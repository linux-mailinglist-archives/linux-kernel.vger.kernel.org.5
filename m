Return-Path: <linux-kernel+bounces-68204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF69857736
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B3028157B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5130B1B81B;
	Fri, 16 Feb 2024 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdYFvl/g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19621B810
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070423; cv=none; b=qGwnpUbIxhC/bmFlL0W7y5VlEkVIPGdcyD1DLe0DXBDX0HmL5IIZyb3cJtHq7IAuCst5ojdPX3TFs1PG7Jg+K/aMI8qSe15G+QKvfRqClFzW1uozv/8yt+rQgJA7u5hcQT/ez3Rk+cUuLH0oXFu/K9VPt40XIaTFGTpGVRQknKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070423; c=relaxed/simple;
	bh=Cqm/EG5qUaoDNuzdzJISKoEg77NshXhbERW32TZKJ+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezotBHH+t4FVLPElLQlTckLf/ZQaTBgrYG7DMqjzuEroYHF7UKa/2ctGAimuObKlh7LLFlU454nm05PoD1f2MLt+OxXChXwgKBFgVahhpKHxQXCp52yMM2USLTqu/HPbrPkmMHJ7cgrmZJpE0ayBN7S62W2jtlE0vG2BnkC7NlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdYFvl/g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708070420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fl5VQYwK1CPmD5XbTx/mJNWpRykw1CcLoDo4tp9HhvY=;
	b=SdYFvl/gFe1by3wDlxbCZbykwODAUsQZWYXdBZlfReH6qp0Kez2DxZT20bnzRIraU/XpC3
	/VEboU0SH6a6c9zF8KxetJ3Bjivy6SZQWpiF+Yz0hzRWZzyUiJGU4ixFzoYnoqo+a/D0tU
	EDqpJDnYFtRGfQdhAe+TDs4eOGmoQxc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-VGzwDg1yP62-BEjplEhMBg-1; Fri, 16 Feb 2024 03:00:18 -0500
X-MC-Unique: VGzwDg1yP62-BEjplEhMBg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-785d863287cso154064485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708070418; x=1708675218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fl5VQYwK1CPmD5XbTx/mJNWpRykw1CcLoDo4tp9HhvY=;
        b=T8LhQkskxT4eS++Eg0B3ONIrz1D9oT+SRJLFyWrLwfg2tPpDpDAkhNI6EKTzsHR837
         N9+E7JpIcNZpJTkcm3HmFjJmRXmroV98w0OMAMeMIJXeSo7zADutgDM+A46Y3yPoyelg
         9h4W+I0z8WbEJQB+d5Ls4v2iFAb0Ne2CEpo+0ch7POoUs8fqxujpsDl7vLk4ptkR/9GC
         xb1oITQgKFcQfpKlNnnDsXtFCLr8ImiYppRGjjKAl3P3kXmImKd8JJGBWvUACTPSSu0z
         ni97tg8NX47PWwlua1OY6r6Rawo3MC1fkpoF2+fQGN6rGhBlUblX2EScu0V8lpQfLv9o
         8QXw==
X-Gm-Message-State: AOJu0Yytm2mdGyBX67Fp06aJZSIpQSR2KBy90kaMZ1P5u4jmQc61yDrJ
	QkiYMs03R/QbIF4/bDdQKJ4Y/P6vhX7GgJFg1g/9tl2oHqo/VeaiXCiZABWzDuw+DfjIoRNhES2
	ppLj2qAvfwNbRM/39oD7IEGjz4IHtWZcvZrztOHjNLY1hOnA1w72SRdC/3sQLbg==
X-Received: by 2002:a05:620a:1a95:b0:787:27f1:b8b7 with SMTP id bl21-20020a05620a1a9500b0078727f1b8b7mr5106185qkb.60.1708070417897;
        Fri, 16 Feb 2024 00:00:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoFFLTl1vSEz2qmS9/UufhOWkiwxQFz5Zp8e7I64XzmrAOC80+oyQmmO0O2zGb46017TZ2Ow==
X-Received: by 2002:a05:620a:1a95:b0:787:27f1:b8b7 with SMTP id bl21-20020a05620a1a9500b0078727f1b8b7mr5106134qkb.60.1708070417447;
        Fri, 16 Feb 2024 00:00:17 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id br37-20020a05620a462500b00787346f1edasm1300756qkb.54.2024.02.16.00.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:00:16 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Leonardo Bras <leobras@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH v2 0/4] Fix force_irqthread + fast triggered edge-type IRQs
Date: Fri, 16 Feb 2024 04:59:42 -0300
Message-ID: <20240216075948.131372-2-leobras@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 patchset subject was "Fix serial console for PREEMPT_RT".

While dealing with a bug that breaks the serial console from qemu (8250)
after printing a lot of data, I found some issues on this driver on 
PREEMPT_RT kernel due to it enabling force_irqthreads, ending up causing 
the IRQ to be disabled and the serial console to go down.

I found out 8250 driver get an IRQ request for every tx byte, but the
handler is able to deal with sending multiple bytes per "thread wake up".

If the thread don't get to run that often, and end up handling many irqs at
once, it will cause few changes in threads_handled to be noticed, meaning 
only a few runs of note_interrupt will not increment irqs_unhandled, which 
leads to disabling the IRQ. 

For serial8250, to trigger IRQ disabling it's only needed a fast printing 
of ~300kBytes.

In order to fix this, I propose that we subtract the number of threads 
handled since the last note_interrupt from irqs_unhandled:
(irqs_unhandled -= threads_handled - threads_handled_last)

So this way irqs_unhandled actually reflects how many of those irqs 
actually haven't been handled.

This work is divided in:
Patch #1: Simple change in SPURIOUS_DEFERRED bit (31 -> 0), so we can 
acuratelly measure how many IRQs have been handled even when the 
threads_handled & threads_handled_last are close to overflow.

Patch #2: Subtract the diff from irqs_unhandled on note_interrupt.

Patch #3: Implement IRQ_HANDLED_MANY in order to let the handler return how 
many interruptions have been handled in a single run, and increment 
threads_handled accordingly.

Patch #4: Change serial8250 driver to use IRQ_HANDLED_MANY interface, 
so it can inform how many IRQs have been handled, and help set the correct 
number of irqs_unhandled, thus avoiding IRQ disabled for normal usage.

Changes since RFCv1:
- Implemented a way of better counting threaded_irqs handled, instead of 
  only zeroing irqs_unhandled.
- Rebased on top of linux-rt/v6.8-rc4-rt4-rebase, so I don't need to fix 
  the sleep while atomic issue in serial8250 mainline.
- Better description of what we are actually fixing
- Changed patchset title from "Fix serial console for PREEMPT_RT"
- Link: https://lore.kernel.org/all/20240116073701.2356171-1-leobras@redhat.com/

Leonardo Bras (4):
  irq: Move spurious_deferred bit from BIT(31) to BIT(0)
  irq/spurious: Account for multiple handles in note_interrupt
  irq: Introduce IRQ_HANDLED_MANY
  tty/serial8250: Make use of IRQ_HANDLED_MANY interface

 include/linux/irqdesc.h             | 11 +++++-
 include/linux/irqreturn.h           | 23 +++++++++++-
 include/linux/serial_8250.h         |  2 +-
 drivers/tty/serial/8250/8250_core.c | 13 ++++---
 drivers/tty/serial/8250/8250_port.c | 16 +++++----
 kernel/irq/chip.c                   | 10 ++++--
 kernel/irq/handle.c                 |  3 ++
 kernel/irq/manage.c                 |  8 +++--
 kernel/irq/spurious.c               | 55 ++++++++++++++++++-----------
 9 files changed, 102 insertions(+), 39 deletions(-)


base-commit: 63d966ad6fecb66769e56fe2285de1e3b448f2ff
-- 
2.43.2


