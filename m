Return-Path: <linux-kernel+bounces-11183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D908981E29C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503D6B212F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBCD1E52D;
	Mon, 25 Dec 2023 22:43:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306B1DFF6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ba7d72a52dso547747339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 14:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703544184; x=1704148984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8rzGGM2S/OWnwe++5O+Ch05F0TdIpzpVypo88YRjSE=;
        b=KRu+sEwWTt5XFkQ3Prs2V0wsq2a5vEwmHWyaeAfDJAPOGJx05ObPP4G8dsPF7ffeHS
         mBY/wTIeG5gUA/qgK9TQ/a/xtTvFt27zT+onISXibo3w3PBUnB2v5wYPs+sGyKPG56uM
         VOs3wcYgFNEOkS6/Rn4D9e5jDnIl1WjcsRCdkCdrn9459HOfVj7th/VTjwvkKjxqKKTA
         5VGMYE2XoRta7imNzS0rZuNJgsCwOkq4/MtzBJALE7GEIE4ebcFbn9k3h15Ntv6n7BFx
         t1pWV46Xc/mlbtY0/29zRD7Khv2K5yIhc11Kd8K3K+hCsidQjXrkWHKRVAYnvtsnAKfV
         7+GQ==
X-Gm-Message-State: AOJu0YzOkXLbR0pj+yKQP3hjDjcfQZoFDuRWja+8RlkiY8ETe3oP7Vyf
	CBsEQneOGlAe+n9HqjGLZi71XDAd/71A68zaQDq89932n9GT
X-Google-Smtp-Source: AGHT+IFhBkqwTv7B+BcCEtyN9Hf+fnEdykai0psDJjz+v5pzAYyo+VjG75vi9WIN/ZNrgS6SmU76yh0W7Fy4KWjDGSULIJd0jACh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bad:b0:360:e6b:bc4a with SMTP id
 n13-20020a056e021bad00b003600e6bbc4amr5652ili.2.1703544184228; Mon, 25 Dec
 2023 14:43:04 -0800 (PST)
Date: Mon, 25 Dec 2023 14:43:04 -0800
In-Reply-To: <00000000000052dcf505f6fc93af@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5d50e060d5d493b@google.com>
Subject: Re: [Android 5.15] BUG: scheduling while atomic in f2fs_register_inmem_page
From: syzbot <syzbot+b9c67110e04430822b08@syzkaller.appspotmail.com>
To: daeho43@gmail.com, daehojeong@google.com, jaegeuk@kernel.org, 
	joneslee@google.com, kernel-team@android.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-android-bugs@googlegroups.com, 
	tudor.ambarus@linaro.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 76ca4a07659a31cc62977664bcf638d6a24af068
Author: Daeho Jeong <daehojeong@google.com>
Date:   Thu Apr 28 18:18:09 2022 +0000

    BACKPORT: f2fs: change the current atomic write way

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11287ba5e80000
start commit:   61cfd264993d Revert "ipv4/fib: send notify when delete sou..
git tree:       android13-5.15-lts
kernel config:  https://syzkaller.appspot.com/x/.config?x=86febd5cba631f80
dashboard link: https://syzkaller.appspot.com/bug?extid=b9c67110e04430822b08
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135fe388e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171ba588e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: BACKPORT: f2fs: change the current atomic write way

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

