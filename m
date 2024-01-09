Return-Path: <linux-kernel+bounces-20953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 731788287BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E1F1F230DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A4B39875;
	Tue,  9 Jan 2024 14:07:41 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122539AC0;
	Tue,  9 Jan 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-20475bf35a2so596710fac.1;
        Tue, 09 Jan 2024 06:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809258; x=1705414058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqF5gaGqpHvHcosofJTzkJSMKdQyTzIwT6UHcAKQaCk=;
        b=Tz/2lGGbXePRdVsG8Nf86mkTUB9HiOZkj7LH9Vb4Hk5sQOm9S3ITPqmRDOyJmaAcF+
         UTv5HvGt+kTn1BVEg6wT0AmRqO8Bi3UPfA5Q3aMYhs6c4hilh9HDIQsuZUyyex6kaYb1
         Up347+s1PzmazRq/HIfqY5WUEORsFO0Fq2jgi7IumPj7T3H0ziaF9yLitjnZps1Z37CD
         8YXTTSxfqo16IsriDkblc4//MmFuLBeHD9inQMelSmnY++vglxVMQgpAVFRiazRDuKpR
         AZS3dlRP+BdVfxJ6sGSH+Paq0437rvuUCg+Kc5SMBw64dYbST8OQmK+ZIVGVL47VSQOO
         +zFg==
X-Gm-Message-State: AOJu0YzUhwys2kjSaGZ3ALtXZA2kMmKQLc2usiCmEqYMr1EsZZRNNgEX
	xqgWGJpI9u53k7qx6B2Tb86nBd/HgUfcJkAZzpg=
X-Google-Smtp-Source: AGHT+IG+8O7C1b4NuN8WT59ADqB4eUOPRViKOqLAz3WiF88mTKrWaBzt3XwkIhu4DaYQgyImVt+LCz0CJVzqnMNvY+c=
X-Received: by 2002:a05:6871:48f:b0:205:fd47:cd9b with SMTP id
 f15-20020a056871048f00b00205fd47cd9bmr10283311oaj.2.1704809258629; Tue, 09
 Jan 2024 06:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107021322.7709-2-benny1091@gmail.com>
In-Reply-To: <20240107021322.7709-2-benny1091@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 15:07:27 +0100
Message-ID: <CAJZ5v0jWjTbuaYXMQ7e0xMFki3mEBO2Su3-DPsGwbWjdStQtJQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/drivers: add DMI exception for ASUS Vivobook E1504GA
 and E1504GAB to resource.c
To: Ben Mayo <benny1091@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 3:13=E2=80=AFAM Ben Mayo <benny1091@gmail.com> wrote=
:
>
> Asus Vivobook E1504GA and E1504GAB notebooks are affected by bug #216158
> (DSDT specifies the kbd IRQ as level active-low and using the override
> changes this to rising edge, stopping the keyboard from working).
> Users of these notebooks do not have a working keyboard unless they add
> their DMI information to the struct irq1_level_low_skip_override array
> in resource.c and compile a custom kernel. This patch will add support
> for these computers to the linux kernel without requiring the end-user
> to recompile the kernel.
>
> Signed-off-by: Ben Mayo <benny1091@gmail.com>
> ---
>  drivers/acpi/resource.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 9bd9f79cd409..eb34d201b65f 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -482,6 +482,20 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
>                 },
>         },
> +       {
> +               /* Asus Vivobook E1504GA */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "E1504GA"),
> +               },
> +       },
> +       {
> +               /* Asus Vivobook E1504GAB */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "E1504GAB"),
> +               },
> +       },
>         {
>                 /* LG Electronics 17U70P */
>                 .matches =3D {
> --

Applied as 6.8-rc1 material with some edits in the subject and
changelog (a Link: tag pointing to the bug in question added in
particular).

Thanks!

