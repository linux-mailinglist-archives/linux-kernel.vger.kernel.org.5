Return-Path: <linux-kernel+bounces-66883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7D6856310
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD051C21861
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4715E12C522;
	Thu, 15 Feb 2024 12:25:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770576A339
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999905; cv=none; b=srYqBPrxYI0GydAowlXYrRIG0PGG5LmvRfubGRLOESOEcMcqDFlkxQYvqX2OlYg5l2OJYTX6l/oIUz11hf3KxHfTj0pcQxUgi6U5cKOSkVI6ZhlK0ppUXr59iyTns3hnCzLitECAZ913/RUbyt25R857K9JTDhlURGjQyI3jAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999905; c=relaxed/simple;
	bh=cbYGo4HDgoNncSDJ5uq3auqAXUzsWWUbiMoWoHHkXSA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TQBhVBZfsJlnzgW9GqmEQVORSCgzz5X7rmjsh4d+ExtSb5ldSSap3d88HqX9RtgHu7TX929TriMmqzBIWcbzpbvOiNwJGdfZnhtaHjm2zEyaovbasiyCmyKKsj7JT0Ph1hGziT/na50lQ9VioXPbbBpglnFKKkdIMpoMdiqZts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-364f79395fdso2387305ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707999903; x=1708604703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lT8sIteF3Dc3XOGgTlLEUtHVQJe3KmEA1oakcKJeto=;
        b=MFAHQnlflXT7YMdv+j9B9d5qJZQoBxQMWn3Yil5Cx03xggHsAP1GO7EAZZqPeN7bRb
         zuZXCycbWxnvcUrMVi0mrtJHMytgqQ9R4LivWW9tguOtbcIHxtEO7E17Qd0pVeiWR3dk
         cfWSphczGn9o6MCmFRBKKHRdfoeSaRS453Xoi2r3S2o1YfQrNcMQVHxSFNH05RLR5Qbj
         HmSG0GOKe4ZxQehfctkrE71uxidJ79wXoaZUSZbO5FRvaGGmlwqm/tNGMaMEWitnHQ4z
         Lj8V6ipscDptVANGZOB9HkMWdkR78mAGdiGhE89ImH2qdtttnyF5K8AuoAEnYHwCG7KX
         MHeg==
X-Forwarded-Encrypted: i=1; AJvYcCXtkWJLeuHgC0Zidg93gTCU8KzhMKf5uWDBef9WJ1mSAdjlrw8B0RFkBMA+4h2Q4GkyF3xiGSol5az29iPNU9adeEit/atptwePViga
X-Gm-Message-State: AOJu0YwqEbwSGOscskBOhaRtcriiJpKzDy4Dm6j1E3h1sYVBivqYFVYx
	CU0c+YC9r247vV6a3wgnGRu+/O8Wy7E0YOdKEr3fKMRctIUCsUhnv31bzRYLi1heA/Z0IyTtQDk
	bGnHe6cQChmOTFWaxvyc2xae6D7PUPv4lj/O10bdbXP17FXuyUy1NTdU=
X-Google-Smtp-Source: AGHT+IFHFIqK1A7gxWTe9tyT8lk9TziyAZerOxD/hrXFW7XDwdv7iznXfpbbQC9gatD0PJ7JXZeVQepz49vDiyl0B2VcRDlT1BxQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:9252:ed47 with SMTP id
 j15-20020a056e02154f00b003639252ed47mr131693ilu.1.1707999903591; Thu, 15 Feb
 2024 04:25:03 -0800 (PST)
Date: Thu, 15 Feb 2024 04:25:03 -0800
In-Reply-To: <20240215113851.GE25716@breakpoint.cc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087b4f706116ab735@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in ip_set_free
From: syzbot <syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com

Tested on:

commit:         8d3dea21 Merge tag 'mips-fixes_6.8_2' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1615eee0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d2ba14dfa6c1908
dashboard link: https://syzkaller.appspot.com/bug?extid=ebbab3e04c88fa141e6b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

