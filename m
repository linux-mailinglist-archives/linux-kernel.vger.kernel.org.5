Return-Path: <linux-kernel+bounces-1637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E3381514A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388641C23D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CB5F84C;
	Fri, 15 Dec 2023 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bZ9Ukbpb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80F51C36;
	Fri, 15 Dec 2023 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702672858;
	bh=oakIDQ7uvG01/XJJI13ENXnsSIMGPigmTQIvEoHHsm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZ9UkbpbtR7o4Yt0JpJNHHDMRvnNvXDFgZ2qbAPQBHpA2QY8Z980Rj3yQZK8k+B1O
	 HyXAxcuixX1hPBHvFaVCqsNQxhGr2wniiRhlnchbp7Kl98IIf5zte7bhluKSfp28+Z
	 D8/YBkkxn/3XIuZ5J3UUAdvkq3N9z/L9tLLzCXx6CaAV34xSvCZJWuxX8w18/598t0
	 1XYeu1fq2VZ+BIatXZ1JMJie9kGGRd3RL6CUw8mrHlp8jZt6p+tZDjXWhfEtS0kF/G
	 OkLT07XORsagSNfC4j4/Hv09c7WqTkSZGXja6S6F3dFhLGCHsbkkwSQhiV60Ox/QQj
	 XrxsbqQFZhAmw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 804563781FF2;
	Fri, 15 Dec 2023 20:40:58 +0000 (UTC)
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
Subject: [PATCH v3 6/9] riscv: dts: starfive: visionfive-v1: Setup ethernet phy
Date: Fri, 15 Dec 2023 22:40:45 +0200
Message-ID: <20231215204050.2296404-7-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
References: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The StarFive VisionFive V1 SBC uses a Motorcomm YT8521 PHY supporting
RGMII-ID, but requires manual adjustment of the RX internal delay to
work properly.

The default RX delay provided by the driver is 1.95 ns, which proves to
be too high. Applying a 50% reduction seems to mitigate the issue.

Also note this adjustment is not necessary on BeagleV Starlight SBC,
which uses a Microchip PHY.  Hence, there is no indication of a
miss-behaviour on the GMAC side, but most likely the issue stems from
the Motorcomm PHY.

Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../boot/dts/starfive/jh7100-starfive-visionfive-v1.dts    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
index e82af72f1aaf..ca134b9f11bf 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
+++ b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
@@ -18,3 +18,10 @@ gpio-restart {
 		priority = <224>;
 	};
 };
+
+&mdio {
+	phy: ethernet-phy@0 {
+		reg = <0>;
+		rx-internal-delay-ps = <900>;
+	};
+};
-- 
2.43.0


