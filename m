Return-Path: <linux-kernel+bounces-86990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C70086CDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFAA9B276F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B067214291E;
	Thu, 29 Feb 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRpcs+Th"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D721428E8;
	Thu, 29 Feb 2024 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221816; cv=none; b=oGoPTbxq4ISRLMpVKVgW2inNLC7C3rJxUeVa/bizJkO24l6owLZ9K0S2Bo5AOeCfZmaO8vcU6ZSeiVU23PMjOsS46+QldYRCwLFF8ax9JO4VuI/YFrGSewljl7+CjLlVjQeQA0Q6pqfxDUpmmUBArNLUqo9MEcuKMl/skzPJfmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221816; c=relaxed/simple;
	bh=sV5eEL/l9z12NIBJM4xwgsZ2FyHlykYtZqQbqeFukpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cx6eEuo7o0rIAdqGP9PNV7Es9ppMx0x9c16SbdNkcpGUmohfSn/2gVFqPBSWQgDfK6ovcSQSjMTyKG8hu0Cg8bFCdjSwNBy2WDpdI5i47GCluEtveU6j3vfSrbYmVzDfB16j4/TOchwqRKb0romWZD/9eTSLHerXFpqkofSqRvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRpcs+Th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8D1C433C7;
	Thu, 29 Feb 2024 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221815;
	bh=sV5eEL/l9z12NIBJM4xwgsZ2FyHlykYtZqQbqeFukpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRpcs+ThV5eMeDN9etBib+x3LbDToJsDxQ4yIoMHWPk8ub0FCqayA9MB7C7Lrfmf+
	 Rc21Tn88taeP5uybxca+64HdRJ/y2saH+JdXMsSKMqwZr15h2P9Wshe75DsOcVnoeI
	 768XKDcaBaQTL4MDsa5DsuigEytxPISVxovTslTuyR21ZXqeWDaHMgxSYwDFRyqewi
	 /SN1x2pBbPWzd848J9PSY3eXB5JWAobqX/0QzUzmQPDjLSMbgI8PyvJcoAwFA0Zp7p
	 X35iwBjS42aMU54mxER3nW6u7jwpvRh4i/oBsiWGw1nX1RsiewtOawYGCZlHoaBzVM
	 JsQSJz3FL+f+g==
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
Subject: [PATCH AUTOSEL 6.6 15/21] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
Date: Thu, 29 Feb 2024 10:49:35 -0500
Message-ID: <20240229154946.2850012-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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
index d83cb6e4c62ae..8eb5f8e2b5f85 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -234,6 +234,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82UG"),
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


