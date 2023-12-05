Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048E58049A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbjLEF77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjLEF7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:59:48 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867BD116
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 21:59:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d0897e99e0so12914145ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 21:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701755971; x=1702360771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyBGwSV+iJralP4K3/kIwnYMScArE6+I+gopISjyQyw=;
        b=k1Kgw8/QWCUAslUlV7mcNpAZr7OUCSZFq7SoHbXtdnLEWCK5OKFcNE09qlygP6FQfl
         UXnF2zOo/eubNgQZZcmMSj86yCiSop7ly/J4z+0OgT+T4ItvDTmx9pYCxo3mCu0fUair
         xfQcYRuMlwVo9YrT8rXxIQDT4pNpEG/x7GNQjww+hUvruJpkmw1SJJIeOE25WtdaiN3I
         m3SopzffE5a3cyknxyeW96lLYIyS9AUpbfZ6dELlF1ruUAv1+O0sHeR3OBIeLbR8koVU
         DVVMC0JDeoQteG0XBptSIo132Ig2rEAZ70Es3LqvBiNP3nkrIRddOmW4Dud+jyS8InMg
         BIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701755971; x=1702360771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyBGwSV+iJralP4K3/kIwnYMScArE6+I+gopISjyQyw=;
        b=CtREXwxDnywFEMqqiEDHFtmVP6PbNwbWK8T5d/tSD4hDgWcfZEDJG024LOwSZOtXVo
         3E0J4r5JOC/BwIoIg9LknTK5Ii4GPGeWNHfSYtoW6jY2VHMHbddrTfN6e2SHXjhIF85z
         /J+TetKciVLMZlyjoHtIlkCQsjtLPwlU1NKQD6egA+qGb1b1YO0yJFmzYHUHcfDBADid
         6hLHtoTGun1ojf+QRf6MTDSTqTseh0xCLLTiF4rKE9lfcf4Cb1ewaGN73Nq85dtShuNy
         hX6530hTJ3aTnHGksab3y61Ly5tEhgucw5B1xzw013km+G5xMaQJXnUx/T+CzoXdW69k
         SnSw==
X-Gm-Message-State: AOJu0YwK4JNx95U1tXre6WQpqZZbg7VoZrm8gjL0Yz8MhZ/0s9mjEEa1
        5OhY9DLwvdSWvxX/EcIZ7E68kg==
X-Google-Smtp-Source: AGHT+IE35oBHBjUxHb/fsvXUD7EoK8AoO8qb0p8T7qrANTR8Tdfrb7T2eq08xEU/xupFItC8DTcn3Q==
X-Received: by 2002:a17:903:1207:b0:1ce:5f67:cfd3 with SMTP id l7-20020a170903120700b001ce5f67cfd3mr2605429plh.18.1701755970999;
        Mon, 04 Dec 2023 21:59:30 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id jb7-20020a170903258700b001d05bb77b43sm7111605plb.19.2023.12.04.21.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 21:59:30 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, me@jcix.top,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH v4 2/3] xfs: update dir3 leaf block metadata after swap
Date:   Tue,  5 Dec 2023 13:58:59 +0800
Message-Id: <20231205055900.62855-3-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231205055900.62855-1-zhangjiachen.jaycee@bytedance.com>
References: <20231205055900.62855-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 fs/xfs/libxfs/xfs_da_btree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index e576560b46e9..282c7cf032f4 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2316,10 +2316,17 @@ xfs_da3_swap_lastblock(
 		return error;
 	/*
 	 * Copy the last block into the dead buffer and log it.
+	 * On CRC-enabled file systems, also update the stamped in blkno.
 	 */
 	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
+	if (xfs_has_crc(mp)) {
+		struct xfs_da3_blkinfo *da3 = dead_buf->b_addr;
+
+		da3->blkno = cpu_to_be64(xfs_buf_daddr(dead_buf));
+	}
 	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
 	dead_info = dead_buf->b_addr;
+
 	/*
 	 * Get values from the moved block.
 	 */
-- 
2.20.1

