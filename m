Return-Path: <linux-kernel+bounces-93673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BBF87331C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46381F248B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14225FB8A;
	Wed,  6 Mar 2024 09:53:20 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA75F560
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718800; cv=none; b=jDbPS6457vZ+Ue7LlRINOrVBkOJNyuRuOt+n34Ls/pdKgnCDtF2D95HtS381SeL6v4zd+bo/fyQlLgDedhniEMOTJ5W5wf3kNHjtbbPrwGptZx4oCMmUMQSAN6Tx1cwwJ1Q2c7MMreExNUDhIza4NDYAZOXjVN6IRXLubvuxooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718800; c=relaxed/simple;
	bh=RBKpY6uTHbNRvkc++ykcWeEmfUxZUBNwIYIcX1qKjUQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iBMDZO9CtGequoC1s2Ok0Rz+fyzEGpdJU3Llg7bgm6zqg6EEqb9j1MN1ipcJVIhh5lAaV0o3aU5uyv17j0qsLP6Uvz1Opxdu3b9UnnRn8X1SyTXgvmtVWhZfqSFD3qJeOrafLUCCR8Gj6l8XJXW1PYHBhdqXHTzsUl+qsSsxlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bc32b2226aso165275539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709718797; x=1710323597;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7GshgTWBC/O7D9m77niat5ipmKRovvawMUZYhZfFyw=;
        b=X12Er3xNGI/Pv5OH90cs0mPKqRgH369Ytpb3mODtNBo+qwXSc9oO3tcx53vOwzycNb
         eCbJPj8LZzP8DgHOj4bHXxudJK84M1otRhXx+g3FrEkl7yq1K0arA55XQyKVx9lk6fh+
         duPBsV6ADz4XMXhIupAaPQ/NEGGDkjJpZVuVmPFwjwwWIpLrfGTU1oDoaE+S7Q5c54BX
         WS2sLratDtBshV7eXUVJn2J2h01vEVavfEMqSvzZoWDT7veJGyN29JxX8LbeHa85AN0K
         ZytZfCHdPe22VzrNgymsxJ/g08kADe3p/yAJoOd16+CujQJwSnFpTavNhvnoYJ+ghJ6y
         yjNw==
X-Forwarded-Encrypted: i=1; AJvYcCXJjAaeJOQzRqIsPsn6zhHFn3Lr5DryOeFrilZQlcGqPzoMH6qEm2ybMnTttc6oeDbfcvorzhFDZGFdzeLutIZmPil/jd9Bwgr5OeIK
X-Gm-Message-State: AOJu0YxMoxA5YqILGGm5QC13/YWAUrbxh+Rpm0GP8ZhbeEYWre5xvgXR
	4pTGT5y/rlsuhK0F5FgpspcAm+zx2cu+xDj5/OdoCRrypd8wSW2fMQeYZzFfLUkwwzjwAZdrpg2
	LXdYy/mT+YU5fNOpeEp+TNvLBKYJRmayucN+lCEM9b3opYdccrbcMn6A=
X-Google-Smtp-Source: AGHT+IGf+1HCcLGFBTjKehh1H4T8kt4HVAo8Zc5w6ywbaml/rk3AHPWNa1CIGOXyFav/zdeME3dCRaZTyXSttRyTgaNbk7NjStYF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:474:e82a:7cec with SMTP id
 m35-20020a05663840a300b00474e82a7cecmr442251jam.1.1709718797575; Wed, 06 Mar
 2024 01:53:17 -0800 (PST)
Date: Wed, 06 Mar 2024 01:53:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009870f70612faed33@google.com>
Subject: [syzbot] Monthly dccp report (Mar 2024)
From: syzbot <syzbot+list41dc79b1e0e10a83fb37@syzkaller.appspotmail.com>
To: dccp@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dccp maintainers/developers,

This is a 31-day syzbot report for the dccp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dccp

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 102     Yes   KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
                  https://syzkaller.appspot.com/bug?extid=554ccde221001ab5479a
<2> 51      Yes   BUG: "hc->tx_t_ipi == NUM" holds (exception!) at net/dccp/ccids/ccid3.c:LINE/ccid3_update_send_interval()
                  https://syzkaller.appspot.com/bug?extid=94641ba6c1d768b1e35e
<3> 17      Yes   BUG: stored value of X_recv is zero at net/dccp/ccids/ccid3.c:LINE/ccid3_first_li() (3)
                  https://syzkaller.appspot.com/bug?extid=2ad8ef335371014d4dc7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

