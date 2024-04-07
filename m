Return-Path: <linux-kernel+bounces-134436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE689B178
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FCB1C20886
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCB381BD;
	Sun,  7 Apr 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUMsHp7H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E2381BA;
	Sun,  7 Apr 2024 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495554; cv=none; b=hszviC+yIqshHWDWAtqghsXVDzD0y1HZ3ssJsMOXAnU+/cgT/Fw9FIyyX2S7qGOWdzpLb07U9tqVvr7lKAzqyiXct/ccEL7lK87lXdUWbRUd8bVpjlYcjyk6896rcXzYbE+cFnTqsYgmqdFHHZ4VOenKCHVx7n+mLK5GL/U2c64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495554; c=relaxed/simple;
	bh=P+UxFT2T+w1OLW0wC5WPBqcbH06FUbYSjIraon1J7KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzgeiprGEDS3aHEFEtZWpVLZyO1I+NndXWMCziKmouYE2tY7bq6Or1CrNdy4bxXwm2oGl+KAUR8kh/PA18S/UdLBsHSVL33homQJtdm8mYG3PzFKyrBOfX3QskGBthQmw0rXnk7Mz00/pMOwStTUdnIHWjDSh37ELex9p3gyKkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUMsHp7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905E6C433C7;
	Sun,  7 Apr 2024 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495553;
	bh=P+UxFT2T+w1OLW0wC5WPBqcbH06FUbYSjIraon1J7KI=;
	h=From:To:Cc:Subject:Date:From;
	b=jUMsHp7HiCirZgTedL+MgIMEU4AIO5sAL0KDd1myHtGa+joFPzPAS/2unAYOBZEVR
	 4YUoxFQF7YJ0LFI//1HWelZm/9nuey6da7ym3LO6EYJ45fWKQwBTBMOrfmyFFyru2g
	 SJqrDi+xgfQE9Tp2oDeSB1DTIBqfgQdVWfIcbggDYXfPQgjTKRgLSoKI028f4jYCer
	 FQZ/p5RreICN2HS5h/6040gMH0RwO/NHqvFHxdz5vrL/dy0AsYsjex2p8RlodcysTF
	 Kd/Ef0cu4Y+uIJAzT/jsT3axKhcbIqIhh+xVtiv6W/PHco5c7lVnu/JTH8z0Js/hA1
	 Vg6H7MpOMsXkA==
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
	powen.kao@mediatek.com,
	quic_nguyenb@quicinc.com,
	alice.chao@mediatek.com,
	yang.lee@linux.alibaba.com,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 01/22] scsi: ufs: core: Fix MCQ MAC configuration
Date: Sun,  7 Apr 2024 09:12:00 -0400
Message-ID: <20240407131231.1051652-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
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


