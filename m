Return-Path: <linux-kernel+bounces-113277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2214888309
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DDE1F24950
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D118BC56;
	Sun, 24 Mar 2024 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pkc3nfX5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C1118BC40;
	Sun, 24 Mar 2024 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320077; cv=none; b=S7/nTFprW3Ed8dEF4LueRa5UDSrqR/XAgFPz5PlgfuJa0iFgKpkhHQeQ0DF1H5D7q9vvCOeg9pl4VAuAr2yqyloFozdLijVe0G1Xx1Plx5dwMAVO/wSiQMI1WwWmjVTfdJFwoS0iLHUE4XZQVRPhSPdGxg7U4fLlBAtOeKPCzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320077; c=relaxed/simple;
	bh=0V0modpgI+8Pr8qgQ7JsqrWWI9vJdi3MzunN4UFnEr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSYkZYWdOVejs/M22+Ovg1tnnYlpH0k2Qe4XcTTUxa4gOrdgUGlY1+foW6YS3Vgs5cOwfGKxOtjwJxDTrKeYFkrcuycQgaZPpN9XYddRuvsV+eF20L9X+/ka+X29e2/C2SKTY9FPOcOgeB+mbCTHgdBouG3z0/kJdAFCVYH8Fm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pkc3nfX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE0AC43399;
	Sun, 24 Mar 2024 22:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320077;
	bh=0V0modpgI+8Pr8qgQ7JsqrWWI9vJdi3MzunN4UFnEr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pkc3nfX52eVBzXCdWptRSa2KHw2DBZCG6gd5cZmiEYgEpXnmuNMsXfiIxk5Y/msX6
	 p5j/lndEaLjPASIZVC7j9iVSVYOPu4/DENabqbrR3zsaq7yKzwagKejJ43SiQgeVb1
	 tEzIUi2yPF7S94r8fx3Fm8zCF1zxsFP6jiX7/FarOoBaD3PQDePCicrNxl4G0TVDL0
	 mxB3FauVNSD5vqBDIDTzCVRIJ5unFSnQvnmsIaXG0dpEZZX67so4t9/K42gu4jSlwM
	 N/84h/SxB8tAz4ETOakvx/5DrkbLTUUkzxzcAvQzAXaWQsjBUtjz1/OkmIAAKTK/Ob
	 O0XFVeIAHIDUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 386/715] pinctrl: renesas: rzg2l: Fix locking in rzg2l_dt_subnode_to_map()
Date: Sun, 24 Mar 2024 18:29:25 -0400
Message-ID: <20240324223455.1342824-387-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit bd433c25ca81b2ac6dca7ea288a8474eea4fb8a0 ]

Commit d3aaa7203a17 ("pinctrl: renesas: rzg2l: Add pin configuration
support for pinmux groups") introduced the possibility to parse pin
configuration for pinmux groups. It did that by calling
rzg2l_map_add_config() at the end of rzg2l_dt_subnode_to_map() and
jumping to the remove_group label in case rzg2l_map_add_config() failed.
But if that happens, the mutex will already be unlocked, thus this it will
lead to double mutex unlock operation. To fix this move the
rzg2l_map_add_config() call just after all the name argument is ready and
before the mutex is locked. There is no harm in doing this, as this only
parses the data from device tree that will be further processed by
pinctrl core code.

Fixes: d3aaa7203a17 ("pinctrl: renesas: rzg2l: Add pin configuration support for pinmux groups")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/f8c3a3a0-7c48-4e40-8af0-ed4e9d9b049f@moroto.mountain
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240115153453.99226-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 80fb5011c7bbc..01ef6921cb35c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -447,6 +447,16 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		name = np->name;
 	}
 
+	if (num_configs) {
+		ret = rzg2l_map_add_config(&maps[idx], name,
+					   PIN_MAP_TYPE_CONFIGS_GROUP,
+					   configs, num_configs);
+		if (ret < 0)
+			goto done;
+
+		idx++;
+	}
+
 	mutex_lock(&pctrl->mutex);
 
 	/* Register a single pin group listing all the pins we read from DT */
@@ -474,16 +484,6 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	maps[idx].data.mux.function = name;
 	idx++;
 
-	if (num_configs) {
-		ret = rzg2l_map_add_config(&maps[idx], name,
-					   PIN_MAP_TYPE_CONFIGS_GROUP,
-					   configs, num_configs);
-		if (ret < 0)
-			goto remove_group;
-
-		idx++;
-	}
-
 	dev_dbg(pctrl->dev, "Parsed %pOF with %d pins\n", np, num_pinmux);
 	ret = 0;
 	goto done;
-- 
2.43.0


