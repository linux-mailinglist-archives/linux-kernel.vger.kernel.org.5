Return-Path: <linux-kernel+bounces-103179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C887BBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAB21F22F84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA9B6F069;
	Thu, 14 Mar 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CuJ8yOW9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F916E61E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415823; cv=none; b=JMeVUcy47z6XrWuyNI1Pq24XoxdRyQgZVJk/PCge5kF1it3r7rSu+WfSikzzzsecT0o5ICe8t9Ol+T6swpG1rqvo9WPFnyeZeLsGdAOqyGhJK9GNaYyNKqgVl62NWb3T7uBDpqtFWcBbLV9Z2eqt003oliluulUJ1wESbAcjTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415823; c=relaxed/simple;
	bh=/MuuARPvl5mfIdBAlNrafkAZafuB245jPxJZSyx6idw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JAdpa5V5EEmB6f87dTY9WDDj4CGAsEJyhbZwKciOrknGRHAkFxICrAYKNe/i3KJ8T38CD/EODGkeMA6GqoLDIvCNozL/PMMz1UhEU4hBpL747u65TpAd6837JFAqYJMQlcZALv4ka3WXfz33g4c8JVUCHmXweNm2vrYe9NXvBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CuJ8yOW9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710415819;
	bh=/MuuARPvl5mfIdBAlNrafkAZafuB245jPxJZSyx6idw=;
	h=From:To:Cc:Subject:Date:From;
	b=CuJ8yOW9pw0uAsUmCYvkNZdFBi/1RE27tG8Pi6DOmvkn1OiKYf3HdwlfPXIfD2cEZ
	 lwWt24Sgrz1khmBPZzmIpj26FPdIbbzPUJEJtTpjXPNoy7/74NZ66gyyK95dGPzMt4
	 6/bnWOi44dCUfR1UvsVlQkePKGCa9lFD+ovRrSjudL4jhMZQjhAER1pejfOA+7lMfJ
	 0RvAd5X/1P4qbhIN9ovzjdQntWPMzK5Z1JO0cIIRwwPgrPxYXBiJdYNfeBFXrD+hgr
	 h6prBjryRaB0nze11GSihwHAT8UuvNYHwT1Ocd8LPmUqgygg84IiNXpaW6ziLQBsBw
	 pazBSiu+xQMjw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E51F73781F8E;
	Thu, 14 Mar 2024 11:30:18 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	wenst@chromium.org,
	kernel@collabora.com
Subject: [PATCH] soc: mediatek: socinfo: Advertise about unknown MediaTek SoC
Date: Thu, 14 Mar 2024 12:30:15 +0100
Message-ID: <20240314113015.121940-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case we're running on a MediaTek SoC that is not declared in the
socinfo_data_table, print a message stating that and, with it, also
print out the read eFuse data: this allows to easily add a new SoC
in the table, granted that its actual soc/segment/marketing names
are already previously known.

This is especially useful when booting an already known SoC that
already has socinfo support, but has a different silicon version
and/or revision, hence different model information in the eFuses.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-socinfo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
index 42572e8c1520..4494cca1d075 100644
--- a/drivers/soc/mediatek/mtk-socinfo.c
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -144,7 +144,14 @@ static int mtk_socinfo_get_socinfo_data(struct mtk_socinfo *mtk_socinfop)
 		}
 	}
 
-	return match_socinfo_index >= 0 ? match_socinfo_index : -ENOENT;
+	if (match_socinfo_index < 0) {
+		dev_warn(mtk_socinfop->dev,
+			 "Unknown MediaTek SoC with ID 0x%08x 0x%08x\n",
+			  cell_data[0], cell_data[1]);
+		return -ENOENT;
+	}
+
+	return match_socinfo_index;
 }
 
 static int mtk_socinfo_probe(struct platform_device *pdev)
-- 
2.44.0


