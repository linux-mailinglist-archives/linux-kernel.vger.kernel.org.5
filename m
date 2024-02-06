Return-Path: <linux-kernel+bounces-55604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E1E84BEC6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FA8285B03
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B41B941;
	Tue,  6 Feb 2024 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btVILNSJ"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2701B800
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251785; cv=none; b=Duf2odKBxWJaZXHtI3k6yV0A0hrPTdz7E7qudvAUsPCB/ttVKSsaLGRSnW6cAtMxKSaEsFDWgcU650urs8T/tBNgkOgMUHphbV92/idnDcjK47PgSIVbIKHrJfunzDuQ6h+Akw+etod7ylXU3iiIoRkol+T+3AL7VsjCB1AG6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251785; c=relaxed/simple;
	bh=se8P+Bqy2T9rM626GcSkDCI8mK7oGhCqfOiPGu9wZkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=X+80P48EBedkSWxoqufz+CoWuvXL0Au0D3kLPB5WKNV55bI/9VS6SEhP6qrtMfkP+OObMfmMjkrxNKoRQDEhLjlejChAnKVo+6DRIBt+PfMmaKpDjcvjs2aYqJ1Rqy/FxfYA1Lb2SVAX/L41dw2pGUiDWwrD7vBfD51A/BkUoDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btVILNSJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ce632b2adfso6096543a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 12:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707251784; x=1707856584; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jzwz3V63szJHlExhCZvPC7c2dtOM+k/FDHvQAaa+NEw=;
        b=btVILNSJbLhDX+8sChHwWXByUoczQaX1QsEtBu3tcptnNHaUHbwI9JyOPuBddk4WP9
         7dsjrsiAMdTYpi86RAUDECKLc+qWFM7B4KIPjVkrHBTdMb6r0+VavfWfGzcpRVL5wVd5
         3MdnDCl0vmhrVvEzRYM484Pjm6zYt/Cf4aXFJIZjR+hxGuiUihCEVA8ZK5mT9nwfYoT1
         SLp1RBhTdQh9ESnG1XTfz9+Pu5gU8leL5pwo44CmUoeBaL1aiu/d32AKNeV/oop2d+gf
         zAIhJDmBGwDQmCXunyguPCnMqJUxqG6x8h0Flb+poN4+A2qPUXDVUpW9GuNWHLR25LPI
         NkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707251784; x=1707856584;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jzwz3V63szJHlExhCZvPC7c2dtOM+k/FDHvQAaa+NEw=;
        b=ISiAKUHZhRGdxdvV7HrbzdOTGHEkdE6J+UluM510s6q3CfaXpzWDxC+PdzntesHqJc
         WLlyPjpQALmqlAwRpHghgA7qlLFf951lSDO7d5CV0/cXznA/O0Zupx1UUAbRHinzzQ9N
         2/RSA1jXaS+xqbOX5JN5PJhdMXSURHMugqMm8RCwDnpTDNHIMXFsSCYjQG030w8skGWZ
         sbiJ8i8N+XzZqMxYPLkD57tCd44AeiUsJsG2vOEfZzNRBf0GYkCWKYoeYstqdq71lPzc
         s5NCqA8/fORgiqYgurpubz0yD11eOKa7/jVopLDiFmCwde/nDOZL/b1LK+zbmaZkj5xn
         YXwg==
X-Forwarded-Encrypted: i=1; AJvYcCV7PPWcC6dAhfCVzB3GNIq5GPcouNyfWd2zeAbJLxotz/AzTWFWPkPS2wiKLy5+Ynfn5hNnqUv/cJ8sr+eG4oxqUCK0wWNUW8Kyi3qf
X-Gm-Message-State: AOJu0YyAVFxHCHt4T5ePabEfm6ckXfiFfT15bV/JnBEp+PVTIuO5F/P7
	lklvFZcfE99uxX84eoZP3FRV3yKfmyFkRYxbcmMQs6BWhYjvG1PmxNISFS0Mu1hrL9eRtdpq8Sy
	LfA==
X-Google-Smtp-Source: AGHT+IE+O6nMTqNGYB/t77HMprboX4PQjl7+xgDRrny/aw5DBBLxjaHIIhAZ2fE2KVmSzCD1jBDPxM7Dmrc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:313:b0:5ca:45d0:dc1b with SMTP id
 bn19-20020a056a02031300b005ca45d0dc1bmr1646pgb.9.1707251783750; Tue, 06 Feb
 2024 12:36:23 -0800 (PST)
Date: Tue, 6 Feb 2024 12:36:22 -0800
In-Reply-To: <20240203000917.376631-11-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203000917.376631-1-seanjc@google.com> <20240203000917.376631-11-seanjc@google.com>
Message-ID: <ZcKYRsNUAngWGy2a@google.com>
Subject: Re: [PATCH v8 10/10] KVM: selftests: Add a basic SEV smoke test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Andrew Jones <andrew.jones@linux.dev>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 02, 2024, Sean Christopherson wrote:
> +int main(int argc, char *argv[])
> +{
> +	TEST_REQUIRE(is_kvm_sev_supported());

This also needs

	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));

to handle the case where the platform supports SEV, i.e. /dev/sev exists, but
KVM doesn't support SEV, e.g. if TDP is disabled, if SEV was explicitly disabled
via module param, etc.

