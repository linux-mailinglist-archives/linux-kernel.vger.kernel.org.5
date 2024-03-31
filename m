Return-Path: <linux-kernel+bounces-125973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D19B892EC3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333EF1C20BBC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B74979FD;
	Sun, 31 Mar 2024 06:52:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E779CC
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711867924; cv=none; b=paYyTMWuETcLtZW7SFpVXLbYafE1FueQ0jUGC37TWxPrsRqwuDKqZXH96DndyOXji0FDMwPs806TSKA7oot11N11KYEwAkKDGACAq2iBtWQFHLH55xwEUYq65luv+gtNZEIhxjnEL+COjh+x6otrtCrGZ68VU/DMFds73koFgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711867924; c=relaxed/simple;
	bh=OtoQRvAf44kkEM7GQqBul6rbzmaS8XHPlY6wrkqFT5I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FrdK23mfZb9+apKPd4RT3u2ds5CyU1HElV/uNQdJ8QnISAsfZZ2zAeGAQhLkCGqNwXiGhBf+iqxaoSj7LYMKyAy+BVoGkqQfxl7BYVQdpQocT4SyAGik4FjmqVyZRvZnPuNk/aeAO+vFSSklEL8v/1VNQV3aDs41nXngJNC8Chg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-368996867f0so30509525ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 23:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711867922; x=1712472722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHyLv+wpo3A65WRicihjM9ZruiPay96/+3AgYx5Rp0Q=;
        b=TnXU6OT7Q8AGbG079vLYGTBo3gZ/ITT8EXviC/RGHwJA1+5uUlnpYp90/cEeaZ/c8n
         RkKsaNte0611N0OMIZgY90HbQljAF5hrN9M43NmpccI20aqknGN+E9Gy2j/2VVDSL8L5
         Rb6TR15tpU5cecJfWpTLm3/dtgSx7i/7Qcfs2disfAOCgIQYw1/iuf+7lkmUJ999KY3G
         A00Loi/0FXtThRvqBwF2hcOLZ54lUWcbiQSRq+nKkuXAJo/ktla4Zxq1KXcM/GQoV/XI
         yjhZIQigz661YFIQ6nAGE4RvFyZQNuccxv3QaaBTBu/j5rzUTa8xSWt8rEbAt3t3TRFV
         qyBw==
X-Forwarded-Encrypted: i=1; AJvYcCUnEcWPcSBGnglvt+j/a9z60/D9nx+RBfJ6g0Mfb8+d7vcTylmdq0YV+q2y+lb5JfZau3i+eglUNaLna4itX7+qveMoGLiU3VVlc7Jx
X-Gm-Message-State: AOJu0YzWYSTwnXzpFx+W0d9GcIgSNTUhT1G6PGKcUv1WgHHhEeyuyvji
	3s5tDrqOg2hJF4lVg/bjd5gPRxjxbBIg7P3svJ43UZAROVAgfL9d+8b08LEpBkUSvcLhC2oFSVj
	oQg/Ohdp4wiUjoSWOYDEsXdAN16Ke0BEdFvNdeBZtQeUk2tqpfYm9iMg=
X-Google-Smtp-Source: AGHT+IFxc8n8Eicrltnxd8sXR3/DRCN8Cu/9VrVAqlNsLjrsSWTIjp4zagYvd1gx8QbebxpwzO13YO96mgSNpZk5Gk2HeyvI6qSp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:369:98a3:6f74 with SMTP id
 g8-20020a056e021a2800b0036998a36f74mr173732ile.1.1711867922354; Sat, 30 Mar
 2024 23:52:02 -0700 (PDT)
Date: Sat, 30 Mar 2024 23:52:02 -0700
In-Reply-To: <tencent_3B1966563C69363897A236A64A4E74437709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a22100614ef4f2f@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com

Tested on:

commit:         443574b0 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11097d0d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152ec3b1180000

Note: testing is done by a robot and is best-effort only.

