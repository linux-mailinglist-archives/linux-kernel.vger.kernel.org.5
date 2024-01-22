Return-Path: <linux-kernel+bounces-32568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CE835D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F88B262E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FEE3A1D1;
	Mon, 22 Jan 2024 08:49:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DAA38FB9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913346; cv=none; b=A8MqpeKcZn8a7o5V8LZ6gNuAlBqPV9zwO3yzIV/zQdJZ62oEmrhWTaQ1HGL4g+EvMgGN4Oms4OG0vVoOm6/7VEw/yrSPCtPmfHHZwGMurev/vaBgGQFy1kemoQQi4KmBTDBHrZ+UNCbbFzwzLwe2/s1oJoDMU6CwTb5XyTbKo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913346; c=relaxed/simple;
	bh=R4ntAACS9EzHmtoY+v8OJQB2l8ziPJ7bgywydPrpGq0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=obUon38CJ5m+N2+QZLkV0CDMmDNJqvYz7r+j+HWahRXnxvzF+Kq5QSuHmlQWrGeIS9lWO6l6VtvAzH5McU6zcQ05WyStHHFSs5kvT4kb3AXH+i8XmeOCUNE7dmoPW7HAQVP29BrQlHAx42y9as6s6Mu/JbtDMT2n398xL9e8ezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7f98e777cso317358439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913344; x=1706518144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8AVNdoQPWp2f+5W+nX8tickhqM+iD/Jmzv3V7hzGW8=;
        b=g4UdqukVEnfkOl1R34HeqxE/smjw+x+z4DMCGXGHnG+n1KQRXby6fEWphFQt1F64Zn
         7uSTJLDB+Je/YQzJPDIMM+haU5WZFPgxtfWR1XiEs2uwMi5J7GLfi8PcoqQXfmvPN05g
         AJgLNLjz5FZQ3ez+c3tKT+88XV+ioKwklv3elzowyI14APzJXzD3y1ZutNeHWfRhFrc/
         7j38WJxlhuCaCWrT6QTIZJka7gu2HqYmCwQYXzRTLUUiO4g3UL9uPxI77xkNzY4MKqY6
         0T7+fXFWatoqQIjan1tfXtLlTRArl8mb1BLnFKgAx0paQU9yMH0HsyY29Zw8WLfRkyb3
         HAOA==
X-Gm-Message-State: AOJu0YwNJb3rqm7kI/MmnPJOn1WEofa31vdpxFvw40v0PIUMn4DG5pYd
	zvkODaIowQ9338yIUbfvYZXZyF9Iyvwcn/Gmn2XT/M1DfR9GSnu8gO3T67qwaDonmeRKy4ydR8p
	ICLSER0sEE0o3rBo0MO+xFCUCCFgRDP8l370J3sMHjCGWkaZX76P3nBE=
X-Google-Smtp-Source: AGHT+IFaDWbAjrBpuywanw5LizNvNrqLAq0GCqWgR/4DCPzj4MqX6RfZ27xHLqW+RrSsPc5IGN3ykdyaOyQIVlVWBXdSpuPU9Ayb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2108:b0:46e:dc29:f36f with SMTP id
 n8-20020a056638210800b0046edc29f36fmr307033jaj.2.1705913344037; Mon, 22 Jan
 2024 00:49:04 -0800 (PST)
Date: Mon, 22 Jan 2024 00:49:04 -0800
In-Reply-To: <00000000000020a5790609bb5db8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e39a56060f84e6d9@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in direntry_check_right
From: syzbot <syzbot+e57bfc56c27a9285a838@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14bedc9be80000
start commit:   305230142ae0 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=e57bfc56c27a9285a838
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cb0588e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce91ef680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

