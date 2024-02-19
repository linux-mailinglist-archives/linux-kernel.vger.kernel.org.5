Return-Path: <linux-kernel+bounces-71535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5114285A6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2FE283949
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F4F39ACA;
	Mon, 19 Feb 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNo/oMBN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gkrYlyo1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CC38394
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355030; cv=none; b=fk1Re+QfSe6vJfie1JItmG9HX0pVm3Rj7IVWZjKqItymB9VE7jM6xbHE2Q5lRcJdIhpDDJRuArnqaF0M1jsA1RIyl0UavH4l1E6kbps0vWIe3+tMVIuavZXded3PVyCiJClfTjipmc3zT+hCwHEjhVaO8aGmXFdhK6vJ/ZJFasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355030; c=relaxed/simple;
	bh=ApvrSVTt2VQ9dXSMfqiGO+i5OycSSX99sOsBkR0FVNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G6WhlYAtd8t/3LQ9WEu2nWbNceXrQac3by1kB8dIAc7a7ZndI/skfmjR81rl5kgRnINPtF3xGg33crWybbrDkc6EvR0ueWjherysMomojfw+LYsE6m/e86p1aCr6zF4rOwRi9Y/EZNpf422Ayf4ZTZJoVyn6MV4lGrDVpzPrK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNo/oMBN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gkrYlyo1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708355027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IC2X9BzxyD17RrC7x2W6QPthCzzd0SS8kYq0ja2PKLM=;
	b=uNo/oMBNB8lXr4rderd3q111++OVB+uxXDddj+uY0/uNQLQM4Frtyh3EYmHBaS7fmE7Bjv
	fB0X7gIcZSYaZosuF6bSdP+L8wLJ4fZ9lZf7P2u6IcJW5ey0ltsD6WCj9/LNbpm6g5Ks17
	eVL3GNby30PawdTa0rBr+UQs3Nto9OuIa/Y7m0oV2reTKCkPGqOZmRAH6e/wforh8WEFV6
	KqCejLsUwE9dm4s/Z7J4o1LIl0rb4D7lD7JJc2YSFq4F89nPEKacVlvA+LEXRujODGJ5SU
	pH5+FPKg20WG+dFFQtbbqTRdrIn384rPUEustAAKgM0dAAOSHp1qMSUkOP/agQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708355027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IC2X9BzxyD17RrC7x2W6QPthCzzd0SS8kYq0ja2PKLM=;
	b=gkrYlyo1EdebKj/NoS6vbRsWdIOQ5XmPg8Wr+j/mBczLDlnIIl82doPXdrvh76ymEioAiR
	KhwiHYZhjuTHhhCw==
To: Angus Chen <angus.chen@jaguarmicro.com>
Cc: linux-kernel@vger.kernel.org, Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] genirq: Fix irqs_unhandled in note_interrupt
In-Reply-To: <20231128021043.2099-1-angus.chen@jaguarmicro.com>
References: <20231128021043.2099-1-angus.chen@jaguarmicro.com>
Date: Mon, 19 Feb 2024 16:03:46 +0100
Message-ID: <874je4a431.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 28 2023 at 10:10, Angus Chen wrote:
> Commit 4f27c00bf80f ("Improve behaviour of spurious IRQ detect")
> introduced a age of last_unhandled,after irq_count reached 100000,
> we set irqs_unhandled = 0,but we didn't clear last_unhandled.

We do nothing. Please write changelogs in passive voice.

> So we can see the print of irq_spurious_proc_show is not consistent.
> Like below:
> root@jmkernel:~# cat /proc/irq/138/spurious
> count 99998
> unhandled 1
> last_unhandled 1543930240 ms
>
> root@jmkernel:~# cat /proc/irq/138/spurious
> count 0
> unhandled 0
> last_unhandled 1548915240 ms

I can't figure out what you are trying to demonstrate here.

> we can set last_unhandled=1 as a prompting message.

This makes no sense either.

> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  kernel/irq/spurious.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
> index 02b2daf07441..e883df04bdf1 100644
> --- a/kernel/irq/spurious.c
> +++ b/kernel/irq/spurious.c
> @@ -428,7 +428,7 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
>  		mod_timer(&poll_spurious_irq_timer,
>  			  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
>  	}
> -	desc->irqs_unhandled = 0;
> +	desc->irqs_unhandled = 1;

Why? Just to do some incomprehensible /proc/ output cosmetics instead of
fixing the related procfs function?

Thanks,

        tglx

