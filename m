Return-Path: <linux-kernel+bounces-52294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F6849669
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6AD1C22077
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D74312B7C;
	Mon,  5 Feb 2024 09:26:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63F12B6B;
	Mon,  5 Feb 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125190; cv=none; b=blnPFfG5kIB109j4NJfolayMjgbfXq1ePf3ffvhW3cQLmSQSSmVl3FSqRJ/ZCbGEP1exsLldcLszc59KwyZrYf4ZgEPTrX/nv1xhHIAq0T4JF8VgyhAIaaDAp1nPztYiiFp6lGuM2VWNSpPcrOLTr5s2jdSr4fSYTxNbo7erDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125190; c=relaxed/simple;
	bh=7OyURGYGOY4oL4U5w30W7RLDOoIaRQQmTHuPg6B3DAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnVg2KGMN1344omUR78MSVXuwMHemJuD0uPCjGLtJE0xVGes/4fbsH6MbNaFLU9J/knWXPdX9Niwn9VpzEGP5RMSyiceqosHHv0BFqxAIX2VuQX8IE1fa0ZDFHuupMv958QbNxqjKaN+DCWvYmYhzrFdjRbbQAUwQuTIYgIgK70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061A0C433F1;
	Mon,  5 Feb 2024 09:26:28 +0000 (UTC)
Message-ID: <4d453cd8-6cee-44f1-a14a-fc5ecdea1971@xs4all.nl>
Date: Mon, 5 Feb 2024 10:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: go7007: fix a memleak in go7007_load_encoder
Content-Language: en-US, nl
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240122172556.3842580-1-alexious@zju.edu.cn>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240122172556.3842580-1-alexious@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 18:25, Zhipeng Lu wrote:
> In go7007_load_encoder, bounce(i.e. go->boot_fw), is allocated without
> a deallocation thereafter. After the following call chain:
> 
> saa7134_go7007_init
>   |-> go7007_boot_encoder
>         |-> go7007_load_encoder
>   |-> kfree(go)
> 
> go is freed and thus bounce is leaked.

It doesn't look like you compiled this!

drivers/media/usb/go7007/go7007-driver.c: In function 'go7007_load_encoder':
drivers/media/usb/go7007/go7007-driver.c:112:17: warning: 'bounce' may be used uninitialized [-Wmaybe-uninitialized]
  112 |                 kfree(bounce);
      |                 ^~~~~~~~~~~~~
drivers/media/usb/go7007/go7007-driver.c:82:15: note: 'bounce' was declared here
   82 |         void *bounce;
      |               ^~~~~~

> 
> Fixes: 95ef39403f89 ("[media] go7007: remember boot firmware")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/media/usb/go7007/go7007-driver.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/go7007/go7007-driver.c b/drivers/media/usb/go7007/go7007-driver.c
> index 0c24e2984304..65d6a63068dc 100644
> --- a/drivers/media/usb/go7007/go7007-driver.c
> +++ b/drivers/media/usb/go7007/go7007-driver.c
> @@ -80,7 +80,7 @@ static int go7007_load_encoder(struct go7007 *go)
>  	const struct firmware *fw_entry;
>  	char fw_name[] = "go7007/go7007fw.bin";
>  	void *bounce;
> -	int fw_len, rv = 0;
> +	int fw_len;
>  	u16 intr_val, intr_data;
>  
>  	if (go->boot_fw == NULL) {
> @@ -109,9 +109,10 @@ static int go7007_load_encoder(struct go7007 *go)
>  	    go7007_read_interrupt(go, &intr_val, &intr_data) < 0 ||
>  			(intr_val & ~0x1) != 0x5a5a) {
>  		v4l2_err(go, "error transferring firmware\n");
> -		rv = -1;
> +		kfree(bounce);

Just do kfree(go->boot_fw).

Regards,

	Hans

> +		return -1;
>  	}
> -	return rv;
> +	return 0;
>  }
>  
>  MODULE_FIRMWARE("go7007/go7007fw.bin");


