Return-Path: <linux-kernel+bounces-94065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62230873956
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E714FB226F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10499133994;
	Wed,  6 Mar 2024 14:38:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E09130E49
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735888; cv=none; b=OSFmud00vBHGZYx3u89ikLtcpQPs/UMsvP7Wl8+sxM6jNT60MGSiACKr4JF5KG01W1zfIxDeSy0a3PGgKvefWb9j3bBoYyVVjHQkjtzpjW6jhDbOuZNXLUE20/AyG7CRJuSl5lHNCKcr8rw2nGj6/MnmxPPnqemsGYIUfBSkcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735888; c=relaxed/simple;
	bh=iVdR28oapjyUHBHng31/nfD6JigwrHqxtdDEUeO4YFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jBIcwVHBtA4TPbj6pd0kings0eN3/aZ8ysrqBf23yTf5BWRJA1npMyG4+2Rwbzn9rtRraemg10lI73H3FRMpdQFkVHKz125VscdwC64XkqqffvU1vX9vu4ZjfSJe8e6dBynidYCmtJVhkSJk1ciCm5KkVAnq5G+8n5OWtcaxAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c86ecb5b37so145822839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735886; x=1710340686;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RyUEEgnO/2QXXbqnWLlMSjI/e0pDW24VIvCoKQIw3o=;
        b=vtuG8LQRV6arhexU2Ma3hHbdJGTvY7iB69DVnAMdk7BUuy4bGDkNSl1Huoy/D8rwLb
         eR6TfdysPzG+Oav9gHvJUGL/KtMiu2MJ9TaWxuwSysVZLwyTrRkaghMP7rY2kTOEVu7h
         Q0yS6iravrm299QodGJCnWRBvM4MXCnDk6LRAO5cy0L7+pTJLVvtn+I8wUtqeHM8ozzo
         21WyU17xJseruO39UxXRkS6S5FSoxWKia7XDLdtSvZnK6VgjhfpjmUIrtXLbSJo+1I3h
         iEzSqluDDAd4WVZANZw73Xx5Y076OunRpao3m8YNzRlFmfg8EKAYTw+SSYRQDfWR1QaZ
         njhg==
X-Gm-Message-State: AOJu0YyLFOYetutwwB6scIZ02MraC1k3TZoDfVxCmDm9BfJJTcLr0GPe
	Y2BP/UvzRwzURBPsmhFa6vOnYnL1Pm8XGSlGO7rPBLLn0DSJoBQR4tqP9QOcWos+sZeDtTv/6by
	oVdZWvhy+/COkCOoNh4dA73B4iwLBPBuY+bwOwp/EEN7ujv3A6+X2cNRkgw==
X-Google-Smtp-Source: AGHT+IHkgAu5Q+CjQqUy6mXz1LtnwLv6YZXQdKhIYHVKdRj8femzD0gD//oB74CttUCpKDtEKQ3mWkt2uiWLr2ZL506hXSlsYWIL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:341c:b0:7c8:37ac:23d4 with SMTP id
 n28-20020a056602341c00b007c837ac23d4mr207459ioz.3.1709735886342; Wed, 06 Mar
 2024 06:38:06 -0800 (PST)
Date: Wed, 06 Mar 2024 06:38:06 -0800
In-Reply-To: <90aa64af-52f4-4320-b52e-29370be8c3c8@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a66c30612fee841@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com

Tested on:

commit:         0dd3ee31 Linux 6.7
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.7
console output: https://syzkaller.appspot.com/x/log.txt?x=1179b951180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=985e3e4313e68ef5
dashboard link: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11008686180000

Note: testing is done by a robot and is best-effort only.

