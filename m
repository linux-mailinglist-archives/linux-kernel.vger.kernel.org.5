Return-Path: <linux-kernel+bounces-86451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F386C595
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C3B1F226EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668E360B96;
	Thu, 29 Feb 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcH5MkOe"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA95D730;
	Thu, 29 Feb 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199604; cv=none; b=mGZ8YsE/WxhKB1Qopf/xGGNbJjQH4Yf2FRqcOEukVRfaTtIiQtvCpMSgFZCErbPqZUZTT50LXK77QTTEa6rFLnQJ5Z9Rg57FuPR1HLdAPEtkAxk9H/VeA3V/BuGPo7qiYrqlcr4Hh/z8R2w32B1i05krHXwM98r8bfjlB1n23dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199604; c=relaxed/simple;
	bh=0UKCb2lsR+XxnPaxGeZX/DBqYYTPVJe9H29vJBMK504=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHV8Rq15vcIoqzscU52g7lL8UsNCYRHcANjwTAGB620cgjkSFrJWP+K2MCKSkV63pd1w/x1kgLq6uvoXXdMyvsS7rgXSlTQ1XiasclPO7yDIUwFdHS9CE7WHZJGUxZd0i5FBfoNCecXtpBHAXc1sfuLH8fcImpcK/xqOUFFOuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcH5MkOe; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4348aaa705so102590266b.0;
        Thu, 29 Feb 2024 01:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709199601; x=1709804401; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W5RaMz9HxkBQ/QHEsUPFP9mvPuXWXa71kO8GRgXAWv0=;
        b=hcH5MkOevdmuQJHXrItLjLsoCzzgG56NlJq3XZAG3lmg605mFbC0qDUDASRkJR9FaR
         7Ai73Rn1Pqr9yg0Ftq0ypFmPkjVkrw/ONCPIM15AbJGj/JuCclMtyU+Qpzyyk0wk1Wsp
         ER+kNNW0dQfeBE3P4if+n4NkaH/jUPnGUQqviiTuaNHZ48pfu3dfCupebgJZ3rHxXHLn
         3zGEbyXj5+8BNrmMhIjF8gwDaEmN9KzOGbKP2GfhqK1uolVCrOQQ73N9tix0Od302H6r
         qghIk3M3Dp+IQ+gFYCsQduwz3/jR9Vvw+MGcDEuE7sHhYZbS6ZbOhxpqBuJK108qvdqg
         Ui3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199601; x=1709804401;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5RaMz9HxkBQ/QHEsUPFP9mvPuXWXa71kO8GRgXAWv0=;
        b=nmT6SRa+x8iK6PxYQZFhQ0vw49KJVZLR+XLD8/1tagi3+b28f2rJ3hOm/1jkhbvs9r
         v/KnOtEA37hw3+BdSVUGzsNnNZC1qw4GClQLpwIe59s8ufT7eIl7QN8FJ0qrmaTvRrfA
         8AiP0B4YlJ8xoKWOtLXNlgHRRjY3ZagNQ9CRPRx79IRlesnklvPwuuTrhMURgXF4bmV+
         2uwKokEUEX5z+bFEuqosz2u430zdlnxyl0BVL5Px4229kfrF6mSOImNZIvhdMSnAnR2X
         iQN2CZwP2mmkQ0QWuaTtoAxuNRv8xYZX0xMPOykJCUvYma7LGEnmkMeJVmTRDSVTcHqc
         NY9A==
X-Forwarded-Encrypted: i=1; AJvYcCUBPeiEVYkZ5YKahnw7Z7ZkHVwo3WieZd6iet5wXrSjI+6JVUjaZi6CPES7F7VTqBfn4W+p6nMxdIo0P49tkyyqoYm+BiGVxE9rQ7Ijj7t69518RDvcxK5rmcf7mLR7SE2dDn5Y3biY50RVMRmJYcNZrQ0jwTWu6g+nPuN87kl75A==
X-Gm-Message-State: AOJu0YyNO+NQmGOsKtWvTejut2bB4kYX2zN7Sd+CNnR+sIOotsnDqrTE
	BtOP/1XTqZ2CbvREUwc1R8BvSFyImEEvUcxfUDGaJsg/t1wWQXpd+vG6MDh+e+i8GQ==
X-Google-Smtp-Source: AGHT+IEx1bdt9xdFXjYVJpodkVY8N8Wlwq6xxgxsW4QcuPFlKd3xWJnzzdX6sT/izTTeTXpQtF2HXg==
X-Received: by 2002:a17:906:a411:b0:a44:442d:89b3 with SMTP id l17-20020a170906a41100b00a44442d89b3mr761919ejz.48.1709199600765;
        Thu, 29 Feb 2024 01:40:00 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id ty8-20020a170907c70800b00a3ed975968esm500653ejc.28.2024.02.29.01.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:40:00 -0800 (PST)
Message-ID: <1265e6ed0e0f5030d633290062f7267621b5bec2.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
	Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Thu, 29 Feb 2024 10:43:24 +0100
In-Reply-To: <20240229083953.607569-2-herve.codina@bootlin.com>
References: <20240229083953.607569-1-herve.codina@bootlin.com>
	 <20240229083953.607569-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Herve,

Thanks for moving this forward... Couple of comment

On Thu, 2024-02-29 at 09:39 +0100, Herve Codina wrote:
> The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> introduces a workqueue to release the consumer and supplier devices used
> in the devlink.
> In the job queued, devices are release and in turn, when all the
> references to these devices are dropped, the release function of the
> device itself is called.
>=20
> Nothing is present to provide some synchronisation with this workqueue
> in order to ensure that all ongoing releasing operations are done and
> so, some other operations can be started safely.
>=20
> For instance, in the following sequence:
> =C2=A0 1) of_platform_depopulate()
> =C2=A0 2) of_overlay_remove()
>=20
> During the step 1, devices are released and related devlinks are removed
> (jobs pushed in the workqueue).
> During the step 2, OF nodes are destroyed but, without any
> synchronisation with devlink removal jobs, of_overlay_remove() can raise
> warnings related to missing of_node_put():
> =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2
>=20
> Indeed, the missing of_node_put() call is going to be done, too late,
> from the workqueue job execution.
>=20
> Introduce device_link_wait_removal() to offer a way to synchronize
> operations waiting for the end of devlink removals (i.e. end of
> workqueue jobs).
> Also, as a flushing operation is done on the workqueue, the workqueue
> used is moved from a system-wide workqueue to a local one.
>=20
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 +++++++++++++++++++++++-=
--
> =C2=A0include/linux/device.h |=C2=A0 1 +
> =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d5f4e4aac09b..80d9430856a8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> =C2=A0static void __fw_devlink_link_to_consumers(struct device *dev);
> =C2=A0static bool fw_devlink_drv_reg_done;
> =C2=A0static bool fw_devlink_best_effort;
> +static struct workqueue_struct *device_link_wq;
> =C2=A0
> =C2=A0/**
> =C2=A0 * __fwnode_link_add - Create a link between two fwnode_handles.
> @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *dev)
> =C2=A0	/*
> =C2=A0	 * It may take a while to complete this work because of the SRCU
> =C2=A0	 * synchronization in device_link_release_fn() and if the consumer=
 or
> -	 * supplier devices get deleted when it runs, so put it into the
> "long"
> -	 * workqueue.
> +	 * supplier devices get deleted when it runs, so put it into the
> +	 * dedicated workqueue.
> =C2=A0	 */
> -	queue_work(system_long_wq, &link->rm_work);
> +	queue_work(device_link_wq, &link->rm_work);
> =C2=A0}
> =C2=A0
> +/**
> + * device_link_wait_removal - Wait for ongoing devlink removal jobs to
> terminate
> + */
> +void device_link_wait_removal(void)
> +{
> +	/*
> +	 * devlink removal jobs are queued in the dedicated work queue.
> +	 * To be sure that all removal jobs are terminated, ensure that any
> +	 * scheduled work has run to completion.
> +	 */
> +	drain_workqueue(device_link_wq);

I'm still not convinced we can have a recursive call into devlinks removal =
so I
do think flush_workqueue() is enough. I will defer to Saravana though...

> +}
> +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> +
> =C2=A0static struct class devlink_class =3D {
> =C2=A0	.name =3D "devlink",
> =C2=A0	.dev_groups =3D devlink_groups,
> @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> =C2=A0	sysfs_dev_char_kobj =3D kobject_create_and_add("char", dev_kobj);
> =C2=A0	if (!sysfs_dev_char_kobj)
> =C2=A0		goto char_kobj_err;
> +	device_link_wq =3D alloc_workqueue("device_link_wq", 0, 0);
> +	if (!device_link_wq)
> +		goto wq_err;

I still think this makes more sense in devlink_class_init() as this really
device link specific. Moreover, as I said to Saravana, we need to "convince=
"
Rafael about this as he (in my series) did not agreed with erroring out in =
case
we fail to allocate the queue.

Rafael?

- Nuno S=C3=A1


