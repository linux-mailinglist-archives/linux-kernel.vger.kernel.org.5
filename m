Return-Path: <linux-kernel+bounces-156077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E28AFD9B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCB8282854
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799206125;
	Wed, 24 Apr 2024 01:11:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8E4C6D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921066; cv=none; b=FSkXmtyNhDQNqpDs3ErIMxb9mJebKDqPeXkrVr70fuUVS2xOLg0qIS55VlQrpnPjqYTBSf+rbnJmMLaFDnIl4tuu0GdzVmlgVshKCaghaVotghUOPpDoIM6sM7YakcngIqMoNlq5PXl6WQGoFr9uw0h8qeus9Oq4oMs1xXyTVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921066; c=relaxed/simple;
	bh=p+apt1bR0v8EiC2bw0KoyvzEkgdsqCnHoH6rTibZ+PA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hLkl/ZbpYnemxVCMRJK8i6ml1oyo0uofeawsQVSqIGsyo6ilGkP9daWSJM0V1wQRO6pNFShOoCwczrBo8PHo2NTHM8Qg3CGmWGfo0xJsoYfpv0KqLUNkYRWYRRP6dK33/R/y+4mwCs8Xf6wBS9lvlIe2PY33hAGlWfwhtnf5l7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b29dda7b3so73341515ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713921063; x=1714525863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiMDi9wPq/XQ1uLsGRZ2p1sizE8VAAKGMDKM1cC19j8=;
        b=fjo7/+GRO2Tb7/mpU8cY75L56/wGKIgZU4E6PEzGqppYKWGjblZ4nOGm8H4VDc77hK
         M8QcE+ZiaGNSPqLxEdbKdn06fR8QY5X/stg3tpw1EsFjA2C67YHTtFTFFu+ByMMrRpMe
         ZXgMAxG6pBmwcqU9QCzgS+kiEwtbhUB0bLAzi0OKa50WaBwzV6xMwXBtVJ3n5ubNIpMJ
         x3igbcN5n8kR1c3kgRbsZxGEmSDeJTTgs+eMlR491WWOkwN7NVUWE9KmM9zlsWEc2lRd
         pXkDPrDRDkwHc19sJOHt+6ye2mQNlQde6cBgzT3am5uyregxpbRJohzISDxPg3cpzKqM
         /sug==
X-Forwarded-Encrypted: i=1; AJvYcCWb02ZxeRCmGMmsFQpCkgZ9mMyzKHw6S9R1OR5LCxr6D4pXNS3Q+Y6pN7od5abbMJOOXY6xBJvnAPTRA5y2ywD0JpUnLlgqqj56dQIj
X-Gm-Message-State: AOJu0YwGLcKn0fKyxNeCgU4uaHvQKUKt8aZzA/EwzfA0MZaAoqN/Kloq
	QrZ9cfzxcEguQOqUSGlzbh9QxgMhwJbntZtmZH73eKr8ux0qBjRZSydglI9LyQ1lt2GLtceRs4M
	s6Vu2DxKWu+d9DzNFlL6EBJ9d3QSO6FyD8G0LaEo81iItFb502pm2M1k=
X-Google-Smtp-Source: AGHT+IEaEsWAddfUwiEwqNU06n9hWA2ox6XhTGJYO3+GwwQ3U3ZRErvoKuSBGSJTDeY4iKqzWUYZ18RWmWYFJSILHV6NMMyCNO+p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:36a:1813:d85c with SMTP id
 h25-20020a056e021d9900b0036a1813d85cmr134603ila.4.1713921063075; Tue, 23 Apr
 2024 18:11:03 -0700 (PDT)
Date: Tue, 23 Apr 2024 18:11:03 -0700
In-Reply-To: <20240424004334.10593-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002355ef0616cd581c@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in __unix_gc
From: syzbot <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com

Tested on:

commit:         4d200843 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1756ad73180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=fa379358c28cc87cc307
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11beab4f180000

Note: testing is done by a robot and is best-effort only.

