Return-Path: <linux-kernel+bounces-76473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D914685F7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CD1286EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D446544;
	Thu, 22 Feb 2024 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQeZqzxW"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075F46435
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603491; cv=none; b=oFuf+i3gDvNGG79OOX2Wgr/4BXcoJnhmNyxItCJnHOfllH9dAff1SXvgJrzr4MfgrIMFZdjNQ/PAcjGGzDzeOwH2FwTo0bKcPNegm3IbzjHPSscyt6l1vBZXpngar5F53N683oHBSEay3KumrC6b566UmkcUVHUl3+ZUmrP+A2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603491; c=relaxed/simple;
	bh=LwQ6zairNjvr6Xij5pcXGnpxU3qI3mbPbsaBV6voo6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=th4BtgNUka98jBfEwGfkoQ7V+bQLxv3Qd5wWet54WqMRT0Nc/ERS7frykz6ElFkxjqxtNZ714TnAgBjkjGZA+7d9u7kvQizHO/MAagp4p1b7UTmS4ALuJawG66gRJ7hyDXMHkpq+Kl4MPCexWZX85FkJ8kWyGAgJGVJneOLZT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQeZqzxW; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so7352084276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708603489; x=1709208289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwQ6zairNjvr6Xij5pcXGnpxU3qI3mbPbsaBV6voo6c=;
        b=QQeZqzxWbecbgiIG04+IPb/Doda8B3TkZzW3xOLFDsKReAVYqUJLpkFbATps0Wr3fc
         Y0BiFH3icVzNUrIyT02KR1+0Ngm2RR1T0GlxPaTbtgtRooiomijIlIEu3EmY6ZWWbywL
         iwzJl0EoeSehjkn+J9j8scYsFJLCnaO8QbHQxfXr2DBD5sfqc2vwkmukxDW6wh/t5bo4
         lz/nTnhBDPKZBzOUHhMpkcfXHusGUSYruOoJZZEliyrH0h3BGPgG6nk9OjpLT+uZbhHo
         MJtYvr/weuIlTU0HKobtIwsxqEL/Ls4AKHeHsIhJC+vwraRNrKtAcjH7f9nuBHBdJF2q
         vlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708603489; x=1709208289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwQ6zairNjvr6Xij5pcXGnpxU3qI3mbPbsaBV6voo6c=;
        b=hCsMc0WGup9qB7Q/varfvRFkPORns3oy3ClM0+aouYWXWr5H5yo86PqDmBRjR3fYy3
         vjhiEH8/NFCoRLeEkayIQWzEbh2syqgBqOPERxcem4/xX1Vf84+q4zhzXeSc04zJB9Ja
         ptaKT7waQN9DPVrHw3V2LmzForsDhhBaWGNRdPuvVfPiuRo8E7JIknTby+EBWfZxzJ0G
         pzGNilDviRRtWpABdA1fhszyG6h2NpGrO7P1iraESpKjmzVPS9kCBAI28A7GN7Lb53Bx
         E05SsCeI/1kvImaC9UO3wopItCVGv3y9g5HKGTrlAg5wtylAH6+i5Gl405dSzV/0nczT
         h3dg==
X-Forwarded-Encrypted: i=1; AJvYcCVq27MdokPkdyX+34XIOsZixMUaU9c25Aa5d4uyJuUSiJsADLpk2Nebri3MTDn98krimTt+PeX4d0uwGjQtVK7glZpiTVdPKSS+AeBL
X-Gm-Message-State: AOJu0Yyxxjze45zRXMeNWGqDvwyFE9fip/5oPcvYPimkm/77lRYSG7QC
	Dci6x1XLEg0F0qNPjLTIJ/PDzug3Ug/03G+3O+j3Nex5ohC67JVewIhMVYA57ftTc8dXZS6Dz95
	O5wZNDCRRf+Zvzsi9Ui5sBBmuS8lBIcErfRC9oRQRZO6txxk8
X-Google-Smtp-Source: AGHT+IFLQHojY9h2dwHgN/0AHn4jJTdW6DKn9NgLX+CiMVK6Ih9qTaDfNM6IaGoEB4QnAxdkhT6psMDV5yn0Jg8SwMg=
X-Received: by 2002:a25:bac5:0:b0:dcd:990a:c02a with SMTP id
 a5-20020a25bac5000000b00dcd990ac02amr1906788ybk.63.1708603489151; Thu, 22 Feb
 2024 04:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222102513.16975-1-brgl@bgdev.pl>
In-Reply-To: <20240222102513.16975-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2024 13:04:37 +0100
Message-ID: <CACRpkdYBji70y7q90TCC-=KT1OG9rNU7zu_fRsLF8FaRR=70hA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: provide for_each_hwgpio()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:25=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We only provide iterators for requested GPIOs to provider drivers. In
> order to allow them to display debug information about all GPIOs, let's
> provide a variant for iterating over all GPIOs.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v1 -> v2:
> - rename the iterator to for_each_hwgpio()

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

