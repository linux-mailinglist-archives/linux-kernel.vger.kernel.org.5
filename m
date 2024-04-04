Return-Path: <linux-kernel+bounces-131101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46689831D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFB528C8EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B706BFA2;
	Thu,  4 Apr 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVCViixq"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812B679F3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219006; cv=none; b=LLhl0MoMGsJRkWqCMC2IgSL9GQI5QZnh5Yf2NO4HS41VSAY0TdZg8AfzibzX3rD3093Vc9kK51q1pAIsPP9bACJdKp+WAtcvQMhvSmDr7vTQO1HsucL/dc3fOem6DtnZ7/CqYbRz78ONDRmTWrj3bvIsgJEuWbudiq7tTizfwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219006; c=relaxed/simple;
	bh=tUkPXupaLm7fsLyPKoLu5BZRQ4nvoD4y4GxTbasq5fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYqIFqmP8iTvF8cL8bO/i1FusVMVEDxFsn9IHu9LqZt5l/Y76Tj5C0ITsQr8xrCITujligc1jMxBMGZUkTWjAxxc6JjBouMTUhbu40vxUwERdgBLI38C5lK3CN/abFCrVgQrA5C7xFgpA6SwUMf5q3a1aEf+NynumZIfys84+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVCViixq; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dd161eb03afso699915276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712219004; x=1712823804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUkPXupaLm7fsLyPKoLu5BZRQ4nvoD4y4GxTbasq5fw=;
        b=QVCViixqjofNKCz81WTazTp1kChJdJbdSxaCANTWnqo+9yS2nzE1Q445ZsofG4O9+Z
         QW7QEjaUyK+1qd+te45AhCxTkTv8TG6ObhOso9wJUfpvcsOmEIqi2BPKXj3Rbz69+gBh
         mlVjt70kPzoRbVSq8pyakOGPtVOz93llz619c95bXcpjxEieZSeKcS/OQvZJ9wpvoamd
         /DziaJCbqIp/LIwLOhMODPDVG0I+glQI66wDgGkrYHBcP2zz0/I9FKtegsVKTzUE9rdg
         hzFMXkU88/lt+16BP/xvHYM1FeV48LQlebR69F00MNfmBitYxuRC7YJbuXXQemKrrsbb
         +5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712219004; x=1712823804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUkPXupaLm7fsLyPKoLu5BZRQ4nvoD4y4GxTbasq5fw=;
        b=v6VKOikIX3Sm2FtlPZN6L1rn/vfpNVjZ4qcFqBm1DwgUdjuNqTgj7IFp8jJNN2ocnU
         nhBvUwFbTshMImQ4N1rvctVd3ZERjxZJj4sbKChV1BB4yVMD2JQVbtZc1XWl/j0FwHLO
         4lDLhg+4xEkUvYXHxqDXIaLbYqbmuQGcjRWsAvqMMmbgUKbKPWQRdF8s3/1xWn7Impr5
         MUJMdX/GHHqIzOoaTDib+MNogMmiXIq78mhA36t4m0ItuCDztAYrLPdvvMJOC6tgDSl1
         eIFFaFovy2jaubsC7n1egR0bKHH9JwbH0QlubLfa+K1rBtwXErQCCV4FqdtpN3BV4bNM
         snxw==
X-Forwarded-Encrypted: i=1; AJvYcCXTjhjvEEKApB/YecnMiirEAVUmXs1YC8KKt7Xl1sCFKOL2IoTvzn2gJxiKXKi28KDHeRro5rniUReeaL7XfP3O9iljy5DTOevGyI9R
X-Gm-Message-State: AOJu0YwQt7uHd8XWuYYdYQSrHCjocOGw3YGHaolA4Ei2f9+WUyRyqIgn
	rr2WiD01R6tuVO4gEErkOyt/KcGjyE7UPUSnKAFkMBjxIdHIeT5Ptjpu2VLjNOfdRP2ViFb9C+d
	sOPORF8nyqf07BaSv5uzioFhgCvdy/z++Y5jW7A==
X-Google-Smtp-Source: AGHT+IESU9WLa3h8aZDesnqNiyXJbZj+fNufrMd2QMdK0OU/9kP3JNABg1ywIrSqCK1qb7HDwP4jhkHml0tcg8LZkz4=
X-Received: by 2002:a05:6902:c09:b0:dcc:375:2257 with SMTP id
 fs9-20020a0569020c0900b00dcc03752257mr2023598ybb.0.1712219003651; Thu, 04 Apr
 2024 01:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327091336.3434141-1-wenst@chromium.org>
In-Reply-To: <20240327091336.3434141-1-wenst@chromium.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 10:23:11 +0200
Message-ID: <CACRpkdYi=3ZYVQGAAwJ5iYNX-WY1OPTX_xuP3H-xJj9Q+b+RRw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: mediatek: paris: More pin config cleanups
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:13=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:

> Here are a couple more pin config cleanups for the MediaTek paris
> pinctrl driver library.
>
> Patch 1 fixes readback of PIN_CONFIG_INPUT_SCHMITT_ENABLE. The function
> was passing back the disabled state incorrectly.
>
> Patch 2 reworks support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE, following
> discussions on the bcm2835/bcm2711 pinctrl drivers [1]. The driver is
> made to follow the definitions of each option as described in the DT
> bindings and pinctrl core.
>
> Please have a look and merge if possible.

Patches applied for fixes, it looks like pretty urgent stuff, yet no feedba=
ck
from maintainers for a week so I applied it.

Yours,
Linus Walleij

