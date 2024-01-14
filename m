Return-Path: <linux-kernel+bounces-25425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8467F82D013
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229341F21BA7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419D51878;
	Sun, 14 Jan 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="h4vzcQ2q"
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE523A6
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id OwMXrDZZKBraWOwMYrneAT; Sun, 14 Jan 2024 10:01:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705222862;
	bh=y3+/aQ4vgOniKlgATVWb92D72XQcu/VbbHayVguyuRk=;
	h=From:To:Cc:Subject:Date;
	b=h4vzcQ2qZd99EaMkQ1rmDICJKBOtuszqY2QT5GC4vUGpzqg6qv+Cy+/nlwcYrpdBL
	 +CcRL7hQ4ZXXHwNY1Kw1lXnd+dF2W7i5LgS98cZePgCUoCREDPZzz4VF/RBnksAf7N
	 /ZPtTqd9OBtUe+/soZJQd9Q71wQkAwkFemaH0AtolzWo3rlCl90E4eRJa9CKvjxqXc
	 w6n1TlL/xuP3xeKN0HdXPtQIjXNPkbw4JJK3CKAUW1O1cnhyg8VN3UonBCHyPTKgNU
	 0G6KFqNpyxNelc9xWVGRLjyg0q716Th6zehyR8XIzDrFyLOHpoWq9bUSIFSZHZNzJG
	 YiGWsU7Ar5kqg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jan 2024 10:01:02 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-block@vger.kernel.org
Subject: [PATCH] null_blk: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Jan 2024 10:00:59 +0100
Message-ID: <bf257b1078475a415cdc3344c6a750842946e367.1705222845.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index b1271de64d36..293f24cc4122 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1825,7 +1825,7 @@ static void null_del_dev(struct nullb *nullb)
 
 	dev = nullb->dev;
 
-	ida_simple_remove(&nullb_indexes, nullb->index);
+	ida_free(&nullb_indexes, nullb->index);
 
 	list_del_init(&nullb->list);
 
@@ -2159,7 +2159,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 
 	mutex_lock(&lock);
-	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
+	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
 	if (rv < 0) {
 		mutex_unlock(&lock);
 		goto out_cleanup_zone;
-- 
2.43.0


