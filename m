Return-Path: <linux-kernel+bounces-98052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C09D877419
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 23:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C38C2817E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0151524AE;
	Sat,  9 Mar 2024 22:20:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238E47F47
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710022805; cv=none; b=YCe9BlbAQoM367UBU8Ie21jGgtkbMANQ+VWXecMTl4h2Uaco7QHtohJHEJINod1pWHtv6JzfPBH4nkYI6SFsHo/80/3IbdLlJ/qDYWzux8nPXZobAXs5XIywYLTr33Gx9ryGp6Q4iHme89d5iTFmiuHnWlWM7EC2I3XIMhse3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710022805; c=relaxed/simple;
	bh=zFhNXKbHLt203SwwQ+ckq7WpijojBJ+o7aN23dGfPCo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VOva9j2LXV6XohdKjJOzBG/wk2lmORTI7+1n06jV3RNa02O2zrjiISITOhQTwGFORUmVxN52cG6riDgteD9j+BC+DAWQUAyZ0QwBUXG8LcSrpXPEIRiwB4qjUXYlAQEkhCLBQpNQVT8vEVXo2xUsI1GGamYtcxUMQOOH7BE/F1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c84b3570cfso323124939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 14:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710022803; x=1710627603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPIQ5P+kw5ZjaCXLN4LFGtLM3L78K1ihJHtxoWuotIA=;
        b=Ew7pSwpZ2tLTQC598vvzG+Fw93EhhZzLbqGjPzkoFApqVr6xjxJiZ40oeIm4WsgKZ0
         DAhVTR5uznRH0ZHR6NiTTDEiHTk5Gs5Cp8HwTyxGCt+Tlbp/7mo4UEYMMrCFvFENvitm
         Y+oCw2PqBjggiCnARyU24as3BZw2VRBEGFbP8jyADPxk/CeK7rk7RsZ2MgmV8BJMjSeE
         Z4480Q1YPHWnLb9b2nAVTILxUGssdcxNKzweEZvsEodx6cQRQVeOaxff4/oCXNjvC4C7
         n+hgwkixyzAAk61W2tLsmzHTZZ4yIQiZnh/DNSaVUfsYON411qQwGuoZlK1BtMP8tB66
         uokg==
X-Forwarded-Encrypted: i=1; AJvYcCX9zxG4asi3SRYXmYmiReamfmc75GHgf3H51CS5iOduevUW/iF501F/zHKdykcmIBd+3S3X16leQAZzVtowX14IcWQLVgESRBfzt+jv
X-Gm-Message-State: AOJu0Yxvwlu3VCNmHRHVnl7xLOYLaQWzHOg8Ru7oKXa9RHp/daX3Hwl7
	+9eySpa11Rg77gL0MTZKZq0TY3xqbJgk5p0jNz4FEGv3R3Jbae2LQabwF5ijfzgy0Bd3SoUbVIM
	2mV+atuMQHsvNpZFZGg2s06gV17pNi7AnNCiIJyYftPrtz08eyROzDro=
X-Google-Smtp-Source: AGHT+IGSVfooHSgQwTj5YVYCcfxioZPTQ9PhJk3trwjRuYHiOmZVPRfAANHZslMUL0ge14sAYcOQNmNuc8GVHbuxjaDiEEOQB1Xi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b09:b0:474:8aed:36d2 with SMTP id
 fm9-20020a0566382b0900b004748aed36d2mr204238jab.2.1710022803352; Sat, 09 Mar
 2024 14:20:03 -0800 (PST)
Date: Sat, 09 Mar 2024 14:20:03 -0800
In-Reply-To: <0000000000007bedb605f119ed9f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c07a08061341b549@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From: syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	jeffm@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	roberto.sassu@huaweicloud.com, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c28556180000
start commit:   5eff55d725a4 Merge tag 'platform-drivers-x86-v6.7-7' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d80b99e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148cccdee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

