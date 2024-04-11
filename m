Return-Path: <linux-kernel+bounces-140335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F168A12EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CB91C2181B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73671487C5;
	Thu, 11 Apr 2024 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYoGdsT1"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF5214A0AE;
	Thu, 11 Apr 2024 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834855; cv=none; b=gZtnUmmE7FTFyGtaxMqdBqhP7e03W9DhjV79V4mTfr4my1Xg2w528j9UQv6vaTfo08RUUiQk1cNnRkXnL9bjJ61CDoNMXA13Qcpwnz85SK4iJm8QU4DjeyvD29+W/dO7jqtLbO1WMGG7IK/UrxPMrRWltKiF6gUSfuR4HMZecJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834855; c=relaxed/simple;
	bh=pEPBqeAYoMzDCWxRgfG/69Jmpftv9TJ/hXdVNM+Wvtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2UwezikbwskwJtsSkzxBPfZmA2RmhY78JuzbfNaOylBpRw7B/8l+Xi8gwc9jPDDuZ68rjDCnX/CRGaaRUR5Dqmp0T1ka0KpOubqdP9v4JKRE+ns1gQtP+AGgqVN3BEv9pPhmBbS30vEx3SzaEcciVWKNINdOcT298FyY6g/Qws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYoGdsT1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4702457ccbso986059766b.3;
        Thu, 11 Apr 2024 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712834852; x=1713439652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEPBqeAYoMzDCWxRgfG/69Jmpftv9TJ/hXdVNM+Wvtw=;
        b=WYoGdsT1QqwGPVldwLpf7yC/Qg+S/8D7Q0tj6nL4NZpxEQdg7IQzz5H5cD8IdsifPe
         CqHn9cQHGiD9htCNBJlaif50k1ctgEZbMyJsh0hhrnyR8ToYFTHnFB1ynbcEc6V1t1mN
         /jT13EyaDnquDsDZ/ltjCxOD3RAwQ/KfLchZA61HWR1Ag+had8srDfdpP0ka1DLg+k0i
         qIl3NZ8hKW4Egk+7/v+b1nJ5Y66q8ImijR7ldqI4mjwsiEsoPmlVicPcrh6t0U8B5Azw
         Q8JpEyzWyFIkPChhWJA4dn/MmVWt2g2NEiqWKfJczQiDKjTsc3z/ZuW0d6sIGRf06k/I
         rtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712834852; x=1713439652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEPBqeAYoMzDCWxRgfG/69Jmpftv9TJ/hXdVNM+Wvtw=;
        b=LQy1RpdaqMNMg6F3TGnrr7if0G8NhcdX+VSmtVWzfUNG2k5D+mUUVWhYACGSvCLKZa
         h1rR9OS+uxOTtfkPTSB2X1xGhy0INXQ9p2XaxZgIISyv+VWkyoYlh9vSzet6QXqwrozo
         oYo7Jp8xZZ4hBbZBJaG0okRju3OaodU2LCO4Eimfid8IG1p9JcDG3Kbov1jLre2tXvfP
         tOESwtH5R1m3guypGH2fVgonVRxzUDlRVQly7Da7hhsdPpF2mER66qlh+69k16Bfpui6
         K56aPQuFhXzMOscygVOBIesBpd89e/rlJJU6dIOJE7ps8Xf/rt+QR4VOiBKL1lgVSUL0
         RvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJdJaGeT481RvQEEyx5FKzEyLh/ojAe2NuXd72NTk4nSNLTNtBTeeis2sJUTfVO/TY4PhYUsWxTBwtjaybC3GZ8Q79rv4kHTXT/aQ8
X-Gm-Message-State: AOJu0YwipTGnsseBFmwYaqnUvqtw2mWY+ibs8eueJxWq9LaP8pJpi7h2
	QTEnO8rfD5r/5PeksWQ96uq2Hx6DVQfUJiM7vJu6PSSyeVvg10JjJMMsQYilvSJBjDSTE6lsptE
	3q4/A5ACaZ48iHldWsyTNZLbpOj8=
X-Google-Smtp-Source: AGHT+IF+E92mUFFdtpNUANWgNMqjMWcwkQ91fGDlFrc79EFg49AYNX+hnHqm1OSkN2DdbtEPzilPP4XYYCDdgrWnzpg=
X-Received: by 2002:a17:907:9302:b0:a52:26fc:3203 with SMTP id
 bu2-20020a170907930200b00a5226fc3203mr754807ejc.27.1712834851568; Thu, 11 Apr
 2024 04:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410063930.1199355-1-andy.shevchenko@gmail.com> <D0H8EQB97VFA.2P27K85EJXCTB@kernel.org>
In-Reply-To: <D0H8EQB97VFA.2P27K85EJXCTB@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 14:26:54 +0300
Message-ID: <CAHp75Vf8vWe=wn62w1yxt5C_Aue9q9C0H7ML7VchEiz999ffxw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: regmap: Use -ENOTSUPP consistently
To: Michael Walle <mwalle@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:46=E2=80=AFPM Michael Walle <mwalle@kernel.org> w=
rote:
> On Wed Apr 10, 2024 at 8:39 AM CEST, Andy Shevchenko wrote:
> > The GPIO library expects the drivers to return -ENOTSUPP in some cases
> > and not using analogue POSIX code. Make the driver to follow this.
>
> I don't care too much, so if you like you can add
>
> Reviewed-by: Michael Walle <mwalle@kernel.org>

Thank you!

> But.. isn't it the wrong errno and isn't it discouraged to use it
> because it's a NFS only errno? Thus, wouldn't it make more sense for
> the core to accept EOPNOTSUPP and maybe convert it to ENOTSUPP if we
> don't want to break userspace?

We don't break user space as it is used purely internally to the GPIO
/ pin control subsystems (which are in our area of interest, unlike
plenty of other users).

The decision to have this error code had been made long time ago and
now somebody probably is welcome to update, but for the sake of
consistency let's continue what was done by design.

--=20
With Best Regards,
Andy Shevchenko

