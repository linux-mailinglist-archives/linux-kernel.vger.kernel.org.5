Return-Path: <linux-kernel+bounces-157353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C948B1044
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C97228392C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140E716C87C;
	Wed, 24 Apr 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRsdDjEX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA216C450
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977534; cv=none; b=Qap/FFEZYg21KNzYgtBI/CoQNPPhfbbI6ZX1UJOUVgsKASHitRCY1GD6yQe0R+6sinAU7SAHTGXpQvFAWvCt84aE9LIW0jVfuAaEPrt9B5Uep2cSrCxiINe54XVCY36+lLZ7E5KrTfmz0CvHTgbAd0+UK4BAcOEnPLWC0/ZU2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977534; c=relaxed/simple;
	bh=amFktTsYZhx0I8VQucVLkG8QNDwrrrdIfd3JgGF66lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBjown+WhCbUpugqRCCYxF49ZQ5TGtMFpXhn9iEzbtW5hxcEvB4E1jSYI5T6vy8Gt0AgynOUmbd3UZ+7uxsiO6xAl0kq2SMmOw4RCvAlNaN7h5+ySnbLdtkJaCnuplxUEPcWNlubPt453vnN4bvcs9OgdQ4keA6TT0AGW56UX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRsdDjEX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713977531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=id9ycaUBE8n/nnS15W/vGnLyEDK1wrwv0iZjSLUyk1Y=;
	b=jRsdDjEX0jnm7eZRpDe1+bklHVIpYP73FBP1gbmC6OS9vjsYTTpDiHoMG5eihXXeLvcPkV
	jIExAl0WmKXaoPDxKyHQtZs2DY2JGNkcBQodGXluB5ceNFEwJvlhKvLgVWa5R8rOEcSt3G
	IaRt8kVT0H9GJyE6kpslXCcpGK1914U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-MO4qjSSVM_-0No0FTcS1Yg-1; Wed, 24 Apr 2024 12:52:10 -0400
X-MC-Unique: MO4qjSSVM_-0No0FTcS1Yg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-349c63ea688so11733f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713977529; x=1714582329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=id9ycaUBE8n/nnS15W/vGnLyEDK1wrwv0iZjSLUyk1Y=;
        b=iezukfr1bdiM+njOWjC2Xeim8r6sbp1lYEYR/y8E8GEM5bgtm3yY414cUfsRma8gty
         eBhmA1hX3RLFWfpKunwPkXRlH5Ck+Iaev1PBtQQhPsVBEOjHpsBAvwqGjEHrYHMAv+Xp
         8WXscBoWvXH0Ng6lplBnfBrw1fJDeM8nFvEausFPXWvfAAW6ll51l26G4bK2+goCbyAV
         ksKlN4xi4AUUd99lDOyS6qGKGsEsk7cfDtx1xCa7FnN6x0mddKbXFri8HftbTlZQLhX0
         ayZrb58Kb+yQf/DQZ893CP3ENj/7NdiYiUp+RozMpiFqOvdnUfpVsp2c4Bw3JqIYNqyB
         hI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpbMInTqz1mYJKznxT+0zoLAb849EDv+FDL5aGews01KhKTsh9ZBwaN2T4vFbyNqzapcCJ2JaFfIYmq15ltOY5WHBeymXlRwEf2i6R
X-Gm-Message-State: AOJu0YzQ0ptQkzWafuY4Vx+ETuevYejOuO+BlTzownFpVluf7+67dhF+
	Pxk7BIC9m1+kTLWYcC0R3pLFDfBUGIx68ILckJ9pYxKm4VNlyqC5+WV0TBqw/2x7GtnI7r7Kjcb
	0D2Sny+cS4cYPwNrksMH8Dev5VERilNlG/jwyxeAhgzxumjMZbbWK8TyVC0b6tMYZ8OypEfoicd
	GExXmXwGLp+gPmkRJfo80y+A1Rep5Nv9J+xfyc
X-Received: by 2002:adf:a2d5:0:b0:34a:ef9b:b6d3 with SMTP id t21-20020adfa2d5000000b0034aef9bb6d3mr1894632wra.33.1713977529032;
        Wed, 24 Apr 2024 09:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR+Q8XeU6R6xECmEQz4NqbdTNaO1G1EnGJfcOAEAL7aKaYxgGlsEHUag2BDkifl8iK/Ykj8pEtfMPkXRl3N6s=
X-Received: by 2002:adf:a2d5:0:b0:34a:ef9b:b6d3 with SMTP id
 t21-20020adfa2d5000000b0034aef9bb6d3mr1894619wra.33.1713977528725; Wed, 24
 Apr 2024 09:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421180122.1650812-1-michael.roth@amd.com> <171388991368.1780702.14461882076074410508@amd.com>
In-Reply-To: <171388991368.1780702.14461882076074410508@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 24 Apr 2024 18:51:56 +0200
Message-ID: <CABgObfa6vD+DQdmZoq0RYjwQqsYxsCvTS+vvANp5OXXOwS+PPw@mail.gmail.com>
Subject: Re: [PATCH v14 00/22] Add AMD Secure Nested Paging (SEV-SNP)
 Hypervisor Support
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de, 
	thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, seanjc@google.com, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 6:32=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> I just sent an additional set of fixups, patches 23-29. These add some
> additional input validation on GHCB requests, mainly ensuring that
> SNP-specific requests from non-SNP guests result in an error as soon as
> they are received rather than reaching an error state indirectly further
> into the call stack.
>
> It's a small diff (included below), but a bit of a pain to squash in
> patch by patch due to close proximity with each other, so I've pushed an
> updated branch here that already has them squashed in:
>
>   https://github.com/amdese/linux/commits/snp-host-v14b

Thanks, I pushed that to kvm-coco-queue. There was a missing signoff -
I just added it since you actually added it in the past[1] and the
patch only differs in context.

Now off to getting those mm acks.

Paolo

[1] https://patchew.org/linux/20231230172351.574091-1-michael.roth@amd.com/=
20231230172351.574091-33-michael.roth@amd.com/


