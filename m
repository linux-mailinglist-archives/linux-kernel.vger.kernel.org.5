Return-Path: <linux-kernel+bounces-19900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B1482766B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655881C21A92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6041C5576F;
	Mon,  8 Jan 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ALPPqpBy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1155761
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [192.168.1.54] (unknown [85.30.205.207])
	by mail.ispras.ru (Postfix) with ESMTPSA id D5F3F40F1DCA;
	Mon,  8 Jan 2024 17:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D5F3F40F1DCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1704735274;
	bh=fG72HQNS24TUTLjRsu7kBiaznvvqKulgAlLMRyjQxe8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=ALPPqpByHuD3DwL9WdjL0Tp6DdeOYaqiR4ULsPJqmzr+3U9EXcU+Pjz2eWrhnC+/V
	 K/eW3kz2YtytycnBRvEyZFrtOWrgrATWnIHQ0LUunwbQkKZeGP7GE9QOKWdop19ext
	 ZRfJsdv+VdvIjsv7uodIr2Q0YP83IZhWJx9VdDn4=
Subject: Re: [PATCH 2/2] procfs.c: Increasing array size
To: Andrey Shumilin <shum.sdl@nppct.ru>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20231116070536.38122-1-shum.sdl@nppct.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <c238ee65-30fb-a5b4-cff7-9adc8f12971c@ispras.ru>
Date: Mon, 8 Jan 2024 19:56:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231116070536.38122-1-shum.sdl@nppct.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 16.11.2023 10:05, Andrey Shumilin wrote:
> The maximum size in bytes of the port->base and port->base_hi
> variables is 20 bytes per variable, since they are copied in
> decimal notation. Two more characters are \t and \n.
> A maximum of 42 bytes can be written to a buffer variable.

I would update subject and description like that:

paport: Fix potential buffer overflow in do_hardware_base_addr()

The maximum size after expansion for the "%lu\t%lu\n"
is 20+1+20+1+1 = 43 bytes, while buffer is of size 20 bytes.
So buffer overflow may happen.


Otherwise, looks good to me.

Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>


> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
> ---
>  drivers/parport/procfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
> index bd388560ed59..9b894f7cb581 100644
> --- a/drivers/parport/procfs.c
> +++ b/drivers/parport/procfs.c
> @@ -117,7 +117,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
>  				 void *result, size_t *lenp, loff_t *ppos)
>  {
>  	struct parport *port = (struct parport *)table->extra1;
> -	char buffer[20];
> +	char buffer[44];
>  	int len = 0;
>  
>  	if (*ppos) {
> 


