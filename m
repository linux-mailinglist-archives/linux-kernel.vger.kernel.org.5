Return-Path: <linux-kernel+bounces-40701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63AF83E456
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F11285F13
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC22C250EC;
	Fri, 26 Jan 2024 21:54:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88924B2B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306071; cv=none; b=uJ7wEjjOIgQSNs8UfRKa+020gLSWd55P7db06zdhZBDs6JiHHXEtsXqaAOtW5qz/qJt8+ryL5a/xfJUmYdlBWofekTkCiAJbfptKbNsHnW8HjRQ/NbI2EpmPIF0LhEgPQO4mdjGw7Blqu7uWzZH59WfV0M1KUbxNkg3plzsfMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306071; c=relaxed/simple;
	bh=WYkCB0YV3k+JEJogympL66UGfns3HTiri1kkF4p510I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bf8Wtvn5vEFTtTxzXNYfNxtZGp/dsPoK0QxfV5OkVyKqoqdkZxlFxFGip+kSSGNaBrKYTfoO5LZMtImOt39Dn+/NALiTg+iglEbjgxid6s2/AZ7t6EPL07LnmZGHipbmscpx/Rm6jZtALP3Fti1DUg5Qx6mS9yddWXShEAeqdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bfd75bf218so7005639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706306069; x=1706910869;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyj0t+LGAAVxJfxXnQtahJ+riT6TUlXPAEKRmRhABbk=;
        b=rbTgP3XpuJnHmtNJlysHHRssNQPQ9ZVch6qQMbgO3ua4ck59+c8xOk95kHg4QlCDnU
         9U25Lft8i5S2MKR9I8ZtfZvZzBKm7emqWRVJ9CsJkVA28UNf5C5FmjPZ3gHBZvZbJFwn
         rUeAHs2gNB8j0MMj8eyZln1I3LL2H9mlsWvdFnYAPWSB633iYBsZg6ouKAzHIOXQQWsT
         OdgA8o87TSQQ7uwbRZVm/g9AEvlXZQFf6F7NYvWvrOqwIKhMh41N5xTXtboT9effBYkr
         ptR9TbFo4Rw4IcdfzWsMFRbUrgZF6HCIZps8glH7MX8xTDRJwV60oNAIhhfBIpcXfZ70
         4/ug==
X-Gm-Message-State: AOJu0YwDILxQLyKcHAh0cWMVvGzH/ODFher+AUIPZ9QWrUHncCU89qwU
	VY7+rfxxbq1X5v8MaVh1k4FaHgF4EXP58dD42tjlLGR1/6TSZtuNT86Zzrk0G296Vp58+Piit3u
	YbHEDc06RphOZf7pOofuKcKF08i1L2FOpU1CbFhsOz7NQNx0ZNPCpv/to+g==
X-Google-Smtp-Source: AGHT+IE0ha7h8q2HfwTA1q+EnpBjKMTQb039ZHuUyyyoh+utD4lq1efVbMVtU4U9Ze1/N9G3MioEWphxzhaNvVI7sKRZ9QI+6j5t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b8a:b0:35f:9ada:73a8 with SMTP id
 h10-20020a056e021b8a00b0035f9ada73a8mr61985ili.2.1706306069189; Fri, 26 Jan
 2024 13:54:29 -0800 (PST)
Date: Fri, 26 Jan 2024 13:54:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021dcec060fe0575b@google.com>
Subject: [syzbot] Monthly net report (Jan 2024)
From: syzbot <syzbot+listf68cb1d62fb9bfa11103@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 3 new issues were detected and 15 were fixed.
In total, 70 issues are still open and 1384 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4010    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<2>  954     Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e
<3>  883     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<4>  778     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<5>  657     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<6>  432     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<7>  324     Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<8>  274     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce
<9>  264     Yes   BUG: corrupted list in p9_fd_cancelled (2)
                   https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6
<10> 226     Yes   WARNING in print_bfs_bug (2)
                   https://syzkaller.appspot.com/bug?extid=630f83b42d801d922b8b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

