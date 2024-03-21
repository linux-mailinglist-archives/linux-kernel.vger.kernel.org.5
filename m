Return-Path: <linux-kernel+bounces-109810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BFB8855FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99EB285D60
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A22E41A;
	Thu, 21 Mar 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1fp7acZm"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE51B274;
	Thu, 21 Mar 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010795; cv=none; b=jDwVAvGZ0hJu9vmplzJraopBrZDli714odqmwgG9lTkk2K5QSWXu0epTWLuyz2HqqALdFZzJmF3O+rITJTb7Iiq2ylNqO5EnXgGwc0bIu9ImVidjITNleB0Rh2SFlc40Gw///19fjUke9Y0SES//NlgGFNY17rcxpeyUstZtRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010795; c=relaxed/simple;
	bh=NqcCQoYTi7w39yHeqdyYgH/AKTtHB2Xu9qukGQne7yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guYnwyyTZ2sVh5zk6bBZgRjweh7rlkyhOErvXYwOTRZGjnqxU7fdURGK2pYC2my3pBYz3k54tEd2MjeYy/mONDyYCNdhrN2JNRwi+JlFbDWue4waxo4naqcgxEsuh4iyn/lmz/gWnip5nygP0C3r+KE5Zm9ETQOVvuKKtgFhsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1fp7acZm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711010792;
	bh=NqcCQoYTi7w39yHeqdyYgH/AKTtHB2Xu9qukGQne7yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1fp7acZmBXCpRsY5BNXvVpvO/H+tZY7F6WB7B0Qay39vTKhh+BKJF42sh6kdvM8aE
	 F913/i597FGqp+xvQvdVzofeVzjSbaAD4PP9kokEPNlGsWgYNX6oz0117rxvXMVZEY
	 LV/bUVKfAavpu+/JbLjWUM8ftpCGKYDXvxwddipwPA+r+NUvabFVgiHlQowucYj9Rh
	 lEbMZ+A53zFJW7skNmG5nFKMqVwvW5oeCyeftgV5lL8BkedpG1B8dl1dl1JEhboy/z
	 m1HY1blLw+mw7PhAuz25pFgj9j0NnjP4Exx8VrBAMDHTNkeG/OYNjxhQ0bMyw/WqrS
	 Co0oCbYYS2axw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A31E137820EF;
	Thu, 21 Mar 2024 08:46:31 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: mathieu.poirier@linaro.org
Cc: andersson@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	tzungbi@kernel.org,
	tinghan.shen@mediatek.com,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	wenst@chromium.org,
	kernel@collabora.com
Subject: [PATCH 1/2] remoteproc: mediatek: Make sure IPI buffer fits in L2TCM
Date: Thu, 21 Mar 2024 09:46:13 +0100
Message-ID: <20240321084614.45253-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
References: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPI buffer location is read from the firmware that we load to the
System Companion Processor, and it's not granted that both the SRAM
(L2TCM) size that is defined in the devicetree node is large enough
for that, and while this is especially true for multi-core SCP, it's
still useful to check on single-core variants as well.

Failing to perform this check may make this driver perform R/W
oeprations out of the L2TCM boundary, resulting (at best) in a
kernel panic.

To fix that, check that the IPI buffer fits, otherwise return a
failure and refuse to boot the relevant SCP core (or the SCP at
all, if this is single core).

Fixes: 3efa0ea743b7 ("remoteproc/mediatek: read IPI buffer offset from FW")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_scp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index a35409eda0cf..67518291a8ad 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -132,7 +132,7 @@ static int scp_elf_read_ipi_buf_addr(struct mtk_scp *scp,
 static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
 {
 	int ret;
-	size_t offset;
+	size_t buf_sz, offset;
 
 	/* read the ipi buf addr from FW itself first */
 	ret = scp_elf_read_ipi_buf_addr(scp, fw, &offset);
@@ -144,6 +144,14 @@ static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
 	}
 	dev_info(scp->dev, "IPI buf addr %#010zx\n", offset);
 
+	/* Make sure IPI buffer fits in the L2TCM range assigned to this core */
+	buf_sz = sizeof(*scp->recv_buf) + sizeof(*scp->send_buf);
+
+	if (scp->sram_size < buf_sz + offset) {
+		dev_err(scp->dev, "IPI buffer does not fit in SRAM.\n");
+		return -EOVERFLOW;
+	}
+
 	scp->recv_buf = (struct mtk_share_obj __iomem *)
 			(scp->sram_base + offset);
 	scp->send_buf = (struct mtk_share_obj __iomem *)
-- 
2.44.0


