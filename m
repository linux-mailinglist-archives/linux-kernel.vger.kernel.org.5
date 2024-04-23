Return-Path: <linux-kernel+bounces-155992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C438AFC6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91147288253
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD6336B0D;
	Tue, 23 Apr 2024 23:11:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73C36AF8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913866; cv=none; b=nLmQ2cGWFXWun1Rt9Zrn/nIG+CLUtkaL/+IDtMAwoM+vmcP3iUHwGM4BvjQakStMjdr83bdGLh7XnmI3btOBB59BpUeBwqXl/5gyE60V8ws8MdAAWsZNl5GV/yuPZK8x2+KOyafgqlcPu/ajU2b24WH1qvSz7xaAqtKKQYbK9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913866; c=relaxed/simple;
	bh=IprRLrP4/OBNEf7yZBlJYicr3vDmv5ZOE/MNS6iX41k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i0ZgRhFyxdD0Lm5YQ/ksEHvI79uUsTMApLxKA3KipI8997q61Zg00n2CTKb2YPEuYXaAesya5rqDMuTowtsGpr8ozEzPr23OnNTBIsurWQbB1arLRrtg3QtUrUKhl4JpLxFk5ousUPXrydB4k88uAm5zDF5G7sLGjoOHHvULcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ddf0219685so152540639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713913864; x=1714518664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkAZzF+AxPebPQDG24hg0CBtvDuYtfCIICEEd/EnwVU=;
        b=CN66+SrhtU9ILHoL3flZpS3s69eST8pU4H/S1i7AbcKbd1C6VCcl8dI87yOzhaLvlC
         ZI4CWxg3af+6CvH9rsgzZVPF/C73FmshaKlTaboQBrFM6u34CmrJ0kn0frhj+FMiDtrX
         pv9A2gBYJ7gTmhqLVvHk3x9+/+/NCxDHXnZ/tcVLVr6r2sMAPpDK3EJUoNcKYqJUd79F
         N/HpFpXHjjH4Os/Z0suQmtuq6kau0hAffDRF433ElXzOO5BPuq/+dMwisFSDV4HQckY4
         KkOjAopNsEC3d3PvdrDcSXdsGzqJr2KOdAF3bMTvxpb1qUvciL5RKQIdhfEZFnUvQepd
         Vb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG50OBDuuS2whBPbxwP9QRZAGQAMlc9GW35san76QEklzattg3/8K8cW26FsSFpvpzXxNER1iRhYpCQgvAHoHFQicUEQ3PTw1Pi7xU
X-Gm-Message-State: AOJu0Yz9TCpWcApVwG328Dw9Nb+kkLKI7IdJmeKbSYjDvWoWSSPXgD0O
	88uBvjwinVqRsxFUjm1TwtrVbVQYtMaQTnOJDWOX39GvmXHDSwdrahYKHg7bO65Uo7p0ZogNWXd
	2hgh601b7VyktHQS9LaBO15wpuHLZezalFm8tGpg/48vJZoLMh2tx9gg=
X-Google-Smtp-Source: AGHT+IEveMiYHuDcZj/a2y6m0NqiKHSXJCwDxdTjEO0YpC8BQ2wwn8vMdO2N2zn107e7Vsl2oNvBMI17WPf7Qn1AwQFtrLEjmuYG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2581:b0:482:cfdd:daeb with SMTP id
 s1-20020a056638258100b00482cfdddaebmr112001jat.5.1713913864241; Tue, 23 Apr
 2024 16:11:04 -0700 (PDT)
Date: Tue, 23 Apr 2024 16:11:04 -0700
In-Reply-To: <20240423223458.3126-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000dd33b0616cbabb9@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in __unix_gc
From: syzbot <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com

Tested on:

commit:         4d200843 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=179a2a80980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=fa379358c28cc87cc307
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128da46b180000

Note: testing is done by a robot and is best-effort only.

