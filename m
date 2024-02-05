Return-Path: <linux-kernel+bounces-52093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21785849403
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544B71C21F3D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF11FC147;
	Mon,  5 Feb 2024 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="myYLmNGX"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFC11700;
	Mon,  5 Feb 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115925; cv=none; b=Crd720OEtWTl9FpNaGtgYBkLj/xPbh3n+AUCKbvMdmEe2ihqVk473EyD1TJfXsEK+ZBawS++YfbyhlqZ9s/VWFpNowctRIrN7mFunbMBxTzQKCsDsu3O8c/DvZ/rJYEsE0gBV0g5NbK5DIwtZOT21P66VQ65PGfarg7ZRC+f40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115925; c=relaxed/simple;
	bh=Qzb8+O36ssVkEdkjB+UK/B3t2NyHsFMLcFyr3s7tPbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fof9wBFrePBA+il2agp5gO5CxofI19cYfH56zqvnB7PA3AVcoabQotc85ncn4u+ggdtY0beOLWeQUEhoxQ+VvHmdlfs7/cZXpcmNHXk9kQCDW0HRriTjxwtOfmd5W3DhxdnLyMXWizJcssQ5RwDuExPgB3ESPMDDOR2CgMcygdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=myYLmNGX; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 879B260461;
	Mon,  5 Feb 2024 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707115916;
	bh=Qzb8+O36ssVkEdkjB+UK/B3t2NyHsFMLcFyr3s7tPbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myYLmNGXQRXofHJznOANhXBG61lt+U1ZGM3aF49uvUoDcgKuDvhocgvBzEPfaNyS6
	 5VzFCWwkrVyKxX39fVy03ENjtt9Sde/LfDSA4/SZb5HF01Vf7x7ICtUQBhuogmYhE0
	 zrF54HKf3vs9yPfLfIEXgtiVdzCyu7FB71WiVYghLDfmVMA3RlOFZ6EzQICHz2teay
	 qhPYLVoIR4w07y0N74O/pP1Hif0Wyms1h/nXqDFVbk+rckV5qw3WbKTckmACglfiEv
	 twWZ59xNzNnRxTnGZ56GpyYhyozl8VWc/sD7rsERoH53nNOzv6md0fb5GS/1VoA56S
	 kLoy/T7x04ypA==
Date: Mon, 5 Feb 2024 08:51:26 +0200
From: Tony Lindgren <tony@atomide.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	john.ogness@linutronix.de, andriy.shevchenko@linux.intel.com,
	tglx@linutronix.de, yangyicong@hisilicon.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH] serial: port: Don't suspend if the port is still busy
Message-ID: <20240205065126.GB5185@atomide.com>
References: <20240204031957.58176-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240204031957.58176-1-yangyicong@huawei.com>

* Yicong Yang <yangyicong@huawei.com> [240204 03:24]:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> We accidently met the issue that the bash prompt is not shown after the
> previous command done and until the next input if there's only one CPU
> (In our issue other CPUs are isolated by isolcpus=). Further analysis
> shows it's because the port entering runtime suspend even if there's
> still pending chars in the buffer and the pending chars will only be
> processed in next device resuming. We are using amba-pl011 and the
> problematic flow is like below:
> 
> Bash                                         kworker
> tty_write()
>   file_tty_write()
>     n_tty_write()
>       uart_write()
>         __uart_start()
>           pm_runtime_get() // wakeup waker
>             queue_work()
>                                              pm_runtime_work()
>                                                rpm_resume()
>                                                 status = RPM_RESUMING
>                                                 serial_port_runtime_resume()
>                                                   port->ops->start_tx()
>                                                     pl011_tx_chars()
>                                                       uart_write_wakeup()
>         […]
>         __uart_start()
>           pm_runtime_get() < 0 // because runtime status = RPM_RESUMING
>                                // later data are not commit to the port driver
>                                                 status = RPM_ACTIVE
>                                                 rpm_idle() -> rpm_suspend()

Can you please confirm if this still happens also with commit 6f699743aebf
("serial: core: Fix runtime PM handling for pending tx")? It adds a check
for -EINPROGRESS.

> This patch tries to fix this by checking the port busy before entering
> runtime suspending. A runtime_suspend callback is added for the port
> driver. When entering runtime suspend the callback is invoked, if there's
> still pending chars in the buffer then request an runtime resume for
> handling this.

OK. Let's look at this further after you have checked what happens with
commit 6f699743aebf.

If needed, to me it seems that flushing tx and returning -EBUSY from
serial_port_runtime_suspend() if busy might do the trick though.

Regards,

Tony

