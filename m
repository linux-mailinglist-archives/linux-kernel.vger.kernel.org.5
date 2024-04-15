Return-Path: <linux-kernel+bounces-144955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0A8A4D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294421F2319F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B464A86;
	Mon, 15 Apr 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XwvULAIy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF825EE67;
	Mon, 15 Apr 2024 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178822; cv=none; b=Ewr4n3XHvLO2phnhAoRqG/huOTfJhZZTlyA979yvkUPkAsn7f/f8QYy1c5oDvO8AxRowxEWLkeM2bXWm79jO2yyiOPvS4ewbyfKdHN8xRFYC46zEQZbw6NCX1wiew1Me13T7QUbtXVYkn450+wTcjUgRv/n0UdpFO2mAFnFqiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178822; c=relaxed/simple;
	bh=WY8EthFDmZfJZmt27wVTY3epf3S/NvCwlH2R04NWsW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZystsTxHieRFWZQnqTUG1+kYQp//NlX1o+kHQLa53Nv9J/7Ia0NYyOduLJR8padwWUmZIh7FoUI7YcSmVqbakG21eYlsAr/F9s0cwzpXkcvFERJod3Ns5AckUTrN5PcE8H/QPt3ejuaQJOBP+SDTGZ1aZHFP2k52B0DqX8FkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XwvULAIy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713178818;
	bh=WY8EthFDmZfJZmt27wVTY3epf3S/NvCwlH2R04NWsW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XwvULAIyoiiK5jjzjSQ0RjCLvqCbsiVtWAEfLMbindIpruDWh7fMwkTU3aNmoPIod
	 0gK1v8tLHosnBnuRNjPrwSEyBqe+p0plvRfbHwrAGs8qciLFEBNcp4EMbUT3KxtUrO
	 +fTedZDCnlYEfphHvr3UZFUU+RiHbwj+sJ21EGHvh5IhBpiozW2k5eDCvZp+VR6AcZ
	 cjCMssSnlw81yGH+JCtphCCO/zu0uqpPMXnqs2wlthv0iQVrsUpjFBb7++qoufUjlu
	 tpDJay8Tdk1aq4x218HXr8wOXsZUcTEw0bvVZYgKN+fknqG7seg8xsJfyqkOkEJRag
	 tY/faXsEtQLcg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 83C4137820EF;
	Mon, 15 Apr 2024 11:00:17 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-scsi@vger.kernel.org
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peter.wang@mediatek.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/8] scsi: ufs: ufs-mediatek: Fix property name for crypt boost voltage
Date: Mon, 15 Apr 2024 13:00:06 +0200
Message-ID: <20240415110012.148871-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename "boost-crypt-vcore-min" to "mediatek,boost-crypt-microvolt":
this is a vendor specific property and needs the "mediatek," prefix,
moreover, this is not defining a minimum voltage per-se;

Even if technically a call to regulator_set_voltage() does indeed
internally set a VMIN for a regulator, the API also supports other
calls to set VMIN-VMAX constraints, so this "vcore-min"->"microvolt"
rename is performed in order to avoid confusion, other than adding
the "microvolt" suffix to it (as this does take microvolts!).

Fixes: 590b0d2372fe ("scsi: ufs-mediatek: Support performance mode for inline encryption engine")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/ufs/host/ufs-mediatek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index e4643ac49033..688d85909ad6 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -595,9 +595,9 @@ static void ufs_mtk_init_boost_crypt(struct ufs_hba *hba)
 		goto disable_caps;
 	}
 
-	if (of_property_read_u32(dev->of_node, "boost-crypt-vcore-min",
+	if (of_property_read_u32(dev->of_node, "mediatek,boost-crypt-microvolt",
 				 &volt)) {
-		dev_info(dev, "failed to get boost-crypt-vcore-min");
+		dev_info(dev, "failed to get mediatek,boost-crypt-microvolt");
 		goto disable_caps;
 	}
 
-- 
2.44.0


