Return-Path: <linux-kernel+bounces-76368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05D85F63D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF651C231FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF7346B83;
	Thu, 22 Feb 2024 10:55:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C74597F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599304; cv=none; b=rSaibZbBFFGzyF0Ch+/oC+WE0tqkuB4V6QfNp63tvQgyjKP39jGUqe+Ye93NkXxwGLW5nwNqJm16nnq42zEqdiCV1fX7Q1nWpk9sppsxhghJalQCobmQd3H5CItKtHdWsR2R3b7RLo9AHf/pzet3irLItda6RrEtOqzwEGexI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599304; c=relaxed/simple;
	bh=ha1O4iLT6AxSqj0DgzjOIHcjSM59rIa3crgUCBSCn8s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iuHAiVknQigamqO5l11G6sUQGk4IZnqwd786kjN2dUDK7rW0cWWQMAsyHJT8EtRrlB8Qp6FGs+QmVeysvnYjNbJFmkIW21hpTE+ndsShsAsZP0+ybIUJ6+gnx47CQE0i6hLAsDo2BOM8KRNSLQvJ4KsFXdWm2NDoArURlpiZFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36512fcf643so53720115ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599302; x=1709204102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBV1Xfaxmpo/itADc9WYkcmWfCaWC4fUkR16tOejUkw=;
        b=VuzbfIfc4XwRrP7iPltO5X+MVPBQvF9/yXxob+O4trrI4hWnuT6NLg3/ySSyzNU7dw
         CjGYEmFJdjzfchRYWUXnMVMDafzO7Bi9jxD+wPwzsQr+oTBDutcGSPjWYvHtensJm5+U
         6HmIbWlK8RBSQ1H0dS5FZRda98fVTKs3FRMjXA1jTl/dhU+WTge3zwcNV2pHhR+xro8l
         7mJaJWocYsqlboSDcC82wqfIuOZfUSwQvoueet/oQuQDWh5x9BhCsVthsUyLN5uG20M3
         6Pc2AgUc4UZIYs06hRYDceRGmZjNfQO29xJKXEXEYNPaATtaK2S8VTe5vzUduPHcEwcP
         9P3w==
X-Forwarded-Encrypted: i=1; AJvYcCUfaooB5oPOZABdliqnR2gVgfFxJ85z+kvZCgPMc2GZv0wktpf9NVGzBVJxeWs3Fz0lMd0XKGESpvkw3tNs7NCjZnORgduKDZBuZ9gT
X-Gm-Message-State: AOJu0Yyw9at5iNHX2jfdkuFVeGqGr8BN8tp23SQh+oXdW/6ZGr3l277K
	oY4usJkjDo0pWpuRubu/iV9XSD2lvOo0y1KbRK2GTRhKJzF6ZFM1IBfaGDk0NY10C8LIBU2Xdv1
	A6EYb7ZNpPxmJtvqMyrmzsyHxzxdRcqG1n8LGFnNzVV15hDsaQXUtplc=
X-Google-Smtp-Source: AGHT+IEF/xyqLKklQw0sVER+TM5iYp/KdEmM9KqeMBTj0TPm8rLS7OaKIU7QbZcgAMu73ys+aigHWAjlhsnpk9/4AoID+Kmj+kTX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:9d58:8052 with SMTP id
 j15-20020a056e02154f00b003639d588052mr1623135ilu.2.1708599302546; Thu, 22 Feb
 2024 02:55:02 -0800 (PST)
Date: Thu, 22 Feb 2024 02:55:02 -0800
In-Reply-To: <000000000000779efd05ed36086d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007def780611f64694@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_ioctl
From: syzbot <syzbot+79c303ad05f4041e0dad@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c4cf52180000
start commit:   1f874787ed9a Merge tag 'net-6.7-rc9' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=247b5a935d307ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=79c303ad05f4041e0dad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125c3ca9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1558b19de80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

