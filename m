Return-Path: <linux-kernel+bounces-114019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82488887EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E3B1C26E81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182801FA813;
	Sun, 24 Mar 2024 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpLgeBV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017281E586C;
	Sun, 24 Mar 2024 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321293; cv=none; b=Azxrilzk9dDyF2VpM8uDd+Jx1sEyHsCIKr7d7AwDz0o0daCMGTGAUDIs3kPg+EfbLV3U2VoTNg7Li8yvlxZBYc6N1HOvFVvX1GDltP6PHtWv55dYnuJfnQIaI+NuEXEdhVUe0IrB91TMoMEtU6/+4NmbOkzsIom98ux3zwjamqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321293; c=relaxed/simple;
	bh=TVn0K55l25BpswqOak4H/Qan8tlImkF4R9suQP0gmms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4jh55vJaKlZXIDQtncL3rI7MQ0G1oLXnFZ26D24mV0FWfWKBHs2KM3GERQ91EgjNMPgKQjyh5SzDoyQLSbjF/Ev9ubQFxXZXKs0GJm+GD3F4mgNgXuAHAxMYHdjK/5XGpZS73b3f2FsnaUom54qeZcmDbAtfnigrj7OFP7UIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpLgeBV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40858C43394;
	Sun, 24 Mar 2024 23:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321291;
	bh=TVn0K55l25BpswqOak4H/Qan8tlImkF4R9suQP0gmms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpLgeBV7lVZ1KQtjAhehndqzOYKHt0Ws6WuQsS7SJGICHD7z9lLVnjwi4w2KesKbR
	 PzLlbp1iVBqDmDHleIusnMQuLI8Hw3QHHfrQ+p0mt9b0VC0HKbzfjWsXMHgXWbJ7ZU
	 mNrONmbkIJdnQ1J3frNCL98M9vSnOxdbSo7wFq0nMG+Jt48hgfBe/Ath1XVXqem9Uz
	 LqetNvJXTRIsEnWrNAzbH6T84mEiJl2Szc+3ycsTvk/OGeodLXtukJDO0vErpw6YA6
	 U6S6V4V4HUnOnXw3ImcH7YOlLiEtvZ9nXk5xT2t+dhdp9yVqr7SvrlTzhWglB0n24h
	 AbV36ng+Ko7gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 014/638] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
Date: Sun, 24 Mar 2024 18:50:51 -0400
Message-ID: <20240324230116.1348576-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 80ad60d485ea0..cc231185d72c3 100644
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


