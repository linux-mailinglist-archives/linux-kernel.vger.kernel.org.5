Return-Path: <linux-kernel+bounces-56387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0DB84C98E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3066A287C97
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3374C1D535;
	Wed,  7 Feb 2024 11:24:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB51D525
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305046; cv=none; b=MdVqjm5//jOIElD7QFtQ3vztNhamTDaAaAlZvbzXRaV/+f3nb0tq9hjaVppfCgkqbPA33fjuZ/UrcktsNvpjFWQtL4XeWJFX6cL8nwdMgyxVkW0kPxqqRkRIwB4q3P6iqzaMuOnS97KfVGbKNFb2PuWO2FrjuGgZC4kpKcuCrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305046; c=relaxed/simple;
	bh=PXdFhi8/+0p8RSbyrHOG/MV7coE/FuE8liBhraEn6AY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IVUcTqbOF0uGTTzjPT/9R21J9fS9dOkJ3WGmfFHrnF8V5KeKBIzTw4PoU8YbmEYPvDwQi9AggfKeWuzWiqbpfzT8PXusxfl++7AzTKcCJGZ8611e7/56a6eAUZV+TqnyiBME3L927JVd7bTHumlu+VK52bTYkiX1ULRujKTQ+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363922a1774so2563985ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707305044; x=1707909844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyKvQle5+pouUIhPoej90C64GO0nhko2wK/O0ubJ9dY=;
        b=kZ7HHnS+qrocqtSfYXnSH+8Oh8XEh6eVLqbf6e4tlX8jOLx2zqP3VD2w1R+2n8N+9S
         tVFMfOyyEYgX8y7oh3MV35KOuEZWKwK03CWUqH6slDHogD/BGbep+ZV7ZfiCgyRrKKn6
         ZNHzcnNXynbHsD1qefeUK15+rFpvxwZqHX0JJFLI3VWHDhDibZ5NWVOXnyHRfAnF+LHM
         GfCc2TkI3fMJ/fnmKqvcXnPLI+ehr5Q5eADtnWEPKb7QZK/7ojSBFgXamtpaJKlJD9rj
         1qSX5m9q7+q5hreee90BLkmB+LX8tHCVdOQR8tfDs4Z7luBJxpWj8k9UrMi5OdHAliLJ
         h0tg==
X-Gm-Message-State: AOJu0YzVrRj8glAHKPuOLTPfU2Cq2wtmAFW8DtSeLvU3m9rblWG107QP
	kVnFsYQwNGUQVHoQvZEIodJnfUyAGaSwOK3jphpz3WnHPPBKxjVaUUIVyScyadwioufxrdAhiUE
	/SIt1QftH5hfgEeFIde0dpk2wfh8W33GH5gaVWVMZCXZosokITdWDkl0=
X-Google-Smtp-Source: AGHT+IGO2fvY4W4sQASF6ChtO3oc6KSXzdlb01OvkQrZu0qgGIw7ZyHSMOd10F6+l0feyxFaKpPue5ejFBntY3PGtpKszXsBOrdb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:363:b5f6:7379 with SMTP id
 l2-20020a056e021aa200b00363b5f67379mr324012ilv.4.1707305044572; Wed, 07 Feb
 2024 03:24:04 -0800 (PST)
Date: Wed, 07 Feb 2024 03:24:04 -0800
In-Reply-To: <20240207110756.936-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4827d0610c8eef4@google.com>
Subject: Re: [syzbot] [usb?] [media?] possible deadlock in vb2_video_unregister_device
From: syzbot <syzbot+3b1d4b3d5f7a358bf9a9@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3b1d4b3d5f7a358bf9a9@syzkaller.appspotmail.com

Tested on:

commit:         ed555127 Merge 6.8-rc3 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13796624180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28a3704ea90ef255
dashboard link: https://syzkaller.appspot.com/bug?extid=3b1d4b3d5f7a358bf9a9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15126718180000

Note: testing is done by a robot and is best-effort only.

