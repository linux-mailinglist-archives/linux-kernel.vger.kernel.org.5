Return-Path: <linux-kernel+bounces-124972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0E9891E64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4478F1F216E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7E1ACBCF;
	Fri, 29 Mar 2024 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSki5JRF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AB1ACBDC;
	Fri, 29 Mar 2024 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716545; cv=none; b=VXbzRMPjC+fRNTgGnp8il5JxYGqS3wNmxY4XPE0NN4lDj3oPozzu7X4Py4Sucd9sFDNNqiBFzgdro7w/dHNblZrNpCE6+AiW/V1kPQldszzK9BKMXaDW40GxU4pr722yG9LyP6jR66PkwgA/qp5wvcPsEhQW7VaSvEPBApB6pJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716545; c=relaxed/simple;
	bh=2uwCHh7IWEliOMQHyqYLK0bE6QOlmtBAJmOCypS98x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzh0iNBPXkuepdXyvnDuIFUef8dNTNHEswkoz9rPL1B1kmGOM6UhpmeeSp5njqlo5TPD0OSlk89vKnJdvqENiTim/wH2zBFX8KFDvr3D2Ijdbvujvd/FLwdcS9SXv/ypNhbBe7FUAwynz0tX9QWEfZUxw+b+G54JFoF67JDC7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSki5JRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320C5C43394;
	Fri, 29 Mar 2024 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716545;
	bh=2uwCHh7IWEliOMQHyqYLK0bE6QOlmtBAJmOCypS98x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSki5JRFolnUyJy8HcV4bz19muOldP+qxeVPfTJed8kAvRRg5NjdLr6puCxYOpL8j
	 ZwJJUAdrBWhUGwPHC31jm8LqhFbq2jJKFtw5G0Xj4NlvJuIP8WGPI1V/VKwwgmyhPL
	 aj9chnVdp5k9tCW7gsmR56ZVslFvevEjwfo3duUIEVLXumltUP7ihQOXWOqHZfu666
	 SwqsMNmeA5DUHyFoGVJ7VkGrMxnKE06i4t+oXCZmJpYpB9yYIneDpfBB6tKBOwyMvt
	 AM3S8EwJfnc98SgdTYuAw8+PbneokxHkS5fZ9+JEDvMtCu48hqTAuMAf+D41fSQE1R
	 b1/eYw3/04SKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/31] pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs
Date: Fri, 29 Mar 2024 08:48:19 -0400
Message-ID: <20240329124903.3093161-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 54f1a7334027a..c390854483680 100644
--- a/drivers/pinctrl/renesas/core.c
+++ b/drivers/pinctrl/renesas/core.c
@@ -868,9 +868,11 @@ static void __init sh_pfc_check_cfg_reg(const char *drvname,
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


