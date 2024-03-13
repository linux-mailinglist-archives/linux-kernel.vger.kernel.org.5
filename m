Return-Path: <linux-kernel+bounces-101468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E554F87A77E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D1D2846A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D44087C;
	Wed, 13 Mar 2024 12:23:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594593FE58
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332586; cv=none; b=aRYQWhfCmQUizlkDVcSqYZy3w/zJ8ksuGwq1JniWE5dBfgjXTpo7ofdJan5H82YNATo7SKPZTseSRDabDhRykj9DWNI/bW3pxCd+xe+JSn3QXSOJKJulMdrz4yJUDmKVmodlCa8D9EoAmk1u0w7dN64SZBrOZ2OTTJX9QFw0Ves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332586; c=relaxed/simple;
	bh=CMx0+K0+od6gAAfqGFuKrClz/7QMgfg21jkqF8+bk0U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FkT/WnIL275lclgX1JU1r82rgQXZmCac/U3iFuVY/BGyRQMvHwZwyYmXietxVHsZnpi/EJ3IZESdrEiBXzVSmffXhsY3FaAIAbqvsumUGwCQp3l7LyA0TV0htZiWmbQiaCpbpJPNgrZd7LRUyJzUA06Qkbpy6ekojPAcrqbUF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8a6a1227bso329770939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710332584; x=1710937384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/RQ7ulMJ/8EuK5QcToN/BsgCLIW1fJL8XxtmY+wQjs=;
        b=ScrC2mhDZYX8TBaXjH5USenrqstoII/QJTgYbgQH6y9oU4g9CJRbfKb/TAkCRj3dOe
         3+vPeqBlUBVWgKmszqSi3jqO7V0bjqES/q32nQl4X7TkNZ5BNaVoxfoyyYwiG/2bUPFa
         L5VtaEyyvTKEzJrLavzqe81glR/Fga6pySBZVfOOadvVzn7DnTwKSRu6GttcURc6F0em
         DsZ4vo80NK5gi9I6IzyRTeUr02XRUc7xvy/SPrV/iiENRVAAA+fr/RGO0pbBMb5wVSZV
         Yw2xwE/6XdED/ePn3cJI5IUIDSx1ujVM75cNDRTwAMD5DV0JzwkDg3fSmroZUlDGd3XL
         JEcw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ//zS/1CA3ZfO+LFoF700zr0wi7l9iydrtIFosboaTcaulF70aSkXaYMlM9tip4kXW25M4ktMjqFlQe/JiTzt9dFyq4uex08jJ3+J
X-Gm-Message-State: AOJu0Yycq8xwaRMHmnFyjWbKeZ09p6RX3MGzIGSO3Biz4iFCSeot0Wrs
	/Fe7TcsQT8qzgoOkLzfln+RxNmnfoLfWD86AhW9AqSMy6XOLxSc+fkj+LVqCDGiLrnHt/P313vI
	G7TUGt1LGPoF+Z5wL6RjRT45TUiUNctwtgR6sFh2RabbCPjP0gVK4CSg=
X-Google-Smtp-Source: AGHT+IGVTtQ4uojG97WNJ0uwB0YBDq59+qtV5IZ/3cDnbc7YourhmR/GosPslCuD+dZwEelAMVRAygeYYtaFyq8wBk2Nc0aMcF63
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1693:b0:7c8:bd8e:a88 with SMTP id
 s19-20020a056602169300b007c8bd8e0a88mr143010iow.4.1710332584607; Wed, 13 Mar
 2024 05:23:04 -0700 (PDT)
Date: Wed, 13 Mar 2024 05:23:04 -0700
In-Reply-To: <00000000000095640f05cb78af37@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002755ce061389d67b@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_queue_drop_all
From: syzbot <syzbot+3bd970a1887812621b4c@syzkaller.appspotmail.com>
To: astrajoan@yahoo.com, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, kernel@pengutronix.de, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org, 
	o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6cdedc18ba7b9dacc36466e27e3267d201948c8d
Author: Ziqi Zhao <astrajoan@yahoo.com>
Date:   Fri Jul 21 16:22:26 2023 +0000

    can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10e4d371180000
start commit:   dd72f9c7e512 Merge tag 'spi-fix-v6-6-rc4' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=12abf4cc4f802b24
dashboard link: https://syzkaller.appspot.com/bug?extid=3bd970a1887812621b4c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17602089680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13398a9d680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

