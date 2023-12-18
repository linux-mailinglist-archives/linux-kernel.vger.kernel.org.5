Return-Path: <linux-kernel+bounces-2965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAFD816548
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E471F215FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186073C16;
	Mon, 18 Dec 2023 03:16:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3642582
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vye3FGX_1702869400;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vye3FGX_1702869400)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 11:16:40 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: shr@devkernel.io,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	joseph.qi@linux.alibaba.com
Subject: [PATCH] mm: fix arithmetic for bdi min_ratio and max_ratio
Date: Mon, 18 Dec 2023 11:16:40 +0800
Message-Id: <20231218031640.77983-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bdi->[min|max]_ratio are both part per million.  Fix the wrong
arithmetic when setting bdi's min_ratio and max_ratio.

Fixes: efc3e6ad53ea ("mm: split off __bdi_set_max_ratio() function")
Fixes: 8021fb3232f2 ("mm: split off __bdi_set_min_ratio() function")
Reported-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 mm/page-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ee2fd6a6af40..b393b3281ce9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -692,7 +692,6 @@ static int __bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_ra
 
 	if (min_ratio > 100 * BDI_RATIO_SCALE)
 		return -EINVAL;
-	min_ratio *= BDI_RATIO_SCALE;
 
 	spin_lock_bh(&bdi_lock);
 	if (min_ratio > bdi->max_ratio) {
@@ -729,7 +728,8 @@ static int __bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ra
 		ret = -EINVAL;
 	} else {
 		bdi->max_ratio = max_ratio;
-		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) / 100;
+		bdi->max_prop_frac = div64_u64(FPROP_FRAC_BASE * max_ratio,
+					       100UL * BDI_RATIO_SCALE);
 	}
 	spin_unlock_bh(&bdi_lock);
 
-- 
2.19.1.6.gb485710b


