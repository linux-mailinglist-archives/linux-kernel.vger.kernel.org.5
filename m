Return-Path: <linux-kernel+bounces-41018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0C83E9B8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551FE1C226F2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCF0B67F;
	Sat, 27 Jan 2024 02:28:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487152F30
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706322486; cv=none; b=X+Eg95BqPbeypI6LX0GI7Z439pALUZCmTmJUfKJejbpzi5q4b0BOTUGvnpJKh5K9zlCxhD3WCcDQU88uoJ7Kk3I2qQa5hQDWtCEy+L6umvSwkq6BALvsimAWpnTEK24krtF2TzHu7EiVqcDShDzQ77ru/MWc/4+w8/1s1cr2Lfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706322486; c=relaxed/simple;
	bh=ZBY1cKp0LLNRmGaJwlj/p4mIIQlnwkuy2CaaDBrnEj8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n8WZtiNQ8kvvzqcQSmgPJGtjaqfX4E7x8/ivC37sPsvu0p8NArqQ6QcF6kvhhPClCeH5n0hSpYlaMOIlYmkXrbwkiiKnLTgdMvE73aB/LDJjQKcpoEEqOuqbJuUBL9DXpZ1SlZqDM9lthZgiXvOSD/R6sWDQY2GaMf71oMvGQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-361a7ea0c21so5417525ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706322484; x=1706927284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZTi9r6mGwHaV+mM5bJDyJp7on3c/3cIRVXJx/JYQ/w=;
        b=dpwKvYiWCGXR3kiHmHF3ZUW+kSWA4qjmkdYCvhcmPZiiHznp0C2VK7ZisdK0m85tTU
         H3bfpT6Xa2DY6x7FZlq3k3HOuVSzX4zI92E5KSn/JrwHrtUSMaipPBYq48G1USx5B++m
         o0l5ujhJKR0ZImo7wvFcHMk3sJ+HMtXMGpTt6G73gAcQaKi6S/KxlXTFXY6c8vfV0zvB
         yQCvMtYhHvvhYj+elYK4yv7whgtVRymh5LP8CTnoyEx6HC7aA8MSH6Cz78jACUSdb9W0
         QFs+jZEvt5SA509j/4CldrH0/IpOclfijoVoWIyTKG3BKEgxUHJ+Rp9sCWG8wDStRYN8
         OdGQ==
X-Gm-Message-State: AOJu0YwiQYCf2r3bHM4mPW0SvNE5nrecgTRmTZK8EgaME9XwYxx8QVJS
	X9fLRB4qif73fMe4vo77dup5MKiuEQVuNRZvN00HT8ageVQErjNU37meh7a1+JuJPbnc+g+kFKo
	Qnl3uyr3Y3slFslqmQp1G2r3anJfgs4gycPwoT69UYDj3qh1rt2qsYUY=
X-Google-Smtp-Source: AGHT+IG06VZMbEHCAwbSAR9zm4HlIu9CCBfB6pPfyZajpD9dWqGxa4/bSzMKXn1RS3hevz4gLqiqB/u8yCKKkwCkEo40Nu5x4amM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2162:b0:362:b3c6:882f with SMTP id
 s2-20020a056e02216200b00362b3c6882fmr73404ilv.4.1706322484593; Fri, 26 Jan
 2024 18:28:04 -0800 (PST)
Date: Fri, 26 Jan 2024 18:28:04 -0800
In-Reply-To: <000000000000e171200600d6d8bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000910cf5060fe42991@google.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
From: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
To: amir73il@gmail.com, axboe@kernel.dk, brauner@kernel.org, 
	dhowells@redhat.com, hch@lst.de, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit da40448ce4eb4de18eb7b0db61dddece32677939
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Nov 30 14:16:23 2023 +0000

    fs: move file_start_write() into direct_splice_actor()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105aa1a0180000
start commit:   2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=da4f9f61f96525c62cc7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176a4f49e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154aa8d6e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: move file_start_write() into direct_splice_actor()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

