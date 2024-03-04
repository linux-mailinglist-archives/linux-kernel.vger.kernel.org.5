Return-Path: <linux-kernel+bounces-90133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B23D86FAD6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C650E285722
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73B1756F;
	Mon,  4 Mar 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="rfl0fOro"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22AD171CC;
	Mon,  4 Mar 2024 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537423; cv=none; b=P0zyE7joj8ycUpd7p+eSirOhnF3v9UwKEJBBT3O+fcogNOPQM/ovTRJFNUTEv8LIlgq02HWNv9aVomZcq2jbrSkVofWfaaQtceOD9wZ124j7KgCbEYPz6d519WflmcXOnxWOVsk2xZDwKmJbM5dzuNT/W9vGJ6UzCEZPJeV6JPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537423; c=relaxed/simple;
	bh=sz8/RCE/mblTN6+mQB7r6nXbctInrDxt2wSc2tr+a2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGQ8Bx57pI4BZcToIzxGbjd4Z6sl1b5+emgz95g60VqVFlvx0UjPgpw1rcmHfVu8Ti1jMfh4HoP+gr2xTKaB+bTZlwzzaOp+KODEoqk3dLyyEWwI1RDujwfGH/uTdFnMZy0rb86r44SGs54//9Ek9h0Q8fvwxWBQs27Z1G8PkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=rfl0fOro; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tp9MY4Xxbz9t8K;
	Mon,  4 Mar 2024 08:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1709537417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugKhzTVt1AcqmTVj4/zhKrifJsgXqt3bG4BPHQ/PtEk=;
	b=rfl0fOroTEroDocPQFaoCLIp8MH7SRryewSU2SeoF5LuO+v0uGb2oGTqGN7JU+4LqXvKaM
	qS8fQapsw+tvDZ+JmF07+E8GVba2zWho71dbSmuQTfgIPxKJpj1N7jImLKRxgDOrJ2G8ah
	UOPBQ3lpleNEmtQ01Xg25znZbNwkuKOzwSEDOGf6VftJrL5I6s2HVwlps+6dEcQOwL3uCl
	zOZrZO35uB4xtgU6CjGtq9oeGmP4ZA4UrJmqpzw7j7mS51qbwrlPgvLyLirULK4CvyDPHl
	Exf2aIQ/OAwyZElxkUegJ1Og8+XiI1loRvnPEzxW+SDA2muexUtZPjN5kfieig==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Mon, 04 Mar 2024 08:29:19 +0100
Subject: [PATCH v3 3/5] clk: sunxi-ng: nkm: Support constraints on m/n
 ratio and parent rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pinephone-pll-fixes-v3-3-94ab828f269a@oltmanns.dev>
References: <20240304-pinephone-pll-fixes-v3-0-94ab828f269a@oltmanns.dev>
In-Reply-To: <20240304-pinephone-pll-fixes-v3-0-94ab828f269a@oltmanns.dev>
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
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBl5XhwI0bCeru/1nlBW/G5cBW5Fv1lAQqsQfso4
 Eq7T4NnpsCJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZeV4cAAKCRCaaaIIlErT
 x+2jC/9GmU2LB9KQ8+Ht1upHBN6188WAGWTUcOUKTsaQRR0jAXDy1+eE7AoHXJTJAciU+uI4/B4
 p6ie9RlS1UXiIAKWMqgSbZ7XMXnPhdz2ZB0T9mSjNQYi5PMlaHzoSwHeMUrtuYyIZvxobCiGITZ
 W3Io+7L18WdBOFEq9iIAtQkWWg4yNRRUlxYUxvkkOOlfdxTHmV+7ZYfPC57KRcDoU2WUVcr/whn
 5AeLbd5LLQvfvv7RQCuKAkCNwAy3afi4HEXFTTCanfuj36s9TXrY4cHuW/DDAR37YcGFMcWZYId
 HFF7vz/QzwUvDnZlOAvxDOQR1jfmzLv/9k9Qs9z0S9xItTcDAN2fhRwuDRkz7FwpcUhnpkc9Npq
 G1m4k9K21huu4tLx9NbIBskqIfbd0GWOo/w6XYbd/ByAC3TWWu7htdthvMQFCsTSjwJ1FMKRj8Z
 iVuzy1SNN2EUTAFsfMTGnfOetrzOjt+HUZVuSh7HtcRtZKJlRtNLIiazpcoW/HTB/GNsE=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7

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


