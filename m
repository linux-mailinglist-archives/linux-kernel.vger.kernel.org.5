Return-Path: <linux-kernel+bounces-66442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196FC855D01
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92BDB23EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD6913FF0;
	Thu, 15 Feb 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smgu+PZA"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AC13FE0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986983; cv=none; b=gFAmVOz0OD3C3m+euaS21N7LgkaShu21kAiGMovIL+DByQimBw3gisMOkDorXBxPHU7mfihE5zJ7PY6HeMR95VouV1YzCFPqy3dZbCLnlWC83Lzrwv8fQe9qtbtIN0jRTD3v7mLUosvBaJofkZ0ZgbHW5i05AENTqyelGCtgFW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986983; c=relaxed/simple;
	bh=qshXf0HFNw0V+6ASl/t02jVpBSTOYtjsOwTrGDgKgi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWRU7NMr4ZXTY3PMwrFCoYDqZw01L8EPReHSZ4oz94ZmvDygTmK9p8pUMjv7VviFjNxxjIDDq04gSrc7NEPQM7MsJgqnia5CgS5wCR5ZTFMlIcgNvlmtYPamurbfyIAC9ID+bgwteiOuE7c/D2xS2rxH2zgz58bmgj7UoMpP2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smgu+PZA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a293f2280c7so81976466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707986979; x=1708591779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZwJRwyAoati4WJnxx7rhcBfrLMB6W5r3eHHRAnRiMU=;
        b=Smgu+PZAOd4L91rDNus3t7lQwkOa/AclSIIzc/qQTxAnRqy9FryI/PZv3VkSC1yU1k
         GVI2aVx2rSomz51TUY0irZqABIKyRw1huqXQZFFMOwevAEj0Mtmxv9J3UW75xz20KXmq
         95n/KuztLFNZyVu4gfWlAQl2qPne20Defo8cTlP33nRCJNXngpZwll38ymvbecuhqY1v
         HjIP175yRaOW/X0v5Sc9CZV6g1mPUX7JZ+tAt+U2qHffx4pu3Xw05gjffIbhSFaeRzKy
         U/JrKMxM2BYtPazGbNrKuVQME46Q2TtPHH4FfES25W+fwQJhC4jlwc9KR3gyNgTjdO0W
         nXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707986979; x=1708591779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZwJRwyAoati4WJnxx7rhcBfrLMB6W5r3eHHRAnRiMU=;
        b=A6Pi85Hk0dPJDZE93rTfzF76IAUz0Asj74oJI0a3yKlCaFDRIb0NR8f5c4ekYT5rAo
         kOiL7M62+K20YccV8ELW5GL2sfxeFGyZRzPewi3BAPWxf/bNmnBYmYs6+UiDVhZXMQDx
         +qS5f7WVIXGQkxWJfbEZAk/YXc8ftm0fiIG5NvFSdT8Z6BszHJxa+g3a8vzPqgwH7wrn
         muyRy9Vzoag07z+07lFh8MjF4+AaQGur+IEDEybl98ToFxbC5OAwFvlSeIgy0dOkWng1
         8Q/eskQKrJ6z+2M0FLV0Q7kMo1rGC0cqT0E3PXVbfRBlNBS0yknN6FlO0SC3d7naJeXz
         mFrg==
X-Gm-Message-State: AOJu0YxFTdMVksgROkmbBrirv04stHKtK3v8D7t0q6nis9s1LR7aUTBw
	08tUrHuyioJekI/GztktuHSMa5biyBoXYUurczhDHksoTfOqTntFVmSPMzcAsDYtXpiLiFBfBxf
	qadHAZB8LjyDWIHaLekv5Kj9z20c=
X-Google-Smtp-Source: AGHT+IGgKg6v/TOpWtoulIA6VeaMXtorPkKArGr9nmr8GkBoUSdVvZ+Uzi4cXBj5GeQs67Gp1GElmbVjYoQ6Mf6t2FU=
X-Received: by 2002:a17:906:bc4e:b0:a3c:10a4:7a91 with SMTP id
 s14-20020a170906bc4e00b00a3c10a47a91mr925445ejv.13.1707986979412; Thu, 15 Feb
 2024 00:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212153109.330805450@linutronix.de> <20240212153624.516965279@linutronix.de>
 <878r3mg570.ffs@tglx>
In-Reply-To: <878r3mg570.ffs@tglx>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 15 Feb 2024 10:49:02 +0200
Message-ID: <CAHp75Vdo7-JqQuZ9ni5a=M3fFM76h4Gr5Babu6hEn0NO-tqpJg@mail.gmail.com>
Subject: Re: [patch V6a 01/19] x86/cpu: Provide cpuid_read() et al.
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>, 
	Juergen Gross <jgross@suse.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, 
	Sohil Mehta <sohil.mehta@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>, 
	Andy Shevchenko <andy@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Wang Wendy <wendy.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:29=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> Provide a few helper functions to read CPUID leafs or individual register=
s
> into a data structure without requiring unions.

..

> +#define cpuid_subleaf(leaf, subleaf, regs) {           \
> +       BUILD_BUG_ON(sizeof(*(regs)) !=3D 16);            \
> +       __cpuid_read(leaf, subleaf, (u32 *)(regs));     \
> +}
> +
> +#define cpuid_leaf(leaf, regs) {                       \
> +       BUILD_BUG_ON(sizeof(*(regs)) !=3D 16);            \
> +       __cpuid_read(leaf, 0, (u32 *)(regs));           \
> +}

..

> +#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {                \
> +       BUILD_BUG_ON(sizeof(*(reg)) !=3D 4);                      \
> +       __cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));  \
> +}
> +
> +#define cpuid_leaf_reg(leaf, regidx, reg) {                    \
> +       BUILD_BUG_ON(sizeof(*(reg)) !=3D 4);                      \
> +       __cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));        \
> +}

I'm wondering if we can use static_assert() instead of BUILD_BUG_ON()
in the above macros.

--=20
With Best Regards,
Andy Shevchenko

