Return-Path: <linux-kernel+bounces-109918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FB88857C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8441B227A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88B45812A;
	Thu, 21 Mar 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRfMWvmS"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04DC58207;
	Thu, 21 Mar 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019131; cv=none; b=pXnjNl1dfd35L70+c2Q4ksURi55nvLkk4s2aPFYqde9rxzVqw57SbkcLeYC/tivwk2NzHzbvtiYKLkRTF2b0WmHH/NLVkHcURmYGN5l9jUSDf28O6uoK0LpdHwk8RWMUxxX28oKzKzWiHceKCXYk+ydqan32vHk7/tee2lSJp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019131; c=relaxed/simple;
	bh=T7oRw9U9YOvtDCNp0N0dPXzwXcNyyNi8HOvwsjPUjMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCxVrP3mEFsegIaowZfZokuapogQQQidozREPiM3pFXMHf64U4rhWpCyJVXLuwVrEaYvVmYyRHS+PeBykIr8biShpKy3WUdQs3p1ibSBfC9supcmtnYW1A9sTNEFOVvKYta3b1F69xG11rmDieiDrFfs2VqPJ86Sa3I5ufp6LG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRfMWvmS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513da1c1f26so1133528e87.3;
        Thu, 21 Mar 2024 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711019128; x=1711623928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph7DhApLQf9g5u+GJFqkGKLK8oTg9+BlB4tUDorFzNk=;
        b=dRfMWvmSMzOVV7s3NeF+4+OR5Jv2susbkXvWpU5wn7JaK7wJncV4HhRiXJk6QsnPLZ
         elFTsRN2zGJkoFpDmV4Oe6/ZUXVqIjuy0BMClYGWmVI1+5J8y+37JDZSa0sXX7ajFISh
         Jn938ck7H/fBtCsPfRr9QgCQnJtS0Kk2iUwQYinW5FEJNMPdk53xZ5b6dJyVP0+gDcKE
         xmeRyu5LTdUMgsR8s0eP1it8CcwCNAFaGufEw08/bqh+NsCSJocOgJCsntUln7gSpEZx
         7GyBLg+aUbdF10Y8pWe0+qLSAmvE83DYZgtLbDBAi5+tUedVm1vMRPTOpgDXH8TmfTEl
         XrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711019128; x=1711623928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph7DhApLQf9g5u+GJFqkGKLK8oTg9+BlB4tUDorFzNk=;
        b=JehzA7KAJiE2Xec/LjLLcFLim7TRSi/tyGR80tWeqb3XtaTpd0dtYMB/ZJxSXN6IWF
         hqJ3q24nTsPrWE8dYh8Ylzdx5kK8kW7dXNvhEW6UrgXkZk/7eAuuO1qntdmIGR+5kiz4
         Sq6zCvpu7rhXiyncfM92BoeYmQyuYlwikX3zxK9Up+086EmvXeYQXsktF+pUqZsrrUuv
         IqUtMO8yMZOyR7kbpJyQQpIOSI1M20Hva+WlCIJTvOtBtiEdD1uFYhB/z/R5PUpmB+Fl
         CNnRZLYd5dGxrw6t9/XYCV4qHXmneR1VZ1pcGyVyGGNCI3FI7ff0YEMScvRDlss7DOwM
         t3pg==
X-Forwarded-Encrypted: i=1; AJvYcCWVmFoOng4p7dw+Pd7PCHwkepleGV6tYAx8IvZFgxre919jkelyQuSZ0qKe2QNvX+lHjez1Ru9AZ04U29/Zg1n8HUHZrCpcClWxLWjDGA31obgggqFwPZBk/mii4B/xHqwWnB1030NTidsJIlgw+Mm/qKl3RRfL/Myl
X-Gm-Message-State: AOJu0YzQ7yrBq5VXiq1DFBmF6rH4naeqFtXDJ8IHI/jWLevfznPMwD7x
	DcYwU3sAo/wZedNp59xgBc1tdfzNbN9QCQOP2FioO6z3v86oE0eZqVWzUw79UImkdI4SwfPfKDw
	w0MzG4itOH077rkLgKVG4ynu2E6cD2WenBTw=
X-Google-Smtp-Source: AGHT+IHpE1IvxAZxMsCwH8ke7VHalqSTikT1Qp9JTWVuYMlf3WlhFObfM/yD4osrKm0OAmcEU+VUnbAvw5dE9JTBc10=
X-Received: by 2002:ac2:5b9c:0:b0:513:dba5:ac67 with SMTP id
 o28-20020ac25b9c000000b00513dba5ac67mr12168547lfn.32.1711019127516; Thu, 21
 Mar 2024 04:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321101058.68530-1-puranjay12@gmail.com>
In-Reply-To: <20240321101058.68530-1-puranjay12@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Mar 2024 04:05:15 -0700
Message-ID: <CAADnVQLhwLgq=QuXD-Ls=t9Scr_4Zn9JwdkXfZQfZkT=ysx64Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: verifier: prevent userspace memory access
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

On Thu, Mar 21, 2024 at 3:11=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index e613eebfd349..e61a51a5b4be 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -2691,3 +2691,8 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>         return true;
>  }
> +
> +u64 bpf_arch_uaddress_limit(void)
> +{
> +       return -ENOTSUPP;
> +}

Looks good and should work, but s390 CI is still not happy.
Ideas?
sock tests were not failing before. So something is going on.

