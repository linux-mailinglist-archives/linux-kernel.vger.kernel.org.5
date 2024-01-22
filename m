Return-Path: <linux-kernel+bounces-32997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A788362FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C26F1F235E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB93CF42;
	Mon, 22 Jan 2024 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h22W9lTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E43C468;
	Mon, 22 Jan 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926017; cv=none; b=lGDVQwbgvU9tLUt6XuM5vo8tH7XghBOPFpFhN5EG+tEnFGy/E1vzA+s4B9OeYbJ+sH5MpG7zdbKztHpjJmOpBq7mcId05aGwI8CjyxYtJ/4GeUub3ZXz7E3EEmyqBAYqh05beHNnP8eMBowJ7NESGxGV4s7Gi/vBmVoEnrA5ZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926017; c=relaxed/simple;
	bh=/RSqN2Fgji+rQoBP/tsnnvR3WmLqh9ZWY4ZdpJUw+rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfO0KrgFfsZmij5uADuqTHW1x4b4oFv6URk+g9L2NdMcLCfyXpO0WY/93Yhg7VAtSjkuN/rLVCU7omBTuek9ts0yN1QDKHmOBUW0ZSSdlkTeWqPjnQkp3Q+AjH27EpXUBfjas6EzaPmJ91L5QID/PoD9XSSRo1zVymWDqJMEZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h22W9lTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D987C433B1;
	Mon, 22 Jan 2024 12:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705926016;
	bh=/RSqN2Fgji+rQoBP/tsnnvR3WmLqh9ZWY4ZdpJUw+rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h22W9lTpevCfg1+UfZzG9Tp6NKthPNsbYG0QHkEggtN0KuoPIeboxQ1n7Zf0Ac1cf
	 nVFQLp10M41JwIE7rR4jiNo/yG0wgt9bZmVcDDEg40BQMRjgqYTPbhYuUPy/Cx17a/
	 LI25VH7k6ZDDlMDSubkPyvaC6y4OH/fYEZ9TduoeIixWpZI0cxPLfMic7UPVa0n4BY
	 G/44g8n3QXF/4cmKBnt9lyDged6/n5QCfjanDMsH9RINQVQJpkxhyFb0DQWCkJeeei
	 2p3qsOISKvRQXCZkhgwpuiiZoI4Gs/EDEpVjam+z7/lxKBVMMBSAz6QwdLpOaZBq2I
	 L/OEofo7yQVmA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/7] dt-bindings: clock: mpfs: add more MSSPLL output definitions
Date: Mon, 22 Jan 2024 12:19:49 +0000
Message-ID: <20240122-envoy-chosen-7ae961b3b07e@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122-catty-roast-d3625dbb02fe@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=28AMgJEH+kbgvVu06aM3gqKT3dUxuCabMm2ZpjhF9GI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnrYlPmLJT0Kn5llKNl++tn4PHwJTLlOU3r4h9yynFfO zGhrk2xo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABMxSmb4Z+C2z3dvWZXJbYWJ ckqH4j6pfZduK8xPfVT3Z86GIiY/U0aGd4aP8g6uOMUo/7Qn1c1qZlV/T7PIsZBg9Q3bgrb+cuj iBwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

There are 3 undocumented outputs of the MSSPLL that are used for the CAN
bus, "user crypto" module and eMMC. Add their clock IDs so that they can
be hooked up in DT.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 include/dt-bindings/clock/microchip,mpfs-clock.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/microchip,mpfs-clock.h b/include/dt-bindings/clock/microchip,mpfs-clock.h
index 79775a5134ca..b52f19a2b480 100644
--- a/include/dt-bindings/clock/microchip,mpfs-clock.h
+++ b/include/dt-bindings/clock/microchip,mpfs-clock.h
@@ -44,6 +44,11 @@
 
 #define CLK_RTCREF	33
 #define CLK_MSSPLL	34
+#define CLK_MSSPLL0	34
+#define CLK_MSSPLL1	35
+#define CLK_MSSPLL2	36
+#define CLK_MSSPLL3	37
+/* 38 is reserved for MSS PLL internals */
 
 /* Clock Conditioning Circuitry Clock IDs */
 
-- 
2.43.0


