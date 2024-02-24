Return-Path: <linux-kernel+bounces-79546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630E8623F4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2F12842A8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4C31B81E;
	Sat, 24 Feb 2024 09:37:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8A4C9F
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767424; cv=none; b=fsZUQ4h/q6GeKRMD8cFzhuatWPIoZDD2so8fAC3gVOx1hIhdZ8GvHWVGHFDBu0c+l94N94AY4e2lWbtADh79NuB++zrHw/OoZsC57kuuA9d8GFDa3TjRXUEESB5GjRvj2BX7p3m9rjkda7A+v1GU4kJpzf5o6zqCiN3P4Y2trTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767424; c=relaxed/simple;
	bh=bQcvBHdiqv3sc7EMZ18rDY7euDY+0vzbiFh1lTvFOc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s8i/NZyRtyLH73TRFkft/4SHuRBrkcCiEsx6HtaQ/Wc0mtkNGl44hd6CnYoUkIV3s51WQ7TfFYC5m+ZR06/Ewz0uW4bVoQuS6AXKOwY3cVU0nu+EWghj6rChEBpf2/qkcYXm/Kq2qczqwn43Sqktmy8DeaVGVs94ccHRfaIrP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36520abf45eso15850815ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708767422; x=1709372222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bG7CeMIcBz4R8ZPtnOBeZeGddzoAFYbCqM2qbx+aFUk=;
        b=Dcqgq71gNqeYLMGOxLbOJAhR7nZtTTPtzBbpi9YStEDl0+1zVh0JhlI5k1syAlmO3Y
         97KpXB6FdZBsc6GiPpPL2PwTIN/it3hYOt2L7Ao+2XdWN6XMy+2npUklRPJ9tTBoHabc
         d96mB0+UWqE3Y7aoUyJEF08JaWWzVUvvWhyzsT/jTtUlu1USCxQAWaZspgyRel7pmeCq
         /JOSgHJs2kE3xXGVQeRweE860bsiZIlsuNqYqQb9diP/wn5aC8ebJijTYIs1/EzLmfPH
         +qQY+xUnzDefs2AZ8DxrrfgLEYQB9nYakq6Fv4Y3wSB50NbEvAikOV/PRnM53rc9dC5f
         l1RA==
X-Forwarded-Encrypted: i=1; AJvYcCUdppXfN3LA1yXnnArv3O33OsY6vNwmAK8HjxmPoHASfsd/isnqU3ObCwh9q9Zwb/VjPFAyndDn+YAjm9KM6MpkgqZHNelxB/vU4D0S
X-Gm-Message-State: AOJu0YxTV8icEfrhqyDcxcbviTmYJwvFVFkUHOp6cAjkegHptV5LeHix
	Qmhc8aqE0Tveq6GEaNo5lcZw9MZLBntD+4z/fSeqJoqwNWa1bltN/a6USTDWhd0dPJwZsmNlhJk
	5BTwz/6wDDym3+8pG/M7MN7P6UjG/CVYv8CK9LvH177RKJx9UFCOvZuE=
X-Google-Smtp-Source: AGHT+IEG4Kedn7F25zgN4YUskZq2LX2rfkeUfsalxNe/VS6JPzQ2RdSSdm5g6h0m31uE7VgpGMxYnyG3dRO63YrdzJUIq1ZriKy9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:b0:363:a059:670b with SMTP id
 i8-20020a056e0212c800b00363a059670bmr130398ilm.4.1708767422776; Sat, 24 Feb
 2024 01:37:02 -0800 (PST)
Date: Sat, 24 Feb 2024 01:37:02 -0800
In-Reply-To: <000000000000cf826706067d18fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d0afb06121d6b34@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_release_global_block_rsv
From: syzbot <syzbot+10e8dae9863cb83db623@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nborisov@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a6a8f22a4af6c572d9e01ca9f7b515bf0cbb63b1
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:40 2023 +0000

    btrfs: move space cache settings into open_ctree

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100fec54180000
start commit:   23dfa043f6d5 Merge tag 'i2c-for-6.7-rc2' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=10e8dae9863cb83db623
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17722e24e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11201350e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: move space cache settings into open_ctree

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

