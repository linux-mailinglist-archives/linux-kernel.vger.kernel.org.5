Return-Path: <linux-kernel+bounces-86965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C314386CDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8B0B24B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2AC15D5C1;
	Thu, 29 Feb 2024 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm4uFGdr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EBC15B0E5;
	Thu, 29 Feb 2024 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221763; cv=none; b=ZmGbZZWwLinyzEzmNsQOyjiiCu/to51LWsmRZq4hDnpwDJdMSyy2KZfm5UQHpBJ9KI8q4HCXCFwm1N0Q6EMV9TMiW2SWaYr1GSmIi9uVss9S5r8qfUzGnH0doJXALriSYeuIxwTEQ+Zge98qSXp9UsWFpnaD/zU4ha4CjAT7jAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221763; c=relaxed/simple;
	bh=sV5eEL/l9z12NIBJM4xwgsZ2FyHlykYtZqQbqeFukpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vA7E05My3M6DQOrAiHvXFQTnrxn8VTHdnb59zAEPIx/hFCeSuUI5X7BAYlbUs6C0vWVrW1C9xyAbrKTD0qi1DRJg21nMNPqyuYVRuEoUbjJgdGY5CI0sY8j72NHXSBd/EqcK9l90mynv/QmziqaR9pUk5DmccuNnhGfI9k9SIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm4uFGdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3DFC433F1;
	Thu, 29 Feb 2024 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221763;
	bh=sV5eEL/l9z12NIBJM4xwgsZ2FyHlykYtZqQbqeFukpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gm4uFGdr0FGWGQL7zOtgQ7gwnHuQCmNGKikbdcsETaqpvDu9dEgyWX177H2Bokjfd
	 1AQFOzBRumegvtmfSbB5uR0FgOFudecslrGkXqyOnoBN9Ri9bYC5YGkHsevWz66xAa
	 RfAy+M9K5DgcJ+J8zjRXNb0cCLWVYIA3n4Qa3tZhMAqVmMl3YksEtkWb6H+qIApjcD
	 I8rVxoA6Fn9P6NDCnomfmcYD+R2undz+PpfjHLTqUD9BL8rP6ztF/ToS/De+snYg53
	 J0kBrH/XxE80jsv0NPWDvkoHEnhfpYU1a3vdJ/cIYC/4D7xMlAMIJxbOZs2f66Yu7p
	 7/8KTbwMUKB6w==
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
Subject: [PATCH AUTOSEL 6.7 17/26] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
Date: Thu, 29 Feb 2024 10:48:36 -0500
Message-ID: <20240229154851.2849367-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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


