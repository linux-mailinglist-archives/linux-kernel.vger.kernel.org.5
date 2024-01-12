Return-Path: <linux-kernel+bounces-24705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA9F82C117
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF31B231A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BCE6D1BB;
	Fri, 12 Jan 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LPFbBNAq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AB6D1A8;
	Fri, 12 Jan 2024 13:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516F5C433C7;
	Fri, 12 Jan 2024 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705067301;
	bh=EFpXmdi+94w1NoCiiu1BKtTy8v+SRmS3ykZ0eRaUW30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPFbBNAqGLfRO+EmAnPz+SzHL4dFyN4vF9ZdZIZp/bYmcGQ4PkvfKjov3ndqXJ1PU
	 4lqr8S6BF6ld4MjJqZ6ehTp7/RwVGwxuAONtXSwq8Co/n/gDiZ02sDP9rvqciLBfE/
	 TFgt+yDnQnjyv8VXbZlAnmDtT4/fL1yozlGYckf4=
Date: Fri, 12 Jan 2024 14:48:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, baijiaju1990@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: fix atomicity violation in n_tty_read
Message-ID: <2024011212-disbelief-respect-5230@gregkh>
References: <20240112125801.2650-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112125801.2650-1-2045gemini@gmail.com>

On Fri, Jan 12, 2024 at 08:58:01PM +0800, Gui-Dong Han wrote:
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

Again, we can't do anything with 5.17 patches :(

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

That is not where this code came from :(

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

What is this lock going to do for the performance?  The n_tty_read path
is VERY tricky, and heavily used and tested, without a real reproducer
or proof of a bug here, we are going to be very loath to change anything
for obvious reasons.

Also, how was this tested?

thanks,

greg k-h

