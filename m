Return-Path: <linux-kernel+bounces-134410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BCD89B127
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1902819A5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10B2482C3;
	Sun,  7 Apr 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7qkFHHV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656D481B1;
	Sun,  7 Apr 2024 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495493; cv=none; b=uWKRnZ22CaZ9NAxhrFyqeMt+9Ba04VgnI+xSXMi/nSUAw+XUl1FjW/kN4HZhIT9wd5zJRKmKLdWhqSm1Vy0jz8lyxXRFEh0wzAomNUgfK//rsgPEe2KhnyumiyBmEoF+e6YzRrhbpA006BKlDyrcLo3RdHyRQxkvJBjeyArWB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495493; c=relaxed/simple;
	bh=P+UxFT2T+w1OLW0wC5WPBqcbH06FUbYSjIraon1J7KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCTVKxymc8xaN/COBk/agdFabN4ZEf6UFs3oU8zBzocW9HwsYDKiUXsFgtWB9uK2zp9AGslfboACtW1h4LTz69wobZ9gdTfa53AXARo3ypkJd0uMTlQevvznZ0Tt19u41oNQJwro/MzO4Jowie5uIVISIGpHodl17PDCX8JO8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7qkFHHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE7AC43394;
	Sun,  7 Apr 2024 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495492;
	bh=P+UxFT2T+w1OLW0wC5WPBqcbH06FUbYSjIraon1J7KI=;
	h=From:To:Cc:Subject:Date:From;
	b=W7qkFHHVCfVNU5GQS1Cyl2lYtfz0NFAbiPvTW4HhNo5LkUmj3ycQwqaoWDVTLOKpF
	 0DWoZFJSgI5IM3TESMQuPWwbAVi4R3X9CCRaQnD5/N/O0TntFl5cA85V7iMLdpYKXC
	 Z4nSwetza6/O/5F6edQs1rkTS5dgbgapJCvP11oOrsQtlYs0l/+lCfKHFSooK52wXk
	 OaNDllYUSs2hxIYPqmIY8J5KPzVCOOj9XhgpEtcco93pcoTR9M9PzIZQwL/aGCMKYx
	 qz66bSBhhD+WMdUfR8wTU8sikbODA6GGxW5JcmF+JVPBaIGLmSoN9K055ABWcBSd1c
	 i5jZu/HimXa5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rohit Ner <rohitner@google.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Can Guo <quic_cang@quicinc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bvanassche@acm.org,
	stanley.chu@mediatek.com,
	quic_nguyenb@quicinc.com,
	powen.kao@mediatek.com,
	alice.chao@mediatek.com,
	yang.lee@linux.alibaba.com,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 01/25] scsi: ufs: core: Fix MCQ MAC configuration
Date: Sun,  7 Apr 2024 09:10:49 -0400
Message-ID: <20240407131130.1050321-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
Content-Transfer-Encoding: 8bit

From: Rohit Ner <rohitner@google.com>

[ Upstream commit 767712f91de76abd22a45184e6e3440120b8bfce ]

As per JEDEC Standard No. 223E Section 5.9.2, the max # active commands
value programmed by the host sw in MCQConfig.MAC should be one less than
the actual value.

Signed-off-by: Rohit Ner <rohitner@google.com>
Link: https://lore.kernel.org/r/20240220095637.2900067-1-rohitner@google.com
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 0787456c2b892..c873fd8239427 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -94,7 +94,7 @@ void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds)
 
 	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
 	val &= ~MCQ_CFG_MAC_MASK;
-	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds);
+	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds - 1);
 	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
 }
 EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
-- 
2.43.0


