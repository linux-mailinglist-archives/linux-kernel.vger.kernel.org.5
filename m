Return-Path: <linux-kernel+bounces-135175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E789BC35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE292840C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D234AEF8;
	Mon,  8 Apr 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td341aOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC28481DF;
	Mon,  8 Apr 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569585; cv=none; b=dPawekrrmr4glBYNQHlPToRUJDjVzIVPG/O2+1VCMdQKfxF6UK7OqUprp7ni7AFjHxMUKnBGuuF5ItzU6DAa9Dam12jSOoI3K6i8sAFTlxZohQ7I5owE2AttK6iWNRje2eWNv3jxdjZ/r4gV7zOSVkAp0bCGewtevpHTa/LjzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569585; c=relaxed/simple;
	bh=w96AR1Wv4GGEMME0DTaOez2gviiLAqcq3igwhCwqMEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie5dCDFOL3hF4IOgzKuFfH/tWxs1fw4vvjEUHQ353j7YmRV/47ObJzysOQ+g2wJLgPasuzwDn3EwyyGEMUSNqABwc34RDBvb7NZzmI9oYTvCi/CzC+kdAAogp20RgjwMSe8fUY3alOtjzWKeCHMCFJh6nfszyfqdpfpU37NAwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td341aOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06309C433F1;
	Mon,  8 Apr 2024 09:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712569584;
	bh=w96AR1Wv4GGEMME0DTaOez2gviiLAqcq3igwhCwqMEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Td341aObAzkaNYyl+vraZVNR5iMk4iIyJPIufLM2K7/sakH38bZ2NUcHm9FUeTCR5
	 cCDVCFDtsNGv4B5WQ4oGk6DjTxaZfB5Eb5zh5ldKIx4XFUWncCmr8WEaNLpN1Wm7pw
	 oFP61mtQoCUYUEUqHl3TgKB0JDzxY03ydK+8djGEYe2F+DTCtyFK6KzDCP3LwQRKo8
	 F6MfBVTTRB6YF6FrUI/S7e58qjrbEhhm4iTCRGk7mXhYUH2A86gv5AXwWec8esyIF0
	 V2M+8zV/tMR7s7TLu8kFHW/kxznUECsUyeDnY1bpxbmCjgA8koTp4DCghRT3UNr4mb
	 y87JWeH2mex8A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rtlZx-000000000Mc-2Pb1;
	Mon, 08 Apr 2024 11:46:18 +0200
Date: Mon, 8 Apr 2024 11:46:17 +0200
From: Johan Hovold <johan@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-phy@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	freedreno@lists.freedesktop.org,
	Douglas Anderson <dianders@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] phy: qcom: qmp-combo: Fix VCO div offset on v3
Message-ID: <ZhO86VWkrOSIGBHV@hovoldconsulting.com>
References: <20240404234345.1446300-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404234345.1446300-1-swboyd@chromium.org>

On Thu, Apr 04, 2024 at 04:43:44PM -0700, Stephen Boyd wrote:
> Commit ec17373aebd0 ("phy: qcom: qmp-combo: extract common function to
> setup clocks") changed the offset that is used to write to
> DP_PHY_VCO_DIV from QSERDES_V3_DP_PHY_VCO_DIV to
> QSERDES_V4_DP_PHY_VCO_DIV. Unfortunately, this offset is different
> between v3 and v4 phys:
> 
>  #define QSERDES_V3_DP_PHY_VCO_DIV                 0x064
>  #define QSERDES_V4_DP_PHY_VCO_DIV                 0x070
> 
> meaning that we write the wrong register on v3 phys now. Add another
> generic register to 'regs' and use it here instead of a version specific
> define to fix this.
> 
> This was discovered after Abhinav looked over register dumps with me
> from sc7180 Trogdor devices that started failing to light up the
> external display with v6.6 based kernels. It turns out that some
> monitors are very specific about their link clk frequency and if the
> default power on reset value is still there the monitor will show a
> blank screen or a garbled display. Other monitors are perfectly happy to
> get a bad clock signal.

> Fixes: ec17373aebd0 ("phy: qcom: qmp-combo: extract common function to setup clocks")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 7d585a4bbbba..3b19d8ebf467 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -77,6 +77,7 @@ enum qphy_reg_layout {
>  	QPHY_COM_BIAS_EN_CLKBUFLR_EN,
>  
>  	QPHY_DP_PHY_STATUS,
> +	QPHY_DP_PHY_VCO_DIV,
>  
>  	QPHY_TX_TX_POL_INV,
>  	QPHY_TX_TX_DRV_LVL,
> @@ -102,6 +103,7 @@ static const unsigned int qmp_v3_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V3_DP_PHY_VCO_DIV,

> @@ -126,6 +128,7 @@ static const unsigned int qmp_v45_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V4_DP_PHY_VCO_DIV,

I happened to skim this patch on the list and noticed that you added a
new register abstraction but only updated two tables.

A quick look at the driver reveals that there are currently four such
tables, which means that the v5_5nm (e.g. the Lenovo ThinkPad X13s) and
v6 hardware would now be broken instead as they would write to offset 0.

Clearly the hardware abstraction in this driver leaves a lot to wish
for when it's this fragile, but how can three people including the
maintainer review this change without this being noticed?

I just sent a follow-up fix here:

	https://lore.kernel.org/lkml/20240408093023.506-1-johan+linaro@kernel.org/

> @@ -2184,7 +2188,7 @@ static int qmp_combo_configure_dp_clocks(struct qmp_combo *qmp)
>  		/* Other link rates aren't supported */
>  		return -EINVAL;
>  	}
> -	writel(phy_vco_div, qmp->dp_dp_phy + QSERDES_V4_DP_PHY_VCO_DIV);
> +	writel(phy_vco_div, qmp->dp_dp_phy + cfg->regs[QPHY_DP_PHY_VCO_DIV]);

Johan

