Return-Path: <linux-kernel+bounces-106907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D6D87F53A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788EBB21565
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3C64CE8;
	Tue, 19 Mar 2024 02:04:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9508733D2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710813844; cv=none; b=XMpIgZIDOwfV+QR0u7f3G8nArxdSeDzVcCfyqeFOLNA7eMMlEuphIiwgudHmD+CRtcgTkz3QDvDgM0MbsM6fMONqef7F/r7UxT10SwFnrzPXyidqai6Tj/MT47VSRPgFGTofbpzL3JExQ/toDgjxi2Oht4Pdog1LeKVy6QHKzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710813844; c=relaxed/simple;
	bh=ksqDU0TRTeGRxLIqrBTDd02ndQeCYOSHDRjkcrjlfnE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ktN6uxC6KoelMMCkQ8GKpt3ddL/NjdGuop3Wm1bgRkBMY8cu+n3Yo69CS1LMKUWAd9jiD4B4J2iK2dYgKG7wQ0qb91fMDsstDv4A3RPSFPu818z0K/vfE1mJBbcuWRWVOEK6DqJ1ZDnRterERj/mQq9WQ5ygck4riPodLFcww8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36696c9cb23so25491355ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710813841; x=1711418641;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Px/lgE/Pk2JFX9HuFwNuF03dzZHfUq2UjRAys4rzc0=;
        b=puItg++Fvt9TMvKkfr0WI7oEmv11l14Es6KmIp35bM/DrquoHo7WwTzzgxyuHlwjkp
         KVMtjz8MBFTA5QgTs/xlwEG5+2SGJTRbXzA6j67m6NfWlopUyC9vOYXP+pIACMcYSM5e
         sbJucxR6DpMW0palUva+QbZL2eBK+4N8Y6R5uoFH0lKk77cQAHym2+two5ZPW+1XGuKf
         4UWUfee5nTPLtH7q2iQrdpP28WRgqBNLy0T4RTAucfWXBiG9eJe4taSqc6XzcrOzzVLx
         Bm4//LTv4/kZXchk8uXu8TGs8h7PIyEaN5L3Od6YI4GZGF10J5+RQT99V+ne94xRKx3K
         etXQ==
X-Gm-Message-State: AOJu0YysGkHT5qesdiFkUlQ0MYXB9s+rSdg4RtGRP8c0Pr+B69ozLZHQ
	pTrCg0ShcwQ6B2/0EYVgZmeIj4MK/KYOOXy02FyJyb85ZZlpiiHcHiq1T6nxcJPyzORXt5s4KTj
	HecTJnmPJE1f/sfhUErLnlUN90SY77o2uDnTKXGuGpCAMDEAsAX4768G1ZQ==
X-Google-Smtp-Source: AGHT+IG2+Yrba8S8SM8kYIOnk3yU8YtFNKB4P66oD5Q30Ex2B+BNI16pja/gp+e5XmGIm4sNEQeZiSjwsfeDsRgICgwN6LSimurL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d92:b0:366:a77e:62dc with SMTP id
 h18-20020a056e021d9200b00366a77e62dcmr31885ila.2.1710813841754; Mon, 18 Mar
 2024 19:04:01 -0700 (PDT)
Date: Mon, 18 Mar 2024 19:04:01 -0700
In-Reply-To: <ZfhkEAPPZ9RLi1Bj@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050aa450613f9e34c@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up
From: syzbot <syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com

Tested on:

commit:         9f8413c4 Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14bf39f1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163f8231180000

Note: testing is done by a robot and is best-effort only.

