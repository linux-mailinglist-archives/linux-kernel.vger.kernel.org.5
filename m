Return-Path: <linux-kernel+bounces-50589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A69C847B51
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C821C23828
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D2D85927;
	Fri,  2 Feb 2024 21:05:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAA8172B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907925; cv=none; b=ClxaraDnWbpX3CtgHVeGECY7N/u3K/CfHlCbBWIva2Q+VDkZAB9nJb3WAlVerve6YsFRAgMDSrb5dSAbnwyc/udz/KX30wG//S23aPpl+X4gMo7E8t62GTpBI+vf4vB1omB0knKz7J+LLemESwTmI+zvIjzuG6ibCZOgqrgcDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907925; c=relaxed/simple;
	bh=5KrRl8KUR1kMeTI+615sU0yX/tF9Bv+EGQ4dtgoiApA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bBbNiTqPfXAS+D29kubfZzQlThg3xmVXFD+yrZ7/87ZI/INuYUHuPrDDo2C8D+EGtR26W+HXz2W6U73hqTCSBusVTGPBQ3x7kpUM7/dr2kowLwKkqgoiTVjKnmTXnNV2WnbBImQjjxWctxPvmglp5mTbqDVSbLngp/KTOCHN8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c018d53e7fso203890139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907923; x=1707512723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGeO4z7v9eVL3ouqozwcHhFGNh319KsDdFkz57A2JlQ=;
        b=ngHzKKZ+mxim7znTbCL6I2C6lKiz2vL3a9TPg456HcVF1mWhndOFKsl1vSNr6n6zLr
         5BWo6pcob+Nc5IrrBMA0LdYUF8vWIAwAmVX/M57H3cfIykC8prgT/vMrh2qjeCw2x/fh
         9twnq7DYduVq9W9prVivJKThcNN70wcygNf0y4Pc5BV3cEQbg/irA+u3ALf12MuGQR8d
         HaUfthnwSLgqrr6AZSmMi15SYwgCSxURz7LEjUJbHNCMVVxO0Q9K/h4bZXNFE5ABN/4H
         Kzt5MlOP5mC1xyCAsig8ktBnUxxvgJdGaL+/0Ar73a08LhInSusDl4S0LecMlQ7mUn2h
         0Hgw==
X-Gm-Message-State: AOJu0YwkAuKH/GqtMAY892m6KhG6lVnMcysjoHyASLCekBGFD891mID/
	D5EQsoUn1rQQ9l1iaFMmGQbmvrQT62piVl3jWkhgx5QHZSxcESudqaAFARDji7w/E2D5PDR2QTT
	VmPbH1VznoumB42x3PHwjUWcxXDD7CSri3rSICoXVZRxfYPacOqJWI6Y=
X-Google-Smtp-Source: AGHT+IHdL1v71en1p/S/OwxhfsAH2ZHEktQVRFFgA3hwsrbadSL6vf7JXljDuCqJK025XMdsgkWMIiwKes6O8n3e8QzHv4ztN9XA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:db06:0:b0:7bf:e3a5:ccea with SMTP id
 q6-20020a5edb06000000b007bfe3a5cceamr78216iop.0.1706907922941; Fri, 02 Feb
 2024 13:05:22 -0800 (PST)
Date: Fri, 02 Feb 2024 13:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000694be606106c7817@google.com>
Subject: [syzbot] Monthly dri report (Feb 2024)
From: syzbot <syzbot+lista75af9f68b8334e88ff0@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 1 new issues were detected and 0 were fixed.
In total, 17 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 375     Yes   WARNING in drm_wait_one_vblank
                  https://syzkaller.appspot.com/bug?extid=6f7fe2dbc479dca0ed17
<2> 213     Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<3> 182     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<4> 132     Yes   inconsistent lock state in sync_timeline_debug_remove
                  https://syzkaller.appspot.com/bug?extid=7dcd254b8987a29f6450
<5> 87      Yes   inconsistent lock state in sync_info_debugfs_show
                  https://syzkaller.appspot.com/bug?extid=007bfe0f3330f6e1e7d1
<6> 10      Yes   WARNING in drm_gem_prime_fd_to_handle
                  https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<7> 6       Yes   divide error in drm_mode_vrefresh
                  https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

