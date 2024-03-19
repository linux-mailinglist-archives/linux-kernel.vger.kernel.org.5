Return-Path: <linux-kernel+bounces-107437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBECC87FC81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296D91C21943
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268307E580;
	Tue, 19 Mar 2024 11:03:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C87D410
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846185; cv=none; b=VEX4qRwCJ2A7dUMXG4ncWWCFjnNc3zZCvXOqgr0TTgQWLxNdNKOkh6Izm4oowHGow0VTqyVKeHH/7BsaK+H+aNR8G/uXYzZgeOHZnSyfQnDsWhtFgK+62Hg4nrbFtWjrWXGjo5thPiLzWN5cof+OjSgu+UBz0sQ1mP9vfHRst5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846185; c=relaxed/simple;
	bh=slKjRaMkRRkHh/39qn7hwcXp2X2erWHCbqhQGdEu/ow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sKVCXD2PqNeeepZVpO4iN959wVf6acDbkaatbkArvQ7lXSwsHg2emxBalXkyPM6ewC2patfwta+kUQEeB9Y62n1kyfwyurCszZU+gs9CahjG8pLw37lLewqc2eEaJNrZJduUxUsLJTZHGou8iV3O9hl+G3mhUIgsEn1J3q54v14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3684e7a4770so2961915ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710846183; x=1711450983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NS31IZUVISj+9f5GH0XsvKxqqRb+tl8wJ9ZGlJagits=;
        b=C+B7jxy1yzDIq4x3miiZ2xtc7Iz+nTmPojOcBqausOqQXBVdNPAXkCPThdomaF1DdX
         7sBmhjHHc3h96oenjAsRCrEzFfNfeQrcW7Sb6l7ojOg++4NpNSB3b0Qj+ORGOjvFeySR
         rkfj2QjmSzk5Hqr2Q0AFb+0mhmoI/C0zOkzk/VURJMbUeJmVsvshWQmZN6qKPrMSHs3M
         IgyAXeHW/Hf9icsWva6HfbqtVOhaYnZMftHo7XbJxCJ+Jq3Dz0yMJ/NNYtFnMPCOvtMX
         OABk90kc5fzxE+GMJWEy79aVqFAg3/xlBzV2wEtfAgmXj/bZy/0krinKzdeSvWz1orxU
         /iog==
X-Forwarded-Encrypted: i=1; AJvYcCUSFlB1i7yn3rrdg6qRwVJVbSgsb8SbsOwkFXbbzsoBuJiJX6t0pAUKNsdzYCG/8WWWLq97QhlRyN1xg6nhY3ypgnAbnkWkvNVNPlHx
X-Gm-Message-State: AOJu0YynhIDLAhaeNNNhBTpjMrjfFM/2Sb2zXfvtGv8uLN6XTkeY17bo
	aeZiO17zbnr38EkwbOXOYnzaz8T8IOnDwZKizPiZcxv7xCl1W6mu2703syKIYrSWOwqdE/dGpJt
	0WNwr77eb4H+GhZp1WrljGRmlZ188m7T6NXZUmZvvMgWHs1toDu+oAkY=
X-Google-Smtp-Source: AGHT+IFiDK1WT/n8TCOKAH5CGiH/AJ5QTidJfxOX7D2n/lTfWZAch3GSOQ51Bj+zC4HRoLqpgpszLLuCibMY38T8UfSWzD9bvdOO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:366:c200:a9fa with SMTP id
 l2-20020a056e021c0200b00366c200a9famr121313ilh.1.1710846183604; Tue, 19 Mar
 2024 04:03:03 -0700 (PDT)
Date: Tue, 19 Mar 2024 04:03:03 -0700
In-Reply-To: <000000000000aefc5005f5df169b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a1c180614016bc9@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in ntfs_attr_find (2)
From: syzbot <syzbot+ef50f8eb00b54feb7ba2@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	brauner@kernel.org, david@fromorbit.com, ghandatmanas@gmail.com, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7ffa8f3d30236e0ab897c30bdb01224ff1fe1c89
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Jan 15 07:20:25 2024 +0000

    fs: Remove NTFS classic

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fafac9180000
start commit:   9d64bf433c53 Merge tag 'perf-tools-for-v6.8-1-2024-01-09' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a6ff9d9d5d2dc4a
dashboard link: https://syzkaller.appspot.com/bug?extid=ef50f8eb00b54feb7ba2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d79fbde80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14be4a73e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Remove NTFS classic

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

