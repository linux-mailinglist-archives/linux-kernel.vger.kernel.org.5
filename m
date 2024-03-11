Return-Path: <linux-kernel+bounces-99101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB8A878371
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA0BB22273
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB234482E1;
	Mon, 11 Mar 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m20DvlWs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB164A96;
	Mon, 11 Mar 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170057; cv=none; b=DtlXd8ocBKw0PypujQt79Gj/G/bN/KIuMbSnmDA5ra4kRsQ4yBqPO3mNfnJy75dH+2Y2iDV2l3TIeJINGFcyiAxLuV3VbN7a7Wvc9sOSj/izNAflCWwZnw0mtaVfXUPNXeT7WgnJYFB+qurJxnO9cLmUdWoZX7MADtULRcmuqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170057; c=relaxed/simple;
	bh=UMBVxqs4Eubdf2xYnwCyDF4DHhJ829haCPshuZ+K4Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB9dhWV5zHhmCpEud1LFj3c/qfcvUqjoyzeYeS+YKqTXz0La8aVFeGzekReC5ZCGgbab2S/3KUr21QznDgjos/iNm3PjYlvMu0y0DJsBNRSsCvhBg/Y5Aw7hEA65DhZdhkJ6p9O2HGH6DF4ML12vvT0cYIkudhjTbP0IWoBSCHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m20DvlWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4D2C433F1;
	Mon, 11 Mar 2024 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170056;
	bh=UMBVxqs4Eubdf2xYnwCyDF4DHhJ829haCPshuZ+K4Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m20DvlWs6ucCgY4bHugiU+HRFDaZrgYGDfXDau3jAB/W8heMzBCe80wF5VZxmhY/p
	 mMh+uKzO5kVK5zu/gg+C5EPjA2dHPCFehEY7a2MGnIdQWjw6LY3dkDPCAYid3oHUCo
	 fVpX7Wx0u7pYqMwvfxDRG2xgRQCz/TqvK8y6RlJAdOFYOL/tSyIAYP/wS2mMeArrgE
	 PJHMKEzb2hq+RQzobaK47CVpCSZDhfGawsm35p+pCXlvxJkXbA5idHFGNUMvYhHkho
	 TnmfwQ8hcfHNIv6utCIisGvp3pUOZgL5jUtGobgZ36Jgs7UYcKN9t8XPsFRqJGqmOj
	 P70wOBeET3yrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	jeremy@system76.com,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/13] ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2
Date: Mon, 11 Mar 2024 11:13:45 -0400
Message-ID: <20240311151354.318293-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151354.318293-1-sashal@kernel.org>
References: <20240311151354.318293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
Content-Transfer-Encoding: 8bit

From: Jiawei Wang <me@jwang.link>

[ Upstream commit ed00a6945dc32462c2d3744a3518d2316da66fcc ]

Like many other models, the Lenovo 21J2 (ThinkBook 16 G5+ APO)
needs a quirk entry for the internal microphone to function.

Signed-off-by: Jiawei Wang <me@jwang.link>
Link: https://msgid.link/r/20240228073914.232204-2-me@jwang.link
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 59f72bfec8e1b..dc828ec6f97d6 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -199,6 +199,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J2"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


