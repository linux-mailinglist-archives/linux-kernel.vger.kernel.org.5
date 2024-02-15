Return-Path: <linux-kernel+bounces-67614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A093856E10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4E31C226EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54513A890;
	Thu, 15 Feb 2024 19:52:41 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B612BF1E;
	Thu, 15 Feb 2024 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026761; cv=none; b=YCwuNZU2eWEUZ1CGhcLGJ35EOo2v8WTkAaP2vVPPBAnJF/arxja9wGYW0FIGVyC0IxDDU3HjMaMcdCdyTDD4ynvuzeYEsDA0inpumJ4EHSQrrHjY0TtbgBg72LieTDXfUcjTAeo9qu971n1qirMeek5Ra29PR+lAnowbLqNatfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026761; c=relaxed/simple;
	bh=HFKcFyvW4sPTCSrx6Kmc7KZ0WwpPVFK4hWtVZSJM1R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bcc3XojfoAWIPlvvRLzmzoyWRsURCBDw3/gTfAV+81tN1iQC8UsKalYRdyMPCb1dPeiZ715E/TChYHTVAC48qLjoD8c+j7gexSjes1f2xvytAb4AgYWEE1aHlHpf2U3ba5Co2UnyQRXUObVwfZ5/KXe8ImvbJ1fUcO2GfgnL7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-214309bbbf0so153773fac.1;
        Thu, 15 Feb 2024 11:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026759; x=1708631559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isRTNv4OHZOkLMBzStzx/NL9+OwNxPNX48FNAMKoAGQ=;
        b=loksQ0MSkzqufIavgnSrG1wakdbzEjd6CXBsOy3jCYBZyVlGBDlIre5mVvh3k/Qc0W
         CfTBq6vZbXi25xSNphWh5vMslr62NkGRta45YhGCPYyi9lJvcdm87CuvDWwhvcAvbQDH
         mTwtefgGoeIBwNRyZPgFnP0fk03cts6nKydYP6atNkH+hH7J6Z4dgdM7vM6dWNcvs1Y5
         L3FCN3xeoxtyeUmKRolvgZdbkE8NTgxZBQMdnS8DsqVkSafFdlS/X3o4uKbB8CncrVXF
         +JCMr8mIzdiTaCL7AawHS0zhuj3avTHmBMCmGY+wlii/j08FyhXVgNhW/MB6uzMoFtst
         iMNA==
X-Forwarded-Encrypted: i=1; AJvYcCWkLuZYRcv75UaEft/i+nVgF+Xuk8YUdEpNKKYUdEwuRO3anw3NDup2Jgsyjeus26cxE5HE0bY7Ma1CBDQUrHYfIBkQTl/gtfoK7sBU3D2tpf+Uhm1sRRuDFMwf+N77HUNNjPwNSYFk1A==
X-Gm-Message-State: AOJu0YyrVQCXRRR7r9ys1R5YnWydUDnMztY8p3SWjG7YWm89HAhHN3ca
	4UmwxN1SLh2FWrWeMVbTsQezmHiIJCgDKZUqsyJ9z4aq/5Trsti9nLJXhdp7Pd8mCLk4t4oO5mj
	ARsnRIJDiPzmKLlUCldRUQYysyTY=
X-Google-Smtp-Source: AGHT+IGgeFXmuc9BaiFv7Y2D9C02UVAGPHRoglZQav+UEKZvUc4R4Kp77gwoBmGYHdKm9l1BGZ59wZfoZGQg85Yf690=
X-Received: by 2002:a4a:3803:0:b0:59a:bfb:f556 with SMTP id
 c3-20020a4a3803000000b0059a0bfbf556mr270551ooa.0.1708026759039; Thu, 15 Feb
 2024 11:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <52cf0eab-dbbd-4f12-b100-c7db1daea442@gmail.com>
In-Reply-To: <52cf0eab-dbbd-4f12-b100-c7db1daea442@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Feb 2024 20:52:27 +0100
Message-ID: <CAJZ5v0hHEWEvo83kuvn9=UnW3wpVQ_Eg8bKHNVCMCbvJEA535g@mail.gmail.com>
Subject: Re: [PATCH] Fix keyboard on ASUS EXPERTBOOK B2502FBA, see bug:217323
To: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 1:08=E2=80=AFAM Sviatoslav Harasymchuk
<sviatoslav.harasymchuk@gmail.com> wrote:
>
> For: ASUS ExpertBook B2502FBA
> Similar to patch:
> https://lore.kernel.org/linux-acpi/20230411183144.6932-1-pmenzel@molgen.m=
pg.de/
> For the bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217323
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217323
> Signed-off-by: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>
> Tested-by: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>
> ---
>   drivers/acpi/resource.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index dacad1d846c0..41fe6f2d4fa8 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -489,6 +489,13 @@ static const struct dmi_system_id
> irq1_level_low_skip_override[] =3D {
>               DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
>           },
>       },
> +    {
> +        /* Asus ExpertBook B2502FBA */
> +        .matches =3D {
> +            DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +            DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
> +        },
> +    },
>       {
>           /* Asus Vivobook E1504GA */
>           .matches =3D {
> --

Applied as 6.9 material, but I rewrote the subject and changelog and
had to fix up white space (presumably broken by your email client or
similar).

I would appreciate being more careful next time.

