Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A675C00E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGUHoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjGUHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:44:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA2811D;
        Fri, 21 Jul 2023 00:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A4F161545;
        Fri, 21 Jul 2023 07:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD808C433C8;
        Fri, 21 Jul 2023 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689925455;
        bh=Er/BapZb3ALRPOmrjE6iHWD/lgnVLLcsK/VqJs60yPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCLyshxSscf0FcD2qfqnOU4ZCp5bAfqiOxoYbib7ddjVIWcaIanoCnij1MWrrDMrD
         6fy38OH2di51feftiqQ1daVr0uVucWuCuZ8XFYmTRs76m8aoDWYRAd6QfAL5ip0PQV
         jd7SeXp86PPDc2OOF9tuJlzCXJVTuFkwFZczU76Dsw1Hb4ATWXEIgDNCo8Ml2KhV3r
         SBb6OX8PSipIvCC7RYiI5eST+PVw2plCZwGb/MYD3VQSVKX7vt1cTmQpy94Hu+MUnY
         TsANyvpA+IAY2Ss63kIGn3Z9C3LzreOqLLGiqOF+OByOiCVENI+B8da2qGAwsD1oAW
         uqDiAZS1yGwCQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMkoJ-0003G1-1a;
        Fri, 21 Jul 2023 09:44:24 +0200
Date:   Fri, 21 Jul 2023 09:44:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 03/10] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZLo3Vym_54IsO-zl@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-4-quic_kriskura@quicinc.com>
 <ZJrL5SXrSiYbvq2o@hovoldconsulting.com>
 <0af6aa13-d83c-8c26-2a60-00cb3bbe4f5e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af6aa13-d83c-8c26-2a60-00cb3bbe4f5e@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

Please remember to trim unnecessary context from your replies (e.g. as
it makes it easier to read your reply and later the entire thread in the
mailing list archives).

On Mon, Jul 03, 2023 at 12:18:14AM +0530, Krishna Kurapati PSSNV wrote:
> On 6/27/2023 5:15 PM, Johan Hovold wrote:
> > On Wed, Jun 21, 2023 at 10:06:21AM +0530, Krishna Kurapati wrote:
  
> >> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> >> index 8b1295e4dcdd..42fb17aa66fa 100644
> >> --- a/drivers/usb/dwc3/core.h
> >> +++ b/drivers/usb/dwc3/core.h
> >> @@ -33,6 +33,10 @@
> >>   
> >>   #include <linux/power_supply.h>
> >>   
> >> +#define XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
> >> +#define XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
> >> +#define XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
> > 
> > Again, don't copy defines from xhci.
> > 
> > Looks like these should be moved to the xhci-ext-caps.h header along
> > with struct xhci_protocol_caps.
> > 
> Can't we just give them an exception ? Modifying xhci stuff doesn't 
> sound good. Can I just rename them and keep them here ?

Nope. This is mainline, not Qualcomm's vendor kernel.

Johan
