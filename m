Return-Path: <linux-kernel+bounces-19042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E1826725
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DECBB20FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFEC10F7;
	Mon,  8 Jan 2024 01:45:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE387F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-5YvzR_1704678337;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W-5YvzR_1704678337)
          by smtp.aliyun-inc.com;
          Mon, 08 Jan 2024 09:45:37 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: dhowells@redhat.com
Cc: linux-cachefs@redhat.com,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Fix type mismatch for pos variable
Date: Mon,  8 Jan 2024 09:45:36 +0800
Message-Id: <20240108014536.43971-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'pos' variable within __cachefiles_prepare_write() and related
functions is intended to store the return value from vfs_llseek(),
which is of loff_t type. However, it was incorrectly declared as
an unsigned long long, which is an unsigned type and cannot store
negative error values returned by vfs_llseek().

This patch corrects the type of 'pos' variable to loff_t, ensuring
that error codes are properly handled and facilitating proper type
conversion from the cachefiles_inject_read_error function.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/cachefiles/io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index bb19b8bcf2e8..3da2b2e261da 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -521,8 +521,9 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 			       bool no_space_allocated_yet)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
-	unsigned long long start = *_start, pos;
+	unsigned long long start = *_start;
 	size_t len = *_len;
+	loff_t pos;
 	int ret;
 
 	/* Round to DIO size */
-- 
2.20.1.7.g153144c


