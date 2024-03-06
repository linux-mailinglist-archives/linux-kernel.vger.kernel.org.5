Return-Path: <linux-kernel+bounces-93181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D105D872BED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFB7280E37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225F6ABF;
	Wed,  6 Mar 2024 01:01:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52062CA7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686889; cv=none; b=TtOYqEPHWuq30ZNZU4TyqNz3vq4X8iRFHUONX1TOaSWWT87bTU2uBGXGQ72u6cu6bIfkZF1CEsr7g3sgmbBRAWx82Q2k7w8tPO4FjsaTJQjjoFZHLbP2EWlrys6xo7jDdgUtuJU5tp6OwM4ipmCnxCBW+v/e9IlS+D0QgwYkETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686889; c=relaxed/simple;
	bh=ojD+ab13fVQy8MH928yiWdsmfg857WbgmGYeDMf5Dvo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RPIAY0wOAdzlq3Mr0BqvhrJGRxtKjJuVedKn/MWyuJMeG3Y7jEG2yPnBxm7EV+N6NLPHm7u+oO5CQ/W6VKZ13g8jEgGOlNERZHtHNm4CTtyux+h6FQnHTjMess9Ixs0UquRn0XzrjO4tQejH8hB3ODPge0zzn34lxbSxnZ/6BDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3657cf730a0so76001135ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 17:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709686887; x=1710291687;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULCYzjMNPo8yxvmkaklI4cEsguCDLV7LCUBvtyd40pg=;
        b=CSM1Dy4/moA4UC5FwBGa0Vh2/4R38RzEDq9NmshPZ2yhzKYbd5FDK0JOebkDVuvdp3
         8P2+hTEmpRlzCxTmqHqH7WuebkkbqMELUyxtX19yN0PEMTBBuSTQbzZMVbWMQ8F8A2VU
         EpS3EIYLhbrhX0G62py64kPXVHSzFZPjdslQAADBZiOPC3pb5PJYtFB8x/lQt5anPF76
         bTHzaIQ/JCEKYs3YLLvE8DD4yPZ3/jOIGfUlP4rhktJUsDqCWFEQULijKrs5hQkmhhNn
         ykmlNahsdOTCa3HIalh9mK6ynqz1OHrZTk6NL2du7hn4v2Ts8+7C5dcuc8AZZM34U+Jz
         pZHw==
X-Gm-Message-State: AOJu0YyO6LKK+chEnbSELSWyfvBijJPmvAhMTowcIz+qzB4RLx4eCYJO
	nTmsf36EFyfYHaCnTSk1YTbmu9zY2Ho84LSK2BmLZ7havNvs2DCMsOvyCJxzKi1/tTl1Psgceej
	7M4RDAL1qWFHPiPPD3LzIR5k6zu3A5bFli56u7ZfveSIm3Lx57hL1x1yx5w==
X-Google-Smtp-Source: AGHT+IFeph3Wdz0Qb2ewdoJf81VEg0LaHvCVVK0sy8dkJvPVorfGFqXZL7TYfstX/KZoLxtjFF+zY2mWzGiKmG1vHl+2My8x1GNR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa3:b0:365:c659:5922 with SMTP id
 l3-20020a056e021aa300b00365c6595922mr540708ilv.4.1709686886926; Tue, 05 Mar
 2024 17:01:26 -0800 (PST)
Date: Tue, 05 Mar 2024 17:01:26 -0800
In-Reply-To: <00000000000069e12f05d0b78c2d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092a1f90612f37f35@google.com>
Subject: Re: [syzbot] Re: BUG: MAX_LOCKDEP_CHAINS too low! (3)
From: syzbot <syzbot+8a249628ae32ea7de3a2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low! (3)
Author: david@fromorbit.com

On Wed, Mar 06, 2024 at 11:58:18AM +1100, Dave Chinner wrote:
> 
> Lockdep is hitting the maximum dependency chain tracker size:
> 
> VM DIAGNOSIS:
>  lock-classes:                         4657 [max: 8192]
>  direct dependencies:                 23720 [max: 131072]
>  indirect dependencies:              274342
>  all direct dependencies:           1053416
>  dependency chains:                   65377 [max: 65536]
> 
> Some of the reproducers don't involve XFS at all, but all seem to
> show something like:
> 
>  dependency chains:                  131072 [max: 131072]
> 
> So this is a core kernel or syzkaller kernel config issue and not
> an XFS issue.
> 
> # syz subsystems: kernel

Ugh. try this again:

#syz set subsystems: kernel


-- 
Dave Chinner
david@fromorbit.com

