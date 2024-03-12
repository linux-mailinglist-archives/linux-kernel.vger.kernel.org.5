Return-Path: <linux-kernel+bounces-100025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE588790FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A61C21D56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBF379933;
	Tue, 12 Mar 2024 09:29:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C778289
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235771; cv=none; b=QiPJ8XnP2oVCH1FnPtaKMfxIz0PWX3Dj+uCsQPrl+NwB+IZgjr3jA6Q1rXHR2mTYu+Mk0oqd1r4oYo4tqlqfZQxRZ1FJenLfwnjcv54J939Gpl8g7mrCfkZKth4qqVxsyVXtGYqsr7oE5uUGfJG2ymOLLSVefB8ZxNPkwl+FzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235771; c=relaxed/simple;
	bh=mISnCRNrBVZrMYQ53f9k8mk7rmapdHLOM+rzryM25Bo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rlpIUSy505/LZErGciRG0gRJPmiUzPW9323MgEh1TfTETpWR7Y0fL4n3NklOHtcakeqw+FU1ahYJco+KvS+2Xr08ldJdiPcryoJ1pml9IYL7/4f3fNEs+4vJdRJsGYS3ZFlQH/na5IzCBIMsGl/9gw0kCChPIZJ8tBM0igFHHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8ae14c2ccso192847739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710235769; x=1710840569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dd3z8i+orPF3QV/wl6xzqYgpXBy4YLJkGho4zyPcEx4=;
        b=WxEBF5uXZkAup1/i6VlZ4OjexC5PWNp6y3av1R/Ff51tbEWHiWv44DxdZr3jhh4ZYv
         pE3YKNOrK3ns8pPRwoJEjM3Kx9flC4J/r9eC4hHUsaOYiTTYi6QlQaMiGrM+RcoqcZXW
         efSASZaB+9zgkabco0KsnzZWo2gla/Ga+ct+C9PQ7lPGgtJ0SrnlOkRT4ftWw/2H+9/x
         i7vHb8coA9GSHHDEkFwee5OBed5sfWsxLrN0XuzkaW/yRzYOZ1KFpFF2svPcggW0Yyc1
         FHlF8HzIIDDB3IKyG7P4s1a/7q9VL2NybQIStHz4FqLRpTYSNJM2MwlaHAXXylIZYM8U
         4Kgg==
X-Forwarded-Encrypted: i=1; AJvYcCWp2neIfYgun+eb79nq7k5QNVVQSc1l5v5ohXitZnfpIZ6S6RqpgKBJyH6IEG3vV4WGKxz4qdG90AXts4xMYXfKq/5uhFPePV7xj+SP
X-Gm-Message-State: AOJu0Yz34nz3SSeTL4ycsOvo96UgDrfNuwtH3HJ6pEK+QcnTI9sYUtUM
	TuaPz2NoJ+tYMPau2iQT+haJVVf9yk7iAfIcfeBT6dkeJHM09S5qiqo4Pu4dgwMWpjXdPIaGZ2u
	mwy51iNpCSJW/mH5BJPBXwx1dXhR5SHnbgSG2CR6if7PLmW4NWgnkF50=
X-Google-Smtp-Source: AGHT+IGq98iCqsDnSQkeiNPaj5MNdKvAZDHjBnRfQO/Gcd11JCE0t91MQzR0PBrcK6viWODPyJBaCraxIt1VH9lML8OKHRdRqK4a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3710:b0:476:d11a:33f with SMTP id
 k16-20020a056638371000b00476d11a033fmr93027jav.6.1710235769055; Tue, 12 Mar
 2024 02:29:29 -0700 (PDT)
Date: Tue, 12 Mar 2024 02:29:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f36a30613734ba8@google.com>
Subject: [syzbot] Monthly hfs report (Mar 2024)
From: syzbot <syzbot+list28302c815c5fd308cf50@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 15 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10200   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  9548    Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<3>  9352    Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<4>  5365    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<5>  3485    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<6>  2010    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<7>  884     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  791     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<9>  694     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<10> 687     Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

