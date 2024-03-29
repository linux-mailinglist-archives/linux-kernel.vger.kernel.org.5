Return-Path: <linux-kernel+bounces-124723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E03891BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D191C26A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6CE1779A1;
	Fri, 29 Mar 2024 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BS4Yh9tZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DAD177990;
	Fri, 29 Mar 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716014; cv=none; b=jr0IB+lJL/T/XFLYavnxDJ78hN27apMmWyd6VZK3O8GlKsrrgyGwrxzwL85jrF5UtEBdX9/C3uZV4wBF0Kk9d3Ads/EiwX4F6MboVuwnjtTwEdZtcqyeMwwbT5OUi2QYV3WQzbxZ/IxpNwISilaxYZnrRrlT1CBuB85Lk3XwSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716014; c=relaxed/simple;
	bh=/7Nyd0ElNKtUa/fFvXgp1vH0TNWpn4B6Fz4DJsTV25g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDrB56u+XUZgb0yDUpxqoU7jN5vdXfmmsgECIaihEvItjIgvQ6MQAufvzwZkNp0V0jMP2nHqCtO7hEg4GX17TjIbqltuSKLRQhTErae15loTh68yqWDeIizAPOjGh0n+BOy6shTIbLP6bIqnbagOeY9Rlc1GKcMaRbaic4ozfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BS4Yh9tZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4058C433C7;
	Fri, 29 Mar 2024 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716013;
	bh=/7Nyd0ElNKtUa/fFvXgp1vH0TNWpn4B6Fz4DJsTV25g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BS4Yh9tZFMZUkYmRUqYXd8ZBc4LdwR+/blN5/imqFeUTTaKUMH51LfHTpevb1Y/EU
	 rW80c4pW9C3AfDVvOh8vtB1j/zEa+Yp9RK/nj2JepuqVSHclEg9dW/PzDB+fL+OFGH
	 /etDCkQXDwcU8TbfnNoaPQgB8tifH628rCah0AI6XjRlxeG0xEPp4PGTgZM2OIqduA
	 /kYIct8ujbed1An7zAifKt9/nyXpuRM9jyZm97a8sITr+uKV0KsET3juW4pTvZFUaK
	 A253B9cfcmf8dqlgbZZfDLZ8GdaGLIUB0P5zF9h8yPcb1Wt1Hsl0/hZ6HKV01dVNIA
	 dha2CtlA4Z4Hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 14/98] pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs
Date: Fri, 29 Mar 2024 08:36:45 -0400
Message-ID: <20240329123919.3087149-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3803584a4e9b65bb5b013f862f55c5055aa86c25 ]

If the number of provided enum IDs in a variable width config register
description does not match the expected number, the checker uses the
expected number for validating the individual enum IDs.

However, this may cause out-of-bounds accesses on the array holding the
enum IDs, leading to bogus enum_id conflict warnings.  Worse, if the bug
is an incorrect bit field description (e.g. accidentally using "12"
instead of "-12" for a reserved field), thousands of warnings may be
printed, overflowing the kernel log buffer.

Fix this by limiting the enum ID check to the number of provided enum
IDs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/c7385f44f2faebb8856bcbb4e908d846fc1531fb.1705930809.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/core.c b/drivers/pinctrl/renesas/core.c
index 93e51abbf519a..8f6d7cc25b599 100644
--- a/drivers/pinctrl/renesas/core.c
+++ b/drivers/pinctrl/renesas/core.c
@@ -907,9 +907,11 @@ static void __init sh_pfc_check_cfg_reg(const char *drvname,
 		sh_pfc_err("reg 0x%x: var_field_width declares %u instead of %u bits\n",
 			   cfg_reg->reg, rw, cfg_reg->reg_width);
 
-	if (n != cfg_reg->nr_enum_ids)
+	if (n != cfg_reg->nr_enum_ids) {
 		sh_pfc_err("reg 0x%x: enum_ids[] has %u instead of %u values\n",
 			   cfg_reg->reg, cfg_reg->nr_enum_ids, n);
+		n = cfg_reg->nr_enum_ids;
+	}
 
 check_enum_ids:
 	sh_pfc_check_reg_enums(drvname, cfg_reg->reg, cfg_reg->enum_ids, n);
-- 
2.43.0


