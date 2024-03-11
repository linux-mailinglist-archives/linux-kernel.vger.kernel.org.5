Return-Path: <linux-kernel+bounces-99074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D54D878325
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC3AEB21AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C141A44C7C;
	Mon, 11 Mar 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQlQ3Lde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8E59B40;
	Mon, 11 Mar 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169997; cv=none; b=Ps2oGiq+oUJ+D2HRUWKeX5r6630y4wzoIWKEjLP2QVLIo1aU+yP9DwcKdqQaew6ytwEaC+lj1AXfAhtDw3Ay55if0CGit55fLGWcNNIqCBMJPhQ7Bu2GFFb54xWbSxOaEymUs4IE1M88Qjp8i7EU5owOwkPgBrY6L4w5AmQo+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169997; c=relaxed/simple;
	bh=dvp3JZnerkFLlEWRHHtB5NZ0FgULvDL+8ioxJBeGMeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTbETTymn5aoMdie/8qGpxnDQN8p8nM7UkSJNO07ZZ903ocpUw9ofQJ3PLYnlG7kDgKLxRDDuin89AT+8y1l9Rcmy3wBPfUcjKXhWECDObC9mdRQI/qTImGZELHqrcKL8CJOdGgixU11dgMMmewtk4gMGpO5PVuyS/HoDp2qFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQlQ3Lde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BCEC43390;
	Mon, 11 Mar 2024 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169996;
	bh=dvp3JZnerkFLlEWRHHtB5NZ0FgULvDL+8ioxJBeGMeg=;
	h=From:To:Cc:Subject:Date:From;
	b=jQlQ3LdeMm1nL8lowGycCqNvzqdqSBKRgRRXk50Dbb2DpP9359mzrdiCdYwH/Zo+U
	 FzZ7jZme9UYGWeReaSp7vDu5LadDvw3INllV02bOvvAdNGJh74hLV+OT8s3fE+cTcy
	 u67jiH9vxb6IsS54vVrbKVPcB3HLhpdvol1SciSNWJQDbDt3dKVbNXUB2MBmLiZALD
	 wIXAff1DKUqSu6X/Yaq/27d6HcUfyBZsknNPWDdbQZzEFy0SfTx7GCNCDoZ0oWXsh+
	 mQ1HDNLMRceY/J/jElAgbwO8IMQSAvd5VGzsPFeiX0Cvghbr2QZnPJhcNirAYxdIEZ
	 DqjbXW353Nktg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.6 01/17] regulator: max5970: Fix regulator child node name
Date: Mon, 11 Mar 2024 11:12:52 -0400
Message-ID: <20240311151314.317776-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
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


