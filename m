Return-Path: <linux-kernel+bounces-67727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02B856FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27AEB21430
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF6513B787;
	Thu, 15 Feb 2024 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nTRuDXOm"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC361419AA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034418; cv=none; b=twKX6zbMZWud8sEuzn40BdU0rWXmbKNI416RzGGKZVtHLTvUqJhJtUfyXNvJL2PO/dhUs7hvMGFleUk6++h+N0MqN1tvep3n+X435rZBbk5hEk/iNlPWsOpvS/F++zpydhJTgyODgW/iXGkFKlZUHoOcPD1xdUfduGJYsB9h1oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034418; c=relaxed/simple;
	bh=0YKpEVkeMzTYXQ240hkjanF7zviyBcRY4VKKULoEVNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLCr1klKxjftvzaj82T2J3v4leRNf+VOSP1zsQ2pZUvj9nOeMUBg3b6Sgi6moeWUyoNqrz+3w+d/7SKKV3/FumLFIZ5dNvYLgbyZNDV2emPzbY89C192Za9a8XthqD8XGvfLoo9w/PnOnCuU13gC9YcIC/9rxIWwsCx8STes0VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nTRuDXOm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d93edfa76dso460815ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708034415; x=1708639215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gs6NzoFHCnkXscwFWvqskhg9gjZlTzzaBFX4/MoY5Y=;
        b=nTRuDXOmS/b5rWd5YFJMV3jKVVLjOkSdL5d3fII7/e/iung5RcdJfoY0fQlQay7S3h
         m4HHCnls7jhfyWUmd1weJr6mQmKbu1bF96EEu8cH/A51NpoRIcIKQArTgTogzJqXabgo
         n1SqtJIswpivPvzqPLl/DFzZlgyG4YN8Lb9mf95L2G4WzA+VXif7u4KlNCO/vMwLn7K0
         1C9lI23gwWIV2dWY498tyXSgIauxPShw2htdteQR9EfUzB8/zH4pMEkYXvx9X1U/Bz4w
         dyGng7Tu+m5skms1WwmaPH7GsutzKA6D5heTYh/UJ/zd74Cw+c3FOjCZjJDEHzNvbXA1
         yDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708034415; x=1708639215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gs6NzoFHCnkXscwFWvqskhg9gjZlTzzaBFX4/MoY5Y=;
        b=E7A+RCRxtobABddvPKT/UgHy5ZzIq9RwG5QhYnm5WcyYVEBFFtDnxe1xFCPFyBiWmy
         +R8tR1yxDnHPiwT3O9/Y7Zh4Hm9mEabS4rI6v0ZxUoXMtt6P9VgIXYjG1IgoJUWrflxW
         BkXPuTMiq9Lk/ERftP8l+zx50fAcxnzGL+U5tkY6wZ9qcNfRK1d6D+MjUIZhMhGTPKO7
         x5+dX/Wsd+FLD7nuuiXR0CW1925uMI8mHNsZOBQkWYYMwrrl08K1wi9tO45aabCrN/NN
         YO32W/61CT7L2zVch2fJx2xw9Tp4aaz67EO70a2guT5oVMlelcULIwlAKEnrPNSGhP5f
         oDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1O2tz+VtIFQdWbPfiW+3gd8uAdeq7kw78aizhXXE+s0N0VhUUvY0ujI8yKbhDRmFBLoOcaqTpXbzyhkMVz8EwoS44K3xOPI7CSsXt
X-Gm-Message-State: AOJu0YwSnkTwp3padBOYxYzOSCT8uGcYafiwR92Xg558fXBRRdzbJHhO
	cUByxwcLECtFldg3y5Ne9EHoCVCS34Rgpk355XTT/RSYffKWAfLHCEtLs7+fJvH/G7z22odl9OS
	xup1weci3+x8HztZr1dEBwiFRKYA=
X-Google-Smtp-Source: AGHT+IHUDH5HqCEHGcEyjZXHmI5Xqq2dmWkbTvIn4GOxHNF2G+rYrxFr0nbuvjQ7lPuYMA7DRSmSDmv1O7wRb/LkOIs=
X-Received: by 2002:a17:902:e5d0:b0:1db:2ab0:f3de with SMTP id
 u16-20020a170902e5d000b001db2ab0f3demr3897384plf.13.1708034414315; Thu, 15
 Feb 2024 14:00:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213142831.3069049-1-jbrunet@baylibre.com>
In-Reply-To: <20240213142831.3069049-1-jbrunet@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 15 Feb 2024 23:00:02 +0100
Message-ID: <CAFBinCCELS7ss0KBW+iHeevVWQzO4Sz6vTP4=E01u3+o73-HBw@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: meson-efuse: fix function pointer type mismatch
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:28=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> clang-16 warns about casting functions to incompatible types, as is done
> here to call clk_disable_unprepare:
>
> drivers/nvmem/meson-efuse.c:78:12: error: cast from 'void (*)(struct clk =
*)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-=
Wcast-function-type-strict]
>    78 |                                        (void(*)(void *))clk_disab=
le_unprepare,
>
> The pattern of getting, enabling and setting a disable callback for a
> clock can be replaced with devm_clk_get_enabled(), which also fixes
> this warning.
>
> Fixes: 611fbca1c861 ("nvmem: meson-efuse: add peripheral clock")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks Jerome!

