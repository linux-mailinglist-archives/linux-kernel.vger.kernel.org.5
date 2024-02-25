Return-Path: <linux-kernel+bounces-79976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F0862918
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112B6281EBF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CBC8BE5;
	Sun, 25 Feb 2024 04:33:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF51391
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708835584; cv=none; b=TFxLNVLjRvjGctL+kMMcangHQcL2q3HT+EnSaQhjOVp/dTGkdGg8O2FhgxRKrX0O9y13xn+OXFJjcaSWbw/+9n/ERhNhR+Zb0czVrRg4LW8xqzSc7YKJOGDUD7vKUbwMF/8pqTv3PfVaVlXW53aeMRv0rXuFzCX0j5tO/71K1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708835584; c=relaxed/simple;
	bh=S4ce2P6MUe5mD8ZBiA9pkBV1r99fMRw8HnSSTL+gIM8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S/nBi/PkRyc/dgV57CLz5Qoysnv/jAn+km+tmaFIeSeTUzQTuIACpngDGR7u1lmy7YCquJ1If9Mwck76gPUtlyCw0uPcm3EjodwCIUAcvR1hmNxLrliY6bpvAQPKnHpEEnSDr0svk4ryZsKbQUitn9epxmzldyA9IEBM5SQxt6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfffd9b47fso215731039f.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 20:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708835582; x=1709440382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MY+QipqJtlC5G96EVHf+xLsuLydsGm4Pmqrje57nWCk=;
        b=MluyG+vR8tsxX2GpKnMKpebtYM0yKwCIXWaX+PJfM7XMdWRKvGVJa63CeywCi4cj/f
         OX+iZ7KSAgdUSZwtVq0pC+VQlVd2Yc/WVcpn6YWJ71xX+4DzBY6LyvVoWw1Bhsueijav
         8QyPkTjkOqvQzTskCt3CNmiAvRjkhfHOXwDWYdgyW07s2BbFpGzdApN+iebVUpfeAT9Z
         BwodvWaInLVDMkB77o7pIc0wYhKXMd3hsWX3UGucYRcn3/tX5991LUqoz9vcthrjV6ye
         Tjxpjqjn0Z95DBr7fIRQqiFeKidi1IyNAf5I+47r5EfqMPcS5ysZLJL+jPjtj48YDjvq
         lDhw==
X-Gm-Message-State: AOJu0YyGrBt6RyfEFzs2chCFzwZUJ3eBF3I+CQwhZWxopoNNv+AnEIug
	Lo1xUl/Nkywn1MNbwfTdUftgvOMcTleFtvhwzBneVw3f2QLXfPT7Ku8X4PP+pdbLsVA6If7mPNk
	RkOx74tR0Jp9JtZIifdQzAMEzY67KGEa5yYWDTMMSxDcUEBnQ4TMnOoUgfA==
X-Google-Smtp-Source: AGHT+IHmWEx+olBbrGx7evZCoCx4jDV1/G9KNimr6rSjLyyeQBlhwk67JfZywqJ/FhykB/EqkHV9O9gj8XF5wt4FDnQmxpgkoyuv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a9:b0:474:78a9:778f with SMTP id
 t41-20020a05663834a900b0047478a9778fmr90654jal.4.1708835582030; Sat, 24 Feb
 2024 20:33:02 -0800 (PST)
Date: Sat, 24 Feb 2024 20:33:02 -0800
In-Reply-To: <2eccab0b-c251-4094-8f2b-2bc9ac3def8e@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8ba9406122d49f9@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=115dcc5c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=373206b1ae2fe3d4
dashboard link: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1018e874180000

Note: testing is done by a robot and is best-effort only.

