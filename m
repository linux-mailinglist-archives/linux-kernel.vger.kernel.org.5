Return-Path: <linux-kernel+bounces-56096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4084C5E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BD01C22FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45220200BA;
	Wed,  7 Feb 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gchjrn6A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C74200AE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293010; cv=none; b=miVddJqmj9zQx53L2nW7761qao4oDK6AsF0AE4wjbrhCXWdTGMwKDUTocKap8pO2RHXpJYTo1Y0Twm44gz6UGWoRN8ptCtByxRSQHs5sm/7DLsq2g/SV5fPfyvzMLvL3UyRxhgTwHD57pK4KqgETYcfmY+pm6Ki8KwqVNOywq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293010; c=relaxed/simple;
	bh=bJ71cMX8UtV3aRxuUkL58YBzQmBYqGTAktwFzLIIFOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbHjAfKOwZLZymPIp1IQeVOr+9lp5LiCLJd9wxMQS5BPjKyzDZc0IuMHvyhaCVC1abamcOXtRn1S49kectQdyANvGCe/zFLbrux9D1zh1NLQ0t6ekebZzGcPM1xQwJhKsR+H92MjsB7dQymLAaVn9ZHuno8OxYfl0Dx8LpEUtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gchjrn6A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707293007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2cTjV2SgwNJoZVYjRYppg2qiwtD1i4vzmwnoPMVa3o=;
	b=Gchjrn6AWMGCpTN4f9vIcpPWWPc4xfHbkXyImCqNBT7hrjhhTPfY49vY8q/hvQQPGdtgev
	3UkrAX2jnGVNJOCPhHgmmcpW2E9hkdQrpCBZ5rMt7W+RgocVla/V/LXMUcct/GicOYQh4O
	R9nUxksrM5LgsSE6r6s5vZR/Fl2CWT0=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-XJXv3lQUPDuAysmqqJgCYA-1; Wed, 07 Feb 2024 03:03:26 -0500
X-MC-Unique: XJXv3lQUPDuAysmqqJgCYA-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-46d319fd52aso397078137.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 00:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707293006; x=1707897806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2cTjV2SgwNJoZVYjRYppg2qiwtD1i4vzmwnoPMVa3o=;
        b=uEH0tXq70TmAaCScOCKpcsQjJuZKViVQ0vVNEW1vPp+6moQ4FwR7ypBjMCg5c6N+R+
         aOVsJSW+CGABSKrCZv/+EM0rRFGsuQjA8ly/rF+Ve3jCHvHvPcs9T+f4RScSpEt50e7v
         4MoAzC3zuZPkWoTaWC1Oa3lpnToM7ek7JUpf5toIdtB45HYq37PNVHB4VIb499xReUtB
         QZkUSBrhnJGf6z5epRFl7/vwaLr1Z6U5gHmxSriaacsfwZpnXA9ybCm46Q6bujtr4XlW
         wjfZ0PAE0pmyqH2DRZGAOLA4XY/aapEDxhmmurs0jH/lTE9lsD1OCk1oeb30DP/SwsS/
         3Jxw==
X-Gm-Message-State: AOJu0YzuwtQJrHy4CCnkStnvR4sJPR/nHIzCw9Uhm9YQ4Iye7ywZWrYP
	l9uioMaThqOUzCc14JGJa1daUhu2yKtrmhAL6IiguBcfrGo18IbHkvREvvyidNTozWOFV+47rJE
	phENeFvbyn37tAwZWtIJtKYv1Y22jUI7gEjDmif0QLWWB4/toXc18P1sUhBrt+fnaKJGG2rFrdE
	gZeAs3dpELcfo03eR1VTULuP5NtoAbeMdjaFHV
X-Received: by 2002:a05:6102:2362:b0:46d:2b0f:aeb5 with SMTP id o2-20020a056102236200b0046d2b0faeb5mr1289275vsa.16.1707293006035;
        Wed, 07 Feb 2024 00:03:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaZzeu/zdF20sLH9pOgZUQvjc4KHv6RddT40BWYC2FIjhnKgF5FPo4oS7Mufd54mwaj/3nM5NsQwxICjqiu1o=
X-Received: by 2002:a05:6102:2362:b0:46d:2b0f:aeb5 with SMTP id
 o2-20020a056102236200b0046d2b0faeb5mr1289258vsa.16.1707293005763; Wed, 07 Feb
 2024 00:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230172351.574091-1-michael.roth@amd.com> <20231230172351.574091-19-michael.roth@amd.com>
 <ZZ67oJwzAsSvui5U@google.com> <20240116041457.wver7acnwthjaflr@amd.com>
 <Zb1yv67h6gkYqqv9@google.com> <CABgObfa_PbxXdj9v7=2ZXfqQ_tJgdQTrO9NHKOQ691TSKQDY2A@mail.gmail.com>
 <ZcLuGxZ-w4fPmFxd@google.com>
In-Reply-To: <ZcLuGxZ-w4fPmFxd@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Feb 2024 09:03:13 +0100
Message-ID: <CABgObfbPeaD83yYM8cHKuffV9CTPZP4QPMbdyRyLUF1xX7KBvg@mail.gmail.com>
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

On Wed, Feb 7, 2024 at 3:43=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
> > > Userspace owns whether a page is PRIVATE or SHARED, full stop.  If KV=
M can't
> > > honor that, then we need to come up with better uAPI.
> >
> > Can you explain more verbosely what you mean?
>
> As proposed, snp_launch_update_gfn_handler() doesn't verify the state of =
the
> gfns' attributes.  But that's a minor problem and probably not a sticking=
 point.
>
> My overarching complaint is that the code is to be wildly unsafe, or at t=
he very
> least brittle.  Without guest_memfd's knowledge, and without holding any =
locks
> beyond kvm->lock, it
>
>  1) checks if a pfn is shared in the RMP
>  2) copies data to the page
>  3) converts the page to private in the RMP
>  4) does PSP stuff
>  5) on failure, converts the page back to shared in RMP
>  6) conditionally on failure, writes to the page via a gfn
>
> I'm not at all confident that 1-4 isn't riddled with TOCTOU bugs, and tha=
t's
> before KVM gains support for intrahost migration, i.e. before KVM allows =
multiple
> VM instances to bind to a single guest_memfd.

Absolutely.

> But I _think_ we mostly sorted this out at PUCK.  IIRC, the plan is to ha=
ve guest_memfd
> provide (kernel) APIs to allow arch/vendor code to initialize a guest_mem=
fd range.
> That will give guest_memfd complete control over the state of a given pag=
e, will
> allow guest_memfd to take the appropriate locks, and if we're lucky, will=
 be reusable
> by other CoCo flavors beyond SNP.

Ok, either way it's clear that guest_memfd needs to be in charge.
Whether it's MEMORY_ENCRYPT_OP that calls into guest_memfd or vice
versa, that only matters so much.

> > > Yes, I am specifically complaining about writing guest memory on fail=
ure, which is
> > > all kinds of weird.
> >
> > It is weird but I am not sure if you are complaining about firmware
> > behavior or something else.
>
> This proposed KVM code:
>
> +                               host_rmp_make_shared(pfns[i], PG_LEVEL_4K=
, true);
> +
> +                               ret =3D kvm_write_guest_page(kvm, gfn, kv=
addr, 0, PAGE_SIZE);
> +                               if (ret)
> +                                       pr_err("Failed to write CPUID pag=
e back to userspace, ret: 0x%x\n",
> +                                              ret);
>
>
> I have no objection to propagating error/debug information back to usersp=
ace,
> but it needs to be routed through the source page (or I suppose some dedi=
cated
> error page, but that seems like overkill).  Shoving the error information=
 into
> guest memory is gross.

Yes, but it should be just a consequence of not actually using
start_gfn. Having to copy back remains weird, but what can you do.

Paolo


