Return-Path: <linux-kernel+bounces-144054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A950B8A4151
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54EE1C210C4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E622619;
	Sun, 14 Apr 2024 08:41:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE301CAA8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713084066; cv=none; b=AS5PqWsQvdZT4841MyouNwITOUEEWXrqKK1wXZS5smGT/rGpk4k4HCxIi0PVQ0gB6NIUgE9QUOG58U3pBu6b1QzCa11qNrV2Mhc/kJGlY3VtMs0zTIGnoAPrOex4JVHCl4Gkd+XwledZGsCgAVI4QvZnTn2j7Nizg67nkxps6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713084066; c=relaxed/simple;
	bh=dZAnNFSFXpH82xQIjtfXvnRg328Zk2sD5+LoAz3HECw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n9x8Owl9+razpuNZqN7TIntCtGASjoD1M5bcHoqi3ZdrWXGi5PK/WbwffTH3GcmETnH+QVEteui/XJEwXalwxleh3hnXVByMsUMt2g9HDsVsosLioHhUE7ib8HIzasIjsoNZeY1wBKeYX8aKYzDz3Vc4NlpYFCvedWW4fNuzrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5d7d6b971so258825739f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713084064; x=1713688864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rLBkUcPmuLzb3F8ivPr5HzBIa58niQNYwzeMWHMDr4=;
        b=e8Pr5SgDoveDbOOJsuj9oyMBrw5jz097oFkZ8Taavf4HmZ+Pd2XpFSvDAD/M1apc2/
         +Rmnz2ePWSZN/VdMsKixLy3SFpJqp5CrkrpIheASOTLbdGltwoJ27bN8Ly7DVLbF+Q17
         RIbsXRimdZz85sjxd86gsubjAVzN4izsTqqJ7aQpBVmqr5OWn4RDDsnCmiKMCxTHRoxF
         qUhj1unhBZMw2h6bQEJhy4vsWzdqTx2KcMW/eXzwie6eeTXeSogj+EJjsosQM9s3S//F
         c3cO0qfQ2DtSvUPKu1LWU1s35xu4+K3XD0bi3gYLmvdLRYZr1yxcNLAVUPXH3XiqWp5V
         PaTg==
X-Forwarded-Encrypted: i=1; AJvYcCU+j/XidVCBo80R87M+YDoGujfp4zoIpVhec1+/zYxscA99RCOE5bk4k3PeOEiwxCoX9WSPO/b1CFPxs2Yuo7g8smaKvHJCmdtlPLId
X-Gm-Message-State: AOJu0YwGAFmAlpz+aLsAh7CLTCopaqYiP9FLdICMiGornZxut6fFW8nn
	JFQnOAN2afxzwecpGifhaT+fO+QQn0V41ZgIh+uFpMh2vkJhCT6O/x4iqXgytcCgDWxzR+7pAJa
	UbRhZbibMvVT3wu0xe1QBw+cYsDswQc23vx1w1zvdQFc9coRGiRtrkBo=
X-Google-Smtp-Source: AGHT+IGY7ePPYppgtdO3jmP9A+EE39pQbXeoHylEBaXuVHNz7j0jnXeYz7Rdw489ll2vV7cDrFRmcDCoGjq9frsx5BdPhmNy8v5Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:36a:3dda:d71c with SMTP id
 g5-20020a056e02198500b0036a3ddad71cmr508822ilf.5.1713084063013; Sun, 14 Apr
 2024 01:41:03 -0700 (PDT)
Date: Sun, 14 Apr 2024 01:41:02 -0700
In-Reply-To: <0000000000000946cf05f34e12c2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bef2806160a776f@google.com>
Subject: Re: [syzbot] [btrfs?] INFO: task hung in lock_extent
From: syzbot <syzbot+eaa05fbc7563874b7ad2@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b0ad381fa7690244802aed119b478b4bdafc31dd
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Feb 12 16:56:02 2024 +0000

    btrfs: fix deadlock with fiemap and extent locking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101316f5180000
start commit:   7521f258ea30 Merge tag 'mm-hotfixes-stable-2024-02-10-11-1..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
dashboard link: https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c0d1e0180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10aff5b8180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: fix deadlock with fiemap and extent locking

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

