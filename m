Return-Path: <linux-kernel+bounces-93917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD328736E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64818284518
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46AF12C53C;
	Wed,  6 Mar 2024 12:48:52 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD4186633;
	Wed,  6 Mar 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729332; cv=none; b=ZWOA8tYFWtrjCZk3+bHy6o+lB3P/srOjTWuiDHz8v7EdW2zAxpqxmgR4D+sfDD5geYPiVjxt5s+K7ZvdmRyuwFs1TuR8aHEu+OlRcbWJlTeo/4az4WRwfW/0L3lfYYWy8C7YV1o8Alk/2DCa+TWcJatN+SoKtQTSzttHmH7z6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729332; c=relaxed/simple;
	bh=wlGohHDpnBrj0wgpAIDRF+sOdE3Grea/71eoCrrnR7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnWDJjs/i/YsNt4MgtZxYvJH4jfQt8e/X3NbhFA2hSWFzdA1Mol9yNvqJC5DE2eOMagh4Tr4Pco/EKmxtxVJyRoh+GTb/ti1QCHtZF1zL6RRT+DvBW+g1xFBB/FWtYLJBFoAfQGMq6nVTJxkPtEtC4WK0QmEnrDFz11wcexSTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a12d31d76fso233155eaf.1;
        Wed, 06 Mar 2024 04:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729330; x=1710334130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP/5Ot27QEzL5fa+CifSiDjHjpLcGRPWWefTTWARLbg=;
        b=dJUUBtkG10i5P5VYXAu1flLrLLB2ORgCVObgAjJ6wpb8hNrNKyor2P41EJFu9b85xO
         jgci4/q+bD0pwbY7PhtvKxFe1roKnYdYy5fRknEFhyVXJTcANqyS6mCPDmKPj2uh0fgr
         J9LtqZ0LymPSrMg+rE8R2EQVZKaOyDCiT+vAIonxJC7GlZHz+pno8zbGX0arGrMFsUp6
         bvgxwA2Vpl2BuNiKVLqY2+htNOy9Y7MTV3UqpVTWvi6qITXMolIgjxmCOp8FQVFSgQdW
         jtR2Tyw0RJ9hegHtBzucSpF1fUbjl+HN1LkeDre96rGvw0EGg2qZwdEJFX/2MIr1unJy
         kyuw==
X-Forwarded-Encrypted: i=1; AJvYcCWOdeq5/lrBFRf2xS15GLSNVdmjaGYiYMt5ybWQVknJDPmkTcf/Sy98sS43jbfn9geEIGD/1vuUbKmDiNroqwdGkgpv4eD7K4IC9bwpjSzdBecPwY33B5mPSDiMaHX3sdoCyPZTGebrgD/GI88t4KuoPYGTQXprQ6VItIOAf08HsA==
X-Gm-Message-State: AOJu0Yz33PrEwG3fgJTEg3Tld73mveyhlfYRmZVAcKNQsqwCLIF8JbMG
	iWac3xMDds5q4h2EB2X64+xrDGHCuGvLI3nf1Fc57h2bzXJIJY0eCLBZjgsvbk9LtnBz019qFxb
	iflg87SrYlJJvD/9ZmQkJY16CMJqyrqCUncY=
X-Google-Smtp-Source: AGHT+IFOSiOuLUOZQcQo0g8hUxeZFz2G8KiRlGAKh3P8Q5/l8fxKsdIGS4MdnPN9gNEMDjV9oS2Wk039Uekgzgm9piU=
X-Received: by 2002:a05:6871:a909:b0:220:a82a:a4ef with SMTP id
 wn9-20020a056871a90900b00220a82aa4efmr3894754oab.3.1709729329401; Wed, 06 Mar
 2024 04:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085007.169771-1-herve.codina@bootlin.com> <20240306085007.169771-2-herve.codina@bootlin.com>
In-Reply-To: <20240306085007.169771-2-herve.codina@bootlin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Mar 2024 13:48:37 +0100
Message-ID: <CAJZ5v0gENrBFfJ3FDJ=m0-veFbue_Bw168+k2cs7v2u9MtCT8Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] driver core: Introduce device_link_wait_removal()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 9:51=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> introduces a workqueue to release the consumer and supplier devices used
> in the devlink.
> In the job queued, devices are release and in turn, when all the
> references to these devices are dropped, the release function of the
> device itself is called.
>
> Nothing is present to provide some synchronisation with this workqueue
> in order to ensure that all ongoing releasing operations are done and
> so, some other operations can be started safely.
>
> For instance, in the following sequence:
>   1) of_platform_depopulate()
>   2) of_overlay_remove()
>
> During the step 1, devices are released and related devlinks are removed
> (jobs pushed in the workqueue).
> During the step 2, OF nodes are destroyed but, without any
> synchronisation with devlink removal jobs, of_overlay_remove() can raise
> warnings related to missing of_node_put():
>   ERROR: memory leak, expected refcount 1 instead of 2
>
> Indeed, the missing of_node_put() call is going to be done, too late,
> from the workqueue job execution.
>
> Introduce device_link_wait_removal() to offer a way to synchronize
> operations waiting for the end of devlink removals (i.e. end of
> workqueue jobs).
> Also, as a flushing operation is done on the workqueue, the workqueue
> used is moved from a system-wide workqueue to a local one.
>
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")

No, it is not fixed by this patch.

In fact, the only possibly observable effect of this patch is the
failure when the allocation of device_link_wq fails AFAICS.

> Cc: stable@vger.kernel.org

So why?

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/base/core.c    | 26 +++++++++++++++++++++++---
>  include/linux/device.h |  1 +
>  2 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d5f4e4aac09b..48b28c59c592 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
>  static void __fw_devlink_link_to_consumers(struct device *dev);
>  static bool fw_devlink_drv_reg_done;
>  static bool fw_devlink_best_effort;
> +static struct workqueue_struct *device_link_wq;
>
>  /**
>   * __fwnode_link_add - Create a link between two fwnode_handles.
> @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *dev)
>         /*
>          * It may take a while to complete this work because of the SRCU
>          * synchronization in device_link_release_fn() and if the consume=
r or
> -        * supplier devices get deleted when it runs, so put it into the =
"long"
> -        * workqueue.
> +        * supplier devices get deleted when it runs, so put it into the
> +        * dedicated workqueue.
>          */
> -       queue_work(system_long_wq, &link->rm_work);
> +       queue_work(device_link_wq, &link->rm_work);
>  }
>
> +/**
> + * device_link_wait_removal - Wait for ongoing devlink removal jobs to t=
erminate
> + */
> +void device_link_wait_removal(void)
> +{
> +       /*
> +        * devlink removal jobs are queued in the dedicated work queue.
> +        * To be sure that all removal jobs are terminated, ensure that a=
ny
> +        * scheduled work has run to completion.
> +        */
> +       flush_workqueue(device_link_wq);
> +}
> +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> +
>  static struct class devlink_class =3D {
>         .name =3D "devlink",
>         .dev_groups =3D devlink_groups,
> @@ -4099,9 +4114,14 @@ int __init devices_init(void)
>         sysfs_dev_char_kobj =3D kobject_create_and_add("char", dev_kobj);
>         if (!sysfs_dev_char_kobj)
>                 goto char_kobj_err;
> +       device_link_wq =3D alloc_workqueue("device_link_wq", 0, 0);
> +       if (!device_link_wq)
> +               goto wq_err;
>
>         return 0;
>
> + wq_err:
> +       kobject_put(sysfs_dev_char_kobj);
>   char_kobj_err:
>         kobject_put(sysfs_dev_block_kobj);
>   block_kobj_err:
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1795121dee9a..d7d8305a72e8 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1249,6 +1249,7 @@ void device_link_del(struct device_link *link);
>  void device_link_remove(void *consumer, struct device *supplier);
>  void device_links_supplier_sync_state_pause(void);
>  void device_links_supplier_sync_state_resume(void);
> +void device_link_wait_removal(void);
>
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
> --

