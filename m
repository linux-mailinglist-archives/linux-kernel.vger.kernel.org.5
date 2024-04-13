Return-Path: <linux-kernel+bounces-143494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9B98A3A27
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886811C2135B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8874B9461;
	Sat, 13 Apr 2024 01:40:49 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2034C97
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972449; cv=none; b=GKWKKxsAvkVlW4E8LUBXB8aY1arqQ51ZP6YSASbfdKr2bFkIFZ/5DlIYQb44mb24NLE0eFYDVA8EbcpWvTFralKcyXech6wsT16kqviZ3zrPk6CjHV+OF2Aw6C7u6ivLoyGhqanNuwzrXZ0O5sCl1uT53HA1Yr33oZkBfR+vqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972449; c=relaxed/simple;
	bh=e+E1Ec0oTaN19dEWIyIQnYGFtuI3vCcAgC7gE8NBcMY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y4Rey2izNN5EMyFV8CqnalBq156I+oz+dGVp+Ase42X5pE1A6mdONFLOjSD12RavwHFGNwXjbt1YXvyPPqSKvkcofGhV74BmF5RLJJnKc1S7TdM4Fz/dJlhf2YzuSEz29TaQOQ6DT8b7ee0xsnA7lr3zEeci2JhZR3UEUm15hVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d5e2b1d05aso157404839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712972446; x=1713577246;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9q+AJtCE1QySXDmN1Cnk/o5LPFJdmAvLyzZEzOfRaE4=;
        b=Krm6V2H6T19BqutIZ8FQHw0Iazir+cKILxY1ib02F4b+fhuvVfhxqdMl8FuH252JEl
         Q+Pz4fY+FUXMcyLOCty5qPudQsK/dqWKZf6P99Aalum5nBDH5p4dr8RPvaNZVUka9leG
         bci1tp8r7e+mPFkytS/yKuXoy9gzxvN6l1ih/6yoSPF1adlMkRtuPfaYqY4mdwLL6wgp
         +BL6/xtBXc25Mxl/0kDX0uTodmuwl++vQRAOaWkvkiNgP0kVCsurTvSv4TThhSouTblS
         DhSgvSLa1mYCZR6Zxl0CEUeNs8/ev67VwKL1xJ35zGLGwjNfNTXaGDPFgDgwtWczu4Qu
         nnqw==
X-Gm-Message-State: AOJu0YxHOrSuDL4gjPLweUVKoimfFG627bj2TG7PQfju23GvHUBUYJZK
	IfQE+mmFe1k+KbjuLmzW4hBLtTz+M8RgVmK3/1kve9v1irlSxeySj6ErL0+4+DXBt60E4pEfqKx
	HwFoQAqzmITF1wQfhm4llkUwJqanLUA2knMpn3y1Pgogb2mzeVkD1jcE=
X-Google-Smtp-Source: AGHT+IEMBL6QYiaEZBHDhNgeyVSGrC8foZB1DZLap0JANY5agQWYITqgC/S0Od3zOyZo8hrfuErqr3nbBSqCO0W2emQmKafFTtJq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:36a:20a2:e47b with SMTP id
 l2-20020a056e021c0200b0036a20a2e47bmr284450ilh.6.1712972445996; Fri, 12 Apr
 2024 18:40:45 -0700 (PDT)
Date: Fri, 12 Apr 2024 18:40:45 -0700
In-Reply-To: <00000000000042c9190615cdb315@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000276bf20615f07a61@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
From: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
Author: hdanton@sina.com

On Thu, 11 Apr 2024 01:11:20 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240410
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1621af9d180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  6ebf211bb11d

--- x/fs/notify/fsnotify.c
+++ y/fs/notify/fsnotify.c
@@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
 	wait_var_event(fsnotify_sb_watched_objects(sb),
 		       !atomic_long_read(fsnotify_sb_watched_objects(sb)));
 	WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTENT));
-	WARN_ON(fsnotify_sb_has_priority_watchers(sb,
-						  FSNOTIFY_PRIO_PRE_CONTENT));
+	WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_PRE_CONTENT));
+	synchronize_srcu(&fsnotify_mark_srcu);
 	kfree(sbinfo);
 }
 
@@ -499,7 +499,7 @@ int fsnotify(__u32 mask, const void *dat
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
-	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
+	struct fsnotify_sb_info *sbinfo;
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
 	struct inode *inode2 = NULL;
@@ -529,6 +529,8 @@ int fsnotify(__u32 mask, const void *dat
 		inode2_type = FSNOTIFY_ITER_TYPE_PARENT;
 	}
 
+	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
+	sbinfo = fsnotify_sb_info(sb);
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
 	 * be expensive.  It protects walking the *_fsnotify_marks lists.
@@ -539,8 +541,10 @@ int fsnotify(__u32 mask, const void *dat
 	if ((!sbinfo || !sbinfo->sb_marks) &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
-	    (!inode2 || !inode2->i_fsnotify_marks))
-		return 0;
+	    (!inode2 || !inode2->i_fsnotify_marks)) {
+		ret = 0;
+		goto out;
+	}
 
 	marks_mask = sb->s_fsnotify_mask;
 	if (mnt)
@@ -558,10 +562,10 @@ int fsnotify(__u32 mask, const void *dat
 	 * Otherwise, return if none of the marks care about this type of event.
 	 */
 	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
-	if (!(test_mask & marks_mask))
-		return 0;
-
-	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
+	if (!(test_mask & marks_mask)) {
+		ret = 0;
+		goto out;
+	}
 
 	if (sbinfo) {
 		iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
--

