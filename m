Return-Path: <linux-kernel+bounces-111611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190EA886E83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F4B284CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CCD481DA;
	Fri, 22 Mar 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLeuuvT6"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386A47F6F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117701; cv=none; b=kDBnZwSTlwrKDkNQM5oZiM/F50B2ubuLpB0d008s3isu0yB6f8sp47iPoyUqWeeG52GsQ4ZHran31Abh7NrbGJxUojJRLYQMRO+aQbt+rvAxTlA7b91Pdgw9nwHTjjsMeAHwfUbcCvog3wprA+i0wc3d2a1fpgSBVnMsaXo7aqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117701; c=relaxed/simple;
	bh=BSRa5G43mi7MP+cPzwPAx8XvxMHOExGKnRxZJXFXEKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJrzsyNnvMXycGkgY6k0KI06tJ34RAmXALXDG3N8Pv2gDB1nSbReUMsIWMvVaB9CLTBgLMlC2kt1pq83QyK0RIaBO6QtXEKOwiFO1I/nSPFQNDIJs/9GIm5/9JR/HLEdET7VxQAEkKBoi4vafPfPWh3z4mqKLsNp/9LyLaSvaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLeuuvT6; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607c5679842so23560737b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711117698; x=1711722498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSRa5G43mi7MP+cPzwPAx8XvxMHOExGKnRxZJXFXEKM=;
        b=vLeuuvT6G/phlZZtOpqaDnbCp9AccDlki47Zwz9z3aR3LKtZGvC27XHwGs8G3K55jb
         yEjNFKfd8ssFprZGPoooshMwt8d6W8FqrvjaPwaT25NoODY0gbnLHdP58OHFIJw5AKlp
         Kl6IkkkPB1KwmaVm+oQHUkKidldOPVzYGzspNZrMDwzQDXp77y0s4ukF4h/Zj59/Jz1J
         iw6qeS1m2Ij6W+yRuqIyQ1kJqULDwYj/vfuYtC9IqgQuZkJ+qBqMXk5M0QLLIGsyYsDm
         30aPtY4Z+j9JdUaRUvZYA5DztLaKrXtX2yhC83KCfVxaFe0KdRz4UpPhvpTL/Y22P1YO
         C8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711117698; x=1711722498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSRa5G43mi7MP+cPzwPAx8XvxMHOExGKnRxZJXFXEKM=;
        b=C8O84tM2w/+L1bE8vvjfLTycMY/XD7Txm6hOivm5Azpkh0W01xUTUHi4bYnokl8bUg
         3BDTgO/g8CfsDAt50E3vYY3mB9wP9I2sD469dKcg/jV2830c6EwzTr2GRtWY6tv7X/w9
         4nRa5taRYIpxpDCC1H987pH2ZkXDPWnVHQ1LD3GMPEbMXeWLUgg+fmhV5L5z6FmO+Lvd
         GfS6bxn+YUyd7vJcZzm14LixFa3dWb+Y3v7pHxexPCCocHHeLSKR0cx6qYvAqb+At58V
         NepxlUmIn/UsyUWzOLdGY6QvWp8KSUVDQzVQDmgZqrWzmejaz5FxuTNyOfiHfX7WZm4u
         C83A==
X-Forwarded-Encrypted: i=1; AJvYcCXkvJNPaMEfGC/MR63zo2H9hAOw6gJkagf4hU8TYBAO4q63DzUcpNqyg4JGtrvvtwjPXqiByGRz7SHTSkrtzPvpPfAldMCrUa83d0CR
X-Gm-Message-State: AOJu0YyzhFu1391mOwZ9CcmMp7zTbZpRFWqIRKjshlgfhDbvA3/rwVeu
	TUsOHzUHCatKIYKxXZjsZgv/xl0qC2ZHW9SHgxg7X7nqaF7usMF37btAhuTK+3jImqlSLkMdm9V
	hT2mIIQJGyczba/KrZfysXz+xLMjHg2wIfYbq0w==
X-Google-Smtp-Source: AGHT+IGqQVjMZHkKIJlkFsR4RJeZUKLo2QeeLI2k4huSnpcBnZUsNA0a45bgAtTQ7oz24BVUerld1XlhOi12G93O+Ho=
X-Received: by 2002:a25:83c1:0:b0:dcb:fb49:cb96 with SMTP id
 v1-20020a2583c1000000b00dcbfb49cb96mr2127472ybm.31.1711117697064; Fri, 22 Mar
 2024 07:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com>
 <36198864-579e-41f0-baf6-917f0a7f4bfa@intel.com> <5767438.DvuYhMxLoT@kreacher>
 <5770245.DvuYhMxLoT@kreacher>
In-Reply-To: <5770245.DvuYhMxLoT@kreacher>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Mar 2024 15:28:05 +0100
Message-ID: <CACRpkdby5dY7j9=r_dq+at_sqFduJWo15zt4tj4fvhY-KgCUYg@mail.gmail.com>
Subject: Re: Bug report: probe of AMDI0040:00 failed with error -16
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Francisco Ayala Le Brun <francisco@videowindow.eu>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ulf.hansson@linaro.org, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:33=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:

> We actually can get away without defining a new IRQ flag, as in
> the patch below.
>
> It is not super-clean, but should do the work.
>
> Linus, what do you think?

Uhhh I rather not, the other approach will cover the invariably recurring
instances of this, it will not be the last time we see something like this.

We need tglx input on this, I could merge the patch below with some
big TODO to fix it properly if the discussion about the proper solution
takes too much time.

But I rather not hack around with IRQs without tglx (or marcz, but he
got overloaded) input.

Yours,
Linus Walleij

