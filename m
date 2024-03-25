Return-Path: <linux-kernel+bounces-118120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3047E88B42F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDECC3067D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F131783A01;
	Mon, 25 Mar 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3/f0y6nG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VEvMHX5Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3DB82C69
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405951; cv=none; b=kf8/5AQ3AYenwe5zFmJoxtFNCBAXeuD80E8p/Jao+bSWVRVNSLr9Eu3Oh0um0X9iOCipXS9Mka2oi/wJH4swGcUahJJWQLEZOJSf5HUXOaGVVxZ58+0kyzWsSCnYoxHpY4lvekKEaGObYooJTzrdLVJopXeazcqrj2WUpacGooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405951; c=relaxed/simple;
	bh=B5fPv01EangL4dPaihakp701vL6gPpDh8Hnsgvi1Y1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p4ZP/zHLOHs2Dl4NXUdKp5EWSaCvUyxg3Oqsq+DK74P4g9qxDIzn4BOsbSRCXjpEK0z9Ai4oXypEbqpXFo4yQtSBNrIZZ3mhg0aIG2pJ89wJALp+4q7F3esd06UmXD4PYTN9yAjntN31/iqvIDdu49x9/7XlyS1gNG+83KD+6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3/f0y6nG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VEvMHX5Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711405947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TIYCmJra+99qiqo0XVnjBVA+8oUTcEab9KgVzv8hxQs=;
	b=3/f0y6nGmM4gMZgLeg8SuJOWta3GWV6wguZJsfnPfn4VxkcwkfH6WuZHvocfqNGZ7/gzbI
	8qpfYVPt4xJjzH615JOoDRdewD5OyUzA+ZCuYkp0lbyBRmur+UPaGNn/cj/iVy8/7+XJuf
	rR6Ds2LfGf3LwuDWnbLADcL9cQicxukNPD0+ZzNOterw3pAQGB/3K9AZio3pJ3ruGHNi45
	zs3MaZlfalpRiuGPSCylpSqHvNgTGmg0LiBQOV72LUPwZhspwk5r+HYtzM1+rQYlyQqcpw
	rxv0ksrjgXQSzoUzPI6v0Jcpc8MmfkrdwQr536IUozzj0wqOqXTPO19OBNTs4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711405947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TIYCmJra+99qiqo0XVnjBVA+8oUTcEab9KgVzv8hxQs=;
	b=VEvMHX5YS9yDK8WE7sfEI6XX1+DvUa77hxXvvny7f8JCW0hqTniHw+B+uaO6wvnRahWaPV
	/tvLuFOBMT9mdKAQ==
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: linux-kernel@vger.kernel.org, Adrian Huang <adrianhuang0701@gmail.com>,
 Jiwei Sun <sunjw10@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] genirq/proc: Try to jump over the unallocated irq
 hole whenever possible
In-Reply-To: <20240325035102.15245-1-adrianhuang0701@gmail.com>
References: <20240325035102.15245-1-adrianhuang0701@gmail.com>
Date: Mon, 25 Mar 2024 23:32:26 +0100
Message-ID: <874jcueydh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 25 2024 at 11:51, Adrian Huang wrote:
> * The following result is the average execution time of five-time
>   measurements about seq_read_iter().
>
>    no patch (us)     patched (us)     saved
>    -------------     ------------    -------
>           158552           148094       6.6%
>
> [1] https://gist.github.com/AdrianHuang/6c60b8053b2b3ecf6da56dec7a0eae70

These gist links are useless within no time and not of real value. We
all know that there are holes.

> Tested-by: Jiwei Sun <sunjw10@lenovo.com>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  kernel/irq/proc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> index 623b8136e9af..756bdc1fd07b 100644
> --- a/kernel/irq/proc.c
> +++ b/kernel/irq/proc.c
> @@ -485,7 +485,14 @@ int show_interrupts(struct seq_file *p, void *v)
>  
>  	rcu_read_lock();
>  	desc = irq_to_desc(i);
> -	if (!desc || irq_settings_is_hidden(desc))
> +	if (!desc) {
> +		/* Try to jump over the unallocated irq hole. */
> +		*(int *) v = irq_get_next_irq(i + 1) - 1;

The position is loff_t and not int. See the type cast at the beginning
of that function. But let's leave this detail aside and let me ask the
real question:

Why are you not handling it at the place where the seq_file position is
iterated instead of doing this + 1 - 1 game here and getting the next
number only when you already ran into the hole?

That's the obvious place, no?

Thanks,

        tglx

