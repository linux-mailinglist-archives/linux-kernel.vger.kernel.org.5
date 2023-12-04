Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981C88042C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbjLDXqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjLDXqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:46:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518AFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:46:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dae71322ed4so3482076276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 15:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701733580; x=1702338380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mUymHRPuxHIIlrnrqmrnoyhDvTW+Hjf6wrxLrnIWncc=;
        b=E7SkVGFFCrkwGcWAvL968rPiPkQ8gfxxGfqf5FIKfAt6GBdKmxCFxzZS209GiX251W
         0T+4CvP0NXwuZGyFJeKUO3PKSWtI8N/fF6b1BMln4YCK0LEHua91EepJcllGEy1VsSIL
         jU8aUzD8ynKCM6xZBCO5yeJljsbTd5SrgKCDvxYJaPH+ToV9CWAG7b2a0MlojI7JrbiM
         a3+Ql66AstmrTcvqlbgBxmIzKyrsrK/+H0PWur3dfdrR4W3n0fCSjCdW6bGDc7eaqjqV
         L49Z976Bs0PdLX5RfGd2d+W5SDoDdbyN8OM262jsrTU2a10tw7iCUNkfrYeEzhrrHcSz
         ACJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733580; x=1702338380;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUymHRPuxHIIlrnrqmrnoyhDvTW+Hjf6wrxLrnIWncc=;
        b=pDxHOZF8ey3KXONlGOHWZ6KB+EyUfKW29ESQVyvc7U4gOloq8ZDgizFDY3hFu6ZFMS
         Qi+hzlFb5sL246hNJJ+OWGWfZVc7uFJ3BCLC9oO2KhOnlPTWaaLS+Uv0UHOT+Q0IbzZB
         UetbnicLiX4Yl+Jkww/wUDixLK0JtC9Y/AYo9dbSHaQId8k+kLLrDVmsuBri45tc1ix8
         DaG8xfV5NjARojXP1K8vRom6yGnIfGjrS956ZkprltHRC98LdNrx7tPxu7WtkDJK+2FE
         xreD30YwqffQp4kQ62wPXwUy61ygTzIw0BY7K85dK//wPlIpyd+yW7bMrTzQ864isNzY
         EgnA==
X-Gm-Message-State: AOJu0YyxPIH9WzKNQ7lRNvhUeusgk4FWg2DBAGK237VxdhgHLvpOPEpB
        YrcTOEzfb2zwHyxgx85MBngCASGFWVM=
X-Google-Smtp-Source: AGHT+IHq0SjWmG+nLZUtdxneA/JrpUr7QGWRDcSdZO7VpafKGKWVxgfIRv46tf+blV+TIKsoHoyYIge4lyY=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:5074:e7bb:c7b:6a8a])
 (user=drosen job=sendgmr) by 2002:a25:ca16:0:b0:db5:382f:3999 with SMTP id
 a22-20020a25ca16000000b00db5382f3999mr474717ybg.1.1701733580100; Mon, 04 Dec
 2023 15:46:20 -0800 (PST)
Date:   Mon,  4 Dec 2023 15:46:15 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204234615.3592624-1-drosen@google.com>
Subject: [PATCH v2] f2fs: Restrict max filesize for 16K f2fs
From:   Daniel Rosenberg <drosen@google.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blocks are tracked by u32, so the max permitted filesize is
U32_MAX * BLOCK_SIZE. Additionally, in order to support crypto data unit
sizes of 4K with a 16K block size with IV_INO_LBLK_{32,63}, we must
further restrict max filesize to U32_MAX * 4096. This does not affect 4K
blocksize f2fs as the natural limit for files are well below that.

Fixes: d7e9a9037de2 ("f2fs: Support Block Size == Page Size")
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..18a2189a0dc4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3364,6 +3364,18 @@ loff_t max_file_blocks(struct inode *inode)
 	leaf_count *= NIDS_PER_BLOCK;
 	result += leaf_count;
 
+	/*
+	 * For compatibility with FSCRYPT_POLICY_IV_INO_LBLK_{64,32} with a
+	 * 4K crypto data unit, we must restrict the max filesize to what can
+	 * fit within U32_MAX data units.
+	 *
+	 * Since the blocksize must currently be equal to the page size,
+	 * we can use a constant for that. Note if this is not the case
+	 * in the future that inode is NULL while setting up the superblock.
+	 */
+
+	result = min(result, ((loff_t) U32_MAX * 4096) >> F2FS_BLKSIZE_BITS);
+
 	return result;
 }
 

base-commit: d346fa09abff46988de9267b67b6900d9913d5a2
-- 
2.43.0.rc2.451.g8631bc7472-goog

