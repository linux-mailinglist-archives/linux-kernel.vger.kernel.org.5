Return-Path: <linux-kernel+bounces-62863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB9D852703
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F59B2AD44
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEBC17577;
	Tue, 13 Feb 2024 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7FzUXFT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E014010;
	Tue, 13 Feb 2024 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787817; cv=none; b=MPObzTuhoMHBSSEMdXxBB5fKVwe+kZePFaJSyWRk2K55qD/PAJfgxqjZhtVC1gyNGIm2A7U0KLGThf4sQxBZQgVSaO/lSM0TdtdAzlykAyaLFJEY5m8ydT9wLgVmr2S3LXAgkGatBfgzuMY7HXvEnI2QQef9B2Uo85sUN71R4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787817; c=relaxed/simple;
	bh=JdTHedcxVO15s3B4sRid8zTpEzYkN8lo7pBe02dMOIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VN1gjarGfMZqMce9JUlciDxNyAJewLnhGbDmzinEDUkLgNiyz+jYEXekILmAYlbFnJV+fxdwBGVbcupAs4SqPN4/FG5oSj5/mOSVlgpGAjpiVzdWkKoxFVEt4dhBBJe84UC+l8PolTvbcYuduiltjO+wz8Ic30w51xnGOSmJDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7FzUXFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808CDC433C7;
	Tue, 13 Feb 2024 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707787817;
	bh=JdTHedcxVO15s3B4sRid8zTpEzYkN8lo7pBe02dMOIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f7FzUXFTQaQH8sST/82MCPpBjozyaFswVdXgob1DuM96d49GvcQ8wdCMwWZLzkxgb
	 UJgmMIkE6HmuBTiwWJJ6jbHzUIBgH/uaV2/oVNOH4xgI1gpyjHC1FKtodkkM88NPb5
	 LyLBx4QyM/e4GbXQ9l/97+7UnUSKW79+3X60suDirIZ49zHBqCVf9kc5JZJbMEEuBU
	 lj1FTyIPXxlSxynmRWq9W8yZkHNr8N0DDAMX7DKO/qDNJnO27yCwoSnhWfXInum8fD
	 dpSzPJHVFS8eWxVFGFi/KxHI9rP3OGCCxyjAQig1Jl5af3KmOGPZSpKo/QKejms+s5
	 N9fniz4acy2nQ==
Date: Mon, 12 Feb 2024 17:30:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma
 <bhupesh.sharma@linaro.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH net-next v4] net: stmmac: dwmac-qcom-ethqos: Add support
 for 2.5G SGMII
Message-ID: <20240212173015.0341f0ee@kernel.org>
In-Reply-To: <20240208111714.11456-1-quic_snehshah@quicinc.com>
References: <20240208111714.11456-1-quic_snehshah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 16:47:14 +0530 Sneh Shah wrote:
> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
> mode for 1G/100M/10M speed.
> Added changes to configure serdes phy and mac based on link speed.
> Changing serdes phy speed involves multiple register writes for
> serdes block. To avoid redundant write operations only update serdes
> phy when new speed is different.

Sounds like 2 separate changes in one patch, please split the
optimization of not writing the registers multiple times and
the 2.5G support.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 31631e3f89d0..6bbdbb7bef44 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -106,6 +106,7 @@ struct qcom_ethqos {
>  	struct clk *link_clk;
>  	struct phy *serdes_phy;
>  	unsigned int speed;
> +	int serdes_speed;

Why signed if speed itself is unsigned?

>  	/* Enable and restart the Auto-Negotiation */
>  	if (ane)
>  		value |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
> +	else
> +		value &= ~GMAC_AN_CTRL_ANE;

That looks unrelated. Either a separate patch or please explain in the
commit msg why.
-- 
pw-bot: cr

