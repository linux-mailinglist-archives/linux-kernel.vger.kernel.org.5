Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B27FB14F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343557AbjK1Fe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343552AbjK1Fex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:34:53 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C293DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:34:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cf7a8ab047so38875575ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701149678; x=1701754478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRqsnYQ6nV0dzX6Vx06lKgWxOV6XUUCzggjpXFerXKM=;
        b=MFB9k4mWSQv3i3ltZ0GgzWfKQZHjbG9ZrBpeRijLSZKtffqDCMVd6PdK7C+H1xnYy+
         mnYSd+ZaOyp6QARthaZGS0BkKDx3o7r6Tfbeimc2eFcwfZuPHI6d0GrY+diF9bNpbpMU
         2/pGMPwuo939+BVPZmXf/hs9BjQTTxIPrdz+nQYcaahJNps7l2ZyjW3utV063M70zPlG
         J/1s5dUkecy9SzsvacUlkrHghiH+Mk7gO5NEqSISQYl5czkOfdtuHs3ln1n3GTm83ZlH
         QljufujAVvTWjlgoIa1njlTrdgi9XVT3Y65bvOqHKMWkXznfk452ZVzRozr3AOeBJR49
         MqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701149678; x=1701754478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRqsnYQ6nV0dzX6Vx06lKgWxOV6XUUCzggjpXFerXKM=;
        b=NM8EQFNMao2frWPa5sxF0cKGEXjdTYoqYVkSaVqUeW9AnyRjneR+XKc0I26SEBCEk2
         pbSgiBB9R/5O/RFND5IWbAE0a4eKTHLFl7VhPmDlMgg85+l/Q5ELVcYDZLXw/Z6jH5x1
         aLXBu/jv7mbDC4vnmN6in5scpcb8Pv36fIKEwZtON/s+b7FjTTkvRNiJ61+p2aBczyYj
         QQr6Owjn9ZoYOGoFNRxwjOYWjjUdAxs5rgPAfY0RIjJ+I4ffQVLM49zmICHSBomrncbT
         UjMqpfd+/5DnWThKleS64jtahIH4GZoL0whh5D8KoKRDnBoMcDZLPucdjT40wa1szWY1
         FxVg==
X-Gm-Message-State: AOJu0Yy9dQnoNgqtvuVk8VAcS43aWIoY9xBlvSrgPhq0CnJJUTn9ffe1
        sEV29PYNKYRA2IWzC1efWz7JMg==
X-Google-Smtp-Source: AGHT+IH37Q4CIY9yDngnFDzZ+uMbMeUPiDKo4jJ4WzEz18Oqecw9exdZNMZEPAqlBiYZRr4RurxfqQ==
X-Received: by 2002:a17:903:183:b0:1ca:a290:4c0c with SMTP id z3-20020a170903018300b001caa2904c0cmr16142204plg.16.1701149678085;
        Mon, 27 Nov 2023 21:34:38 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b001cfb6bef8fesm5372899ple.186.2023.11.27.21.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 21:34:37 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Subject: [PATCH 2/2] xfs: update dir3 leaf block metadata after swap
Date:   Tue, 28 Nov 2023 13:32:02 +0800
Message-Id: <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
References: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
---
 fs/xfs/libxfs/xfs_da_btree.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index e576560b46e9..35f70e4c6447 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2318,8 +2318,18 @@ xfs_da3_swap_lastblock(
 	 * Copy the last block into the dead buffer and log it.
 	 */
 	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
-	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
 	dead_info = dead_buf->b_addr;
+	/*
+	 * Update the moved block's blkno if it's a dir3 leaf block
+	 */
+	if (dead_info->magic == cpu_to_be16(XFS_DIR3_LEAF1_MAGIC) ||
+	    dead_info->magic == cpu_to_be16(XFS_DIR3_LEAFN_MAGIC) ||
+	    dead_info->magic == cpu_to_be16(XFS_ATTR3_LEAF_MAGIC)) {
+		struct xfs_da3_blkinfo *dap = (struct xfs_da3_blkinfo *)dead_info;
+
+		dap->blkno = cpu_to_be64(dead_buf->b_bn);
+	}
+	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
 	/*
 	 * Get values from the moved block.
 	 */
-- 
2.20.1

