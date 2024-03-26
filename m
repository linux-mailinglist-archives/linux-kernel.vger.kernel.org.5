Return-Path: <linux-kernel+bounces-118775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDA588BF28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3A8B2718E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B514B67752;
	Tue, 26 Mar 2024 10:19:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D080854BF0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448369; cv=none; b=Varcnq0IcM5No3qXaX4yjPL8/sejqAyGtCgmauWjdmiYpgAlFF9uDInhmlsXpitryPWunJ2vM9Mem2lvInh6NS9abnJZYtDRYaB/Mm+wzRg+ntloKPU63LgjFhhOj2AcNULJRLxp8F95hBDw5H+GZlLto9mYRlDwBpREwFc3GUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448369; c=relaxed/simple;
	bh=JktfbOUl+kheRtzZv7WDpCfsD/vsnN+YGRCfK+4fz/k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GYbuCFZ6Gq3LKwo6yF5B8ru2lThtMeeNG4/oE1VDHOhlg3jT9NC4U04Lznr3WPlT/3jthnNnGN0UPjvSD1xz+JWxkENAjRLuunr5h0DoTAensmhtR6lIdTi7teuP3GyyRDXp0uafiVUzgdFpirUhB8AbQ9S3IlMyRA+6H0Ywc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc0370e9b0so604874139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448367; x=1712053167;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYw4ctmGeQJ0pMROz3CBzYIrU/HbsnolOpz1gv0N+Ac=;
        b=XRnaT6lW4tP1iI1mduyfPCs/xW4zQvrimZs9VKyWb2+ALBdqoVcPpCX8iInoBwFOUI
         hMesg2wug3yXsXXsWZgx9tSeNWNdxF7ZZntV1xtW6RJ7eThQkFNwwh+xchsfDM+shStH
         a9Q1L9sUeMMupMU1BBACvucxzZEKm6wkNfpciaMYbiPighgfHnRZPiNNtcKOmoTNxqfY
         ekzkoaC9ODE9OfXDz3oy783XRkohH1O5fJcs3FnQFpfpwQ/plfErnPvWfIeCEPGJsPr7
         7ICFSufDx6J6w17/cHZtk9UA9DCBCXGtT4buZ9nyQwDrG+aMhMCVRBhloRHQOR+7Tm+G
         1Fqg==
X-Forwarded-Encrypted: i=1; AJvYcCWyjBhwm6YP/6Np/Mf4F5mDcNa2zQJN9+MbVsqSzNd/gcKF++8XmcLo2V2ZH0O0xJxwmrJy4ziqV5h5BuHg6dP+XsTZaeogcmpQIHwJ
X-Gm-Message-State: AOJu0Yz63DG8MbWJRjyJoUckIg4dl1m4cW28+MZlsLav4guhSgAJMGgx
	+kROGYOtnsfK2GZbcBSSBQlUpxhCEu5E7EEe8KWu9O3oXr3Jf2btwEJ50grBKw8pcx9i7xiJ8ev
	klb7inPIo9VVSDwxjOjlFIWs5R9lQMB8Vj2yn2k9QjQU+SPFfl6mhFQs=
X-Google-Smtp-Source: AGHT+IFoUxsRc4aBQC7u3IilKqLn+U4wOXg7jIkK8Q3DGbnEHReAV2sq3tur827cPtI7zhKrBZLEVgM4g1qBberEDOss8OvkYZPA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1654:b0:7cc:3370:b84f with SMTP id
 y20-20020a056602165400b007cc3370b84fmr288027iow.4.1711448367178; Tue, 26 Mar
 2024 03:19:27 -0700 (PDT)
Date: Tue, 26 Mar 2024 03:19:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa39bd06148d9fa3@google.com>
Subject: [syzbot] Monthly gfs2 report (Mar 2024)
From: syzbot <syzbot+list7455fa46f189bed1f655@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5747    Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 700     Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 6       Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

