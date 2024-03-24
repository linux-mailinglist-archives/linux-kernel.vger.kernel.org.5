Return-Path: <linux-kernel+bounces-114043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64429888F26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A351C2B615
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C708E14A4F8;
	Sun, 24 Mar 2024 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq2qDmAJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2C128810;
	Sun, 24 Mar 2024 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321326; cv=none; b=R6ui6FP+8sUGC3lXOav2bJlROXlRPklEnlBVA6sU8xbZsdBYjKa9Sa+g6UYHVrIEphJaEIOcZ9gV3ILHI/uG/1ukLcE8lhIUt2c/V6FTJLw+r7qXFNaRCSCwTp6iM265dw/YmFot06wtGJwfVpqazP1sODM1r7TzVw/g3XPd9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321326; c=relaxed/simple;
	bh=oZM8KMIQOEe1NkhuP82yx6UpYRUZXW+a3NEGlch/gKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6c4vH1grCWAMqRoUXskVPH6ROvQC5In2R3N8kESdCSqpvxvAUsWn5C49e4/12Zge2V8AM/1+zCq76H2QC0Uj1f665T0UiZDrCWJ9sMk1a+onPG3v3ZjVRyE1FxkH5pT0fO49SdMQ3YGYIQQUJU05m7CBKwJI/xPfghlOavcPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq2qDmAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637B5C43399;
	Sun, 24 Mar 2024 23:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321325;
	bh=oZM8KMIQOEe1NkhuP82yx6UpYRUZXW+a3NEGlch/gKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jq2qDmAJAtt0KGKnWJSvo63HvXpTHAye559qGfyR06Jb5muLCVikOL05+GCLZRBFX
	 izkLeSy3QnHqqNUOjnqPYfb3cr5a0tz+zZ49RUt8fjZueQdmcZM/uwCHoAra2Vc6zp
	 YD36AF4P99PYN8ZBUnuKs1RopHtVupwQ2CU9rPwZusA9WSh/i9xwqgWBGx5QWeTWJO
	 hWVQ9+40qUJ086bmRCMUeu1mh7MMb8yLEOo6B7BvNYGaAths7m3Fh31Zg+AswD9UWU
	 fM7yLZEksVStCC68IAT7pF6pmxcPgmJGSSvz1INdtpzfGv7dDSlGXVcgMZGwjphHmA
	 eX6mRnOPxWGkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johnny Hsieh <mnixry@outlook.com>,
	linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 048/638] ASoC: amd: yc: Add Lenovo ThinkBook 21J0 into DMI quirk table
Date: Sun, 24 Mar 2024 18:51:25 -0400
Message-ID: <20240324230116.1348576-49-sashal@kernel.org>
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

From: Johnny Hsieh <mnixry@outlook.com>

[ Upstream commit 50ee641643dd0f46702e9a99354398196e1734c2 ]

This patch adds Lenovo 21J0 (ThinkBook 16 G5+ ARP) to the DMI quirks table
to enable internal microphone array.

Cc: linux-sound@vger.kernel.org
Signed-off-by: Johnny Hsieh <mnixry@outlook.com>
Link: https://msgid.link/r/TYSPR04MB8429D62DFDB6727866ECF1DEC55A2@TYSPR04MB8429.apcprd04.prod.outlook.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index cc231185d72c3..5587198751daa 100644
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
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J0"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


