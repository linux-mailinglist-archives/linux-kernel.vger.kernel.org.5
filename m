Return-Path: <linux-kernel+bounces-52261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F322849609
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F33C1F20F2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920401426F;
	Mon,  5 Feb 2024 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="hwgn3PrN"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770513FE7;
	Mon,  5 Feb 2024 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124065; cv=none; b=rBPdbi6xM0KmJC4j7KZXykm9Oya41Fw5ecEcgwDAcF4v25UlAngUr2Y+Yp5MDDATek34MXG5XQDnwFaR72cKmVUSDoEwrKlzHUhL5KoTGRoXCVBet6vevO5196Ys/dp9cZawShSS1KlX4YlaOHphbBjHu/BwRHvc8sj9uTbq3qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124065; c=relaxed/simple;
	bh=y+z9xVQilhhc12JJlLDw+v63p9nJbNGDefO4T0ZXh4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4nYAKOfOkvxgw9xXz7FJDDA1i29QO36eyVwTijhExo/2Jw2TVq65ugmUfKiOfane5s2RemDU+9kMb9Oh0H8D4xfobEav8k56Ug8YJ7iapveciUkrzc3OxgR1aHnT55Im41TRvbRJFMGV+zhQH4tne5WrQwzS3gd1J68ElZ6gCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=hwgn3PrN; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id DA39C60372;
	Mon,  5 Feb 2024 09:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707124062;
	bh=y+z9xVQilhhc12JJlLDw+v63p9nJbNGDefO4T0ZXh4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwgn3PrNMAjkMX+XS8UmD8BVTb00qt8zHYGzUAtCGpMsArJPxjKleZjYu0+fJAZZv
	 Oker8ZGAHXnK2LOgB1i18XHQikNt1MatgPripF66eZszCd+6s9OXa9eDGx1LKKknWi
	 OssM2goeu9TtOV3xgIm2DAlJdQBudJ2z5gpD6vGLDs3FeWyklFI920QjfzSzJiFcXf
	 DzYPr8HYoaXk5BcLcY/cfNzxISHwFavvnmRThzVRqGK3WS2nfNGSBuTXm3a3ClN9aK
	 /MCy/UaAspxxsxLW7ESuhUpOqtaFN85ukcb1btHBqAdfE8ZsSxvYuMWFbH3MNvpMKI
	 kxDxO/JoGYG+Q==
Date: Mon, 5 Feb 2024 11:07:13 +0200
From: Tony Lindgren <tony@atomide.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, john.ogness@linutronix.de,
	andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
	linuxarm@huawei.com, prime.zeng@hisilicon.com,
	jonathan.cameron@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH] serial: port: Don't suspend if the port is still busy
Message-ID: <20240205090713.GE5185@atomide.com>
References: <20240204031957.58176-1-yangyicong@huawei.com>
 <20240205065126.GB5185@atomide.com>
 <b1518b0f-977a-58f5-3164-a6bb9a45dfbe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1518b0f-977a-58f5-3164-a6bb9a45dfbe@huawei.com>

* Yicong Yang <yangyicong@huawei.com> [240205 08:55]:
> On 2024/2/5 14:51, Tony Lindgren wrote:
> > Can you please confirm if this still happens also with commit 6f699743aebf
> > ("serial: core: Fix runtime PM handling for pending tx")? It adds a check
> > for -EINPROGRESS.
> 
> Tested nagetive on latest v6.8-rc3. Paste the current code snippet below in __uart_start():

OK thanks for confirming it.

> In our issue case, the dev->power.runtime_status == RPM_RESUMING as analyzed in
> commit. So we cannot pass the pm_runtime_active() check and the chars will still
> be pending.

OK

> Do you mean something like below?
> 
> static int serial_port_runtime_suspend(struct device *dev)
> {
> 	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
> 	struct uart_port *port;
> 	unsigned long flags;
> 	int ret = 0;
> 
> 	port = port_dev->port;
> 
> 	if (port->flags & UPF_DEAD)
> 		return ret;
> 
> 	spin_lock_irqsave(&port->lock, flags);
> 	if (__serial_port_busy(port)) {
> 		port->ops->start_tx(port);
> 		ret = -EBUSY;
> 	}
> 	spin_unlock_irqrestore(&port->lock, flags);
> 
> 	return ret;
> }

Yes the above should work.

> If so will the port fail to suspend after flushing the pending chars? Considering
> underlay driver like amba-pl011 doesn't implement runtime power management, does
> anyone will get the port into suspend routine later? I'm not quite sure about it.

Hmm yeah you may need to also call pm_runtime_mark_last_busy() to
ensure the port gets idled later on. Not sure if PM runtime core does that for
you on returning -EBUSY, worth checking it :)

The PM runtime hierarchy will block the serial port controller driver from
suspending, so the port drivers won't runtime suspend.

> In the patch's implementation the pending chars will be flushed in runtime_resume()
> callback and rpm_resume() will try to call rpm_idle() later.

On serial_port_runtime_suspend() the serial port controller will be active, so
you can call start_tx() directly.

Regards,

Tony

