Return-Path: <linux-kernel+bounces-29967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733038315F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0CC1B247F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6201F61A;
	Thu, 18 Jan 2024 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xc5L8g19"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91221F60B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570628; cv=none; b=JVxt3UISkSNtPXqlpN231F+JtqI+aNQmHkV/Sv1aZmthnl9gNKw+AQk5R/hJiVD8DV7tkCDPLnyjq4Mdm3By7sm/5JpraCqjMvijJOXt6N2DubLlvR4KuTkykRbMK3A0s0H/0IIhQtN3vQ7hHc9QAiBFMcFoks7t8lOYZRRMviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570628; c=relaxed/simple;
	bh=ny05BSmMYc0OdKStL6FH+w7BJCfRWjhsHadAWQ3d5w8=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding; b=fbmBn3zcnhnVVFPzHJqIkrtdR10irFBw7B5c88uLavJzItflKSGW4ctVEDnPNFORpY1mFY9IrsIRKERNsPdQOT/tHRKKQhWNDUzY0STPSOn+4GKB6JdK3vbG+noI19BxtKItX47SGG0Gd657YXatZ+SAl1Z4Yy+b/L6zrxCO56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xc5L8g19; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705570625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFffKgzvP2tJPBxLDLt8qsSP+5mGq9mLel2t1EfYf/c=;
	b=Xc5L8g197fkPYnC+WJ5svM08vteFdqzC9dWLYZrga17mhP8EcfHYKcVIM02YvWEKd/FK54
	SPMsp5uVm7nBzfP74Qii3ZHrHs63ODXHCyNNYujtO9ZJqcSsvbLeF4pljogrt5KCFwnrzg
	8YU9nEsCzzp/PyudrJuu34zn0bzrH5Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-Pyg2Tpn7MoutZpKbJotPBQ-1; Thu, 18 Jan 2024 04:37:04 -0500
X-MC-Unique: Pyg2Tpn7MoutZpKbJotPBQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6805f615543so253531736d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705570623; x=1706175423;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFffKgzvP2tJPBxLDLt8qsSP+5mGq9mLel2t1EfYf/c=;
        b=JGhJhFEugGYooUjrgg9ifWV09OsOUAzeGYPOftScUrUt+hRs8q+DkO902JJ+yE0AZi
         daOH3Yt17QqJJGo01llmBDUhEWYV+PPU1/PRq05EFABnQafoLJ6BHTnjGcyhqm/yOkeS
         bHb6uZxZLPZnqqj5zr2LnAMLajK6ppDrwNLD1JUWUzz92WDyzHUdV7ElcVb+iaQV9FBL
         C0RsNQ1o/GKg29IgV3bT+r++zbYbK6HNU/Pp4zDTbw29bJE1HUpP3PVgYzxfZ76kTr48
         VLK2Ij6O/UqNA+3MPavj/9iZfsWHSeN2z4L6muK4XL0IEMSu5t3VQsLG9z6jdFFy00CF
         0TYw==
X-Gm-Message-State: AOJu0YwmJLcQHXpqZGeB4DQAK9iGKusaKgl1lKQJ/8GJ6Ah1DzwNi+pN
	XN+TenLIDOSH3wN/Gw27KK1aPXpDZBvIUtHRz2LJ3mXai4OPhJZTER6bw1Y6nAQdz/DGapj+dk8
	CUfgluBCkbn/sbbN3SThJbT9cQJ98g0+XUeLItdhIPufl/Mh049J7+3CxXbc7GA==
X-Received: by 2002:a05:6214:62d:b0:681:8aa2:d673 with SMTP id a13-20020a056214062d00b006818aa2d673mr389813qvx.21.1705570623636;
        Thu, 18 Jan 2024 01:37:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgiXjzN4wjLy3FD3tSLUCJyIaYCZdTUeu3sMmzuAhq0WOGFlh006KIdOM1ts6Byz7uluKtsA==
X-Received: by 2002:a05:6214:62d:b0:681:8aa2:d673 with SMTP id a13-20020a056214062d00b006818aa2d673mr389802qvx.21.1705570623397;
        Thu, 18 Jan 2024 01:37:03 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:6ad1:9baf:f024:858c:2fee])
        by smtp.gmail.com with ESMTPSA id l14-20020a0ce84e000000b0068181b61183sm1000936qvo.31.2024.01.18.01.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 01:37:03 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT atomic context
Date: Thu, 18 Jan 2024 06:36:49 -0300
Message-ID: <ZajxMc05uVmK7e60@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87o7djaubq.fsf@jogness.linutronix.de>
References: <20240116073701.2356171-1-leobras@redhat.com> <20240116073701.2356171-3-leobras@redhat.com> <75a39f0a-8f79-eacf-4a35-5de512a3cbed@linux.intel.com> <ZabJGefGkrs0SNzW@LeoBras> <87o7djaubq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 18, 2024 at 10:07:45AM +0106, John Ogness wrote:
> On 2024-01-16, Leonardo Bras <leobras@redhat.com> wrote:
> > Well, at least in an PREEMPT_RT=y kernel I have found this same bug 
> > reproducing several times, and through the debugging that I went through I 
> > saw no mechanism for preventing it.
> >
> > This is one example of the bug:
> > While writing to serial with serial8250_tx_chars in a irq_thread handler
> > there is an interruption, and __report_bad_irq() tries to printk 
> > stuff to the console, and when printk goes down to 
> > serial8250_console_write() and tried to get the port->lock, which causes 
> > the "BUG: scheduling while atomic":
> >
> > [   42.485878] irq 4: nobody cared (try booting with the "irqpoll" option)
> > [   42.485886] BUG: scheduling while atomic: irq/4-ttyS0/751/0x00010002
> > [   42.485890] Modules linked in:
> > [   42.485892] Preemption disabled at:
> > [   42.485893] [<ffffffff8118ac80>] irq_enter_rcu+0x10/0x80
> > [   42.485919] CPU: 0 PID: 751 Comm: irq/4-ttyS0 Not tainted 6.7.0-rc6+ #6
> 
> This is 6.7.0-rc6+. How are you setting PREEMPT_RT?

By setting ARCH_SUPPORTS_RT=y

> 
> > [   42.485927] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-1.el9 04/01/2014
> > [   42.485929] Call Trace:
> > [   42.485940]  <IRQ>
> > [   42.485944]  dump_stack_lvl+0x33/0x50
> > [   42.485976]  __schedule_bug+0x89/0xa0
> > [   42.485991]  schedule_debug.constprop.0+0xd1/0x120
> > [   42.485996]  __schedule+0x50/0x690
> > [   42.486026]  schedule_rtlock+0x1e/0x40
> > [   42.486029]  rtlock_slowlock_locked+0xe7/0x2b0
> > [   42.486047]  rt_spin_lock+0x41/0x60
> > [   42.486051]  serial8250_console_write+0x1be/0x460
> 
> On PREEMPT_RT-patched kernel, serial8250_console_write() is not
> compiled. So obviously you are not running a PREEMPT_RT-patched kernel.

Yes, as mentioned to Thomas before, I am on Vanilla torvalds/linux.
I was not aware of any extra patches for PREEMPT_RT, could you please point 
the repo, or the patchset for that PREEMPT_RT-patched version?

> 
> > [   42.486094]  console_flush_all+0x18d/0x3c0
> > [   42.486111]  console_unlock+0x6c/0xd0
> 
> Flushing on console_unlock() is the legacy method.

Great! so this part is solved :)

> 
> I assume you are using a mainline kernel with forced threading of
> irqs. Mainline has many known problems with console printing, including
> calling printk when the port->lock is held.

I am using mainline (torvalds/linux) kernel, forcing ARCH_SUPPORTS_RT:

diff --git a/arch/Kconfig b/arch/Kconfig
index 5ca66aad0d08..879c34398cb7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1195,7 +1195,7 @@ config ARCH_NO_PREEMPT
        bool
 
 config ARCH_SUPPORTS_RT
-       bool
+       def_bool y

Since I was not aware of a PREEMPT_RT-patched tree, I did this so I could 
compile a PREEMPT_RT kernel.


> 
> This has been discussed before [0].
> 
> > [   42.486117]  vprintk_emit+0x1d6/0x290
> > [   42.486122]  _printk+0x58/0x80
> > [   42.486139]  __report_bad_irq+0x26/0xc0
> > [   42.486147]  note_interrupt+0x2a1/0x2f0
> > [   42.486155]  handle_irq_event+0x84/0x90
> > [   42.486161]  handle_edge_irq+0x9f/0x260
> > [   42.486168]  __common_interrupt+0x68/0x100
> > [   42.486178]  common_interrupt+0x9f/0xc0
> > [   42.486184]  </IRQ>
> 
> If you want to fix any threaded irq problems relating to printk and
> console drivers, please use the latest PREEMPT_RT patch series with
> CONFIG_PREEMPT_RT enabled. This is the current work that is being
> reviewed on LKML for mainline inclusion. Thanks!
> 

Sure, please let me know of where can I find the latest PREEMPT_RT patch 
series so I can re-test my bug. By what you comment, it's higly probable 
that patch 2/2 will not be necessary.

On the other hand, unless some extra work was done in preventing the 
scenario in patch 1/2, I think that can still be discussed. 

> John Ogness
> 
> [0] https://lore.kernel.org/lkml/87il5o32w9.fsf@jogness.linutronix.de
> 

Thanks!
Leo


