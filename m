Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4017A971D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjIURL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjIURKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:19 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AAE9026;
        Thu, 21 Sep 2023 10:05:42 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-417e013061eso7372401cf.1;
        Thu, 21 Sep 2023 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315941; x=1695920741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=njolLyWGYw3vA9Xc4YsCkH7k9TvdmzjireB5CtmLsDw=;
        b=fWXNmgQB8Eogrhj3SP+0GjBqEWe8MePSWeXlfjTVTtyfmzybRkY0RLsLX3xWccU+b2
         Js2H5IMM6rqicMx/DuZYtuSp1arLlJkTkNYj2/7mXmF58gTF4xSxpExGhUunJVcz7YDH
         L77ljqBJ3pk64rtDNU6nKYSl2AS0GXurwFd76w9OTdsRcA0Jme7xcpogHVnPv2SnLhTm
         s5Ppg9AVr1Q6L9zOq4XruXlt+0W9Iy4f5e3hr3+1kguSxi/FMopzHbdSK1RwI4CT8iX6
         pU/Qxzdyf1JZU2rL+9U6Qs20kWlQ7pwyIiZP1uiNrxEpqaaAW4QE7gLCOZVYdNU+OJCi
         f51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315941; x=1695920741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njolLyWGYw3vA9Xc4YsCkH7k9TvdmzjireB5CtmLsDw=;
        b=MqWARGQvlzQKLKcaZaXSbufRh02GQXnRAUxXkC4wigoMqx9bBBAXQ1rSRzAGL887ey
         WYjPWCIL9RfrY/5dQeXYUUXs/6XOHhRlHiBjXDzXz4BZjEKRBUuUpRHMaE3qRtt43VJh
         S5Qp+UH7dgClNeYDXio9gHBsVmp//pF3aakxpA9K42KdsHH93RqeoqKefDQGsZqa8U/j
         cqAql4Cf3X/W8vzI2iVDVDskAkufWzfWDx56c1v9vcLrubNx6ogvmGOIXeOHdfYX4Asu
         gb/LO5fcj5DhioRe8wLiVWgilcoVpoMK+YNKvi7eGSSpSalDzaNt7AUajMjrsErC4Lhu
         lbmA==
X-Gm-Message-State: AOJu0YzN0Q1icWE1ke/Q8x6W1N0SirI/gkWyRCox46XBpslI3L22ZVch
        AgJ6LCrtED64ksSayC0lNZvWHWA9Tc8=
X-Google-Smtp-Source: AGHT+IEzdj/06cFL2sbiF2+qQ9gC3CGwBMmB8cOgMsstcJpMD9UxElbnaKu3HOC2Z76qXDTgzTr+Wg==
X-Received: by 2002:a17:902:6b07:b0:1c3:29c4:c501 with SMTP id o7-20020a1709026b0700b001c329c4c501mr4853684plk.14.1695305855162;
        Thu, 21 Sep 2023 07:17:35 -0700 (PDT)
Received: from carrot.. (i114-180-53-6.s42.a014.ap.plala.or.jp. [114.180.53.6])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001c56157f062sm1529686plk.227.2023.09.21.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:17:34 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()
Date:   Thu, 21 Sep 2023 23:17:31 +0900
Message-Id: <20230921141731.10073-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

In nilfs_gccache_submit_read_data(), brelse(bh) is called to drop the
reference count of bh when the call to nilfs_dat_translate() fails.  If
the reference count hits 0 and its owner page gets unlocked, bh may be
freed.  However, bh->b_page is dereferenced to put the page after that,
which may result in a use-after-free bug.  This patch moves the release
operation after unlocking and putting the page.

NOTE: The function in question is only called in GC, and in combination
with current userland tools, address translation using DAT does not occur
in that function, so the code path that causes this issue will not be
executed.  However, it is possible to run that code path by intentionally
modifying the userland GC library or by calling the GC ioctl directly.

Link: https://lkml.kernel.org/r/1543201709-53191-1-git-send-email-bianpan2016@163.com
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reported-by: Ferry Meng <mengferry@linux.alibaba.com>
Closes: https://lkml.kernel.org/r/20230818092022.111054-1-mengferry@linux.alibaba.com
Fixes: a3d93f709e89 ("nilfs2: block cache for garbage collection")
[konishi.ryusuke@gmail.com: NOTE added to the commit log]
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
---
fs/nilfs2/gcinode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 48fe71d309cb..8beb2730929d 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -73,10 +73,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 
 		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
-		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
-			brelse(bh);
+		if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
 			goto failed;
-		}
 	}
 
 	lock_buffer(bh);
@@ -102,6 +100,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
  failed:
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
+	if (unlikely(err))
+		brelse(bh);
 	return err;
 }
 
-- 
2.34.1

