Return-Path: <linux-kernel+bounces-30132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7378C831A25
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDCE1F23725
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A822554A;
	Thu, 18 Jan 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qRGqsq+1"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555CC250EF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583504; cv=none; b=M/HuH8XXw5t4FKpce+AXcpnBxTaX301N1gdNR4faBfk50xC8D1OZLGruZkN2UoLWCf/j6r4tYSFZ22MnuDvTiFvGXNiS01t//L5pg3Li5qCbgl45V3Eu72fPW+vLVvGTWoTrdU1rxs6U1QJKa0HHcIjzS+dMGbRzAdOxEw/UGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583504; c=relaxed/simple;
	bh=n++XuhRB4EVG1dnVu6UFfzLPoEhlNslsnkhQrRbhM9k=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=EKzvhF8933eBbUM+o2Z4i0BVLXXwWJ1Y0NOyWPK0jEU0btM2YaIGebkf91NQnGLvms5ouiULW/7UMzewbexZpzAcfSDE4RJKLQ4I8w7Eta1kQoEO3vGVEIh1pvZnXz3M6LERPExR2J0d1OTVgB3/t7TtntYYi0C4iuqYscK6Kig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qRGqsq+1; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d2c21d77afso356270241.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705583501; x=1706188301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHW8mrwPYeD3SY8y17cH7gnw3XovI7cNYSvj0nnf3+8=;
        b=qRGqsq+1bJuMzygpcPUnex5SggsPvLRZYTJseFdBGyl4S/GAZKSuc7bdKJ4EjIdPmO
         hdJbXf83QFKgssHvoAAGG1ZyqA9VDp1iB5g/O1pI+5UQvDmBCffzWB9C4FkEJyXknb98
         Ez0ibwxLiYz6GZ0QwMFqKfE0SPZlmRIKIZifWQ2sQrJ6buPgp1eHUrtQiUxRrKE0LXLf
         zHVOuqd704GbXXI28ckuPnx5KtXwNCjiGA+Xo3bonHuN+rwkj+srZUVeG31S8zky+GxE
         8OsymlU/9SdFKfojInsqMLnOYxQvE8J2YHnaNHmTl7QbL5IOG5UfKpFP2uT9RyllV1Ke
         ilMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705583501; x=1706188301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHW8mrwPYeD3SY8y17cH7gnw3XovI7cNYSvj0nnf3+8=;
        b=QbxrrvkjmgmimdnqwCPVSpYzK+MMYXxmiaUArdTfvgDVXyo8iYYJeI28CtvJed2NMf
         AVUjm4xRGWAJGFPonqzpdsxAfUsMlI4W9k1aqo45sxC4DVjUVRsv3XLtq5aY7VPQoDZV
         9+ONwh/qImDO8b1TlWZjPEEu+by1d7RsbfJjd1zD6kDyKFHx6QY/nHe9E1FOhAYYyvDX
         1cvsXassf+gcztzfJVh6VMRQsFoX4/RSWaGkMIbfUAWmdLFMkecLXB194NX38D8GRlgz
         +6hepwz+FOGV7P/e3H8nQDC/8ExxUQjSFrSXo8+TNRvwF5zBa5loi0y3qNfMPqvPxD9O
         6eTQ==
X-Gm-Message-State: AOJu0Yz/7TwoHZk9JuxCPJZeuogSuoPNxlUHlT3MVoRRTJ0VoXroZZlw
	rLgCp8dzxd9S/EufVUJ7g10wFfiO178oysLOevsRYNQmBH/zAWEEtBKxjPWx+h6pBB7hQewbsAp
	4wom6O87KmFcUlOOLOZLkHpxKcqwROvwnJ5YH8g==
X-Google-Smtp-Source: AGHT+IGTGw8HnvT5D8+nH/KgquXG/RE7XEsMEneP3Lg56sqfViwsfnFVV4sR0gvqRyQwQNymy/UlduMSCG1+S/3he4Q=
X-Received: by 2002:a05:6122:128b:b0:4b7:2c46:32bb with SMTP id
 i11-20020a056122128b00b004b72c4632bbmr1337533vkp.13.1705583501195; Thu, 18
 Jan 2024 05:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <20240117160748.37682-5-brgl@bgdev.pl>
 <65a7feb3ea48f_3b8e294bf@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65a7feb3ea48f_3b8e294bf@dwillia2-xfh.jf.intel.com.notmuch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Jan 2024 14:11:30 +0100
Message-ID: <CAMRc=McUdR5oVEpbwXF+Sc1OaEtYH-UCv0ScFwrbGyWtyh8W0A@mail.gmail.com>
Subject: Re: [PATCH 4/9] PCI: create platform devices for child OF nodes of
 the port node
To: Dan Williams <dan.j.williams@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 5:22=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > In order to introduce PCI power-sequencing, we need to create platform
> > devices for child nodes of the port node. They will get matched against
> > the pwrseq drivers (if one exists) and then the actual PCI device will
> > reuse the node once it's detected on the bus.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [..]
> > diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> > index d749ea8250d6..77be0630b7b3 100644
> > --- a/drivers/pci/remove.c
> > +++ b/drivers/pci/remove.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/pci.h>
> >  #include <linux/module.h>
> > +#include <linux/of_platform.h>
> >  #include "pci.h"
> >
> >  static void pci_free_resources(struct pci_dev *dev)
> > @@ -18,11 +19,11 @@ static void pci_stop_dev(struct pci_dev *dev)
> >       pci_pme_active(dev, false);
> >
> >       if (pci_dev_is_added(dev)) {
> > -
> >               device_release_driver(&dev->dev);
> >               pci_proc_detach_device(dev);
> >               pci_remove_sysfs_dev_files(dev);
> >               of_pci_remove_node(dev);
> > +             of_platform_depopulate(&dev->dev);
> >
> >               pci_dev_assign_added(dev, false);
>
> Why is pci_stop_dev() not in strict reverse order of
> pci_bus_add_device()? I see that pci_dev_assign_added() was already not
> in reverse "add" order before your change, but I otherwise would have
> expected of_platform_depopulate() before of_pci_remove_node() (assumed
> paired with of_pci_make_dev_node()).

The naming here is confusing but the two have nothing in common. One
is used by CONFIG_PCI_DYNAMIC_OF_NODES to *create* new DT nodes for
detected PCI devices. The one I'm adding, creates power sequencing
*devices* (no nodes) for *existing* DT nodes.

So the order is not really relevant here but I can change in v2.

Bartosz

