Return-Path: <linux-kernel+bounces-149464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E588A8A917C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1AC282F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634A4F88E;
	Thu, 18 Apr 2024 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoW6bWee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE54F1E4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713410114; cv=none; b=q2ezF9pTN7axNqlQOPSfMVMsBf+pz9WInPtrlDsMT0TS5XFx5IciJm957tyGzisptNFAB/ALE9JMixunsuie/W/SRtfYW/IBYrmGJFZlsrYwQyEQFBJqaBeuu69uxjljsiM2iAq0GmGfaiwHsb1jH8lDBhmOL1OCfIe18vmd2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713410114; c=relaxed/simple;
	bh=E9AmNyGddq5Eb53DUqVaIzShMqppKvErLUvIciv93mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVF11WRigsdqbigJN1xgkviaOGCgLZBnOaLD1PwOnns5BpRPmqib9Gaw8IA4STrw8xERbYFDtkAns9hb0jnzEveLDNVf22l3cObPUBwpEUCSSyGMIV86B/aWIrkjC1gn808LxVSoT5eH7+WW/FfWJONNhIxtZBx/tzzwA3dxyho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoW6bWee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6B5C32783
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713410113;
	bh=E9AmNyGddq5Eb53DUqVaIzShMqppKvErLUvIciv93mA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AoW6bWee1E/bveIDufe2XczRcTRein3ATgmEHU0H1rlejql0PWVaaznSt5D54d4SA
	 cCY+V75o23di5g8zo7qyBPldTlBVrj4o15WGWNg1idom16qcBDuLwK/K9q1tN2GdkE
	 m5FRYKa4XVzdTgodN/YJjN5Kn+/OvQjmZOM+eQaX3mr9qYGWCSXBIGmRsrPLUuyxzT
	 Z6+CNZ2uO7cOdI79+swl83QOjhUbKC5SHxmF+QbtU2ZBg5sq5yP3E/HgoK1w2gPbBs
	 Kd4V04B8FYZhHAEvIv6cvoodK4cmp9Sj+pv3wqQZkkL/hdMdS2ByY0/nTEM0N7JIkS
	 8w67aIfZSDMZA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a52223e004dso24415266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:15:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHDRossT/tCEx0wdtZB/NDHsyWlSihEifj73bifw1YAGe4quhGK/OAwezI5U47cJPfn839N7obVd1oD8RjlK6y5upy8SKJ1BT/focB
X-Gm-Message-State: AOJu0YzNR5+MpSiCT/0juugz/2woWx8mEdO9ZuOwgaz8A72YGNMV1HYg
	jTlv9e3S4udprSy9ExMdCVL1hHoOZZ53NURRoJJq2BUiPJv+A9Zw6g066KAgG0nIzZiAwxHRVuB
	TPt+gvUQUNF7k+IBInKZv7J/FJqI=
X-Google-Smtp-Source: AGHT+IH9z7hHQPUEX63FNBa0KnX03pY3RNYjUifUrqlFSfL67QP2/vgNuWA+OWw67fLYmM/RYW/MC4n3Rpv3BYH8l1U=
X-Received: by 2002:a17:906:d113:b0:a52:7456:bac8 with SMTP id
 b19-20020a170906d11300b00a527456bac8mr996857ejz.6.1713410112184; Wed, 17 Apr
 2024 20:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417095951.2635-1-yangtiezhu@loongson.cn> <20240417095951.2635-2-yangtiezhu@loongson.cn>
In-Reply-To: <20240417095951.2635-2-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 18 Apr 2024 11:15:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4WxQa26cQ7jtt-dj6WrAvpo5LuzF0QXVS9pv3FywSbQA@mail.gmail.com>
Message-ID: <CAAhV-H4WxQa26cQ7jtt-dj6WrAvpo5LuzF0QXVS9pv3FywSbQA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] LoongArch: Modify acpi_parse_processor() for non-SMP
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Wed, Apr 17, 2024 at 6:00=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> When CONFIG_SMP is disabled, mapping won't be created for all cpus.
> CPUs more than num_possible_cpus will be ignored. This is preparation
> for later patch.
This patch makes no sense, don't "fix" anything unless it is broken.

Huacai

>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/kernel/acpi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index 5cf59c617126..ccfa90faf0ea 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -98,8 +98,15 @@ acpi_parse_processor(union acpi_subtable_headers *head=
er, const unsigned long en
>                 return -EINVAL;
>
>         acpi_table_print_madt_entry(&header->common);
> +
> +       /*
> +        * When CONFIG_SMP is disabled, mapping won't be created for all =
cpus.
> +        * CPUs more than num_possible_cpus will be ignored.
> +        */
> +       if (processor->core_id >=3D 0 && processor->core_id < num_possibl=
e_cpus())
> +               acpi_core_pic[processor->core_id] =3D *processor;
> +
>  #ifdef CONFIG_SMP
> -       acpi_core_pic[processor->core_id] =3D *processor;
>         set_processor_mask(processor->core_id, processor->flags);
>  #endif
>
> --
> 2.42.0
>
>

