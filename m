Return-Path: <linux-kernel+bounces-59671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893584FA2F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B261F2151B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A817BAF3;
	Fri,  9 Feb 2024 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huopN3AH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1876415
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497404; cv=none; b=oGylf/0KzJJdXesgUyOi8xM/iNCBOVBIv0RqlRw0Vqd8kZB20W5ulPHqLjNVEee6ovMbc9f0WX7n+3ckfCR0k83x+wY0O67rghbri/pFQFphLbDjiokx6L7yjPtNUJ43ONbsSth85y/JrjAaBYXo7M67cbgVWC43NFjq0oEgjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497404; c=relaxed/simple;
	bh=lcEncMjWx1cHj3mi+d6/pRmr14bUoDw+wvvYprditqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbePpbj74JH+aVyARILMQNyQwS7YOmH1jc5++8HhujdW3eSJ6EDBZXgCMSxljmWloNXB/IvtjsRUvsuyCs8mv4W3cLefSjs6kXLx4JIC4oYxE2psW7aRN+Ku1qJVpZV74PnmAhYFt7cMH5ZHROA9QoNstYKFgPIKPsCMyL+rTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=huopN3AH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707497401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iv56PqPnsvTXTwarveHsnRnFq5SGF+BFGaQ7j/GRxRk=;
	b=huopN3AH0CGe1fN7lpVFAmoVawQTr7MEbV04Lf27vCCKXwQIQcrBaDFcPSWMO9Rp7FqpLQ
	mnasFEyw152eadu4cpPt/ZR5w/Rp0+VSAtDsmtU2S7YRursqWuWhIGE8+RCibY4sJhbchX
	zc3ExaVju5i57fTodTM1/W4elUhLxRg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663--pvn5MnoMbm5fuS_HsDE7w-1; Fri, 09 Feb 2024 11:49:59 -0500
X-MC-Unique: -pvn5MnoMbm5fuS_HsDE7w-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cec090b2bdso1039341a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497399; x=1708102199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iv56PqPnsvTXTwarveHsnRnFq5SGF+BFGaQ7j/GRxRk=;
        b=fv4CpdRmfvOxRwObVlQUI4FRePSd1vrIu0yCTHF6sA5QEhtYwm2KicocWAbFPF3B37
         8Ug90FnsWZBSeGcW0wlbg09eNWfyL5+jm9noW/SSjMHY9tYQd3emVZfvgX4OYKr0ea3b
         WzMU7aaEhLurlejf8uBa5xJC+h865w29hcC48b3K4sdhTibUC+6eeAut/GbuafhVyEMr
         htdUYhCKUr4y3BtUfcyRYsOhNMUo+a3D5mKHTse+McAC73lgvgLmEhDDTg+aKEMC+9tz
         UDmfT/4urH2VKn7IviQ+5RisM3gtcq126vYUseVzFLgzEvNfHXm2BJRrfTlLO/Fhz+8/
         9EvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNEU39WhLZDhtim+kXJeCxrDxwEuP417p+wpqM0SqiU3zRVfGSwse3ta3fEU7H79EmLsGElwp6wLMGnZkp1obj1YIbVCyc54rsJoWb
X-Gm-Message-State: AOJu0Yz4KkB5Til2/sJIWQb6Vx5SZjW7lWbzwcJw1IR3pM/LoN60NjRa
	aiDwkoDlhzoxXtnapVHF3qb2A+gtl1jHpmUg750rqAX5OL25EM7+WbBXuEAqROEUPr6CAwH2fzl
	cWTxkmuq2o4ststNVJs68YDvebpZMwZLIxMWBKH+tODXQEUCsDJPmpE9fcOuXkw4gzpDePUzdjs
	4yKXbefq7MDudqkM7elk+s+iQDTdYVlSsIecCB
X-Received: by 2002:a17:90b:4014:b0:295:fe86:ad25 with SMTP id ie20-20020a17090b401400b00295fe86ad25mr2139894pjb.36.1707497398794;
        Fri, 09 Feb 2024 08:49:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgOkRWUTSqInTRg13d4URgeXtvTpA7pyw7Ka22GIvJnxFBw36TfEgDb0tEyld0wHgAinA0NFa9/Bkq4ZnaI3o=
X-Received: by 2002:a17:90b:4014:b0:295:fe86:ad25 with SMTP id
 ie20-20020a17090b401400b00295fe86ad25mr2139878pjb.36.1707497398427; Fri, 09
 Feb 2024 08:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209163454.98051-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20240209163454.98051-1-srinivas.kandagatla@linaro.org>
From: Eric Curtin <ecurtin@redhat.com>
Date: Fri, 9 Feb 2024 16:49:22 +0000
Message-ID: <CAOgh=FwFMaYvTwmqeOQrqHq2XANxghZbTuY3+SgFx_ozpysBOg@mail.gmail.com>
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, regressions@lists.linux.dev, 
	Miquel Raynal <miquel.raynal@bootlin.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Chen-Yu Tsai <wenst@chromium.org>, asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Feb 2024 at 16:43, <srinivas.kandagatla@linaro.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Creating sysfs files for all Cells caused a boot failure for linux-6.8-rc=
1 on
> Apple M1, which (in downstream dts files) has multiple nvmem cells that u=
se the
> same byte address. This causes the device probe to fail with
>
> [    0.605336] sysfs: cannot create duplicate filename '/devices/platform=
/soc@200000000/2922bc000.efuse/apple_efuses_nvmem0/cells/efuse@a10'
> [    0.605347] CPU: 7 PID: 1 Comm: swapper/0 Tainted: G S                =
 6.8.0-rc1-arnd-5+ #133
> [    0.605355] Hardware name: Apple Mac Studio (M1 Ultra, 2022) (DT)
> [    0.605362] Call trace:
> [    0.605365]  show_stack+0x18/0x2c
> [    0.605374]  dump_stack_lvl+0x60/0x80
> [    0.605383]  dump_stack+0x18/0x24
> [    0.605388]  sysfs_warn_dup+0x64/0x80
> [    0.605395]  sysfs_add_bin_file_mode_ns+0xb0/0xd4
> [    0.605402]  internal_create_group+0x268/0x404
> [    0.605409]  sysfs_create_groups+0x38/0x94
> [    0.605415]  devm_device_add_groups+0x50/0x94
> [    0.605572]  nvmem_populate_sysfs_cells+0x180/0x1b0
> [    0.605682]  nvmem_register+0x38c/0x470
> [    0.605789]  devm_nvmem_register+0x1c/0x6c
> [    0.605895]  apple_efuses_probe+0xe4/0x120
> [    0.606000]  platform_probe+0xa8/0xd0
>
> As far as I can tell, this is a problem for any device with multiple cell=
s on
> different bits of the same address. Avoid the issue by changing the file =
name
> to include the first bit number.
>
> Fixes: 0331c611949f ("nvmem: core: Expose cells through sysfs")
> Link: https://github.com/AsahiLinux/linux/blob/bd0a1a7d4/arch/arm64/boot/=
dts/apple/t600x-dieX.dtsi#L156
> Cc: regressions@lists.linux.dev
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Cc: Chen-Yu Tsai <wenst@chromium.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: asahi@lists.linux.dev
> Cc: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Seems reasonable to me.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
> Hi Greg,
>
> Here is a fix in nvmem for 6.8, could you queue these for next possible r=
c.
>
> Did not cc Stable as this is only targeted for 6.8 and no backporting is
> required.
>
> Thanks,
> Srini
>
>  Documentation/ABI/testing/sysfs-nvmem-cells | 16 ++++++++--------
>  drivers/nvmem/core.c                        |  5 +++--
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentation/=
ABI/testing/sysfs-nvmem-cells
> index 7af70adf3690..c7c9444f92a8 100644
> --- a/Documentation/ABI/testing/sysfs-nvmem-cells
> +++ b/Documentation/ABI/testing/sysfs-nvmem-cells
> @@ -4,18 +4,18 @@ KernelVersion:        6.5
>  Contact:       Miquel Raynal <miquel.raynal@bootlin.com>
>  Description:
>                 The "cells" folder contains one file per cell exposed by =
the
> -               NVMEM device. The name of the file is: <name>@<where>, wi=
th
> -               <name> being the cell name and <where> its location in th=
e NVMEM
> -               device, in hexadecimal (without the '0x' prefix, to mimic=
 device
> -               tree node names). The length of the file is the size of t=
he cell
> -               (when known). The content of the file is the binary conte=
nt of
> -               the cell (may sometimes be ASCII, likely without trailing
> -               character).
> +               NVMEM device. The name of the file is: "<name>@<byte>,<bi=
t>",
> +               with <name> being the cell name and <where> its location =
in
> +               the NVMEM device, in hexadecimal bytes and bits (without =
the
> +               '0x' prefix, to mimic device tree node names). The length=
 of
> +               the file is the size of the cell (when known). The conten=
t of
> +               the file is the binary content of the cell (may sometimes=
 be
> +               ASCII, likely without trailing character).
>                 Note: This file is only present if CONFIG_NVMEM_SYSFS
>                 is enabled.
>
>                 Example::
>
> -                 hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product=
-name@d
> +                 hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product=
-name@d,0
>                   00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M=
-P-DN|
>                   0000000a
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 980123fb4dde..eb357ac2e54a 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -460,8 +460,9 @@ static int nvmem_populate_sysfs_cells(struct nvmem_de=
vice *nvmem)
>         list_for_each_entry(entry, &nvmem->cells, node) {
>                 sysfs_bin_attr_init(&attrs[i]);
>                 attrs[i].attr.name =3D devm_kasprintf(&nvmem->dev, GFP_KE=
RNEL,
> -                                                   "%s@%x", entry->name,
> -                                                   entry->offset);
> +                                                   "%s@%x,%x", entry->na=
me,
> +                                                   entry->offset,
> +                                                   entry->bit_offset);
>                 attrs[i].attr.mode =3D 0444;
>                 attrs[i].size =3D entry->bytes;
>                 attrs[i].read =3D &nvmem_cell_attr_read;
> --
> 2.25.1
>
>


