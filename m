Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975E7FD03A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjK2H7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjK2H7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:59:40 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF61A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:59:46 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so4289709a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701244786; x=1701849586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGwa/klWYWx3gVbFO7UV3sjDmi0cMp8GGfC8jWdaqOs=;
        b=U4fxZJjrLknoM74F9M5SQZuwCbht/oZCeNcVFO/UDjyCFXMQKykI6sSpbuXLh8qpzS
         17GlZkRmkQguChrXSjd3Bs+dPa/n3ZZTsFlykxwXvMxQ9F/nu7QAsWbDLIdA1KiVV0TO
         KXKxM5xQ0uXs+2UGmvFvFP7ywILl9QWIRH1J4TVOXM4Z2Jbn9qMayUhlQIJ26B58yNeP
         JmAQTz8P4eTyEDtxOWrZd27YKWYjMqJkZhmtBcGBRwJo5faoBKYwJ0Sizh13q177vE+L
         W/72gQsZwBRSGbg0mmN5VRUp48zW/V+ZRhypeBeo9QrxDQvskk4xxBFXuAaBFD9lD/3R
         0y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701244786; x=1701849586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGwa/klWYWx3gVbFO7UV3sjDmi0cMp8GGfC8jWdaqOs=;
        b=uA91jtsxjCP+ZjN6gBt8FE0yKxa6fubQDG3yAJaltSC0AeC0uk361xDCKpHxy6HZUk
         lENuek5ZFBJ7LiE1s3C3u2yl8+buG181dH247EjZMYTFno+bh4sjfqNdykvxXx3PUKsq
         Dh0eutOo1M3S2Vqqk0QVkjOStraTfHUo5aCK7fXD8UPDIxiKs0QOO4/ouYgepBTwj9n+
         GoaFJ0lJv/mFLlimazeft0V7ykgniKJdfqzFCwuZ8Bp9DmU14cCA3JO21+2hRLERApJ8
         AoLNQtEdizLBi53epoZjD1U1gGIm7FFT2YI5WVN2vYIqOI9HWQ0P4QuTryljrZTuK5zK
         yEUA==
X-Gm-Message-State: AOJu0YxtXk3abOPR6fhbuIMkhCjg0TBtjXR1EdL7ML6Oh2CmxGmeWBLi
        +W9mTrdMk3qdoz/72PFu5iw4Aw==
X-Google-Smtp-Source: AGHT+IEW7RY6rW1xN0SZYk2KmfKRhGALSQC7dhZKn7nt9rZPJDObYoCq4CCKaltza5Ttsehw10eh9Q==
X-Received: by 2002:a05:6a20:6a0e:b0:18b:8158:b115 with SMTP id p14-20020a056a206a0e00b0018b8158b115mr20395186pzk.56.1701244786219;
        Tue, 28 Nov 2023 23:59:46 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902989100b001cfd0ddc5d3sm4979419plp.277.2023.11.28.23.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 23:59:45 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH v2 2/2] xfs: update dir3 leaf block metadata after swap
Date:   Wed, 29 Nov 2023 15:58:32 +0800
Message-Id: <20231129075832.73600-3-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231129075832.73600-1-zhangjiachen.jaycee@bytedance.com>
References: <20231129075832.73600-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Tianci <zhangtianci.1997@bytedance.com>

xfs_da3_swap_lastblock() copy the last block content to the dead block,
but do not update the metadata in it. We need update some metadata
for some kinds of type block, such as dir3 leafn block records its
blkno, we shall update it to the dead block blkno. Otherwise,
before write the xfs_buf to disk, the verify_write() will fail in
blk_hdr->blkno != xfs_buf->b_bn, then xfs will be shutdown.

We will get this warning:

  XFS (dm-0): Metadata corruption detected at xfs_dir3_leaf_verify+0xa8/0xe0 [xfs], xfs_dir3_leafn block 0x178
  XFS (dm-0): Unmount and run xfs_repair
  XFS (dm-0): First 128 bytes of corrupted metadata buffer:
  00000000e80f1917: 00 80 00 0b 00 80 00 07 3d ff 00 00 00 00 00 00  ........=.......
  000000009604c005: 00 00 00 00 00 00 01 a0 00 00 00 00 00 00 00 00  ................
  000000006b6fb2bf: e4 44 e3 97 b5 64 44 41 8b 84 60 0e 50 43 d9 bf  .D...dDA..`.PC..
  00000000678978a2: 00 00 00 00 00 00 00 83 01 73 00 93 00 00 00 00  .........s......
  00000000b28b247c: 99 29 1d 38 00 00 00 00 99 29 1d 40 00 00 00 00  .).8.....).@....
  000000002b2a662c: 99 29 1d 48 00 00 00 00 99 49 11 00 00 00 00 00  .).H.....I......
  00000000ea2ffbb8: 99 49 11 08 00 00 45 25 99 49 11 10 00 00 48 fe  .I....E%.I....H.
  0000000069e86440: 99 49 11 18 00 00 4c 6b 99 49 11 20 00 00 4d 97  .I....Lk.I. ..M.
  XFS (dm-0): xfs_do_force_shutdown(0x8) called from line 1423 of file fs/xfs/xfs_buf.c.  Return address = 00000000c0ff63c1
  XFS (dm-0): Corruption of in-memory data detected.  Shutting down filesystem
  XFS (dm-0): Please umount the filesystem and rectify the problem(s)

From the log above, we know xfs_buf->b_no is 0x178, but the block's hdr record
its blkno is 0x1a0.

Fixes: 24df33b45ecf ("xfs: add CRC checking to dir2 leaf blocks")
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Suggested-by: Dave Chinner <david@fromorbit.com>
---
 fs/xfs/libxfs/xfs_da_btree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index e576560b46e9..d11e6286e466 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2318,8 +2318,17 @@ xfs_da3_swap_lastblock(
 	 * Copy the last block into the dead buffer and log it.
 	 */
 	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
-	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
 	dead_info = dead_buf->b_addr;
+	/*
+	 * If xfs enable crc, the node/leaf block records its blkno, we
+	 * must update it.
+	 */
+	if (xfs_has_crc(mp)) {
+		struct xfs_da3_blkinfo *da3 = container_of(dead_info, struct xfs_da3_blkinfo, hdr);
+
+		da3->blkno = cpu_to_be64(xfs_buf_daddr(dead_buf));
+	}
+	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
 	/*
 	 * Get values from the moved block.
 	 */
-- 
2.20.1

