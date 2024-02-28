Return-Path: <linux-kernel+bounces-85416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C812186B599
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE6F2823F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C89B3FBA9;
	Wed, 28 Feb 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWwtyg1X"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DB6EF02;
	Wed, 28 Feb 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140245; cv=none; b=RES2h8TZv1nmP8myB0mVODarRJlcX+Cc3HRvBlmGLC64g+6m0dGn0GRsuNZpsSDta2cVbDKdHsouaUV4FM0bGxx35vd7XIit7V3kUV+9RFGfjyU3PRYOs3CTUcKXwgqccX26sXmS7Js1V0Kb+A7ugni+dToLIl/YeAo7NVyxVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140245; c=relaxed/simple;
	bh=PDZWRcSg20BdxUwgxmJMHinyREAR0J3sVtBXMdbFXyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TA9S7QcLXh837DOkdZ2fj8de6qOpv+3mhhdl47przzZcm8kHh760J0Xt9XEaHiIcWhwP90t4uPvAI+bXgqrfpi05okcpH1+KFtn9cTkKBDwogl3YH6M/QBkFMj6Exvhji8/8jEdyEw/oFX6AZEMlQKkkWhT6hMC6rEam001VF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWwtyg1X; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412b88e2f07so1771905e9.3;
        Wed, 28 Feb 2024 09:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709140242; x=1709745042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WiiouwYNer2Jzd0vSzegS7p804ganFmhzlojYqoV8o=;
        b=DWwtyg1XOFfMfxyEwa8WOJjkyYrlFABHvG2uuzW++eKfDRAHwc/O/EVVC9+jsJZq0o
         6oBuiSu+Pu+6HUe5ZZVci5mbhNbq2lXPQOjzwxxOzdoxcA+3vIzE+xbheacYp6WkG1N2
         SErBB/73QSL6Lys2mYyWTPBLBUFEzq7niuzVyHqBte3dSqmks7LxQrNYsj//9ttfFayM
         zWdVs0Cl/A6xg9YauBXh0h7bueYIgeuavNkofC5OioZi59AzkxlZVIINYe1AYD7ZDsCC
         2vh1ge0NwWDddfUOBllXKCoJglIeRwQFYoCiSPT7cE3AMH60j9hp7i0JBweacGPxlkiH
         9jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140242; x=1709745042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WiiouwYNer2Jzd0vSzegS7p804ganFmhzlojYqoV8o=;
        b=v7VCTVfInD/CEtTJwAaEsnjMahUbEFgB8BUPNqDDvbcq9IQp7O1UlbJUlc3dAw2v3p
         cypBBgb8qsXDkxS0RmIwT4nqM8JDjmSEG4l43BXmte+DSL/WxyhVFh2N3w22zSp3zrLZ
         V/zzzBj25ZrVdy6MftKZlBr46aBitKC9O16MXpJb8zk9y13BwGU/NN4d51zevESFy9eF
         iDQccXr1PCgx8h8A40U7BtdvL0GTktNbz4DMN7NusWgsuBC518t9oYJUDNJj2VR2oawL
         DUN/bX/30bAEqRNeaiXCth7POUOs8/Ar49lrHI1xHB9L39NoLv8qKGUX2Cw2nGOYKL2z
         BIQg==
X-Forwarded-Encrypted: i=1; AJvYcCUS++8et11ge3+OqjpmAV5GKBv21PTtj2jmvg6bFTDOHph/ZCJU7+NIXfuyVogDFdWwopxjZC6nt756FaSvCfILtykqCItNuYmG0wNHsLWESVN8WH6ct7vbX0G50KsvSYyUvOKwP7X03CnyZbJD
X-Gm-Message-State: AOJu0YzUdcmkfRflgf49MzCsS2X86zOP+Lvfeq50eR+JNtEXQhjAHJej
	I/LgbR2moFcqd+g8UNFdCbS3B2s3JSadXXWA910xddrcwlHAFVA8nmo2Smj5rNqneL8rgnP1ZWM
	vGDblvYc1Kpzo+M/21QtxvSRTTTEDK1+8
X-Google-Smtp-Source: AGHT+IFNlVok0G/bM11U9R3yRs6/+bfGlzsPAH8qf+jJJ/S7zGispJ1683nsnt1tl8fiThUrHiDRWn/2WqhIM2BkSRE=
X-Received: by 2002:a05:600c:310c:b0:412:b586:6d2a with SMTP id
 g12-20020a05600c310c00b00412b5866d2amr97153wmo.7.1709140242308; Wed, 28 Feb
 2024 09:10:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <361ac881-60b7-471f-91e5-5bf8fe8042b2@moroto.mountain>
In-Reply-To: <361ac881-60b7-471f-91e5-5bf8fe8042b2@moroto.mountain>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 28 Feb 2024 18:10:31 +0100
Message-ID: <CA+fCnZd_eNHes56x3edzcYWeDKW2WRJYqrz_FyCks5wxtLdFdQ@mail.gmail.com>
Subject: Re: [PATCH] lib/stackdepot: off by one in depot_fetch_stack()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:20=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
>
> The stack_pools[] array has DEPOT_MAX_POOLS.  The "pools_num" tracks the
> number of pools which are initialized.  See depot_init_pool() for more
> details.
>
> If pool_index =3D=3D pools_num_cached, this will read one element beyond =
what
> we want.  If not all the pools are initialized, then the pool will be
> NULL, triggering a WARN(), and if they are all initialized it will read
> one element beyond the end of the array.
>
> Fixes: b29d31885814 ("lib/stackdepot: store free stack records in a freel=
ist")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> From static analysis.  What seems to have happened is that originally
> we stored the highest index instead of the number of elements and when
> we changed the > to >=3D comparison was overlooked.
>
>  lib/stackdepot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 8c795bb20afb..af6cc19a2003 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -447,7 +447,7 @@ static struct stack_record *depot_fetch_stack(depot_s=
tack_handle_t handle)
>
>         lockdep_assert_not_held(&pool_lock);
>
> -       if (pool_index > pools_num_cached) {
> +       if (pool_index >=3D pools_num_cached) {
>                 WARN(1, "pool index %d out of bounds (%d) for stack id %0=
8x\n",
>                      pool_index, pools_num_cached, handle);
>                 return NULL;
> --
> 2.43.0
>

Hi Dan,

This patch needs to be rebased onto "lib/stackdepot: Fix first entry
having a 0-handle", which is now in mm-stable.

Thank you!

