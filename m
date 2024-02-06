Return-Path: <linux-kernel+bounces-55740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCDA84C103
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295472878D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F0C1CD38;
	Tue,  6 Feb 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOQvmWLa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923251CD19
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707263000; cv=none; b=RyzIuBtJ7YPlx/gtk26n3ALJ2bbh/ttnC1PY45pJh/S9YG7iLunPybHZI7yZq5QBQzfN2T9Q48P+OdF9O5Z7yzdjMMQzXX0cZHjD9cAmF5n5Yaboi7tdG4ElApxojdJQhL3RU5q3KZnYpsGeJQxKO9/ohRjurrgUq9yea6asH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707263000; c=relaxed/simple;
	bh=OEPH8KaW12xNM/O3MmDiHe3fCylwb/nDHGw8HY4Jre4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pes4qyX3efAIsR1xkAhiZanwSF4rsTqnWbI4+yM9mXKqof4Toxs2/wAIZr1OHmp+2WGRT5d5Wa88YB22Kp0MlZR9tbjlMUrIiwLNfa1FCP1ztWEgqmKiME8mWitgvviB3t+quPwsYkPy/VoyHdzjw+x6HY2hshGGK4eFCmBT33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOQvmWLa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707262997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKqi7t1q2HxhNGO8YhAm57zpm7GYMl8tE7F26XImgsE=;
	b=AOQvmWLasmf/9ebnCzMWgtIRlhthrcoYDPB3ODRGMOEsvTbMCZbIMqZGJcZd3Yh7cmmyfz
	X/GkZ8PEAV0plwEfq2VS//Qa7pUgoRBiYnM/17hRerQFOPNZKxeRjqj6RetQk9P3W5OLy0
	Ix29aMQJ2ATzTO7FnI8jqXNELT6qKwc=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-MZDE1m3CNGmynA_u62AQig-1; Tue, 06 Feb 2024 18:43:15 -0500
X-MC-Unique: MZDE1m3CNGmynA_u62AQig-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7cce403dfc1so3307809241.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 15:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707262995; x=1707867795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKqi7t1q2HxhNGO8YhAm57zpm7GYMl8tE7F26XImgsE=;
        b=HQikFx6+2VU6IWgzdra2rpuTdmHDcpOP03QfX0PnsrvJeE2nCBU4GttTZYhMuEY01G
         qjraFPb1QZp1+U+3gOIpvaG6QNlER0axn2nHpUQIxSoGWB8vGqTEUhSlbUv/uxwLJtCR
         n86eXytiqQU+QM+K86JX+IF7C/sb19OCOfdR+BvZ0aKUuEIOafk3kx6hXBry8cp9BT0G
         GN7R4qnX323RX5vHe28MiQ0c/Krj7BQTTkgaLyVWkIo+X5SKbyiBdUOr58gITPyAqw4y
         xpFC/zMqfKpkSQ1AXe4UI+yDQAUOsiPa8Zy0rRcevozBNrWKOymZweDpeVOCnYbfPHwy
         711Q==
X-Gm-Message-State: AOJu0YwMNrcp9UK8PZdwNp3AO2EahKuRb2p9OjGpzyKY0UJpueVp9Muj
	4h1oJiwvBbtpRHZ1DYLPJVZ7SBpbjJyqNd7ZnT990nzvwGTtxV2tzUik56HajpHLl63w3hfVlwZ
	t5Tt3txxDoE63Xc/Z01jqq7jYWTeHKg9XipIexdlYE4X6MyEsJ1GEFnmtFAvQPZgfX+87dtiFg9
	DrXHXjEp8V+gh2t4ffplsMLt0MEr8gWYA3JAox
X-Received: by 2002:a05:6102:3592:b0:46d:3368:971e with SMTP id h18-20020a056102359200b0046d3368971emr1269392vsu.33.1707262994826;
        Tue, 06 Feb 2024 15:43:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK/bVHU7inbi2JuHbFzemHZknYr2Bz5VmtM/ti/vbrj7b13wnEQ7QyfNrXQAi+3YI2lNVBCxLXaBTn5/ZlI1Q=
X-Received: by 2002:a05:6102:3592:b0:46d:3368:971e with SMTP id
 h18-20020a056102359200b0046d3368971emr1269355vsu.33.1707262994440; Tue, 06
 Feb 2024 15:43:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230172351.574091-1-michael.roth@amd.com> <20231230172351.574091-19-michael.roth@amd.com>
 <ZZ67oJwzAsSvui5U@google.com> <20240116041457.wver7acnwthjaflr@amd.com> <Zb1yv67h6gkYqqv9@google.com>
In-Reply-To: <Zb1yv67h6gkYqqv9@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Feb 2024 00:43:02 +0100
Message-ID: <CABgObfa_PbxXdj9v7=2ZXfqQ_tJgdQTrO9NHKOQ691TSKQDY2A@mail.gmail.com>
Subject: Re: [PATCH v11 18/35] KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, zhi.a.wang@intel.com, 
	Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:55=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > > > +        struct kvm_sev_snp_launch_update {
> > > > +                __u64 start_gfn;        /* Guest page number to st=
art from. */
> > > > +                __u64 uaddr;            /* userspace address need =
to be encrypted */
> > >
> > > Huh?  Why is KVM taking a userspace address?  IIUC, the address uncon=
ditionally
> > > gets translated into a gfn, so why not pass a gfn?
> > >
> > > And speaking of gfns, AFAICT start_gfn is never used.
> >
> > I think having both the uaddr and start_gfn parameters makes sense. I
> > think it's only awkward because how I'm using the memslot to translate
> > the uaddr to a GFN in the current implementation,
>
> Yes.
>
> > > Oof, reading more of the code, this *requires* an effective in-place =
copy-and-convert
> > > of guest memory.
> >
> > So that's how it's done here, KVM_SNP_LAUNCH_UPDATE copies the pages in=
to
> > gmem, then passes those pages on to firmware for encryption. Then the
> > VMM is expected to mark the GFN range as private via
> > KVM_SET_MEMORY_ATTRIBUTES, since the VMM understands what constitutes
> > initial private/encrypted payload. I should document that better in
> > KVM_SNP_LAUNCH_UPDATE docs however.
>
> That's fine.  As above, my complaints are that the unencrypted source *mu=
st* be
> covered by a memslot.  That's beyond ugly.

Yes, if there's one field that has to go it's uaddr, and then you'll
have a non-in-place encrypt (any copy performed by KVM it is hidden).

> > > > +         kvaddr =3D pfn_to_kaddr(pfns[i]);
> > > > +         if (!virt_addr_valid(kvaddr)) {
> > >
> > > I really, really don't like that this assume guest_memfd is backed by=
 struct page.
> >
> > There are similar enforcements in the SEV/SEV-ES code. There was some
> > initial discussion about relaxing this for SNP so we could support
> > things like /dev/mem-mapped guest memory, but then guest_memfd came
> > along and made that to be an unlikely use-case in the near-term given
> > that it relies on alloc_pages() currently and explicitly guards against
> > mmap()'ing pages in userspace.
> >
> > I think it makes to keep the current tightened restrictions in-place
> > until such a use-case comes along, since otherwise we are relaxing a
> > bunch of currently-useful sanity checks that span all throughout the co=
de

What sanity is being checked for, in other words why are they useful?
If all you get for breaking the promise is a KVM_BUG_ON, for example,
that's par for the course. If instead you get an oops, then we have a
problem.

I may be a bit less draconian than Sean, but the assumptions need to
be documented and explained because they _are_ going to go away.

> > > (b) Why are KVM's memory attributes never consulted?
> >
> > It doesn't really matter if the attributes are set before or after
> > KVM_SNP_LAUNCH_UPDATE, only that by the time the guest actually launche=
s
> > they pages get set to private so they get faulted in from gmem. We coul=
d
> > document our expectations and enforce them here if that's preferable
> > however. Maybe requiring KVM_SET_MEMORY_ATTRIBUTES(private) in advance
> > would make it easier to enforce that userspace does the right thing.
> > I'll see how that looks if there are no objections.
>
> Userspace owns whether a page is PRIVATE or SHARED, full stop.  If KVM ca=
n't
> honor that, then we need to come up with better uAPI.

Can you explain more verbosely what you mean?

> > > > +                  * When invalid CPUID function entries are detect=
ed, the firmware
> > > > +                  * corrects these entries for debugging purpose a=
nd leaves the
> > > > +                  * page unencrypted so it can be provided users f=
or debugging
> > > > +                  * and error-reporting.
> > >
> > > Why?  IIUC, this is basically backdooring reads/writes into guest_mem=
fd to avoid
> > > having to add proper mmap() support.
>
> Yes, I am specifically complaining about writing guest memory on failure,=
 which is
> all kinds of weird.

It is weird but I am not sure if you are complaining about firmware
behavior or something else.

Paolo


