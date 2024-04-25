Return-Path: <linux-kernel+bounces-158767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793DC8B24A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189551F221C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0314D71F;
	Thu, 25 Apr 2024 15:05:08 +0000 (UTC)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638E14AD38
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057507; cv=none; b=RjOtmJ1HBXyv6PpjTWPoMk3Y3IiWLQ9ZrO1gPQ6Tpl+BNuvEgSKyWDufxSnHNDeY9L6TG/MHA7p+bfEigB6Int9pT8v3rkd5Vmoj0AqC+6dwTF+dIpSH4nDcOc82UshggB/mlMAfHQoxvIJJRtH0QZ9ksTIT7rdwjrtB9Gsq+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057507; c=relaxed/simple;
	bh=7GgKCZNA8YG4pda2cJjsXOmL0hF/aMYRDuq0OcqOcYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WA2joxapQw5FWBwRj2/dVl0R86ev3FejUg3q1brLwS5VUjVN6siptcy1VwpFk+LO1H390YFRi6qcicYaI/chU9HnNnpfE+f6vCKZ+d91I2kgsu3CEFH1pntwCBMeALpPhXH2MGCHcnhbGA57jfGDwHGkv570ijQxu+PAuFogxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; arc=none smtp.client-ip=202.120.2.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 05E30100460AA;
	Thu, 25 Apr 2024 22:55:57 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id D655C380D11;
	Thu, 25 Apr 2024 22:55:52 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: [f2fs-dev] [PATCH] f2fs: remove redundant parameter in is_next_segment_free()
Date: Thu, 25 Apr 2024 22:55:28 +0800
Message-ID: <20240425145528.2925372-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_next_segment_free() takes a redundant `type` parameter. Remove it.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 fs/f2fs/segment.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2206199e8099..8d63ddfe4a77 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2645,7 +2645,7 @@ static void write_current_sum_page(struct f2fs_sb_info *sbi,
 }
 
 static int is_next_segment_free(struct f2fs_sb_info *sbi,
-				struct curseg_info *curseg, int type)
+				struct curseg_info *curseg)
 {
 	unsigned int segno = curseg->segno + 1;
 	struct free_segmap_info *free_i = FREE_I(sbi);
@@ -3073,8 +3073,7 @@ static bool need_new_seg(struct f2fs_sb_info *sbi, int type)
 	if (!is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) &&
 	    curseg->seg_type == CURSEG_WARM_NODE)
 		return true;
-	if (curseg->alloc_type == LFS &&
-	    is_next_segment_free(sbi, curseg, type) &&
+	if (curseg->alloc_type == LFS && is_next_segment_free(sbi, curseg) &&
 	    likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return true;
 	if (!f2fs_need_SSR(sbi) || !get_ssr_segment(sbi, type, SSR, 0))
-- 
2.44.0


