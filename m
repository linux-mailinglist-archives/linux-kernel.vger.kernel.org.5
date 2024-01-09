Return-Path: <linux-kernel+bounces-20974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136888287F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBEAB24464
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A039AC2;
	Tue,  9 Jan 2024 14:23:16 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3FE39AC0;
	Tue,  9 Jan 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbc47db8a9so387635b6e.1;
        Tue, 09 Jan 2024 06:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704810194; x=1705414994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mREYysZpGdKxJT/PP4XzvgEVe5mAm4kijQUj6uChCLc=;
        b=n2FWwRTNPHtWiLKeVNUBeJX291G5Y1Nfx6gKTLP/f+W6XUqWHcgpcd9/rYzIsx5sfI
         IO3/vqx7sXvmD5zkALiB/6U7HWRng/UH3y/g5V2OXULpOdBYI8vF43CKhFtYpfpsweZi
         2ZBhomMzTWj9vX7/k8urJ9zWuqL52xqHTVfHicvh8X2+759alSIToiVi2j5yupVqEg2J
         owY3y0dmIgCwzS2gVSIC3WcOMvXhrCQKkWC7q1RxvKbb/vG7j3cR+pgkGzeXE2Sgf9y7
         zBbIFlXNoAgK7WCOUDTr1+7epBMWFp0y0UyWRX1yn7N/sYwBEdMEnTMKM7d6YvAIoDg/
         w5kA==
X-Gm-Message-State: AOJu0YwoxZw3zsSOJcyc4sHcA1UdX/lTwQ8Lk1LnLaD35toxg9KF1cxp
	f6k7QOP6u4xaYRw8vo96T2/8Y4gQkOQd3ZbrOA8=
X-Google-Smtp-Source: AGHT+IGE5fCiqJ3Gw1wlD2i7O14i3Ynciv+iM6vwTzkFERr9JEeTDmyexZA4ds4xG8+EaL0j+V7+ywq/2TVzAaEYPFQ=
X-Received: by 2002:a05:6808:60d:b0:3bb:74da:bf82 with SMTP id
 y13-20020a056808060d00b003bb74dabf82mr9022153oih.4.1704810194108; Tue, 09 Jan
 2024 06:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107085305.6981-1-mekosko@projectyo.network>
In-Reply-To: <20240107085305.6981-1-mekosko@projectyo.network>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 15:23:03 +0100
Message-ID: <CAJZ5v0izfETgX_652rk9q83JyP4Tne5H7CaH3DGqr5+xHMttKA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CGA
To: Michael Maltsev <mekosko@projectyo.network>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 9:59=E2=80=AFAM Michael Maltsev
<mekosko@projectyo.network> wrote:
>
> Like the ASUS ExpertBook B1502CBA and various ASUS laptops, the
> ASUS ExpertBook B1502CGA has an ACPI DSDT table that describes IRQ 1 as
> ActiveLow while the kernel overrides it to Edge_High.
>
>         $ sudo dmesg | grep DMI
>         [    0.000000] DMI: ASUSTeK COMPUTER INC. ASUS EXPERTBOOK B1502CG=
A_B1502CGA/B1502CGA, BIOS B1502CGA.303 06/05/2023
>         $ grep -A 40 PS2K dsdt.dsl | grep IRQ -A 1
>                         IRQ (Level, ActiveLow, Exclusive, )
>                             {1}
>
> This prevents the keyboard from working. To fix this issue, add this lapt=
op
> to the skip_override_table so that the kernel does not override IRQ 1.
>
> Signed-off-by: Michael Maltsev <mekosko@projectyo.network>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index c297e40c5bdc..b0c3da70f809 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -453,6 +453,13 @@ static const struct dmi_system_id asus_laptop[] =3D =
{
>                         DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
>                 },
>         },
> +       {
> +               .ident =3D "Asus ExpertBook B1502CGA",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
> +               },
> +       },
>         {
>                 .ident =3D "Asus ExpertBook B2402CBA",
>                 .matches =3D {
> --

Applied as 6.8-rc1 material, but I've replaced the unnecessary .ident
field with a comment.

Thanks!

