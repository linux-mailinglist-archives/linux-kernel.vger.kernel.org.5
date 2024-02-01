Return-Path: <linux-kernel+bounces-48437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE5B845C22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380D5B29E51
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02A3626C5;
	Thu,  1 Feb 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+5MOZYR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF36215A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802521; cv=none; b=Y9XHhjLzlxsRm4RpClXSRr6whB9rE6dmbS7QXk/LIk8NSfnIyKY8OXJ1+DvwltAAl6v47kHvE4klffr7s+y+yel+eceyshHZN7zD+DelbWTBTg5qx8n9D6dt2Hw9ziFAO6YCHZgafB2Gqzk1ujIhe+TAezExeRCRdjNbk5Llx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802521; c=relaxed/simple;
	bh=u4eMRdiVQD77B+FhnGkSd3q0aMsF0Up82tvfkFTaYQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loF5DTIpJ/Z01A4X9ZVZgMHrOH1F/vLItUIgHRsCvnxwWNfx6EOcLV6EOC105cr8iX/W6pfUUu+Q9ckOeZqFz/cDz9KssRqhicuxemLi3IzpaAnEc2ZzcRcUnhGLsJwSMHwAGG3r2LmQVYWURdX+k//I8kJWEe+yGldVlUhYA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+5MOZYR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706802517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUy0BYrD39GIfiCcfziHo26bl6JbaDYlzmvvdn7klvY=;
	b=C+5MOZYRL5wpSnXGQskH00YMwrhPAC+akP/2cHRcBxdCTjj7/sk15PFKxPp3GQaT+nKTKk
	pqez1c1zowkh96b2usxPetziLOlMMrrA4lZ+IEeH+8XMs//Ifd0HB/x82WAByiUa4wN/xt
	d+KEacc5VHtixViVplQcDKnBYoyNFIw=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-EEJ2-HS1Pn2Et2m51ZBUWw-1; Thu, 01 Feb 2024 10:48:36 -0500
X-MC-Unique: EEJ2-HS1Pn2Et2m51ZBUWw-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-46b23f8dad0so445582137.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802515; x=1707407315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUy0BYrD39GIfiCcfziHo26bl6JbaDYlzmvvdn7klvY=;
        b=FWbcCiIedBAta4oQURoiraFh85acLYvXeCBtw2Q7DlQmp3OQWmB4OKHwiz4tSjLjfW
         evyeIXb0AnSE4pTabIe0zLZLt2+hruDhu8eYQ0et628THaNFTVrmNsgCcVVS/a2EgmeA
         5F3r1VXnKzBVosIXuxRxPndia7i+EMd0DyHJ2Mdt4qKTpwhcbiW2nAj75EoSyzHg6nj7
         89tdoBuWR/YDGi4IS5erTCO9FZDePilek+jeQR41praQ6SvEy6zdLGBvcr+F6YkKS4kN
         abjEDphCYXm2//w7GfwAPPbYw27qTU0K7mrgoDCd0m/u0kOPBaitZbIXSAiPMpG1YI0i
         5GMw==
X-Gm-Message-State: AOJu0YybQdKNu18qHXkxuwU03JIP9+7YP5R3pg6Hyr5e/YN0JZKI649j
	TTtkAiUt2IVtVAw1upzbrGAHWb8IcPC40OxuVq0UdXeGpSymNX86ua7u/J9mHFYWuKYdvO57yeR
	zlnwZomq8bTU4JENVSFrCnsOPPbyWS7klOmHLRo8wac22+pvF43S9kX/aSqJHlYT2EU9QBeBslN
	qeCXDDpE2P/sTQwvJx5a9iq3vSEmBOnrOSH51d
X-Received: by 2002:a67:fac5:0:b0:46c:f3fe:4556 with SMTP id g5-20020a67fac5000000b0046cf3fe4556mr1737761vsq.13.1706802515709;
        Thu, 01 Feb 2024 07:48:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDhVjf+JElyY1WLqEUv9Hx1l5qUK2apiia4uTUVGtGJ2NJ4Sg+VSZKVRPgmbFloNdmnAVo9kLhn8J9ymVn+5E=
X-Received: by 2002:a67:fac5:0:b0:46c:f3fe:4556 with SMTP id
 g5-20020a67fac5000000b0046cf3fe4556mr1737725vsq.13.1706802515324; Thu, 01 Feb
 2024 07:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220151358.2147066-1-nikunj@amd.com> <20231220151358.2147066-11-nikunj@amd.com>
 <CABgObfYwtMQY-E+ENs3z8Ew-Yc7tiXC7PmdvFjPcUeXqOMY8PQ@mail.gmail.com>
In-Reply-To: <CABgObfYwtMQY-E+ENs3z8Ew-Yc7tiXC7PmdvFjPcUeXqOMY8PQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 Feb 2024 16:48:23 +0100
Message-ID: <CABgObfbdJe2eui7_3eopf_g8u56D_YYzJUf2drbLp=ACGP2=LA@mail.gmail.com>
Subject: Re: [PATCH v7 10/16] x86/sev: Add Secure TSC support for SNP guests
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, x86@kernel.org, 
	kvm@vger.kernel.org, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, dionnaglaze@google.com, pgonda@google.com, 
	seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:46=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On Wed, Dec 20, 2023 at 4:16=E2=80=AFPM Nikunj A Dadhania <nikunj@amd.com=
> wrote:
>
> > +       /* Setting Secure TSC parameters */
> > +       if (cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC)) {
> > +               vmsa->tsc_scale =3D snp_tsc_scale;
> > +               vmsa->tsc_offset =3D snp_tsc_offset;
> > +       }
>
> This needs to use guest_cpu_has, otherwise updating the hypervisor or
> processor will change the initial VMSA and any measurement derived
> from there.
>
> In fact, the same issue exists for DEBUG_SWAP and I will shortly post
> a series to allow enabling/disabling DEBUG_SWAP per-VM, so that
> updating the kernel does not break existing measurements.

Nevermind, I keep confusing guest and host-side patches.

/me goes in the corner.

Paolo


