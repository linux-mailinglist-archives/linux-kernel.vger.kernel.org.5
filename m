Return-Path: <linux-kernel+bounces-69801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23249858EBA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D294D282E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0302D022;
	Sat, 17 Feb 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hksFsBqm"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5F2C861;
	Sat, 17 Feb 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708165782; cv=none; b=IuiAh1NgHd1U/EojQEmhUve/ea4MtU1vUoYbRA3xLjexH7tIVqo/apmqPlNYEcUcWgB7gG03h4I6ne36gBPAVq5F3o+q1SRldnTC32Is3HgpCWI0d+/sCWd605mtki2NgxfJ6wzcTuEREtWZyjSgmtxPDwqKRtEYOVEst12fVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708165782; c=relaxed/simple;
	bh=VrzO+V41dxhca/SyywqcMH7naQUsXR5lBqumCDwyEHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jShnDL7BdsDTxMt6EYR5mzXhhNiKmmBO6AKVdRPM3AJjdB38SawxcV4w8afsi2Wj164THGjg7t/ut1NX6r1apeCviJbauxHtvzrxQK58cbQRKrKmLlU/9GCcUCSC0kIr/IddqOAMIcA7baqAWMNpFqN0Ha3pre1fXXW6TYqbs4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hksFsBqm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2555804a12.2;
        Sat, 17 Feb 2024 02:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708165780; x=1708770580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrzO+V41dxhca/SyywqcMH7naQUsXR5lBqumCDwyEHw=;
        b=hksFsBqmwErng/jaYk6xxnXoOP6spkzg479tGTqxgImq3xtCHTFWaI7nKVcheTh/th
         FmMjEtsgBJQkgDxCBAKNgey6tPNz82WQiKs+tQyefJsJFGsmlnx6nLQfYSxGohO2XuwB
         zcDe3VVUYM1zp5Z6wMwZkIjKYkmYVyCc95JNwYFUqc2ieTWYoJLF92opuBcToM1UrMNi
         twB+tQyL4Ww7su7SJfqLyf3dU8UT4R2vwfDZslKpcj7DFh19L6zQD7XXY4OtT/gDW3gz
         QAjiDNVoscVpSdP0V9k+Emy6sElR9o7vOT6vuleevf2Dc75JSPfJ9BMAwBZlnQR7P25O
         nk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708165780; x=1708770580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrzO+V41dxhca/SyywqcMH7naQUsXR5lBqumCDwyEHw=;
        b=afHHPNQOuOdZlSkxHDYJq/s7FPD7ZT4Caehbfp3SObZNwVT+wQBGEH1Hyb46QEEEe+
         s55aoJX/7rf/UsVaGd1BXLY4VSdCzh5r30qJUVNL3Cd2jtov/U1BUmanxBzUQjKZLxuA
         HQXX3KdnpDQLGdqm60LVDNUgAXKE1SBdpJ0iGHjpdglAKqYJj6xWfTUUQjcCQw8iq9Dt
         tp98mwQxad/BJDIWIUMuon1TO2tNbDiES/LzyDtj5tmgHnMq0RT4ME3+Odk/59P/ZhZs
         neSNyLjcnWSobonE44ziNUTbNUoWajYI5REl5LzgJiNLm7p1rk+0ksqGaolAQxNZ26FI
         fmbg==
X-Forwarded-Encrypted: i=1; AJvYcCXtXQVEQNlZIUyE+DRy3RY8Jm603M62z+PfNoWE1qIqnrti5/Yo6oB8k+Po/zC5FHwv7xYrGDlDma9znA2DP7I/AaENTFvC+PHuDnHNBc3IoS5vbGJfpP623iISBSFfIXUhq23HxdMDKx4uHiV6bVKaiPDvjLL+ftg7CB7DSGMI/8qsQw==
X-Gm-Message-State: AOJu0YwnUPPTJt9gTn9OjVASLyXOcx6b5lygbv/kJ3SfRQe/gmn3IJCq
	aErgz3evNw77ah0Fanq3imFmMKk9fUWnmitaTPaebV7mbUlbuHNrSs5dwVb3tmKU2wL/7hpdRHh
	MUV1x3jF/jla7kRIVZAyWAr9GOg==
X-Google-Smtp-Source: AGHT+IHakSGlmJMLBQX513NttIL4eDIh7TDxEtRLACm6Sq9uL3cZeiwnsWdJMjabGzzNj9G2w+8AhbXesEW0Gy7HiQA=
X-Received: by 2002:a05:6a21:164e:b0:19e:a1a2:4c53 with SMTP id
 no14-20020a056a21164e00b0019ea1a24c53mr7137669pzb.1.1708165780012; Sat, 17
 Feb 2024 02:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk> <20240207224546.44030-1-frut3k7@gmail.com>
 <20240207224546.44030-2-frut3k7@gmail.com> <cd8c2f79-2307-4ad8-90c7-747d40f14ede@linaro.org>
 <CAKEyCaAy9U_qQ=pXPYaGetEuuuVuoejxjKPrG92fBFauy1wwuw@mail.gmail.com>
 <263bb77f-b91d-4139-91a5-0ddeda0ece17@linaro.org> <CAKEyCaD=2Md8f=K0pfAFmSCQjL0PkBvAzG_g5Me-wpd5iv2rVw@mail.gmail.com>
 <18583e61-bc7e-47ef-ab2c-c669785dfd08@linaro.org> <ae0827d9-416c-4547-8882-44dbb46931fe@linaro.org>
In-Reply-To: <ae0827d9-416c-4547-8882-44dbb46931fe@linaro.org>
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Sat, 17 Feb 2024 11:29:28 +0100
Message-ID: <CAKEyCaCteCG+B0H4DTRtZ3JcU1_-Qimc4iR6UJDCokvvkwPydQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: trivial-devices: Add qca,qca4024
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Peter Yin <peteryin.openbmc@gmail.com>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, Michal Simek <michal.simek@amd.com>, 
	Marek Vasut <marex@denx.de>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Fabio Estevam <festevam@denx.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you point me to some example?

QCA4020 SDK can be found here:
https://github.com/globaledgesoft/Center-Stage/tree/master/QCA4020_sdk/targ=
et
and QCA402x Programmer's Guide:
https://usermanual.wiki/Document/80ya121142dqca402xcdb2xprogrammersguide.20=
06247590
but I don't know if this can be helpful.

On Sat, Feb 17, 2024 at 9:12=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/02/2024 15:47, Krzysztof Kozlowski wrote:
> > On 16/02/2024 14:39, Pawe=C5=82 Owoc wrote:
> >> To be clear, I don't want to add support for the QCA4024, I just want
> >> to use this SoC with its own firmware connected to another SoC
> >> (IPQ8072A) via spi.
> >
> > I know and this does not change what I told you days ago: this is not a
> > trivial device, IMO. Please open the schematics or datasheet and check
> > its pins.
>
> To clarify: this is not a trivial, but "regular" device, so I expect
> standalone binding and at least some basic check whether devices has
> additional resources.
>
> Best regards,
> Krzysztof
>

