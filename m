Return-Path: <linux-kernel+bounces-93197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC02872C31
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690E2B284C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46ABDDAA;
	Wed,  6 Mar 2024 01:23:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DCA50;
	Wed,  6 Mar 2024 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688234; cv=none; b=FwwhZQg7RQvlwzeJpigFNMInmgbA2DUVt3CB0mYgo63m4QuWdfeB5KBgn/IdJ/Yj/6jYTbye2Ms6nNRedaRfOvZKg4ze2Pq3Oo+BlN7ipeWcbRTis2eUznolstJe4pgHahRnhy0OKUyB0izWUT9ez2ccRxoaNrMIYNWmyI9ugfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688234; c=relaxed/simple;
	bh=ROuXL7+LUPZ8Db7wqcYiyDitQ6800u+otyIvruCWmOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q2Y/f8i1BetxcP1F6xGDYTOcbz9Nn55r1QQ4qjbBG32OdXSh4MlPRKTbZKNVtCIFMwMEOLmDQkzpTrUqz0Zr4eZ7DTce2mEl/fbkeK5CkWsdS5vQd1Hy6/dIDp7uTR9UUs49QLANZgCBYBlmC+EjAcWy4g9zF8cST1IYRa7QiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TqF5849jbzXhlr;
	Wed,  6 Mar 2024 09:21:32 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AB8B140F95;
	Wed,  6 Mar 2024 09:23:47 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 09:23:47 +0800
Message-ID: <d1209aa3-b8d4-4509-9689-4882bc079ffd@huawei.com>
Date: Wed, 6 Mar 2024 09:23:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: chardev: make bch_chardev_class constant
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Kent Overstreet
	<kent.overstreet@linux.dev>, Brian Foster <bfoster@redhat.com>
CC: <linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240305-bcachefs-v1-1-436196e25729@marliere.net>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240305-bcachefs-v1-1-436196e25729@marliere.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/3/6 4:21, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the bch_chardev_class structure to be declared at build
> time placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>   fs/bcachefs/chardev.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
> index 226b39c17667..af587453fd3d 100644
> --- a/fs/bcachefs/chardev.c
> +++ b/fs/bcachefs/chardev.c
> @@ -940,7 +940,9 @@ static const struct file_operations bch_chardev_fops = {
>   };
>   
>   static int bch_chardev_major;
> -static struct class *bch_chardev_class;
> +static const struct class bch_chardev_class = {
> +	.name = "bcachefs",
> +};
>   static struct device *bch_chardev;
>   
>   void bch2_fs_chardev_exit(struct bch_fs *c)
> @@ -957,7 +959,7 @@ int bch2_fs_chardev_init(struct bch_fs *c)
>   	if (c->minor < 0)
>   		return c->minor;
>   
> -	c->chardev = device_create(bch_chardev_class, NULL,
> +	c->chardev = device_create(&bch_chardev_class, NULL,
>   				   MKDEV(bch_chardev_major, c->minor), c,
>   				   "bcachefs%u-ctl", c->minor);
>   	if (IS_ERR(c->chardev))
> @@ -968,26 +970,25 @@ int bch2_fs_chardev_init(struct bch_fs *c)
>   
>   void bch2_chardev_exit(void)
>   {
> -	if (!IS_ERR_OR_NULL(bch_chardev_class))
> -		device_destroy(bch_chardev_class,
> -			       MKDEV(bch_chardev_major, U8_MAX));
> -	if (!IS_ERR_OR_NULL(bch_chardev_class))
> -		class_destroy(bch_chardev_class);
> +	device_destroy(&bch_chardev_class, MKDEV(bch_chardev_major, U8_MAX));
> +	class_unregister(&bch_chardev_class);
>   	if (bch_chardev_major > 0)
>   		unregister_chrdev(bch_chardev_major, "bcachefs");
>   }
>   
>   int __init bch2_chardev_init(void)
>   {
> +	int ret;
> +
>   	bch_chardev_major = register_chrdev(0, "bcachefs-ctl", &bch_chardev_fops);
>   	if (bch_chardev_major < 0)
>   		return bch_chardev_major;
>   
> -	bch_chardev_class = class_create("bcachefs");
> -	if (IS_ERR(bch_chardev_class))
> -		return PTR_ERR(bch_chardev_class);
> +	ret = class_register(&bch_chardev_class);
> +	if (ret)
Here, I think you should call class_unregister to relase resource which 
allocated before. And the same thing shoud be done in other exception exit.
> +		return ret;
>   
> -	bch_chardev = device_create(bch_chardev_class, NULL,
> +	bch_chardev = device_create(&bch_chardev_class, NULL,
>   				    MKDEV(bch_chardev_major, U8_MAX),
>   				    NULL, "bcachefs-ctl");
>   	if (IS_ERR(bch_chardev))
like here..
> 
> ---
> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> change-id: 20240305-bcachefs-27a4bb8b9f4f
> 
> Best regards,

