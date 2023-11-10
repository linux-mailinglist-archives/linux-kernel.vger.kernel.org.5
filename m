Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7717E84D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbjKJU5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjKJU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:57:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22112BE3B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:28:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6C1C433C8;
        Fri, 10 Nov 2023 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699608510;
        bh=O71kWkjLpRl34q0yTwylpF7QtQRF306pEE+e5Yis+eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhZlWNO/O/GlcCmSNulebkNqJCBcE5IlpGDHxug+wJ86H+p/patK8+fRBqpzzGjaZ
         d6SvpHoCvd1jfHn0itYAEK/akm7STqjUawTQ2JZfk9hYQA9/TAjtOhrQvPkDcghomr
         5kFVtluMH6FzAcpqfx/Y4STvx2lN3e2HW8zTkrkM3qDQ9bdy3wsJYQp/4mPkUiIE1f
         ZEnVwc6HchoE0JiBE25kzYrFGYEeohmxnnDHR22CC8ILlJX7YmHlR9EQpmT1lwvFq8
         uWB5YOP+FAoBaAb6TZBf0qBFLhas93tda9svqEyCKdBaiU2Nm75GqOfA56DsPeewdc
         jk8hn7oMcLkVA==
Received: from johan by theta with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r1NoP-0002tb-1q;
        Fri, 10 Nov 2023 10:28:25 +0100
Date:   Fri, 10 Nov 2023 10:28:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Message-ID: <ZU33uWpStIobzyd6@hovoldconsulting.com>
References: <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <2b19b5e2-5eb0-49e0-8c47-8aff3d48f34e@quicinc.com>
 <50931ba5-132f-3982-e33a-691583e3a71f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50931ba5-132f-3982-e33a-691583e3a71f@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 12:25:59PM -0800, Wesley Cheng wrote:

> > > > Since the DeviceTree passed to the OS, should describe the hardware to
> > > > the OS, and should represent the hardware from the point-of-view of the
> > > > OS, adding one interrupt (ctrl_irq[0]) might be sufficient as Linux
> > > > would not use the other interrupts.
> > > 
> > > I've only skimmed the virtualisation bits in xHCI spec, but it seems
> > > Linux as VMM would still be involved in assigning these interrupts to
> > > VMs.

> IMO it might be a bit premature to add definitions for how to utilize
> secondary interrupters since design wise, there's nothing really too well
> defined yet.  At least for the XHCI path, we will have a slew of potential
> use cases for secondary interrupters, such as USB audio offloading, or for
> VMMs, etc...  I've only heard mentions about some of them after pushing the
> usb audio offloading series, but I don't have much details on it.

I tend to agree.

> > > This may possibly be something that we can ignore for now, but perhaps
> > > someone more familiar with the hardware, like Thinh, can chime in.

> > > You need to get into the same mindset when it comes to devicetree. Even
> > > if Linux currently does not use an interrupt, like the pwr_event_irq,
> > > you should still add it so that when/if someone implements support for
> > > it, an older platform using the original dt may also take advantage of
> > > it.
> 
> Yeah, I totally agree with this point, but I'm not sure if adding it into
> the "interrupts" array is the way to go.  It would probably have to change
> as support is added.

Yes, that in itself would probably not be sufficient and possibly not
even correct.

> Sorry for jumping in, but just giving my two cents since I'm the one trying
> to do the initial push for the support for secondary interrupters :).

Appreciate your input.

Johan
