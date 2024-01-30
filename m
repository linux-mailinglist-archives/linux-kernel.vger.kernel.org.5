Return-Path: <linux-kernel+bounces-45253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E11D842DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAF32894F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853D8762C4;
	Tue, 30 Jan 2024 20:20:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947F69E1E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646007; cv=none; b=TpOahEHHnQU76QW8JeTs47zrP3/PQOWXEr0CJHmBHyq2fbD4t0Ou9eIZaJVsKPG1J5EW1zrwQ3q/8vJfuTJQyJj+D6SvLf780P4qHL2THhcwRTAk/s065USmfCIZ3fGU7pVIs3jgTuNA8AYactmE3rMeMcPEBT5ktDQlhXVjCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646007; c=relaxed/simple;
	bh=Jt5ydey4bpbXzqLMHn3otk3l6scprQSM+QrkZNYsBNQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nKwxU0WeYlEd8uRPenkDSkjB7Uxxa4KjTrc38FPxFzTp066AIj1ZORFmX4hu0zmux/soopqYUsr7ThMGaQtIc6SO462h8h9D7iHcMB6mG3qlaVwZAWGjCGudxA+3a3o3oecSxL1W5YqTRlWPaLoAmD1kHhtt0ZcIwg9CMnGa1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36381f0e0a6so13428845ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706646005; x=1707250805;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+A8pfCXoIXQb0QnZAAwyJe7GsEXkiuDcw65BK4p44U=;
        b=Lc2U4cyyFIQfMa3fJUV7UKeUMxZuffcZLgwr8mJh+lUm9NZ4FhVv7CoBTdD0/XcDG1
         8gP+9L+ipFPuCOZpWjGCyHu81ADV6ys7mO1DqroGS5UvuA7nJyCFAzjJTAaefp9Fizd0
         GIi1vYHJeMxc4YeZGNEYYgJ0hM3Rg7T0S7Rpd7FUqGLzs1Mdz4appYlZon7ElzOUbqOa
         ygQM/qIjLh3g2Hb5hB3S4iQmiCw8v5Pi3wZpP+oCTPOrO1I2QHlcocMyNXznWjm/NeUF
         arLPHydno5ReB8Da+a1WogStwyw2efEw1hNJ16b5lr4r6VaX7PF1t41102HVDD3vAbJb
         d6VA==
X-Gm-Message-State: AOJu0Ywhn1iwNrh1bdAmB+3oCCMD/O6HDRHFrI9jKumOg5+/F3ciuIpX
	8q2k4CaYATS5IhQoHKeuG3x7MtJql0Hx8CaB9N9+LhaBqnqOLMtWXY28Ry7+MXoGNZiyeXqyyJd
	aQ9gRHhOCE8fCKwt2W6x5aQcCXLLCcHqkPpDTxaGdGCGHxaCDczAs9w8=
X-Google-Smtp-Source: AGHT+IFVoj4MGeAX3Ru3jeK2B3pvLTbxb03u6w1Ve6/MOnSo+qEQF21G6Hbz+jg0eF5PF8NiUFvb3xFl3cINCEQs7syOqj8pfqGp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c9:b0:363:83ec:3663 with SMTP id
 9-20020a056e0220c900b0036383ec3663mr496459ilq.2.1706646004958; Tue, 30 Jan
 2024 12:20:04 -0800 (PST)
Date: Tue, 30 Jan 2024 12:20:04 -0800
In-Reply-To: <97e73fb2-8d0d-4eef-8122-7ee117a45cbf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e20f0b06102f7cdb@google.com>
Subject: Re: [syzbot] [input?] WARNING in bcm5974_start_traffic/usb_submit_urb
From: syzbot <syzbot+348331f63b034f89b622@syzkaller.appspotmail.com>
To: javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+348331f63b034f89b622@syzkaller.appspotmail.com

Tested on:

commit:         861c0981 Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138825dfe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af550fbe64c0692b
dashboard link: https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147c0cb0180000

Note: testing is done by a robot and is best-effort only.

