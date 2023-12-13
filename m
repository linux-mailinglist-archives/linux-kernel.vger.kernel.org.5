Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB4810F82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378610AbjLMLL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjLMLL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:11:56 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EC1A0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:12:03 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2865a614ed6so4134367a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702465921; x=1703070721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDGnVUEjGLM/KrqNZKG5GqxtRpBtkmZfbZ9eKL9zCH8=;
        b=aLpBFf7+d/lrG7T7p/1sJgwRrqLDQdDtxdcgpxsubmHUwn5eKVnd87rLJFnuH6sihw
         7H7QtLVhGe7Fj2G1o9+E5LPdgQYnQvd2BTYoJIxf8Zjg+TjYgnwvY3kxB2LUrpQ2SUVs
         /b93VMjxDchBpY3lpdD82OuaDlIhT0y5mWVJIICCZZLCa2XMxXE1io9nj1YhDIQNFLCO
         IeR5H/LO27i3qAABxJKthPkz7MUkSQS5iKR6gQDvkz9TvQGHyLYBOjcAo1h9YbqU+Sow
         7Zoka5NdWhjoEc1+AQPf6FBVNNeRjXvVkMLDWZ4gUzl+CszDcGKdYtSx7eSovVQ/lGSt
         98mg==
X-Gm-Message-State: AOJu0YwywfWoGdArwwVtyWe76ZGAwzWVJLuYtQdVWAAcYStslsR1yW7h
        QJp9h58q8c8Lz5Ye4sF9jaUwHzoj/oTeW8XGYgquUMgV+ycCh/g=
X-Google-Smtp-Source: AGHT+IFwPRQTD7rWpYUHgBXHM87js9qf6C9AV99Q5Ef5utxuaQN0XTf8zohztn59DTeIDJ4tCaB/6oARjeMhZ3I31t1peyCCIxdW
MIME-Version: 1.0
X-Received: by 2002:a17:902:da85:b0:1d0:bde3:25a1 with SMTP id
 j5-20020a170902da8500b001d0bde325a1mr114064plx.12.1702465921762; Wed, 13 Dec
 2023 03:12:01 -0800 (PST)
Date:   Wed, 13 Dec 2023 03:12:01 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000824aa2060c623c6f@google.com>
Subject: Re: [syzbot] [syzbot] [ext4?] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data
Author: eadavis@qq.com

please test kernel BUG in ext4_write_inline_data

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 44c026a73be8

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 9a84a5f9fef4..2ab1ca192167 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -169,6 +169,7 @@ int ext4_find_inline_data_nolock(struct inode *inode)
 					(void *)ext4_raw_inode(&is.iloc));
 		EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
 				le32_to_cpu(is.s.here->e_value_size);
+		printk("iis: %d, %s\n", EXT4_I(inode)->i_inline_size, __func__);
 	}
 out:
 	brelse(is.iloc.bh);
@@ -232,7 +233,9 @@ static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
 		return;
 
 	BUG_ON(!EXT4_I(inode)->i_inline_off);
-	BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
+	printk("pos: %d, len: %d, iis: %d, %s\n", pos, len, EXT4_I(inode)->i_inline_size, __func__);
+	if (EXT4_I(inode)->i_inline_size > 0)
+		BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
 
 	raw_inode = ext4_raw_inode(iloc);
 	buffer += pos;
@@ -314,6 +317,7 @@ static int ext4_create_inline_data(handle_t *handle,
 	EXT4_I(inode)->i_inline_off = (u16)((void *)is.s.here -
 				      (void *)ext4_raw_inode(&is.iloc));
 	EXT4_I(inode)->i_inline_size = len + EXT4_MIN_INLINE_DATA_SIZE;
+	printk("len: %d, iis: %d, %s\n", len, EXT4_I(inode)->i_inline_size, __func__);
 	ext4_clear_inode_flag(inode, EXT4_INODE_EXTENTS);
 	ext4_set_inode_flag(inode, EXT4_INODE_INLINE_DATA);
 	get_bh(is.iloc.bh);
@@ -381,6 +385,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 				      (void *)ext4_raw_inode(&is.iloc));
 	EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
 				le32_to_cpu(is.s.here->e_value_size);
+	printk("iis: %d, %s\n", EXT4_I(inode)->i_inline_size, __func__);
 	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	get_bh(is.iloc.bh);
 	error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);
@@ -469,6 +474,7 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 
 	EXT4_I(inode)->i_inline_off = 0;
 	EXT4_I(inode)->i_inline_size = 0;
+	printk("iis: %d, %s\n", EXT4_I(inode)->i_inline_size, __func__);
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 out:
 	brelse(is.iloc.bh);
@@ -1979,6 +1985,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 		EXT4_I(inode)->i_inline_size = i_size <
 					EXT4_MIN_INLINE_DATA_SIZE ?
 					EXT4_MIN_INLINE_DATA_SIZE : i_size;
+		printk("isize: %d, iis: %d, %s\n", i_size, EXT4_I(inode)->i_inline_size, __func__);
 	}
 
 out_error:

