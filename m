Return-Path: <linux-kernel+bounces-64982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BB585462D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE71C1F2DEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCD01B59B;
	Wed, 14 Feb 2024 09:35:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9081AAB9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903304; cv=none; b=A9ChEfnOhQyIjfkeMryMDIJUGVnZDMQ2wIZT+hY//qT+UzPu0dg0KqVcTD/dCWQXcv6ywPXXqmdKLjLieWmwPhOa5Q2Im/q0X0FVMPQmMGR0nn4rrq/8cpU59F5afGExSSQjL2swYX8YQscsUFjxe2wm5QHNkk/d8O1azqVPLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903304; c=relaxed/simple;
	bh=mCK1Um/BXsaU8pNKjy69g6SVqMEaiG3IrWptrWdgIcg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uoawBmQg2hVVBQB7JtuUI1arc6DfeQ2NPmYPgXz4wIfVbk1QnmrsXfwMrm5HzxIFkj1EG6Rp+GNo3boL9N7XNng3LhsTe4ysdYfnTu96THrJCCshLV+CtUoYIiSQUjlEvEvbW/u9EWP8zr2zvNrIXPCduaYHeFBSjJgM6yKrbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363dab8a83aso44779445ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707903302; x=1708508102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORnUAaewv/RB2Qy7deClC3JARtWN1YpviAOkafVIcmY=;
        b=OFv1BwwQnuPm8xXzSioKRfpf6iN+lpSRL/Hz23ZZ+2z+HsnSsF/ISLNVM5T+RGUhEi
         N0fu1Bw9qok0hBVIJgXOIFp5qXUTGXYFvKNUtHr46vME7vyTSHEBXnJ52mX4eIgfARp8
         /J1kdf2/yz8sHDc3WPn7Yb7FB2jw9sE16vrCDMDWk0Zk8qfBG55Smzb4ybV7kptnhGSV
         SBQ2+JxdoePNBhjiAF8iUx9NApN+rfziseaYbYDqQV68IXoTNeao2mm+tWCprd1sOWXJ
         dlpcJZiJwBI7EnienMoJ/Tkxha4Yfd5WU0xv6DnTSF2CPI9P/Pl2x5zZ205RiiJsrHJU
         nKww==
X-Forwarded-Encrypted: i=1; AJvYcCUSMVVZbyEcGX0oD2X5UaVCRgf8YowsQvFj3HUSsCOEhzQriRhZzyfXQa64K0qNBrVBDrVZHzGAIFjsohu7PhVBSCtlFHOPCK518nmI
X-Gm-Message-State: AOJu0YzAY+LCS6jarhe24iY2PVgyEpDdYhr2Z+NvzwFVWpuhbvVx+nlt
	zuYkJ5Xm8jxC18tJtF99dGJ7q+CmNtZrsbkkSaKbH/G9uxXMKHELcbVIlMBMcduhFNwYKyjGbhM
	TF7xUcdFnS5oRteQfe+D6Wc8w3YlawBluq//pF1MH5VwMrBQF6tQZmDQ=
X-Google-Smtp-Source: AGHT+IGTPrgALnOcbPza/P498AJpJEyxRbba0VvGWrms/leJlROmkz7mhYo156aSOU2ElFeJAZQzPCr8wZyuUtxb2Ywa5mAN6Atf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:363:d88a:4640 with SMTP id
 g15-20020a056e021a2f00b00363d88a4640mr177226ile.5.1707903302303; Wed, 14 Feb
 2024 01:35:02 -0800 (PST)
Date: Wed, 14 Feb 2024 01:35:02 -0800
In-Reply-To: <71fab85e-966d-ba46-faec-a75a283bd325@netfilter.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a508c00611543978@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in ip_set_free
From: syzbot <syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/netfilter/ipset/ip_set_bitmap_gen.h
patch: **** unexpected end of file in patch



Tested on:

commit:         f735966e Merge branches 'for-next/reorg-va-space' and ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=d47605a39da2cf06
dashboard link: https://syzkaller.appspot.com/bug?extid=ebbab3e04c88fa141e6b
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173bec1c180000


