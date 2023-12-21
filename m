Return-Path: <linux-kernel+bounces-8822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE181BCBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F912B21F33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28B5991D;
	Thu, 21 Dec 2023 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="HJD9yBYP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B295822F;
	Thu, 21 Dec 2023 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=248JVgGyRvCA5szqZVI4DtrGSxFHLc+06wLR7mZzUgw=; b=HJD9yBYPkAx1lcfslO8XmfanRu
	EUDSmzPVea8xvPCxexKhDR+0nnQWZiERB9AKjbqWVV+Wms4loMDsUORbkhbPHFR61q3UkJvKUxkru
	UYjBYHq1P70oHavw/ld3qm+lSF+RMyQ96wWmdZ01ZkVoZKBx42UvFCQIkuKLT+jjtuNM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:45918 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGMc6-0007Fu-7K; Thu, 21 Dec 2023 12:13:38 -0500
Date: Thu, 21 Dec 2023 12:13:37 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 stable@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
Message-Id: <20231221121337.8d56a89ece7c341f9f36bf6b@hugovil.com>
In-Reply-To: <ZYRk6NpuUJvVEmOZ@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-3-hugo@hugovil.com>
	<ZYMK-l03S86Nw19I@smile.fi.intel.com>
	<20231221105639.17910de5e7d7a486834bd856@hugovil.com>
	<20231221111337.2c1af5bbe4920268dac25e8f@hugovil.com>
	<ZYRk6NpuUJvVEmOZ@smile.fi.intel.com>
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

On Thu, 21 Dec 2023 18:16:40 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Dec 21, 2023 at 11:13:37AM -0500, Hugo Villeneuve wrote:
> > On Thu, 21 Dec 2023 10:56:39 -0500
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > On Wed, 20 Dec 2023 17:40:42 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> ...
> 
> > > this will indeed fix the problem described in patch 1.
> > > 
> > > However, if I remove patch 1, and I simulate the same probe error as
> > > described in patch 1, now we get stuck forever when trying to 
> > > remove the driver. This is something that I observed before and
> > > that patch 1 also corrected.
> > > 
> > > The problem is caused in sc16is7xx_remove() when calling this function
> > > 
> > >     kthread_flush_worker(&s->kworker);
> > > 
> > > I am not sure how best to handle that without patch 1.
> > 
> > Also, if we manage to get past kthread_flush_worker() and 
> > kthread_stop() (commented out for testing purposes), we get another bug:
> > 
> > # rmmod sc16is7xx
> > ...
> > crystal-duart-24m already disabled
> > WARNING: CPU: 2 PID: 340 at drivers/clk/clk.c:1090
> > clk_core_disable+0x1b0/0x1e0
> > ...
> > Call trace:
> > clk_core_disable+0x1b0/0x1e0
> > clk_disable+0x38/0x60
> > sc16is7xx_remove+0x1e4/0x240 [sc16is7xx]
> > 
> > This one is caused by calling clk_disable_unprepare(). But
> > clk_disable_unprepare() has already been called in probe error handling
> > code. Patch 1 also fixed this...
> 
> Word "fixed" is incorrect. "Papered over" is what it did.

Hi,
I just found the problem, and it was in my bug simulation, not the
driver itself. When I simulated the bug, I forgot to set "ret" to an
error code, and thus I returned 0 at the end of sc16is7xx_probe(). This
is why sc16is7xx_remove() was called when unloading driver, but
shouldn't have.

If I simulate my probe error and return "-EINVAL" at the end of
sc16is7xx_probe(), sc16is7xx_remove() is not called when
unloading the driver.

Sorry for the noise, so I will drop patch 1 and leave patch "fix invalid
sc16is7xx_lines bitfield in case of probe error" as it is, and
simply remove comments about Yury's patch.

Hugo.

