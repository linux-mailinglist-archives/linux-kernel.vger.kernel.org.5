Return-Path: <linux-kernel+bounces-158040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A7D8B1A89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E68B22907
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E58D3D0AD;
	Thu, 25 Apr 2024 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdQsl6gs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690183C064
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024903; cv=none; b=P2F3JPdEBRBT23j5k6SFIrtLKnbRVYKDmxcFuw0RI6God9Yl2cQvWF2Le1PLAFV46kNuifRB+grtXhvnZ2InK/+KtlmHUJvp2nhch22dqNA2Y8xK/hGBcuYIC/KhgJM36gl+mq3nCnGUncO3gzq6wSJSbicT/u69D+kZJlEuD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024903; c=relaxed/simple;
	bh=Rv79jL1MsnYC4D3TlOenNz3Jb7GaCxBx+ZWVUlVUxAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7ICrx1FaOMevAmXr7d9UPZVhJst2+QP8Yez82SU2eWRyN2xnuX15mfKRPAsK9TmIILs1FKfuEGQMlyfQWByaIgJpYFUn7Zo3vbBsNNiJeZ9dseZaB3cQO4ELGlpwk8zylRQFf9HS/JgP82I9Td7yfDvpROWykbidNqL2KEBNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdQsl6gs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714024901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQ/7vfDjCQVJqJUXQ1xYndqEQtRQGewhmh+Bgyn7BAY=;
	b=CdQsl6gsAxUEWYOtVhAdq1yT0wN3zyC5WZAxWnGOBGendyvOqsGc/n6onL2OsdHQVn4ikg
	fzTlFRnmDzCusbn4XmGYhqERSrDDri4kKDN/uaCB6TTD8pcdCqHFv78LP2yt5wMt4+d7wS
	KhPBFa3xzf52d2sx+cr3zW4muO1CUGw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-g4idyW7fMW22UdB-bTUnYg-1; Thu, 25 Apr 2024 02:01:38 -0400
X-MC-Unique: g4idyW7fMW22UdB-bTUnYg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41552c04845so3101625e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714024897; x=1714629697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ/7vfDjCQVJqJUXQ1xYndqEQtRQGewhmh+Bgyn7BAY=;
        b=hl7+P8Umuwo+im0LfV+oUVzPpZtKJvZZ8Gof4IiyOw2SPSbbxqRD9f6M/0BgUqqZzw
         jFZU2bcqix8I37DqIoSSGDgs87jZJ+hD2mGmrwcqo/ziLKtrSeAJXikQ56z5lJzobgIo
         pqbS1xizMEcnapyoc0qNg/LXQkMYvIrGFrCgRBCewwgGU2WFczaNGNKiKwLofoV2Vx7W
         BOyAaMTYCSgUqGTx2Z5FM4NZN4Q4rDsXGYopYxcBwdUQIBtZDsaQyTY7rltZUAow+NRk
         1bc5gDqwntra+3+NhKAQUhdIqoy+XUR37LKDzAMpZm+x1csetAew/n/kB3T1mIMEtI5+
         TRmA==
X-Forwarded-Encrypted: i=1; AJvYcCXqNPW8oI4NJ47ne1pLpyluucs4V1nWu7+tXWDpQStZ85fu8xcOqtoFmn5cj4Scgz6+XaOXSb+cUPqd/f0NJlEjfl/dobOE5VbFPPeE
X-Gm-Message-State: AOJu0YzDwDFLVcCoDXS/3kQwsaLeeoHCTpY5MjEkLPjGi+hXCPEwyck1
	XvX6BDFpFJLPTr2YPXhTK9ko3g9S0z+Q6+lqk3ZXyAXVIwf7hAN6OXa6GynEP4QS+L+y9ltTy10
	H9vAxpX48LbZVe6bbvlzHmtYSIXGcDkvKN363ZITG0bEAfltYCUgwpUpCB35uoESx8z+sleRjIv
	JlEPmIYWxyQXlUkKKl71XcDXoo4i2L5JHwUo9K
X-Received: by 2002:a05:600c:4ec7:b0:418:ef3:6cfb with SMTP id g7-20020a05600c4ec700b004180ef36cfbmr3539700wmq.26.1714024897199;
        Wed, 24 Apr 2024 23:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZSfuRrRECutOe8DB7H4JRMQ4nFhrjtfWN31viYcrRC965AhFymJAr17XZwxL32uDuMyRuTKRi1v3RAzK9TNo=
X-Received: by 2002:a05:600c:4ec7:b0:418:ef3:6cfb with SMTP id
 g7-20020a05600c4ec700b004180ef36cfbmr3539659wmq.26.1714024896559; Wed, 24 Apr
 2024 23:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404185034.3184582-1-pbonzini@redhat.com> <20240404185034.3184582-10-pbonzini@redhat.com>
 <20240423235013.GO3596705@ls.amr.corp.intel.com> <ZimGulY6qyxt6ylO@google.com>
 <20240425011248.GP3596705@ls.amr.corp.intel.com>
In-Reply-To: <20240425011248.GP3596705@ls.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Apr 2024 08:01:25 +0200
Message-ID: <CABgObfY2TOb6cJnFkpxWjkAmbYSRGkXGx=+-241tRx=OG-yAZQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] KVM: guest_memfd: Add interface for populating gmem
 pages with user data
To: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	michael.roth@amd.com, isaku.yamahata@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:12=E2=80=AFAM Isaku Yamahata <isaku.yamahata@inte=
l.com> wrote:
> > >   get_user_pages_fast(source addr)
> > >   read_lock(mmu_lock)
> > >   kvm_tdp_mmu_get_walk_private_pfn(vcpu, gpa, &pfn);
> > >   if the page table doesn't map gpa, error.
> > >   TDH.MEM.PAGE.ADD()
> > >   TDH.MR.EXTEND()
> > >   read_unlock(mmu_lock)
> > >   put_page()
> >
> > Hmm, KVM doesn't _need_ to use invalidate_lock to protect against guest=
_memfd
> > invalidation, but I also don't see why it would cause problems.

The invalidate_lock is only needed to operate on the guest_memfd, but
it's a rwsem so there are no risks of lock inversion.

> > I.e. why not
> > take mmu_lock() in TDX's post_populate() implementation?
>
> We can take the lock.  Because we have already populated the GFN of guest=
_memfd,
> we need to make kvm_gmem_populate() not pass FGP_CREAT_ONLY.  Otherwise w=
e'll
> get -EEXIST.

I don't understand why TDH.MEM.PAGE.ADD() cannot be called from the
post-populate hook. Can the code for TDH.MEM.PAGE.ADD be shared
between the memory initialization ioctl and the page fault hook in
kvm_x86_ops?

Paolo

>
> > That would allow having
> > a sanity check that the PFN that guest_memfd() has is indeed the PFN th=
at KVM's
> > S-EPT mirror has, i.e. the PFN that KVM is going to PAGE.ADD.
>
> Because we have PFN from the mirrored EPT, I thought it's duplicate to ge=
t PFN
> again via guest memfd.  We can check if two PFN matches.
> --
> Isaku Yamahata <isaku.yamahata@intel.com>
>


