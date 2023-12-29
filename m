Return-Path: <linux-kernel+bounces-12910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A79381FC88
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC621C21F11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB0817D1;
	Fri, 29 Dec 2023 02:12:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D75F1382;
	Fri, 29 Dec 2023 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 16AE0900112;
	Fri, 29 Dec 2023 10:12:37 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-ANTISPAM-LEVEL:2
X-ABS-CHECKED:0
Received: from localhost.localdomain (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P9456T281469140463984S1703815956124928_;
	Fri, 29 Dec 2023 10:12:37 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:axboe@kernel.dk
X-RCPT-COUNT:4
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.58.12
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<7c857e38d5f4d502005b6d183eaf34d0>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuwei09@cestc.cn
Subject: [PATCH] block/blk_mq: Only call kfree when set->tags isn't null
Date: Fri, 29 Dec 2023 10:12:20 +0800
Message-ID: <20231229021220.7337-1-liuwei09@cestc.cn>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function blk_mq_realloc_tag_set_tags, there is a check on set->tags,
but kfree should only be called when set->tags isn't null

Signed-off-by: Liu Wei <liuwei09@cestc.cn>
---
 block/blk-mq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ac18f802c027..07a3fc01d54b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4409,10 +4409,11 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 	if (!new_tags)
 		return -ENOMEM;
 
-	if (set->tags)
+	if (set->tags) {
 		memcpy(new_tags, set->tags, set->nr_hw_queues *
 		       sizeof(*set->tags));
-	kfree(set->tags);
+		kfree(set->tags);
+	}
 	set->tags = new_tags;
 
 	for (i = set->nr_hw_queues; i < new_nr_hw_queues; i++) {
-- 
2.42.1




