Return-Path: <linux-kernel+bounces-159955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2D8B36BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8AD1F22C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE78514533F;
	Fri, 26 Apr 2024 11:52:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043491422C6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132326; cv=none; b=HEtr1TItt4mo+6UdwIQQSORopw9oyw155o+5HHxf2Lw/Xk/lrTRbxSRxnACdY/9JtPoHHbBK3U3bSv+nJfCSpoo8Qh8BLY9YuElogSMmNKUCCUxXeq9vn7GEJHRRBYfQ/+tDpolWswqtj5eaYFt9lDOZ8jj8ZtzxO+QCLhizQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132326; c=relaxed/simple;
	bh=jIOR+vzhPlHA3YgmQjcxZ2mhImEnME5KI77ES+ODJAs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=roWiaXCQopY3f42Z3+4ZNViVzxix74+A2rn0AQtK77UchKJr/hA6NMl5+X66TvzWtINyFR0SEDNzD2U1HZ36eMhd2b6wrJR6z1P6jvRybXxo4UCz7g3R6ocisgwqkoVqTJXhdQ1x+rG5J+nFHL+G0u9E03WgQbX6zxKRliphqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7de9c6b7a36so192165239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714132324; x=1714737124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVc6/BDH6Sy9YrefDPdxSrXQevFVNRqAFB6pcl+xTic=;
        b=DvIe5kEgBmXKjtznCxcmpg4pvVxrjaYycSgSZrlWP41hHFPD2PzS/MMoQ/51gnWrHY
         D11UHtKcdSUlQJiZHDRY0D3pDNmp7iLAREfAm6js7i12NcGCP9RyzrHER8u8/KbflN9E
         5plQNvQP9TCEobS+5ucd41kQ1sGQE/Kwz6ddJXeIlhft3+oE9heepfdK73+rMuKrPmhS
         4x9R/fOejrSZJbgC8KU9oWqiGt4QjAXh2ryb0HSnphoGQ3/p1gaXd1uGybJypeNnEmnU
         yi9xn9YzEO4x/NxrCF1eIJxVZbxLCkIakLV1ct8mfEn3mw6MxyLih7Jaeo5DfdHoMxgA
         wZzg==
X-Forwarded-Encrypted: i=1; AJvYcCVXNb2qM5Ym6jpZb2iTKvvoqr5qScFXpEBreY4PeEDVgII3VyTmTAvx2Z0Yj4oSvbN7CBbnJ80U0YgYwUeo5bSVb0KNxfjqM+DY7I6W
X-Gm-Message-State: AOJu0YxIZcMFI57e2KjGUSPHwuiGmYFdPUoKwm2UvlazhgJskUyGHCIf
	AJwWXbEdA0agkdmCZ3NTLRSgao85tzSQoFwA5m6v0yNjJ25dbDfvCmx1fl2MciuYwG0T94r71ik
	BcBkLkMqZI9HA1ID7mm3FnD67t+QlZJploNMUiKGv18lPf9U+z8ssDkA=
X-Google-Smtp-Source: AGHT+IEdzIQiQITYJUeOKWKbIBkyvRpuhxPgBg2W6l+emkSMCdptnDV8VRSYA4SnR4HDZ0IlA2zdhjQM2geznhblgUnwg/CkNv92
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16c2:b0:485:65de:892 with SMTP id
 g2-20020a05663816c200b0048565de0892mr128439jat.5.1714132323704; Fri, 26 Apr
 2024 04:52:03 -0700 (PDT)
Date: Fri, 26 Apr 2024 04:52:03 -0700
In-Reply-To: <20240426102644.3298-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040adeb0616fe88df@google.com>
Subject: Re: [syzbot] [usb?] WARNING in wdm_rxwork/usb_submit_urb (2)
From: syzbot <syzbot+c6a1953c27ace6cc34e5@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c6a1953c27ace6cc34e5@syzkaller.appspotmail.com

Tested on:

commit:         a160e120 usb: dwc3: qcom: Add multiport suspend/resume..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1215128b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe204286ac73e15
dashboard link: https://syzkaller.appspot.com/bug?extid=c6a1953c27ace6cc34e5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1026cd6b180000

Note: testing is done by a robot and is best-effort only.

