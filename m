Return-Path: <linux-kernel+bounces-402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4317181409C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9901C21E16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536846BA;
	Fri, 15 Dec 2023 03:26:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB620F9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b74bad5ea5so32728939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610762; x=1703215562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8L4f+5tKvr0PBNnfFmfd5h0rlvnnStP6aBdKq38GBA=;
        b=LmCKHhZAMkM4J8M3JmjfoQ3Jbt5u8azdxsfsokuqbnUXioovt4Rj8NtC56L46PCcr1
         qzp3G9X3bMAabv9ohNwNtuMzoEsr8XiQBIWeAie7gkamIVxEzWH1zMQhpPE1E8awSWtC
         EDt6hUDXkZxMt+PkwEYG2KG0eIdzIbj1GqhAM9O+Cf0UOMZskgLeUErNJs+zQ7oDxwYG
         fq4qazJFKT2dLspxI9QtKMxwh5JaikRketsI6TSn+gy8PQXK1V14tfbMxRMkOJyOYZ3T
         /0hFmMltjSYGlr5kSBZWvll3C4MPlq+ucp86LGLQKG47ph/1lHyb4vRkcsE/VT0S52YB
         9w3w==
X-Gm-Message-State: AOJu0YwzAxwwf3PA3FgV6p/OsS3OKz3q9Jmu95WQzcpbtOadcddDQzXc
	AANqGVmQ8Q5/28v8zhPO4gRbBtRpYIFg+L2Hc10DEAMa/IJLKis=
X-Google-Smtp-Source: AGHT+IHMWkdjANRlRQtgnLH8TzSRwuEH7BvCJhnsOfElc6cmW47WUg3fJA9p/i7wzKSbWStv8Sgh6dzJYR7lx8bi+qYQ8MJ4SxL/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41a1:b0:466:7cfc:bef7 with SMTP id
 az33-20020a05663841a100b004667cfcbef7mr216883jab.1.1702610762513; Thu, 14 Dec
 2023 19:26:02 -0800 (PST)
Date: Thu, 14 Dec 2023 19:26:02 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0c2ea060c83f56c@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [ext4?] kernel BUG in ext4_write_inline_data
Author: eadavis@qq.com

please test kernel BUG in ext4_write_inline_data

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 44c026a73be8

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 9a84a5f9fef4..e0d261ffe623 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -169,6 +169,7 @@ int ext4_find_inline_data_nolock(struct inode *inode)
 					(void *)ext4_raw_inode(&is.iloc));
 		EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
 				le32_to_cpu(is.s.here->e_value_size);
+		printk("iis: %d, in: %p, %s\n", EXT4_I(inode)->i_inline_size, inode, __func__);
 	}
 out:
 	brelse(is.iloc.bh);
@@ -232,7 +233,9 @@ static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
 		return;
 
 	BUG_ON(!EXT4_I(inode)->i_inline_off);
-	BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
+	printk("pos: %d, len: %d, in: %p, iis: %d, %s\n", pos, len, inode, EXT4_I(inode)->i_inline_size, __func__);
+	if (EXT4_I(inode)->i_inline_size > 0)
+		BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
 
 	raw_inode = ext4_raw_inode(iloc);
 	buffer += pos;
@@ -314,6 +317,7 @@ static int ext4_create_inline_data(handle_t *handle,
 	EXT4_I(inode)->i_inline_off = (u16)((void *)is.s.here -
 				      (void *)ext4_raw_inode(&is.iloc));
 	EXT4_I(inode)->i_inline_size = len + EXT4_MIN_INLINE_DATA_SIZE;
+	printk("len: %d, in: %p, iis: %d, %s\n", len, inode, EXT4_I(inode)->i_inline_size, __func__);
 	ext4_clear_inode_flag(inode, EXT4_INODE_EXTENTS);
 	ext4_set_inode_flag(inode, EXT4_INODE_INLINE_DATA);
 	get_bh(is.iloc.bh);
@@ -381,6 +385,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 				      (void *)ext4_raw_inode(&is.iloc));
 	EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
 				le32_to_cpu(is.s.here->e_value_size);
+	printk("iis: %d, in:%p, %s\n", EXT4_I(inode)->i_inline_size, inode, __func__);
 	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	get_bh(is.iloc.bh);
 	error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);
@@ -469,6 +474,7 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 
 	EXT4_I(inode)->i_inline_off = 0;
 	EXT4_I(inode)->i_inline_size = 0;
+	printk("iis: %d, in: %p, %s\n", EXT4_I(inode)->i_inline_size, inode, __func__);
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 out:
 	brelse(is.iloc.bh);
@@ -1979,6 +1985,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 		EXT4_I(inode)->i_inline_size = i_size <
 					EXT4_MIN_INLINE_DATA_SIZE ?
 					EXT4_MIN_INLINE_DATA_SIZE : i_size;
+		printk("isize: %d, in: %p, iis: %d, %s\n", i_size, inode, EXT4_I(inode)->i_inline_size, __func__);
 	}
 
 out_error:


