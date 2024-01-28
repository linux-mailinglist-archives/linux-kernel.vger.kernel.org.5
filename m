Return-Path: <linux-kernel+bounces-41580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A69E83F4DE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4589F2842C8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD21E88A;
	Sun, 28 Jan 2024 09:41:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8ED1D6AA
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706434866; cv=none; b=JJ80dGEEVhbTn+ezgkQPzCwsMeOoIcS84/0odDABJxzGr5jYCEDUyu5Mz5opriZKb1J4Ev2ksRsP4VSBGk94egACo9uRZf82yGntLIwwmUSTMtU0t3flBRU2d6sWhhPdscnwOJadz2T2iE4rqXXqmzJulGV83Bq4avMwsZWNnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706434866; c=relaxed/simple;
	bh=5YildW7VjU3TCIEBjQYTAGOA5Qsf8hjg940UtwPskTg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TbPyIoyu5Y6HyMhp7O/MviBTK11Xa/ZjmKTxYGbwjVfNPij3EbmRlK1vOCL145Ik/Gr5npgjCui4tGMdWYMWSWE4webHyqBa1UCvCw4Ise5R3upM2PErCQsxOOudiV1yRxBBSQOt9w6r4S+9vMEpF8plJN+ABype9ok5GMwjHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bfeb848712so22719439f.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 01:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706434864; x=1707039664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnqBrwOjYJm92wiZttPsfDDPZs/Vhpv/Kl7Eke2ZJtc=;
        b=oh4VGDs/t3yNt6r26e7uFfxVVqYwmvL7Z9bMXMFtn7nK9Laac16oVrLApqofEZTx/L
         u4c8d2/xup9dHS/1ewh7U4Xqm4+jvp0h08DVzUpuHyZT8lhBIYL2PuxMH1kalYbRq9FT
         CFnlctqWKwM5G0p11v1CX+sQmgl7B0qGJskNJSAx0FK2mRU5eluc1KO5lm5/MxwH/vsX
         H2omkOL5jUyZsYSitPpAhoLjRCWwbG3I0gny5dx7jhbg+jQDT6Ww2ZtOmJNMDIb0KGh0
         v9KSoxFiQEMDegRYW4/TzNAAzViOMFyUQwo0+QUKNcQDzrGp4PMTF19fWQ8XQLa2TM4a
         kniQ==
X-Gm-Message-State: AOJu0Yyf+HFNQqhTVJmjt3xfizwgMYy0xEBm3NryUcbd4dYLiLqnikAB
	nnMgwKoe6jbGnjIBkf2VTyaqoH5PJ/cAhFvynEcnOdKPA8Dqtj/M0irej5KPY6zgkxD4mFl2pT5
	GwdR+eCmyJMQ+4SQAE8inxezNasM5819oKMCKNsCnhuqbQO4XQWDG/u4=
X-Google-Smtp-Source: AGHT+IEAgXolaXGAfzmBgg7P1MwiV7RUtAwT46rPQ4zO0i5q5VcpiC1ADHSbZB/fPOy8YdEWCsrUGjTOP883omD/id2vjENfEJiC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:363:7ea6:578c with SMTP id
 q15-20020a92ca4f000000b003637ea6578cmr43976ilo.5.1706434864349; Sun, 28 Jan
 2024 01:41:04 -0800 (PST)
Date: Sun, 28 Jan 2024 01:41:04 -0800
In-Reply-To: <20240128091521.1102-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec0da5060ffe53ab@google.com>
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
From: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

/include/linux/stddef.h:16:33: error: 'struct hci_chan' has no member named 'rcu'
/include/linux/rcupdate.h:992:41: error: 'struct hci_chan' has no member named 'rcu'


Tested on:

commit:         8a696a29 Merge tag 'platform-drivers-x86-v6.8-2' of gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
dashboard link: https://syzkaller.appspot.com/bug?extid=a984066a63e9c1e62662
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d9682fe80000


