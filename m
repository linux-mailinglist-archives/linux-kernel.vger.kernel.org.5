Return-Path: <linux-kernel+bounces-101654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD287A9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059EEB23855
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B73E46430;
	Wed, 13 Mar 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWpXRcR+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B344C89
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342116; cv=none; b=aIA5wA4osnBZBEtsDBCnjOMo15f25MAtObsHl3N3d8Pl+hvoRUWLvH7WBXkHKDpONa+/LNfR/5sQziEtZuFBwXcCyv0N18BgU+unA/vtFGE6K9g6/kfkdQjikutPljAG87Sqy4QIbNIHNpewdcBJZ/nxScspq1OccYblG+4JWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342116; c=relaxed/simple;
	bh=BhNCnyoTesqFmuls5ivViDYlow0aTT/P/P0basWLPJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF6aEBLwekpoZzmrsRsbWFiV2jbDWaxEVbJoftEZEcWqfDGF5rVPAk5HZUn13Bx9ORHGrE1JKrJqMCaXQSxiy7NUEjJXbzgM5IO3W07s35a7tU2SsKDAyB9jwKHUseweyi2bVFtz4AbvkRKOKaHeKadufJEup2DqWp+X2ShUX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWpXRcR+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710342114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/9033pqa13lPK0uOMJ5/UDPzpYtNbRiAHnnfFJUj+Y=;
	b=XWpXRcR+9BZVmE17yJza0IV9vi6OLjieC3lZX7W6oU0lGlljyH+0yDN1xNJ7os05T3VpLz
	pBcOSoGoocqHAgOxWd8Fn9LAzcQ6e8ySdhs6p2xn8Ig23LzE8Yqj5GlbYxc6YlhXJimPhD
	2OzUU6cwaazgE/yTDYH8BEuyqMhKdFg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-VCWrV8IyPD2kFbltAsmg9Q-1; Wed, 13 Mar 2024 11:01:49 -0400
X-MC-Unique: VCWrV8IyPD2kFbltAsmg9Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e6d36db5dso650591f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342107; x=1710946907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/9033pqa13lPK0uOMJ5/UDPzpYtNbRiAHnnfFJUj+Y=;
        b=cXwXWMyZgS6WisiWJ6jcuti5X14PCBzv9F5PMDo5dCPiRbcb0wCsKsCdDPjGX4ck3o
         FSCnJjOE/5+vgLv1i9zeN7xL9VPtyp6vunO87inoWRRjgC76PZeb5iuKnRZ7Aw5+60UE
         Z49NYZAn2K3fFYxywCJTq76QFSgpBkWKYjZN/KUY/QIugPqvrGMEWrv3QGIaS/2grsZN
         i59sStydVp/GWoBzAVfFsFOHTYayU0aCe64BEvUHBFxz0dHmTNBtADpLWS2SEr8iV3Pb
         Ict0k6uN9xNT1Tr9cLif2ZacgPYaOaDuR0FIO5xhqHfK1M17rH6Qppkenu8cEC5jK49K
         /Ngg==
X-Forwarded-Encrypted: i=1; AJvYcCXfbImZ7s3roJWJypPrzcRrps9HEz6OXM2KB9umKL3zmPSP74cNivXnyJmYuCIjmaOiacHA5abCzOqLgDeJgdIcRB69jO98NU7d8Iqq
X-Gm-Message-State: AOJu0Yy7WX7omXd99F9kH5DIcxJpfi1WEBnNGVo+E2stlXDYZZEaYvYP
	YLMPyhd7+1Ga+EJTZKqW0Zctg5jIo6BvUp/D4q8nL8MqfzasXY2hS2+KEMPWNZU4aOvUC3hlEb3
	DS0JkfDwYsKjNRec6LxA0eTJogkICoSLlL7iEZ/Mhw5Q1MVacYn/3Q9LG7Cg0Wmt/WuECVgrV2R
	PF6p8/RCmmEF0gIAdd3wwnFFBD1UJWPhsjaItK
X-Received: by 2002:adf:f549:0:b0:33e:8b95:b351 with SMTP id j9-20020adff549000000b0033e8b95b351mr1835664wrp.9.1710342107676;
        Wed, 13 Mar 2024 08:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXNDFO30abwoBORNfBCrv9tG6NnsBZaqMWC9sIknwfHHO03Tt2/WreaRj4i/D+RMnScfjJFx/ABZsxCaZHcLs=
X-Received: by 2002:adf:f549:0:b0:33e:8b95:b351 with SMTP id
 j9-20020adff549000000b0033e8b95b351mr1835644wrp.9.1710342107333; Wed, 13 Mar
 2024 08:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313003739.3365845-1-mizhang@google.com> <DS0PR11MB63731F54EA26D14CF7D6A3FDDC2A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZfG7SgyqTTtqF3cw@google.com>
In-Reply-To: <ZfG7SgyqTTtqF3cw@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Mar 2024 16:01:34 +0100
Message-ID: <CABgObfYfAS2DBaW71iUcQgua7K3VY4nz8krGYGxyBt1+7i193A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: Return correct value of IA32_PERF_CAPABILITIES
 for userspace after vCPU has run
To: Sean Christopherson <seanjc@google.com>
Cc: Wei W Wang <wei.w.wang@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aaron Lewis <aaronlewis@google.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 3:42=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> We discussed this whole MSRs mess at PUCK this morning.  I forgot to hit =
RECORD,
> but Paolo took notes and will post them soon.
>
> Going from memory, the plan is to:
>
>   1. Commit to, and document, that userspace must do KVM_SET_CPUID{,2} pr=
ior to
>      KVM_SET_MSRS.

Correct.

>   2. Go with roughly what I proposed in the CET thread (for unsupported M=
SRS,
>      read 0 and drop writes of '0')[*].

More precisely, read a sensible default value corresponding to
"everything disabled", which generally speaking should be 0. And
generally speaking, commit to:
- allowing host_initiated reads independent of CPUID
- allowing host_initiated writes of the same value that was read
- blocking host_initiated writes of nonzero (or nondefault) values if
the corresponding guest CPUID bit is clear

Right now some MSRs do not allow host initiated writes, for example
MSR_KVM_* (check for calls to guest_pv_has), and the VMX MSRs.

Generally speaking we want to fix them, unless it's an unholy pain
(for example the VMX capabilities MSRs are good candidates for pain,
because they have some "must be 1" bits in bits 63:32).

All this should be covered by selftests.

>   3. Add a quire for PERF_CAPABILITIES, ARCH_CAPABILITIES, and PLATFORM_I=
NFO
>      (if quirk=3D=3Denabled, keep KVM's current behavior; if quirk=3D=3Dd=
isabled, zero-
>       initialize the MSRs).

More precisely, even if quirk=3D=3Denabled we will move the setting of a
non-zero default value for the MSR from vCPU creation to
KVM_SET_CPUID2, and only set a non-zero default value if the CPUID bit
is set.

Another small thing in my notes was to look at the duplication between
emulated_msrs and msr_based_features_all_except_vmx. Right now
MSR_AMD64_DE_CFG is the only one that is not in both and, probably not
a coincidence, it's also the only one implemented only for one vendor.
There's probably some opportunity for both cleanups and fixes. It
looks like svm_has_emulated_msr(MSR_AMD64_DE_CFG) should return true
for example.

Paolo

> With those pieces in place, KVM can simply check X86_FEATURE_PDCM for bot=
h reads
> and writes to PERF_CAPABILITIES, and the common userspace MSR handling wi=
ll
> convert "unsupported" to "success" as appropriate.
>
> [*] https://lore.kernel.org/all/ZfDdS8rtVtyEr0UR@google.com


