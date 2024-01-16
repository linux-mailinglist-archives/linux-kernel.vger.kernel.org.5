Return-Path: <linux-kernel+bounces-27246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA27C82ECB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6181C2300E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586013AC2;
	Tue, 16 Jan 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SklX3cVU"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D014134C1;
	Tue, 16 Jan 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705400640; x=1736936640;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YniVLZD2s3E4XeUi3U56nsCA0cbZEvcrCwDUGCUg620=;
  b=SklX3cVUqlzCqfl6Rpb+SaaYOZ9te08JZHY3fLYzxK3wohb84042IAmP
   e+Dz3fh/ZTICyxGi9iOjTcKslJEe2Zej9Y6vbg0MO49zloNINv/8YBdhG
   0IOcWhzNNrIeHSfCkaVmRuBpP8nhTPioO4TACOenMB9i45Uxm4Wyxon/y
   C6Y262FlqLSxQD0V/h4qa31Y/f/34bJAH50vPEv8R7ew0CeP+1wWJ5God
   z95z6PtxkrPqPXKz8nZmZVqKzdpk1HSgdCwZdIjFJqbv5zk63C1pfVQyZ
   Jx9YARFfAiNncavNV4ytTpERCTuuvyayJy5Fg0DOVS6JnTnpE0J4UxOcm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="466194397"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="466194397"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:14:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="18417568"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.68])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:14:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Jan 2024 12:14:47 +0200 (EET)
To: Gui-Dong Han <2045gemini@gmail.com>
cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
    baijiaju1990@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH] tty: fix atomicity violation in n_tty_read
In-Reply-To: <20240112125801.2650-1-2045gemini@gmail.com>
Message-ID: <7f51ab12-bbfe-0aae-3755-275ee4762f03@linux.intel.com>
References: <20240112125801.2650-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Jan 2024, Gui-Dong Han wrote:

> In n_tty_read():
>     if (packet && tty->link->ctrl.pktstatus) {
>     ...
>     spin_lock_irq(&tty->link->ctrl.lock);
>     cs = tty->link->ctrl.pktstatus;
>     tty->link->ctrl.pktstatus = 0;
>     spin_unlock_irq(&tty->link->ctrl.lock);
>     *kb++ = cs;
>     ...
> 
> In n_tty_read() function, there is a potential atomicity violation issue.
> The tty->link->ctrl.pktstatus might be set to 0 after being checked, which
> could lead to incorrect values in the kernel space buffer
> pointer (kb/kbuf). The check if (packet && tty->link->ctrl.pktstatus)
> occurs outside the spin_lock_irq(&tty->link->ctrl.lock) block. This may
> lead to tty->link->ctrl.pktstatus being altered between the check and the
> lock, causing *kb++ = cs; to be assigned with a zero pktstatus value.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations. The above
> possible bug is reported when our tool analyzes the source code of
> Linux 5.17.
> 
> To resolve this atomicity issue, it is suggested to move the condition
> check if (packet && tty->link->ctrl.pktstatus) inside the spin_lock block.
> With this patch applied, our tool no longer reports the bug, with the
> kernel configuration allyesconfig for x86_64. Due to the absence of the
> requisite hardware, we are unable to conduct runtime testing of the patch.
> Therefore, our verification is solely based on code logic analysis.
> 
> [1] https://sites.google.com/view/basscheck/
> 
> Fixes: 64d608db38ff ("tty: cumulate and document tty_struct::ctrl* members")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> ---
>  drivers/tty/n_tty.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index f252d0b5a434..df54ab0c4d8c 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -2222,19 +2222,23 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
>  	add_wait_queue(&tty->read_wait, &wait);
>  	while (nr) {
>  		/* First test for status change. */
> +		spin_lock_irq(&tty->link->ctrl.lock);
>  		if (packet && tty->link->ctrl.pktstatus) {
>  			u8 cs;
> -			if (kb != kbuf)
> +			if (kb != kbuf) {
> +				spin_unlock_irq(&tty->link->ctrl.lock);
>  				break;
> -			spin_lock_irq(&tty->link->ctrl.lock);
> +			}
>  			cs = tty->link->ctrl.pktstatus;
>  			tty->link->ctrl.pktstatus = 0;
>  			spin_unlock_irq(&tty->link->ctrl.lock);
>  			*kb++ = cs;
>  			nr--;
>  			break;
> +		} else {
> +			spin_unlock_irq(&tty->link->ctrl.lock);

This seems way over-engineered. Wouldn't it be much simpler to just test 
if cs is non-zero after the original critical section to detect if there 
were any changes into pktstatus before the lock was acquired? That would 
avoid all this lock dance and enlarging the critical section.

>  		}
> -
> +

Spurious changes like this should not be included into patches.

>  		if (!input_available_p(tty, 0)) {
>  			up_read(&tty->termios_rwsem);
>  			tty_buffer_flush_work(tty->port);
> 

-- 
 i.


