Return-Path: <linux-kernel+bounces-163451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1688B6B29
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD741F228B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47DD3A8CB;
	Tue, 30 Apr 2024 07:11:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348920DC5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461084; cv=none; b=oPcic/bHvy5G6K1nNZjlPFiXrK38bdY7GS9CsKZgcE1GA7xhtubFUhAwkUuAQr6RICxTNu1HkCzcTpnz9kojuZ4lfJGWIoF3TcPiunjqn5ViybChqI0GKJxEUeOD4yq5e/EeGLGUUbOww9ZdoAOD3dgv76Os4hS1Ba5G4SegRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461084; c=relaxed/simple;
	bh=KFRDWWtjbuEunsWn3Gk/CgLfeQoKhGLxSJv8cTIwpLU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jqRqd16+/Ez2NhiMGv21stcwUmHFsWEm3XsMyd9/7Fk2IPJlpBkehoVDPp5JhvA3D0m81nWXylv6O3IOR6YBraIRP6n6SR7nfNVT/xaWtrmomZLmU65FUDAdxSPtTbG1IvwQFX56WiQK8XKYOP/YAUN//QMBPgwTFml7YGexZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da41c44e78so576886139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461082; x=1715065882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8prKtnl50HvoW4z73hJBAJwWMydf63uzm6sVs9PfG4=;
        b=lsCqhuKfJDrl7qmqho/1HeixK0+dSWrP4hmOgM0ra+uYJ79dd4clYiZ42p5P0X0/gx
         Wz+rVfxf2CHmvHhgWXHOLp7X1ATA4+HqS3DENR6Bq5xVGOihao5GUHhLVSTCMLqDOAw+
         8tGX6nMcsGtMtiv++KsJZSGauIHusKgS96FNZ2d6Hyjz+AVtJqUQvKk99GigPJwtq/3L
         UAnGv0KGH3kJVGtJZ9VRC9Shg9c1TDNURtys9DrcPnOQcj4VQWIEG3uKOKgs1pJDOWL9
         Ja27gk84ZhtbeUBfg+/34vGs1DDSaXLlJYpV2AcKguxsJudIrAo1ZedRzQv1umU9hsrf
         ZNbw==
X-Gm-Message-State: AOJu0Yz4W2VPFkOyasS0SXjylho/7gZlyfSQIeJjqaedgV5Rl5QtjbnV
	SCX/0BA0EN385IjBAyexQDW9nDm5Plq4sCP1g+BbyQWhL9awxP2PEktRu6/GMTn/ZQ7ZQZ925Jk
	VFsv/zWuAyy4iDvQChGu0W3yo4djfItHEQBTMrFDRNGZu7gRjiAQ+ajE=
X-Google-Smtp-Source: AGHT+IGt2ZOvcXEOznWBkcFV/R7eTOFVtsKc+DW0+Fh1XcaPz7gTKboNqDVymTV8LLw4ZeGLruitvuw1r3prgapH46mzITTYt096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:948b:b0:487:3dc3:c47f with SMTP id
 kz11-20020a056638948b00b004873dc3c47fmr669110jab.6.1714461082346; Tue, 30 Apr
 2024 00:11:22 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:11:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb776406174b137a@google.com>
Subject: [syzbot] Monthly trace report (Apr 2024)
From: syzbot <syzbot+list303abcf8101ed15610df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 3 new issues were detected and 2 were fixed.
In total, 9 issues are still open and 34 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 471     Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<2> 26      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<3> 26      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<4> 13      No    possible deadlock in __send_signal_locked
                  https://syzkaller.appspot.com/bug?extid=6e3b6eab5bd4ed584a38
<5> 7       Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

