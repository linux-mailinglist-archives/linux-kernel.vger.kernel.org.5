Return-Path: <linux-kernel+bounces-125970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F494892EBF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0BA1C20CDA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0D79CF;
	Sun, 31 Mar 2024 06:39:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C656FB0
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711867146; cv=none; b=r5/5GoaZptfpW9I1un3DEFriYAZkToV4AxVjXE0BrvOzEjRpkPp4dKeyqW8aN44SucgNtWIGExcaBpPqodTHM8fuzf4UAOPvFwaS1HbE2NH2x/NYc/8aI6w2ixSVoGe3mkBYLUDKKMz2qjnc9sfA7WaljgtmoxbyvL2Wjq4Dw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711867146; c=relaxed/simple;
	bh=d0LbC7NP/kY3ykwR5ZbFSBZTdzpKeHD0SZmMQO1UNfs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FDWHoNqYyRFGSwOR5Xpl13F5zkrqePcomZ2W6V9QeYFaiR0biFJXa2OqKaVeGWz77IPBOWeTeb67ueuKhFPaClO9+CsQSxk2uyP1uptJuP30t3997aJNA7sOLNvHycGC3OYdGCxy6PzVtGfUsdUPd6GPTt1ZUx90jHLDryi1MgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cf265cb019so264644939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 23:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711867144; x=1712471944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQ8VuHx3zYYL3CHeHPvJ8zJopr1d1QL2nszjux4HsUw=;
        b=SuvRTcyGC0w/uqfE+cHs7m0k7o24CgXnR5HWzR222JBEj+vQV5XVBPMT3DGUCvVL9D
         Jgqczf6HE/YMPy2TOGzZ0reRrnVAGovxAImxZyDq6wJhTI8BAC18Poh7AEIhpI44yT7u
         VXVQSTPBQ3hizY45JnEMspZzsMhno76M0Wl18OHWKOmRjQD7c6jTMY35xyOYlof8A1bS
         i6gUGeW1mFxF/KugOaeakjRdCELvB2Z4W5jEuqEtvQS36HPB7L46NvJgnpXr/drdMpPa
         mUTQHwQckJ6N6LBMqhvpSzZjXTHRrgjKVmaOjlTAbOy74IHzEmY3a1Fs91VYw1HCDd9t
         v71w==
X-Forwarded-Encrypted: i=1; AJvYcCVImjVcjjGEyst95GgmJQPa1NJ8CLUcRRErAR3m2eyzwmF+ixrtWTiwdZ9uuNIT/Q0Ogt7XtQO512HUqBYDxTrTNegI+cr4YeH70GF6
X-Gm-Message-State: AOJu0YxrHm6JrbyKgXlyy7Mtkv1cyDYa3gOZC6HyHDI6S0rxG8oNJfn7
	2K4U3x1WX+r4Me6kOqHUigx33Izia+X1Msx6CZ0Ffqf9G03d8Ht7Y5b6aeALptJhyUDgNU3iBVv
	zRruQAG3W/cR0mhLN10WSg5rNeFg4slFklkDjz7/3JNnKRuAmOs4jjok=
X-Google-Smtp-Source: AGHT+IGQUCI9vVEX3ax0ensR7zYCjlOjMwi0gbYoZRMXnUo6G/ac15/KJvQ6TyQ/2wqGdMrZwUFwc86hxopMJYRsCGnRlAldc12C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8911:b0:47e:e6a1:d1f2 with SMTP id
 jc17-20020a056638891100b0047ee6a1d1f2mr137889jab.3.1711867143893; Sat, 30 Mar
 2024 23:39:03 -0700 (PDT)
Date: Sat, 30 Mar 2024 23:39:03 -0700
In-Reply-To: <20240331000912.3242-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003c53d0614ef21a4@google.com>
Subject: Re: [syzbot] [audit?] [bpf?] INFO: rcu detected stall in
 kauditd_thread (4)
From: syzbot <syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com

Tested on:

commit:         712e1425 Merge tag 'xfs-6.9-fixes-1' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13cd811d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
dashboard link: https://syzkaller.appspot.com/bug?extid=81f5ca46b043d4a1b789
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c7aa1d180000

Note: testing is done by a robot and is best-effort only.

