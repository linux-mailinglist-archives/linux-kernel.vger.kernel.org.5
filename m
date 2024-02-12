Return-Path: <linux-kernel+bounces-61915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB8E851858
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D0828771B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D93CF5C;
	Mon, 12 Feb 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="gS7lHoVJ"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B863CF49
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752639; cv=none; b=Az2B+pxLn1JmdwW9BIYpPiok4YI7tk1VQh+vp3Bomoe2KrrEqDI3mhFiC2LFKc11amxCMGeQ41ccAh2WK75h8D0pDxs+3V+AhTUoCppiT5QZackMi2BWnfhyjH2L/EiNNFJBFDUIp47rHqYGNpKLA7AosQLypCEUIFpfHpSkPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752639; c=relaxed/simple;
	bh=cvVTOC2X+05hH/d+YZ7aGeqiZdF4zt9gjMio55/9LC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lWJXgiJuiES/9xCqvxjqakoX86KCloeWqDDR7mL1b1cxNqP77OXP6Xcp8k7XNv1WlvgDr5yz9t2vpboFwHbsGQ0idnx/0TpdH+dd1CzBuDiowlsDV8UJFpGIrMa7pPpMLrXiPD1V6DPQZlX9Ro3/scTLX7kSpQqytJEz1qtn0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=gS7lHoVJ; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 0CC21240106
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:43:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1707752635; bh=cvVTOC2X+05hH/d+YZ7aGeqiZdF4zt9gjMio55/9LC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=gS7lHoVJUa0+Vm69TgFx8bQbHOMKrApMNLk50nRR5YKcltNl9p2WPpkRzIZBLSmgy
	 TcPH++Wrv2nXZ05XQJGb/1mLvdTFTp3jXsPHtXtvmYYFirOILan5cOIjBNF7iRHWNY
	 NdK4aCwNusOr+zjBR1X/x4IHHgJ9MISW84+OyT+mwB+u2o83lqbf4A+h5WWRhlRgI3
	 sFW/NFlD13d7e7TEmnBpclZI/oVOcHvnUkvptcRsr0iILO8U4eVQUmeP04l3r6XFQ/
	 VXtO+Psw3XN3H31Sp3IvNLmThZY/FiQoIu4/lkfJAHnuh3AkIzrZhfiTRZ3NZof0Ng
	 55go2bntVoIqg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TYTJl4Z3Dz6txm;
	Mon, 12 Feb 2024 16:43:51 +0100 (CET)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH] net: stmmac: xgmac: fix initializer element is not constant error
Date: Mon, 12 Feb 2024 15:43:19 +0000
Message-Id: <20240212154319.907447-1-shiftee@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC prior to 8.x gives an "initializer element is not constant"
error for the uses of dpp_tx_err in dwxgmac3_dma_dpp_errors.
Newer compilers accept either version.

More info here:
https://lore.kernel.org/all/20240103-fix-bq24190_charger-vbus_desc-non-const-v1-1-115ddf798c70@kernel.org

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 323c57f03c93..c02c035b81c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -830,8 +830,8 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
 	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
 };
 
-static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
-static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";
+#define dpp_rx_err "Read Rx Descriptor Parity checker Error"
+#define dpp_tx_err "Read Tx Descriptor Parity checker Error"
 static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
 	{ true, "TDPES0", dpp_tx_err },
 	{ true, "TDPES1", dpp_tx_err },

base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
-- 
2.39.2


