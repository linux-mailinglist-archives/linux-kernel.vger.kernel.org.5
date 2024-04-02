Return-Path: <linux-kernel+bounces-127660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B8894F06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396761F247FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03458AC0;
	Tue,  2 Apr 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbYEZPmW"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8758113
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051381; cv=none; b=Q/V27fGy6hSKiS/jLbAZJ7UBudntc7tfwI+9d23/eNvgZ1j9chQtFamBInjX2S7+A32fRr7XfFtbxERMKU5YGK871wAo0Gm2tNFDjQ0/FjVGfgIYbG8wqA2eP74ULHfncmyuAwiLSi7zPuA2umPM+fgu7Jh/O8PPnO48weGTayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051381; c=relaxed/simple;
	bh=4/EtvWS0lZMV84j65Uy5L17yPmitKMCnx+1V6GM8jWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWZ75R8Wa4a/lwYhZ8ka/MHMy/Y6YZIknnR+bfSronXLE6Z0lPat4DDrbAgp/5mBHt7VI3YHf/FrM7LFeG0FQVxGOdf3DEc7G6Kk1AyT0HcQUqs3DutN7I75zTa93yH9NGgLwHmMTQXprwMSI+xQRIcsV8rMTTTGLW1qlT4XVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbYEZPmW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3436fec6a70so186486f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712051378; x=1712656178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khWTrPazDRXs/RM2v0O9wjs2bqj7qxq5S67ky2y7oZw=;
        b=VbYEZPmWNXs/aGck0WtQb1eAzJbZPyoIxNAnkcL+fYKyT31jicFzEkcBMQZShdGz+D
         DeAuIy1wdPhBPcWF6r0aSXitYEN9UGg63bVy6fRVohbgu+feUFUtkNLDtC79gHIB9TLf
         lrCZjDqhbZKA7iunj2REuv+1wnJkel/D5bQ0MBtvCs6D1KPtHZ/7LsmbwX+Zs+W+VqDU
         RcMwvDFr/oRDZjmc9f7ob5n9HqxtJ4JH5BIHPPaAsrtUFjj/KpH4LK4qJK7AjU9fXDM8
         I97M7LV4oJkk1aKtUlJmlcy1zIcks3gPjOzSiEY5QR/zUnXpcZuEJX3SEReGvkcycU73
         D0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051378; x=1712656178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khWTrPazDRXs/RM2v0O9wjs2bqj7qxq5S67ky2y7oZw=;
        b=AgAf4DWKEOjFW0js1VmagGPj3KUl4hTpiZvRB+9+rvT9XRCUGuOGMXXsE3VxcjpF0M
         WhDs4DBltSEPvYViaqCEbJvNxgvP81HPrez3wA0XXR18a2kQz1uCcz2AHmVs5Uwl285p
         rKlP8qpOemyb9TUqx5KLdu0LInpxLrsGdHV+uRSq5OPzQPtl0zoq25R6BSltbKzYpWQg
         sVIoKwtaWyDRmfSG3na94ilB7eqDlfkOn3f0oL7NSsUk+Iyyc2nd18x7wSzAuaZYs9xZ
         hzT469zwykgIVnDq4cHZaWkC8ELJo5B/06gxvjzfQlKp8mOxGxJPd3Stz+MXkUYUc0DL
         5bvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUffaFb6WEpBt0L7viTHSOVDgQILAZ/g1WVR8TB6faavw7L0e+GRwQnFZMLqys/wBinmEK4qBqZxH4agW/61czEU5imZzTdiR7llcfk
X-Gm-Message-State: AOJu0YzTXo0eYmMNkpkN8A0JppgY5qgzRZDyFEiWaWcinhz7CIUdH3+u
	8I1LE0H7wRb4L3NVhYh31XyioKZ73sUbz8i5u+SxPSpDL3RVgHUU7rmyFKwd+wBi5fIBUavai5G
	o3pGA3IdxIjsr3vP+rxupyH0XJnM=
X-Google-Smtp-Source: AGHT+IENhD8t5MKDpeopK1nj7kc5PGim4v4nlxjclGl5XXLECh7hx+H71FVqbAxoCfJ/OfxlpBVKd9GpIhiZyFZPPbI=
X-Received: by 2002:a5d:4d07:0:b0:341:cf9b:c8e with SMTP id
 z7-20020a5d4d07000000b00341cf9b0c8emr10357697wrt.50.1712051377736; Tue, 02
 Apr 2024 02:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222022741.8223-1-boy.wu@mediatek.com> <ZgvRmhbvVoGHcLqu@FVFF77S0Q05N>
In-Reply-To: <ZgvRmhbvVoGHcLqu@FVFF77S0Q05N>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Tue, 2 Apr 2024 11:48:37 +0200
Message-ID: <CAPAsAGyzMBgwCTXkBO1xqETt-tvO-gD1=C1Snmu5arhX9SFrXQ@mail.gmail.com>
Subject: Re: [PATCH] arm: kasan: clear stale stack poison
To: Mark Rutland <mark.rutland@arm.com>
Cc: "boy.wu" <boy.wu@mediatek.com>, Russell King <linux@armlinux.org.uk>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 11:36=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
..
> It looks like you're specifically referring to what arm64 did in commit:
>
>   0d97e6d8024c71cc ("arm64: kasan: clear stale stack poison")
>
> Where the commit message explained the problem:
>
> | Functions which the compiler has instrumented for KASAN place poison on
> | the stack shadow upon entry and remove this poison prior to returning.
> |
> | In the case of cpuidle, CPUs exit the kernel a number of levels deep in
> | C code.  Any instrumented functions on this critical path will leave
> | portions of the stack shadow poisoned.
> |
> | If CPUs lose context and return to the kernel via a cold path, we
> | restore a prior context saved in __cpu_suspend_enter are forgotten, and
> | we never remove the poison they placed in the stack shadow area by
> | functions calls between this and the actual exit of the kernel.
> |
> | Thus, (depending on stackframe layout) subsequent calls to instrumented
> | functions may hit this stale poison, resulting in (spurious) KASAN
> | splats to the console.
> |
> | To avoid this, clear any stale poison from the idle thread for a CPU
> | prior to bringing a CPU online.
>
> ... which we then extended to check for CONFIG_KASAN_STACK in commit:
>
>   d56a9ef84bd0e1e8 ("kasan, arm64: unpoison stack only with CONFIG_KASAN_=
STACK")
>
> If you can fold in the description above (i.e. cite commit 0d97e6d8024c71=
cc and
> a copy of its commit message):
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>

Agreed with the above, feel free to add:

Acked-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>

