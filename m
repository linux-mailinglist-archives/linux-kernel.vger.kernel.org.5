Return-Path: <linux-kernel+bounces-102455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501D887B25A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B6328385F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438953375;
	Wed, 13 Mar 2024 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYFMEeNn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC444CB57
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359704; cv=none; b=vAVxiEe50ubUPQbpb9xabeh94u07I3hhy4IGjoZ9Ypl/FAKeSwESnhS64xcf+lKg0A9p21j4WX+QPlJy6JQjJ6F0NB13PfArnJqQUva+89N8hFOnsfk23zemORoC2mfvvS/NONbHXldjIEGoERWmUOVsVYlGgBotpECWTg13/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359704; c=relaxed/simple;
	bh=vwMk2apG5ic5Dd6Bp36ZNc/3RMBxC6ECiqzJaBRCdhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tnm5fo5gd/5bSU6WN1OeCDxYcMiQ25ozTSmng+u5aYE/MTjMYp1sbdzWkfi2a7PaaCX0plsbbWeo6KNR3lwXPXlTTiaDW2Ghi1A/t9i5ylytqL72mK/tc8AZTapDef4Vc7Zsrjd58bSfq5OJurXmS8QWVxy+LOdtq1EGoJO0MKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYFMEeNn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dd819f975aso2215425ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710359702; x=1710964502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5HqJNUmqWMTgd98T3K79c/2t73g8s0wifafUW041cE=;
        b=UYFMEeNnWADOJkURAUDkXG+5Gvi7MR8K7ewfF7AwuO9xtrThDH0lVUYE0uJcQhueji
         ceoSF77cnY2KX9Zhr65VN2nPCFzzxciHayFARVHmzlNP2oqDZh+7qIxgvRXOcnQoohdU
         K9NcbNZVltIAe5Rag42SnOPw+NwL/c0Mp3eKThBr32oFIfEVBu7hNdwlYqQIKwAUk5HZ
         7xHAv6ND6KXNzluBjSfyu+ffwZJ693fzdIIwJlBW5DLlQwR/9kvNPG2FPi4H/NaJCBwz
         TPUjiqqBxD44wU0fse9+P53jqnMa3Wlq7fzhbGmpwikfetgFb0svVAF7L0Dzz3RXm0NY
         bjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359702; x=1710964502;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X5HqJNUmqWMTgd98T3K79c/2t73g8s0wifafUW041cE=;
        b=GtXdJJ9KEtsv72q3KNn4i97UvX1UynUqR8ZHAY7K9IDbK2OK1arJ1MR9NqFiAYuF6t
         DHpOXq0KLtW2oAoxEB90ZDfnL02ekYubNuYEzfcUk7Ch5pT9vN5gg7Jwiwez+FbOPtpn
         qUsoX/he4CcNZDy4rpGxgChA1nHz3VbmCwCcVG+3ZkcUiajV1OwuGcQb7uG6HxQHkji+
         /CMAerR969gzTeACobjijQycYpbr2AjtL17LgI2i1aBZ10cd+v+BG3RHIy0Etw6deKqD
         rd2w/ym15OPk6SlV6gojywrEl9rw351JRX95D7CezvpPRRqZ+ZxFmifDvpFxu7G9PTKZ
         I8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXWiKddGtzn4aOZK7TL+o81PF3v3jDOVxow+dz/LGtB3orTRe93zdU5Lo39aOPKkLtRZ6UcOhH8mKvqxUR5zMV16qAcRz5vUB8P7P9k
X-Gm-Message-State: AOJu0Yy4YXMxM9gJwiswNOeoiqOOihsw6l4g1ScDU2GFZrAH3D5OXSJC
	muIrKRjDijQrrBmISaAOUPvanlWjscasaVJ1leQ44YaTtKProTT1Fx+EIyKYQ9QIsSILVelweOb
	jgA==
X-Google-Smtp-Source: AGHT+IHUHVkmqRnQeBMmogabzemFDsqB/jox8KnYjWk9nf000LMrWRlCQ63yDDEj2c/RUWA9ZfmpslZpxLk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:db04:b0:1dd:8cfc:c7ee with SMTP id
 m4-20020a170902db0400b001dd8cfcc7eemr249385plx.11.1710359701731; Wed, 13 Mar
 2024 12:55:01 -0700 (PDT)
Date: Wed, 13 Mar 2024 12:55:00 -0700
In-Reply-To: <20240312173334.2484335-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240312173334.2484335-1-rick.p.edgecombe@intel.com>
Message-ID: <ZfIElEiqYxfq2Gz4@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: x86: Don't overflow lpage_info when
 checking attributes
From: Sean Christopherson <seanjc@google.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, hao.p.peng@linux.intel.com, isaku.yamahata@intel.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024, Rick Edgecombe wrote:
> Fix KVM_SET_MEMORY_ATTRIBUTES to not overflow lpage_info array and trigge=
r
> KASAN splat, as seen in the private_mem_conversions_test selftest.

Ugh, that's embarrassing.

> The issue can be observed simply by compiling the kernel with
> CONFIG_KASAN_VMALLOC and running the selftest =E2=80=9Cprivate_mem_conver=
sions_test=E2=80=9D,

Ah, less emabarrasing, as KASAN_VMALLOC isn't auto-selected by KASAN=3Dy.

> It is a little ambiguous whether the unaligned tail page should be

Nit, it's the head page, not the tail page.  Strictly speaking, it's probab=
ly both
(or neither, if you're a half glass empty person), but the buggy code that =
is
processing regions is specifically dealing with what it calls the head page=
.

> expected to have KVM_LPAGE_MIXED_FLAG set. It is not functionally
> required, as the unaligned tail pages will already have their
> kvm_lpage_info count incremented. The comments imply not setting it on
> unaligned head pages is intentional, so fix the callers to skip trying to
> set KVM_LPAGE_MIXED_FLAG in this case, and in doing so not call
> hugepage_has_attrs().

> Also rename hugepage_has_attrs() to __slot_hugepage_has_attrs() because i=
t
> is a delicate function that should not be widely used, and only is valid
> for ranges covered by the passed slot.

Eh, I vote to drop the rename.  It's (a) a local static, (b) guarded by
CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES=3Dy, (c) pretty obvious from the @slot
param that it works on a single slot, (d) the double underscores suggests
there is an outer wrapper with the same name, which there is not, and (e) t=
he
rename adds noise to a diff that's destined for stable@.

Other than the rename, code looks good.

Thanks!

