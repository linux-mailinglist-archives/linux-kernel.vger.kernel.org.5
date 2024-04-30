Return-Path: <linux-kernel+bounces-163450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F89F8B6B28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9128A1C21B13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497939FEF;
	Tue, 30 Apr 2024 07:11:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB61C291
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461084; cv=none; b=CrAZaWRxtMySsnNHkitfObzD8WPM3zyH/BdK4bE7mU21qxqkiVP+Kda8h3C3KSaIpT41H1rIeY8yk1TW1ohYj1JLd9XceLsqCm1brlS+z5BoeeMqJirNDZhds5LK545n6zi1jG/HyQOeh3Zanz8yf0nvyS00zlZFRNAICo/lpUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461084; c=relaxed/simple;
	bh=DfT3eej2m6KOPnni9bTCDfHoXF4S4yXSjrNpRAl+KZk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DpZ/pGfJIMqxBdLNve7EPNh0+w5HhuH1cJRJpYJ6g5wIjxf/AAGznA6346GmM9Q6weYOUulqdWB3VURTmjtWZYRveQ4Rms6lkV19LEYDQl0Cwuqy1uft4RD7yIYzS7lRe3Slc6SNnLtZa/24vRTG88tSpgZg5nZq30L1DZJkKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9913d3174so555194439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461082; x=1715065882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hB5JyjSp0fRxJ94Xv9k9vT1D7hNT4E6Sz9ZWtEnTjcc=;
        b=k7IcyVDjLUU+ugxEEIoNqwgsVIhvmpDRlZfph5eVAS7SzFXPnP4OsN/DJRG6UIzWaS
         c3U4JYD1eyXzAvCAUG0s0DP9eZjVx7wHLCNe7OF8XxC5LKEltlEXvxdVWvKUQJvW5ty8
         vCA6ZVirr8ZA8jLXXF3Ih/SpwLC1oGUW51faxpu1q6XlRlmibxQa0bJumkGWaWlVQqXR
         nCc/ufulz2HG2VYmhZwnPBWmGcxl875KmbqQhoX0oDAB51NPX+NIMq1OaZuwnpH4HWR5
         oR9VD38ve3VmKBON3oboV8a1/VT0xlMuEqce3gpbyqpFGv+3NLGXy4/QXUffHyS9ppuj
         BvDg==
X-Gm-Message-State: AOJu0Yy2zakgyg3Zne+ecMvJqWEDgJndFbNemDAP7avT80KuvcwR1o2h
	EZ30NUG+dqM2564tEATVsyI87yNZCYoBVFrLdwMEv0GOrBBVQKBkOAWzQXlVvHuVPy0M8Ortj1u
	HL7Ljo0YyPp8lvxb4AQeSAUMOPktUd9oX9Xv201f2x6/5C1SxIGI+w6Y=
X-Google-Smtp-Source: AGHT+IHsjGZ2+aJHmeRDbujWXxotx2yTRH3uY3yuAJQPBFmBl9X2WClPP8lQKMhRmpm9bwcj4RZOK7CPxPpz6+j107mRFPLkv/CL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:36c:5bd2:6b92 with SMTP id
 i11-20020a056e021d0b00b0036c5bd26b92mr7923ila.0.1714461082103; Tue, 30 Apr
 2024 00:11:22 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:11:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7c09706174b1395@google.com>
Subject: [syzbot] Monthly net report (Apr 2024)
From: syzbot <syzbot+listd6cd52ac5782bd942fe3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 10 new issues were detected and 23 were fixed.
In total, 79 issues are still open and 1428 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4504    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<2>  1404    Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  1077    Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<4>  993     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<5>  914     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<6>  534     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<7>  457     Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<8>  443     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<9>  377     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce
<10> 356     Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

