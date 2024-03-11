Return-Path: <linux-kernel+bounces-99048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65668782CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1414D1C210AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E941C9D;
	Mon, 11 Mar 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1wyx1qU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D841C92;
	Mon, 11 Mar 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169940; cv=none; b=W+hAog+ptz+mDlkSfq+AIgJ1TllmA5nbpojwg6wfJuj4P+7KuWGWguVn0Hh6W4EoDyPHs0JChl0jhcUHodeJlzdPNEyzFVMkf1Wrzuh8P6J/7gjqhXF/vMnjIC0ZyzHhAld876MDaeDYabViDODJS2vBFMorwywIZ7SJFjA0Uzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169940; c=relaxed/simple;
	bh=YpUu2CjLMI0+YD/GN0Etjr06QCUFEP9kP/OYotHlol0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IB2qx/WeE/Jf+vEXv+Vx8xUp7+kmkya7YrwhhbdEhtWbQAHqZWM/hO994gfTR++obiqdUQr98xTDQjN9yVvFWGap93kB6DRP7jzZOl6HQ8yGAEdlnCQVBP+qXbMrKUAfZX/NT0MkrHCfDL4uYF1IrLl8IGbeafz9uYd90gJJ3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1wyx1qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0C5C433F1;
	Mon, 11 Mar 2024 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169939;
	bh=YpUu2CjLMI0+YD/GN0Etjr06QCUFEP9kP/OYotHlol0=;
	h=From:To:Cc:Subject:Date:From;
	b=T1wyx1qUdvYS4roeV1kesiezTLKphL+Q37Owf9irJZfz7tFyag18gLSll4h5k9uca
	 KvX3Ukt4jRYXkTgyzGWVx42O8p14nqCacdYpyfoRBAxSDXpKidj9hl5M2rUKupzWBi
	 FvY+XoNsuZOqz7SmYejKjXywKZWeluGa+X1uEoLSCsLTZgL6XitZxDNEy5KEENSJGy
	 CzT5izp7ER9QYzVWmsPPU6DMpsry23IEc6/XZxkV40HtWQvfg3nEpTX6kL8895nMdx
	 ig22twxEXOC1qpiOCBnQkB5dxfXMayEz3VqHLHZ0V8YVEFOCwjqWV3xIVIHhuKkF6b
	 MAUfsIWaSQgXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.7 01/23] regulator: max5970: Fix regulator child node name
Date: Mon, 11 Mar 2024 11:11:41 -0400
Message-ID: <20240311151217.317068-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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
index 830a1c4cd7057..8bbcd983a74aa 100644
--- a/drivers/regulator/max5970-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -29,8 +29,8 @@ struct max5970_regulator {
 };
 
 enum max597x_regulator_id {
-	MAX597X_SW0,
-	MAX597X_SW1,
+	MAX597X_sw0,
+	MAX597X_sw1,
 };
 
 static int max5970_read_adc(struct regmap *regmap, int reg, long *val)
@@ -378,8 +378,8 @@ static int max597x_dt_parse(struct device_node *np,
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


