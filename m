Return-Path: <linux-kernel+bounces-158037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC18B8B1A79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878DB1F22FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286493D0AF;
	Thu, 25 Apr 2024 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuJNxCPp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74993CF51
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024604; cv=none; b=AEegz4iNDKSWxgHkHiRKeml9LCLotFN+vAOzfx6uKilcU0HA07ZW2QUi4aQFTEbzsTCwtmp2592eVI9SD/PdD4sAM/BkTx9qRIPlYz57gclHsBr9fo/HVe7YuU4E/QG7ryhZKThsvpMsT2IbOOiFIQl9vMBuPL1cC4v27YPsrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024604; c=relaxed/simple;
	bh=O4CznqeG8T+JWseL09yaa78FtOWwIBAlH8a0Gt7nzEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpRKFWwczwkiPcWKkOr9TAEvFeCmwJ1aZFGSTn2r2MteLMHUkNsC8opN12dqMFq6eTFLWV0IwR6sXfv/Ycwy8f0+CrR+RaNKt/V799Z7+pWK+OJUuvuZL9EefvTO+bYr973reckf3w1ZUMl17f6QgMEqag+qtAoLvLg4k4BvhcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuJNxCPp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714024601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exOCW1wmcScF7uY7sXoI9wagJW8drQNtgczHEogNU4E=;
	b=EuJNxCPp9BMNnK58MXRDqmAtM6SuH5D2NpIMCdWJjNo2gRv3gAz/BFiApc7NN+72GRz7i7
	9BWM6uIhx4JUTtn9LibndFnJEb4ZQal4vQs6bPPpXbFP013XZ7ZMKvWSg08kOqT8ODxSRU
	+zJFka+0Z5xr8E+pcKs35K75UYY7vhU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-aqy910WIN1Si8rbo0U_Ivg-1; Thu, 25 Apr 2024 01:56:37 -0400
X-MC-Unique: aqy910WIN1Si8rbo0U_Ivg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-346b8ef7e10so398974f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714024596; x=1714629396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exOCW1wmcScF7uY7sXoI9wagJW8drQNtgczHEogNU4E=;
        b=ZDZ0iH4RjdjsMXnbx0dFf3v398RP0k3zBxRu8IRrNMAX3FmaJBGNy6YiIoWxUYT5xw
         fOvkIINlknxecfnYkuNe69AHfrS5xwKyvRvgNJ/7xJ0uHtzzpAEiCSA1rbQ/MvODRdag
         YlqWpnShjyOmPNO2vlHIAUr4JW8OqSlxcvvBPQRhtwAYoCvU9BOah1/yVxS6xrFjAtG9
         QWgFdpxnQuJhkFba4IqsEQSiHiwXDjjN8D1cqZZmFItOGBMT1PEwQ+mTfBhFDouFKIHA
         Ns7gzEeO3iQcSDRMaZHvp3cgW34PJJKPOS6MNkGqYev4JLgfCNhpb6fVsG5lJOG9Jkz7
         nhnQ==
X-Gm-Message-State: AOJu0YxVd1uQJ1BNwPArwCK9Ie8Af2inkpGaQAci6Uk7ZVlu8MYoCwu9
	CGRd2b/yF+DlTuYjpGm1sr1ERS+JSLm21v8sW1Zw2Cx7OFHlRn6YLl7nsdoy4Dd4+rZ+bn1ZPa9
	KKmN3U5C3xamYhk6TcjzHLq3zSnT+yMuOgKAq4/WzSrxEHaSgmRcQZY/Zd02ou1agP4W5Z6+68t
	e7911xnG2+D0srWMRAGd3dMjYml8+cyAKXjXKX
X-Received: by 2002:a05:6000:18c2:b0:341:ce05:dba5 with SMTP id w2-20020a05600018c200b00341ce05dba5mr3252463wrq.30.1714024596257;
        Wed, 24 Apr 2024 22:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQMN4AK15f2j3BmYvEcbraA8vxJgm5FQOQBHc0h7FbM4crcHaNHD/tT0WZx2+vXC7+1vOLMupG25xmdYYeTI4=
X-Received: by 2002:a05:6000:18c2:b0:341:ce05:dba5 with SMTP id
 w2-20020a05600018c200b00341ce05dba5mr3252456wrq.30.1714024595937; Wed, 24 Apr
 2024 22:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404185034.3184582-1-pbonzini@redhat.com> <20240404185034.3184582-10-pbonzini@redhat.com>
 <ZimIfFUMPmF_dV-V@google.com>
In-Reply-To: <ZimIfFUMPmF_dV-V@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Apr 2024 07:56:24 +0200
Message-ID: <CABgObfYgmuBbzQP+ZQhpm7BEgiwLTz6W0g7=EK-xwd9=CWUCOw@mail.gmail.com>
Subject: Re: [PATCH 09/11] KVM: guest_memfd: Add interface for populating gmem
 pages with user data
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 12:32=E2=80=AFAM Sean Christopherson <seanjc@google=
com> wrote:
>
> On Thu, Apr 04, 2024, Paolo Bonzini wrote:
> > +long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, l=
ong npages,
> > +                    int (*post_populate)(struct kvm *kvm, gfn_t gfn, k=
vm_pfn_t pfn,
> > +                                         void __user *src, int order, =
void *opaque),
>
> Add a typedef for callback?  If only to make this prototype readable.
>
> > +long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, l=
ong npages,
> > +                    int (*post_populate)(struct kvm *kvm, gfn_t gfn, k=
vm_pfn_t pfn,
> > +                                         void __user *src, int order, =
void *opaque),
> > +                    void *opaque)
> > +{
> > +     struct file *file;
> > +     struct kvm_memory_slot *slot;
> > +
> > +     int ret =3D 0, max_order;
> > +     long i;
> > +
> > +     lockdep_assert_held(&kvm->slots_lock);
> > +     if (npages < 0)
> > +             return -EINVAL;
> > +
> > +     slot =3D gfn_to_memslot(kvm, gfn);
> > +     if (!kvm_slot_can_be_private(slot))
> > +             return -EINVAL;
> > +
> > +     file =3D kvm_gmem_get_file(slot);
> > +     if (!file)
> > +             return -EFAULT;
> > +
> > +     filemap_invalidate_lock(file->f_mapping);
> > +
> > +     npages =3D min_t(ulong, slot->npages - (gfn - slot->base_gfn), np=
ages);
> > +     for (i =3D 0; i < npages; i +=3D (1 << max_order)) {
> > +             gfn_t this_gfn =3D gfn + i;
>
> KVM usually does something like "start_gfn" or "base_gfn", and then uses =
"gfn"
> for the one gfn that's being processed.  And IMO that's much better becau=
se the
> propotype for kvm_gmem_populate() does not make it obvious that @gfn is t=
he base
> of a range, not a singular gfn to process.
>
>
> > +             kvm_pfn_t pfn;
> > +
> > +             ret =3D __kvm_gmem_get_pfn(file, slot, this_gfn, &pfn, &m=
ax_order, false);
> > +             if (ret)
> > +                     break;
> > +
> > +             if (!IS_ALIGNED(this_gfn, (1 << max_order)) ||
> > +                 (npages - i) < (1 << max_order))
> > +                     max_order =3D 0;
> > +
> > +             if (post_populate) {
>
> Is there any use for this without @post_populate?  I.e. why make this opt=
ional?

Yeah, it probably does not need to be optional (before, the
copy_from_user was optionally done from kvm_gmem_populate, but not
anymore).

Paolo


