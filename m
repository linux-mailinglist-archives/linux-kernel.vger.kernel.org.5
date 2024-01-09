Return-Path: <linux-kernel+bounces-20935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2AA828796
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF03328690D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCA93985A;
	Tue,  9 Jan 2024 14:01:32 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648439843;
	Tue,  9 Jan 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-594363b4783so80722eaf.1;
        Tue, 09 Jan 2024 06:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808890; x=1705413690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4g/qLgJTtLnx4Mwhlep4ev2Jw4DB5X4OpGt8/1y0G4=;
        b=Q2KVGp2ZpH3ifHw23PFc1Y4+DALCkcG9sa7WdizcV8t+l0HWQSBXx4ESLpyb9v2tNT
         zLt8sixGGTDO8rUpBJjb0mz4Y5MoCnxOW2bN9AOML+x3j3ktLqKpR1tzoXYyQTsGhhnN
         xFDHB/Sf3iHD2WSpPOaVIa4bKWGQZarN1hUDgFZIzVEEZUPVulBhJs7zmMXpM6BI4824
         ra2w6tsUiR5CSGEHM1BmtSyq1YLKNV70vwrYut+7Owcn056WXbBcHuK1qpwXO0c2Mwxm
         MUvBps1BtN7xTHoaaz9MHhU7VPbS8bjD/rIo4AKupgGvfX17bU6T1y5dpiF+8xdr5wsM
         /xBA==
X-Gm-Message-State: AOJu0YxCJ+lV626DPNhsviksnrFhunQaBfzSAfejBT/oZDWKUG12a24d
	4sizai12bXx7H4c29sHlZp74W6P4laBEsHcq2Ws=
X-Google-Smtp-Source: AGHT+IE6YRqP3ux3j7EjNd3nCXpoVsgKfUWLobU291Rdho2HmM7G9qCpj4yPQRwGpLSkf+YsaN18PhrY01plEPVn1U8=
X-Received: by 2002:a05:6820:d0a:b0:598:8d98:286d with SMTP id
 ej10-20020a0568200d0a00b005988d98286dmr325959oob.0.1704808889513; Tue, 09 Jan
 2024 06:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024010520-joyfully-cosigner-c2a9@gregkh>
In-Reply-To: <2024010520-joyfully-cosigner-c2a9@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 15:01:17 +0100
Message-ID: <CAJZ5v0h6+W5PL5mSC9LHg+P+S08C8XKPfjy4XX=RDkukWOQ3vA@mail.gmail.com>
Subject: Re: [PATCH] PNP: make pnp_bus_type const
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 1:51=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the pnp_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pnp/driver.c | 2 +-
>  include/linux/pnp.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
> index 46c534f6b1c9..0a5d0d8befa8 100644
> --- a/drivers/pnp/driver.c
> +++ b/drivers/pnp/driver.c
> @@ -256,7 +256,7 @@ static const struct dev_pm_ops pnp_bus_dev_pm_ops =3D=
 {
>         .restore =3D pnp_bus_resume,
>  };
>
> -struct bus_type pnp_bus_type =3D {
> +const struct bus_type pnp_bus_type =3D {
>         .name    =3D "pnp",
>         .match   =3D pnp_bus_match,
>         .probe   =3D pnp_device_probe,
> diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> index 267fb8a4fb6e..ddbe7c3ca4ce 100644
> --- a/include/linux/pnp.h
> +++ b/include/linux/pnp.h
> @@ -435,7 +435,7 @@ struct pnp_protocol {
>  #define protocol_for_each_dev(protocol, dev)   \
>         list_for_each_entry(dev, &(protocol)->devices, protocol_list)
>
> -extern struct bus_type pnp_bus_type;
> +extern const struct bus_type pnp_bus_type;
>
>  #if defined(CONFIG_PNP)
>
> --

Applied as 6.8-rc1 material, thanks!

