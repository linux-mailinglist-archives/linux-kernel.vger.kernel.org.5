Return-Path: <linux-kernel+bounces-134516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9435C89B269
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54D61C20C2F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B839AC4;
	Sun,  7 Apr 2024 13:59:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B039ACC
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712498344; cv=none; b=bEJre4rN2+s6TA5JavCHlpAs6y4mP2O8havXISKZxLtcNSqGD69pQAYczaiyP9FDIJBYUnXSoTH2DeAydgS54RTgkdDwScz0Fl3HoVnxWsSqTgcE0uWVRp+jYQSiZ2Rw3vARsQR0v2hqkQTedjlsQpkFCZsje/49WnbuyGn2D2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712498344; c=relaxed/simple;
	bh=G3SuHFbHFzh8ypZatqs8OpXqZOj87aatW9KjH+JX3+A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oZqUkyEIrn8BdSfyMhNC4zAKsTdk2ZgEjD3fJpMeKA2DX0ZCnBpyNddMB6hrdAwnAotGFt5SsHCJDLs5mGMAkEdoNsEpdOeLIF0VQJrLjFJHgOP1uA/G+4s1znP6duk6cdZsSJu2O8WdNOnHOltttAeIIjv8YHEg1Bgvg0u3pC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso397125039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 06:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712498342; x=1713103142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8th6mi8YZ4SsK+AiWToLd2PxMqZqV+eb1WyXiyTunM=;
        b=upv86iB3KoBd3wZx1YXokc0Crzbi6REo4cSuGiZLRNLa1gbUnBhmP78nr7Tvf7wzvv
         x58bqp9cbn4toLUD/79GIXvXTo9TJ8A2bj8m5StX1oocQYWw5GekE4KageJUqKNs7QWd
         Wv/Q1CfKsMcbxr8cDw4beHbVhvqeWQ0K2xi6sd9Q5mWHbajcz3Jfc4iNM1On1/A7jr8x
         B6FoC19RMYXolNMwyTr9mmgf85gsitp8SniX9yiMmqnLfd+ypR5MPaLns62SCaoto/D6
         1lMtet+BkrTeILiab8LDjTHOzHdwpkteE/n2DqAnA+LaTk0fXjfraSNU+NZNMlPtqqyN
         /Ddg==
X-Forwarded-Encrypted: i=1; AJvYcCUA2T1qticuScKU8cLFYJzAFlJg90EhuC+pF1jvYOWpKyfwZGc0QncCPw9T7x4pFBUuzD2sIDQDgqc+9tew0NaQUFLtKVPtrlhVsv2v
X-Gm-Message-State: AOJu0YweG+iX7VpR/n/kg1TVQF+RHve+v7lXXPHs8WwE+FunUz17xycK
	y3lMEPOwK2cvxsuB8qPiOvb3t1WJUOOHTb+MHtal6zTgeOxjd5QDnOMEiPdlwclFjfoqHo4xAEm
	R1HrYbprV4INB1olXtvkZLAjipD5HAIDI6yoJ7y73weJnSL3iTpTVaX8=
X-Google-Smtp-Source: AGHT+IFRKc+gPnyLAxAH5+XQEeRuYzDRDNS0sDrq8v2ttGi7NqWFtGQeCgDhZmSWhznz4tsckWDm4Cdcag1QA6QB0dcB1gsjCuuz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:368:efa4:be00 with SMTP id
 v6-20020a056e02164600b00368efa4be00mr555322ilu.3.1712498342650; Sun, 07 Apr
 2024 06:59:02 -0700 (PDT)
Date: Sun, 07 Apr 2024 06:59:02 -0700
In-Reply-To: <000000000000dd84650615800e67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000647e5f06158217d9@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_le_create_big_complete_evt
From: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	iulia.tanasescu@nxp.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a0bfde167b506423111ddb8cd71930497a40fc54
Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Date:   Tue May 30 14:21:59 2023 +0000

    Bluetooth: ISO: Add support for connecting multiple BISes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146c679d180000
start commit:   8568bb2ccc27 Add linux-next specific files for 20240405
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=166c679d180000
console output: https://syzkaller.appspot.com/x/log.txt?x=126c679d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ca5acf8d2eb3bc
dashboard link: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1338efc5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15428f4b180000

Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

