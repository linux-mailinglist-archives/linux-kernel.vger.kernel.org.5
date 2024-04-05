Return-Path: <linux-kernel+bounces-133238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B089A10B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF791F24967
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA1516F8FF;
	Fri,  5 Apr 2024 15:27:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655D16F284
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330826; cv=none; b=FXfiFl5WqrgZWc5BEzyLjD5U6vB5nzvZ76CNU7vxXkfdyHGtxt6B3AOA/S0+GscMxXfJRhEupUwzggxcOJkOE15zEDnvvAnNd+md5el/TM12WO1t6sCwS06GaJMBeYICId6S+SwqeB7IujzpqRvuGbC8VmK4DZ1sM+DYfvbJzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330826; c=relaxed/simple;
	bh=+MKqULzRhHvGIj5mOz8O+ztQ8/EUDbrXmdnUimxW0B4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uHxMhOhZi9pv9UfgTb4XKEwcpbyEiI56BNYyggFPRZSCA16vR92qA6mBtuM9VAJg+q0a0wKdV7HiQCDq1PNDBdeMoCBCM/hB6j+z2C4fs+Mj/TNGC9f0A4a5/cmV8JZSOWxN6awnz/AKjNVNbFyJK+3css6a6lG8pGXZFdyT6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf0ebfda8so224736439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330824; x=1712935624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqUgd22O73HiWEeGalTYk7fICd88WxtdLl6hhTETrsM=;
        b=WsctrcyFD647j+O60k3gSKzz8J3HUIpWFexPSd3RicpXmBnmd2PujA7iphaB9wXrrY
         uvdn9IHtCW19HQoc1iL688lcZRzHDO0jgu6cqubBUZ6wpBAZsl90mJ7usUxUG+5IuNsB
         3cFlsmv6ghWDJe2yGbTn4BjbBQj7ZT+O4BwvYpNj+cdYdJ2wF+eXxNkg44xHAVSmU+2K
         w3//hs0fkCnc3abTIWXiB98TdsqOtGUmt02/9K7uqlOaPHyONlo7yYSVmVq/aLWVgq0j
         F3/U1SH809Mu6ijBGM3zmMh+rmZJPaJuj+w/XcT7RuRKQxcSA3p3AWV2t225XLcyIpka
         rbbw==
X-Gm-Message-State: AOJu0YybTodLpu5BgT5hRMGthJ4PxPL+JrAvj/7V4RuADaRdJfNSFA9o
	vLH2zeKMgpNKVIsUqeMSpSRe8YI+ElHr0tqXMbiDxQupuLWJEYA790QBJs1e3G6h3G0G82uO75Q
	3gVkqR0ZjayQXjvyz/lSxT7Nsx6f/b2K5KSsua0rlbw3+F+NDJz9F63pMFw==
X-Google-Smtp-Source: AGHT+IFzMKOIQnCl6tr2eMO8tDMNoQSf8AzQKB82dFyzT6sBz88Rv0q2w/nQFp7Yjf09W5bLauvcnfgdfhV3ibF0EU9GdpxE+Owx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1350:b0:7cc:cc9:4332 with SMTP id
 i16-20020a056602135000b007cc0cc94332mr71934iov.4.1712330824643; Fri, 05 Apr
 2024 08:27:04 -0700 (PDT)
Date: Fri, 05 Apr 2024 08:27:04 -0700
In-Reply-To: <Zg-kEEJq2P4ic_LN@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a879506155b1656@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/nfc/nci/core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         58c806d8 Merge tag 'phy-fixes2-6.8' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12448aa9180000


