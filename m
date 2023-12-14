Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6D812D30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443662AbjLNKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443641AbjLNKjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:39:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741ADE3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:39:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20BDC433C7;
        Thu, 14 Dec 2023 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702550363;
        bh=yCEKQFaUrCZAt0Cggx/F1wMYgUKW9axB5dGFHkP8rxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5w1HLkELARynQCRfDz4e/qOmrfpq/znPX7uuY+43vvYzB0JhDPZMpD90pHmb5+TS
         pNar2GRPHylpBIgI/yXLg6mSjR+fHWHM2uVwD2+F2k704AHEnw2/vMDfKjf8ELTWss
         8eXju5pKQonG+EN/Yo1CpqF0H0SVscHiWzDnC0NVCY4kaNyXJ/g3//zAF0xokFehC0
         fmBrk5E0ySQus/FAPaF6KjZxe/ESQiEWaN/g/KjbxZeOr7Z3+lqXZzEmX4ieiqil7I
         KmdayZLawHOGmHZMUHl8LDeyVicfnTJfI0uFpU+0YfCp/GgPDK0ggj/UhIzGnQlF3T
         xyyVq54yS3Wnw==
Date:   Thu, 14 Dec 2023 16:09:07 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 00/16] Fix Qcom UFS PHY clocks
Message-ID: <20231214103907.GL2938@thinkpad>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
 <ZXrVxmxY6wZprbBa@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXrVxmxY6wZprbBa@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 11:15:34AM +0100, Johan Hovold wrote:
> On Thu, Dec 14, 2023 at 02:40:45PM +0530, Manivannan Sadhasivam wrote:
> 
> > This series fixes the clocks supplied to QMP PHY IPs in the Qcom SoCs. All
> > of the Qcom SoCs except MSM8996 require 3 clocks for QMP UFS:
> > 
> > * ref - 19.2MHz reference clock from RPM/RPMh
> > * ref_aux - Auxiliary reference clock from GCC
> > * qref - QREF clock from GCC or TCSR (TCSR since SM8550)
> > 
> > MSM8996 only requires 'ref' and 'qref' clocks.
> > 
> > Hence, this series fixes the binding, DT and GCC driver to reflect the
> > actual clock topology.
> 
> Is this based on documentation for all the SoCs or on inference from the
> current (upstream and downstream) devicetrees?
> 

It is based on the internal documentation. Even downstream devicetrees are
wrong. I should've mentioned it in the cover letter.

> Are you sure that you should not just describe that some of these UFS
> reference clocks are sourced from CXO in the clock driver instead?
> 

I don't get your comment fully. Could you please elaborate?

> Take a look at commits
> 
> 	f446022b932a ("arm64: dts: qcom: sc8280xp: fix UFS reference clocks")
> 	f6abcc21d943 ("clk: qcom: gcc-sc8280xp: add cxo as parent for three ufs ref clks")
> 

Btw, these commits are not accurate. In all the SoCs before SM8550, reference
clock for the UFS device comes from the UFS controller. There is a dedicated
register in UFSHC memory map that is being toggled by the driver to
enable/disable reference clock for the UFS device.

Since SM8550, reference clock is directly sourced from RPMh. I'm preparing a
series to fix it.

Unfortunately, this information is not depicted correctly in the downstream
devicetrees.

- Mani

> Johan
> 

-- 
மணிவண்ணன் சதாசிவம்
