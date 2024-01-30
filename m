Return-Path: <linux-kernel+bounces-44001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D171841C09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA1E2875D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2EB1E496;
	Tue, 30 Jan 2024 06:40:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EDF383A2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596805; cv=none; b=WZ9P9PxuptJHIeULnjdiqQ7BvQIbtIMyLqrYmbpZDgrW18wn8STfKm1Pa+kiMZ/Nv/miCENLrWwNM8CveEUxLjFwf2qV2wEeubp/rhsJW9T0ADPeTXB2sRJnTprxdvmX3aOvc7QkLsJmGYgUYihWq427iL4A7S6Dhj7qb3YJTuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596805; c=relaxed/simple;
	bh=SbxQH8pCY2qeXLeoiGtq4S1uXcyRkQ03Tz1xnlX507c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YUpV1mfcrv6SNi99LwIW4fHRh7a7hJTUbIBe86hPn07rXRDKzDTamYHYkzv/fKvhtzKKYcKRwKm+umh+fCocQ8jK2Dc2XXxAPQu63C0XeoBKlixAMdmV6FeELZpbKctRfwh4xObrqzuhjMRR1Nv52nNHzDqfBnWS14usKe8e4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bef5e512b6so295677739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706596803; x=1707201603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oMwg3PFTnIaJkXmNJC69+Q6VOUn8cC8qomw8d1KQ00=;
        b=lPahQKfjCY1qxX3hHp2CJFIV+wZDTKiR2gSI3Oy/PGfEtvHVyhb7WDoPY6uO6GIJea
         g8pfedOxClEx/xb3AfPAUPFGqbU7djfiYccEuFK3EUprcYQ8tMzMS7jS95Rgi29PUHai
         xfEKIMOm5fG+4YmeFBxiBah95iusrjLHVfOXfi7TiGJ2rnVAlSJno6Jf99A6aeecuU2u
         QtRyYPMNH3pR31P2vuXJwx2u+4fUSSQsO2SPvjfQch2FsIoUkVwN7AOiDGzMIf+q2bhX
         1RlzAHTaEX0H+nnsKAMiusA3Wy1KjR95KIgJuWp9JaAh68rFSudEGzKs1HsN37wdUDXx
         cbwA==
X-Gm-Message-State: AOJu0Yya9EygNHb6gz7Aey6bKVLdS/UcuoyYJohSBBMmNFT/PQnzBU7c
	RoiXWQbf/sLbNBhTYauG8ahf9DKiTswdIenshBYTiNkjqUSgxbEM+BAfhCf73Rz5ZPCfgOdb81r
	GVftCovOpc4FXvHZ2FqVwkZl7HZ/eLEAlsrKrj+EPmZcUIzUCkYSpzdQ=
X-Google-Smtp-Source: AGHT+IHXyJOF9P7O7uhy76RalsYAGf8yyTYv72bC+M3IU7MTykjY3N4XULvKvVHwZP3Tjs5Sd60fqutt+QbvMMIevfSXlKhFsGTd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35d:b0:470:aae7:5dda with SMTP id
 x29-20020a056638035d00b00470aae75ddamr65267jap.6.1706596803173; Mon, 29 Jan
 2024 22:40:03 -0800 (PST)
Date: Mon, 29 Jan 2024 22:40:03 -0800
In-Reply-To: <tencent_324B541BA3251CBAC1BB0F33A29EDF1B6E08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a6e4f061024082a@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

kernel/trace/blktrace.c:332:21: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
kernel/trace/blktrace.c:332:9: error: 'kfree_rcu' undeclared (first use in this function)


Tested on:

commit:         861c0981 Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=4059ab9bf06b6ceb
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17512a0fe80000


