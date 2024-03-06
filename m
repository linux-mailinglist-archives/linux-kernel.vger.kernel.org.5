Return-Path: <linux-kernel+bounces-94609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C2874216
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B756CB2304D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3ED1AADA;
	Wed,  6 Mar 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCzyRXE1"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395301B7F7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760973; cv=none; b=c7/2u5a2VP0/db7WHOsT5Toc375DVmaIyi85uQ6kxQ1YxG/2jAJeej6Olrsp3yUALuGAGO0sHw8qKt1haz0t06DtVVNdg2Z5QGqwiMKIcDXy18BHT047LkSb4N6oeG1QuMaFcs/bX8mhtEyz0Jc/BcCuKp/5FvnExRBMqyiIXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760973; c=relaxed/simple;
	bh=YlaGW5DIfQikcv1Ey1OaeroVdJnLORWMXlwJte/PfRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0n/ZwbXQY+6jjCQ+vYH1BzW1pQo/GWdM3U5dLzkZh00TX5bUXjgQc1EuvHTmG9HAC6VjBbKtGQ14N++HHgdDe3d5o0XwOgNZR4JlqJ+NUdKikAv8nQkHkiCyOlUOBZyCiyJFM43odpOUpb2GKX6XHIX8U5jY3do+H5Se+r2PlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCzyRXE1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so16631cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 13:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709760971; x=1710365771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuRty+lhYaNXcOtehTNWQ8+EoEDd7pkrwovTsDUb2fg=;
        b=zCzyRXE1Zr7e75wrVh48ChI+p1UJOMsk9luj9Tyz+QO/gUDqTZfG0an1k0tQw3ntgI
         xj/Fj/1VpxCFslkqhmUY521Xs1CeslrMW51VNH3JuJju3saRWa+iArhICPb8PO13FTe8
         KM4VENUeaG2kaS49iB4yH4yY3OySGQs/3mA8sNnURBMTS7SqNnvf+dhEvl4cNJ5Fduqy
         XN4VdWB3/WiyN3I4D4Hd+3pSX6BsW9Wtva35sk76483Yob2ekAEbPV6MvFPs3js2Jwul
         8wODDKlThoDfOckOxB+l0h/3VVZw7QktB9CNhSRL6byZyb2KyBf/YTZdEmllJdZQufGp
         XeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709760971; x=1710365771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuRty+lhYaNXcOtehTNWQ8+EoEDd7pkrwovTsDUb2fg=;
        b=KFpj+yMtsIPGv5kCrfFG66EJ3yUAWajXAIvSp17MA5/sRabSRAXhzvtnt5uF1JLsLX
         COAAhhDk1mZWvuiB5zyDS3rZwRMWRvS4PdnNS5H6SKfoWE5z8L2vGe+UkWZJ+7mWPxyC
         ZzkD9AtQDbVx7jwfQHb0Ykj+g6jOMw9n5aN/ZQCkrzaY8p9hnOMi0aR6JSHL+W8MCKUr
         wcS+9iTyJqHty3FumBiqNBw4BVX7aEGmYFKJO9temQ/mq2ph47g8GbcdeccLZWGNEnoI
         m41Lkdyj2wQunluraTGNlWloyr6DKHslCwcNeoITXR11oEP+5TWl1niEURwmXfFIk6mT
         Aa3w==
X-Forwarded-Encrypted: i=1; AJvYcCV0QTJIem2U4A7dGX3JDlBiu/NKwJwW/ubPFK0sXUO1Zb6FDbTGRvmr5JWXAyZM9DGWwmqA4aQtZD/UTGuAwPncJGkU+1VJkvlySXan
X-Gm-Message-State: AOJu0YxzPjbGqlM/kr8SdOG3b4835jitURQfFWfBAO3WjtMKRlDAp8Jj
	YsgaGpFiJiF18di7uUsf3M5/1oCeiDJ9JS5OMl2jVnMCVY9ugenBklkuEIlTbRksJ+XjdGkGX9R
	Eh3ac5Nv5kPmFqXzUYS34eZEaBRONXxvXBt4G
X-Google-Smtp-Source: AGHT+IHlc4s/s/55ElUaUz3cVLVdAQgf0cVgD2Lgnr2hgoE30sFPrSs46+Kf7Q5rU7kI/xgLWqRerx7iktLxcbQX/no=
X-Received: by 2002:ac8:5f4c:0:b0:42f:a3c:2d51 with SMTP id
 y12-20020ac85f4c000000b0042f0a3c2d51mr132826qta.18.1709760970984; Wed, 06 Mar
 2024 13:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085007.169771-1-herve.codina@bootlin.com> <20240306085007.169771-3-herve.codina@bootlin.com>
In-Reply-To: <20240306085007.169771-3-herve.codina@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 6 Mar 2024 13:35:31 -0800
Message-ID: <CAGETcx9RFS7Z61FeCYXMxRSDXnMYhg_y96dgtbHp-3t_9x8+SA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] of: dynamic: Synchronize of_changeset_destroy()
 with the devlink removals
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 12:51=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> In the following sequence:
>   1) of_platform_depopulate()
>   2) of_overlay_remove()
>
> During the step 1, devices are destroyed and devlinks are removed.
> During the step 2, OF nodes are destroyed but
> __of_changeset_entry_destroy() can raise warnings related to missing
> of_node_put():
>   ERROR: memory leak, expected refcount 1 instead of 2 ...
>
> Indeed, during the devlink removals performed at step 1, the removal
> itself releasing the device (and the attached of_node) is done by a job
> queued in a workqueue and so, it is done asynchronously with respect to
> function calls.
> When the warning is present, of_node_put() will be called but wrongly
> too late from the workqueue job.
>
> In order to be sure that any ongoing devlink removals are done before
> the of_node destruction, synchronize the of_changeset_destroy() with the
> devlink removals.
>
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/dynamic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 3bf27052832f..169e2a9ae22f 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -9,6 +9,7 @@
>
>  #define pr_fmt(fmt)    "OF: " fmt
>
> +#include <linux/device.h>
>  #include <linux/of.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> @@ -667,6 +668,12 @@ void of_changeset_destroy(struct of_changeset *ocs)
>  {
>         struct of_changeset_entry *ce, *cen;
>
> +       /*
> +        * Wait for any ongoing device link removals before destroying so=
me of
> +        * nodes.
> +        */

Not going to ask you to revise this patch just for this, but this
comment isn't very useful. It's telling what you are doing. Not why.
And the function name is already clear on what you are doing.

Maybe something like this would be better at describing the "why"?
Free free to reword it.

When a device is deleted, the device links to/from it are also queued
for deletion. Until these device links are freed, the devices
themselves aren't freed. If the device being deleted is due to an
overlay change, this device might be holding a reference to a device
node that will be freed. So, wait until all already pending device
links are deleted before freeing a device node. This ensures we don't
free any device node that has a non-zero reference count.

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

> +       device_link_wait_removal();
> +
>         list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
>                 __of_changeset_entry_destroy(ce);
>  }
> --
> 2.43.0
>

