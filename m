Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952BD7590A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGSIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGSIug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38010E;
        Wed, 19 Jul 2023 01:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A078E60DC7;
        Wed, 19 Jul 2023 08:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1B5C433C7;
        Wed, 19 Jul 2023 08:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689756634;
        bh=QaOVdoicLSy5dKvSVcxnCf2FIR9+Gbw+hyfNJZaBNxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOCiS+mAhkBUIAtb0ZxxOSM4mSLoUcdDjifVlftwc1NrvcfomBFsJspfrW2zoRfrm
         +zX+3YqCNk7WgX9L24AO13e23ygzMGGkVH9XdxB5rHqylkep1kNiAymb0nCDTWfkyu
         w/R9JcLRgM+pfjU4VRVaL3rAGERGV1y+YEFPoyYTstgf1qJ1T6mYLhoW14bU8ean7e
         CAo8awK1ee+UTb/TdJZmUWDuh+nbQyQXWn2mc5VbnQVYBG/HyH/fSjYkBXkfb68qlA
         LDxMsjH+XFvxqLyL+Dhey+XEBl85lPv8anpYjemdmKiWNGO5/Ze2Q3+9aJngGwQXXj
         J9uvFc1DwVmmQ==
Date:   Wed, 19 Jul 2023 09:50:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Dylan Van Assche <me@dylanvanassche.be>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Tom Rix <trix@redhat.com>, linux-leds@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com
Subject: Re: [PATCH v1] led: flash: various minor fixes for leds-qcom-flash
 driver
Message-ID: <20230719085029.GI1082701@google.com>
References: <20230718092439.2482320-1-quic_fenglinw@quicinc.com>
 <d246292b-c0df-fa70-7561-9523e4db6138@linaro.org>
 <e420f2c9-4c29-e2c4-4312-291b05c97224@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e420f2c9-4c29-e2c4-4312-291b05c97224@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023, Fenglin Wu wrote:

> 
> 
> On 7/18/2023 5:32 PM, Krzysztof Kozlowski wrote:
> > On 18/07/2023 11:24, Fenglin Wu wrote:
> > > Update the driver to address following minor issues:
> > >   - Add a sentence in Kconfig to explain the driver can be compiled
> > >     as a module
> > >   - strobe off the LED channel before setting flash current to prevent
> > >     the flash LED being lit with an incorrect brightness if it was
> > >     already active in torch mode
> > >   - put the child node if register any flash LED device failed.
> > 
> > Don't mix different fixes and changes in one commit.
> > 
> > Also, please use scripts/get_maintainers.pl to get a list of necessary
> > people and lists to CC (and consider --no-git-fallback argument). I
> > really do not see a point why I am cc-ed here.
> > 
> > Best regards,
> > Krzysztof
> 
> I understood that we should separate the changes for different fixes.
> 
> I am trying to address the review comment from Pavel that was coming late
> after the original changes were applied:
> https://lore.kernel.org/linux-arm-msm/20230325170957.GA2904@bug/ (sorry for
> just got time to work on this), since all of them are small ones and all
> related with the same driver, so I thought it might be good to put them
> together and update with a single patch?

Separate patches - one per functional change please.

-- 
Lee Jones [李琼斯]
