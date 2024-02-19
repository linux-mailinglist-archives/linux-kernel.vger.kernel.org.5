Return-Path: <linux-kernel+bounces-70736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188A859BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C921F224F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849F31E514;
	Mon, 19 Feb 2024 05:26:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35381CA98
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708320364; cv=none; b=t6jPZNUtTP+pJp3qKGegFnpfFYvQxEwtnAQMYPyOm5d5YEUJl04AI6jTd6LpxR/Is+p/Pgi9FC5/jMln4fL/Eljvbke4iPsVteCqpSy8bczl+DhvFcmKqSijn/DHFRHOywGdFKvRK7MaIhxf0662GTzzU0oMtwB23Ca2IJWfqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708320364; c=relaxed/simple;
	bh=/UamSygtRoHGtpPGb62UgKOiavVW2OhoLRhrRpKJ3bY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VN9V1lecX6Y1DDyXlDL8/Z6Kd0NCXzS9K8ny0A8GsfNgm2QCQeaiEbcVJb1nhvFMHExOeLm8SLpMhlZnWtEHoJ2bgFXQWJFpBitC3I9hPVGQjNi/42FkUPXniK02gMnBNeQOLHteuFEbCLo1qtRdOFFJ6UrBF70+siuQVW92zo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363c88eff5aso30442295ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 21:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708320362; x=1708925162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOFoFESmvlklSQbncNSApOvu+sIjkHC5FQZ3He6zZio=;
        b=t+Iz6upqPKDmy8Nz4hx79MrT2W98GsPozw8GUc+ukU/rAomu4xPbQ/W/yksHz7Drq4
         k4pXeQ+QVcc8YnmFGE5oZSr5hO2rYWdjsfK9NNOTt4p0JI5wZDuKFElXnd1amm3BBpE9
         iZqgnHxg4uUH1dxRi0RykQEcko7vRf2t8R0Lw6nZPNrk3tbSWWJ5DIm2u+qIOceKyTcQ
         OHTtHBM+8mApcImu3XBiL6mv5KEVXB37Cn3hOWAONqcrapjtA/at5WqmGhyEIWBx98q+
         YrrQNG8az3G4RkzN/4O7xdchhZggvyV0U5CVJnqvc5o+RHi8tP3sqGfcsBXRwoOGUSol
         bVpg==
X-Forwarded-Encrypted: i=1; AJvYcCUp042lsymb87ZEnNVulbnH8OS0GvEEL1OTnoz1/FkZO02TMe8fynNVZXkNEo/Y6aB0IUuf/cGm5//nxckYa6wCQCIjWm0EZ3xCadSD
X-Gm-Message-State: AOJu0YzYIkStWEagzmP0OCI4yxNpli8l+MAICAMqzlgXnJTD88l6niQG
	DWooNE2+MH/SY9UpiNvswLbqXb09eljstWqf/nyWcPL/YXM5vLioep5hBo3GsbIYrgrMhz9LK4m
	8GKl93YH7om6QrmSWruiJp//DqlAygNMsMj7SATN/Xyz+SJrqTInTHyI=
X-Google-Smtp-Source: AGHT+IHSD6r+WANqHstIaCKHCJUTmPR9yzzjf/m9rmHwC3SEFCPekxM9WqAzHDkGdt/XQG/5sU2TdpvwzirUzbIFiKnXK8KWO+xb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:365:3328:6324 with SMTP id
 g11-20020a056e021a2b00b0036533286324mr99180ile.5.1708320361966; Sun, 18 Feb
 2024 21:26:01 -0800 (PST)
Date: Sun, 18 Feb 2024 21:26:01 -0800
In-Reply-To: <0000000000004f9dd605eabee6dc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056790c0611b5548c@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in __get_metapage
From: syzbot <syzbot+84c274731411665e6c52@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, damien.lemoal@opensource.wdc.com, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, jlayton@kernel.org, 
	kch@nvidia.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13310158180000
start commit:   1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=84c274731411665e6c52
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1702dc54480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b9eaf4480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

