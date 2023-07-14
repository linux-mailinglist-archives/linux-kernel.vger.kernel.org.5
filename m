Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7450075360C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjGNJGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjGNJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D330E9;
        Fri, 14 Jul 2023 02:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 301E961CBD;
        Fri, 14 Jul 2023 09:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849BBC433C7;
        Fri, 14 Jul 2023 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689325543;
        bh=WvoBK4BO8pPPux6zd3qw6bxteYzOyTTKLiAplHoONqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYQOx+Bf0l+WC841uAxl+EmnmXnIWq6H+9fTX5BHU8AjkSu6g7L7b+35oANMDJ728
         nF07kgeXFpmztoS8zKDGp2Mz27GCeCt7JKD3hff8XA2o0mBZk4Nge8EXeaoSA0qqDd
         qNhuCMiEmA07Rm3MnKJy4sU6OriXo4GOhrwjDy9Ec9Pc5KjCTBevCk0VOxFNM3CYsD
         ptVnuN5pjFgKZDeLU1O5hmNDvs7hmiq9gVknilZkJs2L9wKbYIskaGlSsxtuIOsPB1
         F2Cf3t/QymtdnWVbbWqiqcXn3WoABZ99gxrxT+xscG187m1AvLnsv/Pm4NX2dphzmo
         xUI0zL6JveEkw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qKEkC-0006bZ-0a;
        Fri, 14 Jul 2023 11:05:44 +0200
Date:   Fri, 14 Jul 2023 11:05:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
Message-ID: <ZLEP6Ekh3unSTiCL@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZK6YrLMn9r39zEeB@hovoldconsulting.com>
 <ef29e520-7b9c-f581-e70a-250df80d3821@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef29e520-7b9c-f581-e70a-250df80d3821@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:56:33PM +0530, Krishna Kurapati PSSNV wrote:
> On 7/12/2023 5:42 PM, Johan Hovold wrote:
> > On Wed, Jun 21, 2023 at 10:06:24AM +0530, Krishna Kurapati wrote:
> >> Add support to read Multiport IRQ's related to quad port controller
> >> of SA8295 Device.
> >>
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> >> ---
> >>   drivers/usb/dwc3/dwc3-qcom.c | 108 +++++++++++++++++++++++++++++------
> >>   1 file changed, 91 insertions(+), 17 deletions(-)
> > 
> >> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
> >> +{
> >> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> >> +	char irq_name[15];
> > 
> > The interrupt device-name string can not be allocated on the stack or
> > reused as it is stored directly in each irqaction structure.
> > 
> > This can otherwise lead to random crashes when accessing
> > /proc/interrupts:
> > 
> > 	https://lore.kernel.org/lkml/ZK6IV_jJPICX5r53@hovoldconsulting.com/

>    Sure, will create a static array of names if possible in global 
> section of file and use it to read interrupts.

Or just use devm_kasprintf(), which should allow for a cleaner
implementation.

I've fixed it up like this for my X13s wip branches:

	https://github.com/jhovold/linux/commit/0898b54456bc2f4bd4d420480db98e6758771ace
 
>    Are you fine with seperating out setup_irq and setup_mp_irq functions 
> ? Can you please review comments and suggestion on [1].

I haven't had time to look at your latest replies yet, but as I already
said when reviewing v9, it seems you should be using a common helper for
non-mp and mp.

Johan
