Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1E77D38F0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjJWOHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjJWOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:07:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B31C10A;
        Mon, 23 Oct 2023 07:07:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE822C433C8;
        Mon, 23 Oct 2023 14:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698070019;
        bh=EFCcj+kM49q/Fckkag31hERshVse68raKNrkQaF+5ZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jY23vsQ5maPtg3WiklVBO5WrDgi3oiBq+nleb+bSxDOdxu7etyw40395PmLKcUXJQ
         /C7QPkQN4FBPAFmoYwMLym5TGfyvKZZwu5LQOo3KRKpjcCBOOZArTSNmTalM2O7WwI
         ROE7GQonuqIAHKpVD56N824eore4Y6NhWoAW3cJT+gftflAEmDrz7msTH+/ssAue12
         hPVWxzoMdQmz+a/GdAbTnc+Z+fE6EyT1IUPJ3fMb80qkkB+yutnkPvmOsffjkuTPO+
         9rDAlCNGA46AHMd7hX4HXzzbhb7Fz+0Hdzqxy2V6vEDiZoHVIHjMPlXGT07nbteHqq
         qvLx+Cm4LPi8Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1quvaM-0000YI-0b;
        Mon, 23 Oct 2023 16:07:14 +0200
Date:   Mon, 23 Oct 2023 16:07:14 +0200
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
Message-ID: <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-6-quic_kriskura@quicinc.com>
 <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
 <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 04:54:11PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/23/2023 2:51 PM, Johan Hovold wrote:
> > On Mon, Oct 23, 2023 at 12:11:45AM +0530, Krishna Kurapati PSSNV wrote:
> >> On 10/20/2023 6:53 PM, Johan Hovold wrote:

> >>> I also don't like the special handling of hs_phy_irq; if this is really
> >>> just another name for the pwr_event_irq then this should be cleaned up
> >>> before making the code more complicated than it needs to be.
> >>>
> >>> Make sure to clarify this before posting a new revision.
> >>
> >> hs_phy_irq is different from pwr_event_irq.
> > 
> > How is it different and how are they used?
> > 
> >> AFAIK, there is only one of this per controller.
> > 
> > But previous controllers were all single port so this interrupt is
> > likely also per-port, even if your comment below seems to suggest even
> > SC8280XP has one, which is unexpected (and not described in the updated
> > binding):
> > 
> > 	Yes, all targets have the same IRQ's. Just that MP one's have
> > 	multiple IRQ's of each type. But hs-phy_irq is only one in
> > 	SC8280 as well.
> > 
> > 	https://lore.kernel.org/lkml/70b2495f-1305-05b1-2039-9573d171fe24@quicinc.com/
> > 
> > Please clarify.
> > 
> 
> For sure pwr_event_irq and hs_phy_irq are different. I assumed it was 
> per-controller and not per-phy because I took reference from software 
> code we have on downstream and hs_phy for multiport is not used 
> anywhere. I don't see any functionality implemented in downstream for 
> that IRQ. And it is only one for single port controllers.
>
> But I got the following info from HW page and these are all the 
> interrupts (on apss processor) for multiport (extra details removed):
> 
> u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_0	SYS_apcsQgicSPI[130]
> u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_1	SYS_apcsQgicSPI[135]
> u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_3	SYS_apcsQgicSPI[856]
> u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_2	SYS_apcsQgicSPI[857]
> 
> u_usb31_scnd_mvs_pipe_wrapper_usb31_ctrl_irq[0]	SYS_apcsQgicSPI[133]
> u_usb31_scnd_mvs_pipe_wrapper_usb31_ctrl_irq[1]	SYS_apcsQgicSPI[134]

This second core interrupt is also missing in the updated binding... It
is defined in the ACPI tables so presumably it is needed for the
multiport controller.

Do you have any more details on this one?

> u_cm_usb3_uni_wrapper_mp0_usb3phy_debug_irq	SYS_apcsQgicSPI[668]
> u_usb31_scnd_mvs_pipe_wrapper_usb31_bam_irq[0]	SYS_apcsQgicSPI[830]
> u_cm_usb3_uni_wrapper_mp1_usb3phy_debug_irq	SYS_apcsQgicSPI[855]
> 
> u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_0	SYS_apcsQgicSPI[131]
> u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_1	SYS_apcsQgicSPI[136]
> u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_3	SYS_apcsQgicSPI[859]
> u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_2	SYS_apcsQgicSPI[860]

Ok, so at least we know hs_phy_irq and pwr_event_irq are distinct and
both per-port.

The ACPI tables do not seem to include these, but yeah, that doesn't say
much more than that the Windows implementation doesn't currently use
them either.

> u_cm_dwc_usb2_hs0_usb2_dpse	apps_pdc_irq_out[127]
> u_cm_dwc_usb2_hs0_usb2_dmse	apps_pdc_irq_out[126]
> u_cm_dwc_usb2_hs1_usb2_dpse	apps_pdc_irq_out[129]
> u_cm_dwc_usb2_hs1_usb2_dmse	apps_pdc_irq_out[128]
> u_cm_dwc_usb2_hs2_usb2_dpse	apps_pdc_irq_out[131]
> u_cm_dwc_usb2_hs2_usb2_dmse	apps_pdc_irq_out[130]
> u_cm_dwc_usb2_hs3_usb2_dpse	apps_pdc_irq_out[133]
> u_cm_dwc_usb2_hs3_usb2_dmse	apps_pdc_irq_out[132]
> u_cm_usb3_uni_wrapper_mp0_qmp_usb3_lfps_rxterm_irq	apps_pdc_irq_out[16]
> u_cm_usb3_uni_wrapper_mp1_qmp_usb3_lfps_rxterm_irq	apps_pdc_irq_out[17]
> 
> Seems like there are 4 IRQ's for HS.

Right. And I assume there are hs_phy_irqs also for the first two USB
controllers on sc8280xp?

Can you find out anything more about what hs_phy_irq is used for? It
appears to be an HS wakeup interrupt like the dp/dm ones, but there are
not really any details on how it is supposed to be used.

Johan
