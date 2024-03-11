Return-Path: <linux-kernel+bounces-98526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E4A877B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067DC1C20D40
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ACF10A12;
	Mon, 11 Mar 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp7o9uXQ"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72331C33
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710143825; cv=none; b=U7hdkzyRqNArgJqfOfC9EwOIYQXxx7AohqLp/q3EHsGVmO0ZbW/X7jza3wrQSkbcvxZ6HE0f01Yw7LRHiFD0az6qFnZADnh2Tj6NZvF5QTjXhIFrnx4KpyOusWpwbCeqzmOCK0l6qnBoTX/IFX/U370eCfmVJcBAIVqFPM2T2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710143825; c=relaxed/simple;
	bh=l1GlUN2HihV5LZtSj9DtGfp1vdhPKdNbmWkJ1oSjdUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyiEzCHOnc1sbNGhyFAo9fC2kkstEJNQ9xO1hXI74agpxmIQ/abhpEIXJvPPyTR0fbGP8R51jmYwHMWZhbALzptlaQhfs1u17UeLEV9EPwerOtY6Ly3Bnv+Le21FTNO0xqNOlSDre7KbJAQuMAWLBlUaZfMEI7ZTdYcLCABDJzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp7o9uXQ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso3518736276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710143822; x=1710748622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1GlUN2HihV5LZtSj9DtGfp1vdhPKdNbmWkJ1oSjdUk=;
        b=Vp7o9uXQyhhX2v0i4fq4tPHIp4Ob5RIfj9ZfxL/PpbVe09OsEPmsppxLOf0FkbVg3J
         gRCpXYp5y9srvjeMO8WrJvumu5eB8nYo+vJ3Wh1CPkXNtUXUeN6L4z/6MsD7fmaU+XnI
         AFd5/E7c0lTfPbPm6Z2uIK+R9Gww9No5bSQJNvfMA7AWXMXOokpXInpwulc5YXjgLWcl
         bqWd61bjWEUpitkyXrSUuC5mCe5+l2ZHO4onZFjQI46gets0IWCa7N1NImtHLCZalPI2
         Rg7H3Tkt1ZMwLJQ0giHgJZtnO9INSxFmx7OPCNlIXQKVi2P4t4iM7fCzuEhukqr0Tpzp
         v/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710143822; x=1710748622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1GlUN2HihV5LZtSj9DtGfp1vdhPKdNbmWkJ1oSjdUk=;
        b=OUD73FumCt9qlFsvvdWe59wAayhqrwBdHCvs2JWKJ0+KjYfhqc3//ODUtABij0WhnH
         fUIftxDh1EkPQNs6V2pGOoExdU6cz6Iiw3z2UDHG/tAowh6nRxiRL9+LxY1cgUiJWZ2S
         53H7GI776Ml2u+8490QpJy0TMnaIJDVeaeZ26hE9e0zSBR0Njkqgw0JH0T3X51MJTKZy
         V7AzVAHa548gyFwtVI12HQrrhq3DO+SL5oB8lGW8KSAEeJDj2OnU9RsZ2smV2sfKOVq5
         htOyfXmRFYeBVvGgww8hG4y5Py7xG3liZUcAn0YyETITm8/siaoW+x7aicU++fR2aEfr
         FDig==
X-Forwarded-Encrypted: i=1; AJvYcCXH6IPQuE/V2r7SBxKD85q+9ttcsjciXgxnrSgjO47knhBH7lVVhY3lu37E2Ko+0ji7Hv9ZOQWJy4WZ+o8HnrBnct7o2phsTH60SJ84
X-Gm-Message-State: AOJu0Yw8dT6/n8WpT/R/ULzRMxlN/lo3jL3mNzpJ1Ec4YH6VlQ1m1P06
	A/x0EUN11//9LchUw/1wnUT5757akZ+6UAYg8bMwmjDqPm7FrEJvBFpt0LDFMeoquQM/2QQEkKp
	WxxtpuyZEFQLvBcHRRf3pSY9+IDM=
X-Google-Smtp-Source: AGHT+IHQJ4sUl3hCowXQDe0G866xiBo0JEIoRHtVzKJEsNjcvbr/+8mWIMLpp4/LFmK4KbAnHgxImO4hBvPL4+xmG/I=
X-Received: by 2002:a05:6902:c7:b0:dd0:c2a:26f9 with SMTP id
 i7-20020a05690200c700b00dd00c2a26f9mr3178090ybs.27.1710143821857; Mon, 11 Mar
 2024 00:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311063018.1886757-1-dqfext@gmail.com> <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Mon, 11 Mar 2024 15:56:29 +0800
Message-ID: <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@atishpatra.org>, 
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
	Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Inochi,

On Mon, Mar 11, 2024 at 3:13=E2=80=AFPM Inochi Amaoto <inochiama@outlook.co=
m> wrote:
>
> On Mon, Mar 11, 2024 at 02:30:18PM +0800, Qingfang Deng wrote:
> > T-Head C908 has the same IRQ num and CSR as previous C9xx cores, but
> > reports non-zero marchid and mimpid. Remove the ID checks.
> >
>
> Hi, Qingfang,
>
> IIRC, the existed C908 SoC (such as K230) have an early version
> of C908 core. But C908 core itself may support Sscofpmf.
> So I do not think removing the ID checks is a good idea. Instead,
> I suggest adding CPUID of your SoC to this check.

As of Feb 2024, the latest C908 revision does not support Sscofpmf.
You may Google "C908R1S0" to see its user manual.
But I think you're right. Even though C908 does not have Sscofpmf,
T-Head may release new SoCs which do have Sscofpmf, and the check will
break. I will submit a new patch with your suggested changes.

Regards,
Qingfang
>
> Regards,
> Inochi
>

