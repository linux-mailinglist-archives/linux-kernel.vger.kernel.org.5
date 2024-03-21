Return-Path: <linux-kernel+bounces-109681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D10881C55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D161F229C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477D3B2A4;
	Thu, 21 Mar 2024 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joL1OcsK"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2AB6FBF;
	Thu, 21 Mar 2024 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001296; cv=none; b=GZn5pnSKomV04Me6BMyR4CpMWwOUiaCV9480yJN5Sr34eeyut/rP8vt7guAJTKmBXEmtm34ZBOVMl5eSpxmvxHXBLgHqDgH61KoWhM1goG028J+AxHOM6TmPr9jQ3Nk5k8AnqJO+diMC0qhi592I5TPoDWeJwMTJhN7pW32VztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001296; c=relaxed/simple;
	bh=Wea1fSqHpz3J/JBua4hd15llvV+QZuuLz+xrfQq/WvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQwLv0iPauVoCCnjSHXHkOa7IaCjCSnI3JqkC03wVad8LjgZSkfWHMY7z31fwED9ZHZ/KA6mK1/jelVmHm1o4BC8G/qzOXhi7lOrbzChND6a+YoAmSIF0LUHfgmXA1J3Hw9Ntt+M2CQj1ix5LgyloofkKkhXHYF8QvJXD4TKDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joL1OcsK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ececeb19eso307831f8f.3;
        Wed, 20 Mar 2024 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711001293; x=1711606093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAOWqEugmsLZcY5+XlGTS+PYzImgKXVHs0T7fAbF/hY=;
        b=joL1OcsK5VI1Hooc7A5Lbdq40cfB29ry2iLhCLT9HcdvSM2En78nmBZe1+0mmZ0XlZ
         J8a5OwP3hfZgsyCzHJ7Epmb3ABe3NGtqhmGK6Tsl6h7wBYC3+q5+dqyLOleDfU4EyHtE
         VJkzB09g1yBz3XuQ2DwtAsmabV6NRsgRvfG7lB1qBwG5C7F0DXjEPeT9N5a4Ui4mkE3Q
         8JmPJRwTCtaMIszPZGLVRpK72921T/eyLglFAZMEVVwwWwtZQAirLagoL3/PzT5qNL5Z
         icDVuvbNktuO0D2LpeLSMc029nETieU2Ni0foKs/cDlg2lfu89akEvvXvYyybz9+mpHJ
         5uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711001293; x=1711606093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAOWqEugmsLZcY5+XlGTS+PYzImgKXVHs0T7fAbF/hY=;
        b=GeZHu5IrzI6X4e+1yYGolPkggAsc6PhOONFWOsmPXwZIbYmXGW6A4VpoSzCRpbZuPF
         CrFwuBZwJ+Ugh5vviDwSnb6mQOSy7bh5ZLp0uBZa8ik/CxKyqWm1db2ofBc5jmwN5tRu
         iRmJCbd5kL0gqdK6t7GqpgLWR4NtqGKTgESZJuz+4dJVhNN8/sprdxeWuET10tovDrqM
         WFsoDe9dW4fcQLV+AVjKjwo/R9Z/ffHvRr2xvFKEwBNg9EVWZG8SCkug3l+pKIuLP8Fm
         J1b1WblRJDoaVOi8ASgbLKIISCb2QAoKtlTnysLBaQAxA1LA81BhXBKXeMeRmsUEP5kO
         TBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHfVhVNcMrGwbxDJPAmwn1+BLlsMtYUyvu/EPgk3e9wRslIPyx/76Py+Cb5JgTMcDPTpihvw84XFekrGkV6avVtzfJhbb7lr3wKveOQ7++F2jTl4F+hzvThQ+7wMc1749jCSdQR1iN6nfDFkfpjLQ+FIMDvIGamK8V
X-Gm-Message-State: AOJu0Yz2k8vMjUpBZLC+mXGfEeIEhyqL2mSKieXztGbxFENQQBPzF6RN
	6kszFOMPuSxJydxCxJSORHgNJfdRNM/r2Hpl2W5ipur+6FLIit6cOmoGoSUessvh01lRzSXlkXZ
	0lPm7g6tsLYeGlkyDjQhmGWVnioY=
X-Google-Smtp-Source: AGHT+IG1ZQ91dGzNjV3S/a0sal/vPAwq07eP4TWvORk3wU+AEnbxoMNPW+53b4pyrDj05zRUsivgsb8wShGrtFAdUwQ=
X-Received: by 2002:adf:e005:0:b0:33d:886d:bb51 with SMTP id
 s5-20020adfe005000000b0033d886dbb51mr673479wrh.60.1711001292385; Wed, 20 Mar
 2024 23:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320105436.4781-1-puranjay12@gmail.com>
In-Reply-To: <20240320105436.4781-1-puranjay12@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Mar 2024 23:08:00 -0700
Message-ID: <CAADnVQJ3o6DsURi=N_KXx+mbW9r7__3LrwYLyYwuoMOsqFHPkw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: verifier: prevent userspace memory access
To: Puranjay Mohan <puranjay12@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:55=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> The JITs need to implement bpf_arch_uaddress_limit() to define where
> the userspace addresses end for that architecture or TASK_SIZE is taken
> as default.
>
> The implementation is as follows:
>
> REG_AX =3D  SRC_REG
> if(offset)
>         REG_AX +=3D offset;
> REG_AX >>=3D 32;
> if (REG_AX <=3D (uaddress_limit >> 32))
>         DST_REG =3D 0;
> else
>         DST_REG =3D *(size *)(SRC_REG + offset);

The patch looks good, but it seems to be causing s390 CI failures.

Ilya,
could you help us understand is this check needed on s390
and if so, what should be the uaddress_limit ?

