Return-Path: <linux-kernel+bounces-124817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB8891CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFA81C25A54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D60019F53D;
	Fri, 29 Mar 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2MJBKF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8D19F52A;
	Fri, 29 Mar 2024 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716225; cv=none; b=ZRJ1l1zFibzBQhbEzpTx1vNk+xVt3gQSMH3BYQLz+rOwEuvJGd/DoIsWf40aDN1skWw0XLFhfIubgktnrDDReQObvpdXID+YLU0n7mwrSkiSsBBdSbEUV1qgKboBELM2NEW/bl3C55Y+kie6BYy7WS45Qv/aB7pH+iP63UntHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716225; c=relaxed/simple;
	bh=/7Nyd0ElNKtUa/fFvXgp1vH0TNWpn4B6Fz4DJsTV25g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O95leu0A8DWqpm4AcM1+uHBg+HWysDW8cvbB2zouChKNGXVYiL8QcQrTc1Ws8yDkHGE/Qhq56y8K/F2zNVgscZHiEkNEXdTLWmI9m5Ek+/dzRRCOGszznhCci66ZFnpU8JiR9pfJdnjqZ1Ql6LihBX2S8yVixGztZlTPg61PpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2MJBKF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78461C433C7;
	Fri, 29 Mar 2024 12:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716225;
	bh=/7Nyd0ElNKtUa/fFvXgp1vH0TNWpn4B6Fz4DJsTV25g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2MJBKF4KCZyE++ZVxKHyJKCwhM14CvVXuRhsooJcECp7QXF0ENfn7ovRoTLgCw3B
	 ElST9qDaQTAgLdHO4xDs9NogGhtmJIkwjcTD7rWX0BvX+/Dr5tCtebnzu2VoXdME/g
	 Kge316P8E1N8GCS8RQtrVwd+1BfCk5/Jf21b+o1rKdwbNAVuYZJ11vZo3tQZmmmorI
	 h0QSqv8NcJtk5ctvkVdpRKWMm6QBbzGX3Tg6BYHrO//QrI0NeGn79PRymAEWLkaewm
	 T7lhWTfJZSHQs8ntNuTVG4qOFjyRNKHsWhwQRg8B0U5SV0rkEkybJQ1eafuIM5X7/W
	 jwxhU1ERlIkMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/75] pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs
Date: Fri, 29 Mar 2024 08:41:49 -0400
Message-ID: <20240329124330.3089520-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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


