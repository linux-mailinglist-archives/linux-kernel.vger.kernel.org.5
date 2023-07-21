Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46EF75C2DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjGUJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGUJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463ED30C2;
        Fri, 21 Jul 2023 02:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C826162C;
        Fri, 21 Jul 2023 09:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADADC433C7;
        Fri, 21 Jul 2023 09:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689931291;
        bh=ITIHgfNish4ScHCGzlluolo3YJdgMQUBDwaI7t7ZYUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smhFFR5Tfz/dvfDwv2AeEEh8VD6iL8AKeBByY2Ds/NLVsQEgtHFOeKPmatv/oXt8F
         ooQKb+yKOHBsg681w9SMykkbRi+n0mjMsjugKt4bLO2b07+MLVRBp9Cf6x/R6C2D2f
         SF8iOXhvJr7QwaXNhoY72DBIhEFps85WehGedtsHX0zicE0EzagmlRxV3ApDmcW//T
         VKCgBbYF0H2E5w3YS2fiPiq7ip4fOSF++9EMU4DAz9CsDyCfja5PjfZ0l3V5ctpA2L
         B2MloIISOABZ2t0X2XigR1bsj5aNlsPF4In7iFypTBzXpyQxwlI2Xp4L51tsI3DRg/
         l2o7l7yIXzb6w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMmKR-0003ZC-1w;
        Fri, 21 Jul 2023 11:21:39 +0200
Date:   Fri, 21 Jul 2023 11:21:39 +0200
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
Message-ID: <ZLpOI9ZAHb_AB_Fr@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZJryrhuUrL5APh4o@hovoldconsulting.com>
 <7e32cf95-1565-5736-cc3e-c70e8d8f3ca7@quicinc.com>
 <ZLo-feuIr2FzCoxa@hovoldconsulting.com>
 <f6f2456d-0067-6cd6-3282-8cae7c47a2d3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f2456d-0067-6cd6-3282-8cae7c47a2d3@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again, please remember to trim your replies.

On Fri, Jul 21, 2023 at 01:49:37PM +0530, Krishna Kurapati PSSNV wrote:
> On 7/21/2023 1:44 PM, Johan Hovold wrote:
> > On Mon, Jul 03, 2023 at 12:29:41AM +0530, Krishna Kurapati PSSNV wrote:
> >> On 6/27/2023 8:01 PM, Johan Hovold wrote:

[...]

> >>> So the above should all be merged in either a single helper looking up
> >>> all the interrupts for a port and resused for the non-MP case.

>   How about the implementation in the attached patches. This way we 
> don't need to know if we are multiport capable or not.

As I wrote above, I think you should instead add a common helper for
setting up all the interrupts for a port. For example, along the lines
of:

	dwc3_setup_port_irq(int index)
	{
		if (index == 0)
			try non-mp name
		else
			generate mp name

		lookup and request hs irqs
		lookup and request ss irq
		lookup and request power irq
	}

	dwc3_setup_irq()
	{
		determine if MP (num_ports)

		for each port
			dwc3_setup_port_irq(port index)
	}

The port irq helper can either be told using a second argument that this
is a non-mp controller, or you can first try looking up one of the
non-mp names.

My mailer discarded your second patch, but you cannot assume that the
devices connected to each port are of the same type (e.g. HS or SS)
based on what is connected to the first port.

Johan
