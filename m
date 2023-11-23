Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69997F60A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbjKWNo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjKWNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:44:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD460BA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:44:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A349C433C8;
        Thu, 23 Nov 2023 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700747068;
        bh=trYkMaqpWLmDB4oJKoY1+CJr1bJOUKmTS9Un+OPmKFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0iR60nvxcY0qV3BXuSd3E3+kk2rlD00vl2QflXaT3x8kIjB3SH99q8WMPevw7P5E
         bNTm+mpm2pxNjC9xPQbuB3x/IKG4XnGufxHxD0iPOVHnVf1qPad2Bt1F4ESuWukMIH
         zvQ8zPwGph1R53DSx9un/SlNOkzSAXkKp0xh0xk6rUGb65WCyv0z/P0dTdiq7zRwAb
         CTKBQ6oHAsCAFRSnhDdYtR8O5uU9e48wZ4zgyJezTH+vV3idEiozG5qFRTMOHj5wNQ
         G3Uu/R1HLqXLaR9+ZOOtCtOfDY5XW7AyRE0PCrCuk3pXAsCguNnFb4gx19DVMiSclI
         YxGgbMmcx8fpQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r6A0b-0004vo-0K;
        Thu, 23 Nov 2023 14:44:45 +0100
Date:   Thu, 23 Nov 2023 14:44:45 +0100
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
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Message-ID: <ZV9XTU-q038BaWn3@hovoldconsulting.com>
References: <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <6d4d959c-b155-471b-b13d-f6fda557cfe0@quicinc.com>
 <ZVYTFi3Jnnljl48L@hovoldconsulting.com>
 <e0789695-43ee-4285-95e9-4cdee24d6ffe@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0789695-43ee-4285-95e9-4cdee24d6ffe@quicinc.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 01:02:24AM +0530, Krishna Kurapati PSSNV wrote:

>   Pushed [1] to address all the queries and comments. I was initially 
> looking at only Femto phy targets, but when I looked at all targets in 
> general, seems there is one irq not defined in bindings. It is qubs2_phy 
> irq which is named as "hs_phy_irq" on QUSB target DT's (both downstream 
> and upstream).
>
> There is one actual "hs_phy_irq" as well but it is not used either by hs 
> validation team or sw team on any target. It was put in for debug 
> purpose only and doesn't have code to trigger it (even downstream never 
> implemented it I suppose) Atleast 4.4 onwards I saw the code but I 
> didn't see the actual hs_phy_irq being used. It was the qusb2_phy irq 
> named as hs_phy_irq.
> 
> Even hw folks used it under the same name which is why they recommended 
> using it on qusb2 targets and dp/dm on femto targets.

Ah, thanks for getting to the bottom of this.

> On some targets the hs_phy_irq was given vector number of pwr_event irq 
> also like sm8550/sm8450 etc., I tried to address those as well in the 
> series.

I can imagine that we have a number of such issues.

> Also, per your question as to there are some qusb2 targets having dp/dm 
> interrupts defined... It is only for SDM845/SDM670/SM6350 which were 
> last in line of using qusb2 phy's and they started incorporating dp/dm 
> interrupts.

Ok.

> Also added missing interrupts for qcs404/ipq5332.

Thanks.

> I didn't add missing interrupts on sc8280xp because I see that current 
> interrupts present are working fine (I see ADB working and wakeup 
> working as well), but the interrupt vector numbers are off by "1" 
> between hs specifics and DT (both upstream and downstream). Will sort it 
> out and clean that target up later.

Which interrupt numbers are off by one here?
 
> [1]: https://patchwork.kernel.org/project/linux-arm-msm/list/?series=803412

I took a quick look at the series, and it looks like this will
eventually clean things up a lot. We should probably define a generic
order for the interrupts with the sometimes optional SS interrupts last.

Side note: It looks like the threading in that series is broken.
Consider using git-send-email for sending series as it takes care of
things like that.

Johan
