Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA52C7D2D36
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjJWIvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjJWIvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:51:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E1D65;
        Mon, 23 Oct 2023 01:51:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8500DC433C8;
        Mon, 23 Oct 2023 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698051107;
        bh=Vd28yKOH0TRadp/QldDFl+VqSlMewckCgsfZOnDua/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUI0p9EZzW5EQp/km//8FhM3hOl8F71DPi8ii981Mbq3jGfx6KbDZfgHYIE9N3Fma
         y1C72eMRXudKHFGy6p5vLVoPBe++MBVnYtceYYMJiNxjMWbDPwkggr3X1ZZyfJ4mlN
         CtIz+9XY1TYLR1s2nVwRpPPxxZqBq56jcNz/QBNz46qQMrTRkhUM5ohkd75GyZ9dPr
         pEEDAZ9P6kijjxpXJxJMLL4FMpKxkjd01TcMMapZvvr7u26nrkaeukndMaRob2ZbEH
         2HQW1lYiiQSm+u+gRO6UK84Fmd/Ek7Tj0nLLJ/3Ju6VYjQfhZKdLAlL4l8jcdcZX5R
         OxGLlZpRlDlCQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1quqfJ-0007hO-1Q;
        Mon, 23 Oct 2023 10:52:01 +0200
Date:   Mon, 23 Oct 2023 10:52:01 +0200
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
        quic_shazhuss@quicinc.com, Harsh Agarwal <quic_harshq@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v13 03/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZTY0MYmiM-WrA5B6@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-4-quic_kriskura@quicinc.com>
 <ZTJPBcyZ_zLXbgE5@hovoldconsulting.com>
 <157d1c8d-5aa4-4488-bf85-7806c8fb00bc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157d1c8d-5aa4-4488-bf85-7806c8fb00bc@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:11:46PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/20/2023 3:27 PM, Johan Hovold wrote:
> > On Sat, Oct 07, 2023 at 09:17:59PM +0530, Krishna Kurapati wrote:
> >> From: Harsh Agarwal <quic_harshq@quicinc.com>

> >> Co-developed-by: Harsh Agarwal <quic_harshq@quicinc.com>
> >> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> >> Co-developed-by:Krishna Kurapati <quic_kriskura@quicinc.com>
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > 
> > Thinh pointed out the problems with the above which were also reported
> > by checkpatch.pl.
> 
> I see that removing Co-Developed by tag for Harsh is helping with one 
> checkpatch issue. From what I know, although I made Harsh the Primary 
> author for the patch, should we still mention his Co-Developed-by along 
> with this Signed-Of by ?

This is all documented in the process document I pointed you at earlier.

You don't need a Co-Developed-by tag for the primary author.

> >> @@ -748,23 +781,32 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
> >>   static int dwc3_phy_init(struct dwc3 *dwc)
> >>   {
> >>   	int ret;
> >> +	int i;
> >> +	int j;
> > 
> > These could be declared on one line (same throughout).
> > 
> 
> I did so in v7, but was asked to put them in separate lines:
> https://lore.kernel.org/all/20230502221100.ecska23anlzv3iwq@synopsys.com/

Ok, either is fine if Thinh prefers it this way.

The problem is usually the other way round where people try to squeeze
in too much (e.g. unrelated variables and declarations) on the same
line.

> >> @@ -1892,9 +1975,12 @@ static int dwc3_read_port_info(struct dwc3 *dwc)
> >>   
> >>   	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
> >>   			dwc->num_usb2_ports, dwc->num_usb3_ports);
> >> -
> > 
> > Drop this random change.
> 
> The removal of extra line here done you mean ?

Yes.

> > 
> >>   	iounmap(base);

Johan
