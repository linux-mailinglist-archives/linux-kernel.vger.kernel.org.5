Return-Path: <linux-kernel+bounces-71260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE2F85A29A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2061C23151
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C532CCDF;
	Mon, 19 Feb 2024 11:58:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928042D602
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343888; cv=none; b=gR5W9zNGyxFYmcID8pc3zy4MJXUEtRlhXvfOLZSxl6h8nxEEXJOI+bLdKKgIJbwdgSSG8PXyik+kfocKmSC3P/+uu8Cb8kShr38+kdDI7HkZx2pkmCrGiS+lREztA+tRJqbf14+cIZywuAITMvnC3D0ycEolhavQJlcEFV5mMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343888; c=relaxed/simple;
	bh=TQmW0k0mrrJtpAYMPKSa7ihRnBCkF+V4hHMWThy4tNg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YYpoD5iO3CQRPbQHsaa9Q2Dx9GcIiSRFjG7wiZgIZ52TaXsv48Gf5UzK/sU4PdHiwavh/MV3ilryCFE7cUzA3tbB5fSIK0y6kjA1EbEjIRBqPRZ9+MNPw3mjQBVCW5KgHCFIQmVkNbdEJ+oNgNA5gkP1jWmmsrtuRQmxP6321XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3650280b271so21036885ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343885; x=1708948685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOT/FQ95TWde9g78HBgFYpuNfXwzNoXRLXzlXD9GSII=;
        b=L+RB3UtArLxM13p3pCaDtJy4xzqqgEX2bVLr8jtIjaF/JRjqVUtLdw6bf8eD1gjyor
         GZGOquC7LO3ewF622DNINrMVqziULBIP2zPTrEtKwHn3ISPh/1OmZdyOXA5QHrrHt8Ob
         J4XQhW/lBtTSTCRU+H1RFq14+C2/rlhS14a09iDQg4Dxy0DQt49dZUYou8RsXt8+Er+i
         sKmEn2fVM1Kt52pVsfvGnfs5OTxI/DIJYF+mpcuo3q4h/6aRp6XpnANVcrtx0fBJ7E3e
         z3Y94ZUt9mfXzaRHoAJURIbb7woxKZ9fiF2mmE7AaziyXVbV9pnrmcXgvttz/Pi1Tb2k
         8F7w==
X-Forwarded-Encrypted: i=1; AJvYcCUy4/6uYt0VkDXmvbohuAuiaQaXv/lAuTKvzMUBWWJrZZE6EZTRfISJKnoYZAdWMVlA5SsAoPqBfy2nAfmdi8i8CT7LNeKsYFwceeEI
X-Gm-Message-State: AOJu0Yz1TxA3KYyT4mQkW5MbQXz2ayDjG8ftLAtZtd2gr1nWQ8usoSPK
	sarK4jRi1x09mRyMtW042JP5Hrhh7eNihqb7LC7iSY7xXj28Cjjw5S4b6gcKrWNLdUyaOb6E6o1
	z9mrUJQ+bHKEwYtm4GOyJju64JfFzvmHYDsHRyzfGiLgMVHQWLDzeKwk=
X-Google-Smtp-Source: AGHT+IHzjLRsBmpEd4oZ2sh+MbTV5Oxsu6nOCTZ6wBZQxqKeFpAy7GVq3CUuF1jwCIbUmS1x3hblykLa5NZxVHGCoIjqeitDcdaJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:363:df76:4a1f with SMTP id
 t13-20020a056e02160d00b00363df764a1fmr964199ilu.2.1708343885808; Mon, 19 Feb
 2024 03:58:05 -0800 (PST)
Date: Mon, 19 Feb 2024 03:58:05 -0800
In-Reply-To: <00000000000050a49105f63ed997@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077ce280611bace5b@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_dump_glock (2)
From: syzbot <syzbot+427fed3295e9a7e887f2@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, elver@google.com, gfs2@lists.linux.dev, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, peterz@infradead.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com, valentin.schneider@arm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14238a3c180000
start commit:   58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=427fed3295e9a7e887f2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172bead8280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d01d08280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

