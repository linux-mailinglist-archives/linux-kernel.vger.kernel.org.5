Return-Path: <linux-kernel+bounces-49194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABB084670B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E27BB23C9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D6BF9C8;
	Fri,  2 Feb 2024 04:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5kQMXVZ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9EF50A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 04:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848875; cv=none; b=XRzEP7vW6/tm0p+aRIrpRs1bt/xAb0MNO44wlcxqa6kXHd4dpz4a8EAcOoKArKOTIajFCzAropvx1liPdSwqthYFXI0x7tHuDn3QoqE4w6Yl0wNN+x121sOShAoZF5ZRYE6IjnkrwB4vRnqft37gkQvOJU6/tZpSr+fuMHza33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848875; c=relaxed/simple;
	bh=/pB71NBkTE0MT14Da9dzFzR+degq732UxHP/HWHbMgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7oU4kL6MSp+GX1YHT29DmXHFDJCkVqLaE5RZPy5AUG++2RnuWERJqI2zWmKJ36IdEndgO7HEG8cYVJQWlg7KHNNyhf9oxAhm8eInk23+WoF38dx2u2hiAXb3YRvNFURnkOzqqCoAFWi9N924Vp5eZqtv2Jx0RWqzJaj6kMvnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c5kQMXVZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a318ccfe412so183514966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 20:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706848872; x=1707453672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRhBf4Bx7DrVWvh5cmLuWZexlCXbaWG6blbF9sDghb8=;
        b=c5kQMXVZcO8Y61DeIBbzVtNORd9eZy4AHVEPt/8U0LIE+0WooVE0RPOdbC61eaotQn
         gG4/nn3Hpi+mHOiVnzEfJsowBG2tKFMw8gl8l2uYg8qM9oHkkEku5yhZRjvpFL9glao4
         y9O6YDodBFTTo1fjFUcQzHQprxN/aqLOz0fQDfnTbimArzIQdtUxZ1lSSDV7+C/e5CSP
         wzKqcjCZ4JMExd6yFzuZZHaGye8qpdc0qD/0vl0nQK0qcf6Q2LKMTMf61Y0W0DKXPWky
         QyJUhaNkYiGRkRWp26frq7jqXF5dW22psM4sgrC9V1gGnNBMA/jtmofAY3zZzXyYKPmj
         80Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706848872; x=1707453672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRhBf4Bx7DrVWvh5cmLuWZexlCXbaWG6blbF9sDghb8=;
        b=K3mzvn24bHYuqC+og6eozMBzB0ETcNo7D2q3EeBNW0L4z/ZjtoPrybh1A13W7PZCoO
         PHe/AkN8Tzj+qJ+ZS5TsRipb0qExZIF1HkBYhMPed5Kms8cpCCxB5x/tw+JQWzxBAp+H
         EZbm6xbvcsHPNscv0sObujnw+kqpfaQswtUYtlwS4BxHHBITErtHDCKNuDQ7UXwPaLyd
         5lRimftLfkYEIoJD+I4+dYgkGKXJ9Xp9NtNJ+CX1IBZv4xYWMsRyNRq7qnhFxrOWYYX4
         HZVpLZ0GiEkG2TT6OJMjRBpGnI7/U2KXj0GLnTnZox8Up8YiOVbuCoj7JJrp8rJwQnyD
         gbDQ==
X-Gm-Message-State: AOJu0Yw49X7ONdtJvDKtfqW+oH06sVf/GfwVIr3NSU5huBP2qby8V0se
	Q9mlt//4q53S0PElENkMXlEJKwmdcoVUdUZupwHHDnqjIyERIAFu8lsj+7e89zqBjSiAso3wp8A
	DiuGWvqFOi1Zh0EMtFOtALHe9usAXH0SKJT9u
X-Google-Smtp-Source: AGHT+IEVE5Y3uH5AqP3V6QPyHqLgJU0azKUT5CeTH/HmRivo8ARRLcdrlEqfII1PGFRkUc05mpeJSMRCMT6FSFjC8i8=
X-Received: by 2002:a17:906:30c5:b0:a35:cbf1:c254 with SMTP id
 b5-20020a17090630c500b00a35cbf1c254mr625339ejb.11.1706848871298; Thu, 01 Feb
 2024 20:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-4-vannapurve@google.com>
 <0fda610f-a8ae-4133-a9d5-e9084c88ba7b@linux.microsoft.com>
In-Reply-To: <0fda610f-a8ae-4133-a9d5-e9084c88ba7b@linux.microsoft.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 2 Feb 2024 10:10:56 +0530
Message-ID: <CAGtprH_Kr+PfK5MxcoYB3fhQZ7S4uaxQz7Lr+ZN-nbshViG4hg@mail.gmail.com>
Subject: Re: [RFC V1 3/5] x86: CVMs: Enable dynamic swiotlb by default for CVMs
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rientjes@google.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com, 
	pgonda@google.com, michael.roth@amd.com, kirill@shutemov.name, 
	thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:50=E2=80=AFPM Jeremi Piotrowski
<jpiotrowski@linux.microsoft.com> wrote:
>
> On 12/01/2024 06:52, Vishal Annapurve wrote:
> > CVMs used SWIOTLB for non-trusted IO using dma_map_* APIs. This series
> > will ensure that dma_alloc_* API to also allocate from SWIOTLB pools.
> > Initial size of SWIOTLB pool is decided using heuristics and has been
> > working with CVM usecases so far.
> >
> > It's better to allow SWIOTLB to scale up on demand rather than keeping
> > the size fixed to avoid failures with possibly increased usage of
> > SWIOTLB with dma_alloc_* APIs allocating from SWIOTLB pools. This shoul=
d
> > also help in future with more devices getting used from CVMs for
> > non-trusted IO.
> >
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> >  arch/x86/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 1566748f16c4..035c8a022c4c 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
> >       select X86_MEM_ENCRYPT
> >       select X86_MCE
> >       select UNACCEPTED_MEMORY
> > +     select SWIOTLB_DYNAMIC
> >       help
> >         Support running as a guest under Intel TDX.  Without this suppo=
rt,
> >         the guest kernel can not boot or run under TDX.
> > @@ -1534,6 +1535,7 @@ config AMD_MEM_ENCRYPT
> >       select ARCH_HAS_CC_PLATFORM
> >       select X86_MEM_ENCRYPT
> >       select UNACCEPTED_MEMORY
> > +     select SWIOTLB_DYNAMIC
> >       help
> >         Say yes to enable support for the encryption of system memory.
> >         This requires an AMD processor that supports Secure Memory
>
> What this does is unconditionally enable SWIOTLB_DYNAMIC for every kernel=
 compiled
> to support memory encryption, regardless of whether it runs inside a conf=
idential guest.
> I don't think that is what you intended.
>

Right, I will have to add a way to toggle this support dynamically in
addition to having the support built in, based on more discussion
around 2M allocations and dynamic scaling.

> Best wishes,
> Jeremi
>
>

