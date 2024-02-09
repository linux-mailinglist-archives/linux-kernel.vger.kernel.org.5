Return-Path: <linux-kernel+bounces-59358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7FB84F5C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA281C2182E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E0938380;
	Fri,  9 Feb 2024 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGKaKcTO"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C7374F6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485141; cv=none; b=lpeiNLnveZ4NagVd8opIMGv/eXEQZADOehHV/21yVGBkmquuUHfWM5i0ZpWC9NqQpW6QJS+JoQ7FmfzLXSSJWE0zrRtgGM/II2aaUbdBmYomgs/XAJEUsXc/Fp0ErPWT8idCOA1IPUjz7dEY+v15ycON848ERmdXxP0K25Ki9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485141; c=relaxed/simple;
	bh=IRmUxOo8xpxTnzyDJCNyfLb+z4mUKnik1Xz78qZ/PLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3Y7CFBKStpgT6W5Rd0DNfhEBK3pUB6VNey/Q8dLMJhZ4PM7Ic5ZS8evR7kNAqGZ5YJpv2NdVTtRQLlJv5suMFi0eEmPcs0kyEZLVO73Jf2f17Va4lvAS/dZbL406xozthF15+hZMyAlsf6ZVMBKuAs6FPwB85TucpSD+e9hUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eGKaKcTO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-604a184703bso9986587b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707485139; x=1708089939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRmUxOo8xpxTnzyDJCNyfLb+z4mUKnik1Xz78qZ/PLk=;
        b=eGKaKcTOx56l8syxpmNdORtvfXee5tlq8LQKtoASetDqHFT5gAAcQ3ZdrDp/N2bpOf
         A2GuCZBV7fLfOl5E3u5IK7XofXkJXx1avvcUcuPxuKfO+N4UWtZYisX7buCcM0kD/7xU
         bS7d7xBy/xtX7/T4bLwuSpcmL1JODEn1W39VebRBDvgbIzMcpOSk2A5a2l0JOA9h/Fip
         7frhE3m/eQQ7s3xdezZIcAKIkAgyTpK85KdXYSNKzI3dy7VD8sux5nBltNqJC+ofG6aY
         zOLues7a4ZQEjHWfS0EJUikRMQnCvPCAPvMu2oGf3lQ2F/hDELSrvdZJVL1wEC68YGGL
         xrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485139; x=1708089939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRmUxOo8xpxTnzyDJCNyfLb+z4mUKnik1Xz78qZ/PLk=;
        b=W35fFwl5KM7oc9vBvTm83FZZP5hTovHwoJFnO4RkoOxmT7phsdNWzkTnaj29TWyMP/
         hIHe3eoyDEgXIaiDgzysSGDZW2iuapn6nBsrOmfuPz+swa6eRNe6LIxeqHv5rlwupByN
         FEC6O5Y88uQJckgZYZtYpdNnseKquhT/w8T+Ux/YdRX3kd0KA2XDtpg0TUNk5rm+MXVn
         8DnbmpPghCF8r6teRxw+2HrEFZQzu3/XvbJaknIVI+/jeEfv2o5xUvMUBlqzpqM08IdC
         7hykrDT7gMjL5TWkwcRWagJa340S+8IWyQBA35s/M9fEDQBN8GPMyLF1oyBy+uX8ibkE
         mcLA==
X-Gm-Message-State: AOJu0YxAQZ2foH/QcF2SyU3zmF/+QWL5dOHwA+RfTcuEjnPcwLx2HBtR
	MKOPP7q164aqg4FAlLY8WJGw8fNka2kbXrC8uV5gUW70I0JE6QPpz2JyM0vDnqLn90PQKVHcPg/
	45byrydYvTFFtrQxLe/15oPM/EsnilS6YxCsYwA==
X-Google-Smtp-Source: AGHT+IFKR6S4/G9DmrvM0mEtaFdZwkbCXlZkhaqKJtQhDFVowF0KrwEF85bMCAPU+yFzG20W3ToCXZz9/ObHLrZrmKg=
X-Received: by 2002:a81:7255:0:b0:604:9c2e:923f with SMTP id
 n82-20020a817255000000b006049c2e923fmr1452942ywc.32.1707485138749; Fri, 09
 Feb 2024 05:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:25:27 +0100
Message-ID: <CACRpkdaCNJ3g2gRWmcrBQ3KeXwfH7i2Xpmnm1NAgi2+ASLwMUg@mail.gmail.com>
Subject: Re: [PATCH] gpio: constify opaque pointer in gpio_device_find() match function
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 9:27=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The match function used in gpio_device_find() should not modify the
> contents of passed opaque pointer, because such modification would not
> be necessary for actual matching and it could lead to quite unreadable,
> spaghetti code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

It's what we call a pure function, good const-correctness fix.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

