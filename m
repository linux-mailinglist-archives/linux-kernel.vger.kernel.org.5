Return-Path: <linux-kernel+bounces-89797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6199086F5CC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51ECBB25117
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13B67C4E;
	Sun,  3 Mar 2024 15:23:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2167A1D
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709479385; cv=none; b=Nn7xPFLGROO0oiw7PT82gdgDgKjdVnFA679Ly9uwog+dqD2rWPugmPDFt0AzyfUrhcoVAkDgD8cTTuv9kInM6XC8rfEuxUTUfyjjbgRXNZnt8KLpL+kR0EOoxt43BMOR+MZe8vj48m0fRohWBn+Y2WaJ3N5XmbzBf4gxU9r2kFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709479385; c=relaxed/simple;
	bh=4r/pjpMXv+vUuSNFuhQ9aG3uP3ZYK8F7/vMguHAvzac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ue3lxnUKNLiHoNpaBVLBQc9OSA+1uS+gbb7PP216zC9K8NWWF+2YXL+E03HjLwvNp6cDYxhRPp8CcGiaSywure1uOCdAm4L6KR4dzo2uGLSIna8iRG6xln4ZtIkRDqXeXq5Ih1g1a2U71aggibtqlCj/AEfigP37YUwtSS7IWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3657bb7b850so45842705ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 07:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709479383; x=1710084183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2dolGX8lN9vIwo+jPRD948sICXcwQTFKCQ2jT8zcK0=;
        b=f0rRuKOedBgm1dgYGWahs5/xWr3f9VjiPGD+V5c4vDpWOgO3ax4VbNCUg/hztrP2Br
         +nnQYxscqdyoaB97C7q//fQULdw2d9VRlm6/WyArVrhhzdlwcoNL5Y9wCMmvQiGHKgBZ
         jlvECwqBPckTcIPal+8iwA6RgdhP0hNcpUtX/AfU8fCR2K9d/CA6yTHXez8PPbx5H0WN
         RBvF0cSL2t9VdOdwmbXY3buADxHIDGyOO0aXo78zvIIg/8QMbi2DDcLo5sb3Z9sUIOBf
         UjAu6TuVFmRh2dv+c2oRZZxa7ppB2YdeOo0QSrFcOZFahpQHVwpujK1kJ/f2t4A9xViv
         q8bA==
X-Forwarded-Encrypted: i=1; AJvYcCXGNJbO8FOoLoQ3XKB9aBFywf5Zn1YK2wNb0P1Ossr5mFwaw0RpjPHdqxa/J3D6duLB9vySNrUqYfcmuaEjy2QCD+EFXNH/EMcnor7d
X-Gm-Message-State: AOJu0YxqcYKQvLh7w6UnuhFjYxYPsISO8KKoq5tTAThrCqM6UOOkZUVl
	y6NVWjcLIhvmnBz6AEzfKG9y3N/OCeA+dLrpPPlgqJ+fAExJ6/6bSqXeWS/wKpIcOEqq98Ym9Ky
	FULojiGWFKXouPeAtjt89vs3kfJL6ZMOA+6Qc+vtveFZ68AN9HxWf0Cs=
X-Google-Smtp-Source: AGHT+IFzHZd7RM8yH3KL7k0MA9PZACOPNm8lvtJ9xyqAE32YyTytIcecm/mi22z95pQbMVo9034e/Kg3RnqF7EYcTHBFgASo6zkb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:363:d7d2:1ddd with SMTP id
 e6-20020a056e020b2600b00363d7d21dddmr343423ilu.0.1709479383496; Sun, 03 Mar
 2024 07:23:03 -0800 (PST)
Date: Sun, 03 Mar 2024 07:23:03 -0800
In-Reply-To: <000000000000c801280606a82e95@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006786560612c32ff9@google.com>
Subject: Re: [syzbot] [jfs?] INFO: trying to register non-static key in txEnd
From: syzbot <syzbot+ca4b16c6465dca321d40@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e0e374180000
start commit:   c7402612e2e6 Merge tag 'net-6.7-rc6' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b6602324d4e5a4a9
dashboard link: https://syzkaller.appspot.com/bug?extid=ca4b16c6465dca321d40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16941c8ae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d9c3c1e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

