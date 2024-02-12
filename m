Return-Path: <linux-kernel+bounces-62064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07664851AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3A41C22774
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51D40BFA;
	Mon, 12 Feb 2024 17:10:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FBC405E5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757805; cv=none; b=S6gSPpwgcXylS9mObnFVVKUI9WQT8xvC/rLE52/i7T1B0MRoBVzc+zInQdxppMYlwX6OlgStXzOmzBsCna4Xyob6vuTh39WSHOjpXyRZlQa3UusIlVm1Ooqo5bu4fhU2Ed45atwJF7pKA9vE9HGoeOXhdmWOGBeez6phGWFJXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757805; c=relaxed/simple;
	bh=dhs5X453QuebkxZokUrCXDu80prHk7y1bR8rbGRUZR0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JNASUyyUuRrSy1VqqP/rL0A771dtkkDt9+7hnShgIX+l9w4pk/EG4vE2DzrhoBNdUR1gHda1hIfg+4uNzju/qCovga0p99sLCfS69jhhuZl0+U0lFvueDZ+xC0ML81bTKLU1D+1VgLwnawyXwonr+7nYBjxhCiColOkmM1ThNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bedddd00d5so355649939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757802; x=1708362602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syTmq/2+cHOps7ocoSA0QeSIKj9tzYgPgaLcLXmYLsE=;
        b=idOEh64SFJ8F+lfICAce1O7wfP0SJTfkY7YVPL5M3NhrTWumGt4RfUjikCVQ0/4Kum
         w20ru6lziNA66xcu99GKVE6U+DPcPgMluOzS7cBx4KZO+c9HibSZ0p06EI4djiJPK5kt
         XMw28L7dS5gYD5g3nm+rYUJt/PXDEMzr/NsOjzRD7vBgOH5IAdR4iLb/NXaapQILWZyN
         pWpc72PIQJNgbqm7zFHL9b2N+CGvEU5Kc0RJc9rfeQprJB2c5DtSql4zJc15MgiwQZci
         QAG99D9XYQ+9z5p/HaJqNk+VDwPm62DxT8LX4+WQzvzfnNwrkFpQ7Zu+riaQAz55IPB4
         CHxg==
X-Gm-Message-State: AOJu0YyomoE+2Ajapw1VTuEa1hNuO8+OOxSyBS7hZolCBJnk4tWfz2hn
	2jJ3TccLAFxpjFBvykVRXWPePQF6Zc2nkPi64gA+bW5x4u1BfogMvTNFtu/WNEVx9sS3Xl30nX1
	uoQ3SmGR4viZmR9vnd9CyrB1QofMs1ZqAxdIyHMZ7yKibY9IO7Xtvt2o=
X-Google-Smtp-Source: AGHT+IFh4xAKDFcF47AC6TVZkIoj6iiFG392km/BapfaiHws2vqiNSlClhwZVgg+/uCSguLJAtaKS6ls2o03UbZ7vB36MylGOvZS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:7108:0:b0:7c4:6e52:ec1 with SMTP id
 q8-20020a6b7108000000b007c46e520ec1mr7560iog.2.1707757802567; Mon, 12 Feb
 2024 09:10:02 -0800 (PST)
Date: Mon, 12 Feb 2024 09:10:02 -0800
In-Reply-To: <0000000000006bf22a060e117a8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f3fba0611325902@google.com>
Subject: Re: [syzbot] [fs?] [trace?] BUG: unable to handle kernel paging
 request in tracefs_apply_options
From: syzbot <syzbot+f8a023e0c6beabe2371a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ad579864637af46447208254719943179b69d41a
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Tue Jan 2 20:12:49 2024 +0000

    tracefs: Check for dentry->d_inode exists in set_gid()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17659d24180000
start commit:   453f5db0619e Merge tag 'trace-v6.7-rc7' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=f8a023e0c6beabe2371a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1414af31e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e52409e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: tracefs: Check for dentry->d_inode exists in set_gid()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

