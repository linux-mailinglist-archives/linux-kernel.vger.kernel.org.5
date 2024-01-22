Return-Path: <linux-kernel+bounces-34045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500E18372A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA39B2992F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEE63DB93;
	Mon, 22 Jan 2024 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhfdkKB6"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6D3DB85
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951305; cv=none; b=MqxwPOdw2pDDWXdxBGX66vApjOCFPc4cfhQ1OEsqRsHAZtZrORtW977mjBZ5lYnOGeY8RGBuRKNFCB6a9pAELQxIXEC8gLN1Mk879DoSbDaM1GHKiejb4txijpk00MRMn4FKBhDyLRBPkr+gPcCCVljKkZay383ndzQrTYfcw4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951305; c=relaxed/simple;
	bh=Vze7Ue8PwyRlFuzF5j5pGTaPTTu6NsC20mArVOMM8iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm6ge0KnOkfHkss1BqfeQITg0VfXtCCJVfYqt0h5gRcddY5WqJfsKB7fRNwGKOq8JvsnynxwEV8y4KlEXE2D16kKb2hwahUG+pw3ataPkOvtrtehi5Nc9QV3ArhG84I3xiypht+a7y6m3kKYbs0ntNW9BJMBAFKpTangBcRC+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nhfdkKB6; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-469531dd926so669735137.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705951303; x=1706556103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff/eoY/1D5Phcwob49nwqMJI2GjuAonkjZxNhDG1/fY=;
        b=nhfdkKB6K8lhu7gPJqdADgPdC9gHke9jP7KpsXEERQyrrQu45iNt8vDwm4OYc8xDnk
         fddoKupAFargtbnRICYpJ+ZyI/2zmz3R28r9bd60fJyDPIooYYN+mTInOWaF86iGYYLP
         2zGN6thq9vkeq1Rn9lSSLvZasnEBAC63SjEMi4U5eHLkFAo7xv51Xc9efq1a+nLXTjnX
         lqNRH2nbESZJO5irv4MYfwR27jFfYeyG8SrJHTCYZSdFn+0XVzjLXSCuA7sDz6Vq8kQO
         xtva/CRsvMCc98wdSQUaPtjqUCcPf9I3z9pVryfpBXnp+7r3zVJH+TnMBGZN2/x63edj
         lERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705951303; x=1706556103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ff/eoY/1D5Phcwob49nwqMJI2GjuAonkjZxNhDG1/fY=;
        b=bMm13r8UCUEoVx1jYRgkPkmQYxerUqc9huArN6U3SY28xLkq+FidGcsTp/nUaQnRGL
         2DYe68Xuo7Kv+dlb4G8JPcNZSQsPfADyeBoEvQuNcjIV9wsj3T51b/avoaiok/l9e4bn
         gAV+FQyCM4zMTtKVeLseeXsb56dk2q0vprmPGEAmcBpDE6LtWCVSSXCYNDjdNcPyw5MM
         FbVxPXRC5rLrW0H42EUtyEPqev3pLVEL3AX2sMYPEWwHjhhsO17VD16Ly7nx87jjsvLH
         aNRY6cFPHItchNYOAbx2Yj+ngg5wezNb4IQm9MpWBUHlEv3H6c3SYr6iUzxTPy5LhE1j
         7pBA==
X-Gm-Message-State: AOJu0YwckaHDffzR5H3yTtI7/J4eOnajKbDoJLvJh9HMMXUgcNQeitze
	B4gwJXTUfswJrOYoSACfH2idnHxWmy9hzUxUzY4ioStfTWShSry0mGteMUbdWLKM9q4fqusFaoJ
	e0MnYxeckHRcpgMSZUGCk6Grz9wHlKb1aRao684ZzugfGHicX+Q==
X-Google-Smtp-Source: AGHT+IG5SXQv7Vebw20083XaJNF+f7v3TkKm+0lQsmX++BUanoSW69QV+Zd36TLqvI/iJF3Sdw36/xqTyLXoO4EAZ9s=
X-Received: by 2002:a67:ff8d:0:b0:469:5c02:a848 with SMTP id
 v13-20020a67ff8d000000b004695c02a848mr1925609vsq.33.1705951302706; Mon, 22
 Jan 2024 11:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122175204.2371009-1-samuel.holland@sifive.com>
In-Reply-To: <20240122175204.2371009-1-samuel.holland@sifive.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 22 Jan 2024 11:21:04 -0800
Message-ID: <CABCJKueoq-5vMTtWjiDqeMqt3SHM6bfcGyKUO1k7Uu+EN+LyxQ@mail.gmail.com>
Subject: Re: [PATCH] scs: add CONFIG_MMU dependency for vfree_atomic()
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Mon, Jan 22, 2024 at 9:52=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> The shadow call stack implementation fails to build without CONFIG_MMU:
>
>   ld.lld: error: undefined symbol: vfree_atomic
>   >>> referenced by scs.c
>   >>>               kernel/scs.o:(scs_free) in archive vmlinux.a
>
> Fixes: a2abe7cbd8fe ("scs: switch to vmapped shadow stacks")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index c91917b50873..a5af0edd3eb8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -673,6 +673,7 @@ config SHADOW_CALL_STACK
>         bool "Shadow Call Stack"
>         depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
>         depends on DYNAMIC_FTRACE_WITH_ARGS || DYNAMIC_FTRACE_WITH_REGS |=
| !FUNCTION_GRAPH_TRACER
> +       depends on MMU
>         help
>           This option enables the compiler's Shadow Call Stack, which
>           uses a shadow stack to protect function return addresses from

Looks good to me. Thanks for the patch!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

