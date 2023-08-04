Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D877004A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjHDMeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHDMeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390046A8;
        Fri,  4 Aug 2023 05:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F80461FCA;
        Fri,  4 Aug 2023 12:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F999C433C7;
        Fri,  4 Aug 2023 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691152446;
        bh=yj/B0W9BcspXC2UxB03MQT0G1dUXs8vgKQRG94PPXP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHmB/A1JazuAuqvuw8nd8+A4pg3ietVaLE2vBI0KsIUqZkzCobJXIQeirVwdUlTTD
         qaxvV8YnbuJG2FKIzZOE9kN3ueru18kto95MSLPvuh0edkmhmT9p008B28mv8d6cEL
         N/9P5PF2iGKT3l2Gxux1i5NpOA8A85U8hqB+RmZs=
Date:   Fri, 4 Aug 2023 14:34:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 0/2] usb: typec: qcom-pmic-typec: enable DP support
Message-ID: <2023080455-impeding-deplored-7058@gregkh>
References: <20230728100857.471984-1-dmitry.baryshkov@linaro.org>
 <e4de7d39-978a-0996-1b03-8e7a6712b477@roeck-us.net>
 <CAA8EJproo0yv7Zo6T6fVNfvDVy7JrtMCmixHH73iaWbssehZbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJproo0yv7Zo6T6fVNfvDVy7JrtMCmixHH73iaWbssehZbg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 01:19:36PM +0300, Dmitry Baryshkov wrote:
> On Fri, 28 Jul 2023 at 13:14, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 7/28/23 03:08, Dmitry Baryshkov wrote:
> > > To enable DisplayPort on the platforms supported by qcom-pmic-typec
> > > driver, we need to register a corresponding drm_bridge for this device
> > > to be able to receive the OOB hotplug event sent to the corresponding
> > > DRM connector.
> > >
> > > Reception of the hotplug event is implemented by [1], but there is no
> > > direct dependency on that patchset. This series implements the remaining
> > > parts: registration of the drm_bridge and setting of the proper
> > > destination for the OOB hotplug event.
> > >
> > > [1] https://patchwork.freedesktop.org/series/120393/
> > >
> > > Changes since v2:
> > > - Reworded commit message for the first patch to explicitly mention that
> > >    the "displayport" OF property was rejected (Bjorn)
> > > - Removed several #ifdefs from the qcom-pmic-typec patch (Bryan, Konrad,
> > >    Greg K-H)
> > >
> > > Changes since v1:
> > > - Properly handle CONFIG_DRM dependency. Disallow building DRM as a
> > >    module if qcom-pmic-typec driver is built-in (Bryan).
> >
> >   config TYPEC_QCOM_PMIC
> >         tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
> >         depends on ARCH_QCOM || COMPILE_TEST
> > +       depends on DRM || DRM=n
> >
> > This disallows building TYPEC_QCOM_PMIC into the kernel if DRM is built
> > as module, which is pretty much the opposite of what is claimed above.
> > It does not affect DRM at all.
> >
> > Not that it matters much, but I find it confusing if the change log
> > claims to do the opposite of what the code is doing.
> 
> Ack. If there is a v4 I'll fix the changelog to invert the condition.

Please fix.

thanks,

greg k-h
