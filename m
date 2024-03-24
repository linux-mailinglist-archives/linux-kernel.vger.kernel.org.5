Return-Path: <linux-kernel+bounces-112840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C64887EE8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E011C2095B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0D81D6A5;
	Sun, 24 Mar 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7yn+zEW"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B61C6B6;
	Sun, 24 Mar 2024 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711313293; cv=none; b=W7Lkt7HiGuw6AC5UnRs1abkMGLZe5Ow5qiw3fOF0fxeXGkbgDbQEfp5tCGamfR1iVqFBVwy3WLeO3kZHKt4M9Bil49A0AI+3iU0FnDz0ChN2ata8G2saeYKKaeRzL32kFc3sMahIhurNKRO8x4kXvTnVWGQ3/rM0wMP/dwwOf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711313293; c=relaxed/simple;
	bh=3RO0I2wKpwij7HkA5K8tjfw8jlhh3LvlW6e5OC+73p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7ysDDgU/fyZYvXmQXwHVECPVyD6u8f5Zi0JBIU94wkHxh+hIyffKtLRQKaVf7+sutFEhdgI3lsBXXuyjkI2fZuQ9m/6gxQ0A+rJ7ajDOI1hubIeVXudJ1mVR6wNFm5mePUiWL1vCnKmD6g0DEkyqTYIsZ/ZrTNA+wcM8CV2DSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7yn+zEW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so2528576f8f.2;
        Sun, 24 Mar 2024 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711313290; x=1711918090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E06WwqE1mYNwqT0s+qKXIFxzOo9G0k2mK8nywS/aUw=;
        b=e7yn+zEWc19meUC4ahT2ESoElkBeg6lNUBITi6SzSDeviYDwjp/NfcpsNO98gzkv/d
         UIFffCq5GIA5DL1wOZLBNN1JzVCwOwg1GEh7GRVeX5phcRrqw2690t2MlusUIRUtGL/b
         g4JB+6nchFrGqjpLCgM6yuHVuZuZTvFlqH3lSQaQY1RHqgDHO6PEynXCukpEWNvV//lP
         tOtVNFEJMEGnsO9B5rlGhWAF7lLIJhZjCWqvmcmCIlxxORZu3Qz68jp3VF80t/DboYxg
         wzrZK6G8+7VM2nUzbt+vWHL0OkxhSzp5/kSEJDQias6YdCThUXBSF97YX6RT0PLq9uFo
         ozgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711313290; x=1711918090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9E06WwqE1mYNwqT0s+qKXIFxzOo9G0k2mK8nywS/aUw=;
        b=S7C+UwObuLq4XAGZyaxaOOfwk/cRXHf/C4z8Fo4nAhrqTJ2qAwS6tOK9+ldcSHZRue
         tXs4iEbTcJzblbhhw0ixRFaceQ6NKdJ4gcsr9d3Gi4jmvMAdgsmeuMHgrSgCeAJvxP3X
         TET3nnXnc8FmwhWiYqtxcs/lMa3z4wIXaLpsuTVtbnyT7v3TZjK3bGNIXK0db05+iSuf
         a8wwgUeOs1odPF3823wagSR9Rp81kJ+aeSD8Ehk096P8pgN2cmetROLSbWIE4pUr15Lv
         tabrYRDWgc7Y5TGuMIopNI9UwYJu2/sC7fwr8jxy7jqfKknL2TJR/tpDC7dAHBKZKxGj
         YI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcEHdXhO0zIRd/ci/KmnXi0spbq0hDEeabFlr0O64IqCvcqJNZpgrr82SFII6eaUTiB+rA1ifxpYGFGJNI+adCwRJpl7yM1pobgWaFfER/17+KiQr7Id3wbqYQQ3QCml3y9GBzlBmg7nOkaoHv7pSNjqk/3KSpPL5O
X-Gm-Message-State: AOJu0YwSAsykTdZ061ej7+qXBKSe9WJZ9JmpenBODnlyvieqxqbfyyaW
	x3XDdwZzo4naGS3BMXYPpRCtvQQggrZSY3HyMZyveqI/fnRNM3O1va1Mhmp+BFNbwGvHJ3S2jfS
	nJ2s3TBEvvuMvKESpHx6g7sxLCcY=
X-Google-Smtp-Source: AGHT+IGC0xab3YuWtcN0TLka25yNA8BVbK9IBY8BQCUNgCF5rwmkRMKj6d3YN4/qnQhDtPElGlQh5n9hnjaXy50FGi4=
X-Received: by 2002:a5d:6884:0:b0:341:be5f:ff21 with SMTP id
 h4-20020a5d6884000000b00341be5fff21mr3782685wru.55.1711313290050; Sun, 24 Mar
 2024 13:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324185356.59111-1-puranjay12@gmail.com> <CAADnVQKW2ajQ25BkOO_D2=N2wOHt9fdNY+tWRunXe_sN-w+33g@mail.gmail.com>
 <mb61pwmprbezj.fsf@gmail.com>
In-Reply-To: <mb61pwmprbezj.fsf@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 13:47:58 -0700
Message-ID: <CAADnVQJdoC6JaVu+m2bfC3QHkTSpbA9LyiMyAnjhght_-_EP5Q@mail.gmail.com>
Subject: Re: [PATCH bpf v5] bpf: verifier: prevent userspace memory access
To: Puranjay Mohan <puranjay12@gmail.com>
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
	LKML <linux-kernel@vger.kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 12:35=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Sun, Mar 24, 2024 at 11:54=E2=80=AFAM Puranjay Mohan <puranjay12@gma=
il.com> wrote:
> >>
> >> +u64 bpf_arch_uaddress_limit(void)
> >> +{
> >> +       return max(TASK_SIZE_MAX + PAGE_SIZE, VSYSCALL_ADDR);
> >
> > This is broken. See my other email.
> > Sadly you didn't test it.
>
> Yes, sorry for this. I was relying on the CI for the test this time as
> thought it would work. I just realised this would reject all addresses!
>
> Given that the current x86-64 JIT just tests for TASK_SIZE_MAX +
> PAGE_SIZE can we go ahead with this and later fix it for VSYSCALL_ADDR
> as it is specific for x86-64?

This patch deletes a bunch of code from arch/x86/net/bpf_jit_comp.c.
If you're proposing to deal with vsyscall check in JIT then
very similar code in the same spot will be re-introduced.
So we should address all issues at once to avoid code churn.

> Also, I will spend some time figuring out the best way to do this, there
> should be some mathematical trick somewhere.

Let's think of it right now.

For the next patch you can reduce the cc list to avoid spamming all
mailing lists.
bpf@vger plus JIT folks for affected arches will be enough.

