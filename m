Return-Path: <linux-kernel+bounces-152876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343798AC59B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D533A1F24B87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5E4DA1B;
	Mon, 22 Apr 2024 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YVoZ+T9e"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F7C8F3;
	Mon, 22 Apr 2024 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770983; cv=none; b=cUDW+3s4xegODOBe/Y6ozVsOHWB0Kc/QNvUDccqWyjgXZI5b6C85gUWJWW0Pr5V27BnvQe/jVGKuyQd2qUqC0vBmjOVdxnSbD7nuc/HiMrvK+j75U6KKoOpGmpDGnPffczAlSgmN3xIDvhDrTEhL3j/Tl9s0pmQniAW9jl1qXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770983; c=relaxed/simple;
	bh=UUlGK4PQumY+T7kadQ2PjXiq/o3GP7g8bhWr7C7icG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OINTJEr+xka7j/5nb5lr6HzeW03s8luLkIJOYWZzF/7EOyYyK8RU1MvnTjK8c4MPHiIvZ9rpGZ/JEedSNwO5Rx2B1CvNoLnqe7OtXK/zInumHE9pGwzbL84XG60REVAXAPC0wl2YF4nF2sayTGo95XU0iawyJOQ3KHExxFSxLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YVoZ+T9e; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713770972; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eTYBpn4kM6qD+5ULLW976eOqqUt2i6JW5gCkcrmMFlo=;
	b=YVoZ+T9eR9JgIpFsC6Zl3HkzEDqEmx9AJseX9UiN+CWpoKl6HwWErMRKDsP7XBtDW5uweS4XHOpJ3QqxgaGm4MO8x5/6nm6N2zOM+9piNH32UUrbJoS3OdolVNHy1Q2g6Ru73sI5aNWqA1nUwbJMewzWHayu1D9jtOQIF3+7d6U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W5.r20R_1713770963;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W5.r20R_1713770963)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:29:32 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] wifi: rtw89: Remove the redundant else branch in the function rtw89_phy_get_kpath
Date: Mon, 22 Apr 2024 15:29:22 +0800
Message-Id: <20240422072922.50940-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assignment of the else and if branches is the same in the "case:
MLO_2_PLUS_0_1RF" branch of the function rtw89_phy_get_kpath, so we
remove it and add comments here to make the code easier to understand.

/drivers/net/wireless/realtek/rtw89/phy.c:6406:2-4: WARNING: possible condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8812
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Add code comments, modify commit subject, and content description.

 drivers/net/wireless/realtek/rtw89/phy.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index eaa18140d1a8..a82b4c56a6f4 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6403,10 +6403,8 @@ enum rtw89_rf_path_bit rtw89_phy_get_kpath(struct rtw89_dev *rtwdev,
 			return RF_D;
 	case MLO_0_PLUS_2_1RF:
 	case MLO_2_PLUS_0_1RF:
-		if (phy_idx == RTW89_PHY_0)
-			return RF_AB;
-		else
-			return RF_AB;
+		/* for both PHY 0/1 */
+		return RF_AB;
 	case MLO_0_PLUS_2_2RF:
 	case MLO_2_PLUS_0_2RF:
 	case MLO_2_PLUS_2_2RF:
-- 
2.20.1.7.g153144c


