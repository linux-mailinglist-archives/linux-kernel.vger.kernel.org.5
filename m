Return-Path: <linux-kernel+bounces-93926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3930E873705
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648831C21548
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EB013172E;
	Wed,  6 Mar 2024 12:53:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D612C81D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729602; cv=none; b=TjBm2+CmNKIlUmfA19aiPIE1DNMbCaD5KzW7EYFy5nHDclInZdIXScPNdfyNrIaEKSgw5Kt97RKwujo7j/AVHwHhPNVxflnjaFktfv6LHhUH7RACJa4e5E8rw3juXoDX/8QHpC2bKKNfq4kQ1j8jx7H3aeLWfIYhr9LdR2uwMx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729602; c=relaxed/simple;
	bh=9+t9Y7EpY+Nh25tbLiKHuxy0RxzvNfE8+vLUCPQG2B0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JV9tj5XNjVTkdQ6WnU7zzCi9jc21loxHEj6F6QLI/Ay4F7NBLBjSNEd92qNL88c5FYuS/Ins2S2St7ikZchR3YMoKlG+e7ZTehKwr65qsOujXc2zJRsHYJ2Av41nUN4LNhTp9DYoKMqjvUC9WmAGprXWOiOBstgH/pomk0Uz6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c83b5361feso336360239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 04:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729600; x=1710334400;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gou0OiZ3/4qiZbmE2nZGs4XwgQLrszXKYnscoVCGmpE=;
        b=MBym556PIhANGtUM1fsiMTzXYJVMc3CjFiD5USK53DrJ2RgHSFDRKZWKGP2voncPCY
         4nUtOOl/AbTWb4lLttEsehHMpcrdJIfQQzO+9BZYKi17RHM6uhqxmO5nZxXzSo4kfa60
         N81hemXyN8RZcD6rh0M3A7sqavtrBdqXGjY8dblsv9d8WW5KuG5HSgt+p/unJSfN/1xr
         AZPcjzNqi6OuXMIvTQGu6kiDIYD6XqvEcAZxPCkNBlAfaRtaiy3kZnPMh4zHZdPm+sYo
         jpZEG3m19Amz4TPESFkvfbByCK+Oeh0gO/BB6nbGxRFxHXeMoFCtqAXJhZyvdnJfUy4b
         EPjA==
X-Forwarded-Encrypted: i=1; AJvYcCVzfRNldXW0JbUtRjPlBqm6aZtYleNLxhpJg4DY+Ap5MhJMppTuDiBw93d+vxemORZtWPxxLn3REhG7rVYSnxMfooLd/tyla6U0y67I
X-Gm-Message-State: AOJu0YwNOQFP9QbAqQmM9wJRjLu8TSgTSUsmj1btwRaSgGw8U2iXrE46
	XZ8vLDHQD9fqxp6YNSbJOvEX6j/j84OPFTxR3u0LVf/ZK18WnCWTIXo5OyrzoOAsVhqOa7Glycf
	GtNxNDrOzQZhFMITTxNi8rI+ulDI9Bl/0tKReji4P390b8QzutL5ElBw=
X-Google-Smtp-Source: AGHT+IHye2it3rgUqKQhQ+qi8X1zN6qRtpc3cVbcToHSfNtqcRix4qPLQm4dcuStQS6HxSOz4woPjklF59wFcml7ddR5LgzbYIXw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:474:e855:ddfd with SMTP id
 m35-20020a05663840a300b00474e855ddfdmr242316jam.6.1709729599914; Wed, 06 Mar
 2024 04:53:19 -0800 (PST)
Date: Wed, 06 Mar 2024 04:53:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077157f0612fd71e8@google.com>
Subject: [syzbot] Monthly kernfs report (Mar 2024)
From: syzbot <syzbot+list0fd290f5a0f10ba9dc82@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1761    Yes   possible deadlock in input_event (2)
                  https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<2> 245     Yes   WARNING in kernfs_remove_by_name_ns (3)
                  https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3> 52      Yes   KASAN: use-after-free Read in kernfs_next_descendant_post (2)
                  https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

