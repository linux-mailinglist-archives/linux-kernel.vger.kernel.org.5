Return-Path: <linux-kernel+bounces-89684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401E86F426
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37FB1F21BA0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E57B657;
	Sun,  3 Mar 2024 09:21:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDDDAD27
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709457665; cv=none; b=JLcPi928VOB0+TWyj89GSpeKxMjkl62x7gGjyYStVaQfs5viNovmyn4FjbC3BQKRYh3dTzog19cvEdA79Cx6+WtfpZv3Whre4uLvXanpyXGO5wBQbAVzWasduZ38/nVFWy/KeePsacCltyTFhMC1jbBqFDXaxcpXaJ/dycAxIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709457665; c=relaxed/simple;
	bh=eQ2zKyXcg6lchPmJDdH4J88CdY7LkmQ+FwqDiZ3fWrs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cQ8kdcsvnwWJzKq0Dbfltdpt92p9KNRR0175vODEd3hMeD8sEGDgsTuA0CQfa8iK8Av/5jppPDDUxPF0TTkte/dNcYCcu2cmHTKwZNsXX6N6ZOoUFyTg22LGp2o+t3nhCcr13LrvEnDS0y+6BjPqb320/YeVmXHnh1aCNakoYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3653311922eso41937965ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 01:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709457663; x=1710062463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnnr37vr7kK8/uItRIjje7sAKUW3hU17pprTGtiVvYY=;
        b=i5RUe493ZsouGyLdvN0iI95Qdf2DiMVVg8YUyLpIyH3zVrSTZ0Cj2rSWAEVno/cz7+
         2wJwbDYi5N+Er80xECj6Ovsz1enA+7IlWlWv4K7eLUon8w86tPqXLu+zT7gscMQfmgAm
         swQ5QogoWVsZkrQMvErS39sMlZQxZ8VvHuog20oS8iJ8Px/9TBFlkuUnFl6rMhtJavWP
         A/eWMaPnQzbwNXCSRfB4cDvT+yj1n0sWxzzfkY0A2NHY9PkT+JeyFMtBYaBjXpmaNoQ2
         GzyIfD1laZgWoeUsniDvMpn0oVdWss99x17TTzOpJI3blrrTLdd1bYoDZ+KxjIBq/V4g
         GA2A==
X-Forwarded-Encrypted: i=1; AJvYcCVu/BMOe74sEW+G7/a/tn2klf7xD8tEFpWiZ0xNdP+FuKH2Hvt9wpBPhTgR8w/bHwZ7V6b03QofquNEcqnSs9+8zFo8+OmjrFdjN1pi
X-Gm-Message-State: AOJu0YwXh/T99gBF4NUbRTXrLLcRD4NBZi2XAhja5OpcwAWuLnJY0RFJ
	yZpI4JurtRd41AXMMOLUhrpv4zlggoiSeBUaDTripXWgsaGrQods0sVa+lXv/hsT2W02oavaMjU
	b/KaOF0zzmmw95A6+T02jY8/HtLoOc29l854VfDDGwM32onUreV35MWg=
X-Google-Smtp-Source: AGHT+IExuAl1BYRZUWOqXt/mPBBPeN+jgdmkqUJMT8iH+3nUEGBGafeE5uibvMk2oOpsuDQS+nimT4c6JqP26uCjxEZUZJS11+AF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:365:5dbd:b956 with SMTP id
 x5-20020a056e021ca500b003655dbdb956mr353124ill.3.1709457663236; Sun, 03 Mar
 2024 01:21:03 -0800 (PST)
Date: Sun, 03 Mar 2024 01:21:03 -0800
In-Reply-To: <0000000000002373f005ff843b58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6b0fa0612be2070@google.com>
Subject: Re: [syzbot] [reiserfs] kernel panic: stack is corrupted in ___slab_alloc
From: syzbot <syzbot+cf0693aee9ea61dda749@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, cl@linux.com, cl@os.amperecomputing.com, 
	dvyukov@google.com, iamjoonsoo.kim@lge.com, jack@suse.cz, 
	keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, penberg@kernel.org, reiserfs-devel@vger.kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1629e3ca180000
start commit:   e8f75c0270d9 Merge tag 'x86_sgx_for_v6.5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a98ec7f738e43bd4
dashboard link: https://syzkaller.appspot.com/bug?extid=cf0693aee9ea61dda749
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10310670a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1220c777280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

