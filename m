Return-Path: <linux-kernel+bounces-29120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C271F830923
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64921B23D17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E242134E;
	Wed, 17 Jan 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="MDJEmvVv"
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD33B1E485;
	Wed, 17 Jan 2024 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.6.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503973; cv=none; b=dnFpGkhI3LPaR9Ik3sNcIRe0Zw88gSbQN7YsmnBi2McJI7SXjbhWDUpj4sxPPoVjbSm9C0Ck1RDzfg5Q6/+lQVi6b504PQ6Tzry2sKWu0nltOFHE9AK7ZlaiO5vPc2WS4U8wO8673/F+8cMjYBSkdZKDVOBMyONN33o7el/7UdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503973; c=relaxed/simple;
	bh=0puuW3TJ0FCRviSMs7e5yTWLZRzhlBbPbMaNHCKi2EQ=;
	h=DKIM-Signature:From:To:CC:Subject:Date:Message-ID:X-klartext:
	 In-Reply-To:References:MIME-Version:Content-Type; b=LDtqCfPBDa1xaykrWJUG6TWzBVJ+A2GqcFFjAY/DKS/pCwR/MjZlkf+sa40PWDQLzqK3Hwtj1bic+vdMpUcK+H+HWBW8/qz2zEQt1MwgBkP9TZ4KCtFDq6bIN8BQY3hU6/ZF1D3Fk4pBfP5xK9dK57uqTJwRHsfUZW+crQR+ZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=MDJEmvVv; arc=none smtp.client-ip=178.254.6.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1705503387;
	bh=8zEDP540sjwJaBrMK5oZNAb5uebPyAwo3ymgl0om22g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=MDJEmvVvjPOMDdAmlvf/L+gbqe/avosXlfx/ll/72v6KZtxWHsyHrUuRGZ2MUempq
	 ehcjuB8jZS+tdZFgS/R1zeFwA5dgJYrLQKKocgtF2bA4jwrvCLPuoRjD23ABWm+OOW
	 Q3rfTgicGG915sTiu4xOkORDo54i3EiOT+XB40P8DlFfseAzy3e2rnBAA2CHzaXu6E
	 mPjVbtdWRs7Hq83gnIdPGILVDVRPtluoQCS+Bw4TWE7t0jokB0GFVp4/WQnytRGjFL
	 LieTe2jaOOHRNAf57WmOJjGk+H8iDnwAkTAa0IfEqp4u3uJD9I827K9Z+0d2VnKj4V
	 nhErBTHFZ72tA==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <crescentcy.hsieh@moxa.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<LinoSanfilippo@gmx.de>, <lukas@wunner.de>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <cniedermaier@dh-electronics.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/2] tty: serial: Cleanup the bit shift with macro
Date: Wed, 17 Jan 2024 15:56:23 +0100
Message-ID: <20240117145623.3556-1-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20231201071554.258607-2-crescentcy.hsieh@moxa.com>
References: <20231201071554.258607-2-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi everyone,

> This patch replaces the bit shift code with "_BITUL()" macro inside
> "serial_rs485" struct.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> ---
>  include/uapi/linux/serial.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index 53bc1af67..6c75ebdd7 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -11,6 +11,7 @@
>  #ifndef _UAPI_LINUX_SERIAL_H
>  #define _UAPI_LINUX_SERIAL_H
>  
> +#include <linux/const.h>
>  #include <linux/types.h>
>  
>  #include <linux/tty_flags.h>
> @@ -140,14 +141,14 @@ struct serial_icounter_struct {
>   */
>  struct serial_rs485 {
>  	__u32	flags;
> -#define SER_RS485_ENABLED		(1 << 0)
> -#define SER_RS485_RTS_ON_SEND		(1 << 1)
> -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)

In the old definition (1 << 3) wasn't used.

> -#define SER_RS485_RX_DURING_TX		(1 << 4)
> -#define SER_RS485_TERMINATE_BUS		(1 << 5)
> -#define SER_RS485_ADDRB			(1 << 6)
> -#define SER_RS485_ADDR_RECV		(1 << 7)
> -#define SER_RS485_ADDR_DEST		(1 << 8)
> +#define SER_RS485_ENABLED		_BITUL(0)
> +#define SER_RS485_RTS_ON_SEND		_BITUL(1)
> +#define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
> +#define SER_RS485_RX_DURING_TX		_BITUL(3)

Isn't it a break if number 3 isn't skipped here as well?

Regards
Christoph

