Return-Path: <linux-kernel+bounces-8746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E6181BBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7621F25DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2BE55E74;
	Thu, 21 Dec 2023 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="k26iM+Dx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E350627FB;
	Thu, 21 Dec 2023 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=w58q1EZLNvdrYMtYLHciABWJyucaztQhQ1k0qWMzqJc=; b=k26iM+DxO+STVASN/voeZEecT/
	oic5XSBzoiCRdjBIu2fQ09ZZGfOCRFIsxJLCQ8qTkhj3AwnD95SwCzfhT0rluAjDDZxXg7/WVM3s1
	WqeUYruGFdANef/q6GM8kMtYGXmTRXdEdiqHQqQGFAb4QWBqP+8punhkVxom/UAqN5pI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56104 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGLg2-0006VT-3M; Thu, 21 Dec 2023 11:13:38 -0500
Date: Thu, 21 Dec 2023 11:13:37 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, Yury Norov
 <yury.norov@gmail.com>
Message-Id: <20231221111337.2c1af5bbe4920268dac25e8f@hugovil.com>
In-Reply-To: <20231221105639.17910de5e7d7a486834bd856@hugovil.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-3-hugo@hugovil.com>
	<ZYMK-l03S86Nw19I@smile.fi.intel.com>
	<20231221105639.17910de5e7d7a486834bd856@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -3.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 02/18] serial: sc16is7xx: fix invalid sc16is7xx_lines
 bitfield in case of probe error
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 21 Dec 2023 10:56:39 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> On Wed, 20 Dec 2023 17:40:42 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Tue, Dec 19, 2023 at 12:18:46PM -0500, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > If an error occurs during probing, the sc16is7xx_lines bitfield may be left
> > > in a state that doesn't represent the correct state of lines allocation.
> > > 
> > > For example, in a system with two SC16 devices, if an error occurs only
> > > during probing of channel (port) B of the second device, sc16is7xx_lines
> > > final state will be 00001011b instead of the expected 00000011b.
> > > 
> > > This is caused in part because of the "i--" in the for/loop located in
> > > the out_ports: error path.
> > > 
> > > Fix this by checking the return value of uart_add_one_port() and set line
> > > allocation bit only if this was successful. This allows the refactor of
> > > the obfuscated for(i--...) loop in the error path, and properly call
> > > uart_remove_one_port() only when needed, and properly unset line allocation
> > > bits.
> > > 
> > > Also use same mechanism in remove() when calling uart_remove_one_port().
> > 
> > Yes, this seems to be the correct one to fix the problem described in
> > the patch 1. I dunno why the patch 1 even exists.
> 
> Hi,
> this will indeed fix the problem described in patch 1.
> 
> However, if I remove patch 1, and I simulate the same probe error as
> described in patch 1, now we get stuck forever when trying to 
> remove the driver. This is something that I observed before and
> that patch 1 also corrected.
> 
> The problem is caused in sc16is7xx_remove() when calling this function
> 
>     kthread_flush_worker(&s->kworker);
> 
> I am not sure how best to handle that without patch 1.

Also, if we manage to get past kthread_flush_worker() and 
kthread_stop() (commented out for testing purposes), we get another bug:

# rmmod sc16is7xx
...
crystal-duart-24m already disabled
WARNING: CPU: 2 PID: 340 at drivers/clk/clk.c:1090
clk_core_disable+0x1b0/0x1e0
...
Call trace:
clk_core_disable+0x1b0/0x1e0
clk_disable+0x38/0x60
sc16is7xx_remove+0x1e4/0x240 [sc16is7xx]

This one is caused by calling clk_disable_unprepare(). But
clk_disable_unprepare() has already been called in probe error handling
code. Patch 1 also fixed this...

Hugo Villeneuve

