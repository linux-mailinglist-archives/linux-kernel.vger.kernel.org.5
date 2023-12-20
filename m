Return-Path: <linux-kernel+bounces-6512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF0F8199D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622971C2211E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D87168D1;
	Wed, 20 Dec 2023 07:47:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB86168A5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VytbEip_1703058445;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0VytbEip_1703058445)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 15:47:26 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foudation.org,
	surenb@google.com,
	rppt@kernel.org,
	zhou.kete@h3c.com,
	zhao_lei1@hoperun.com,
	kunyu@nfschina.com,
	zhang.zhengming@h3c.com,
	gregkh@linuxfoundation.org,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com
Subject: [RFC PATCH] relay: avoid relay_open_buf inproperly fails in buffer-only mode
Date: Wed, 20 Dec 2023 15:47:25 +0800
Message-Id: <20231220074725.23211-1-lulie@linux.alibaba.com>
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
return NULL. With IS_ERR_OR_NULL() check, relay_open fails because of
the returned NULL dentry, so this patch reverts back to the WARN_ON()
version and add a comment for this behavior.

Here is an example after fix:
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

But before fix, the create_buf_file callback must be something like:
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

I'm not sure if this revertion proper because it may break existing use
cases. I think we can also remove the WARN_ON check instead.

Fixes: 2c1cf00eeacb ("relay: check return of create_buf_file() properly")
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/relay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 83fe0325cde1..0700745447c1 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -395,7 +395,8 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 		dentry = chan->cb->create_buf_file(NULL, NULL,
 						   S_IRUSR, buf,
 						   &chan->is_global);
-		if (IS_ERR_OR_NULL(dentry))
+		/* has_base_filename not set, so dentry should be NULL */
+		if (WARN_ON(dentry))
 			goto free_buf;
 	}

--
2.32.0.3.g01195cf9f


