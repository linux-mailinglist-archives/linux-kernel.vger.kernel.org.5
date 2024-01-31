Return-Path: <linux-kernel+bounces-46882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D925D8445BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9A41F22A37
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602B712C553;
	Wed, 31 Jan 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="C/sNkXvR"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F112BF0E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721232; cv=none; b=lVfFTlvs/0tyQOrSuJ+WFkl8rV3HNFG2Vu4Bid0ua2QJkmoRbOPTCAAYXXTlph+0AO3qkSK9qBelPaEH4v/DV4H1eqCb4NSpaVajJdtH6sr3fvyAFeOab0kuBDsIRSZ+2F0rZNzjrQEPgttXsVmjlVv769zYC5QomP5apHt6VIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721232; c=relaxed/simple;
	bh=nwZYaGiDC0dt4XMiU2uVseTseF4erfN8KXvD37w3q2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzmW++tBuFJw1q5K/0TMCPsKVQG+OKTzYY0cQMdhMZw3udZWihwSI8phNrNpxOrMwvk5zx7Nx5CKxk8E9hpNa5oIfHPoLgjLTY7wo4/60c0ZMsc4kW35K4e2LvAfw+Dmaqqu4+fYKCLhMcdBslyGNTEE4u+2wuo/V+3M7pQH5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/sNkXvR; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68c4300518bso21356d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706721230; x=1707326030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IJlALPOP0m94SbFgDUPXzZQCU+Ot6RdR1/m5iPTGnU=;
        b=C/sNkXvR9LbaDAKrqweFi/Np6TF+HAKYCw/PC/UknGa7yedzHAm67GtNU/wzs1gZMz
         xtDj3dIgkpr5G7GvgP3wIu2lPCsYbfQmc09vIwcy7PCz+v1tIKHoyj4t44UqF9Taz9iU
         jET8s03VV3czPn/pWm2T5TLoGl3aqAujbbde7tDdlzBGEiFPwOLRZU13NDcszPj9stn0
         F/OjXEhgD78vyq860zepwMlX0kk+a7Re7qWCwb42G1oWlRYUP9KHGftMTuxo3JrQqrbG
         j4NYGKpnM/FAWXkXxpq4+PxR024MqZyBQF2ypeEtc1isL9z/aJP0QVK1CEjIgjCDJcvQ
         2Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706721230; x=1707326030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IJlALPOP0m94SbFgDUPXzZQCU+Ot6RdR1/m5iPTGnU=;
        b=D24fhCdJz2aObn3UtSCOb9/ZQbTusj3wSIcdde+321/iEuHUHK8LwYxWzNh1DckqSM
         /0L+S0cwenNFzPy74ESlLhnaHi0ynuAW8l2y18kXW5TWoYVTp4CH6QJVSuiYhZ6dRTZt
         W0sJuU38MeV/RZh5FkIHWPCkSKHCMVu8QRJBVAANfrgTJqgcL5aupGIO7782UDpSKFvb
         irrtCwr8xLecGcCVHbjr5px+4bBMHZg8MjT00Eh8S1Snn4sz+r9bcvX7c2YTSFdBog3s
         fxRCA5LOd8Rik5EN6MnLDCakkdadUwaQPTlU7Q1SGLkpTrRkYmAgK3p5RBpnoaCAQsyk
         tWYw==
X-Gm-Message-State: AOJu0YyvoaSslZJfs9XxHQkqaavne4N3rz2uU9BSQhDlNeNxd+9vhrHZ
	Vm1xsJ60wydkCYM/XVVaoDBDaO+tsNVkqwkISXp/I4bd+itbCy0Xo5uFQoqxEH4ODd+fnGYybtv
	WuhJmttaE9tStAxibIWYP4n7r85uN8v5uXrWs
X-Google-Smtp-Source: AGHT+IGeL+lnDarNegE01H/3A8DwfzXHmFLBjWvwqbfeIkhfoVvb3X9wjzl1nkLPqvdpUhEabGteBvw88WkwVVRQcpU=
X-Received: by 2002:a05:6214:f6a:b0:68c:45d2:354a with SMTP id
 iy10-20020a0562140f6a00b0068c45d2354amr2529358qvb.18.1706721229715; Wed, 31
 Jan 2024 09:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123221220.3911317-1-mizhang@google.com> <ZbpqoU49k44xR4zB@google.com>
 <368248d0-d379-23c8-dedf-af7e1e8d23c7@oracle.com>
In-Reply-To: <368248d0-d379-23c8-dedf-af7e1e8d23c7@oracle.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Wed, 31 Jan 2024 09:13:13 -0800
Message-ID: <CAL715WJDesggP0S0M0SWX2QaFfjBNdqD1j1tDU10Qxk6h7O0pA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:02=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
>
>
> On 1/31/24 07:43, Sean Christopherson wrote:
> > On Tue, Jan 23, 2024, Mingwei Zhang wrote:
> >> Fix type length error since pmu->fixed_ctr_ctrl is u64 but the local
> >> variable old_fixed_ctr_ctrl is u8. Truncating the value leads to
> >> information loss at runtime. This leads to incorrect value in old_ctrl
> >> retrieved from each field of old_fixed_ctr_ctrl and causes incorrect c=
ode
> >> execution within the for loop of reprogram_fixed_counters(). So fix th=
is
> >> type to u64.
> >
> > But what is the actual fallout from this?  Stating that the bug causes =
incorrect
> > code execution isn't helpful, that's akin to saying water is wet.
> >
> > If I'm following the code correctly, the only fallout is that KVM may u=
nnecessarily
> > mark a fixed PMC as in use and reprogram it.  I.e. the bug can result i=
n (minor?)
> > performance issues, but it won't cause functional problems.
>
> My this issue cause "Uhhuh. NMI received for unknown reason XX on CPU XX.=
" at VM side?
>
> The PMC is still active while the VM side handle_pmi_common() is not goin=
g to handle it?

hmm, so the new value is '0', but the old value is non-zero, KVM is
supposed to zero out (stop) the fix counter), but it skips it. This
leads to the counter continuously increasing until it overflows, but
guest PMU thought it had disabled it. That's why you got this warning?

I did not see this warning on my side, but it seems possible.

Thanks.
-Mingwei
>
> Thank you very much!
>
> Dongli Zhang
>
> >
> > Understanding what actually goes wrong matters, because I'm trying to d=
etermine
> > whether or not this needs to be fixed in 6.8 and backported to stable t=
rees.  If
> > the bug is relatively benign, then this is fodder for 6.9.
> >
> >> Fixes: 76d287b2342e ("KVM: x86/pmu: Drop "u8 ctrl, int idx" for reprog=
ram_fixed_counter()")
> >> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> >> ---
> >>  arch/x86/kvm/vmx/pmu_intel.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel=
c
> >> index a6216c874729..315c7c2ba89b 100644
> >> --- a/arch/x86/kvm/vmx/pmu_intel.c
> >> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> >> @@ -71,7 +71,7 @@ static int fixed_pmc_events[] =3D {
> >>  static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
> >>  {
> >>      struct kvm_pmc *pmc;
> >> -    u8 old_fixed_ctr_ctrl =3D pmu->fixed_ctr_ctrl;
> >> +    u64 old_fixed_ctr_ctrl =3D pmu->fixed_ctr_ctrl;
> >>      int i;
> >>
> >>      pmu->fixed_ctr_ctrl =3D data;
> >>
> >> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> >> --
> >> 2.43.0.429.g432eaa2c6b-goog
> >>
> >

