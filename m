Return-Path: <linux-kernel+bounces-41561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C133B83F495
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAAB2847A7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37F8D536;
	Sun, 28 Jan 2024 08:24:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5DD527
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706430245; cv=none; b=Lc8reKgIRUUrKYdgtrSAi0tKnJT0F6fCfnRJXm5p5WY5p+HrhQiSICMHFqP6mR5tCvi+eBhCvTFZx60MOVxjLFsZsGOX4CiZG0YWn1Bo/+5WaPlXNKzVovjGwzbZKEBnJb5ZlhMblZPtJAX2HHFuJbX1kb2ke+l5q4gQpsFbeAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706430245; c=relaxed/simple;
	bh=djVxdPh6n+qvnaL858ysLJDEfmAO6wdLChSO/yDb3PA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O3HSKkdhWGsO+iXNGvZSzLV6shzfIV4uv68ABW9bj+G15kPgpFKQp3PVwDzy3RbZsfjLQF/ufAmAvV5fevIQ7S2PtS8bt+DFc1Y5dgbT8KrZtknttpHMq0UNXB/ygdrNjv0h/zrnTD5w1LGg8sO0EoMex5DuI5SYheMKbMF3Ue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf81e2e5d4so111478739f.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 00:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706430243; x=1707035043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tixAC/dBvIqFOvEhGo9DK9KceemeQG3mheOFlZWOP6Q=;
        b=gbDFGfDRyDsQbmXRfXE5YGgoqszh8248Ldvoxm4XTuWuEB/MizToouWTPRa9flaNSe
         9/tceYe6042EuJkDdw7641Wcx8P04DUVc6uRVztZ3joALmJcHKQKZxsGJgZVHs7Ol+Ar
         yM9PfRGBxcPG2Ja82PlIQgRlq+tzF361dXbCZzNmiM+kfQtu5Y9OnjPTG9Kgs56MZSXb
         e+cwTg0M8vSDhaOuxFYxHQS0jNt1GaSCeNoPnWG3Sg73kkFXa6Jf7nhVtVW6hRZ2AvwE
         h3/UADZ18OFNVjeaEt+mz6bciaHYUclaXR9/w7ISZEH2tTjqqTa3GgYUFE/50bWA7HE2
         H8MA==
X-Gm-Message-State: AOJu0YyhSmysECpa89EG26xTCq1yOpX6iSG3xm2A/+dwh8KQNV6R6x0w
	x+FXwmpBEWYhVFxm32YSOJfiu/jHolUXaA0z48LQxfWpnn/KzsRtbSceivIsbHTP8TuqzpgTsFI
	E+nA0mT3oCXAn62dgTGogX++JVWWiAHrRFFVwZfFwOWththd/bdTx2uw=
X-Google-Smtp-Source: AGHT+IF67pR3VNWWo1SuW87LsplqdcqKzYshdZhqNyNpYPrAkaag/WWqxGgefTZev3CRKnV6c6YLRcmM89oW82EfwPk9gGUKv0FK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e3:b0:363:7aed:f073 with SMTP id
 l3-20020a056e0212e300b003637aedf073mr106632iln.0.1706430243219; Sun, 28 Jan
 2024 00:24:03 -0800 (PST)
Date: Sun, 28 Jan 2024 00:24:03 -0800
In-Reply-To: <20240128075340.1015-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b3188060ffd4061@google.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
From: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com

Tested on:

commit:         8a696a29 Merge tag 'platform-drivers-x86-v6.8-2' of gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1516855fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5057c9bffe24fc70
dashboard link: https://syzkaller.appspot.com/bug?extid=da4f9f61f96525c62cc7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

