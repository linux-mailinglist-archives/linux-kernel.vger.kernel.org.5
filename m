Return-Path: <linux-kernel+bounces-54593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A330C84B150
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA81287F96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3AF12D17A;
	Tue,  6 Feb 2024 09:31:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82F12D777
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211866; cv=none; b=fhxuQ5qUFOGR/EQbkGiUmr9/HgNNLsKDYGQyimPbBNYCMVnoZTCvGxGfevfeAQDYYBqhTdFCHBOtOOUHaGbRKPwXdFyisF9kS5887fqxdZEzYcPB3SW1rxRmL5Oq4a+CJVFCZK+xvNpLbrjFWxGXxxjq7+28ErMat8xQ7iPiVO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211866; c=relaxed/simple;
	bh=xFF7DkeUffKYwvbOmRdOo6ss8mPv0mpUT3ui1ov0Llo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZUv4qkEqL0aoAGa7UJHSzF2xwaQfAN3U0mTNLELOWG6xeMFMhtgkJG4jWzrhlmoI3bzrQAVj2WzoHTgTwQ26m2g42s642eFi6ua5OG39NR78qjq58NUgBnY/ScS2wwUr5UC/m24VD9W4Il4dn7hrN6xClULbyEOKjpn55aYx7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363c06d9845so21159335ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707211864; x=1707816664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2L1A6fmofMmSXCOvCOTJZEDDig3DubXgKsoiNA5cGI=;
        b=MyZ1WZmgpnZLf05MhJxBfhnZ/qaEn3PfA/m8GIYBREneFfcuXDHKQK2sDlo9VGY8DG
         8hx3vLIyQAY9nAK1trVH4bEIvLBBbNRWbUWRiaefjC2bd8q4pHIF5Hm78FU7OSfTS5zM
         89XmBUfdBGs7ar3nEVHlMgBNTd4P3RBKvDgSKGuD5DzfM7Ow+hhDZMnj92e3Bgs3V8Zq
         9ZUIx5A2wz65SRBEeQwrUyOTC6oSAAf9ZV1lJEwJ5XF468pYz3XLpYfXhc//PyHap8tV
         mektdBEY11oSgoHAI/S1FIftWPG0B3l0Cu12FkDXTffvzQOD3qbTLgg7LyVaX7r61tnQ
         Qr2A==
X-Gm-Message-State: AOJu0YyWKOjNG3A8DYLB3WzpK1AwzeSXVeb5N89B3fv0PLbQWmHVhxaL
	b0+NprmTQeT8UQio5TNqtWhZhli4i3IGckqTTGq6LO4uWK2iRgFuLfEvMlT8YTdfbw67Y3lh8q3
	RUs4IgTUV41T+rqnT55ncNFsmnHl3pD3ff78f1o7vXZLM1FY/UwV9xjw=
X-Google-Smtp-Source: AGHT+IGkA1pN6H7fqXDGAhmqsBYCD3ZyAqAW9h/Bl5enO4hn8vPkVckgxnIGxdeDch62mxmyUlU4QyaZeKkhfIIKtkA4EcMM5f6E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd83:0:b0:363:7bac:528e with SMTP id
 r3-20020a92cd83000000b003637bac528emr147749ilb.1.1707211864284; Tue, 06 Feb
 2024 01:31:04 -0800 (PST)
Date: Tue, 06 Feb 2024 01:31:04 -0800
In-Reply-To: <0000000000005a02da05ea31b295@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba28410610b33cc5@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbSplit
From: syzbot <syzbot+8c777e17f74c66068ffa@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, ghandatmanas@gmail.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mushi.shar@gmail.com, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110ffd6c180000
start commit:   708283abf896 Merge tag 'dmaengine-6.6-rc1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=26188a62745981b4
dashboard link: https://syzkaller.appspot.com/bug?extid=8c777e17f74c66068ffa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138fb834680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1399c448680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

