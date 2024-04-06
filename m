Return-Path: <linux-kernel+bounces-133741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7046789A7F6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10ED11F2327B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45617C2;
	Sat,  6 Apr 2024 00:34:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7534C7C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712363644; cv=none; b=kQ6eEtoY+sqjBL8UmCWOHOC4AVFV68AVewS++1BMi9zXxBiER5a8XK8I+hEoha8LoHuBwv9GDfqGrQU15uJS9AVJYMcHbmZHAVVxIdZoCc/ymZ6WyLL5Lzn/dwQA/GHzcY0aXmtGA9NGycomGz/SjB8nRFYag+thAc5aQWnP13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712363644; c=relaxed/simple;
	bh=nxCLcCNTmd8UIMICvGHcN5UPjHEENzSxGDWwXQZisOs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CzgyjikEIJsewSba1tCjnjkS6169V8AK96gdQvrwxIQRv38tUScVnvVn/FSUlSZcrOcOuvgP+Xy4ZVeGlIeaDpRL2oVVSYORkG4hYMENxqUBhRkoUnrI0hHco1fxOnCWGmrtzgzq4ZBWAVnjamWgqobvuvYs0sUyd7lTOpgltys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf3ec6a96so313309539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 17:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712363642; x=1712968442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8TX7iG9YpCaPmFEMKF2n7TPDi7Rx3R7SjsusnlXPLA=;
        b=EfgaNuAp3oMblPj6rvZfsmIpWIu02wWypEAemgvOXVqCfIzb2r+KqOvczfCZFpSAy8
         aKmV7Q+fT5/A9Ne37axw6CjByNGCpJy/CygCb94sshDebnPVn3qUgUl3YVUKnMTORr04
         4rt8edm3oJGdAXOfuz1r8eqYjTwN2l/l2hNryls36qbkr9AiTKgC5UEw0KFpEduuoYfK
         M0eU8n6yREezZOo/emu5yxUgwzw8KJVXtRBiqnVLAEVoMWTFHS5H61nl52jYkQbZhI4S
         Bi8EdHvbiEzlYClN++dDfHauA1Iaf8JWCFo6TtjT20KtEkZWN4PwC1jngPB+H9CP8IPI
         7pow==
X-Forwarded-Encrypted: i=1; AJvYcCXcY8brrxGwZUcNT9QQRt2QquUSFv9c6y96FXBC1LExs/4GDow+Zx58kPl/XabGG4/WrRAT41P7JGrnypiGiitJlPBXu+6luagmOCUm
X-Gm-Message-State: AOJu0YzByC0zZNPMBg4o4l5nmItE8A2ZQ06PmQOc1pLjRKokAub6W5pz
	IK6nLtRn7tESfAwhpKYQNlAMFFRxDJU0XBJcBZ6jcNZLTFKwK7tSZYO047B2WEQJMNrLHR3y3Is
	Hz2nO6JlirtPzlTTxg9uTYc+oLIUK8LsUWNPjzal7j2YAroBFe0XrWDc=
X-Google-Smtp-Source: AGHT+IE2jBmiAwa90CC0FqxPbXhWCQwHdriAJsgDsdlnu8XiLyooWVBwsj4vSXo6BJGwRl8B+l0qZEkqvyWxGi0soIBe2UwgUXvz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2999:b0:480:4e6a:bf00 with SMTP id
 eh25-20020a056638299900b004804e6abf00mr63785jab.2.1712363642515; Fri, 05 Apr
 2024 17:34:02 -0700 (PDT)
Date: Fri, 05 Apr 2024 17:34:02 -0700
In-Reply-To: <20240405230243.1067-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a386f2061562ba6a@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
From: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=137893e3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=111f2c05180000

Note: testing is done by a robot and is best-effort only.

