Return-Path: <linux-kernel+bounces-67245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F187856895
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F284A1F21EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379413399A;
	Thu, 15 Feb 2024 15:55:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7805912DD9A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012506; cv=none; b=RnYkaJWe18qcME0LSjHhj4/j+EJykjB5iu/TyzOvNs2UGxLCXB/CoY9pSzCWqrdSp1GSE3CGdx9YTcPh/S+QeAEbn+3gjBQVWvYBeKRfbp8CFayQyLltoazmpfjOa4NdyvwFo4P13jyTVwN4ZInXm0qiqmnxgnqIplF7vkJY4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012506; c=relaxed/simple;
	bh=+4TZlgebhzAvm1VpRqSBsRyCiXLBSLYvaaBaIer6eCo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CTQXricTKOZaPFvNu/7ZVn1Abtj8guZ4ryuu0LkOyfvV0e7aMAMtGoRRxlyAqbK2JOc6IYRMrgaqwDNXf5ggHRIVJSWfxilYrErEXwzDciM3TL5I3qzvjH65WV1MfLCQdNGcCYoCq7EkLRwfEj4UztN8p+9Fhud7YK3LcbURYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-364f951ecc1so4252675ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708012504; x=1708617304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFdOD7OAEDjyxNFLdci4Z93aJp8BsVRUDZGBHng3VLI=;
        b=gSgmXChXtbDSGmrwN2J07n2WXJ3oUnUP+A7VkkR1yRS2EoLCogeQ0eEY8FEGRP0KSZ
         3RhbQLYY2FhQjsiq031+9nhPDlUYjwh7RJHhZMlK8FKcK7O2Sww3PWbISKT4fnQFVYFg
         rS/C4PNKfP73/piNe/XmeeSbri8IqMr4UGt16lqwLbxyo2/WJOFwqQ5kWskPcd6ep6fR
         EEYFwiOS4ESPuHLUlnBHndu2Sg3kVOtJqp/tRbMPVbhwY6SdEOyi2JSSmseMoW6Vcx3l
         hPExDwo5UDpYGNWJW/D8PMbhH4iJQHHqlNLNz3MOVUgvXreY3IpApjEXJuG9/xPEE3dN
         gtfw==
X-Forwarded-Encrypted: i=1; AJvYcCX7YEAdWt77J3UOVaPJt5famQqGRQ3sjtM0QWO/+SKM8VxvtyX5HsxTn5GVan90ajgVhSeEqTGYhKYg6KMQ17dM4p6IwXe1UMmiCt0G
X-Gm-Message-State: AOJu0Ywpnhs+htf3bSBl9jkLL9ZNVo3kbvt7i7osaITQhclJoqHb8e44
	tTTFI3AZgJxQl0+627Mgf6mv3iNvk7Yz5VMsXNP4hP0eNBG5JDGJJGQDnNWSiKXxjgfJOQUIFNJ
	F7C69SbYWvcVbQkNQBIElc/AVcZIm3oDOk9l4H5TZ4WDUoXPWWjnS058=
X-Google-Smtp-Source: AGHT+IHg3+0VXu4xAp48vJ9xsuI1lRPvMGC2t0obYLjYmlvcH9IvQWj8jo3htzenu6trrCBjyUtW1MD8Zl1vuynCLiUxkXm9pvIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c43:b0:363:83ec:3663 with SMTP id
 d3-20020a056e021c4300b0036383ec3663mr120994ilg.2.1708012504622; Thu, 15 Feb
 2024 07:55:04 -0800 (PST)
Date: Thu, 15 Feb 2024 07:55:04 -0800
In-Reply-To: <0000000000008a91fe060164b11f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c2e7d06116da6ba@google.com>
Subject: Re: [syzbot] [fs?] WARNING in __brelse (3)
From: syzbot <syzbot+ce3af36144a13b018cc7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrew.kanner@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, hch@lst.de, jack@suse.cz, jainilpatel2003@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liushixin2@huawei.com, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16bdd592180000
start commit:   d192f5382581 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=28e257d54f02de1a
dashboard link: https://syzkaller.appspot.com/bug?extid=ce3af36144a13b018cc7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15302152a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12771152a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

