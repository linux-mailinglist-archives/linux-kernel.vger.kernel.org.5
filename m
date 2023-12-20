Return-Path: <linux-kernel+bounces-7487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBAE81A8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918111F2360A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6969A49F66;
	Wed, 20 Dec 2023 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="z06PS5AE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1124A984;
	Wed, 20 Dec 2023 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=gGhivGWuZJFEJNuLOFHDwrv7/AKHko0IOcoRRvuYkZc=; b=z06PS5AETwf3oQlBySaanxAS9L
	4sr6cQsoOE3JOzjYQtVAv8DATN5g6wM2e3FTP3fYQ2mDi4ak/8FnY6s0JuWp2Mbdf9rCFRf6yzVBi
	pNhh+eTzlTbL61t5oup9L28FFj0/DWM+KQiASXwTfquptBekYOflxCW3GGxcCsB2C8w4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55480 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rG4lD-0002wK-D5; Wed, 20 Dec 2023 17:09:51 -0500
Date: Wed, 20 Dec 2023 17:09:50 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, stable@vger.kernel.org
Message-Id: <20231220170950.88980abb0764442d77398675@hugovil.com>
In-Reply-To: <ZYMLK1yXFCsGlzoP@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-4-hugo@hugovil.com>
	<ZYMLK1yXFCsGlzoP@smile.fi.intel.com>
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
	* -1.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 03/18] serial: sc16is7xx: remove obsolete loop in
 sc16is7xx_port_irq()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 17:41:31 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 19, 2023 at 12:18:47PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Commit 834449872105 ("sc16is7xx: Fix for multi-channel stall") changed
> > sc16is7xx_port_irq() from looping multiple times when there was still
> > interrupts to serve. It simply changed the do {} while(1) loop to a
> > do {} while(0) loop, which makes the loop itself now obsolete.
> > 
> > Clean the code by removing this obsolete do {} while(0) loop.
> 
> I'm just wondering if you used --histogram diff algo when prepared the patches.
> If no, use that by default.

Hi,
I did not, and effectively it makes the patch easier to follow.

I will use it as default from now on.

Hugo Villeneuve

