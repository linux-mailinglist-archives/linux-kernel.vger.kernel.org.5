Return-Path: <linux-kernel+bounces-130841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F89897DCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF8928A81A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853D1CD11;
	Thu,  4 Apr 2024 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGPCv6lz"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E72137F;
	Thu,  4 Apr 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712198437; cv=none; b=NhF/coWBkg6QUiaRB1t5Y7Vwpn9CLl8crKgROO9LVO82a1ZcGP65wAq6L8sOt9ejc2BhVlZkCu+yHQKbRfH+xhTR5s4/jj/2HIu9uFE3xOz+tii79O1/lPwdTpCqd/bJNCkwQRLvhGvXz9TfDezKct5FJglHLm3ar62W212tJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712198437; c=relaxed/simple;
	bh=kFe6tPH/cWOyHNl56rrigW4jxnM0G4udQ16tF7NHiCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruK4QwU83q/lnJ1frq3ZeRM6iDb7qkmXNLcNhHsqiHN3tczp8oO2sOrMaeOZhlg+QsCwgdECobA1HadtQIinsIIDwTAyKxBs1YWjiCQwvIOD7GG25UMPOC80oEF6uwdJ4yr1HGWQdGYzEGPSSLRetkdXYOBDFkurMKbTSi0MAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGPCv6lz; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7e406cf6263so42221241.1;
        Wed, 03 Apr 2024 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712198435; x=1712803235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVREjhdwHsZfrwJAEoys2z1mQGNzhFFLniJpdksZomI=;
        b=HGPCv6lzF55pG593uQWaTmnC6/BBtA2wvv4ASPywEPbuk5WNBzzXadJmlPYfIEtdeJ
         0FcggMCKRH7c7INDV2fsF0x8OqrAAtPejpIRpM7hVC9kyH7FS+v1Iy1I6qig1fDG2rk8
         l48s4xecGEjRjBW+CeLIoUfWaGB5h9kdbihv3eS0QYkRyD/QFUKm75b1iHi29sVfEJBV
         hDV8lTlt0bZrLWrmtJN/+StXqPnvB/Fp3fT0zdnBq30426Xl0R9Z5uHj5vGJXssH1qGv
         xnJ007iElDa4SYl3sIZSdQxazhnpYkQPPgQo4lrBMH6rLxIT17mh054nm8rrWF9G9jz1
         lg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712198435; x=1712803235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVREjhdwHsZfrwJAEoys2z1mQGNzhFFLniJpdksZomI=;
        b=rCRSptBE+7iPA0PQ1vlz6cpOtOBKV93F7ryXtBy/NIsxkrEJbAl+sXPmDNzMW6yb3m
         EQbUDAYtPPoL5W9HVCKfsm6+sTkU7mWzVVbOSudlZg7WYGaAaxdhVTGEr3E87yUk0U8C
         +Kf1Q6YhGSQiaQHTTp29deDiyB9p3elqUtZ2poniojXdhZTeEyk08dAwJsdYnwT2HekY
         QT6xPnnFj0nnCA8oyQP+khbwMKeXQqJNqwHUod+9rzoZULn4rSIRm0qUITWNLHyGyj5/
         +PoCOitbqdfPmogv+6CRqamC32rw0vZMCaFSknBETZ+oXTg0+6FtSQuOcvosy/A+CL/B
         n8/w==
X-Forwarded-Encrypted: i=1; AJvYcCWsmhKJ+P6v+tuEM9XSdtiPOveRe2E8VVc0YwFmouPH6Likdwc4SPt/utTuU57yjthe7ogfIR6QjoEaOJOQrVNCV55DhUbHqirV7w6qCRbKHM3Zg+CNztWyRrf9SgL/GJwH
X-Gm-Message-State: AOJu0YybIRcgv/dZSXCWMLrgmzYql3wOuxzbbTcwEKf26rhgWEmozMub
	2FpTe20J39UI4j6G7QKRSntDZ6Qj+DYCgn4yJ3MvZbWbSqICZSRu19EO8Mr3Pr/zgLahcadmUEz
	GXIm2Q8nEHkPlWdPOeVsj7RcqKNI=
X-Google-Smtp-Source: AGHT+IFp0MAuYPUrQ13Gs+NAxjFLozHrIsEVlc8iE4G/jw+Jid5LJkvCLqzD3P+WiRRxRXh2xHTMb4AlpmcGJYX8KCs=
X-Received: by 2002:a05:6102:4a02:b0:478:efaf:868 with SMTP id
 jw2-20020a0561024a0200b00478efaf0868mr971359vsb.22.1712198434666; Wed, 03 Apr
 2024 19:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com> <77f5c5ed-881e-c9a8-cfdb-200c322fb55d@amd.com>
In-Reply-To: <77f5c5ed-881e-c9a8-cfdb-200c322fb55d@amd.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Wed, 3 Apr 2024 22:40:23 -0400
Message-ID: <CAM=Ch04xd5u75UFeQwVrzP7=A5KPAw3x7_drqQHK3C-43T4T2w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor
 value tracking
To: Edward Cree <ecree@amd.com>
Cc: ast@kernel.org, harishankar.vishwanathan@rutgers.edu, paul@isovalent.com, 
	Matan Shachnai <m.shachnai@rutgers.edu>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Edward Cree <ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 9:25=E2=80=AFAM Edward Cree <ecree@amd.com> wrote:
>
> On 4/2/24 22:20, Harishankar Vishwanathan wrote:
> > Previous works [1, 2] have discovered and reported this issue. Our tool
> > Agni [2, 3] consideres it a false positive. This is because, during the
> > verification of the abstract operator scalar_min_max_and(), Agni restri=
cts
> > its inputs to those passing through reg_bounds_sync(). This mimics
> > real-world verifier behavior, as reg_bounds_sync() is invariably execut=
ed
> > at the tail of every abstract operator. Therefore, such behavior is
> > unlikely in an actual verifier execution.
> >
> > However, it is still unsound for an abstract operator to set signed bou=
nds
> > such that smin_value > smax_value. This patch fixes it, making the abst=
ract
> > operator sound for all (well-formed) inputs.
>
> Just to check I'm understanding correctly: you're saying that the existin=
g
>  code has an undocumented precondition, that's currently maintained by th=
e
>  callers, and your patch removes the precondition in case a future patch
>  (or cosmic rays?) makes a call without satisfying it?
> Or is it in principle possible (just "unlikely") for a program to induce
>  the current verifier to call scalar_min_max_foo() on a register that
>  hasn't been through reg_bounds_sync()?
> If the former, I think Fixes: is inappropriate here as there is no need t=
o
>  backport this change to stable kernels, although I agree the change is
>  worth making in -next.

You are kind of right on both counts.

The existing code contains an undocumented precondition. When violated,
scalar_min_max_and() can produce unsound s64 bounds (where smin > smax).
Certain well-formed register state inputs can violate this precondition,
resulting in eventual unsoundness. However, register states that have
passed through reg_bounds_sync() -- or those that are completely known or
completely unknown -- satisfy the precondition, preventing unsoundness.

Since we haven=E2=80=99t examined all possible paths through the verifier, =
and we
cannot guarantee that every instruction preceding a BPF_AND in an eBPF
program will maintain the precondition, we cannot definitively say that
register state inputs to scalar_min_max_and() will always meet the
precondition. There is a potential for an invocation of
scalar_min_max_and() on a register state that hasn=E2=80=99t undergone
reg_bounds_sync(). The patch indeed removes the precondition.

Given the above, please advise if we should backport this patch to older
kernels (and whether I should use the fixes tag).

> > It is worth noting that we can update the signed bounds using the unsig=
ned
> > bounds whenever the unsigned bounds do not cross the sign boundary (not
> > just when the input signed bounds are positive, as was the case
> > previously). This patch does exactly that
> Commit message could also make clearer that the new code considers whethe=
r
>  the *output* ubounds cross sign, rather than looking at the input bounds
>  as the previous code did.  At first I was confused as to why XOR didn't
>  need special handling (since -ve xor -ve is +ve).

Sounds good regarding making it clearer within the context of what the
existing code does. However, I wanted to clarify that XOR does indeed use
the same handling as all the other operations. Could you elaborate on what
you mean?

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fcb62300f407..a7404a7d690f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13326,23 +13326,21 @@ static void scalar32_min_max_and(struct bpf_r=
eg_state *dst_reg,
> >                 return;
> >         }
> >
> > -       /* We get our minimum from the var_off, since that's inherently
> > +       /* We get our minimum from the var32_off, since that's inherent=
ly
> >          * bitwise.  Our maximum is the minimum of the operands' maxima=
.
> >          */
>
> This change, adjusting a comment to match the existing code, should proba=
bly
>  be in a separate patch.

Sounds good.

> > @@ -13395,23 +13391,21 @@ static void scalar32_min_max_or(struct bpf_re=
g_state *dst_reg,
> >                 return;
> >         }
> >
> > -       /* We get our maximum from the var_off, and our minimum is the
> > -        * maximum of the operands' minima
> > +       /* We get our maximum from the var32_off, and our minimum is th=
e
> > +        * maximum of the operands' minima.
> >          */
>
> Same here.
>
> Apart from that,
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>

