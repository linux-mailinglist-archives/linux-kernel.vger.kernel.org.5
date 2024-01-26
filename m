Return-Path: <linux-kernel+bounces-40702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7065583E457
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6411C21FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF3B24B33;
	Fri, 26 Jan 2024 21:55:37 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0331CD34
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306136; cv=none; b=ejbynECoZlXIKY6IPSMDKae0Xtsh9GSn0BGlhhYTJ3HZuVz9aWEwcObtI1oPM6+VKhGxC5jz2MRtoPImeNhDDPbJlxwDgOo5MmP9pBxWpilAJ/gaQbdNkswAT1SJ3hGW8HuxtzF6nGHEfiYpA8YCFp03B/0gPTDb6EyFvIIiTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306136; c=relaxed/simple;
	bh=p6YVvKXOOwohPb6oUgioCbBxsKbg/UXAcY0gQZK0lJI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hZUbNKYbv/oGXfNwn3nsPnXHvHHBYVPlnaLH0tKnmjh9V9s+LpHjobX115DqvPlWazwg4eq+seOs1tCN5+g8Hbe3SptGv2QPv+qvMzvTq+YtAqUKppp0yEWxZnQ1LOSfL2U237J/yVs9qkNZjKntlFZOtCi+sdnlJ8AeWp7DKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf2a953988so50862939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706306134; x=1706910934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lZ+RoLccba6Zyj0Ry1n2ZHFwWTBO9rUbxTQO1+BOxI=;
        b=bJbtIii/5a77Q6z9QJyr3Gd0DP9mai45NcMhnRHANITilQP5bf4Z7koSgQWREoaWyd
         ltsysZax8Trv8KjRVCRsV4sBCTEIDTmUsNRezhRq6GnkDzoQAM25N6HLgy+IxwyWsM6p
         5qZg2HX0ZqAasRtzQj0KJQ8HNw+aTpy4Pky73C53lcgLrrA0gL+YtGQYnxW7wY6pXIEQ
         tNkSx3rzRJCSBvrjhVn8sEK+k2FJuYhPiNVjwxP/Pmi8d9244vx/ky6l2nMck9KOyNIG
         GSqtpXhxcu6gxvxSBvzTeRKOTjqMX0S2YSYHmH1LQ5Fn9maIQ71D2VXjwp9IeawAa2ee
         6XNA==
X-Gm-Message-State: AOJu0Yx3M6oh0GqwhFNOghWl+WJW3f0FbyQ4P5cecu9CXOaqvYfruWzp
	CySir9oQ5XHTnJ9ZPAkcL3+9zeJU+LH6lmAedUPgdfLHoYr+7PAxk+u5Aka/JbeZxU8+QCFc2KT
	d4x9ndU4eAsjkau8ICA7i+3toZvREIbp47keEo0KU7Cpqe1nGZsVGyC9KaA==
X-Google-Smtp-Source: AGHT+IHQ700lnngjM8exNANwdaXeYMkQsFXucd8GzIxnkP9wyO9vyxY5mAvAf7ult6g4a2xA0mgs/oHi5dyj9+DZY5cU1kvyZsOj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b83:b0:360:795e:a6b3 with SMTP id
 h3-20020a056e021b8300b00360795ea6b3mr57972ili.4.1706306134405; Fri, 26 Jan
 2024 13:55:34 -0800 (PST)
Date: Fri, 26 Jan 2024 13:55:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004fa23060fe05bdd@google.com>
Subject: [syzbot] Monthly trace report (Jan 2024)
From: syzbot <syzbot+list6f10f18d2d6a90df46a7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 29 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 8174    Yes   possible deadlock in task_fork_fair
                  https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<2> 235     Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<3> 26      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<4> 12      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 5       Yes   WARNING in get_probe_ref
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

