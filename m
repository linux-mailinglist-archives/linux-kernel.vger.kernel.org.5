Return-Path: <linux-kernel+bounces-164577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BFA8B7F94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274941F23AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA228181CF6;
	Tue, 30 Apr 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4Ej+Evc"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A3A181B92
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500969; cv=none; b=hUrTXNjPDuRk0VWQP81eOPRcDfAO+ctfEVJsHz2vrd6SiWix6arqBlaD0Qii2YPGv4abohzvw0f5p8lcQsCNG2NaxnUFZSxfMpXhIFvgSkGL1c5LE1j9tjVNaJnvJbsNgQL1e7Cf4PooRCWNTxeYmVJFe92enRbY8UwUSYpGrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500969; c=relaxed/simple;
	bh=KYDQaXJbUy4BBpl0zCpu3SweTMRYh4Sl8T2mNnNwAMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MS+bTMmJ/lH40NFETt2iRqpSyypJngipJ5XQlCSLokZzvkIodxxIiOQBjdBZvlTjMvqjrmh7pWPKiFCe0+/hk0RlAmnK7qe/DikK6LsjRu/LotnlE7h+uTKAtj3Ew5oYYljXribH2aXtE3JSDwjnT/A7G6akcg+6E6NVAjyi14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4Ej+Evc; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso96801391fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714500966; x=1715105766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Omc/SJcyagpOCeRfDDLKmzu/HYd0lcKpkm9AyuFs7Xw=;
        b=K4Ej+EvcE14bG2EXcAPolFS15OF9jTU9WKljyJWAxGgVMCq6aE0BEdFHExObbf0Ctp
         chD2geL2MXPShq+F0aZWhOlWwvgFk/6SHq5CnuJKiL1NiYr+c4hgG2ufe7bC7PtSJRk5
         JBq0IXwfAP3AwDmbuLIpr5ZceWts9L1ZiImQD8ceSDBxzRYeLzSejg2LS3029Oy1wset
         c9B1iItTOHeQQVYcNgk6xtWkOay+FzYvuDeQ4yEYavpgyciw7Glj4vAYspscIx4s47fv
         nAJ2Hwuuvc8VbTPj9GIDYqLVig9x0d3IABOBJmK2GPHkme+NsrhSbuFqZESRxYAF0q2E
         KfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714500966; x=1715105766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Omc/SJcyagpOCeRfDDLKmzu/HYd0lcKpkm9AyuFs7Xw=;
        b=tXsNB7mUpS1yKnQaMPw5K/QUyoslAIAWeNVHcUK0CM+6V8E+/WX0Z5nCDaIlOJ95LV
         gxYxTg5o7sdedigCbDqJgUf2D66YT+V2u9m+cDGyGDkyNVuicYYTWGoKjrc/mFbYpQaL
         PvF7Q7htK+SfEbr6rAx0tnozRD1ai55KnveKH5uIl0q8DTA2+6AEqfOk8QkHTgRO97t8
         4Z3RvezcpLO9+SP4iUSP3sujn4JR+69sPo/qW/D3+8GEHky8aItuYoF4vDYPFqNv6R7n
         rk1TeqnqH8kjQHiSPshQiy4+ZkUsJ1a5hKBK/3sLePiZwaXqoYNVZgUFLreBr+4prVKc
         fONg==
X-Forwarded-Encrypted: i=1; AJvYcCVjd9uz0AR4Bx49BEwEsNbL07dmUbdFD6TXjPBkfP6dQub0TSKFvrN2tIxP69f+WDXfD9JYyWd96i0+JyB3Bc92IrdTpySEQ84WwgbR
X-Gm-Message-State: AOJu0YzfRrL1Xsr42PcyzbTJcNQ+pdV/mUPOiaZ/QOlB9Jvqsqzk4+9o
	vvnLhn8NiCfu1LKDv+HDjGtWzIKuByjXkrlACd/kFOtduibbmffIYJKMGoOaWiK9P6wD+wBNLB/
	EKKK6ztRcfAgVkKtOvHHyM3msovkOt7ycHMEh
X-Google-Smtp-Source: AGHT+IF7zwYJP/hkeVCzIRKcIqK9Ty42z14qCbU+QG7hU31mOATBmrjf2DM0oR20kXLfbgW4V681zULCQgNXql4sQLo=
X-Received: by 2002:a2e:8099:0:b0:2e0:6740:112b with SMTP id
 i25-20020a2e8099000000b002e06740112bmr318592ljg.47.1714500965688; Tue, 30 Apr
 2024 11:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430005239.13527-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20240430005239.13527-1-dapeng1.mi@linux.intel.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Tue, 30 Apr 2024 11:15:29 -0700
Message-ID: <CAL715WK9+aXa53DXM3TP2POwAtA2o40wpojfum+SezdxoOsj1A@mail.gmail.com>
Subject: Re: [PATCH 0/2] vPMU code refines
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 5:45=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> This small patchset refines the ambiguous naming in kvm_pmu structure
> and use macros instead of magic numbers to manipulate FIXED_CTR_CTRL MSR
> to increase readability.
>
> No logic change is introduced in this patchset.
>
> Dapeng Mi (2):
>   KVM: x86/pmu: Change ambiguous _mask suffix to _rsvd in kvm_pmu

So, it looks like the 1st patch is also in the upcoming RFCv2 for
mediated passthrough vPMU. I will remove that from my list then.

Thanks. Regards
-Mingwei

>   KVM: x86/pmu: Manipulate FIXED_CTR_CTRL MSR with macros
>
>  arch/x86/include/asm/kvm_host.h | 10 ++++-----
>  arch/x86/kvm/pmu.c              | 26 ++++++++++++------------
>  arch/x86/kvm/pmu.h              |  8 +++++---
>  arch/x86/kvm/svm/pmu.c          |  4 ++--
>  arch/x86/kvm/vmx/pmu_intel.c    | 36 +++++++++++++++++++--------------
>  5 files changed, 46 insertions(+), 38 deletions(-)
>
>
> base-commit: 7b076c6a308ec5bce9fc96e2935443ed228b9148
> --
> 2.40.1
>

