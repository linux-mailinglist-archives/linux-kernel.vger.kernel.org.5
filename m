Return-Path: <linux-kernel+bounces-132102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C27898FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D511C22AC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612E213792B;
	Thu,  4 Apr 2024 20:35:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878066FE26
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262907; cv=none; b=UhPcquQwzXH0UNSgnr1cTxHPgJhtb/3J5qzSy7DQbgHDWm5jsA4UuJXagtJa/2HL9A2v5aHTZvqp28jBKidLbO5dbxALfNBa09qyb9AcPcbad/wIbM1S17YvV49+DuhOoAQ8WUW3X/ozPP4ORjh0KmY0UtK+bMls6Wf6upEu/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262907; c=relaxed/simple;
	bh=xyNQ9LII689lLqTXyfi5pCT+jOJLL653v3tL07feIGw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CuZPdQn6GJSaATbmLVF6cbLnHVCGGa5Zh+JJpXc1aBa1quwxRx44zRiZEgT3mAj4S4BU6vvH0c5f4JKb8dN6dgcmvmyY2iEN5z+Bz03dXKo7SkfsWNhOXpUX9e1uD6kG51ydZjS6auLlpgWtH05/9AQpC97pAcLHjm0kficGp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso128073939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712262904; x=1712867704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smw4QHbDQqqRXF3MpcRJToT/tkL7bhSfX/z4T0s3H14=;
        b=iQLdLuyHA7ygkMBOb+I+KKKHebWGIHX9np7qvx97qcYjFFydpPgD8OyjN1pcVnJIjb
         0OtxzhkX6hGE02ARkigwVbtHU77dUGTn5EvvVCLjv+Yu4Lnw3sbRyF1C7dI3eQXKTcjw
         7paNyyELqCCK9YORPmv6EFa4XNRXtvecbKXf8+pC4oOVM2fN5X0Ih2wv1h/d5m4Wsd2y
         lKOiHOAB7PckCbuhpcBWD2/yJ+f8A2fJ8gky84QBDCUFH+MEghj7U7CvR/LTZ2xN7Ryv
         fAIntbyE2BjnXVsAcGMmVPzYPU2MvS/tJBWlNQCn4z6t288dKKO5kqFX7Y5ZR9epAyJb
         kmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMR2dCZkaVbKN01hHr6Bh69hTq+kMD3ej4FJVOCbLmD5bONhbOMQMNmKMI/Cabrv6+cbZGnzKehKWyup0OnMTAdxdkIEuA9e30/5Jh
X-Gm-Message-State: AOJu0YyLOw+BBVbQA1yewIZ1KiqKMtQs1A1rSqwW5dPTBA1YkPnM5Sbo
	GTnh61UqRyvjwJUNw2zb5bcM1JuqXW1WbxPdRM+QVHovZ9OAsZ9OTGLYXvjlLPxG5WghwLm9Ky8
	OFWZ6UL3rebEJe5IPT+4/USYJnGHZd9OeX14ChMvoOnHPVJ9OaN4KcnM=
X-Google-Smtp-Source: AGHT+IENKpnCelPUDZ/aOzBoGOZh0MLRL36FGVQ7mpcx76xmrOFFKPhC2uz6Yv9HxAP+r8R4Z1nrqeIDn5PfI2SDmZDBLdquNh1T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc6:b0:7cf:15d7:c2c with SMTP id
 l6-20020a0566022dc600b007cf15d70c2cmr21381iow.0.1712262904713; Thu, 04 Apr
 2024 13:35:04 -0700 (PDT)
Date: Thu, 04 Apr 2024 13:35:04 -0700
In-Reply-To: <476ef488-5f3c-420d-97ea-bb281f2891f2@arm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032a29506154b4614@google.com>
Subject: Re: [syzbot] [mm?] WARNING: bad unlock balance in madvise_cold_or_pageout_pte_range
From: syzbot <syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com

Tested on:

commit:         e04f7296 __mod_memcg_lruvec_state(): enhance diagnostics
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=10888115180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ba2443e2eb20292
dashboard link: https://syzkaller.appspot.com/bug?extid=c641706ad4e9688cccdf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

