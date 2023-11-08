Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548367E5030
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjKHFxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjKHFxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CAF1706
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 21:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699422752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBGE/0VZmoYE6T5NyEpzvQcz4+dbke+4O0trONkaIwA=;
        b=KVZmAehOykQY8sw6BKOOiTQSWKRTGhyXLj8apeYzmMO9XBrm24DK0lWwm/RhZ6G34hRKwD
        VfJyyp7B5plAFO++Upb7ZotCkFYd5xJDJb9Xg1ve717BJQzI1j3IDe+ZAcArjA70fKVqLD
        dTpgc9+BbrCzYVifCs1NMjzxLClUi2I=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-m3rQFnisPY684yxzxsjLGg-1; Wed, 08 Nov 2023 00:52:31 -0500
X-MC-Unique: m3rQFnisPY684yxzxsjLGg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc3ad55c75so44674455ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 21:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699422750; x=1700027550;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBGE/0VZmoYE6T5NyEpzvQcz4+dbke+4O0trONkaIwA=;
        b=W08EwcUQ6Ebgp0OB+gom0l+qF+vZJwersdwjwbHxW0nfhCTvv63HkECFBBtGy38i9m
         JaYYLCIT9xRQCuzxMU3D+STakJg3srFEfXzmZvJr0UeJBTX0V2sxI/715sU5tqOmIzFd
         EVAv3LPxyRmG71CtvZGvsHIbsVF8BkwcLnyPTB9RECo4wFR6CQpilATYnk4rR5VTqKaa
         9gnJrNyYk4XrSRD+8PkYhK6SLwQTYz+/WnbTJ4BrGO/CGFoFLlBAMId9ay6MCARSmY+p
         hEQoI/JwpoYt7Czgmg1EqM8s50+J8ikdNX1i8CV/vHcHzTBA1OpAFsp6PClvNaW/q/7v
         mqSg==
X-Gm-Message-State: AOJu0YwVAgKcrGNWvQ6CjO6jd2VOoS9zD70CrzGZ9F+usY28YZn+noAG
        xlfYc3JWW2n43PIJj8qvvHgSnu2Wspia6KCi8r5m5dnS0OpzyPAlC1X5YM3fIyRPCg80pdqbTMI
        ZBUxQr5nl91eXhT3nqzkchQebnNfw8Vnm
X-Received: by 2002:a17:903:186:b0:1cc:50ea:d5c5 with SMTP id z6-20020a170903018600b001cc50ead5c5mr1435878plg.24.1699422750142;
        Tue, 07 Nov 2023 21:52:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc5SciGddidkcawGVGQdyT7Gvy9ULncspDMuJ+MoqviGGad2QQpyyE0huCHg02paax74UBUA==
X-Received: by 2002:a17:903:186:b0:1cc:50ea:d5c5 with SMTP id z6-20020a170903018600b001cc50ead5c5mr1435871plg.24.1699422749847;
        Tue, 07 Nov 2023 21:52:29 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:f0fd:a9ac:beeb:ad24])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902934a00b001b0358848b0sm807931plp.161.2023.11.07.21.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 21:52:29 -0800 (PST)
Date:   Wed, 08 Nov 2023 14:52:26 +0900 (JST)
Message-Id: <20231108.145226.326983157567394476.syoshida@redhat.com>
To:     sj1557.seo@samsung.com
Cc:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exfat: Fix uninit-value access in __exfat_write_inode()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <9e8201da11fc$f9b461b0$ed1d2510$@samsung.com>
References: <CGME20231107143021epcas1p304b8b94862a8f28d264714f06a624674@epcas1p3.samsung.com>
        <20231107143002.1342295-1-syoshida@redhat.com>
        <9e8201da11fc$f9b461b0$ed1d2510$@samsung.com>
X-Mailer: Mew version 6.9 on Emacs 28.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 13:35:17 +0900, Sungjong Seo wrote:
> Hello,
> 
> A similar fix has already been queued in the dev branch.
> Please refer to below commit.
> 
> Commit fc12a722e6b7 ("exfat: fix setting uninitialized time to
> ctime/atime"):
> https://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git/commit/
> ?h=dev&id=fc12a722e6b799d1d3c1520dc9ba9aab4fda04bf

Hi,

I've not noticed the commit you mentioned. Thank you so much for your
feedback!

Thanks,
Shigeru

> Thanks.
> 
> B.R.
> Sungjong Seo
> 
>> KMSAN reported the following uninit-value access issue:
>> 
>> =====================================================
>> BUG: KMSAN: uninit-value in exfat_set_entry_time+0x309/0x360
>> fs/exfat/misc.c:99
>>  exfat_set_entry_time+0x309/0x360 fs/exfat/misc.c:99
>>  __exfat_write_inode+0x7ae/0xdb0 fs/exfat/inode.c:59
>>  __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163
>>  exfat_truncate+0x121/0x540 fs/exfat/file.c:211
>>  exfat_setattr+0x116c/0x1a40 fs/exfat/file.c:312
>>  notify_change+0x1934/0x1a30 fs/attr.c:499
>>  do_truncate+0x224/0x2a0 fs/open.c:66
>>  handle_truncate fs/namei.c:3280 [inline]  do_open fs/namei.c:3626
> [inline]
>>  path_openat+0x56c6/0x5f20 fs/namei.c:3779
>>  do_filp_open+0x21c/0x5a0 fs/namei.c:3809
>>  do_sys_openat2+0x1ba/0x2f0 fs/open.c:1440  do_sys_open fs/open.c:1455
>> [inline]  __do_sys_creat fs/open.c:1531 [inline]  __se_sys_creat
>> fs/open.c:1525 [inline]
>>  __x64_sys_creat+0xe3/0x140 fs/open.c:1525
>>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> 
>> Uninit was stored to memory at:
>>  exfat_set_entry_time+0x302/0x360 fs/exfat/misc.c:99
>>  __exfat_write_inode+0x7ae/0xdb0 fs/exfat/inode.c:59
>>  __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163
>>  exfat_truncate+0x121/0x540 fs/exfat/file.c:211
>>  exfat_setattr+0x116c/0x1a40 fs/exfat/file.c:312
>>  notify_change+0x1934/0x1a30 fs/attr.c:499
>>  do_truncate+0x224/0x2a0 fs/open.c:66
>>  handle_truncate fs/namei.c:3280 [inline]  do_open fs/namei.c:3626
> [inline]
>>  path_openat+0x56c6/0x5f20 fs/namei.c:3779
>>  do_filp_open+0x21c/0x5a0 fs/namei.c:3809
>>  do_sys_openat2+0x1ba/0x2f0 fs/open.c:1440  do_sys_open fs/open.c:1455
>> [inline]  __do_sys_creat fs/open.c:1531 [inline]  __se_sys_creat
>> fs/open.c:1525 [inline]
>>  __x64_sys_creat+0xe3/0x140 fs/open.c:1525
>>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> 
>> Local variable ts created at:
>>  __exfat_write_inode+0x102/0xdb0 fs/exfat/inode.c:29
>>  __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163
>> 
>> CPU: 0 PID: 13839 Comm: syz-executor.7 Not tainted 6.6.0-14500-
>> g1c41041124bd #10 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.16.2-1.fc38 04/01/2014
>> =====================================================
>> 
>> Commit 4c72a36edd54 ("exfat: convert to new timestamp accessors") changed
>> __exfat_write_inode() to use new timestamp accessor functions.
>> 
>> As for mtime, inode_set_mtime_to_ts() is called after
>> exfat_set_entry_time(). This causes the above issue because `ts` is not
>> initialized when exfat_set_entry_time() is called. The same issue can
>> occur for atime.
>> 
>> This patch resolves this issue by calling inode_get_mtime() and
>> inode_get_atime() before exfat_set_entry_time() to initialize `ts`.
>> 
>> Fixes: 4c72a36edd54 ("exfat: convert to new timestamp accessors")
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> ---
>>  fs/exfat/inode.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c index
>> 875234179d1f..e7ff58b8e68c 100644
>> --- a/fs/exfat/inode.c
>> +++ b/fs/exfat/inode.c
>> @@ -56,18 +56,18 @@ int __exfat_write_inode(struct inode *inode, int sync)
>>  			&ep->dentry.file.create_time,
>>  			&ep->dentry.file.create_date,
>>  			&ep->dentry.file.create_time_cs);
>> +	ts = inode_get_mtime(inode);
>>  	exfat_set_entry_time(sbi, &ts,
>>  			     &ep->dentry.file.modify_tz,
>>  			     &ep->dentry.file.modify_time,
>>  			     &ep->dentry.file.modify_date,
>>  			     &ep->dentry.file.modify_time_cs);
>> -	inode_set_mtime_to_ts(inode, ts);
>> +	ts = inode_get_atime(inode);
>>  	exfat_set_entry_time(sbi, &ts,
>>  			     &ep->dentry.file.access_tz,
>>  			     &ep->dentry.file.access_time,
>>  			     &ep->dentry.file.access_date,
>>  			     NULL);
>> -	inode_set_atime_to_ts(inode, ts);
>> 
>>  	/* File size should be zero if there is no cluster allocated */
>>  	on_disk_size = i_size_read(inode);
>> --
>> 2.41.0
> 
> 

