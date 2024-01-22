Return-Path: <linux-kernel+bounces-32319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7AA835A08
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E531F22636
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6C4C7D;
	Mon, 22 Jan 2024 04:21:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1721FB3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705897267; cv=none; b=SqzWv9SGaxwtPq3LIPSPejZgLNMTuXXT6gfkQGpEAQ3zv6kLpZARCbjMXuVfcHWacCw+kJcTMcGr0pTOsjJW/selrLOQikqv5BGibHF5i1jRMGUVVcxRsUYKuPB8svdI4rkuX08YBeDwJC0mJ86rxvZzZkoTe0Zx8uZ78mHznks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705897267; c=relaxed/simple;
	bh=yBknp7rDoro6OnNzFvJHw0ELV6UD/IVEgSajNLaz2Aw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q0Oxxp1UaeBpw+eFqpPBMGU0XTh1Q59dEk1ediBy/iyFDmCYmXWAObKEusut/Dqw9Tah5ZtKp0Cpc0jziynsYfPHxBzSiAqF7/KxOhYSYpjXvXUHm1VHDc8TNo4SYmgfotbrnPBNUW+SjKa0/r1RsW5HBBkitD9nuI2AeEX/FLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bec4b24a34so467227739f.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705897265; x=1706502065;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXPpclGAIFhBERZDMtHr6l2YeB7w8V9HRVruQN/Qu+8=;
        b=CIHZcDx+A2oKnpoCPoJrqFO6ubMQW5+vwGiIoF1UCMr4y6R+IlkQyv6QWVLYkaK97Q
         K6n7ShCAB/tAKou8yi0SZr8E6/CDFuJR1geUscUgSRL7opld9TFmfbE36c6vQYIMYsFZ
         1c37/lCWw56i904ThvQuSmbb+OIfxBtVXkIF4iXk57N3d2aw63Tz4tpn+UIW8GjA7xTt
         lxYNWC+J+RYvWrUMb/dDk/SCoAM21xrunewRFPqUiBGpC2y5F3PWSh9BIUcO/EqUupRU
         eSCxnlK+SJNyi8kCuwr2l21BE7HHLGfAq++xG6JDoLP4UIn/oiMTqbhrGeV0uzA2Yh3d
         n9gg==
X-Gm-Message-State: AOJu0YynQPHjA+txVtW9Q/C8Wj/JSwAQ6SOOg7LOY0wAcCz8YE532xB4
	g/sa0rRc7zQiGkNm0bWM2QeDZZCbyFg5V4I5he7iSgMvH6wkYGp8c2B69xqZkIySAFMpp1mvnMx
	TsLZJ+MQk5xLkgc3b2OAG/+FgWEFoMD7ffkRic+f6eFRexMWJKoef5jM=
X-Google-Smtp-Source: AGHT+IFSsIjvr32mvZRZi+H1GDgew9dkknvF5/aCpqQSyYakV+KxA95Xjx9FhG/BiAb9fGF/jstKcbpoyx9sMfrq2hYyC1dUnDzi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:361:955b:17e3 with SMTP id
 i12-20020a056e021b0c00b00361955b17e3mr458490ilv.5.1705897265051; Sun, 21 Jan
 2024 20:21:05 -0800 (PST)
Date: Sun, 21 Jan 2024 20:21:05 -0800
In-Reply-To: <000000000000d482ba05ee97d4e3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081bcbd060f8128e2@google.com>
Subject: Re: [syzbot] [gfs2?] INFO: task hung in gfs2_gl_hash_clear (3)
From: syzbot <syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, bobo.shaobowang@huawei.com, 
	brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com, 
	cluster-devel@redhat.com, dominic.coppola@gatoradeadvert.com, 
	dvyukov@google.com, gfs2@lists.linux.dev, jack@suse.cz, liaoyu15@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liwei391@huawei.com, 
	madvenka@linux.microsoft.com, rpeterso@redhat.com, 
	scott@os.amperecomputing.com, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137b2d43e80000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
dashboard link: https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b6f3f8a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1688b6d4a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

