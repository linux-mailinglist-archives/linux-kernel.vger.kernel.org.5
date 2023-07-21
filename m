Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4175375C08D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGUH4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGUH4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D529270A;
        Fri, 21 Jul 2023 00:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FCF36137B;
        Fri, 21 Jul 2023 07:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB402C433C7;
        Fri, 21 Jul 2023 07:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689926188;
        bh=5CIitjjI5khTPF7RHT+gTh25uD/FQODAUJsQwUhQD5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svt1h8bTI05Eh8uMp29Ukd0mWqQ2hOFonGmcNeA9eCKIIKGkIgWhr43D7ndQR/ZBx
         0agLf0SrMxcb1VUcZHyIXudI5yx2JNIIKF8DQm8n98Ja2/mUo2/pptnDYyEoOw0XxA
         Z2RLAQfBrjyxK4xDB5Gw0mREQc9dMymipb0kvO/jxH7vUCe0tj7V0wmBPAlNqUQN9b
         SCQ2oSLk/tzUYeb+XZ9pkIPIYNwvzZDe9IrHaFSjmqloE1FiK3YdMPm8WT3DpQQERa
         IsRVi3jlAzbNEsncO2gNQz+e1HBEXQ+ejz6DYCkAjyj939dwI0uKHIIh1Amk8P3pm8
         MRAEkH7AdawUg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMl07-0003Iw-1s;
        Fri, 21 Jul 2023 09:56:36 +0200
Date:   Fri, 21 Jul 2023 09:56:35 +0200
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
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 05/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZLo6MwbuKNL5xtPE@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-6-quic_kriskura@quicinc.com>
 <ZJrRe7HtMs0KbsCy@hovoldconsulting.com>
 <e3e0c4c8-1e91-caf1-c1c4-86203a7ecba0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3e0c4c8-1e91-caf1-c1c4-86203a7ecba0@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:26:26AM +0530, Krishna Kurapati PSSNV wrote:
> On 6/27/2023 5:39 PM, Johan Hovold wrote:
> > On Wed, Jun 21, 2023 at 10:06:23AM +0530, Krishna Kurapati wrote:
> >> Currently the DWC3 driver supports only single port controller
> >> which requires at most one HS and one SS PHY.
> >>
> >> But the DWC3 USB controller can be connected to multiple ports and
> >> each port can have their own PHYs. Each port of the multiport
> >> controller can either be HS+SS capable or HS only capable
> >> Proper quantification of them is required to modify GUSB2PHYCFG
> >> and GUSB3PIPECTL registers appropriately.
> >>
> >> Add support for detecting, obtaining and configuring phy's supported
> >> by a multiport controller and limit the max number of ports
> >> supported to 4.
> >>
> >> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> >> [Krishna: Modifed logic for generic phy and rebased the patch]
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > 
> > As I already said:
> > 
> > 	If Harsh is the primary author you need to add a From: line at
> > 	the beginning of the patch.
> > 
> > 	Either way, you need his SoB as well as your Co-developed-by tag.
> > 
> > 	All this is documented under Documentation/process/ somewhere.
> > 
> > The above is missing a From line and two Co-developed-by tags at least.

>   I tried to follow the following commit:
> 
> 8030cb9a5568 ("soc: qcom: aoss: remove spurious IRQF_ONESHOT flags")
> 
> Let me know if that is not acceptable.

I don't see how that commit relevant to the discussion at hand.

Please just fix your use of Signed-off-by and Co-developed-by tags that
I've now pointed out repeatedly.

If you can't figure it out by yourself after the feedback I've already
given you need to ask someone inside Qualcomm. You work for a huge
company that should provide resources for training it's developers in
basic process issues like this.

> >> @@ -120,10 +120,11 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
> >>   static void __dwc3_set_mode(struct work_struct *work)
> >>   {
> >>   	struct dwc3 *dwc = work_to_dwc(work);
> >> +	u32 desired_dr_role;
> >>   	unsigned long flags;
> >>   	int ret;
> >>   	u32 reg;
> >> -	u32 desired_dr_role;
> > 
> > This is an unrelated change. Just add int i at the end.
> > 
> I was trying to keep the reverse xmas order of variables.

That's generally good, but you should not change unrelated code as part
of this patch. It's fine to leave this as is for now.

> >> +	int i;
> >>   
> >>   	mutex_lock(&dwc->mutex);
> >>   	spin_lock_irqsave(&dwc->lock, flags);
> > 
> >> @@ -746,23 +779,34 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
> >>   static int dwc3_phy_init(struct dwc3 *dwc)
> >>   {
> >>   	int ret;
> >> +	int i;
> >> +	int j;
> >>   
> >>   	usb_phy_init(dwc->usb2_phy);
> >>   	usb_phy_init(dwc->usb3_phy);
> >>   
> >> -	ret = phy_init(dwc->usb2_generic_phy);
> >> -	if (ret < 0)
> >> -		goto err_shutdown_usb3_phy;
> >> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> >> +		ret = phy_init(dwc->usb2_generic_phy[i]);
> >> +		if (ret < 0)
> >> +			goto err_exit_usb2_phy;
> >> +	}
> >>   
> >> -	ret = phy_init(dwc->usb3_generic_phy);
> >> -	if (ret < 0)
> >> -		goto err_exit_usb2_phy;
> >> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> >> +		ret = phy_init(dwc->usb3_generic_phy[i]);
> >> +		if (ret < 0)
> >> +			goto err_exit_usb3_phy;
> >> +	}
> >>   
> >>   	return 0;
> >>   
> >> +err_exit_usb3_phy:
> >> +	for (j = i-1; j >= 0; j--)
> > 
> > Missing spaces around - here and below.
> > 
> >> +		phy_exit(dwc->usb3_generic_phy[j]);
> >> +	i = dwc->num_usb2_ports;
> >>   err_exit_usb2_phy:
> >> -	phy_exit(dwc->usb2_generic_phy);
> >> -err_shutdown_usb3_phy:
> >> +	for (j = i-1; j >= 0; j--)
> >> +		phy_exit(dwc->usb2_generic_phy[j]);
> >> +
> > 
> > Again:
> > 
> > 	The above is probably better implemented as a *single* loop over
> > 	num_usb2_ports where you enable each USB2 and USB3 PHY. On
> > 	errors you use the loop index to disable the already enabled
> > 	PHYs in reverse order below (after disabling the USB2 PHY if
> > 	USB3 phy init fails).
> > 
> > with emphasis on "single" added.
> > 
> Oh, you mean something like this ?
> 
> for (loop over num_ports) {
> 	ret = phy_init(dwc->usb3_generic_phy[i]);
> 	if (ret != 0)
> 		goto err_exit_phy;
> 
> 	ret = phy_init(dwc->usb2_generic_phy[i]);
> 	if (ret != 0)
> 		goto err_exit_phy;
> }
> 
> err_exit_phy:
> 	for (j = i-1; j >= 0; j--) {
> 		phy_exit(dwc->usb3_generic_phy[j]);
> 		phy_exit(dwc->usb2_generic_phy[j]);
> 	}

Yeah, something like that, but you need to disable the usb3[i] phy when
usb2[2] init fail above (and I'd also keep the order of initialising
usb2 before usb3).

> >>   	usb_phy_shutdown(dwc->usb3_phy);
> >>   	usb_phy_shutdown(dwc->usb2_phy);

> >> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> >> index 42fb17aa66fa..b2bab23ca22b 100644
> >> --- a/drivers/usb/dwc3/core.h
> >> +++ b/drivers/usb/dwc3/core.h
> >> @@ -37,6 +37,9 @@
> >>   #define XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
> >>   #define XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
> >>   
> >> +/* Number of ports supported by a multiport controller */
> >> +#define DWC3_MAX_PORTS 4
> > 
> > You did not answer my question about whether this was an arbitrary
> > implementation limit (i.e. just reflecting the only currently supported
> > multiport controller)?
> > 
> I mentioned in commit text that it is limited to 4. Are you referring to 
> state the reason why I chose the value 4 ?

Yes, and to clarify whether this was an arbitrary limit you chose
because it was all that was needed for the hw you care about, or if it's
a more general limitation.

Johan
