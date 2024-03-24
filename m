Return-Path: <linux-kernel+bounces-114038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3F5888F24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8EB1C2B614
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ECA1FC995;
	Sun, 24 Mar 2024 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBVUibvZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC714EC43;
	Sun, 24 Mar 2024 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321320; cv=none; b=QoR1ClPlveyYyOYJsQA7QiBTCmcxSIXWl/3lt3bJRVRm2D1m2OrdG+4t7o4QOKcxZrWWfRdm4ZXY7okePCNDjv6cjN5U+6QBvC8cEADOLpnifnNhuPPqDChJZQnUHm8WoKmpoyPM93VXd0PMBF6Fqo5SCR9or3sJejdu0OaEqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321320; c=relaxed/simple;
	bh=dvp3JZnerkFLlEWRHHtB5NZ0FgULvDL+8ioxJBeGMeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDVT7w07bYRepmze5Okn0z4Pf3SNco3vJ8MEWUu9pAekbsOMFn29waglqlttF+ppcGt1mIHnRQPyL6kHusrFsV92rFPJWjg6znB9mmi8c64FycA799dVFhBo6hsrsZJisXQnVrVIVn66/IxheRlsl7xrZNqcvedN+dpW/DvYnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBVUibvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C42AC433C7;
	Sun, 24 Mar 2024 23:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321319;
	bh=dvp3JZnerkFLlEWRHHtB5NZ0FgULvDL+8ioxJBeGMeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBVUibvZ6ei60oT41deCfGvnTSJCkxtHm9vxvTMuDMqlDUTYYXHUoafaMCn2U8NdN
	 5yMWCiaQgwQbAPU0LqYG+uEsPBwUM2mTwyj4010n2WvcsQcrwwrbg8wEXcZDE7vFLp
	 gGmidAEqZ48SwcWP9dfNaj0KhHlsqLgUmwtvsRHfFpHTc+knGwYRYNoWPKfYoMp0vg
	 1Qv1pOzshaMFV4qQ5/bbD09sOvox8ZGQe9wCRsVA8cccgQmaBQbvPNQNIPUDURAoM7
	 UQ4Z0diNSEN+D2H46Ri/3Yfy0fG9OHi+Rgm+WZgSWL57mrqtqdKVBrRgzXi9yu/tgk
	 FPr7ctz8vQylw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 042/638] regulator: max5970: Fix regulator child node name
Date: Sun, 24 Mar 2024 18:51:19 -0400
Message-ID: <20240324230116.1348576-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Naresh Solanki <naresh.solanki@9elements.com>

[ Upstream commit e5d40e9afd84cec01cdbbbfe62d52f89959ab3ee ]

Update regulator child node name to lower case i.e., sw0 & sw1 as
descibed in max5970 dt binding.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Link: https://msgid.link/r/20240213145801.2564518-1-naresh.solanki@9elements.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/max5970-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
index 5c2d49ae332fb..4362f332f746b 100644
--- a/drivers/regulator/max5970-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -28,8 +28,8 @@ struct max5970_regulator {
 };
 
 enum max597x_regulator_id {
-	MAX597X_SW0,
-	MAX597X_SW1,
+	MAX597X_sw0,
+	MAX597X_sw1,
 };
 
 static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
@@ -251,8 +251,8 @@ static int max597x_dt_parse(struct device_node *np,
 }
 
 static const struct regulator_desc regulators[] = {
-	MAX597X_SWITCH(SW0, MAX5970_REG_CHXEN, 0, "vss1"),
-	MAX597X_SWITCH(SW1, MAX5970_REG_CHXEN, 1, "vss2"),
+	MAX597X_SWITCH(sw0, MAX5970_REG_CHXEN, 0, "vss1"),
+	MAX597X_SWITCH(sw1, MAX5970_REG_CHXEN, 1, "vss2"),
 };
 
 static int max597x_regmap_read_clear(struct regmap *map, unsigned int reg,
-- 
2.43.0


