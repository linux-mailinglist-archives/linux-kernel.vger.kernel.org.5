Return-Path: <linux-kernel+bounces-100139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9355A879265
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476E51F22B92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365CA77655;
	Tue, 12 Mar 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb5GqRuK"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724D8464
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240461; cv=none; b=c2u45n7hf2uWQolueRcX3p5kgaisgpEJTTZf+053aauYOfB2b01XjiRo3XtEnd9MIWQ0sdD1xcSKAyVJ66CoP1jlCC9DhSGnfNDqKNtEaeDpCULrKXEBBQTYOPXsgMjodiemoG/BbljLoCMvNy3ZzIOgcMYQL0MLJ59EwXzHNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240461; c=relaxed/simple;
	bh=60fW2N45Mo1Ih3HHdg/RYurDXI1KKShx43EJNg4Sfjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfkMXTIhgEMyXHFpFyjd8tTgXY5pKlTT55T7gRGNikZV5U4siu5W825U2GUxH09Gzs5e9DOf/gQPTs7Yg2QaddtxMvWbTYxeNFt2Wpx6Hg7piutdKFXzvXAD/sl8GQHpyiQEM7o2FPUbg4AMgs67skGAeCBzo1PIMZHI6DCl8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb5GqRuK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd8d586126so13505475ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710240459; x=1710845259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60fW2N45Mo1Ih3HHdg/RYurDXI1KKShx43EJNg4Sfjk=;
        b=gb5GqRuK2DHpC7rwdyyBqd2d3vmBeBf00OJ3CPxOPdQhZpXDU2gAQivYXK/wdkN5CT
         tG/EUBbhd01vtlb7rlQPOpr/NE0UOw1QcKF/OTCGCbpxtT7OYf9ThikfENqV0zcsmPa/
         f6We/EkkKABZxFgbc1uWMgAR9NxOttFEfwSIDsf1kQY3PT78+fVwi1ZOTP+GzkwkWx8w
         oUCp/DyhGuzmgBUHa+KTwX8ZQf0+tO3D6ouRTq6ogCQneps/h34MKxEsDL/D0cq5T5pP
         Iu3j1LVC7oWyPIrjWbPdoSGMGBPWv7iMG5kQMTr1bA9tEdug6jVh2ctT9d3onddnlaRP
         HQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710240459; x=1710845259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60fW2N45Mo1Ih3HHdg/RYurDXI1KKShx43EJNg4Sfjk=;
        b=Ifm26aJ5WJRliQP0RGIFrndqVkmKcY+xBoZ49TsFHnhFvtCChWEDM2JTGXrGKGgaNk
         iUOg7+Yzg4xEoheZYHyXhtwRZjyxCtTPEitvmF5mxzIFxG4MFNd2Pko7J4e2dto9ntsO
         HWLFv5I4ikQjO4al+U6gFzRQBQr7B6g+/XYcUvvMNyGUyMX+jYbtLl+e7K9vdHEJU36u
         sNNm7PUd1PHM7eQhNhdLNHx1eDG5utoqzeQ92e6BvUTzXyjWP9hvIUZHY8UP8WhBrJlE
         VGikzOmNIHdUzZromBqP9UxPsVcyqOmpRJTqFmipizMIrZ5A8k8Hm7qWzG/e7Sf+7Ulz
         YWPw==
X-Forwarded-Encrypted: i=1; AJvYcCVHf0U6lmSVI1yZ8W0oHvEEgmK9Gl6Pr592p0KCx7KdN8QhY6f/1wa3fBK8v4rC37KndVwcu2uZ3I1vhJkoCxHGpRd+nCJscfYoBNCA
X-Gm-Message-State: AOJu0Yz9Lm4cni039BRHaYZCupvu9AE9vgx3b207a26Mvxs/iyTHgHgk
	YmGl7Hhe+J0ygUcF1E8zW27ivXSt18H9PWy3RV2F2x1PiIVYmeEm5RBMriu6ayU7oMFm4WRMn8l
	0Q6C30el7yc1iJhzA1O1CAdJhzqQ=
X-Google-Smtp-Source: AGHT+IGGKR+5FCtct33xIB/dwJiE9tYu6X1vPI2XQVIZz9E+W+FaFgqeJGQjUPXrFLbM2mccU1gdqxGsvi3/sGXM0pw=
X-Received: by 2002:a17:902:a50c:b0:1db:fc18:2db9 with SMTP id
 s12-20020a170902a50c00b001dbfc182db9mr2809890plq.64.1710240459371; Tue, 12
 Mar 2024 03:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710194084.git.u.kleine-koenig@pengutronix.de> <e14f61b16189138baceb72cc3a9c34698787ea92.1710194084.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <e14f61b16189138baceb72cc3a9c34698787ea92.1710194084.git.u.kleine-koenig@pengutronix.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 12 Mar 2024 11:47:26 +0100
Message-ID: <CANiq72nt0WK1m16OMV970TiXgd_+wp=owxH4mnhJM5=VweAexw@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: cfag12864bfb: Convert to platform remove
 callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 10:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

