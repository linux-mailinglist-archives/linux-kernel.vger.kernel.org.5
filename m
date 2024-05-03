Return-Path: <linux-kernel+bounces-167269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B708BA6BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B326B21474
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C83139CE3;
	Fri,  3 May 2024 05:52:35 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6BA224D0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714715554; cv=none; b=L+ogendFt5tTG4Lp90UO1Fa8wqtt1EIWFkPNjO6cnVygsJix3qi9KToF+WcoKurosbsr5HrDVBfw8JnvMm+KULQ6PhjJe4tSDDTb7dsPQ0O4oXAq+hdNbzLVV74kU2uRAvVx9foyMFczEEsQLAEjW2vb4Lrxbo6td+df7uFR3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714715554; c=relaxed/simple;
	bh=zrImG30dwpuvr77L2j6ZTL7Sp6bFRPvDqsIojnWoiWQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Oa4ogUfByNgZtW3doxIfm6m7xnIWLvjPBsov+w5MI7NQuYD04P6bnAGtIXI8gK/i6n6MPgTzVnM3XmbyFKB1/BOWcs+Ma0dSqxnZArMj4w/sJimhJuPpO/09PnZBsP/DlrhePG6AjytppOQLk/yR6vDbfxAUV0gtZwdRvnhijAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c5d1c48d3so23969645ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 22:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714715552; x=1715320352;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrImG30dwpuvr77L2j6ZTL7Sp6bFRPvDqsIojnWoiWQ=;
        b=uq4LjrUfkmHRtbOF8hOu5L1ZKSuz43gOOjj59UcnwFkahY7zfkGPfv39JXl3FtKHzh
         V4usKfoNyXkXZymEZga2gtPR0+fmJdXOpuZ6cz5G7QixuiR2gUP8jnxv1hJdeiKU8lr8
         7M7OI9ao7ccBpGygvZ9q6aRTFpVv2jxnkPjjniKOLIL4exSMZ/G0nxgJouOrkV+eXd1+
         0S+IuP8+ifujHfXIXGhcrGPWVAoi+eimUlYls+Xreph7GUGLKJIJZBoWX48UNWovQCyP
         IfvoCpvGxcl8DE42Gk2x7aRpgIfJsa+0EV/6GD1mIOJJJNowPDDLe/M8r+HZfhBkmc9L
         /eTA==
X-Gm-Message-State: AOJu0Yz/dBkEbpUBI1q0jLxfYCx64sEJ2+GSR6KQ/bF1MzY9stQYzu4/
	Zmb/UwJ1PYVMYRfWzOn5IpUu0rVJ3jPYsTsDIYE99B6T2Xrgt2WQY1nhZ+OPL4uOAYlSOcTh2m2
	IrilLOmu32suUCeGY4Xs361sZdiPIa+IRD35LvWm8RuXsktBxjeyLtok=
X-Google-Smtp-Source: AGHT+IH4+7Iw/2+J15vaeoNZO0n+3oNqhpmt2BDVUatLJuv8ERaZoEfP8dJocu3TVFxpQ4y6n4F/10ID4nJFZJ6qM/L3euB40pHP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1389:b0:36c:4c3c:e16 with SMTP id
 d9-20020a056e02138900b0036c4c3c0e16mr58675ilo.2.1714715552693; Thu, 02 May
 2024 22:52:32 -0700 (PDT)
Date: Thu, 02 May 2024 22:52:32 -0700
In-Reply-To: <00000000000048aa8506177649b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068d6e306178653f5@google.com>
Subject: Re: [syzbot] Re: [syzbot] [iomap?] WARNING in iomap_iter (2)
From: syzbot <syzbot+0a3683a0a6fecf909244@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (2)
Author: hch@infradead.org

#syz test: git://git.infradead.org/users/hch/block.git blkdev_iomap_begin-fix

