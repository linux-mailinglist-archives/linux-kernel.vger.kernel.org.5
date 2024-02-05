Return-Path: <linux-kernel+bounces-52054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3603E84937D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4851D1C22684
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76B5BE6D;
	Mon,  5 Feb 2024 05:43:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A06BE48
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707111788; cv=none; b=IvlOYQr226R6zcZ1XFeSSIAPYCkRwul607It7iGrm0kyiMIyUK8ONl/tf/E/NdX1/24u3QrGQ4WWrtPSzz81uWoFnj3UbjQvj5oZBBZeYZ1rw5zZE2SXOTm7nVqR+ZMg9TPB6+vohAQSCGwGdfvwuOy0NHp2sYqoVWJrZru7yAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707111788; c=relaxed/simple;
	bh=TnyLyi4pbcqB159OUCIuZkkSeOzEbp2i9ZTbIItGexE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pHICMP0PQ6+Ch5XHkOfvSEa/KyJTQ3IJHReBxqKSKzudjV5WE6I6CKhP+Vf2Wk6dkZuFCNYM5pN0KfBywHmiNXPXIqEiKYoaoZDDveXCean4nOzuxM3LtGMeDzCKlrsyehOeuYPFTezuerQDUGro/DOCw/LiNOhXgNuRnv1b4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bef5e512b6so453648039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 21:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707111786; x=1707716586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMJipuFtPGBp3RtGk+kS7GLbd5R6tnIoeFJwWcU4ALI=;
        b=kdLAd7qRWH3zmR+cBWRbNWtRDjMrmXUvDn28UMSDmnC3F+islKpECy4nU05i9u2LeQ
         wwb863L9cTFYggY7XdqHJxPH9kd6iL4V0CpKlO7JUJjrIS6ATu4dO5vrYCVab1tHmSEz
         cz+zcEkgedKNbVi0HVd0LHLFdzZ6e+soaKrFvr0GfWyIxUiTAU9BySPAtK8mTg24FGif
         FrYbk84QoozD1rlwtrRvlIG895W+Vo1TIKFf3chzxVK7AoF+WqxUehvAIwNxhH/JmVHY
         fUERZsHtNBV/irqA+Tc6p2p91KCWvB6bSuU/zUwDNggZ7l+fts3+LTt+qLWrg5YJcwjw
         cwqA==
X-Gm-Message-State: AOJu0YyUW6IKTAhqTZBLPsmZdfxw1FKBQOcPjmrc14Zmxym/DaseJy45
	MdlJ9B0dK1Cpsql6u8KwuY+nYdrY2x5gpGYNr1MyZRrxtVIA7dkVDtT3X8CPJC277znKat5TE+c
	pJ5CSsTdvwXYwLz2GCAsq/qAEDk+23kXTbVkBnzDmZXo2AP9vS3E8clg=
X-Google-Smtp-Source: AGHT+IEp72kAU94xWECWZ/YwiCu07/K9IYp2W5bcr9jghe/WTDNEYnXhrI9FV+HH++lSa8G9IlUeKwW/an0fl+RgchF+rYV6DsCh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4a42:b0:471:266c:6960 with SMTP id
 da2-20020a0566384a4200b00471266c6960mr62202jab.2.1707111786300; Sun, 04 Feb
 2024 21:43:06 -0800 (PST)
Date: Sun, 04 Feb 2024 21:43:06 -0800
In-Reply-To: <20240205050144.652-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d4ac806109bef95@google.com>
Subject: Re: [syzbot] [afs?] [net?] INFO: task hung in rxrpc_release (3)
From: syzbot <syzbot+6b1634ec78e55df41793@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6b1634ec78e55df41793@syzkaller.appspotmail.com

Tested on:

commit:         076d56d7 Add linux-next specific files for 20240202
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e49540180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=6b1634ec78e55df41793
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c2f9b7e80000

Note: testing is done by a robot and is best-effort only.

