Return-Path: <linux-kernel+bounces-69976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6A585912D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D41AB21130
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101867D400;
	Sat, 17 Feb 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AOsZ1fOy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AB7D3E6;
	Sat, 17 Feb 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188365; cv=none; b=KcEZ0oD7e7jYiAwH9u3NtozYYXCsMozT2H8XymB1B+Q5sZZ/D1ys8ZiBSqbb2HhFuy9D5qeSv8okk7Oja+PoeNepzx2p+5THMIVFuX64WbKVQT/LvOEdjLbQ8Y6oWmBSYrWljz9DVltNfOLhl6gWGlEbIh4I1drbGe2Zd3wHqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188365; c=relaxed/simple;
	bh=x7XoWYctPcqETeBiz20slgtZGVDKxSwbVTWu+34DE1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW4/cOwDoB7mrkLlJLHwExZRasvm/Xq2nU2cG/1muuYh4nKPRfTlfkQO3DfbVkAq5VGVUe2wNen80g3ye06Cj4HXi6GTK1BL+/L48TgahVWieGoWLFQRinnRcvoJQUFHP/wPgF1/sJQbaa+m7J7fbaWa7HRC86eFNIY+xAofQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AOsZ1fOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B071DC433F1;
	Sat, 17 Feb 2024 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708188365;
	bh=x7XoWYctPcqETeBiz20slgtZGVDKxSwbVTWu+34DE1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOsZ1fOyTaQZnklis6YBOFEm5gFnbFyXCXObYMF/xDGytNZUcGwD3UfySXN9RTAp2
	 pmThqbz7llCGmiuEFOupV0HFr65jGthYLy6rq8uVaMrsp9jt5NMQ29+E3clS9yH+IU
	 sMDflX5k7DQn8tr1ypkyPIxU/UrUUChaRq0D/yI0=
Date: Sat, 17 Feb 2024 17:46:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rengarajan S <rengarajan.s@microchip.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_pci1xxxx: Drop quirk from 8250_port
Message-ID: <2024021747-material-variable-ed02@gregkh>
References: <20240214135009.3299940-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214135009.3299940-1-andriy.shevchenko@linux.intel.com>

On Wed, Feb 14, 2024 at 03:50:09PM +0200, Andy Shevchenko wrote:
> We are not supposed to spread quirks in 8250_port module especially
> when we have a separate driver for the hardware in question.
> 
> Move quirk from generic module to the driver that uses it.
> 
> While at it, move IO to ->set_divisor() callback as it has to be from
> day 1. ->get_divisor() is not supposed to perform any IO as UART port:
> - might not be powered on
> - is not locked by a spin lock
> 
> Fixes: 1ed67ecd1349 ("8250: microchip: Add 4 Mbps support in PCI1XXXX UART")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Breaks the build:

drivers/tty/serial/8250/8250_port.c: In function ‘serial8250_get_baud_rate’:
drivers/tty/serial/8250/8250_port.c:2684:32: error: unused variable ‘up’ [-Werror=unused-variable]
 2684 |         struct uart_8250_port *up = up_to_u8250p(port);
      |                                ^~
cc1: all warnings being treated as errors


