Return-Path: <linux-kernel+bounces-72865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306385B9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5021C222F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9C65BA1;
	Tue, 20 Feb 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oP8bJC1Z"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0956519D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426729; cv=none; b=TXzm7Il80FCW+qkyxee0gRJIdKQqADnaO7nIwao4r0qGIyZJwhZ5DQHXE5ULqOdaKqCEilFzze10Cut0GCcAeqHa82RID5Pq0rKI+P5VSLUY90l50arSy0oI/A8F3pUxSTMl0yJtnlTOKCGg8ovLDGkp/xgQEwA7usc2pXdIiXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426729; c=relaxed/simple;
	bh=JWW1JxkqWuHVa6b8AqZqenUuq61dUCp0Rh4lrmiIiQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfGHK9WwWMjJzu2yYTMFMAGu/qEzYbi81mropY94eQ1fT2xJy9BiFHpnJN7Gi8TBAAD0eirzshr0ldMeBqog3ELB5JpWhWv61j6rw9rcWBUdfah1l8h3a/IyY84ptKMPa+ZqODzx7c0UTZ0t6mlxe4KvU8GD1emwfOPsmF1Kmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oP8bJC1Z; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708426717; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=x1dXJmu9Nanj3JJhkblhi78dtxr9mOoMw+nXdkteozQ=;
	b=oP8bJC1Z+pZE0mI1Pa/YGrbivtV8t18JYDMvxpwjGbyPpD32G/ZSZXg2R3P6BE87pTtJHkccsnPtWeFMbkQQz3DryBzP/KpAMJheqkdGmrFeJ7PPPjIT60TLswCSWaY4SIhxs1xyXC2br36nVM8xG0E1xX7sQ15Hy9beoDfOu8A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0wa1gb_1708426716;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W0wa1gb_1708426716)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 18:58:37 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	zhou.kete@h3c.com,
	zhao_lei1@hoperun.com,
	nabijaczleweli@nabijaczleweli.xyz,
	kunyu@nfschina.com,
	zhang.zhengming@h3c.com,
	gregkh@linuxfoundation.org,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com
Subject: [PATCH] relay: avoid relay_open_buf inproperly fails in buffer-only mode
Date: Tue, 20 Feb 2024 18:58:36 +0800
Message-Id: <20240220105836.15815-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In buffer-only mode, relay_open(NULL, NULL, ...) is used to create the
buffer first, where chan->has_base_filename is not set. Though we still
need to call chan->cb->create_buf_file in relay_open_buf() to retrieve
global info for global buffer, the create_buf_file callback should
return NULL. However, with IS_ERR_OR_NULL() checking, relay_open fails
because the returned dentry == NULL.

This patch remove the IS_ERR_OR_NULL() for compatibility and update the
comment to explain the behavior.

Here is a create_buf_file callback example after fix:
```
struct dentry *my_create_buf_file(const char *filename,
            struct dentry *parent, umode_t mode,
            struct rchan_buf *buf, int *is_global)
{
    if (!filename)
        return NULL;

    return debugfs_create_file(filename, mode, parent, buf,
                &relay_file_operations);
}

relay_cb.create_buf_file = my_create_buf_file
relay_chan = relay_open(NULL, NULL,
                    subbuf_size, subbuf_num,
                    &relay_cb, NULL);
relay_late_setup_files(relay_chan, filename, parent);
```

But before fix, the callback must be something like:
```
struct dentry *my_create_buf_file(const char *filename,
            struct dentry *parent, umode_t mode,
            struct rchan_buf *buf, int *is_global)
{
    if (!filename)
        return ERR_PTR(1); // a valid ptr is necessary for relay_open

    return debugfs_create_file(filename, mode, parent, buf,
                &relay_file_operations);
}
```

Fixes: 2c1cf00eeacb ("relay: check return of create_buf_file() properly")
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/relay.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index a8e90e98bf2c..0d8b8325530a 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -391,12 +391,13 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 			goto free_buf;
 		relay_set_buf_dentry(buf, dentry);
 	} else {
-		/* Only retrieve global info, nothing more, nothing less */
+		/* In buffer-only mode, relay_open_buf is called with
+		 * filename=NULL, but create_buf_file is still needed to
+		 * retrieve is_global info. So dentry should be NULL here.
+		 */
 		dentry = chan->cb->create_buf_file(NULL, NULL,
 						   S_IRUSR, buf,
 						   &chan->is_global);
-		if (IS_ERR_OR_NULL(dentry))
-			goto free_buf;
 	}
 
  	buf->cpu = cpu;
-- 
2.32.0.3.g01195cf9f


