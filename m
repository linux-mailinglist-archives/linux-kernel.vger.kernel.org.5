Return-Path: <linux-kernel+bounces-74530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA0385D58D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA9B1C21400
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA7A5231;
	Wed, 21 Feb 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc43piSv"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B816B186F;
	Wed, 21 Feb 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511449; cv=none; b=h9Ah6tUC6SFXY4JhOTgozvI1kZ8rMtYKIi81UShQ1nxHB6EEqT6Mj8AWl+1Jbn6MezpZyefyMKr8VPGcUEL9mGe/QQCOsizu31g/gROMZYi9O/4PTEC/3qJfim9uztAKvNz4iuXyrmX34Y4e1E01Fc++y88xaUZyT8tHIE/bqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511449; c=relaxed/simple;
	bh=Y5xsKgigDPeqt/VxKiQzkP1SOMCGJPYPQlZloVadbDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az5bkToouSP66RpEyKnlT9EF75HLvKt18ht2v5q9Wbd83GNWIPSZ2eO+gNIlia3PjcX4YLEcsORuu9mje5pNEn0Vrp84yfOpEze1ptURG40a51vudGYtBRxChEN8/zxAtYd6rGQbQVCxzdH4Yeihijw3mGm0tX6MaEbiRSXsYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc43piSv; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-595aa5b1fe0so4228609eaf.2;
        Wed, 21 Feb 2024 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708511447; x=1709116247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS9/jiE8MWvoVVRlTeZyyyHcTdU0X9jAny+PuZ4RSHs=;
        b=Bc43piSvuX7qzaA2FzhpcFP2KVYzHax5Zyztoh2IuapvdAuCLQ63P0hgGqND2dnYMi
         vWMgqCfIBtEQi7aiAcgGpmb3k4Bk2uTUsZbX8DdMgzqOIABiOzZm5KiF0q8hVmNKeQC1
         24bA6UJxPgYBxv0hk68k62wVDCKrzHQq1IFgi6OirpJN4QSFZIq2CfhSUm2tXyd/0Oaq
         mF1dXVjTTG0G53Z+0uoS3HCAzzoVz85j5tTPYbXsh1FCyo9Kolt1/lDSMWhy1cDdW406
         jNxzAu2r3BpDSwhbuJy9D/MXad+8fp929aplTKFbtszLna3/hciIkIrFJX6u6Y/sEjeJ
         l6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708511447; x=1709116247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS9/jiE8MWvoVVRlTeZyyyHcTdU0X9jAny+PuZ4RSHs=;
        b=DjrC89sUsMWq8xw/B+F/99whZdftjE4i7NHFMVkzM/3sNAV6fUZI6s0piBctJiIqUN
         Taam6narB5BYh0B+i6Tmnp2x+D+gNjRipzRvGEduHMF9USQrqhXIAt4ISFeoQ+8UTQ7Q
         MD6CG5MM6P9xUYanB2Kpso27hbAVai9Fu6laoSn5hxC3wbB4EYEcBh/LppTnXPqou7bm
         1bPogEKjXOLVNjk0KgAzrNBMlkvj1CYWsyd62V2cDtuBMLmR+r4MDGvqQsqjpEfvV0WC
         fFUzPZlwFDv1D/D3WOhqYU+TtYLq//DWC5upz4spv5uOzFBYUFKvcEjve+fsqkV3nbJK
         fk2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFGeGNxIj0g6TMe+1fkzOXxgPUkflwmlR01d2yub3XLJ+gBvph0urmHB8w2mRsBRcvp4+6xMmm6qtpr5SqJ1mHQV+dDxdsLFsr/5f/c0SqzvX1asxV/1Ax2pX8dnH+pNBK0x5z4w8DzayRxxat
X-Gm-Message-State: AOJu0YyjCKSm1lg+Q3FDuR5kcZ+xkKmWeffI3Q/in+wjH2152GkWLl+H
	oVtaudNUMIqg+2YuyUK+7ANHa3ddr8zX1tamKO1xnZHODZhrrAc6VzI4DxSA6sxs0UMzar16iF5
	dxRSiuSK91Wkp+ACHEreQalwoQLY=
X-Google-Smtp-Source: AGHT+IGy0agsGAwrKbTWhpUR4Xd/LZ1E7T8rgouIcMK3FZ4hyasWMdTdVLD1EHGJQCFTnpFWrTwR85RVEgJwpIdSdXI=
X-Received: by 2002:a05:6218:2624:b0:17b:6171:adab with SMTP id
 oy36-20020a056218262400b0017b6171adabmr625829rwc.1.1708511446736; Wed, 21 Feb
 2024 02:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221051634.work.287-kees@kernel.org>
In-Reply-To: <20240221051634.work.287-kees@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Feb 2024 11:30:33 +0100
Message-ID: <CANiq72mab-U9i0qVre7yucfi2oRHJ2yQPDju4sQuTb6HjCy7WQ@mail.gmail.com>
Subject: Re: [PATCH] refcount: Annotated intentional signed integer wrap-around
To: Kees Cook <keescook@chromium.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 6:16=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> Mark the various refcount_t functions with __signed_wrap, as we depend
> on the wrapping behavior to detect the overflow and perform saturation.
> Silences warnings seen with the LKDTM REFCOUNT_* tests:
>
>   UBSAN: signed-integer-overflow in ../include/linux/refcount.h:189:11
>   2147483647 + 1 cannot be represented in type 'int'
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Not sure why I am the "To:" (i.e. even if it is a change involving
only an addition of an attribute), but it looks good to me (UBSan is
triggering on the few `old + i`s caused by the calls from
`drivers/misc/lkdtm/refcount.c`, right?):

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

As usual, thanks Kees for keeping up on getting the kernel (un)signed
UBSan-clean :)

Cheers,
Miguel

