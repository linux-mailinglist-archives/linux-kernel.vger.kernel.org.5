Return-Path: <linux-kernel+bounces-115298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF5889A89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597C11C33383
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F61D4C64;
	Mon, 25 Mar 2024 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpX9cKzE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A898762FF;
	Sun, 24 Mar 2024 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320489; cv=none; b=RkKQDQf4AwgKxc5JDwKjlGZVEgHwRi+2ESLMd7UL01jEwu1Xzbx8wUFdJhBKlv4Hg+RFj/y3NBVIcfgYYfFgM9qIOSpFMYpiWVFgIlFOisWnkLkRHtSnwADyTdT1IUWOkhcwrkhrr+H9JKJahG5PtOjCBKV8f14tJMqOsoQ5AcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320489; c=relaxed/simple;
	bh=YpUu2CjLMI0+YD/GN0Etjr06QCUFEP9kP/OYotHlol0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsZoM6iWFA/HSecHoFCUyKQvGCTy32w+fDHVmafXG4zewoxQvcJiWAS82iKV6LQtUMXK2wheiyjgWo2067DEmAc9FBaQ1nw7m+YZBbAfBzqdhRU/QPyLahg6mv502fgIyQN4OQj6TXT0VCbim/yO28eN6ENnMmioo5gkB6epQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpX9cKzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70837C43390;
	Sun, 24 Mar 2024 22:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320489;
	bh=YpUu2CjLMI0+YD/GN0Etjr06QCUFEP9kP/OYotHlol0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpX9cKzEI3aCPFmh0A+oSutEGqKNceuE59ONrRui4OMDBs1yHuTxSNZZdB0EMkWVM
	 0mUL3bPGJpTz3m2uEg9Vl8Wg+l9Az8IKl5deKsczJr/1YHQH5P0mT+Bjig0OYOE9sf
	 RaRmbvLpeUEwit8Y7JPZRBNUnwiENSzLpoy8rP0gMFfazeLAq4+amHyI3QSGbV2d0A
	 fcboWCdSaoN9R5YylojQRNSuJdN0R+4vFC4pQBj5rKfns+g50NSPNUzztCa6h8nRVA
	 +PunPRNQ8FsZRU4PNfByOYzVOQhsSy3R0izIf48x1g8ga4XbmGYx8RXP1ARACj22Od
	 ua3fC63YJWifg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 048/713] regulator: max5970: Fix regulator child node name
Date: Sun, 24 Mar 2024 18:36:14 -0400
Message-ID: <20240324224720.1345309-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


