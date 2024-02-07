Return-Path: <linux-kernel+bounces-56900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D384D104
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1022840E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731383A16;
	Wed,  7 Feb 2024 18:17:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42828DDE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329827; cv=none; b=SEjCRqaTRl4ODTIbRDSEvdLxHS3cC4ZrY6MF5pCZ0SLpfiJ1xCZq0pC1KcLOeDpp8WR2EGn7SmUF4Kma2fX3zf7OB/S5C0XZaYwWY9HjMLVJ3K7/dnPcLeaUbAHGG/LHgboRPaLhzE0NtZZEnPr57nr+ZgTi4VftCuSsT4XcRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329827; c=relaxed/simple;
	bh=2vTyFLmYYfKWy6Gj4hU+1rmm0ovvg7vjHgQ4+Zm13YY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CdkAE2/9wo6d43cBnYKR7hl2eeVcwHVfbnnuxlOEAMVT1pK0aKxX7D3zxlvmn1i5hIDRUVPkOnuxw5kkG3Y7y8Slz1C8ttyWYvcqOAOQ0jApylB+Tl5EtA91bIplWVlQG7hbQBDrs55eurIwNHNZqD4cq6yQ9F1aRVlr2ounNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bbb3de4dcbso98312939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 10:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329825; x=1707934625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=be3GbaZ/I/Bw54yVwIBFkvdPJfjdH73IwIL5QtbBR9E=;
        b=V2TaBEl70Z/OFZgAWkJogoZAoYtq6xX1HV6Fbw+FTQaiT4rEjwme3ttQLwHRXR7HRq
         gXDt6h51VRxWV4DdOf04N19O+7hkyvqv5yulKqr0sAcnPrL69tfHdEhRgR1QGq4r8jl2
         S+GIOQ76oMcujQrl5EVjvf0TDqhaeivzCvgcSIQu/FdseGtoYk1PM8NjkmzR1rY5eK8K
         G9o5+HZYu+OdKeAdzvRzeKV75niNNDH8KlOO6wHVybvKCeDpmrcFxt8j2IqVyWm8LRz4
         jtCPavZXHYfjecn8oXDLhIKqam8Jn0tvCpiP4ztvRL4/JNejsinl8MvfAFTg2tfKOTkK
         tiBQ==
X-Gm-Message-State: AOJu0YxPpI3u1YhBO7ez6V1HfKskd2ark1++RAxgMkjWNezSx1zllgzS
	tmj+TEjN9RjZhyXumh4a5YFYFGn/W5uLZWdhSVXRZeGJ2caR532v/7+TmTde2MIHEnQ5ngsazlx
	s2R7ROPQGqkkusoU3/dnjDrT28nMZH4K27eeAelYQf7LOuaKAJC7fJyE=
X-Google-Smtp-Source: AGHT+IHfir+A+/gYcaMQmPZSB8NET3r6FooBj5GlmYy8UvJN9Uul0QpZesXws4oFQggR75nC6+t3Sqg2/GSAJxTFEBpiKWJBaxiH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:9999:0:b0:470:b4f0:f762 with SMTP id
 a25-20020a029999000000b00470b4f0f762mr43403jal.1.1707329825085; Wed, 07 Feb
 2024 10:17:05 -0800 (PST)
Date: Wed, 07 Feb 2024 10:17:05 -0800
In-Reply-To: <00000000000067322b05fdfa973f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd244b0610ceb32c@google.com>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
From: syzbot <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
To: airlied@gmail.com, airlied@linux.ie, daniel.vetter@ffwll.ch, 
	daniel.vetter@intel.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net, 
	melissa.srw@gmail.com, mripard@kernel.org, rodrigosiqueiramelo@gmail.com, 
	syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ea40d7857d5250e5400f38c69ef9e17321e9c4a2
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri Oct 9 23:21:56 2020 +0000

    drm/vkms: fbdev emulation support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1282dbffe80000
start commit:   6764c317b6bb Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1182dbffe80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1682dbffe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c0ac5dfae6ecc58
dashboard link: https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12067e60180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102774b7e80000

Reported-by: syzbot+93bd128a383695391534@syzkaller.appspotmail.com
Fixes: ea40d7857d52 ("drm/vkms: fbdev emulation support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

