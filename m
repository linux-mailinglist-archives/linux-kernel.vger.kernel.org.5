Return-Path: <linux-kernel+bounces-73009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0275B85BBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94C01F22B13
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C35469963;
	Tue, 20 Feb 2024 12:25:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784B67E9C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431907; cv=none; b=U9CrQoIbcAweEd0xG8fKdtdDKnT1JvutKZJxFf9Nc/y6CfVJEGHa6vYkAjWclWj/eJetf454yshSfGx2NcopCo3sprNtVOY1zrYKAsEoKfrKndb5YB0z0ZRnOoxmzgdcOYVM6HOjffNq4ZZWPQ7rkhrLZ3OCJW+zEAN0PUuFOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431907; c=relaxed/simple;
	bh=3t9dR5gOF2+q1doSg++v1C2Odo+1zjhz6+p4+jEN+bk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K4wN705X0yQlZ7TF3LPr3ZO7eOnmxiVvGwVGW6ie0lACMwbwSbLU5nXe8D7pYA8+NA5iAFePJyqNWGAU7DtcOfhvh/xqRUH7xLwwt23ZJPZ8SU9UmM6iNOrFC5S2rhfi8eTI7mmWhSJEJmKRZ8YUXx+2e3rith868aI/FKsdDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3651a2610d8so31319495ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431905; x=1709036705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t98unJc8id/hkIITRZDWKmSNdULbzVWQwwxt6jtKcyY=;
        b=FUqWS9rtdQIK6q0TOhmpshUHBzPS85AMHVt7u30TlUPT4ISEsiPNu14Nol4vZeRC3f
         De335jjwwUS58jZaFftUkL5X2P5fwGfFj/HXPYxMD1kUtZdHZjj4hA023IFFr6Rb9XE4
         LbLaoUfqBZEe7WmabXSMZHjNDyMY88zNncUDaI6sTzIx1EeF3ariJN83+nXfe3mrpJt4
         a989FDICMNILxfZkrSW31vIoF2KNHxqFMS7ftdeb15fbcyb4UlRD73LTGWWPAUW0Nxm6
         mFgPkbQ8dKM+Q0snVUhvrwFfMXY1kEsJV26TALuNL7XOgfVA8KprOyzNnANioElZanuV
         WyAw==
X-Gm-Message-State: AOJu0YwEDk2jrztNZ7wpUfUBuzWc2uprdLB/1CntmZCaS3ywcDHTUPuJ
	rOSBQMUsriJt2rh9JWHbJm7LxDs2GpTjkPftj2EZf4dOcjivpnaXf9mcJA5jNVcRA4kwwSmA124
	B7RUYfetKIYjZ4zfZnYAQtl3Hs6k5QAFRbJXWScbeB7k3abaZ3i3ufH0+qg==
X-Google-Smtp-Source: AGHT+IH8IYfvHq55X2aGyVifo880D+KGHofqdPqMjSFqyKsB7UIngDFaXJTF08m6Nm4vB9TvuPzPkgX3rDqukV4svoC6G3JCEw9D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4f:b0:365:2f9d:5efc with SMTP id
 u15-20020a056e021a4f00b003652f9d5efcmr335316ilv.6.1708431905506; Tue, 20 Feb
 2024 04:25:05 -0800 (PST)
Date: Tue, 20 Feb 2024 04:25:05 -0800
In-Reply-To: <ZdSUXJYRA8jatpIP@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9cf280611cf4c72@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com

Tested on:

commit:         5bd7ef53 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=127a98b4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3f069371247b697
dashboard link: https://syzkaller.appspot.com/bug?extid=34ad5fab48f7bf510349
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127ab3f0180000

Note: testing is done by a robot and is best-effort only.

