Return-Path: <linux-kernel+bounces-62941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E091852830
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C458B2527A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B3A11C92;
	Tue, 13 Feb 2024 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDe9oxXI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667F11725
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707801531; cv=none; b=ml4hBigGOKgVSL3YFssLgIwIKvJuKdbX1+0KW974tmGrOjXP7Ib1e/rmvW+7vaYbXz2hhyhQUsRIxvUKHMWR0j+ROODUxnwvyBYXYcJX6Un+wJ+vWnv5YsBz1GxLTW+S4PZ2/wDwPAGT/OVyThLlMa5yKdEPLRYyOGpzfHZo4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707801531; c=relaxed/simple;
	bh=eiQTgF1UiR8Q+fk0Adp4OuUfIL1afzXcdoTxy37Yy5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzYYmB7WORJhCacFXYW5qnHvGqhLi5WeddTQWpjA3Vgeh0bfZvs+UHQQHJNgR24c9bg7DQ1on6z6U79ZSXviRLcNG9RPb7FpDaom3j5b0M6BYVD7w/X9n35qnAGEX6Q9ao6BueBbjLO8wfonF2Ugcn0CpEYAX6dFRSofe8aSUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDe9oxXI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-410cf70a057so22545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707801527; x=1708406327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghVxi5tVAq5eNnLPMygpM8GWrTrZsdJ/UPlOsCNOXcM=;
        b=KDe9oxXIL1+dgew9sVRcq0lGImY+/x6DZ4Ho4p6GvDxwBTuTavN0BznCYJIpLO+m8j
         RO7yITROgsdwsM6rnmcph/+n5csiQgidkfLLM76VlPwmkyauiXx22q+A/nil/Kl3GvCx
         Gu1iuQKgoURB3te03YegbnarHNSkiu78+tMIGktghh8Zaau8z90Y3J4DtPSwKVaibwQ1
         XjooOJsvrs19m6O4d1rJh+grLJ9Zef+x51r1+hdMIWAfu9F3fcQyEumDe76MqMkHAl0z
         Gx46Bm/JLra7P5ZIepO2y+m4zEcrSHY0cOrWF8hbd2FrT8duaMlP80bYPuPTfQ00XDTR
         6s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707801527; x=1708406327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghVxi5tVAq5eNnLPMygpM8GWrTrZsdJ/UPlOsCNOXcM=;
        b=II/rmLAYJqH+xJvkyhSJuQesmlg2Xa86ZFq4hjAw+icpyRCf3+MSlbze215k1Nd/5W
         rAVK7LnzbA/LREC4ePCAhnQ5iwh2BosdiOd431Lh7at9Heah/8NnfyQgxKX1ZhZV2eQk
         NckDhe77Kk+bfeBF6Re1vRqXFA+21rSOGD/TB6IO5AfM6jdpDlNvr1aDdOJdO0PZJZUE
         TWqkeHen7sjOnrpoFVvueAm6+EgmyCT/gEeitfPHkAzonq5oKC7hcGFQIO98PZCBFPO9
         Uk69yFuRgj0ybWwm/vwDY/zNgw33Lp8Qk0YUQTDfghEmc9bUotqj+lihRobPhcB+0ZqP
         nAKA==
X-Forwarded-Encrypted: i=1; AJvYcCXfDHbPc6vt4g75n86XNdL7gSO8y8vJH8b4RcTpjvM62+Zphf6BDCzrfxKowdGz2j1oDfJ689Sz7p2DvA2DR4zQB1feIUR5KgkUFs/J
X-Gm-Message-State: AOJu0YzfkYDDfK6TK61Xqo2fP22xl5BJ7di4suv4beQUZlk3adrnGslX
	96dZAerniGiEycTcp9yBAta2rGDVejklj4XofNM2SjIW1v5QMiDCAW/dthRmUcsu81MiG7t7vDy
	OtJ9heXehWTqg9ZNvqqhA4NsHt9jWCsvOaUB5
X-Google-Smtp-Source: AGHT+IGIk9vgIyNEuPvEQWVSn9DTVK8z4lhSQ+F7yHiGndjDMSMn8pMG1+J6wBdEBW/Ugy8gdDTVKttr2XXSPJJzZys=
X-Received: by 2002:a05:600c:3d8e:b0:410:87e5:42da with SMTP id
 bi14-20020a05600c3d8e00b0041087e542damr61264wmb.2.1707801527358; Mon, 12 Feb
 2024 21:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org> <20240207-s390-lld-and-orphan-warn-v1-6-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-6-8a665b3346ab@kernel.org>
From: Fangrui Song <maskray@google.com>
Date: Mon, 12 Feb 2024 21:18:34 -0800
Message-ID: <CAFP8O3+L6Jpgktk50UBKg_SodH-DTAW2syZueUqxdZsxrOT3bg@mail.gmail.com>
Subject: Re: [PATCH 06/11] s390/boot: vmlinux.lds.S: Handle '.rela' sections
To: Nathan Chancellor <nathan@kernel.org>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ndesaulniers@google.com, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:15=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> When building with CONFIG_LD_ORPHAN_WARN after selecting
> CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are several warnings from
> arch/s390/boot/head.o due to the unhandled presence of '.rela' sections:
>
>   s390-linux-ld: warning: orphan section `.rela.iplt' from `arch/s390/boo=
t/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.head.text' from `arch/s39=
0/boot/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.got' from `arch/s390/boot=
/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.data' from `arch/s390/boo=
t/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.data.rel.ro' from `arch/s=
390/boot/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.iplt' from `arch/s390/boo=
t/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.head.text' from `arch/s39=
0/boot/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.got' from `arch/s390/boot=
/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.data' from `arch/s390/boo=
t/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.data.rel.ro' from `arch/s=
390/boot/head.o' being placed in section `.rela.dyn'
>
> These sections are unneeded for the decompressor and they are not
> emitted in the binary currently. In a manner similar to other
> architectures, coalesce the sections into '.rela.dyn' and ensure it is
> zero sized, which is a safe/tested approach versus full discard.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/s390/boot/vmlinux.lds.S | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
> index 2f0bc05664ed..ff8c62d84f98 100644
> --- a/arch/s390/boot/vmlinux.lds.S
> +++ b/arch/s390/boot/vmlinux.lds.S
> @@ -137,6 +137,10 @@ SECTIONS
>                 *(.igot .igot.plt)
>         }
>         ASSERT(SIZEOF(.plt) =3D=3D 0, "Unexpected run-time procedure link=
ages detected!")
> +       .rela.dyn : {
> +               *(.rela.*) *(.rela_*)
> +       }
> +       ASSERT(SIZEOF(.rela.dyn) =3D=3D 0, "Unexpected run-time relocatio=
ns (.rela) detected!")
>
>         /* Sections to be discarded */
>         /DISCARD/ : {
>
> --
> 2.43.0
>

Commit 5354e84598f264793265cc99b4be2a2295826c86 ("x86/build: Add
asserts for unwanted sections")
specifies `*(.rela.*) *(.rela_*)` but it's not clear why `.rela_*` is
included. We only need .rela.* (see also ld.bfd --verbose)

This patch LGTM with this changed.

--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

