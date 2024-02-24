Return-Path: <linux-kernel+bounces-79352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82142862116
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98177B215EA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6E5639;
	Sat, 24 Feb 2024 00:15:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8099D383
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733707; cv=none; b=hAF+EYw2QJKj7hl0JqjE1/V0pgcUKSoLah9U74lQND+GXBgWt/+0skwD/0VoY95ugt7nIDl1V+vv0nMbK4DB3pZ41goV5WuMvYExz0119VFuvkJVKgQXt7LO+M+SytUan1j2r8OvLtAKswLxuY+q2jqVQzdvPAMsK8uVRgAo+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733707; c=relaxed/simple;
	bh=rifFkqhLkRjhyNJhTggXVscRXS2KYIr/f1tjY8PNNFc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dvEhdm9jTrfPoIaN0gesw99D8hEVAlyVI83bLWww4uaNNI8iiaD7zuMlb4haQmzZt9ng6IZxWgJTvV88/EZ2OggFzWIoAUf/CjscXT+nHi3sCAbJgHLDcUw14kg/AaK3BhGzObqj/xCmGnZOdpedOKr4gBg4vVQchEwuT8clwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3657ef5f01eso12956635ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733705; x=1709338505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt8rcUjb2UnSpbdYkOVp+f1An4+KPMLnm+gTZICJwyI=;
        b=mzeXYoSKdNZBXXQP9Eji9HDye0K4hpIbxOcs/lfgibs4JjgDx/OxmcxVlpPj4wxGPK
         6sF+LNga8/KByvTvLwBRgjP+KtQAQOr3sRWFRMcqy92p0nUmMTNLJBxraVVV95HKUwdX
         bvNt3YVaDR/oYSJBrYjjNFtQ56j21y4QYm+V3YRFLwrLi3Fu4Hr3bZ6wpXnnkjrAk8Aa
         Ign5lMJLLOBIxxzLNVjnzgYycUCc763RA3PhID+S0VwpyvkyLgmgCiDvz8FisKNck8DP
         oqRoUf2g+NZJAc3Tf6GCxcDbJp5+uaqPILtNTJpUylD2BHslTcxeJaEEKFro5kPp9oyn
         DXrA==
X-Forwarded-Encrypted: i=1; AJvYcCUSB5ErgEtnab5bHaAMt3avqc7aRMOqN591BDA+ewtT7tfMt9khPkkDBM1nYgzZv6S21hn5H32g2+OxM5c/x5vsW77OuXR8IzV0J7Z3
X-Gm-Message-State: AOJu0YzORAarYuYFYc2zIJ7je/MpLMGnYJw0BVY+sgJFStU3ik4Qewyu
	pIyHonxmNiBQcOb3sHa9y0AIu8MTFXseawneWtIwT1znR8e+Pqcg8PYtrm5g71Al0UDq+DfDGVx
	nPfys+f1YAQNEeOWZg0Ynal2GEW6z9NZAO47Rm9ZspGYpw4G+Ooah1sw=
X-Google-Smtp-Source: AGHT+IHR8m3nXhK0O2sV94EHJUuPAqVxO8Mxz27X7StHBFMy2f53w8xYOntkLOC7WleqEZ5D3qhE5zCu6bV1SruaiG8Wd0crnpw7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c563:0:b0:365:88b:3fba with SMTP id
 b3-20020a92c563000000b00365088b3fbamr70631ilj.1.1708733705764; Fri, 23 Feb
 2024 16:15:05 -0800 (PST)
Date: Fri, 23 Feb 2024 16:15:05 -0800
In-Reply-To: <20240223230204.297-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c49c3061215913e@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
From: syzbot <syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com

Tested on:

commit:         9abbc241 Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12633cc4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af5c6c699e57bbb3
dashboard link: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138fea02180000

Note: testing is done by a robot and is best-effort only.

