Return-Path: <linux-kernel+bounces-118844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DABE88C01D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE43D2E4042
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD19321B4;
	Tue, 26 Mar 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXONSIlQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBA3C30
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451128; cv=none; b=CDKr+7H1NLx7FvTOfqyxME8mn1EiexVljUcr/qm0Vh+VGmj6gzz1FN4hVHbI3AuCZof+E4IAiiqKk0oYQO1K2+y7bWKWg/WRrqJvS0usM85L2boOe0bOi5B2F4xjp7yS4Dwlgpoh6hxm9QuIm50m72RBvJ5J9jJc7FeF3MyJAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451128; c=relaxed/simple;
	bh=Tu8LJ1+CQi0lJJMWJK5Tv7gRGqoNUunnGIQubTe3NW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJZp6n1NVaCyRaQoI0I4Z07YSSBOfP1FK9C853Gri/ijv58t36YxqBS2FpM7O7nstQ9GAbC7fYMy+l2c39O8Rn5Znrfb//Cbrp3ZKqNlSnjOUJIZkrKWjkwyFZeS8wtbNWClhuGS+aLK5dEWSnlO1HVEilqov2vo3JqsMk0jEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXONSIlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0941C433C7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711451127;
	bh=Tu8LJ1+CQi0lJJMWJK5Tv7gRGqoNUunnGIQubTe3NW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lXONSIlQRtjuiiZN/kBSZB7hD0uXPwtjFf0PDxrGx/ADtNUsVYkdgybVxBiLR2UGU
	 bL5ZiBjz8KHTRYawKYWLcQ2q0YTadL4QG+3jAviSbIG9NQ4Z+B8w2rVKBxaZ1c2yHI
	 k0vpeMppFoN50PWh2+Rz+qm044gbmq1Mq/lsrzphVezTIdUiZogDjvm51zFUi4cslA
	 R7H2HX+Q9o3fIW1RWhv/s/UrWH2Cgi8wKJhbyI2SXQGc9NySPTMme9APP+BXdVwKpA
	 6JERI2dRkx7I8Fjbr1Uy5/KemP93tvsziZ20o1f8Mh1cC4kH11B8hkIGYqLexjmlz3
	 e+ZcFg1N0RvjQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a46ad0d981so1255607eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:05:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmaYeqSoZuLQxJ10Hnm5EiZx32cNzz1bxh1yh/pr7AdNybUxgJ7S8fHTzYlCN/PXoTY8O9hC7+tZ7PnsTIGmAGQAF2u0Bf6GXXRrJ9
X-Gm-Message-State: AOJu0Yz5Lk468D8wsQsWO6C5CZLUHG1cgoijc0hs+zjFciJDZq9jIxoB
	bxjoeeo1mJXMjfSwkj4zh3mmUB8klz9vqYOtETNsFL8/guXJxxaXCXCc4WpKfHpOHyMtHPejiin
	VPr31Yj08yjHJgtnWgRx8730kMhA=
X-Google-Smtp-Source: AGHT+IFfsBnh1dnEs5fHJzLKuCcQMoXcD2qU+zZNrwyD9E0zwoKMsFJYX/wg/Qi/qUpIca7wezahHw8MbVu8BVvWb4Y=
X-Received: by 2002:a05:6820:b91:b0:5a5:5ed9:b246 with SMTP id
 eg17-20020a0568200b9100b005a55ed9b246mr3885758oob.0.1711451127200; Tue, 26
 Mar 2024 04:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325221409.1457036-1-helgaas@kernel.org>
In-Reply-To: <20240325221409.1457036-1-helgaas@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Mar 2024 12:05:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hEAWQf+SXjsYt92xrF-8M2PUVGod2b97gBBFTKiv+UFg@mail.gmail.com>
Message-ID: <CAJZ5v0hEAWQf+SXjsYt92xrF-8M2PUVGod2b97gBBFTKiv+UFg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Remove unused platform_notify, platform_notify_remove
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 11:14=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The "platform_notify" and "platform_notify_remove" hooks have been unused
> since 00ba9357d189 ("ARM: ixp4xx: Drop custom DMA coherency and bouncing"=
).
>
> Remove "platform_notify" and "platform_notify_remove".  No functional
> change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c    |  8 --------
>  include/linux/device.h | 11 -----------
>  2 files changed, 19 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b93f3c5716ae..78dfa74ee18b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2331,8 +2331,6 @@ static void fw_devlink_link_device(struct device *d=
ev)
>
>  /* Device links support end. */
>
> -int (*platform_notify)(struct device *dev) =3D NULL;
> -int (*platform_notify_remove)(struct device *dev) =3D NULL;
>  static struct kobject *dev_kobj;
>
>  /* /sys/dev/char */
> @@ -2380,16 +2378,10 @@ static void device_platform_notify(struct device =
*dev)
>         acpi_device_notify(dev);
>
>         software_node_notify(dev);
> -
> -       if (platform_notify)
> -               platform_notify(dev);
>  }
>
>  static void device_platform_notify_remove(struct device *dev)
>  {
> -       if (platform_notify_remove)
> -               platform_notify_remove(dev);
> -
>         software_node_notify_remove(dev);
>
>         acpi_device_notify_remove(dev);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 97c4b046c09d..c515ba5756e4 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1206,17 +1206,6 @@ int __must_check devm_device_add_groups(struct dev=
ice *dev,
>  int __must_check devm_device_add_group(struct device *dev,
>                                        const struct attribute_group *grp)=
;
>
> -/*
> - * Platform "fixup" functions - allow the platform to have their say
> - * about devices and actions that the general device layer doesn't
> - * know about.
> - */
> -/* Notify platform of device discovery */
> -extern int (*platform_notify)(struct device *dev);
> -
> -extern int (*platform_notify_remove)(struct device *dev);
> -
> -
>  /*
>   * get_device - atomically increment the reference count for the device.
>   *
> --
> 2.34.1
>

