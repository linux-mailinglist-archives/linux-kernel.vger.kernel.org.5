Return-Path: <linux-kernel+bounces-106778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E4E87F361
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D5DB21741
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F85A799;
	Mon, 18 Mar 2024 22:52:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0E5A786
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802325; cv=none; b=ogceirmnYtAH2N1aUDuk7ZAb/Gc2XelRcnrgEdZW1x2do/ih+dt1Pt9rD/SbmYeI+1Fu0J80lxJUbwoj7moIn9PizJtmPZA9Hcsgq/M2rzM7jpq4AAy9q4tDAYCwrl5izf3vKeSoVjuGFAL3WrGsS/opYlaVgQywl53BIKu3aHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802325; c=relaxed/simple;
	bh=rc75pA5QnIDKWmYqaGlgLp9Cbg1SQtg1gmXLtGLPeU0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KAZhsRHsPvjdPb7CRPP7tsK0ta634bZadQBsELSJ9n9nVuWKCT15pSyOKUujoDU7Obs10gDSJJLK3PBiOn+QbNlvpPKNPIW1BZ6/NaUhl1UU5KEtwhLbYSC81pcPjRFm0OE0HUTxg+aUz9Ob6gHFiZmX0BIo9b+kTnny2VRwU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc0a422d43so253628839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802323; x=1711407123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuuU81/mBTibP/+ky1rBGJGEXBkS4x31NazlmPaf2FM=;
        b=byum8TgwbTH5grGvhGQ9+VXaXyeK6sBmYvePDtzMcDzJ3O4NMFqBnH7cCZuvFYvh91
         wkdkkDnuKYn2M5QFHzQ4Eo94nU0UscJHEPs7F7uTmNHfYOftWclX3IUWPtN8BsKMuIU9
         pXp137V1EtLSiIEu3f//fdISYWGV60LDFNkh+To/utjVPn0IDjVfa6zXQJwXHFaJpymE
         jK9NXxmG5HZsRYWcokvCo9e2od30p0pKFEUq0AyFQg2UPPxLfM4mH1NyDt3jsl6p3Xl3
         3Zup/d4hGj6fx+tcvCv23k4TqahkRPIdJqEHoP/xLZdvenXC7A2NprV09UA/13Vh0CeG
         I22w==
X-Forwarded-Encrypted: i=1; AJvYcCVSjYzRjJ3qFY0wB/lGI3AlRvBLKFg3XtSXU41lQFBwzZwUGs7jqivKrYc5acYUwNukaoZidQCFCBWKCGYMsLupM3tRqTWXN0pPZpkU
X-Gm-Message-State: AOJu0YyXbLT+7eWvbWdK3p58wpsQHRAtgAwAS2tgmXMHDEASMYNz0z/+
	1aHxgRnuxYCzhcnE4fkN8WgebHzkkE6O8seVF18XUPfYNGAqKJ33KR9o8ZivQAxwl0VOsfG4zTP
	e7Qfrf4n2dfAmK9JKMpAQA8B5nx2Ws/uqlQXXPIzm2SydOIl7F8/VA4I=
X-Google-Smtp-Source: AGHT+IEIKiNUWwyhUIbfizqWZQP9QnVCpOA5o2s3QIkvWgzsePEzPgS7b2CQ8aJJIfwFARMHxLo39UOCx62fnbS+JygCVpr6iio3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34aa:b0:477:303f:e0a5 with SMTP id
 t42-20020a05663834aa00b00477303fe0a5mr7737jal.3.1710802323262; Mon, 18 Mar
 2024 15:52:03 -0700 (PDT)
Date: Mon, 18 Mar 2024 15:52:03 -0700
In-Reply-To: <20240318222715.86329-1-21cnbao@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c261890613f7349d@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
From: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>
To: 21cnbao@gmail.com, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com

Tested on:

commit:         e5eb28f6 Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=109a75a5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19bb57c23dffc38e
dashboard link: https://syzkaller.appspot.com/bug?extid=adbc983a1588b7805de3
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177266be180000

Note: testing is done by a robot and is best-effort only.

