Return-Path: <linux-kernel+bounces-155095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874748AE53E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B241C22D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE2613774D;
	Tue, 23 Apr 2024 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjU+dy/r"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4884FD9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872824; cv=none; b=cqvE8XGI2mFf4n5cZfftE/f0E9BO5STOtrKvOhU/eO/p8SaDWgT+pJitaZvCZUd2Vco+YAW1gIlIghEVwRyxVsqvi/HIWJH6/pVlnIh5YrWpFkZkTuzD40drylXEdlTAqLaHO3c6JI3GnEC7gtYpAJVq9jrhN3PfNKzH9kYT49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872824; c=relaxed/simple;
	bh=X3u3N1m8IXHPJ/XYLGkgdbqWKFrGFYVK3qndJ9iJp7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XP+GJA8U7C8IV1weyKDyRIvZ+tZmgGgQdmKMqWqL3G0oibSLRikJcBF5LNESDPEf/w7JlYZZ7JpekUFzRF3pS6igm8d7pNuxWvIkYbw6QFEIXfzC3fCvgJKCiR0LtxyWLDICeNufiS656G++hcHupK5TZHQ8UMEirn63jyN6B0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjU+dy/r; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61b3be24dd9so27812737b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713872821; x=1714477621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3u3N1m8IXHPJ/XYLGkgdbqWKFrGFYVK3qndJ9iJp7Y=;
        b=cjU+dy/ru6qYGnLhcZHKAmuaq0XotP0dcOx2EdS8+BsO16akc9B1IrJbndvw+eiGr3
         aUIrm9kTW3heN5P1R7BiuWHL1AjYr4pD4XFp7ULUUzATwoycx7PYT3xzW9SI747pX3QE
         t6xBZvvTqbKZbpYYsjxMPQgBp55Zfew+M3gBSadCGMeFEq1xXNNNyrynufB6suvWLk/V
         eWB9Nvn3ifb+/Xge++spQxr6Juimgs+uJCPCJOb3aKjGeEwdDBIwCKobYZWRHUp+cp31
         Oj+M2MGELlZIRVfEBFoI/tNKLTT3cMBb0idwyhw0N9KJtLHxYeycH5QhxGHsDD48zY4v
         6zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872821; x=1714477621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3u3N1m8IXHPJ/XYLGkgdbqWKFrGFYVK3qndJ9iJp7Y=;
        b=JQtKXRmojrBBjxv9gtZ0yJfyx/obwL9BLR8RSAOyKW8UiFDqekbQNHVkXy1eireadO
         Hywr4xavB4j7n0aRl4nIf+Pbt/DNB1Ja+3xfSMCafrRIBWts1lWYNsP3oamIYx/Suz0b
         9TXAKKt/9D7uwr34/pkv4eafweM/wr71Te8BORjfcAYXUTBmU0Vf4MEMOFSOdfLY+JXP
         ChYKBjUmdu+SrYOgACcwTwAvdeE3XNjSjPwKQeCC9aJWCl6hiFqznDA2UB+vb7nMPOKe
         9nfhiWHLU/b3gjrp5FYZVQW2gKoDJEgMxjkkEiqyTvwGZtq0VRRA9qfWztkOLdqpWHMS
         VzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQkKFumQcPoTTjxA86JgTh8oksujmdk8vF/iopRY1OHZFoNk5jifezfAvErVmzfExRoGoEdhI6ZK/+YU48qb8Y4gDT2Pw3KpOtIDvW
X-Gm-Message-State: AOJu0Yygt1SUTZbGPHhpRvpNqkKOMP38ahIUY1y4arAa8PUm2Sh5KJe5
	yBLRvHnfw+/hnk/yHPq5N5jOsOPzqWKvMEFP5VE4T/+kFpIz2sZ0hndKxlUOZpH86q9LcehIwbL
	32BADoSRKq40Zv6f0iAbYAfRLLTZhVbEpkP6CgQ==
X-Google-Smtp-Source: AGHT+IGRJi/HpxT/aRBlek3pLJoeYyhkd7E8KqK5Vhw2r1ncz4Ds38dt0J+jITOwBaZfG/c2/Cl5CRFPk5Lh4qfhQAU=
X-Received: by 2002:a0d:c885:0:b0:61a:e7a7:b3df with SMTP id
 k127-20020a0dc885000000b0061ae7a7b3dfmr1914512ywd.15.1713872821364; Tue, 23
 Apr 2024 04:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
 <20240423-for-soc-asus-rt-ac3200-ac5300-v3-1-23d33cfafe7a@arinc9.com>
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-1-23d33cfafe7a@arinc9.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Apr 2024 13:46:50 +0200
Message-ID: <CACRpkdbata8PG0QP2NXVqCdLhpxyKWJkK+tPSS7JAvOTiZ+Wig@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
To: arinc.unal@arinc9.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:51=E2=80=AFAM Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 R=
elay
<devnull+arinc.unal.arinc9.com@kernel.org> wrote:

> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> Add ASUS RT-AC3200 under BCM4709 based boards.
>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

