Return-Path: <linux-kernel+bounces-4423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A2F817CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6A02864AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C4B7CCFD;
	Mon, 18 Dec 2023 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o2FDqXiN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DA7C645;
	Mon, 18 Dec 2023 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702935903;
	bh=PX9WR1wsK5Wtdc1EF8E/KGnEO4lLD+GneTrUOqNm76c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2FDqXiNcCLgRFLH5qXcvMq2L1svg6g+4RfB6S3dIApGqILH0GwNj0NiXlz8iPutr
	 geetWUt63bwQm91x8TyEmvlUh0T/PaqEddJRgiJYx5sbplzUT1T1za7+AGId3t2qKt
	 V1gA9RmLAJ8S+OBauEmtxJBVuKgi1ddHCEjSwN4mNF84mBQx9LJAq3JVIi3eYLZh0j
	 IoyY+9+Z7Zh37qJXhYZuOxKBl64KAsR++zRBXOf/8bDh6/O8/1llN5K3QU01Awdg/V
	 TO4Kvjp1DcCxG2+q3yRTSufKxsDmLzB4I1HiHcI9lPtrLnQ80x0Za4EUiVCm8bdK9R
	 6zDcFd2WpG5hA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A6753781495;
	Mon, 18 Dec 2023 21:45:03 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v4 9/9] clk: starfive: jh7100: Add CLK_SET_RATE_PARENT to gmac_tx
Date: Mon, 18 Dec 2023 23:44:49 +0200
Message-ID: <20231218214451.2345691-10-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218214451.2345691-1-cristian.ciocaltea@collabora.com>
References: <20231218214451.2345691-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

This is needed by the dwmac-starfive ethernet driver to set the clock
for 1000, 100 and 10 Mbps links properly.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/clk/starfive/clk-starfive-jh7100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index d3b260c01d5c..03f6f26a15d8 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -200,7 +200,7 @@ static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
 	JH71X0_GDIV(JH7100_CLK_GMAC_GTX, "gmac_gtxclk", 0, 255, JH7100_CLK_GMAC_ROOT_DIV),
 	JH71X0_GDIV(JH7100_CLK_GMAC_RMII_TX, "gmac_rmii_txclk", 0, 8, JH7100_CLK_GMAC_RMII_REF),
 	JH71X0_GDIV(JH7100_CLK_GMAC_RMII_RX, "gmac_rmii_rxclk", 0, 8, JH7100_CLK_GMAC_RMII_REF),
-	JH71X0__MUX(JH7100_CLK_GMAC_TX, "gmac_tx", 0, 3,
+	JH71X0__MUX(JH7100_CLK_GMAC_TX, "gmac_tx", CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, 3,
 		    JH7100_CLK_GMAC_GTX,
 		    JH7100_CLK_GMAC_TX_INV,
 		    JH7100_CLK_GMAC_RMII_TX),
-- 
2.43.0


