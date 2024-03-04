Return-Path: <linux-kernel+bounces-91303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9D1870C9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B89D286A44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB4F7BB1E;
	Mon,  4 Mar 2024 21:27:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC207B3F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587624; cv=none; b=snSbXk5y0EocbzRPbM5cnyfZ3cU3526w/P3ZctNxi6em+gYjDIUhUUVOw6sRgnGWX8BFc3fqhNfqXETpSrIrSHJjCCG1XLBFNh1k/4g8lhGk05O0EeualO+NT8brORAjplQNkEjkV40yojzxpJjnFNwJVAjSRIfszdRoWzYpgxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587624; c=relaxed/simple;
	bh=7OIRGJZUwt4n9PdtYeKoGZSG9ijxy+x04qpKy/W6QxI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sSInRZtmMZHgPaGes0BxHdF/YYoICcJfpFBOHqJsFztd1FXcKE5nRiR/6VdI9Vpx6T8of3auL1YXyfnIuPBGdUAFA7YBjcZaFbETYskBJkPipwj2pVJdx18TFpWuCW7oKtBk6vV6RN/qlJH2ATt50QfCBL38TTICA/83YFSnPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso448550039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587622; x=1710192422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieJ7vArxQ23QAB9KZQ2E29yL0CVdR5bt1wIM+GBalqk=;
        b=hCjiYWtc6jL0KmAvjT168aBOqI4xbnunDDCQU+oyQzWYLuNWTUT3x6I68YujxCnBTO
         3NBd7AZNcWwVEJgrBGdo9ht9AiZAEbtmIp362+3/kms3SewfI4OYyZbpnH8PlHhxfHiY
         BYdOlaY+FUsTwNo9GCIP3mEUdSuxm3UR9waxijBbyTTs3qUFNS8BVmnXudVSBHL1O2bx
         k+oeNMuw+ilYyafnycNBS5yL47wh4+fRkg6SO7ihaVy8A3r95Vm0Ra9ZHKTNy07Goq2B
         iRbp6Cef/DRpDkneg0pzM6EFjMH0her6unVpl+WnYJK1/pa/VP8c1mEZ1ngK2PmDYvYt
         61AA==
X-Forwarded-Encrypted: i=1; AJvYcCXPYSYPDuYDhj4DyCX9+GfZdaNapxYTVOCYNnl4wDDfDTpO1cwtAutb6VZ0S5f2Bl4casu8x3KSqspB9ozUkFs6ejeTJeUUrAvZ5JVd
X-Gm-Message-State: AOJu0Yy07OyPMtbkh8yFkLAQcU4ikc7USZ7BFJ7sYiJJX5J1oEUAtivg
	94QH2p0KQYYZj0XRZe0ySuFIkOXN2nVFIm2DzNmQDDt7VYCRuIFYxH8AWmIBXshw3HJ5PaUV8J3
	ccZGAyl+gTt9bUPgKHPaMNInz6Wn1B7gtAN4z/cQ/W+VHsd2rw3Q8x8U=
X-Google-Smtp-Source: AGHT+IGAT78R2FREye2VSHhSfsYgwamzc4aqFcA1RseDZztivUY+ue7QdldxXl8TLQ4eDahQCC0D/+koCyYRLRemElzpP/fMAgiT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4114:b0:474:f9e1:6d6f with SMTP id
 ay20-20020a056638411400b00474f9e16d6fmr145821jab.1.1709587622420; Mon, 04 Mar
 2024 13:27:02 -0800 (PST)
Date: Mon, 04 Mar 2024 13:27:02 -0800
In-Reply-To: <00000000000084090905fe7d22bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f279ea0612dc62cd@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_finalize_lvid
From: syzbot <syzbot+46073c22edd7f242c028@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495d341180000
start commit:   861deac3b092 Linux 6.7-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e118a9228c45d7
dashboard link: https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a44d79e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130b99e9e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

