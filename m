Return-Path: <linux-kernel+bounces-98227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1504C8776FD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC74728125B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51A2C6B2;
	Sun, 10 Mar 2024 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="AnZC+e2a"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433762943F;
	Sun, 10 Mar 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710076949; cv=none; b=jYbuzFSstUzprvQ29xHIkEwj3x90GANCmlRy5oL86ppOzHEovLA2w5SifNFTxSpoHRUGZHWGJysfmBMzHpenpOYNyJfjl5v7b/wLfiWyNauvm/C73SBBfNxmeC9T4l278UBMnhSx/wOh51KdWrMFnVfP6VilxxDA7P4hVlq4xqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710076949; c=relaxed/simple;
	bh=sz8/RCE/mblTN6+mQB7r6nXbctInrDxt2wSc2tr+a2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/rsrio/S2btW5gc8wTK6T+9HDIHM6vPvnvVy3Iu4s6/nHgM9O8ENSM9WI/nVTJyz/ntD8AE/UacPXNKoGNGQYTYDFCx0eQkRVJmzIve3m+oU5ZsJZ73RfAAgkmvdggYohSlAOw1Th0SGWUC7kKwW7ZLHfxqN4eFi/fJUvY1HoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=AnZC+e2a; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Tt0v45hX5z9sps;
	Sun, 10 Mar 2024 14:22:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1710076944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugKhzTVt1AcqmTVj4/zhKrifJsgXqt3bG4BPHQ/PtEk=;
	b=AnZC+e2aF9e/e3raZ/HmFBI4rZRzDxjSUpTqCLeG4rYtcC5y+uQRv0VBaHDuFvWyVgBGEt
	13ZjpOSpnsEblHujKJi0Df8cjDegZrSVOBa4QGQTRJKyCxnjEAsrl8CuJj2s7jpdH6j7rH
	HLKxss97dZkioiI2Epp6WoXokXv8BcXgxAYKNApVmMQeJY2BB+jxgFf6/AE7IufSyFZ7dm
	Z7PElD3n0t9L077DNF62pyIFKBc7Ep6lFHpb9x7hPnV1T3O73LLb3KkzkyHbhITkmfRNB7
	bneU5+OVIFnPEvIsJlCjxlRbh8txufGpI8koVFI6vN4jXSEOhmmwztby2LkWVg==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Sun, 10 Mar 2024 14:21:13 +0100
Subject: [PATCH v4 3/5] clk: sunxi-ng: nkm: Support constraints on m/n
 ratio and parent rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-pinephone-pll-fixes-v4-3-46fc80c83637@oltmanns.dev>
References: <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
In-Reply-To: <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2581; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=sz8/RCE/mblTN6+mQB7r6nXbctInrDxt2wSc2tr+a2Q=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBl7bP5Pva37Lqxh7aeU4Ge0T48bdNaev/Ytwhzh
 xTIwi0Pf9OJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZe2z+QAKCRCaaaIIlErT
 x47kC/0bWCWj4UUKuy1/lJZ2Qaz5o9QjWH//p6UhSvRoMO0PW67MWT5weXPqpq0fdxfkTHVM/S8
 9vM1SBGW/C7VN/eVTeIvfsCBGlk3IGMMyJ7uVnUSrPJQD+fgw6dexD5qI2hNQRy5mgVAqUv5SZ2
 kPf6MemGxZfwsI0fxaavcUiQARZWRtcNar3ybbnoIIb0BWzVeaXCuLWyKcNYjbph6pETDAJFSLF
 /0sBarC6qWNPJAeFEc0I7hSXc8ysA5ws9MSADrZDxQFtQbOBDCqGwW+jPf9+L/9jDaLLtWNQDsh
 aPwY3HPk4T3yaYefRX5idT6w0M0qy7lkB1d5mZb6ArQOZ/sKv01aNs6PfJy4bJQzyJi8ZpR8wqk
 Yv0gV5EEHLz3goA/nReyrB4xtxxGwuwwOotKrXOoLmACBbNy2iB/KztRCdbIvrnx59ZqQ2AZmsq
 fXlbL1/lDQrwjeNt8J2vrPQ4twmiZPPELa81VB0jmGBACqkE6btneLjYRmhnCSb/kQj0I=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4Tt0v45hX5z9sps

The Allwinner A64 manual lists the following constraints for the
PLL-MIPI clock:
 - M/N <= 3
 - (PLL_VIDEO0)/M >= 24MHz

The PLL-MIPI clock is implemented as ccu_nkm. Therefore, add support for
these constraints.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 21 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 853f84398e2b..1168d894d636 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -16,6 +16,20 @@ struct _ccu_nkm {
 	unsigned long	m, min_m, max_m;
 };
 
+static bool ccu_nkm_is_valid_rate(struct ccu_common *common, unsigned long parent,
+				  unsigned long n, unsigned long m)
+{
+	struct ccu_nkm *nkm = container_of(common, struct ccu_nkm, common);
+
+	if (nkm->max_m_n_ratio && (m > nkm->max_m_n_ratio * n))
+		return false;
+
+	if (nkm->min_parent_m_ratio && (parent < nkm->min_parent_m_ratio * m))
+		return false;
+
+	return true;
+}
+
 static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common,
 						       struct clk_hw *parent_hw,
 						       unsigned long *parent, unsigned long rate,
@@ -31,6 +45,10 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common
 				unsigned long tmp_rate, tmp_parent;
 
 				tmp_parent = clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
+
+				if (!ccu_nkm_is_valid_rate(common, tmp_parent, _n, _m))
+					continue;
+
 				tmp_rate = tmp_parent * _n * _k / _m;
 
 				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||
@@ -64,6 +82,9 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
 		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
 			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
+				if (!ccu_nkm_is_valid_rate(common, parent, _n, _m))
+					continue;
+
 				unsigned long tmp_rate;
 
 				tmp_rate = parent * _n * _k / _m;
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
index 6601defb3f38..c409212ee40e 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.h
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -27,6 +27,8 @@ struct ccu_nkm {
 	struct ccu_mux_internal	mux;
 
 	unsigned int		fixed_post_div;
+	unsigned long		max_m_n_ratio;
+	unsigned long		min_parent_m_ratio;
 
 	struct ccu_common	common;
 };

-- 
2.44.0


