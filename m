Return-Path: <linux-kernel+bounces-98687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB2877DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584B61F22B35
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC832C870;
	Mon, 11 Mar 2024 10:18:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429424A11
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152308; cv=none; b=SHYP47fascKy2dP7MrtIcfxkxKc1fAEJNqYEwcGrlTh/+/GHzon0oC0isz7TLW5vbrrGKQ+odiH9pNuXPLTj4GLfrKXLR5Y2ztydX7j7vJK0tTbkOHhLIY5HBLsNmU/+TXO10/gldS4vgnKbjXHLzO4Tyd8JvOdJrzhBctoicCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152308; c=relaxed/simple;
	bh=49p/z+I9ibGX9tkXzASFtaJyfmLbdA1BOuZStIYVDhg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G/GCh9fQ+Pp0q9LT38PBKWtueepCSBnKkplqaXfncH9XTisAmjo/1dnHotZ/LpTjFuoQWUkZc8ixQKNn9FAc3p0CjJhmazr4XAUoYnkwNv2V8FrYisl6dEugHp2ByIBRMHSjyBjoWz6BzKbWpvGzpKBPwRAA4nAkTFwZ4f6Gleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-366555ecfe7so7475855ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710152306; x=1710757106;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeeeQW0zVOCeEC+ecefxOMdD9qh/oMQiVsJYRGRAiHM=;
        b=Oqx08DfR834qTuRW0KUpFHIbVSHmvNspVKCYKKdhJoQYFHCG41Ws6cBAU1Y+mGjSDY
         cjLgfZZxltZBKnBc6Mg3n58UUzHJ/esk7Jl/mqFbQa0fEngKR5mUkUMuvhC2jQ98jxU0
         nGIsUvbF3+PEVUEbd9OnVlQXsB2/OjCXqs4w+u9HAGXtRVdEzdJVklt6P8R2DpTw7lDk
         AQBgPdlAHAAtp8Y0NQlcTMGWxiENhPO8AlgE7SQnXIiufsIToQ624cHW0tluNT/Yy1nO
         MdcoTWKO7mNHMlSMnUlZikXdcaY9ln4BBg4uJzTn4C3k4tULOO2jX5zHnFdaraKB79j/
         38xg==
X-Forwarded-Encrypted: i=1; AJvYcCW9p7kSOmfERJj+ZMLjLtv5M9HxIGHjDOaosGNyOgiKHP9vpVxvExgI0Bne5GPIVvO4I1DMZax3n3G3znD8kdssRAmhDPanu9ugZGP0
X-Gm-Message-State: AOJu0Yy3HetWp0RZol800Ae87YBHR9N9gPB5VUKUrKgnWhzFb/NmZyaM
	mzQlJJAysY7nRuHmXp5OQaXHBj8lCRS8iCuZ3/4R4PG8gbV2AmAkpXqq8wRbQIeC0mPjI8FYY3i
	Nb2uNi5Pb2qlaBVoN6ejvx9IbYGmSmNRoxyxpnqKyY54ijR2cUKUiml0=
X-Google-Smtp-Source: AGHT+IGyDFOwFe3vpd5h1XcY9fH/ePmTHy+TjyNNTo4z5/jgrAj391EgLeE6V7W+6kx8BJ7MA89VMnoKdMd5kpqMn7d9cx/tcO9h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:365:26e3:6e47 with SMTP id
 j13-20020a056e02218d00b0036526e36e47mr348291ila.0.1710152306129; Mon, 11 Mar
 2024 03:18:26 -0700 (PDT)
Date: Mon, 11 Mar 2024 03:18:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b80a0d06135fdc97@google.com>
Subject: [syzbot] Monthly bpf report (Mar 2024)
From: syzbot <syzbot+listf53548453a719ea625e4@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 3 new issues were detected and 2 were fixed.
In total, 12 issues are still open and 207 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 175     No    KMSAN: uninit-value in bpf_prog_run_generic_xdp
                  https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<2> 94      Yes   KMSAN: uninit-value in ___bpf_prog_run (4)
                  https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
<3> 43      Yes   BUG: unable to handle kernel NULL pointer dereference in sk_msg_recvmsg
                  https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba
<4> 4       Yes   KMSAN: uninit-value in strnchr
                  https://syzkaller.appspot.com/bug?extid=9b8be5e35747291236c8
<5> 3       Yes   INFO: rcu detected stall in sys_unshare (9)
                  https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

