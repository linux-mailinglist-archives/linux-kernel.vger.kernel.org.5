Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0A7D4B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjJXJGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjJXJGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:06:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50275C2;
        Tue, 24 Oct 2023 02:06:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E790FC433C8;
        Tue, 24 Oct 2023 09:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698138380;
        bh=tw6phL3njg7Zk6Ua/WCHEM58n0W8/AyOMzwRfIKowRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ih3HhdbX31Wkgy27F6HRxpE3Vm4JjuchCIypVYEbrbnA8YRbLzAiB7A2fiBP2wdrK
         1S/zRb2vbKl1dnGwit5YKRJrR2u6yRSGQ5nibOzEf4mBGmmmPc5O/Q486wt99rp4JD
         QjQCRo2/+c/UOk68hLfeaZUKbK+itH++tMsYLU+0kVQk3SXOzELtqpT5w1tZcGpptj
         /MzFG1suRqBg6R7rCuklotyiTOhFW4oAqiMo0pA+OUtzhrl8T31ygyAoKVYbYInHEd
         LlPlXdiR+MAvv9bi+bNAhdxjnm2qsKjz0ZysBXhCU5Lm23HR1vBoBWFANDYaE9AV6v
         y/lB3Nd41rjTg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvDMy-0003zs-1N;
        Tue, 24 Oct 2023 11:06:36 +0200
Date:   Tue, 24 Oct 2023 11:06:36 +0200
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
Subject: Re: [PATCH v13 06/10] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Message-ID: <ZTeJHMJYMQWVIbI7@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-7-quic_kriskura@quicinc.com>
 <ZTaViatsRY7LCbIX@hovoldconsulting.com>
 <7e9bdd65-35b7-43c2-810a-2cd81f736084@quicinc.com>
 <ZTdt-wyCHh3i0SlK@hovoldconsulting.com>
 <00044364-9a6a-4138-9c17-7b0b801e9f10@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00044364-9a6a-4138-9c17-7b0b801e9f10@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 02:11:31PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/24/2023 12:40 PM, Johan Hovold wrote:
 
> >>> But perhaps this should be done using usb_hub_for_each_child() instead
> >>> as that may be more efficient. Then you use this function to read out
> >>> the speed for all the ports in go (and store it in the port structures I
> >>> mentioned). Please determine which alternative is best.
> >>>
> >> Either ways is fine. We would have qcom->num_ports to determine how many
> >> speeds we can read.
> > 
> > That's not the point. I'm referring to which alternative is less
> > computationally expensive and allows for a clean implementation.
> > 
> > Please do try to figure it out yourself.
> > 
> I don't think its much of a difference:
> 
> while (loop over num_ports) {
> 	read_usb2_speed()
> }
> 
> read_usb2_speed() {
> 	while (loop over num_ports) {
> 		hub api to read speed.
> 	}
> }
> 
> The second one would avoid calling read_usb2_speed multiple times. Will 
> take that path.

You need to look at the implementation of usb_hub_for_each_child() and
usb_hub_find_child() to determine that, which you now forced me to
do; and yes, you're right, this shouldn't matter from an efficiency
standpoint.

> >>> [ I realise that the confusion around hs_phy_irq may be partly to blame
> >>> for this but since that one is also a per-port interrupt, that's no
> >>> longer an issue. ]
> >>
> >> I don't want to add support for this right away [1]. I would like to
> >> keep hs_phy_irq outside the loop for now.
> > 
> > No. Stop trying to take shortcuts. Again, this is upstream, not
> > Qualcomm's vendor kernel.
> 
> I don't think it is a shortcut.
> 
> The reason I said I would keep it out of loop is I know why we need 
> DP/DM/SS IRQ's during wakeup. The wakeup signals come in as 
> rising/falling edges in high speed on DP/DM lines and LFPS terminations 
> come on SS lines.

It is a shortcut as this interrupt is per-port and some SoC's already
use it. So you're making a mess of the implementation for no good
reason.

> So we need these 3 interrupts for sure in wakeup context.
> hs_phy_irq is not mandatory for wakeup. Any particular reason why it is 
> needed to add driver support for hs_phy_irq's of multiport now ? May be 
> I am missing something. If there is any reason why we need to add it 
> now, I would try to learn and see if it has any side effects (like 
> generating spurious wakeup's) and if nothing, I would add it back to 
> port structure.

As I've mentioned a few times now, the hs_phy_irq is already used by a
few SoC's so you can't just pretend it doesn't exist and mess up the
implementation for no good reason.

Just find out how it is used and why only some Qualcomm SoC's use it
currently. It appears to be used in parallel with the DP/DM interrupts,
and it has been there from the start:

	a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")

Sure, the wakeup implementation was incomplete and broken for a long
time, but I'm not going to let you continue this practise of pushing
incomplete hacks upstream which someone else will eventually be forced
to clean up. You have the documentation, just use it.

Johan
