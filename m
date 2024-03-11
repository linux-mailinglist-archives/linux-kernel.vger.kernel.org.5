Return-Path: <linux-kernel+bounces-99087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5023878349
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA411F277AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEAC60B8E;
	Mon, 11 Mar 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtLV1Wq8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC526089D;
	Mon, 11 Mar 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170021; cv=none; b=VnKWN1qr8nsa4lWuL3t0tFVe0YiT5WBURlnm714zihK6sco69XuoSTXmi9LGMU4WLRMOCIcIAlr+RWQSIWpgXM7RhEQ1aUQz9Qm+DweFtRp/6uTNM/6szETwL2Om5xdmcV4hBXGI0HKzY5kjeTusSjt/aUKo+yHHMcAnzxkbxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170021; c=relaxed/simple;
	bh=yxJXJBt2rnE90+EW1MbwMjyYjD3W0qZ618LNmt+sM4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXqNF2prj4mIHTQU5DVQf7ItBDeQEmiQbhHDXe++oK6PmEiGtfgFSvO3kcixNZ822zMQhyFo5P+4cINKkhr+vh6dATfxqWqmSU5in8wK1CJPAcFvIhCtFs/p8Tr4yRHPjr06PCVisdjvYumdDrKy44GC7U5+zKDxwK68JeIA9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtLV1Wq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388E5C433C7;
	Mon, 11 Mar 2024 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170021;
	bh=yxJXJBt2rnE90+EW1MbwMjyYjD3W0qZ618LNmt+sM4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtLV1Wq8/Y/ZfBMzuk0ywzLzKa9e0vJTgQlkk1oWnQiUSbq42R4BEyGByQh58nUY2
	 CaLxxoZazvzAJG1i4Iw0Jnul4EB9AUEx64i69ZbsNvumRXaL2wIIjvS3qyK38e0O4n
	 dXH6ynINmcmsDXf8yom/G4IxHV+odo0+KXfhYOryqB5J0RDEurtivg2OjxfsX19N1t
	 O5rJ6xCq/IWovMicNztl8YsXAtQLImNALcCoFW7tkhesIaBf0VuGzpzqdqVIWgwbf/
	 QBxUmGvZEOW44QRGuP3ePY9GE08JbVKniRtXFyO8O9rwTmfFRpf4Opg9rtg32xOl1U
	 Im/6O6FemGC4A==
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
Subject: [PATCH AUTOSEL 6.6 13/17] ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2
Date: Mon, 11 Mar 2024 11:13:04 -0400
Message-ID: <20240311151314.317776-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151314.317776-1-sashal@kernel.org>
References: <20240311151314.317776-1-sashal@kernel.org>
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
index 17c8ff7558694..de0d399eae8c4 100644
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


