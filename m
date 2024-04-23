Return-Path: <linux-kernel+bounces-155945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F78AFB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33C31C235FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C298143891;
	Tue, 23 Apr 2024 22:06:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867C26288
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713909966; cv=none; b=NYcfIIk3fTokv4yEq2F8K/8Li15NA3Vo+L1/9hSnRhn819H6/l0f+ljlQhR4uLLhagmIbd/rRBRLtQuJH5l4tQ1YdTOsW+ZkesQ/G1YafPzIdRWt2tKvpAIqlccWcHPwRQVDz4x3XEh+Ua8JbeJBK+ixWamrGWr26apJ0lMUXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713909966; c=relaxed/simple;
	bh=xA1mMwfiHvixCqrHHvX1+dXJDAfO/B9GTLSr/XRnM+0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DeboIhnoj5XXJbSWd3ghyqY1GOQfW9tXMiL2BixUzdS/P+kKXc9rBFz/gcvrPt4qACr+w79UPtgO24XlLhr+2UFNEhngheIVVsc8qnieC0PDhUvmmz1Dk+xGx+TfjLo/7K1sH4zLKx4DBa20387x7u3sWL3Ka5q3zy0uG18+oYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da4360bbacso717258839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713909964; x=1714514764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dS7fIo/BHGESKaBtu+09R6BtulUfX9z9VDFR4tVQRVs=;
        b=jIb1x7vSwbTZ/7CxBxcp8etca94Ep5a/WFLdhckWgz1bEUy3zmQWg5WOaNG1xQ1bld
         sRd0JT8Dshkr0JnlMZEdMpa3/0x4y0YeYoXBLTxqDFql8P3pS3SzODLyIWkz7s91dn1k
         ImgcHenZuGjipcqDX7g5P+LrUDwlyaAmuCrZIpK7DXv9svcKmCGEZ9CLqmy65wBD/Pc7
         4VMw1Cl73P4cfAUj0t8rejAWW+38R8iaJJowPS9chj95dZtLw5/xOubTKf/xZ0wsPhZP
         +3xLE0Idr9nEfLcezsHV199q/UvrF8tA/H9Bqj2AKikGXSrrIgqVgr59Qvmnv0sWtvIq
         /diQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX+pWbpsLo6ZT95ZRw8aqcvIN2Ng645LMJ9TeQf4kG5RMgQ0ySmgQ9gjWLaNxC8WSs2BAITRgiB5JwqNLYG8X1bR5DYH1GDHFCvj8X
X-Gm-Message-State: AOJu0YxC2AhEqz8VCz9frt93FM2AdtgrhriZyZ3L7OEmMBILZqABAWgk
	mKO5uYnMk2Ft5NstNCTp/l1AixUKqpsZ5IpvDTz9BDuFF3Sd15Ug9xD/OALYcCNeW1+RungjNIf
	//EWotNO5psY7HjVitzT+J6dC5intmZe/jOicEFQhCC57FZpF+i2WQ2Y=
X-Google-Smtp-Source: AGHT+IGLZN9m5SzP6BQMLUzEAP8LA2gW8ArzrktpNNMRG8W+uQAsPKm4rrAnP9eBQeRn2hFzZ61SKc5GPD0fKm0V5TkCiNKsPl0N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1647:b0:485:4e1f:5a75 with SMTP id
 a7-20020a056638164700b004854e1f5a75mr69130jat.4.1713909964732; Tue, 23 Apr
 2024 15:06:04 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:06:04 -0700
In-Reply-To: <20240423213131.3040-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a008f60616cac2cd@google.com>
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com

Tested on:

commit:         3cdb4559 Merge tag 's390-6.9-4' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=119e4230980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d239903bd07761e5
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e9a8d3180000

Note: testing is done by a robot and is best-effort only.

