Return-Path: <linux-kernel+bounces-38222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3AC83BCB6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8A91F2D101
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4671BDC8;
	Thu, 25 Jan 2024 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f7Xz34JG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297D1BC5B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173168; cv=none; b=XYstgp18P9Nu3ZmxuA8pDzzRY+HtpNJnjXyzvydPpA89cEC0t0qHxn1q3iNc2wpsP8YfrmHNOSgWSmXybteANLBa5IPwsi4Vqig3Bsq/2dkiSWc9IdDAvKoSzp13ZIdYAeKOWtdv4IJddytBzxoKIElsjnNcShh8BkuJHmisapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173168; c=relaxed/simple;
	bh=BkonSwvBSVAeVSj+/yM8srRNCH2JQwmNT8fjAm5M6zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLKshNQJygilt7UV66G57QPkWMvM53BiIlx7bCrivAQ23KSHSLjeD5ATuj2qkrxGzVDfyjVTtg49fZnwAK3niiwYxqgIe1C29Cc/gYjwGM7SHX3hQmhWNdR+WXF6RogOGBI8xAfmqeprvVBFs8gnq+djeNH/R/Dyv48oGUUhEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f7Xz34JG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ed2333c8fso2659175e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706173165; x=1706777965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erSKDlQR5+PNHS3860P/F3Nu4Jwial5atVHAuQbFvdc=;
        b=f7Xz34JGnQd430h9kD6EFEyb4rllPrTiM+1kG/iH9PbzGUDMgLYnkyurB337Ne8nS1
         A4mmSWf59FDLXosdNjZ7arSXgp1DGran4RkkbEHdgJ6Lkx4jIFjSIUSfD5FflHXDpWx6
         XK4Ypi2e7Y6NZRRmGEzvCfg8dy9E2dxuFtt0IdUwNpKfMn0MlWojVc+0RaSHNORRY1wm
         j1tmYr943sanakZXVpGyDVDGOiDxZlZhRuWQ9DSLVd9uL6ZvvcxBHhzw4ETY4qRWkTBB
         HS4dnhen0Kb3hi3p6QYq6bf/UkQTk7og1kSzmFiFw7szfxRC7lghDwQv1DpcmTdCaxlR
         Q9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173165; x=1706777965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erSKDlQR5+PNHS3860P/F3Nu4Jwial5atVHAuQbFvdc=;
        b=vbVVjjkS0xFEZy62Y8hfUna8eaGtyWilnjIgYH6Lx5H/U+zmfoIEYKLcy4nlGqovbQ
         EutQ3RCUblBKUPzPngRe8QBbWfY60NH6j4Iad0zZ/IYaNpAih8jqFwH39Jw04h0XfAPj
         d+mJSTfh31VUh6cyPbQiolb4A+pNIKmzN0R3GAQjHz+imq3vmsbiu0u15uNY5d+9tn0m
         6sI36XreI4WR26fKfIk6I4SzbCgF9ODiYDGJ1uc+Ggv5fpXWlMyL2Zw8w3x53narnDsj
         hi5UnA1Nli4xhtiXUUtV/circlP/JVu6zq0OcqCPRuKXhOg++H6BB0WdVhymVQf8xdad
         ttTQ==
X-Gm-Message-State: AOJu0YyN96qZUkXI39EkC13W23GXo8PulwQgeCJxqG9aU1Gx6vApuuFD
	ZvzGjqddTXKS53UxqRGY6+pJUVp15eDql66SEBtBEi9dq+Hm0w5zFdf6PxFxmQm0yMwUMA5K371
	e
X-Google-Smtp-Source: AGHT+IE8NLFBdP26KgzjN7t3Eo6+D2rQKQrXWvEBi8qCf1k9BJWCKOFGza00RXHRn0+C9ey1X1qo3Q==
X-Received: by 2002:a05:600c:1c99:b0:40e:cc93:2f6b with SMTP id k25-20020a05600c1c9900b0040ecc932f6bmr311011wms.151.1706173164937;
        Thu, 25 Jan 2024 00:59:24 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7589:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7589:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b0040e5945307esm1786225wmo.40.2024.01.25.00.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 00:59:24 -0800 (PST)
Message-ID: <f6448d5a-c04a-4d8f-9672-a14aa3061c3e@suse.com>
Date: Thu, 25 Jan 2024 10:59:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/9] ntsync: Introduce NTSYNC_IOC_PUT_SEM.
Content-Language: en-US
To: Elizabeth Figura <zfigura@codeweavers.com>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: wine-devel@winehq.org, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Wolfram Sang <wsa@kernel.org>,
 Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-5-zfigura@codeweavers.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240124004028.16826-5-zfigura@codeweavers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24.01.24 г. 2:40 ч., Elizabeth Figura wrote:
> This corresponds to the NT syscall NtReleaseSemaphore().
> 
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> ---
>   drivers/misc/ntsync.c       | 76 +++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/ntsync.h |  2 +
>   2 files changed, 78 insertions(+)
> 
> diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> index 3287b94be351..d1c91c2a4f1a 100644
> --- a/drivers/misc/ntsync.c
> +++ b/drivers/misc/ntsync.c
> @@ -21,9 +21,11 @@ enum ntsync_type {
>   struct ntsync_obj {
>   	struct rcu_head rhead;
>   	struct kref refcount;
> +	spinlock_t lock;
>   
>   	enum ntsync_type type;
>   
> +	/* The following fields are protected by the object lock. */
>   	union {
>   		struct {
>   			__u32 count;
> @@ -36,6 +38,19 @@ struct ntsync_device {
>   	struct xarray objects;
>   };
>   
> +static struct ntsync_obj *get_obj(struct ntsync_device *dev, __u32 id)
> +{
> +	struct ntsync_obj *obj;
> +
> +	rcu_read_lock();
> +	obj = xa_load(&dev->objects, id);
> +	if (obj && !kref_get_unless_zero(&obj->refcount))
> +		obj = NULL;
> +	rcu_read_unlock();
> +
> +	return obj;
> +}
> +
>   static void destroy_obj(struct kref *ref)
>   {
>   	struct ntsync_obj *obj = container_of(ref, struct ntsync_obj, refcount);
> @@ -48,6 +63,18 @@ static void put_obj(struct ntsync_obj *obj)
>   	kref_put(&obj->refcount, destroy_obj);
>   }
>   
> +static struct ntsync_obj *get_obj_typed(struct ntsync_device *dev, __u32 id,
> +					enum ntsync_type type)
> +{
> +	struct ntsync_obj *obj = get_obj(dev, id);
> +
> +	if (obj && obj->type != type) {
> +		put_obj(obj);
> +		return NULL;
> +	}
> +	return obj;
> +}
> +
>   static int ntsync_char_open(struct inode *inode, struct file *file)
>   {
>   	struct ntsync_device *dev;
> @@ -81,6 +108,7 @@ static int ntsync_char_release(struct inode *inode, struct file *file)
>   static void init_obj(struct ntsync_obj *obj)
>   {
>   	kref_init(&obj->refcount);
> +	spin_lock_init(&obj->lock);
>   }
>   
>   static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
> @@ -131,6 +159,52 @@ static int ntsync_delete(struct ntsync_device *dev, void __user *argp)
>   	return 0;
>   }
>   
> +/*
> + * Actually change the semaphore state, returning -EOVERFLOW if it is made
> + * invalid.
> + */
> +static int put_sem_state(struct ntsync_obj *sem, __u32 count)

nit: Just a general observation - those functions that contains the 
specific type in their name could take the exact object i.e struct ntsem 
which will make the code somewhat more clear. Of course, this would mean 
that the struct definition in patch 3 should be changed to also contain 
a tag name.


