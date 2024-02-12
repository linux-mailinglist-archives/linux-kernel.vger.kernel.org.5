Return-Path: <linux-kernel+bounces-61275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C84D851038
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18ABF289000
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0DB17C74;
	Mon, 12 Feb 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjaIMASa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DD18AE4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732047; cv=none; b=nWlC5Fs2TC/vRLSsyWZp92qTfDf4XTJfThysdmguqMSSF7MgYn2EfneHZ/lqP0ZlbB5YzvYl1EHOOpoUX9dxBv//ZPkboxQnRUZgz8JuelGDVfz9/6jRDlWMwecMNS8znVHYCka+CIAkAzPZxS55WduAmS5Ip0TVziHs/5oAM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732047; c=relaxed/simple;
	bh=3y4L/Ww9jOlNtiXvABcrsz/8FFXP25E4KZgEUZ8G8fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofjFQn/CLOqgJHWNXWzjvh7Pcq8MGie9P/nbObxrbv0fDb5xVmItSUGnJ61KI6LO3rznUBQxuRlceYCmQn0NhN4sipzAB7kZduNdUjgGt74njFp2G9ob7v9l5jblvGE4TrQe8OKcME6W+i3ukehDr1SSGyJrk31YxWtvp513p0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjaIMASa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707732044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l44duX4bruiSysv390/0MeGikPC351P53LEkSBBfAnE=;
	b=bjaIMASaEaAuxbIRGbbCr0TkHp9FRdoZ7R4ctkW9yZSXgGfs7YVEdqK03WEs3rXy9+/upS
	Et+aZG18/o9uNkJ8r4hBYmpmwi0FKSonULVxnqgJi/S7vYMjLnBR02CY1FDt7c7LXmcLtL
	aPaA+tvjCChIJX1XQlHTp05yIuE7xuY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678--MBAVieEOFO8J9OlgKn7Pg-1; Mon, 12 Feb 2024 05:00:42 -0500
X-MC-Unique: -MBAVieEOFO8J9OlgKn7Pg-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-46d6a12073aso635128137.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707732041; x=1708336841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l44duX4bruiSysv390/0MeGikPC351P53LEkSBBfAnE=;
        b=qDTbyErrTjy7PdI4Kzvh55rOX358z/eqJOJcpldm8+/W66fKH4jl4XwJm4a+N813Pq
         6ORO3FK7xcJ3NnScu836drTtNx3x7cIm82yZalL2FwP/kqnzZDbAsCbeQCI8I6ZqrWs0
         VASk7Ed40uPVyqhgfmXu/cgwApAPpWNSw59o14L9dRbKLbmwj+GNmex8MjepypBtS0ni
         Sb7omcFLxO/MpLhmsxNsJYwWK7rOLXOpqTYmG+8y4FFn/y3KOHqscJGkSJuLcSbl4sAp
         j64vwOcN93XPfu9WgHiejPFo7DdVU1AW2lO3/RaZlQYFzyAMe+SO2pfvt27uyW2FksYX
         IOcA==
X-Forwarded-Encrypted: i=1; AJvYcCXRWoOOAJkPsmgb4TwSwMcaQnRZvtNnYrxGS9NYDVcdMeGFsVnVYjr6lmlYebiQ3bYasg9TImbZN4nw6xGys8j5v5QvoCDxQ2VhdJ1E
X-Gm-Message-State: AOJu0YzYYo3k9rclCA+ISSLI63/PEo3+a9ghLUyWgaLBOEldKs8stY4V
	6jpUsALfCEopl1U8hdDoCAS5Pl4xFEDkZJe5kjwfG66duB+QOgy76CFHYb1n89JQhE8xZzt7bMR
	yizWAQZpQ+VnG83lLW/tryfp//IyhmRr5v8DlZMa/iVRJozh+YXXUgss6woaqZpU2XKkk2eMKtx
	4CqUA3VJvSRL+E5nsOn+Z2T9W5kgf9GE81Qo3D
X-Received: by 2002:a67:fdd9:0:b0:46d:162f:a77e with SMTP id l25-20020a67fdd9000000b0046d162fa77emr4229779vsq.16.1707732040099;
        Mon, 12 Feb 2024 02:00:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNS2UrbWm61NEj4QS+lNMC4rXIR1d7f9tSEY7SuWQz9LtNYOaIt21AdO+LQgIosdUlO16W/y6MTDYLoVqP5+o=
X-Received: by 2002:a67:fdd9:0:b0:46d:162f:a77e with SMTP id
 l25-20020a67fdd9000000b0046d162fa77emr4229749vsq.16.1707732039543; Mon, 12
 Feb 2024 02:00:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230172351.574091-1-michael.roth@amd.com> <20231230172351.574091-7-michael.roth@amd.com>
 <ZcKb6VGbNZHlQkzg@google.com>
In-Reply-To: <ZcKb6VGbNZHlQkzg@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Feb 2024 11:00:27 +0100
Message-ID: <CABgObfbMuU5axeCYykXitrKGgV5Zw-BB843--Gp4t_rLe2=gPw@mail.gmail.com>
Subject: Re: [PATCH v11 06/35] KVM: x86/mmu: Pass around full 64-bit error
 code for KVM page faults
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
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 9:52=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Sat, Dec 30, 2023, Michael Roth wrote:
> > In some cases the full 64-bit error code for the KVM page fault will be
> > needed to determine things like whether or not a fault was for a privat=
e
> > or shared guest page, so update related code to accept the full 64-bit
> > value so it can be plumbed all the way through to where it is needed.
> >
> > The accessors of fault->error_code are changed as follows:
> >
> > - FNAME(page_fault): change to explicitly use lower_32_bits() since tha=
t
> >                      is no longer done in kvm_mmu_page_fault()
> > - kvm_mmu_page_fault(): explicit mask with PFERR_RSVD_MASK,
> >                         PFERR_NESTED_GUEST_PAGE
> > - mmutrace: changed u32 -> u64
> >
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Link: https://lore.kernel.org/kvm/20230612042559.375660-1-michael.roth@=
amd.com/T/#mbd0b20c9a2cf50319d5d2a27b63f73c772112076
> > [mdr: drop references/changes to code not in current gmem tree, update
> >       commit message]
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>
> I assume Isaku is the original author?  If so, that's missing from this p=
atch.

The root of this patch seem to be in a reply to "KVM: x86: Add
'fault_is_private' x86 op"
(https://patchew.org/linux/20230220183847.59159-1-michael.roth@amd.com/2023=
0220183847.59159-2-michael.roth@amd.com/),
so yes.

Paolo


