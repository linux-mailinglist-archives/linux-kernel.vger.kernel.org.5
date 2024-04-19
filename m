Return-Path: <linux-kernel+bounces-151738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C168AB338
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDCC1F2338B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E402131BD9;
	Fri, 19 Apr 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHG4xZkd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB589131BC7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543487; cv=none; b=mzOAKas2tLeTcAANwPSLU3A3xgNw/LpC1vrnX1Pw202zGF8RwO+FtDCtsHH1iGl73BJmu7y2SFPIoyWXaqFnmY82FndrVIoWYZiy3mMuCskM8bjlfl3eUxrdWCJZ3GrqJ+DM+zALjPogXyD0Ygz43T+7P4o35cbLVw+ZrbBwQkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543487; c=relaxed/simple;
	bh=ltYnxkGmhFpcFrwY19hNp3Q7sHEjefSoiJDD3ImAFQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXyWSyYtkZa3MLIvPmJlJCNT9KZrtpbziWol8uHsW+KLBOkcA1zbnmY0zwrt5TMr+eAP7PqBT/4K0YlxTqY7Od+TQoljaKU3qd/HKuvfdaBmb7wPx/0D7sQtcTJSkYUPRWoLU1ImqTlg3/2zoOFxJf9/6kUCbD7a4zKIf7iziSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHG4xZkd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713543485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCQBeSy7fxIc6enJRzf0fB8fa+25yMzZIh550xKv9hI=;
	b=QHG4xZkd+55AEDXtRaK4CuVah1nQ/vYF5saC9rB2VkeJDaYbHnJ67dEi+tgQ8aLsXa31v4
	VOkyBJ3BU8ZQTB6EEA9EM/Jv9OTM1M95sbEYLM+uvQdenbesf43aZqwqjcF0/F+XlX5IKm
	cMlkcOXNTYvXU0Ajf05qTMYmMyRG/C4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-xPpKhWRFNQeJiNTUUftGjw-1; Fri, 19 Apr 2024 12:17:59 -0400
X-MC-Unique: xPpKhWRFNQeJiNTUUftGjw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d871086a09so20659291fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543478; x=1714148278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCQBeSy7fxIc6enJRzf0fB8fa+25yMzZIh550xKv9hI=;
        b=Uo9m0bzTxdO63Sb6kheer0lC+GMF28DPQxZm4Pe76OAO7O/PHMh5ql+gK96z4bE3Ym
         ziP5nLXjlvYGGTwVKpgIy9K6kuGDdRQa60FGikbHB9TpYvGnZo1sU9xIEiHkDJeh+5UE
         F9q1VZrl4DcIhXYVXYNBHKvt8Yxebo1Xe35bIpDQjOVJ199DKfYSTevITCvhQA1PFk3S
         MiuJJnj4EXFVdB7aFUyRPfCCZit3yarqQIK9swHyN24QGOWUKuGC900dPBRiQEX7DhCy
         qnzCfnZT36U/4EVXcce/IxQLB9BXQ7E5cnb/cF88v/KEGVB4hnoPOLamFNHcWQTugTkE
         6n1g==
X-Forwarded-Encrypted: i=1; AJvYcCUFFBSuAZydUZBflTc+LFkiicMkYU5dOlS3Uas5Er5RtbiKLS/pudNXnQ1wuNuCPa5HUzPQVMTpxWyYoSqvuyQwqLUlopqlDPPxtoSu
X-Gm-Message-State: AOJu0Yyj4eLfAreijwHGlPb+dfER5RqXWin9mmFISXe59r5pEGHH2BUf
	4e4l6J7jc1212iAMGuwUZBe+F+hvtWtcCuB9ZeKLxk0v0i+nuU4oYaghN8Ywqwk3JVnWXg7dcap
	LqYBKPzL+UxPLWL8v2uYwY0zjrxzHAiDoFgnud4N4OQSCJyDTroLMDrAU5EimgcrsObL6Wg8Q9h
	oG/Yxs2Wy++3PMXwgswT8nl1brv2QdDUo9DpqZ
X-Received: by 2002:a2e:2c1a:0:b0:2da:7af:e6a1 with SMTP id s26-20020a2e2c1a000000b002da07afe6a1mr1689596ljs.3.1713543478029;
        Fri, 19 Apr 2024 09:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFs1jtdCXbIxqpwbuCS5xK85TAjnmuAZI/8TTHrvW2yG8L2y0KPYV6w7Jcu0HjZtCeFL5Vk1Cg+pcQRewqSow=
X-Received: by 2002:a2e:2c1a:0:b0:2da:7af:e6a1 with SMTP id
 s26-20020a2e2c1a000000b002da07afe6a1mr1689551ljs.3.1713543477605; Fri, 19 Apr
 2024 09:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418194133.1452059-1-michael.roth@amd.com>
 <20240418194133.1452059-5-michael.roth@amd.com> <a6086ba5-6137-44a0-9e51-ce4df5eb6ce4@redhat.com>
 <20240419151109.bo6kz4s24jgrmaj4@amd.com>
In-Reply-To: <20240419151109.bo6kz4s24jgrmaj4@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 Apr 2024 18:17:46 +0200
Message-ID: <CABgObfY4brEENatf_kVMcGv85M=ia01TStLGBwV4y9t=iOedAg@mail.gmail.com>
Subject: Re: [PATCH v13 04/26] KVM: guest_memfd: Fix PTR_ERR() handling in __kvm_gmem_get_pfn()
To: Michael Roth <michael.roth@amd.com>
Cc: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, 
	seanjc@google.com, vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:11=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
>
> On Fri, Apr 19, 2024 at 02:58:43PM +0200, David Hildenbrand wrote:
> > On 18.04.24 21:41, Michael Roth wrote:
> > > kvm_gmem_get_folio() may return a PTR_ERR() rather than just NULL. In
> > > particular, for cases where EEXISTS is returned when FGP_CREAT_ONLY
> > > flag is used. Handle this properly in __kvm_gmem_get_pfn().
> > >
> > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > ---
> > >   virt/kvm/guest_memfd.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > index ccf22e44f387..9d7c6a70c547 100644
> > > --- a/virt/kvm/guest_memfd.c
> > > +++ b/virt/kvm/guest_memfd.c
> > > @@ -580,8 +580,8 @@ static int __kvm_gmem_get_pfn(struct file *file, =
struct kvm_memory_slot *slot,
> > >     }
> > >     folio =3D kvm_gmem_get_folio(file_inode(file), index, prepare);
> > > -   if (!folio)
> > > -           return -ENOMEM;
> > > +   if (IS_ERR_OR_NULL(folio))
> > > +           return folio ? PTR_ERR(folio) : -ENOMEM;
> >
> > Will it even return NULL?  Staring at other filemap_grab_folio() users,=
 they
> > all check for IS_ERR().
>
> Looks like the NULL case is handled with PTR_ERR(-ENOENT), so IS_ERR()
> would be sufficient. I think in the past kvm_gmem_get_folio() itself
> would return NULL in some cases, but as of commit 2b01b7e994e95 that's
> no longer the case.
>
> I'll fix this up to expect only PTR_ERR() when I re-spin v14, and also
> address the other kvm_gmem_get_folio() / __filemap_get_folio() call
> sites.
>
> >
> > >     if (folio_test_hwpoison(folio)) {
> > >             r =3D -EHWPOISON;
> >
> > Do we have a Fixes: tag?
>
> Fixes: 2b01b7e994e95 ("KVM: guest_memfd: pass error up from filemap_grab_=
folio")

I'll squash it so when you rebase on the new kvm-coco-queue it will go
away. Thanks to both!

Paolo


