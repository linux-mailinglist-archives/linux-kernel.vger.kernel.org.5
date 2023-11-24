Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33477F728C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbjKXLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbjKXLTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:19:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0666D67
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:19:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60889C433C7;
        Fri, 24 Nov 2023 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700824740;
        bh=uv+M2uJcD6nigmAsYgStYTAS4i8Dzh4L8oQ+du2M+04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1kwtZdHvVApDv9ZwK757wpvC8opAjMwEYhUCtu0QD1AA28B2iOvULCtCs35iBLxK
         apNIF3jq+X9ShikKZUo5wDmh69E+fGkD6p7M0azQ50mrxaZjno9+fHPWVdrDfh55F4
         EoytZBi1YzuDbemZQAeqtuGZM16oOsxm3OX01w5ZQoUyE7SSbGXEsvubh4MviR3pdS
         bQoHeEgEmnXX0Fs2EMJTwain5VcYSk8u9CMaQBH+uGh6fdPs+sqSu3zBGoM3QJ+zH1
         ZRYV50EKf55OpnFw873K+WYNBlQlZgfQaTAZvz1hUSfl1HkRC4V9jZPVSQW3IjC3mP
         qT3G34/O/wMvA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r6UDQ-0000cA-0j;
        Fri, 24 Nov 2023 12:19:20 +0100
Date:   Fri, 24 Nov 2023 12:19:20 +0100
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
Message-ID: <ZWCGuDTBMBYHSZSB@hovoldconsulting.com>
References: <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <6d4d959c-b155-471b-b13d-f6fda557cfe0@quicinc.com>
 <ZVYTFi3Jnnljl48L@hovoldconsulting.com>
 <e0789695-43ee-4285-95e9-4cdee24d6ffe@quicinc.com>
 <ZV9XTU-q038BaWn3@hovoldconsulting.com>
 <4fc27dbb-b0aa-437a-a48c-9deea236282d@quicinc.com>
 <ZWB3SWJWXwj0atdH@hovoldconsulting.com>
 <b3919f6a-80ef-4743-b28b-991e93328a19@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3919f6a-80ef-4743-b28b-991e93328a19@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 04:08:42PM +0530, Krishna Kurapati PSSNV wrote:
> On 11/24/2023 3:43 PM, Johan Hovold wrote:

> > I'd suggest that you just send two separate series, one with binding and
> > driver updates, which will eventually be merged by Greg, and one with
> > the devicetree changes, which goes through Bjorn's tree.
> > 
> > It's good if you could add a link to the binding series in the cover
> > letter of the devicetree changes as they are of course going to be quite
> > closely related and need to be reviewed in parallel.
> 
> Thanks for this pointer. So for Multiport, can I do it this way:
> 
> 1. Core bindings and Core driver changes in one series. Now that we 
> finalized we don't be adding the ctrl_irq[1] as discussed on:
> https://lore.kernel.org/all/ZU33uWpStIobzyd6@hovoldconsulting.com/.
> 
> 2. QC bindings and QC driver changes for Multiport to be pushed after we 
> clean up the current driver and DT's (an effort which is going on 
> currently).

No, I was just referring to how to handle binding/driver vs devicetree
patches for USB where we send them separately (unlike for most other
subsystems).

The dwc3 core and Qualcomm glue parts should still go in the same series
for multiport support.

Whether to do the irq cleanup before or after adding multiport support
is a different question, but, yeah, it is probably best to do it before.

The question of whether we can drop ACPI support should also be
considered as that should also simplify your multiport series.

Johan
