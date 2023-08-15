Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F2277D46E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbjHOUix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbjHOUif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:38:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1859EE7A;
        Tue, 15 Aug 2023 13:38:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bdf7086ae5so10543715ad.0;
        Tue, 15 Aug 2023 13:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692131884; x=1692736684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9ApbnI87Q8RNqPgxcxbxYleBLjFt36Eud/z8NM1Jfc=;
        b=Igj27S3Q1W7pnf91BSrgUhHYMac9KPTpHDNMOSpyjGg87YOqrM8yugbC9cQpM9wFZn
         ot905KzakQ/YUojEz0/la0PlQcexdTkV45EUPdQnKkunKIKgveO6JG3bv/6pgNYvalik
         UqWYSWuq+SbR1g1jX/emIsChbfQyWYnBmNKUlCtPFO0f3aUqGdJ8K3b4Y5KJS1me89BY
         3FVnSH4f22UmdGN4eSKRukmqoOtNH/T41pGJSB8pqMnVFiD1wWqL7fjuU2JYKmywif5N
         HeDbsn+VbosOa+pjWaRjS1lKO8IFSabcQ2uSHHGk16BiEO4Ihv9OrDdu4p4YEY+ESIr8
         jGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131884; x=1692736684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9ApbnI87Q8RNqPgxcxbxYleBLjFt36Eud/z8NM1Jfc=;
        b=fRK16UN1cAq2bs+KBd0cJRFiCtCriR55IqltjzWIGlUf4aOZgnhTZtsYAbad+OFu8j
         0d5WKhFrDM41EYKuOXn6VXSIxdrFiR7pQrkMrsKjUV/3xKk2jrxXR7FMlevYz1LWGY/w
         8QOblA+TdsySvXs8kRFlui2MSvhKrVJnljoODxa+VAZrZjSigPb1H9W/tkHCAa7erW3c
         jUlBR9FaW/ZQQx+dbxY45EmQFGp2qRu7buDF8HCtAcqhI7Jzr8dsWnkYDQg4zMEG2CpW
         jasfxI02EE3vhurIGkWWUC5tmf0uxMvZPfjJYl2X4MyTvVaHnv4KC15zzbuJgM1XvhIm
         Pzjw==
X-Gm-Message-State: AOJu0Yybm4ioE1bniIFIiTM8brtCEfgoDGumAUgyMJjehZlChjDV5H5r
        CymQMj44AID9f5Tuwhl9l6I=
X-Google-Smtp-Source: AGHT+IHhUV8EaldMz7zWKp34yUjxtun7VSqtlbQQK+DzG0CXOWQECA3nlkJg7rjhLd5VtW+qDgr4YA==
X-Received: by 2002:a17:903:11c9:b0:1bb:ce4a:5893 with SMTP id q9-20020a17090311c900b001bbce4a5893mr17379711plh.30.1692131884499;
        Tue, 15 Aug 2023 13:38:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:db85:3caf:1429:e455])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902da8b00b001b9e9f191f2sm11492962plx.15.2023.08.15.13.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:38:04 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, shuah@kernel.org
Subject: [PATCH v1] drivers: block: Drop unnecessary error check for debugfs_create_dir
Date:   Wed, 16 Aug 2023 02:07:39 +0530
Message-Id: <20230815203739.51706-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the error checking for debugfs_create_dir.
Even if we get an error from this function, other debugfs APIs will
handle the error value and doesn't crash in that case. Hence caller can
safely ignore the errors that occur during the creation of debugfs nodes.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 drivers/block/nbd.c     | 7 -------
 drivers/block/pktcdvd.c | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 65ecde3e2a5b..f64c79f6e112 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1666,11 +1666,6 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (IS_ERR(dir)) {
-		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
-			nbd_name(nbd));
-		return -EIO;
-	}
 	config->dbg_dir = dir;
 
 	debugfs_create_file("tasks", 0444, dir, nbd, &nbd_dbg_tasks_fops);
@@ -1692,8 +1687,6 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (IS_ERR(dbg_dir))
-		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 69e5a100b3cf..37cdd68c3de5 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -451,8 +451,6 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pkt_debugfs_root)
 		return;
 	pd->dfs_d_root = debugfs_create_dir(pd->name, pkt_debugfs_root);
-	if (IS_ERR(pd->dfs_d_root))
-		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444,
 					     pd->dfs_d_root, pd, &debug_fops);
-- 
2.25.1

