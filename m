Return-Path: <linux-kernel+bounces-159341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAA78B2D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D3A1F21A83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55D156250;
	Thu, 25 Apr 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5vApXQj"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A484155A34
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085794; cv=none; b=MQXxSxcpnZ7zTy781FhD3gxqCH2EkGHs5N6GBhGeJIAQhH5bANmCtyHZc2g/qeEOacuS08Sh5scrqUDcGvBCivUE+/tDlVkQiuEExl78J+j2a+z6IS9ZEQ23Z+Rm3kYIvhBZgjvWGdyGizhl+Hs22JVrv/7wHCYTJOwiqQuadOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085794; c=relaxed/simple;
	bh=KYtF1y9QVO5lRyrlFu3LypLQR8DFwKeNUbD5+t8eWAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LLpbXqoujAwWBX5yL2ORNrrhckGKOlnY3oj2+fjnysMUUYiCmiXybz61NCBOnKERBSbCim/YnxRjQxzaZGLxJHFvNjvpFWbJ5F7WR4VoqnC9OrPBIYv61SpahskZE3xJfdttN5a7vhgg1uPZJjLw9HZKvguNQ+NFjFhfMut2fws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5vApXQj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b76ab0b46so26496157b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714085790; x=1714690590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkB0Oe3ETNpX0Q3btEZQH9RDe4KISQYsNCkxgD0xRNI=;
        b=t5vApXQj+HlsAVwouSNLkjD55s92sAE0x9Hx/6jIOoG7BURTbLdTbFKkVUSm4X/Wr6
         7GcwrOVdagftITNEQO7s9IWVtBSc9pigDktf4TIay8KKPK9tkJLuWtiAeVsNXAqJ4KMd
         yz+QoLXGsELnta+HaJZ6DzvNkDMVENKFx9i4yBghUyToYUZQoN6KbI4IeN4hk5LstTHW
         f3pqZAep21f8Agz+Hr1rQ/jlwJ4KXcCZey9ZCNgmZL/61munn9Hx+BZokU0TxHqRqM6V
         /zL+Vgqn6aTRrQ7L6Lg0soQTvqVKxNBEt6TsUqbCv4aEFpB0TogbFp2l40uw0D59LIoc
         SIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714085790; x=1714690590;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kkB0Oe3ETNpX0Q3btEZQH9RDe4KISQYsNCkxgD0xRNI=;
        b=VsfsMMQmXzBPmN8cer5g0NFhU7ewUSg5cddYBk0ChLU9F1bpYWpQYl/oB3hsWNF22d
         J0pbYndzUhFUvGVH7BU4r0FViYoum0P+ftlWczMxPQwZh7KYmyX+C5hrLkLrduTOAaB8
         fefUhiWJEfNBgZ7JaRqVYcubMJdxX0/3RtkFCwvU7mF/AMsLL0PZtTdkIFBzO+sMR9CE
         0+oPEt6c8POf9MvcZ24OOWIJYgqZTz3vMfN4R10WImlkRkNTMphctfspFfvgYttXo/AS
         apm/eUde0jRPTcyUOTvftjNGKXWiR284yFonHRvOVAvY9BsPeycbSaPu5gw+DuqnfmoW
         GYFA==
X-Forwarded-Encrypted: i=1; AJvYcCWKKEiIDsDi5oCYcv3pg5f5oPTSGg1Wbm/uVNmt/bIe5G0WFpgfmU0MgBlZTxGD+r3JMbe5PwvU1/W2NLLL3WyCxOOknhFw5UPsoAMw
X-Gm-Message-State: AOJu0Yz3SnqTqyJOtvJFVQ2dCiQu+F+K74dUA/rYo2KiHvvFRDdZlndY
	YzR0XpV31ff/aeI5BQaT4FeFnY7Mgt2zhmWyvYX2CAIKVoxrQq6sY5XOOoQYpQ6esv+Vy+zhZ9C
	cFw==
X-Google-Smtp-Source: AGHT+IFK9QispM2ICO/aS/Bc4lsJTNQ0CRIQjWqhFAfzup1zpNtFb4vtBZLcBygyOTGdpJexadd4ZWJU6fQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:15:b0:61a:b2d4:a3fb with SMTP id
 bc21-20020a05690c001500b0061ab2d4a3fbmr220432ywb.8.1714085790530; Thu, 25 Apr
 2024 15:56:30 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:56:28 -0700
In-Reply-To: <4195a811-7084-42fe-ad10-27d898fb3196@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240412084056.1733704-1-steven.price@arm.com>
 <20240412084309.1733783-1-steven.price@arm.com> <20240412084309.1733783-2-steven.price@arm.com>
 <CA+EHjTwDaP6qULmjEGH=Eye=vjFikr9iJHEyzzX+cr_sH57vcA@mail.gmail.com> <4195a811-7084-42fe-ad10-27d898fb3196@arm.com>
Message-ID: <ZirfnPFPo1cMwFQc@google.com>
Subject: Re: [PATCH v2 01/43] KVM: Prepare for handling only shared mappings
 in mmu_notifier events
From: Sean Christopherson <seanjc@google.com>
To: Steven Price <steven.price@arm.com>
Cc: Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024, Steven Price wrote:
> On 25/04/2024 10:48, Fuad Tabba wrote:
> > On Fri, Apr 12, 2024 at 9:43=E2=80=AFAM Steven Price <steven.price@arm.=
com> wrote:
> >>  bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range=
);
> >> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> >> index fb49c2a60200..3486ceef6f4e 100644
> >> --- a/virt/kvm/kvm_main.c
> >> +++ b/virt/kvm/kvm_main.c
> >> @@ -633,6 +633,13 @@ static __always_inline kvm_mn_ret_t __kvm_handle_=
hva_range(struct kvm *kvm,
> >>                          * the second or later invocation of the handl=
er).
> >>                          */
> >>                         gfn_range.arg =3D range->arg;
> >> +
> >> +                       /*
> >> +                        * HVA-based notifications aren't relevant to =
private
> >> +                        * mappings as they don't have a userspace map=
ping.
> >> +                        */
> >> +                       gfn_range.only_private =3D false;
> >> +                       gfn_range.only_shared =3D true;
> >>                         gfn_range.may_block =3D range->may_block;
> >=20
> > I'd discussed this with Sean when he posted this earlier. Having two
> > booleans to encode three valid states could be confusing. In response,
> > Sean suggested using an enum instead:
> > https://lore.kernel.org/all/ZUO1Giju0GkUdF0o@google.com/
>=20
> That would work fine too! Unless I've missed it Sean hasn't posted an
> updated patch. My assumption is that this will get merged (in whatever
> form) before the rest of the series as part of that other series. It
> shouldn't be too hard to adapt.

Yeah, there's no updated patch.

Fuad, if you have a strong preference, I recommend chiming in on the TDX se=
ries[*],
as that is the series that's likely going to be the first user, and I don't=
 have
a strong preference on bools versus an enum.

[*] https://lore.kernel.org/all/e324ff5e47e07505648c0092a5370ac9ddd72f0b.17=
08933498.git.isaku.yamahata@intel.com

