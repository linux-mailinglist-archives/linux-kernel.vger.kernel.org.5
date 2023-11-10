Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CA87E818E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346037AbjKJS34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346603AbjKJS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:27:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD272BE09
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:19:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7238FC433C7;
        Fri, 10 Nov 2023 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699607946;
        bh=b9jyp9d6eUs12groes8KvuLudG/6cY80nzVdpBVlpl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/15eAPSmNar0fmxrbidbkveb69ykFpmetwPD7Yza1TswwTh+IpgJSSIMHqzZNP9R
         y5zAQ2Xgo4NVYjaMLLxRV+fKgppRoxikGpT8QuJVGwVFHJaX6m1BDUiFI53AkD7Dbz
         DyACF7jrbVQmI5Jnpy08C5eX54ntRlki7xM+T2Y0m2YS4H/Xz3fMr2EJwl3mwn7UDv
         sjZg3ZAHHD5t+GMii5Cj+4M6636v+g9yQBPCcq/Vf3X1RyLQ1J7vLUK5eyGvqYYDyQ
         dEgZLzY2ud9Jql0Gk5YRq3ySoVaFUhITcouW50caJp5GhCovdhVD99hjRRxMa7yL65
         BLTtCnLJ6qZJg==
Received: from johan by theta with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r1NfH-0002iZ-2T;
        Fri, 10 Nov 2023 10:18:59 +0100
Date:   Fri, 10 Nov 2023 10:18:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Message-ID: <ZU31gx-LY5GBJGPU@hovoldconsulting.com>
References: <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
 <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <2b19b5e2-5eb0-49e0-8c47-8aff3d48f34e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b19b5e2-5eb0-49e0-8c47-8aff3d48f34e@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 10:08:12PM +0530, Krishna Kurapati PSSNV wrote:
> On 11/9/2023 8:48 PM, Johan Hovold wrote:
> > On Fri, Nov 03, 2023 at 03:34:52PM +0530, Krishna Kurapati PSSNV wrote:
> > > On 10/24/2023 12:26 PM, Johan Hovold wrote:
> > > > On Mon, Oct 23, 2023 at 10:42:31PM +0530, Krishna Kurapati PSSNV wrote:
> > > > > On 10/23/2023 7:37 PM, Johan Hovold wrote:
> > > > 
> > > > > > Right. And I assume there are hs_phy_irqs also for the first two USB
> > > > > > controllers on sc8280xp?
> > > > 
> > > > > There are, I can dig through and find out. Atleast in downstream I don't
> > > > > see any use of them.
> > > > 
> > > > Yes, please do post how these are wired as well for completeness.
> > 
> > Did you find these two interrupts as well?

Please answer.

> > > As an experiment, I tried to test wakeup by pressing buttons on
> > > connected keyboard when in suspend state or connecting/disconnecting
> > > keyboard in suspended state on different ports and only see dp/dm IRQ's
> > > getting fired although we register for hs_phy_irq as well:
> > > 
> > > / # cat /proc/interrupts  |grep phy_
> > > 171:   1  0   0   0  0  0  0  0       PDC 127 Edge      dp_hs_phy_1
> > > 172:   2  0   0   0  0  0  0  0       PDC 126 Edge      dm_hs_phy_1
> > > 173:   3  0   0   0  0  0  0  0       PDC 129 Edge      dp_hs_phy_2
> > > 174:   4  0   0   0  0  0  0  0       PDC 128 Edge      dm_hs_phy_2
> > > 175:   0  0   0   0  0  0  0  0       PDC 131 Edge      dp_hs_phy_3
> > > 176:   2  0   0   0  0  0  0  0       PDC 130 Edge      dm_hs_phy_3
> > > 177:   2  0   0   0  0  0  0  0       PDC 133 Edge      dp_hs_phy_4
> > > 178:   5  0   0   0  0  0  0  0       PDC 132 Edge      dm_hs_phy_4
> > > 179:   0  0   0   0  0  0  0  0       PDC  16 Level     ss_phy_1
> > > 180:   0  0   0   0  0  0  0  0       PDC  17 Level     ss_phy_2
> > > 181:   0  0   0   0  0  0  0  0     GICv3 163 Level     hs_phy_1
> > > 182:   0  0   0   0  0  0  0  0     GICv3 168 Level     hs_phy_2
> > > 183:   0  0   0   0  0  0  0  0     GICv3 892 Level     hs_phy_3
> > > 184:   0  0   0   0  0  0  0  0     GICv3 891 Level     hs_phy_4
> > 
> > Yes, but that doesn't really say much since you never enable the hs_phy
> > interrupt in the PHY on suspend.
> 
> I did register to and enabled the hs_phy_irq interrupt when I tested and
> posted the above table.

Yes, but, again, you never enabled them in the PHY (cf. QUSB2) so it's
hardly surprising that they do not fire.

Still good to know that requesting them doesn't trigger spurious
interrupts either since these are apparently enabled on most Qualcomm
SoCs even though they are not used. We should fix that too.

> > > Since the hs_phy_irq is applicable only for qusb2 targets, do we still
> > > need to add it to DT.
> > 
> > Are you sure there's no support for hs_phy_irq also in the "femto" PHYs
> > and that it's just that there is currently no driver support for using
> > them?
> > 
> > And why is it defined if there is truly no use for it?
> 
> Femto phy's have nothing to be configured for interrupts like we do for
> qusb2 phy's. I confirmed from hw validation team that they never used
> hs_phy_irq for validating wakeup. They only used dp/dm IRQ's for wakeup.

Ok.

Is there some other (non-wakeup) functionality which may potentially use
this interrupt?

> > Also, if hs_phy_irq and dp/dm_phy_irq were mutually exclusive, why does
> > the following Qualcomm SoCs define all three?
> > 
> 
> Similar to BAM IRQ's these might have been just ported over targets I
> believe. I say so because HW Validation team confirmed they don't use this
> interrupt at all on femto phy targets.

So then including the hs_phy_irq for most of these SoCs was a mistake
and we should drop it from the bindings?

What about the QUSB2 SoCs that also define DP/DM, are both useable
there?

And if so, is there any reason to prefer one mechanism over the other?

> >                - qcom,ipq4019-dwc3
> >                - qcom,ipq6018-dwc3
> >                - qcom,ipq8064-dwc3
> >                - qcom,ipq8074-dwc3
> >                - qcom,msm8994-dwc3
> >                - qcom,qcs404-dwc3
> >                - qcom,sc7180-dwc3
> > 	      - qcom,sc7280-dwc3
> >                - qcom,sdm670-dwc3
> >                - qcom,sdm845-dwc3
> >                - qcom,sdx55-dwc3
> >                - qcom,sdx65-dwc3
> >                - qcom,sm4250-dwc3
> >                - qcom,sm6125-dwc3
> >                - qcom,sm6350-dwc3
> >                - qcom,sm8150-dwc3
> >                - qcom,sm8250-dwc3
> >                - qcom,sm8350-dwc3
> >                - qcom,sm8450-dwc3
> >                - qcom,sm8550-dwc3
> > 
> > Some of those use QUSB2 PHYs and some use "femto" PHYs.

> > > Since the DeviceTree passed to the OS, should describe the hardware to
> > > the OS, and should represent the hardware from the point-of-view of the
> > > OS, adding one interrupt (ctrl_irq[0]) might be sufficient as Linux
> > > would not use the other interrupts.
> > 
> > I've only skimmed the virtualisation bits in xHCI spec, but it seems
> > Linux as VMM would still be involved in assigning these interrupts to
> > VMs.
> 
> I didn't understand this sentence. Are you referring to cases where Linux
> needs to act as the entity using the ctrl_irq[1] ?

It seems Linux acting as VMM would need to be involved in configuring
such interrupts and passing them to the VM that eventually use them.

> On QCOM SoC's, in reality (atleast in device mode) I can say that we create
> the event rings for IPA FW (which registers for ctrl_irq[1]) to use and read
> depevt's. We don't register or get this IRQ from DT and then provide to IPA
> (not even in downstream).

Yeah, I don't know how such things would best be handled.

Johan
