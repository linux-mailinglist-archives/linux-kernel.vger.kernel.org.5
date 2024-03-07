Return-Path: <linux-kernel+bounces-95553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C35874F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA28B1F233D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B012BEAC;
	Thu,  7 Mar 2024 12:43:59 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EEF12AADB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815439; cv=none; b=RGvLT9sqhl50buF/yqtZI/qsDDYxfL1WzjpoVGuVZYb/Up2O/tyv5FY7rw4aAKDbX8vrpZZ4NJtAIkMtpG8Geszf+aBcoFRGvkMJrBh/8QHahI3Du8jWXP/PkTQ8SY5bdX9nD8WUjWYRRxMh+MqArL0XCML+S/ZMDEzHQWLOhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815439; c=relaxed/simple;
	bh=+5k+8rEgISBNGB59KLCG2aMKGbsCMx3Ul6Z2Iblf7J0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J63WIoCJL9WrnP9yweda2qRA5R6Rk1VUgPZpzZgOdod4A8sDqG80PALVO/Lir7oczGwB7c4L5p7Mj8qnlSTGY/aYJBMwNFjj0RwND/2bVgo6j1wWLCRpmlHXgn0doYLW2OWJf0/KzE5BC/nni91dr2yMQhH9dPr5pssI/iejdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tr7qs4Kmxz9xHw5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:28:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 24626140154
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:43:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXTBWAtullIlHjAw--.4316S2;
	Thu, 07 Mar 2024 13:43:51 +0100 (CET)
Message-ID: <2d70513e9f84e650ef1ede5a8ae5960a9de782bc.camel@huaweicloud.com>
Subject: Re: [PATCH] um: Add winch to winch_handlers before registering
 winch IRQ
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Thu, 07 Mar 2024 13:43:40 +0100
In-Reply-To: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
References: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBXTBWAtullIlHjAw--.4316S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF45Jr4fCF4UAFWDZFW3Awb_yoW8uFW5pF
	WagFnavrWSqa10ganrJa1qyFWxAws7Gr1Uur1kK345ZryUXr9aqF1rGa42qF1DAry7Jr93
	Xr4F9a9xuayDAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr
	1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5sXFwABsh

On Thu, 2024-03-07 at 11:49 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Registering a winch IRQ is racy, an interrupt may occur before the winch =
is
> added to the winch_handlers list.
>=20
> If that happens, register_winch_irq() adds to that list a winch that is
> scheduled to be (or has already been) freed, causing a panic later in
> winch_cleanup().
>=20
> Avoid the race by adding the winch to the winch_handlers list before
> registering the IRQ, and rolling back if um_request_irq() fails.
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Fixes: 42a359e31a0e ("uml: SIGIO support cleanup")

I see that before that commit there was the same ordering (list_add()
before um_request_irq()).

Failure from um_request_irq() should not result in executing
winch_interrupt() which could call list_del() itself. Then, it should
be fine to delete the winch in the error path.

Roberto

> ---
>  arch/um/drivers/line.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index ffc5cb92fa36..d82bc3fdb86e 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -676,24 +676,26 @@ void register_winch_irq(int fd, int tty_fd, int pid=
, struct tty_port *port,
>  		goto cleanup;
>  	}
> =20
> -	*winch =3D ((struct winch) { .list  	=3D LIST_HEAD_INIT(winch->list),
> -				   .fd  	=3D fd,
> +	*winch =3D ((struct winch) { .fd  	=3D fd,
>  				   .tty_fd 	=3D tty_fd,
>  				   .pid  	=3D pid,
>  				   .port 	=3D port,
>  				   .stack	=3D stack });
> =20
> +	spin_lock(&winch_handler_lock);
> +	list_add(&winch->list, &winch_handlers);
> +	spin_unlock(&winch_handler_lock);
> +
>  	if (um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
>  			   IRQF_SHARED, "winch", winch) < 0) {
>  		printk(KERN_ERR "register_winch_irq - failed to register "
>  		       "IRQ\n");
> +		spin_lock(&winch_handler_lock);
> +		list_del(&winch->list);
> +		spin_unlock(&winch_handler_lock);
>  		goto out_free;
>  	}
> =20
> -	spin_lock(&winch_handler_lock);
> -	list_add(&winch->list, &winch_handlers);
> -	spin_unlock(&winch_handler_lock);
> -
>  	return;
> =20
>   out_free:


