Return-Path: <linux-kernel+bounces-87003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3386CE21
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27CC1F2214B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688814EA53;
	Thu, 29 Feb 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5tXujd5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98241504F2;
	Thu, 29 Feb 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221846; cv=none; b=V0MqdvOABmMiTHy7ZQ6ixHSyqFo6i0YydI893dQGUBp6ECDCMZEqxS2/Ba6zMFnWFebdI7p5hSDOV6/U/7qTz4lmcqfxQVdwqvHsPg3YvLKXlE3DfrTRFxjhBRUNvx8YeCktTwbp+CPX1NsvvZ2Yx3BXXUpxc6wUahoBHq6Ku4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221846; c=relaxed/simple;
	bh=cXqc0s8jWv3m+juKpMKGwUKVhtDeTSLv/yo9mPFkS9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaQhg+Tg1ALehN9s+XzkKHxibtQdcfspDCnDIudpb0a+71oFpzYAnW/Ajsd13FxlFPbMMTiVyusT0jRFUDuuUI1GO2KOXPh3+B9H9T2NvTG08iQbXM5GJs57ayOoXINibMTqKVgQF41F1I+ovqTCb/cxHFhvlaninxpFEioBJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5tXujd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE1BC43330;
	Thu, 29 Feb 2024 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221845;
	bh=cXqc0s8jWv3m+juKpMKGwUKVhtDeTSLv/yo9mPFkS9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5tXujd5qhgGT8Z8rBTZJ5INrJcOX7OhYtGqUVSu88bjFSPY5d3xDqfPDTm/O7J9l
	 lByJ0WjcuYGKRz6oi2kULEcG+HXpjWgit361ftu6te2dLeb6COPlvZzb5EkTENKCC0
	 QIHAVfUPpmn7oRgAnWhfLy/86kkhbsWFdjqjNv2YzcxqJynZpX4gJgWjsWX7eF37cz
	 5VAzaEi5nOoqDIIdp+/7ZpdwGtcrF9de5wLwz0fmbBvviqk+qBejMFLHFCFnI8Dqmq
	 +2ALzE+aHHHyGQRCDtKpDnEXLHuVC6IUIJy4+g6FVtGdrxnXbEZpSnDDiW9dVc2sca
	 YRG4WYybuPCuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	jeremy@system76.com,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/12] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
Date: Thu, 29 Feb 2024 10:50:24 -0500
Message-ID: <20240229155032.2850566-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155032.2850566-1-sashal@kernel.org>
References: <20240229155032.2850566-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
Content-Transfer-Encoding: 8bit

From: Attila Tőkés <attitokes@gmail.com>

[ Upstream commit f7fe85b229bc30cb5dc95b4e9015a601c9e3a8cd ]

Like many other models, the Lenovo 82UU (Yoga Slim 7 Pro 14ARH7)
needs a quirk entry for the internal microphone to function.

Signed-off-by: Attila Tőkés <attitokes@gmail.com>
Link: https://msgid.link/r/20240210193638.144028-1-attitokes@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 808d002826233..c4b72101b6472 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -227,6 +227,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82UU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


