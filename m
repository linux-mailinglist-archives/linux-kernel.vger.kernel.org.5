Return-Path: <linux-kernel+bounces-132038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662C8898F03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978A91C29937
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B12313B787;
	Thu,  4 Apr 2024 19:27:02 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA54134730
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258821; cv=none; b=AIGlyhHLjVuB3W1ElQkw6GQ18lzAGvOE/Rayx1eR58pycZVIgbznjSxB5PAvFvo4IMbUKdNg+v+Dvzvnmq9AMsnhphlZn1bdZR1kxeC0hWTFEnIzNQMAFtQZU3SGHL4QVP77/PzVMgCDjFsnOHAzI6HHRHaQ2Xxg5DqXypks5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258821; c=relaxed/simple;
	bh=DN3Rl/VGAC+TFPGwzkMs2CopD6q2AYSDbcJFPFL9loU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoRyaZ7QcCbZb03CeU1UpKl4gQ30Cd44MGf26CwfnJq7yDIoscf/n9sN9QoqID+TwuXIHG7XDUPXtebPPhS4v8X7GzR3zquxRPapkwFjTS0D4+ZIDy9wtn6w1wQfAtRiaduOjoOy6kfTjZqHYLazVUaFQAjnpmUnyChGhuRG3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rsSjZ-0005PO-AW; Thu, 04 Apr 2024 21:26:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Michal Tomek <mtdev79b@gmail.com>,
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject:
 Re: [PATCH 2/3] phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON
 bits
Date: Thu, 04 Apr 2024 21:26:48 +0200
Message-ID: <5232346.31r3eYUQgx@phil>
In-Reply-To:
 <20240404-rk3588-pcie-bifurcation-fixes-v1-2-9907136eeafd@kernel.org>
References:
 <20240404-rk3588-pcie-bifurcation-fixes-v1-0-9907136eeafd@kernel.org>
 <20240404-rk3588-pcie-bifurcation-fixes-v1-2-9907136eeafd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 4. April 2024, 19:11:27 CEST schrieb Sebastian Reichel:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Currently the PCIe v3 PHY driver only sets the pcie1ln_sel bits, but
> does not clear them because of an incorrect write mask. This fixes up
> the issue by using a newly introduced constant for the write mask.
> 
> While at it also introduces a proper GENMASK based constant for the
> PCIE30_PHY_MODE.
> 
> Fixes: 2e9bffc4f713 ("phy: rockchip: Support PCIe v3")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

after checking with the soc manual

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



