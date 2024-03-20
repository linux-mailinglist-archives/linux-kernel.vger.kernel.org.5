Return-Path: <linux-kernel+bounces-109381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9489888184E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CB9284599
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F81885935;
	Wed, 20 Mar 2024 20:08:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084E8592B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965284; cv=none; b=i5QfKHtF6NOBs9qNI8Q2Zgu0d/ueW5kVFKuM7A2FK0yg2RejEnAmvvxlVhAzKO/duraZxK0f258HNa/Kpqly9gTutM3/rI2fhe0G58aFCsG4FZxRQI8isrlO7cWoIBh2k3NZEVDGJOazAn7bnylMb29mO36RfSkxQX1vHqO+Etc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965284; c=relaxed/simple;
	bh=U+UVKAt/Bq8p2XJNRPjZNvXZ6YosjOH7xSAmcPxwOps=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iy/l+Hty+X1zov6v6Pks3iBb/lrYh/AIZhQFhplBBUK4meVnwFQpdg5GEkXqvHjAOXPoTkZL7apHsNNrFTylaJNiybTjv0PSyo37WRJA8fOyMX3LtiDeNTw22YeYs6PHxb4b1dDktuabEfpnsArjQA+cdUm5XcJ3lm10zv/Z0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36860170307so2687955ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965282; x=1711570082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90ngouxeClPqd2Uy/VEUTMh551N/5NtUq2TP2nVIm+Q=;
        b=MX2SW5ISpXjNlZZtbhaT4l7Mn4ZGigUY3VrUUA9KEHvT6iFKK7C1rhXa1P0LoDi/3A
         OED70jVOf3xTe9F99NUbHF0exFkbSOpFzMVZN72zszRShh/Lj/HwgWLp4Lpm6lZk4VRY
         suSVNe7Zh3QHgY1WztVLG/X0I2eeeLVrROrOiR4S8eDmkoubPunKnBtYVyGnaRLMaSvx
         exXZezJU6MuCyo2t5zQkv+rvNkM4jRPtIkwH7jZJ2gWHsrENl9XCUS6TAHTOYXKKyFF5
         bhtXEvVbit3mTN2fMZCcGeJBctmYy8819ccGELcf0dICLURh1AqfO7CuTd3WlIeg194y
         ew6g==
X-Forwarded-Encrypted: i=1; AJvYcCX3ED/27P5/B1yKcuHsod0Lg8mn+jx57kBx+QGTOok1e1uPM5zNWZ1UHBwyQvXoKR5mkGkUoYrFNrY9uU+/kdU4SydoHrqz3tuVI1KQ
X-Gm-Message-State: AOJu0Yw1aeBYGAc2B/DbPYRJqUN8GiRrg6jKm4WOLR0hBjYukFZbSH1h
	C49wtOlpM33sKvvinPvwB0gihaoqmnt3K1lCi9Unwp4swM6dAyO44iXmXw+9eeyQIWBnr6LSAYQ
	AUQHLaBVGDZogVmR9z1DGQXqIj3dn1kcPE1c1L5EGOlDJqxwZwMC1cx0=
X-Google-Smtp-Source: AGHT+IFRSgFMkgU5w4crMUDJ7kthxDKNL9C7Z1syq/rB6BCaRhzrzbNaiH9JCERgVxC0vDcoLAhfCgoOJW3SIHdDAfFpp7CxCPQn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56f:0:b0:368:5b92:cfd8 with SMTP id
 b15-20020a92c56f000000b003685b92cfd8mr67313ilj.2.1710965282612; Wed, 20 Mar
 2024 13:08:02 -0700 (PDT)
Date: Wed, 20 Mar 2024 13:08:02 -0700
In-Reply-To: <20240320113002.GA1178948@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4b57b06141d250c@google.com>
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING: refcount
 bug in __free_pages_ok
From: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>
To: jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	michael.christie@oracle.com, mst@redhat.com, osalvador@suse.de, 
	pbonzini@redhat.com, stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com

Tested on:

commit:         4bedfb31 mm,page_owner: maintain own list of stack_rec..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=527195e149aa3091
dashboard link: https://syzkaller.appspot.com/bug?extid=70f57d8a3ae84934c003
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

