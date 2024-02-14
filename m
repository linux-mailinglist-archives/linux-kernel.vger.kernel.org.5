Return-Path: <linux-kernel+bounces-64849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA688543B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B855B232AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550D11CA9;
	Wed, 14 Feb 2024 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Bje3DTZU"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8711706;
	Wed, 14 Feb 2024 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897577; cv=none; b=lOcaYWwFhaDMKEU2/qiDACBLaojXZMZX0lg00vB9yXdBUuiNbOV2VMZoJDdfHLSLEZZYI7Db2spsuDaJkEBySrbzYp12JlrndMXptnpBlVo0W+LPky8oSDXE//luYDxZcowdreqZ2a3v54pNplNdQqkhXvtI2gRMmPsGYdJdUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897577; c=relaxed/simple;
	bh=kGkB+tECODquRq5qt8lXIgXC6l1GnX+cpabAS67lCJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku5l1p39quBU16F5IwaTRgKuenEzZBDXX8SRzWsSQzqe5/s/3p/VOCqxuP1IqVJZfw3jthUNHTGqRMwINdzYxE3Vp215+sF5rXya6ZwIurwFpgvG9IRipmfCyw7tjaysfNTn+CYxGuVjHg4HBiu3u7D4/Us2Ut8BDIiNsf+B8Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=Bje3DTZU; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id B96B9604B9;
	Wed, 14 Feb 2024 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707897574;
	bh=kGkB+tECODquRq5qt8lXIgXC6l1GnX+cpabAS67lCJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bje3DTZUjDh7iTlRzAvqtHwvcyv9x3baWQbZbdRgTDWaKBkBU3QaLhr2E8XfMwgZa
	 hZrAW48N9wzlAIXPd+U7/yAWVTcMIkc96xVBGTjwGOE+L9f6a3UxWNh/B8Jd0L/zmq
	 JpM4dfP2Vc2YR3fHakxbL1qaCAHbvFBaXd/WQ1K2rT0+665SyZUC6w+eWn3LCpdpmU
	 xdcxE0f4UjaE+SH5FbpW22lNzvquye1oGcjtXat7xglfW0r1SvdGrs6Ngwa8HZaA28
	 JlrXkxqWETD+xeqHeWa5TgHygM9fOptdPEnImmYere8swzvRmvMIfHhlTCt3NMzyud
	 a+nz41N/P4reQ==
Date: Wed, 14 Feb 2024 09:59:01 +0200
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/6] printk: Save console options for
 add_preferred_console_match()
Message-ID: <20240214075901.GO52537@atomide.com>
References: <20240213084545.40617-1-tony@atomide.com>
 <20240213084545.40617-2-tony@atomide.com>
 <Zcub1bQrDqHE0Mkt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcub1bQrDqHE0Mkt@smile.fi.intel.com>

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240213 16:42]:
> With fresh look at the above, can we amend it like below?
> (dropped NULL assignment, optimized strlen(), split checks, dropped unneeded +1 in strscpy() calls)

Sure that's nicer :) I think opt can be empty unlike brl_opt, will test.

Regards,

Tony

