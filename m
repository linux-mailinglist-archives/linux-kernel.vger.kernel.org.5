Return-Path: <linux-kernel+bounces-51664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87083848E0D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6B11F22576
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B92C225A2;
	Sun,  4 Feb 2024 13:30:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C13224D2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053427; cv=none; b=qgubvJfmqB5DyjPLvFtvG6uTtSqZ6qIDz0qOfCTkv+d2g9D1kDANsdYZPCZQuPay2OyWl2mdZzel5sL4CdF3YwYZfHys3v0GXw5AasYyCm3JdVfcAITS+MVfw4uUs2juqAdEvN1R4zmDY4YLk/9p4ZfGoBddvXCQOu/ZrGnzY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053427; c=relaxed/simple;
	bh=NTclJSi3YbSGHgiI5XcsR8AWQhozBRRiLgDmcQF4ATo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OPnyRhHNJSZ6TbKQksWf8DZG5dLrzEqVWlNlXNFq9/oMYJjWBiso+8nfZiVc6wyF2hhHvkm6PR3Jy/kJ1DFYVl77pcVi8xx4AgX3BDygqvXiji8KDJTRT9X3ygpdL+JpotCI6zyG8LlSbJas9VtQjsdRs6XR97mfCc70WUKXCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363acbe3859so22447415ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 05:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707053425; x=1707658225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=739SuBFX3Be2eWWvd/HjWGQMj76u6yId7jGxm6HQSbw=;
        b=p4n63kHDECrFlMHrP6pr5Ub9hHg6JufelyejyPrMmvaynIVUO+FWxyvV/B26sBER4N
         jEIyEKSQ4/CVb425qzw/aa1U5Pe1Rfur44xc2e8v7OMmeDe+AdmHQgr8nDm0Ci7mosk+
         htu6y4Bn735oDp4C78shjIaR/qWfyS+5ZHCpRF1EztU7G1E2BCJV2O0Ls+jue7xX7WZO
         feQMK0ZgMFo3xFtpPP/NDKlKLNW1Pk48D4Y/C4bT+9xyGG0igV+v1QMCkgKSYnxVmMP5
         b41r44GeVXujZqeQxwo9u0JkfO0yce+8qsUcztaPR8hAYpeaLFc1WnwO0GxTX+rcK1R1
         8PEQ==
X-Gm-Message-State: AOJu0YzVNjCgwwunZpwFTzSy9QZkFF0jRJ3AQcjUwLic2OtY/L1UvZp+
	71ajdY1FSvcZYNL9ASfjoll6EzursozqrfsM2wPsaZgb7gN185HvcfQVECFc7sGUxYXLcji97Yi
	rQ9XeTXsX/DKWlsY/zgALZn3bFD90fJqMuM6HGklST2lMufhN+8+OyuE=
X-Google-Smtp-Source: AGHT+IHZtwe9wzzCSvXpwP0XCV8e1qgf2CMySJUT6M6548CgiFENx4BQB9w2dxgc3CoPLz/AXw75wO+Oj44ECSF4sz6fu/6k+qm+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56b:0:b0:363:820f:72b8 with SMTP id
 b11-20020a92c56b000000b00363820f72b8mr894532ilj.1.1707053425494; Sun, 04 Feb
 2024 05:30:25 -0800 (PST)
Date: Sun, 04 Feb 2024 05:30:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a105f06108e597c@google.com>
Subject: [syzbot] Monthly bluetooth report (Feb 2024)
From: syzbot <syzbot+list042bdebb13aff52dc486@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 2 new issues were detected and 0 were fixed.
In total, 27 issues are still open and 59 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  17527   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  9390    Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  4897    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  565     Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<5>  143     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<6>  63      Yes   KASAN: slab-use-after-free Write in __sco_sock_close
                   https://syzkaller.appspot.com/bug?extid=dec4d528fb7a7c5d8ce3
<7>  34      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<8>  20      Yes   KMSAN: uninit-value in eir_get_service_data
                   https://syzkaller.appspot.com/bug?extid=5e132fbe94a9ede456ad
<9>  4       Yes   general protection fault in l2cap_chan_timeout (3)
                   https://syzkaller.appspot.com/bug?extid=f0908ddc8b64b86e81f2
<10> 2       No    possible deadlock in __flush_workqueue
                   https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

