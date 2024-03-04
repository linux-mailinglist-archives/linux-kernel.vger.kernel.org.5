Return-Path: <linux-kernel+bounces-90170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044AC86FB5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C522B21F9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3793C171CC;
	Mon,  4 Mar 2024 08:12:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83216436
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539924; cv=none; b=OZKnYqpCQ58HG12J/VjRVsQ8u+8mtULAb4TaptJGAMogjGIjl2v2Zb4xBKcLMEtE/cWQc4p/PrD1+8x3sL4HX0vCWlDX+dJFmvCvHGxIYmO20Yr3KZgafnaQeoXFZwyCMTG5Mn0BPOuui6y+o33AEEaQ21HpS5K0A6a0eT17LtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539924; c=relaxed/simple;
	bh=05Zg3Yfh5R7PIlbPjhsaPvx4ut1XAWO/IPGktUKBJgg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MGud0US5ZICvKbJQbAZ2VaW5k5dhKF7rdYDLZVqHqggTQu6T5mWlzrOJvbqmXAoDifttLT0CiQ5KNh9cLCPIaRJ2LvhLuuTRyLefiogd63pMfHwirig0u5o2/y701oIBQQlcMffSApqQSErQJdeJ0Y/XrbTGiCEk8gRLMhcFDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c84b3570cfso93171839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709539922; x=1710144722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egdYmnZntij2p3DhMY51S6LIFFVV0i12cJm24YKgZOc=;
        b=E0QvCvnjkEqeBvUVOUIH2+XCmfWjdX15ihWzXPFA0F0LlDpTBVG9qfk503X3/vakGo
         58b8GO7a5J+n9mcmHb4l0pEsY+RxRvK7v5e4Oq7J1IZG2HX3H91y0Cgs27U4tnUwP0Ln
         Wg5DQZ3N3apiBkZlcvwr96GiRbliuYUqw40VH6T1sriVlvXmj4uTzuFC+Uw7dnZHcamo
         Z8abGFZOxzIhUOBf+GtZZ8cUjEKiX5BoUTA2ecOw9H2Jy4foE2Ii8sa6zxku8pmZxVaT
         BXIsIQi5neWkZJCiUWfrSJhngNP3qrNRL3Lu6ucoTFVs5Uk0UhDrgIKDbzlwN5t0oycz
         W7+A==
X-Forwarded-Encrypted: i=1; AJvYcCUponFhNbdDzskilgF8T+V4S5QtqK+rea4x4dceI97GqQxaxma6wEAhyrDHknG1P5TRJJzk/ZFQRDQQhJNtSsg8WRrothHxt5pFedw2
X-Gm-Message-State: AOJu0YyskOfQRpIATpH5JwnGisqSV6AmhCW1rY8bIgJnxz5KlrFRxtJw
	8G+SoFIHH6C/Zd5pgVk6OUzTKGSPULk+9YZEm2jqnd91SEuGZG95CX/qayKEpC0Shyj2dM40Wga
	iz2mZuqIqH4bE0o5Oh/vw9RtKtHaSSaZ3HOfTzr4DKoIfDT17T7UZeJM=
X-Google-Smtp-Source: AGHT+IHd++C0mIqHIx4KMRWW4LIbs1lu5uiKyHeoLqXPiG35XwNNd2mAtRYPPjUcgSTA9cOGPnHrQzdR41PAlHTfXw2JfxIWyGgv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144e:b0:474:ebfd:1749 with SMTP id
 l14-20020a056638144e00b00474ebfd1749mr138087jad.0.1709539922680; Mon, 04 Mar
 2024 00:12:02 -0800 (PST)
Date: Mon, 04 Mar 2024 00:12:02 -0800
In-Reply-To: <000000000000751c0305f19b3faa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d225a60612d1476b@google.com>
Subject: Re: [syzbot] [reiserfs?] general protection fault in prepare_for_delete_or_cut
From: syzbot <syzbot+e621a445f96fd0e94be4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	bvanassche@acm.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13493754180000
start commit:   4f82870119a4 Merge tag 'mm-hotfixes-stable-2023-10-24-09-4..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=174a257c5ae6b4fd
dashboard link: https://syzkaller.appspot.com/bug?extid=e621a445f96fd0e94be4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1382cf0b680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136a5849680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

