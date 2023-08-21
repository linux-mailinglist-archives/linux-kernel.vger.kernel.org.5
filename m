Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A767C7822CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjHUEeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjHUEeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DB39B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692592404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Br/Gj1T78wovSAQTl1ZJ6wGykRttQ/DnXY6mK9SoBdM=;
        b=W75Wqdtx8X2ApusXGgIs+AXv/B6oqjlVMKEInzUQ5yl4AZvIS5bDAPFhX4EEq7y4tU1rjv
        W2CVQ55fcGw022eVbe4f4FekjzFdmaA+tMygXqOdBJQs89duhEdImzxbUJ/0fA5dTbHIEV
        2pYenDNqJseRugerXFSI3D9AcR4lvfc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-hvmGQqUIN8ahBG2s849zqQ-1; Mon, 21 Aug 2023 00:33:21 -0400
X-MC-Unique: hvmGQqUIN8ahBG2s849zqQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-563b4d68e07so4170375a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692592400; x=1693197200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Br/Gj1T78wovSAQTl1ZJ6wGykRttQ/DnXY6mK9SoBdM=;
        b=aK+iZgtr8lxkUR3hcHIMQVXivofbE+sEtyPb9UmQXyzOGD859AK7qgq+W5Z0Gl7uKT
         V2ZzDBgu07wAtcDIcSrTPr7VSNWCb/QtLz94yyxCe3U65HGB7msPB9ouop+A3seT9zwy
         i6A36/7T8MGnNJT9HhtuqgZnwekGrYdrKQ4DtcZUSUlyPulewYeJ/6S1Xnvw8huxsIBq
         tnx7zenZ/xYiMFEDkt3IXFL0dLQYE3kj7g6e/pKmUpqCegRP9+ChbtPkYKl5LEYflzZY
         UX42PFqbG3wuwLS/ckRwkzvFMrvQFu+PAelSCAZp797qebSIgL4mu6kPtasMAgZwSqjl
         Ssbw==
X-Gm-Message-State: AOJu0YyuYXVXu9oG9PFE3yg9Iexnccxv7PI0NAZxUpUa471KcAM5Ns4j
        K/pQRG9GdbTJjoZgh04mtty8GjGJN+s0/f5p5qkSLo47hnx5EnpDUJZzSPCfnAtJghDqMIketP3
        SkstFS9QMLarwKdsC1VzrOHr2
X-Received: by 2002:a17:902:ec84:b0:1bf:f70:a8a6 with SMTP id x4-20020a170902ec8400b001bf0f70a8a6mr6378382plg.30.1692592400518;
        Sun, 20 Aug 2023 21:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7yyfl+jfmEoZ/kSewcNfrVOkwn3jVHPcfdxUXPvL2Sp3UUmW4jt+oPMmoonZEtMRwxLBOhA==
X-Received: by 2002:a17:902:ec84:b0:1bf:f70:a8a6 with SMTP id x4-20020a170902ec8400b001bf0f70a8a6mr6378365plg.30.1692592400185;
        Sun, 20 Aug 2023 21:33:20 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b001bdd512df9csm5922794plg.74.2023.08.20.21.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 21:33:19 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     reiserfs-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, brauner@kernel.org,
        dchinner@redhat.com, dsterba@suse.com, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] reiserfs: Replace 1-element array with C99 style flex-array
Date:   Mon, 21 Aug 2023 13:33:12 +0900
Message-ID: <20230821043312.1444068-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN found the following issue:

================================================================================
UBSAN: array-index-out-of-bounds in fs/reiserfs/journal.c:4166:22
index 1 is out of range for type '__le32 [1]'

This is because struct reiserfs_journal_desc uses 1-element array for
dynamically sized array member, j_realblock.

This patch fixes this issue by replacing the 1-element array member with C99
style flex-array.  This patch also fixes the same issue in struct
reiserfs_journal_commit as the same manner.

Fixes: f466c6fdb3b1 ("move private bits of reiserfs_fs.h to fs/reiserfs/reiserfs.h")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/reiserfs/reiserfs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 55e85256aae8..8ed547893ae9 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -2699,7 +2699,7 @@ struct reiserfs_iget_args {
 #define get_journal_desc_magic(bh) (bh->b_data + bh->b_size - 12)
 
 #define journal_trans_half(blocksize) \
-	((blocksize - sizeof (struct reiserfs_journal_desc) + sizeof (__u32) - 12) / sizeof (__u32))
+	((blocksize - sizeof(struct reiserfs_journal_desc) - 12) / sizeof(__u32))
 
 /* journal.c see journal.c for all the comments here */
 
@@ -2711,7 +2711,7 @@ struct reiserfs_journal_desc {
 	__le32 j_len;
 
 	__le32 j_mount_id;	/* mount id of this trans */
-	__le32 j_realblock[1];	/* real locations for each block */
+	__le32 j_realblock[];	/* real locations for each block */
 };
 
 #define get_desc_trans_id(d)   le32_to_cpu((d)->j_trans_id)
@@ -2726,7 +2726,7 @@ struct reiserfs_journal_desc {
 struct reiserfs_journal_commit {
 	__le32 j_trans_id;	/* must match j_trans_id from the desc block */
 	__le32 j_len;		/* ditto */
-	__le32 j_realblock[1];	/* real locations for each block */
+	__le32 j_realblock[];	/* real locations for each block */
 };
 
 #define get_commit_trans_id(c) le32_to_cpu((c)->j_trans_id)
-- 
2.41.0

