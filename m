Return-Path: <linux-kernel+bounces-46626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0E844229
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEBE1F26845
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5C084A39;
	Wed, 31 Jan 2024 14:49:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA884A29
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712548; cv=none; b=KwBKesS6XjCnFo0jtZ8OGdEczvlQi5Przs0J1jNQ6F50SxWzf2OMJR4NozZdM3Dsn+/XkwUCe2d46mbngf3ek7aLqpA+jd6Q/WbUMJxFbGMjFjSt3Anq26kFeRXJhwyvDNya93Qiz9bkLpEf295JItgn76i5Pt8rNZr0GWHFUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712548; c=relaxed/simple;
	bh=honKSVfcEtgWheN3QUhnTIysGeAk/zNSwOpWs4ruFG0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lQ2LmN48kLsevLcXaxwpjZek3p0yQKgB/D1N496F9pjck//WPrPTxYGepqTHDNOAN1VASpgqxzxMliN50WIrd4WEuRACyMofKeta8ZSR2bnTQCc5rB005Y81vgJnxHs0HGoxZHxynzRcBybA0KYTi3OgziohIX7UhQOukdX0cnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf36117dfbso429383539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712546; x=1707317346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JU/sjRAKZc7ONAEHtMhiKqRcSwzItildUxEkqgwCKk=;
        b=eEQuJXPTbokoOKCD6+fVV0Jy8dhP0sC8gTAtDZkqKQaTOC3NvBi4L3s2bsH/bT4EkB
         8q36XC7o416MY9idTHGEW58fZMzij2KT6kLEwx0+nOgEPn35Ak7Jo3hI0MQtmhetTN+f
         hT7We8pbxE1nVS42R34kBh1pl1O7ljlyo90iXvc6slkx8miwmnnj0Hcpst7lsHJORVOU
         8/FSf61gaUgyjAvQvKZhhqgycTFq6WM83WDiqusUY8bGqSBTVLqGxlWv+9aXhUjB3hcs
         gOjJdb59KdhvjDNXWeZrcRkz2pgRQUJ7MmtOr5iPoSIo0cgfWp7gpMxII1A9sSwFk/UB
         hsVw==
X-Gm-Message-State: AOJu0Yzs+BkKrysv/xa5JlwTnZEwO37xkGcjBL1pEX6vvjCbOkEdn9Mq
	gRAd+gF/wo0xMMlbZm0B8sP9awTuPF8ObwPgLRJpnmLg3Ok0J68Z3fy7v5rlPT9Xn8erUEvBnxh
	r12yE9eW707eNlARS3ZU62A4we4Rvo1igwsqSH0vEqQwIU4ZVstco5rWlrA==
X-Google-Smtp-Source: AGHT+IFW+m+qe4G4q4J2PlL2WczuiVUmf7qeCC+dnQZafHoDowea02PRa2JuFpv2t51lgXDEemlYQyUFU5P+y+LzHNjxyDShkFZw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:b68a:0:b0:46e:c3d9:8636 with SMTP id
 i10-20020a02b68a000000b0046ec3d98636mr10555jam.5.1706712545374; Wed, 31 Jan
 2024 06:49:05 -0800 (PST)
Date: Wed, 31 Jan 2024 06:49:05 -0800
In-Reply-To: <20240131.232520.120791084902858290.syoshida@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000378e06103efb26@google.com>
Subject: Re: [syzbot] [tipc?] general protection fault in tipc_udp_is_known_peer
From: syzbot <syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syoshida@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com

Tested on:

commit:         a9c3d39b Merge branch 'qca_spi-improvements'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ab5a67e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca5885ce8d5696bb
dashboard link: https://syzkaller.appspot.com/bug?extid=5142b87a9abc510e14fa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151ce47be80000

Note: testing is done by a robot and is best-effort only.

