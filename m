Return-Path: <linux-kernel+bounces-63142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA616852B91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD4A1C22748
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D68224D2;
	Tue, 13 Feb 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PfBosD5V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d3EQaR1t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C79224C6;
	Tue, 13 Feb 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814002; cv=none; b=B33jJK8HCcNIO/XbOgylW+Ga1qw6JMvAB1tEbqHthaJWPLj2w2ha70FTP3/pNS4dheH9im2RxeQIEp1rF3MvKASYuZg56KIJMg396WHnouKego5h21+QODJhi+KzytBYvjVjebKbEKW76g0b7XzLG8cDOiI54BRfad6O83jPdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814002; c=relaxed/simple;
	bh=qQiwpn09B4+vwleHQGtUBug9CbJpwTwlrCSrjzBa3z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UObQu9QBk0O1mT3GE4UBEd97z+m1Wrl4sVFuf2/shfQUrzOYdDH8jmgf2Cpg2DpKTFNeXWL4d+AtafeABBmYzH5HIRrIdbLUDnOgMndMQRyAwUo6fJlQJhzKFkGLdayHfI+eXbqfNwWjBHQsOeozDGLTks8uGGkke6d3nWZtpYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PfBosD5V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d3EQaR1t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707813999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sv7XIDRdwrOpwhStOB8VNj5SMdSkv/7xoAweXnGu+b0=;
	b=PfBosD5V0ngTuqtDPittmA5h/Gr0F4p9mccJqaALyIIvxeMC1WkTdYQIVkUDnP5g7tT4HC
	nVI6onaEYHpm7OD+KkOlUeeZ+6Y9DvYQTFeaooJ1wvS7gYbAdbZT76SC8GIZKKFbx+Oscp
	rSWrsHFnYxFXBCbTv7S84ood32Em5nLWbFWwdvtwsiqZu7nCmZPuXsb4+oInKgr5rUs+Wj
	ys88ZB+nuhQPgMC5GeOwT+XSm0ZMEbvfWCyfIJO7OoIf36eNmLKR0wXVswNHBayos9H2Dx
	3bxg34TMU2wPA08iMfOkXbt7DpONHwpcIogb5tf/VsV1ill6B45DHk2P9XjLLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707813999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sv7XIDRdwrOpwhStOB8VNj5SMdSkv/7xoAweXnGu+b0=;
	b=d3EQaR1tV6hGzu+06Fh8PgLDPqDxQfWAfnF1J0MzvPuDhoSppXX/D8yErXivQ+0cYj+POq
	h8dzB4ZaYwCmjcDQ==
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey
 Shtylyov <s.shtylyov@omp.ru>, lvjianmin@loongson.cn, Huacai Chen
 <chenhuacai@loongson.cn>
Subject: Re: [PATCH v5 1/3] irqchip/loongson-eiointc: Typo fix in function
 eiointc_domain_alloc
In-Reply-To: <20240130082722.2912576-2-maobibo@loongson.cn>
References: <20240130082722.2912576-1-maobibo@loongson.cn>
 <20240130082722.2912576-2-maobibo@loongson.cn>
Date: Tue, 13 Feb 2024 09:46:39 +0100
Message-ID: <87frxwiweo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 30 2024 at 16:27, Bibo Mao wrote:
> There is small typo in function eiointc_domain_alloc(), and there is
> no

This is not a typo. The code uses an undeclared struct type, no?

> definition about eiointc struct, instead its name should be eiointc_priv
> struct. It is strange that there is no warning with gcc compiler.

It's absolutely not strange. The compiler treats 'struct eiointc *priv'
as forward declaration and it does not complain because the assignment
is a void pointer and it's handed into irq_domain_set_info() as a void
pointer argument. C is wonderful, isn't it?

> This patch fixes the small typo issue.

# git grep 'This patch' Documentation/process/

> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> index 1623cd779175..b3736bdd4b9f 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -241,7 +241,7 @@ static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  	int ret;
>  	unsigned int i, type;
>  	unsigned long hwirq = 0;
> -	struct eiointc *priv = domain->host_data;
> +	struct eiointc_priv *priv = domain->host_data;
>  
>  	ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
>  	if (ret)

