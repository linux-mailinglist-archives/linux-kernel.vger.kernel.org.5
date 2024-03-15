Return-Path: <linux-kernel+bounces-104062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9BD87C86E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6FF1C221BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9919CFC1C;
	Fri, 15 Mar 2024 05:08:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D6DF43
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710479287; cv=none; b=aw97LUdurV+Lf4SBC05k+JiyLgbW98ECQmSj6ttDE2Rwzu5ERrNmk+hgG6lESOPIWzWhYZ0gqhQdeMyUzzL4IikwXH1FsAQca7me3P2KaBEKUkwOLEtkvVqBT5/SYqAuzzy/tkgBvvpMDzxrliSXh1A+YXl3gS3WFQ1NUdZzlCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710479287; c=relaxed/simple;
	bh=NmDOUG811XfRB16igaZyw6LFbv7sSn2UAdDeMDEa6OA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MYevh5Xa6rIMqeaNV3sXh95TsxY2/vTAZNSjp0f1wwpMZaDU609YHEgM+U4Fo59BJjXXtEAtk9eJYvZlAwuL2mm2qldhpTz/NxT2cx61dCS8QsHr2v4X/TuVFX/SwCrXUma0YK2v5m1KjgW+SYlcoo5dd1il4aWnVgCWRkQrdbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36677ca965aso16873295ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 22:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710479285; x=1711084085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVU3SwTinQlrbnvG3eYIW9m6xS2x5pbAtn9qvd7kqLU=;
        b=lotkSie2oXU4sPnorr1tzdHktTw+6A/+3vNr0HvzpqJ7zEgXKlxkTXn753KH9mOF8k
         Cpm5pPrNRXMaVITIA0uOoSld4CehnG6VK1fwtbuEzApXa+JGXcjwQ5k1lYk3JnsWVFHs
         p9Xzh8/u7cszJeLO53kgsMNtLaougKMq4QshDDsz4QlRteh9k4cMiRPFSHU4JtIEaJLD
         iE6EAGBuSOHPKD/2epEv89xjTne71HwLZXl4/Z8hFxSYM7VKIdvKyrCECbZ07NeJWrF0
         PPD1UusKwI0K2yH8fM62fzvrSkJTYeRamKg4Ye5PwtwcAoPCxTi8Zu8QZ/GxLBt0EBSH
         T+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkJASVcK1gMx7zDHzypBfbqjulF2DUC492aekF/vmH6nG4tC2gM1YAWWs5cbwFoJPsVjJZtfscV5mqFHMqHjdVmV3K5dowv+Q74o3t
X-Gm-Message-State: AOJu0YwZI63zffLR0LCS1z07cBCSWP1ldp43QHI8su2R74ALCnPXbO4g
	47s3kT+JeEyiTrLVzVgftRJGOQV4fk8CgXwOVGRX0qWgcYYnvsz7fUYJWgOkcEHRX1/cii+9oyG
	gSyWYzft3YgIg/S/yFXWCG/Wr+H94UsVK7a9ByqNx61+ed84BEneEoP4=
X-Google-Smtp-Source: AGHT+IE4etLVdxE7NeSUJez8W2EAutCczB7gCGAguxf71D5ai0qlUnXy0kkyvk7dTFBA4qoM3k9rLzgTfGh9vvILeXfcxtJP6NXG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:365:38db:a585 with SMTP id
 j11-20020a056e02218b00b0036538dba585mr216452ila.1.1710479284985; Thu, 14 Mar
 2024 22:08:04 -0700 (PDT)
Date: Thu, 14 Mar 2024 22:08:04 -0700
In-Reply-To: <000000000000e8364c05ceefa4cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d73880613abfe48@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_session_activate
From: syzbot <syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com>
To: astrajoan@yahoo.com, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, kernel@pengutronix.de, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org, 
	o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6cdedc18ba7b9dacc36466e27e3267d201948c8d
Author: Ziqi Zhao <astrajoan@yahoo.com>
Date:   Fri Jul 21 16:22:26 2023 +0000

    can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c1afc1180000
start commit:   296455ade1fd Merge tag 'char-misc-6.8-rc1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e8eb82c088a8ac6
dashboard link: https://syzkaller.appspot.com/bug?extid=f32cbede7fd867ce0d56
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d7b3afe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ba0a4fe80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

