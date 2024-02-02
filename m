Return-Path: <linux-kernel+bounces-50592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3135F847B58
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C4BB28413
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1599E126F1C;
	Fri,  2 Feb 2024 21:05:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB88175D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907926; cv=none; b=NXHY3xGJb00UC6IT34n1Ea/Bkj+vcVVFF0yOGdRu9ggi1whWzmxOVyoO1aZo5k5Q1rRsByUcMJmRMA78VaXec022AK9g5DeXia+s/rI+2GXRBAu019nzmi49YOkL/6/y4e8UCZnMprgfn6IRBCcHMfKWe0WcuVpFFIO0SmC0kZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907926; c=relaxed/simple;
	bh=zVEZF3UmOBGaFQWlFwsyEckv1Kv26SyyTDwlsRJ2Ctk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bhtne686UHFGEyvFd8iQ7otS8+5zeqTLzS0fdcnVi+/GRNt/CNyimCeNrDM/48mHQ625nq4p2rhoglw1UR3bDOKyahD/k/9QkTYQMFpmI/vEE+DbN0lx2YgHwFdamfrZ7BXYMHwcMBAeviJqGdwVh49LOchUUFizVkod4Q/w/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363b281a3b9so10079895ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907923; x=1707512723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbpB9CkzBKZ5YTB7Sbfot3j8a0vy9QxqN92wrcvFWh0=;
        b=AYudY9HeuQObJxoxTsW3BOvCmcs9+Uf9uv+0L+oFPKqvtQPzynecIjr3NIfafZRd3X
         soZC4oazmz1z4wPEo4kBbIWxFJYeAtgZPWojblDREtD54rYyUgtFMVr6+Phs/hwjksaw
         nsR+EknaZ1zGFquvVpyiK+ntQgY4N7BW7CukOpO86mjnuI/rOHlJ+R8IZ1aQeYc01YdR
         BrTCXqFcfEic9umOJT7cmgxBRaxIXjBwMHertLcblvz/cYNtwVuiusmlROj3AzBeBUf4
         aiLS08d5YYt+n8rxoCXy1p898qsuXAO00rIHuxrndvUkxzsCeo6OohONrsCbX3PJUUIh
         Y2uw==
X-Gm-Message-State: AOJu0Yytnny0Jl6cukOwH4Gq/v8UmsACAoTDsngi8XZuVUW7LdF2r9UT
	vz244GnO/I70BIEbgjejR583xajutnFJGWodLo3c12zGkEkIppZAL1SNAsbaJRKBL9V9v+LaHiJ
	3rPlOJiJrGGoQSQPxLMJZAg84ovkCINcmtB0xK1/ix6kVYcOUlCjHUt0=
X-Google-Smtp-Source: AGHT+IEI8OXCfeauopidytDzSIZbNGtVMQpXAP1br3oXmhVIQDyUj9v/vVb7+FQJTlApf+zfmh2v1Juc07EX1h3FuRAuwJBtuQTI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160e:b0:363:32d1:80ce with SMTP id
 t14-20020a056e02160e00b0036332d180cemr733331ilu.5.1706907923416; Fri, 02 Feb
 2024 13:05:23 -0800 (PST)
Date: Fri, 02 Feb 2024 13:05:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000708ebb06106c7865@google.com>
Subject: [syzbot] Monthly nilfs report (Feb 2024)
From: syzbot <syzbot+lista589ce3cf9a23bf25db5@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 37 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 475     Yes   kernel BUG at fs/buffer.c:LINE!
                  https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
<2> 114     Yes   INFO: task hung in nilfs_detach_log_writer
                  https://syzkaller.appspot.com/bug?extid=e3973c409251e136fdd0
<3> 24      No    KMSAN: uninit-value in nilfs_add_checksums_on_logs (2)
                  https://syzkaller.appspot.com/bug?extid=47a017c46edb25eff048

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

