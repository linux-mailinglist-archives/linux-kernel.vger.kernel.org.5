Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615EF75C5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGULMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjGULMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E72733;
        Fri, 21 Jul 2023 04:11:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05287619B0;
        Fri, 21 Jul 2023 11:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C1DC433C8;
        Fri, 21 Jul 2023 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689937887;
        bh=tFLhoXlT5wsyLB1eQ/FSVutf9zsEsRYZ2/zg1HSvlu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4Xr02icdTMCyyfz1RziBcYB1ccaVMVxxn/LbcB+bRqClk53BmWqByIl36fs9cpJS
         3a81sZscpSPQEqkg7k0AIfE+l6X0z0JTzhMwDIaf/fVXLBmSfhMpVQdm13YUfoJbhp
         EQZdFvDqfdN0TitN9AFNRDxGEEGUhK/MNjOdx9e4sifAggrnDecpkQc7Zh+Ta88C2e
         79wkUtATkpKE88PraaFZXdvF0dzqipIdE9aGyhyYaeCbXOb2n6/txVbtqG2KOievLL
         LZGL4zvtxu5VJ4Olw7jCx9B0/k7IwnWzJdjFV5sHJRHhLwwYM5x9e9h37J3rfrWi7L
         W5INQj1QTR7vg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMo2p-0003p0-0r;
        Fri, 21 Jul 2023 13:11:36 +0200
Date:   Fri, 21 Jul 2023 13:11:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
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
Message-ID: <ZLpn5xEoZRJcNYT1@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZJryrhuUrL5APh4o@hovoldconsulting.com>
 <7e32cf95-1565-5736-cc3e-c70e8d8f3ca7@quicinc.com>
 <ZLo-feuIr2FzCoxa@hovoldconsulting.com>
 <f6f2456d-0067-6cd6-3282-8cae7c47a2d3@quicinc.com>
 <ZLpOI9ZAHb_AB_Fr@hovoldconsulting.com>
 <4b58fdfa-83a4-290b-f7e8-e82feba4586a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b58fdfa-83a4-290b-f7e8-e82feba4586a@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 03:05:36PM +0530, Krishna Kurapati PSSNV wrote:
> On 7/21/2023 2:51 PM, Johan Hovold wrote:

> > As I wrote above, I think you should instead add a common helper for
> > setting up all the interrupts for a port. For example, along the lines
> > of:
> > 
> > 	dwc3_setup_port_irq(int index)
> > 	{
> > 		if (index == 0)
> > 			try non-mp name
> > 		else
> > 			generate mp name
> > 
> > 		lookup and request hs irqs
> > 		lookup and request ss irq
> > 		lookup and request power irq
> > 	}
> > 
> > 	dwc3_setup_irq()
> > 	{
> > 		determine if MP (num_ports)
> > 
> > 		for each port
> > 			dwc3_setup_port_irq(port index)
> > 	}
> > The port irq helper can either be told using a second argument that this
> > is a non-mp controller, or you can first try looking up one of the
> > non-mp names.

> I think I did something similar. I prepared a helper to request IRQ in 
> the patch and the main logic would reside in setup_irq where i would try 
> and get IRQ's.

No, you only added a wrapper around request_irq() but no helper to
setup all irqs for a port, so that's not really similar.

> Irrespective of whether we are MP capable or not, how about we read all 
> IRQ's like in the patch attached previously. And the implementation 
> facilitates addition of ACPI to multiport also if required. I am just 
> trying to cover all cases like this by declaring IRQ info in global section.
> 
> static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, char *irq_name,
>                                 char *disp_name, int irq)
> {
>         int ret;
> 
>         /* Keep wakeup interrupts disabled until suspend */
>         irq_set_status_flags(irq, IRQ_NOAUTOEN);
>         ret = devm_request_threaded_irq(/* Give inouts here*/);
>         if (ret)
>                dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
> 
>         return ret;
> }
> 
> 
> static int dwc3_qcom_setup_irq(struct platform_device *pdev)
> {
>    for (DP_IRQ[ i = 0-3] {
>       try getting dp_irq_i using MP_IRQ strings
>       if ((ret < 0)  and (i == 0))
> 	try getting dp_irq_i using NON_MP_IRQ strings
> 
>       call prep_irq accordingly.
>    }
> 
>    //Run same loop for DM and SS
> }

So again, the above is not setting up all irqs for a port in one place
which seems like the natural way to add support for multiport.

It should be possible to reuse a per-port setup function also for ACPI.
 
> The second patch was just enabling IRQ's for all ports to support wakeup.
> 
> > My mailer discarded your second patch, but you cannot assume that the
> > devices connected to each port are of the same type (e.g. HS or SS)
> > based on what is connected to the first port.
> > 
> Are you referring to enabling IRQ's for different ports before going to 
> suspend ? Meaning get the speed of enum on each port and accordingly 
> enable IRQ's ?

Exactly. That will be needed.

Johan
