Return-Path: <linux-kernel+bounces-146907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC52D8A6CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2051F22509
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE4612C558;
	Tue, 16 Apr 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5ihT5E0"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8513E128385;
	Tue, 16 Apr 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275167; cv=none; b=AGbP6gVdM/YPcv7FWOOfTqhqDFrk5sb6rSowpOg6ljU4L512dxTfnJXUizEWctXLAQkpPJK5x5yTxmQk1bZrW3nYvFIDeU3Z+BfW6NEuutDOOvCOCnPZIA1WNAWrDJv4I1FQOfXranmgFXktLF7/IyoX8CDN06LeQa3pUdy9Xh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275167; c=relaxed/simple;
	bh=1s5jT77kXAEOB64Hgh8ttGaCyhNYzlNL1lVHCpRhEl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9zW5KdU0gIhLeu6jBn4Nb7/GSYV9D6TLCATnTtAr3mKv9ogXi+1V7r4Unx9o5B5pVwYSfAF9rFj9j0P1V1kxx8eu1TFRpv9hkpGHHq9DmNGvx5lC89nhxG8FC88xKKRaIQ1zGj74hvrLRKh5WfEmGJNK84FbOs7FNtYa8qjhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5ihT5E0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5269c3f9c7so286107566b.2;
        Tue, 16 Apr 2024 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713275164; x=1713879964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ln2bOghlbnxTvN3MGwjWqt27D8bIt92GVeqcGNHglE=;
        b=B5ihT5E0lcAH5DR2+f210i2xNlRd4B/qErfwnUhh7H8j3Vy/XWQypFWnvmT6TQbzv3
         o1sTky2e3WeooeeiYuHQ1iEAnticHuvSve5nD7aT9VVsLPEAxyIebnsMNBAAsyTNiUjB
         jbQuXPkQ4KXJhnH+yKhwbMvn6FfCbF2mZpCXIf5eAtZll2I65lQg2YAH5q5V6EGlfWme
         NsqdPQXYWFiJJ205Rb0f9+2Bs6Z16KbuBqjcPX7GozpRW54tFJWgryyFisJ/N9TMVqJh
         JCT328x8jwrcl9hRToQeidLLuEdWhuHS51onTSU0y3TuPSfXilOTH11JRnbeNHAdxBAp
         EfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713275164; x=1713879964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ln2bOghlbnxTvN3MGwjWqt27D8bIt92GVeqcGNHglE=;
        b=jZ44QD16wA07U3MH1B3WscezaK6NdqxtSKWtKgc5ndwk7TYXQ602e/ubKk2ek8JGOZ
         4UpvkgsdENoC2zBDQoKtC3vtgC5lMjDodlTpyu762B0rAS0y4O3dTF+HT9LT9AlfvctU
         zs09trwN5XWq9eiPEw7qoFmU7MBD8uCwcZq8GugNad8SHi2nCwuYWrdpuIXeVFiFy5vC
         L6VqUwUEuHgeCbSZRQ1xOgDBMLArogFJsLgGcYwanVzehxK1dfSd6YVxeanhaIVmRzEs
         ZGNSz72LolxXXDieZo17X+8CGlVluyg/ROdSEGG/v2mvo2psCh48YWHRFApuMoV6mv2y
         ICMw==
X-Forwarded-Encrypted: i=1; AJvYcCVFuEJYJpmmDWonnAMq2KYJ9zTU9+Ce13Zt+NDVl6/+O/b3z8FDvHIr99WAVoATl2ZbvKFlBqsywBG0d0IYILMvx8BxQmnhj1mbdNbOBPeXPBrK0ZeUFpStp03gxPuaaoJbgpZ9neqUqn1g1GcoGIa7yC1MZhDEwd5vsxE+EHdEPvzeJ3zH55y7ZmT2RUYqy3tRq1pmxTpFvmwEMBGR2lT4m4VFjMJa/A==
X-Gm-Message-State: AOJu0Yxzx1zNtf7mHyu1sIU4FxRsItmeOWGhMMH0fRmAPIXbyils/05y
	iwzsDoLg8ykBAd9LMAAiH3FFa3ppxAT4PfPhI4ztm9wdIK9V8juF9DwEuvEyQ2tk2Ls5SIpNyVW
	TjMFEy+uqJRkAKFTuI+X/GaFYojhmVjwS
X-Google-Smtp-Source: AGHT+IHXlF76z7XD64K1AlyyNhTwiWKMjybMPhhN3Rvx3Sl3nSv06AAKnIQzBr2Egavtr8Nb9A9A3elrw2UNdVUhpFY=
X-Received: by 2002:a17:906:31cc:b0:a52:3ecb:ad83 with SMTP id
 f12-20020a17090631cc00b00a523ecbad83mr5868329ejf.38.1713275163625; Tue, 16
 Apr 2024 06:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416053909.256319-1-hpa@redhat.com> <20240416053909.256319-2-hpa@redhat.com>
In-Reply-To: <20240416053909.256319-2-hpa@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Apr 2024 16:45:27 +0300
Message-ID: <CAHp75VeuXuD7USd=bS1X=HCtKRPYWZ7r1NApPfDFZ4RRCUSRLg@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] platform: x86-android-tablets: other: Add swnode
 for Xiaomi pad2 indicator LED
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:39=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote:
>
> KTD2026 LED controller manages the indicator LED for Xiaomi pad2. The ACP=
I
> for it is not properly made so the kernel can't get a correct description=
.
>
> This work adds a description for this RGB LED controller and also sets a
> trigger to indicate the changing event (bq27520-0-charging). When it is
> charging, the indicator LED will be turned on.

..

> +/*
> + * The fwnode for ktd2026 on Xaomi pad2. It composed of a RGB LED node

is composed

> + * with three subnodes for each color. The RGB LED node is named
> + * "multi-led" to align with the name in the device tree.
> + */

..

> +static const struct software_node ktd2026_node =3D {
> +       .name =3D "ktd2026"

Please, leave a trailing comma as it's not a termination entry.

> +};

(TBH I'm still unsure that having a name is a good idea even if it's
supposed to be only a single device on the platform, but it's up to
Hans who has an experience with those.)

--=20
With Best Regards,
Andy Shevchenko

