Return-Path: <linux-kernel+bounces-141395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68AF8A1EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1856B2A890
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B6182B1;
	Thu, 11 Apr 2024 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICJlgC4d"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F8205E3D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856264; cv=none; b=utqffH5GzbWQFSqvMsgvicffhB8SX53wXu7MjiPh501GGqZynMm7MtQ0zKqS2vncshkWI6JFuz91eRxACxr9uwsFYnA9M2SQcAd5+rHpSxN+CNFD2M55D81FMrBbf7t6BxB9FoszRj5cCeQIVe7kqyUTX/oRWQeSjfPXrJxUL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856264; c=relaxed/simple;
	bh=OvyPA4qcqhT8afxo9TDbGb0P1gxyjdE+tUpwI4Y5ptU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCVuE9OcpXQILv+I/vC9fMpfILlPrIAyiNuw9rtaS8vglRWjoLJB817X7Xw3IboIn5Nhy9vOP5RrMH5SjGFDFVNCpUzH0psZE84iFHqw7iHYOwGHBf+yIjK3Znk5CsZWVWMVsEw0fMkXodPVnT3pCmGeF1FFjRrAQVCKGHCSMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICJlgC4d; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so873a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712856261; x=1713461061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbe+N+ArnFJu6oo3t2QxqRzeLGyanm8Bt8NltXAuiV8=;
        b=ICJlgC4d/3wHMB2y72CNjmO71BwtmgY37MSB65HSmXeoh04wOjETNAhmw92q6w005D
         W6xRGC+nJ4D6BG90xmeuaKWLDaEnnRXd/uuiAwqtSYfk/VemLXly5A7nGfdpDEhlOsGH
         afm9ZPVInUgdPYK7Cd3z5j1M67Lw0yOlgAoNmhEgkC47zayfJTAGSYZgqONvtEzFuhlQ
         CRz1FOilUjB1d/3vlV90xwjXsqZSfdOfCe3nKx5Zj+iz7F+2P2xetdAiozyDF0fJczGl
         sKionBW7wZGtJ4LWgbe6SLFzQZvN9S2slsJ0JbC4BHyx/xDeTbV4PBc6zdwLP8SGwtcb
         RIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712856261; x=1713461061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbe+N+ArnFJu6oo3t2QxqRzeLGyanm8Bt8NltXAuiV8=;
        b=EiEVcVUaO7PaJjZV5e5G3eAEdC3E6Wian8GAxM8m8jrVkHludUTREIN6L4oxxuEdO4
         Q3MFTRfVptiY+3zxcUmxC9rlWFsMLyR2l06z0TfaVC5G1VVRMhPCRSJhuX1NJy+xLE6g
         mpyLc1wpNWA4dkSSJSAAGPn8gvpPRJ1aFgqIORxNHJNWy59LxigcXi8fWegSTqvkZykJ
         4Pic1RHl9NG4i2dGPnI/YvRcSf/Ntxn8S+khLly9et5i8JKXzi3AzfOg3IkwrwSuXPNP
         t0mxsJskJ8v4mq2tXwmkc0blqR5CgxSeXRrfCloW6aPUrT8YOZ24aWnA5A9DCzKQqmQA
         4+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXWsqORqNgZk7SqzWgibdKL0DCNeOLzyg2c28KonNu03PK2JMI4TKp+IV23e2J2ttxLiJvDGP2PHEfNEgfSyo3WXXpr+FVyDoiZGCtJ
X-Gm-Message-State: AOJu0Yx7q+0PkaG2ZeGXS6gzcRp2JvTidBeoqF85QnJAQ+KkBOkv+CW0
	VZgct8X4puQO1p/reTzLonTQBd41B2cWQ+kDrHryFtc6sNqAZ8AEL8zJz6S+9cqCYvNOAfWwguK
	YwDnG61hBUazi9NiuMwwJ8HPmM/GnvPk/hKS0
X-Google-Smtp-Source: AGHT+IGzM0+wIr54mp1dxlbIvqgdkGtnaeo28Ht38EKsuTcHsjkq3lzshCVsTDzwCECDVlz2tWHzcducMqzsXDKXJ0w=
X-Received: by 2002:a05:6402:34ca:b0:56f:ed6f:2b6d with SMTP id
 w10-20020a05640234ca00b0056fed6f2b6dmr129606edc.6.1712856260820; Thu, 11 Apr
 2024 10:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-2-xiong.y.zhang@linux.intel.com> <ZhgYD4B1szpbvlHq@google.com>
 <56a98cae-36c5-40f8-8554-77f9d9c9a1b0@linux.intel.com>
In-Reply-To: <56a98cae-36c5-40f8-8554-77f9d9c9a1b0@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 11 Apr 2024 10:24:06 -0700
Message-ID: <CALMp9eRwsyBUHRtjKZDyU6i13hr5tif3ty7tpNjfs=Zq3RA8RA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/41] perf: x86/intel: Support PERF_PMU_CAP_VPMU_PASSTHROUGH
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:21=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2024-04-11 1:04 p.m., Sean Christopherson wrote:
> > On Fri, Jan 26, 2024, Xiong Zhang wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Define and apply the PERF_PMU_CAP_VPMU_PASSTHROUGH flag for the versio=
n 4
> >> and later PMUs
> >
> > Why?  I get that is an RFC, but it's not at all obvious to me why this =
needs to
> > take a dependency on v4+.
>
> The IA32_PERF_GLOBAL_STATUS_RESET/SET MSRs are introduced in v4. They
> are used in the save/restore of PMU state. Please see PATCH 23/41.
> So it's limited to v4+ for now.

Prior to version 4, semi-passthrough is possible, but
IA32_PERF_GLOBAL_STATUS has to be intercepted and emulated, since it
is non-trivial to set bits in this MSR.

