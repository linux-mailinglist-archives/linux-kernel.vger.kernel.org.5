Return-Path: <linux-kernel+bounces-144671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A97C8A4907
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8E51F21B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD472C6B9;
	Mon, 15 Apr 2024 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F1fWXgBG"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1522C1A7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166145; cv=none; b=pE50Drvzz++CJ4hBizkOmSOf3oXq7OMkQyhdLg4+25vuqyYv6aiYEoo6IBxSjgTFdB0tixp0qu4M9aFP1va/MOKm47+jX0IzqBK95eqyCiiYGZ88gMy5zAJCKHhNXFh2AzH755yehFmhpGF2lArTGk+xxF7UI8QO/Vt9IrwRZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166145; c=relaxed/simple;
	bh=du0W4qpqs7iigYAyvC1Db2y4iMsMSpAINvx2wlgvTEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUwwgo3gWy8/mBOnO2H9/6HiD4lKPryV9I+FNHAKqdm7qf4vDQEI3ybOCvh5FK+M1DEJRG5QHrSFHHm+5SMOpyTyaOe5Yjjfl3uWWCWVhl8bPN3RSiik8iCFxaT3oZjjdQFGGynU1KfNSsUHi5W1yPtTdyApBcw7DTbd/Rgum7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F1fWXgBG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d487659bso3432473e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713166142; x=1713770942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du0W4qpqs7iigYAyvC1Db2y4iMsMSpAINvx2wlgvTEM=;
        b=F1fWXgBGIep+W3E0eMbHNfYX9nn/htFXcxbVcd9p+j8vcTIaF9NQziTFFiDQuG+tIj
         WgNSqsO5JTpPVE5trV9YqjweDXknwRKh50suWzEr3+3UlTueNMm0y4kwne4dSsZIBWcy
         f7kBp/vXz5VaHhNNkiC+D5q8SpeBNO5S9gGBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713166142; x=1713770942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=du0W4qpqs7iigYAyvC1Db2y4iMsMSpAINvx2wlgvTEM=;
        b=snXRDIriNzSFj5YdmrioSjMdhUXLe+dDNe1pF0K6ZCpToOW2Uyp49n2tr4c1mJKNH3
         g1kvV/1iEKb4x8j+25w5QX2iWTSMdhQYv+SrPL+OIY4xHgibXDhupDcD2gys76GJxBoG
         z3ppZ3zTIAP9dVypPxZ7/S2tRlMgrjFbws9qtJ2IYPpHMb/No9P2O1a6T5C8v5AaEXV/
         O1Kg+7LIp0vctBuczsDZPNLj7vUrs5V9WmVZs/RnYlNkiZBJYOnBy+YaQBjHq3zphjvN
         vsrWqvCShuY79y0Bc9cE6imcAUgGe6vF7QhuH2BYUwvFy3dloeHDu/rIh/jbOwK72urj
         djtw==
X-Forwarded-Encrypted: i=1; AJvYcCWdlpHnjnWsKU6fib0ut2DnOPc3jzaib4BZB8emkwFVOqFZTVrboimAdpxnBFGUOWIcAeAI6eCKJN0VC2MTM26S1NkxBvBacUdTQX80
X-Gm-Message-State: AOJu0Yx+l4vPsK49wb7ku8Zdr2R+UGTDNKZ1iKqWF+c6yu377XZSVJwU
	l4EkdawIRa6bwUvIBznSVLujeExmAPhjq50RGFwMdfUeJF8WNxbKRjrXdtihh1HwM13yzjEtMJZ
	t/q3ImVrunCHzDujFNN8/qv9ZrM0VO8YWshGL
X-Google-Smtp-Source: AGHT+IERO5rG8jweS1bNqQ1EXQ2ssIePQAJ4H8RW/7zN4PAfCchdCg5YM+BZHb/VI06OVCMrIz/XiyTQ8yMwuhxGerw=
X-Received: by 2002:a19:7008:0:b0:513:5a38:f545 with SMTP id
 h8-20020a197008000000b005135a38f545mr5926585lfc.62.1713166141844; Mon, 15 Apr
 2024 00:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229025759.1187910-1-stevensd@google.com> <20240229025759.1187910-9-stevensd@google.com>
 <15865985-4688-4b7e-9f2d-89803adb8f5b@collabora.com>
In-Reply-To: <15865985-4688-4b7e-9f2d-89803adb8f5b@collabora.com>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 15 Apr 2024 16:28:50 +0900
Message-ID: <CAD=HUj72-0hkmsyGXj4+qiGkT5QZqskkPLbmuQPqjHaZofCbJQ@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] KVM: x86/mmu: Handle non-refcounted pages
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:03=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hi David,
>
> On 2/29/24 05:57, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > Handle non-refcounted pages in __kvm_faultin_pfn. This allows the
> > host to map memory into the guest that is backed by non-refcounted
> > struct pages - for example, the tail pages of higher order non-compound
> > pages allocated by the amdgpu driver via ttm_pool_alloc_page.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
>
> This patch has a problem on v6.8 kernel. Pierre-Eric of AMD found that
> Qemu crashes with "kvm bad address" error when booting Ubuntu 23.10 ISO
> with a disabled virtio-gpu and I was able to reproduce it. Pierre-Eric
> said this problem didn't exist with v6.7 kernel and using v10 kvm
> patches. Could you please take a look at this issue?

This failure is due to a minor conflict with:

Fixes: d02c357e5bfa ("KVM: x86/mmu: Retry fault before acquiring
mmu_lock if mapping is changing")

My patch series makes __kvm_faultin_pfn no longer take a reference to
the page associated with the returned pfn. That conflicts with the
call to kvm_release_pfn_clean added to kvm_faultin_pfn, since there is
no longer a reference to release. Replacing that call with
kvm_set_page_accessed fixes the failure.

Sean, is there any path towards getting this series merged, or is it
blocked on cleaning up the issues in KVM code raised by Christoph? I'm
no longer working on the same projects I was when I first started
trying to upstream this code 3-ish years ago, so if there is a
significant amount of work left to upstream this, I need to pass
things on to someone else.

-David

