Return-Path: <linux-kernel+bounces-114484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA8F88901F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C85F1F308D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B947C13C824;
	Sun, 24 Mar 2024 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSi0cn8K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533E1448CE;
	Sun, 24 Mar 2024 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321952; cv=none; b=uicA64DqH+9Bu6p5FskPuUTMRWp7omhm2z4AIDOkIxfqFosl/KbsJs1upx0IpDdP+E3UU3dOm0mmM2ARZ6f01Rh2qA5n31wUnroXvFHv7uWkmljQOu7dndRdp38nV7xX5JLYfSbXa9nYUKFPQgIlIXRCw9C/Zhf6vvqxJmOlhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321952; c=relaxed/simple;
	bh=78/fjmKN2GarCEpgvjNsLegJ4KdOnTYmz0NgaQ+YhW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loHA4U+qm9jsdzH7DzlQc67ieFm+HJ+04BW9o15AGhFQ9i9RQKxd40FpOSFpMUgY2sG/QHpf2AGFohffZyQpvaQCRyZfJBV74Q+rURQ4Ukh46wK2m2njUTghATpdH+caZBV27uR4WOvEotqYboWJjDX8Yi6XqUPImDe68Jnk1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSi0cn8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B5FC43394;
	Sun, 24 Mar 2024 23:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321951;
	bh=78/fjmKN2GarCEpgvjNsLegJ4KdOnTYmz0NgaQ+YhW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSi0cn8KKofgF/xmAUbBarF7KZeDOKnBcZh+lNnRhHGpR3O76jkB0tHylX3ilRQ8z
	 AWbZcLnr8Ue8YfaU1nb6VGwRxYETLJb71BruY1zDCNGSXK+X/yD1Fzy6UsVQ4Ko1wL
	 dJ9euBWyj90GzwMTHT3fPx63Ni1LeHEAkZ5Zcai/sHrnfqPMGSQSowQdnpTfXSqOTe
	 JQNScdkHZkwqV66Avyz+0s8scNUYHJ2kXNDFbPPYBXMhPlWiqMw1dP0SSzXMbMBaVL
	 7TXFdh2m4RbhfYWoxFnRbRrrLNzKEK4pizcj7A1bVZiteIef0cho7yRX3SKirKkK4V
	 8NEr/Bvo09kEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 023/451] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
Date: Sun, 24 Mar 2024 19:04:59 -0400
Message-ID: <20240324231207.1351418-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index 28da4e1858d7e..5921af7fd92c5 100644
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


