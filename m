Return-Path: <linux-kernel+bounces-101419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832D887A6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6A7286216
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14B73F8D1;
	Wed, 13 Mar 2024 11:11:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FBE3EA94
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328264; cv=none; b=jdLOHJVDhFUHcot9qXyedD9Ae4rwxgUYb1rAGydlg+r2E6/tL8dY04m6bDLhISLVfS+btvREAdV4FA4LxTfalTH5dj6Y2YMENapYleXBwzt8WbP02thy/sc3tQTW6S8ZIUD4NijLEQb984OCLYPOFErlfz46pyKrkkNWnAJ4HdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328264; c=relaxed/simple;
	bh=krDBWLkCksHvcCVwuVZHOJZxILbXM8XQWz4eTUBRtws=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SQiH+poQD5jhZhYS2PPCfNex2LdbxYxjh8zxA79ATTQW6C3JcinNLgQkJjjRskztG3MFBCiZuD1AOGZfIkxbfRJhJkQVO54rohCQdKpDKj+6DkX5RWtr0q3JhXc3YII4VapoErJNRGJlHDumtyXsbp1hAU02OiHiFJtnmwEtpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36677ca965aso4236695ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710328262; x=1710933062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=og43RopSDbtIXOr5b/QeLC2pWLh0Ixgs+pA7WVJx5ec=;
        b=osZpsARLuFfEPihEbhOlbcC2QLMAbCJIJbmpG2NcMTfO1LC+uzncOLEMix9CbqgOis
         W4p4/C191SoG8gfkfTQe4b0GwcjOr5ougGi4o2g2Uug0hvcxvP5VhP7NfPExRlxD2ukO
         vVEG0MvoCC0crnsRXM/Gu5SHKm/Mu6m6uF7hLrYMEhzF29zYOY9jEs57N5prfyYadzlN
         kRjy7uB+DgCieokNJHo6FYKkcKrabhNCcKiay7CDtFWpnjl/3BKIFeop3fDau1K4LzRZ
         5BC/kD5++ZRZQoQxfEl/AJSjxrcfexzcqRIqDmOLek2MeQb4aYvEdF+qf2gSsT7B6hDA
         RTbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXLC7HoIxDXwF/CtPf+znokTb1zHcx66Ga0I5zgJ0r29aOUTIGFgoJTIrofFXE39v+d1Q/aGfVdRmp0R2lMa8jFofFGhZmga/hA51y
X-Gm-Message-State: AOJu0YyTT9dkzMlkjcnUcBJsB8N8/weG/1K7TEaValAhVZ5Cv8JncszM
	oqpqs2EfyAE6od2KVMUA3hlSEtx8EdcPqGg8VHjmHwsqu0DeNs5wJXh9AzYIMUWhV0hYUMyIHzB
	VW5iGSLfKm1dqDsVAu/XJRkuWn2EHomYk2LMaOY/ujoo0Mfr1O/Cz0Wo=
X-Google-Smtp-Source: AGHT+IFaPEtekJpvI19Rdgsih8mBDripRhpN/aYvFtOZCwZOz7KH171DUMzoli3mUYqTPnAJ0c4PIa3brACgehgGgTMmaDCgP4fK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:365:26e3:6e60 with SMTP id
 d12-20020a056e02214c00b0036526e36e60mr427700ilv.0.1710328262063; Wed, 13 Mar
 2024 04:11:02 -0700 (PDT)
Date: Wed, 13 Mar 2024 04:11:02 -0700
In-Reply-To: <20240313104628.2178-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082883f061388d49e@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
From: syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com

Tested on:

commit:         b0546776 Merge tag 'printk-for-6.9' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15d3a48a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a7ce1a180000

Note: testing is done by a robot and is best-effort only.

