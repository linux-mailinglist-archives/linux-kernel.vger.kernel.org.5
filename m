Return-Path: <linux-kernel+bounces-130314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0D8977E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262E2B31EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770AD15B11F;
	Wed,  3 Apr 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrB/31Fe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72381553B4;
	Wed,  3 Apr 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164717; cv=none; b=qIP/p6O4GOuSfGadPZC94eBwLQxnyCdPknEKvFUx9qSHJbK6VAU7PF9vg4Am1aEnCZzJcIa6PwNp4uSCMYuAukYxKx8wRXctji49quAI1YowSe5fK9DFYLNsTMYiFhCYe3ywtpJfgFNKy9ltq3zFVN++vF53jlKYyWMBMrvdM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164717; c=relaxed/simple;
	bh=coJFkm5Kd2MRvJi2hKagDToOoEIiF9f/Hj1LGH0wG88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFqvzS9rv+LNht4CG7+6uPdfVnnUHwU0Ypdbn7L8g7YjTwu1nXPTqvsaCLwuB8Bga0wyHmC5LLWdcfB+A3zpauR5jouLl9MaTUyeaP0YSAems0yPCjuMBBJjWbGTI8Hktr6SNmV/8GWXpQQehU1vW2bI7gyEycq2ZCBpcE0PNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrB/31Fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0525C433F1;
	Wed,  3 Apr 2024 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164717;
	bh=coJFkm5Kd2MRvJi2hKagDToOoEIiF9f/Hj1LGH0wG88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UrB/31FeCcDy8sZEBOEnankviclt6cNmJPoVbq6QBHaona5QxUkOde0AMbDwUBfH3
	 cfQthThsII+UrCuy5sXPbBXcsYdLmNUSzw49YOLggy85QoUQpXhwXsHO284mXr9cli
	 mVnJSXRYKHXd0E4iedLs7KkVwTOFg6AiPbtGGW8h6up62xSSYHWWcxzOM4WmCOg0cC
	 B1tVKyMCvKmki4VJIwOUjaWWJZtxYUpGghrBjCmlAR8UZ2pxvyQsEkxtYaZaPzhcmr
	 xywRiKtVSLF5Yrmzzc+7qRzUtvG3yBj9nmIj6GDwmOzZsJEFm+bdGEIiZpuIRhtAt8
	 vSCd0kVFeKCeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: M Cooley <m.cooley.198@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	jeremy@system76.com,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/20] ASoC: amd: yc: Fix non-functional mic on ASUS M7600RE
Date: Wed,  3 Apr 2024 13:17:51 -0400
Message-ID: <20240403171815.342668-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
Content-Transfer-Encoding: 8bit

From: M Cooley <m.cooley.198@gmail.com>

[ Upstream commit db185362fca554b201e2c62beb15a02bb39a064b ]

The ASUS M7600RE (Vivobook Pro 16X OLED) needs a quirks-table entry for the
internal microphone to function properly.

Signed-off-by: Mitch Cooley <m.cooley.198@gmail.com>

Link: https://msgid.link/r/CALijGznExWW4fujNWwMzmn_K=wo96sGzV_2VkT7NjvEUdkg7Gw@mail.gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 80ad60d485ea0..c47362afc9432 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -297,6 +297,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M7600RE"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


