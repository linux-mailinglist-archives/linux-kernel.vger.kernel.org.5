Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA04175C10C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjGUIO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjGUIOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFFA2727;
        Fri, 21 Jul 2023 01:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB71261705;
        Fri, 21 Jul 2023 08:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3075C433C8;
        Fri, 21 Jul 2023 08:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689927284;
        bh=sFlXHCb5ZvFuWm824StAJi7e5LrCinNBnp51yxoySZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGu8eB//nerrPvPDj1hCcc/PlC1GnAMZ+XCd5Pt9DcL5FtLuhrKtJSAxpqJKlapFL
         XlmzIX/SPU7ndFE1/f2YLm3lC9WhO+BXfUej+oQEo8h9s5IIMJ4DUNSCjdiQhos59Y
         SkOUNHcsP2HLqangqDzBuUgSvZQbMA3Vql8hRWo6wkZjGraxbkvcyA9AYZu+anE9+p
         qltWp6GBEWZF3wXVJQf5bPWM3OZ471Js05ABe4vKTiqXPqJkR6yfexQrsOQi/lNUDC
         zLervuL4tXGVwCd6MNDJYB8Vriyg8wS3dfaUAb0g6Yi0GniYPjUIFoJGN5v1WKh3iV
         0EOqvnwbKwIuw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMlHp-0003Ms-1Q;
        Fri, 21 Jul 2023 10:14:53 +0200
Date:   Fri, 21 Jul 2023 10:14:53 +0200
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
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
Message-ID: <ZLo-feuIr2FzCoxa@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZJryrhuUrL5APh4o@hovoldconsulting.com>
 <7e32cf95-1565-5736-cc3e-c70e8d8f3ca7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e32cf95-1565-5736-cc3e-c70e8d8f3ca7@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:29:41AM +0530, Krishna Kurapati PSSNV wrote:
> On 6/27/2023 8:01 PM, Johan Hovold wrote:
> > On Wed, Jun 21, 2023 at 10:06:24AM +0530, Krishna Kurapati wrote:
  
> >> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
> >> +{
> >> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> >> +	char irq_name[15];
> >> +	int irq;
> >> +	int ret;
> >> +	int i;
> >> +
> >> +	for (i = 0; i < 4; i++) {
> > 
> > DWC3_MAX_PORTS here too and similar below.
> > 
> >> +		if (qcom->dp_hs_phy_irq[i])
> >> +			continue;
> > 
> > This is not very nice. You should try to integrate the current lookup
> > code as I told you to do with the PHY lookups. That is, use a single
> > loop for all HS/SS IRQs, and pick the legacy name if the number of ports
> > is 1.
> > 
> > Of course, you added the xhci capability parsing to the core driver so
> > that information is not yet available, but you need it in the glue
> > driver also...
> > 
> > As I mentioned earlier, you can infer the number of ports from the
> > interrupt names. Alternatively, you can infer it from the compatible
> > string. In any case, you should not need to ways to determine the same
> > information in the glue driver, then in the core part, and then yet
> > again in the xhci driver...

>   The reason why I didn't integrate this with the original function was 
> the ACPI stuff. The MP devices have no ACPI variant. And I think for 
> clarity sake its best to keep these two functions separated.

No. The ACPI stuff may make this a little harder to implement, but
that's not a sufficient reason to not try to refactor things properly.

> >> +
> >> +		sprintf(irq_name, "dp%d_hs_phy_irq", i+1);
> > 
> > Spaces around binary operators. Does not checkpatch warn about that?
> > 
> >> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
> >> +		if (irq > 0) {
> >> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
> >> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> >> +					qcom_dwc3_resume_irq,
> >> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> >> +					irq_name, qcom);
> >> +			if (ret) {
> >> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
> >> +				return ret;
> >> +			}
> >> +		}
> >> +
> >> +		qcom->dp_hs_phy_irq[i] = irq;
> >> +	}
> >> +
> >> +	for (i = 0; i < 4; i++) {
> >> +		if (qcom->dm_hs_phy_irq[i])
> >> +			continue;
> >> +
> >> +		sprintf(irq_name, "dm%d_hs_phy_irq", i+1);
> >> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
> >> +		if (irq > 0) {
> >> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
> >> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> >> +					qcom_dwc3_resume_irq,
> >> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> >> +					irq_name, qcom);
> >> +			if (ret) {
> >> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
> >> +				return ret;
> >> +			}
> >> +		}
> >> +
> >> +		qcom->dm_hs_phy_irq[i] = irq;
> >> +	}
> >> +
> >> +	for (i = 0; i < 2; i++) {
> >> +		if (qcom->ss_phy_irq[i])
> >> +			continue;
> >> +
> >> +		sprintf(irq_name, "ss%d_phy_irq", i+1);
> >> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
> >> +		if (irq > 0) {
> >> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
> >> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> >> +					qcom_dwc3_resume_irq,
> >> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> >> +					irq_name, qcom);
> >> +			if (ret) {
> >> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
> >> +				return ret;
> >> +			}
> >> +		}
> >> +
> >> +		qcom->ss_phy_irq[i] = irq;
> >> +	}
> > 
> > So the above should all be merged in either a single helper looking up
> > all the interrupts for a port and resused for the non-MP case.
> > 
> I agree, Will merge all under some common helper function.

Good.

Johan
