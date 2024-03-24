Return-Path: <linux-kernel+bounces-115773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5738894A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679081F33B21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6782436D0F6;
	Mon, 25 Mar 2024 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smo4iNQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17A1448C8;
	Sun, 24 Mar 2024 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321973; cv=none; b=p6SEwMdrlP/+IAe+tY2aRExI5T5mpb0nqLiE+Mwe9xVGjpiOx0rHOkfFm8BHVXJHeSl3Vrkq3RlNxB8VDw90NRlXHyT2UYIfLL5/vv2Y9YoKyhVuOs8CCKdxkIcRDxAp959gOA7kMTgROEqXXtEvGsaHkO3pAh6VlGTEYYsy5ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321973; c=relaxed/simple;
	bh=9kUUdf+AjWFvFSiEOTqGVjiPX8FFD9m8l8eaQutwhnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbkoYnAG/Pl8Fq8OOwBNBZvgq0R8Y4ewHbkLW7mPoMtj3n5Le/6jMZRfKzUNiH+3tB+m07a+Pxkki5NbLkdv0gxv5BO1imMblVdsOMPviGo4BaMamadL6wBXxxYiovo/bnWk9Ge53jrekv/Sw5o4WUWBVwy2HLC95izxHFZcACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smo4iNQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AFAC43394;
	Sun, 24 Mar 2024 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321972;
	bh=9kUUdf+AjWFvFSiEOTqGVjiPX8FFD9m8l8eaQutwhnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smo4iNQBsjd9IqKOAy0dP/tm4Ft8dE0iVa6S7W25gue9BLI5lIjwWCnJuZbh/FCZD
	 FLtJlUVrhNTVx6dDOk+mGQtUAN3qhbtXgU/XkXuSlAzESfYdGzVwWCg1Bw7juHZ7RC
	 LfhoYsIV98a/lE6lHzIZEVHWsUhLr6VkGaVJ1tGnP9N17yF7wt+taAzhB8v8cgI9du
	 rlOvTjKtpEUu+0Xg5B/WBp5+GkjN483DyxLb0BPdy+gmdJ560FWsq3DKKH3qTgpq1h
	 9ZksmCUOwywTIXwj8OEOpnAAX8+vUHMGZ1SII3iyTv2m9xAk6mCjzpT7LdPpeTmClU
	 g/d+nSDn84GoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johnny Hsieh <mnixry@outlook.com>,
	linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 044/451] ASoC: amd: yc: Add Lenovo ThinkBook 21J0 into DMI quirk table
Date: Sun, 24 Mar 2024 19:05:20 -0400
Message-ID: <20240324231207.1351418-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 5921af7fd92c5..0568e64d10150 100644
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


