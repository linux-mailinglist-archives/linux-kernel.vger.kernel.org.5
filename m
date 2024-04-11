Return-Path: <linux-kernel+bounces-140651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AF58A1730
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0221F224FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4470814E2C8;
	Thu, 11 Apr 2024 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkmyBtAA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F4149C7F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845762; cv=none; b=bmh1z+ZcDGzJHdTQycjj3aqwLcTeykABNVvD+qBS28ViXiw0nUP1HUGxSfsl3mWGOJep4LLqMvq5AvRbZbC1qwCPnnnuXDXR1Ux1Rwfo1NmeRCYKS3DG8xSYW3QTHsf9XwarZBHGVaDQ0S0pbemz7LNnv4u6HtLSkCoCnmT/KZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845762; c=relaxed/simple;
	bh=x55n7vjcJdyUEJvdibwMdhPTKR2vStUWN+qbo2qhmPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B0H3Qj9rFVPIKlLY94OsCoEHSNJAFEA9TIq/UUSzs71XUvQGJegTxOwH+PNih4+RYKLTLGITXNAWtSuTBlGesmH1DqolNbfWsr0qTWxguUCs6cqTySzuke7KSbTMLO4NHNE1YVEs+GY18cjkWty8zODDyyh6hhOA9OBX6r8zIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkmyBtAA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-618409ab1acso33856857b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712845760; x=1713450560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJmBDRYpQVGPOAzl5ekp5wY5VwMrYDSR6T3I1ZkBMGQ=;
        b=XkmyBtAA8EpBmm+9OvRViVeUTxXfp4nvIO8R9LyJI/Cekzc3LugzLTtB99kccghg0O
         7U3RbVkhKSa+auAF/IKNRAR+zwOymGXbzRrIl/e6xkBg7Uc4LVlWAb8s6C/EJ+wZqs80
         EaTXyT+kwSDEu69Ocywc4c368oidUVuH4TLK5Kd19hDHn/bXgbrcMcFdJytnH6cN397F
         R3YGk6PUEepZi6o1NQa8IAQeaktGNQHsYTs19yP/BHGl3WprwEdXlUkJk8/bkbOhgMXw
         y/Xw9skFR1zEiI9qJFOJ2l/jSxi/56ZLddclFgGa5juLHDcKAGoMvnYtAS+OJvXQrn1y
         N2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712845760; x=1713450560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJmBDRYpQVGPOAzl5ekp5wY5VwMrYDSR6T3I1ZkBMGQ=;
        b=pdQ4s4Y69/BtSfNCTx4wwYse3AHy9aKhCQOno4ReLIk2ZL0yAV12R0I5+rrcXToJdt
         LJ7b9WMHqd6xkTBtgA3O9yKwT5pg/+VpSjkC+NmeUhfUVhFQEX1TC0O7q4WqUlZa/zCi
         vtJ+1WhwYqEp/TpPTPYWKSmHC/MHiFq4EbOTeCj0Kthgk5Ms2r9nNY4WipKDEsFRq8sY
         QZC0o/0BKD5fxFuQHdkllOQHSPrFjUAa6wNpJyjly7vqHFYPTNC0L5cw37S1CPoPMcrE
         qCqLfOvDM+USkDw7DfrRAchC7n5w1rYM6saSFU1XZFmpokZkJS/rlUuz1Ik5K6uNZRyW
         Pabg==
X-Forwarded-Encrypted: i=1; AJvYcCWNmvDSHMfoIaFyYSM1RM8A7aG3YNtGe119GiITixE5BIkmLkb6D3adRC6zQLgbR1NjXbgJf+TCCNIqQV9dQt04ogcp/jdtMz3lKhlh
X-Gm-Message-State: AOJu0Yw3Y1Q0H3CrVGg3EySXuPQz1g6i95xvKKcZtfPohXXf1j4XuugU
	bv9m6V6W2dWBe7WOj0BxBujGeMOjIUwe32Ibi2E5bwTiWASeD6UrKU0IERBniQHmywP1tgNG5BJ
	pFw==
X-Google-Smtp-Source: AGHT+IEIlYqEEmBQwCGGP2djaxsmLGQ9AIy2rj86gl23EnoORoi0F6hP0gykyv+CPONGJK2SNRim0rIPpg0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:b94:b0:618:4a14:54b8 with SMTP id
 ck20-20020a05690c0b9400b006184a1454b8mr1183076ywb.1.1712845760361; Thu, 11
 Apr 2024 07:29:20 -0700 (PDT)
Date: Thu, 11 Apr 2024 07:29:18 -0700
In-Reply-To: <20240411104822.6429-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240411104822.6429-1-xry111@xry111.site>
Message-ID: <Zhfzvv6_ZENQ1_7Z@google.com>
Subject: Re: [PATCH v6] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode or the kernel is running in a hypervisor
From: Sean Christopherson <seanjc@google.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Michael Kelley <mhklinux@outlook.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 11, 2024, Xi Ruoyao wrote:
> Per the "Processor Specification Update" documentations referred by the
> intel-microcode-20240312 release note, this microcode release has fixed
> the issue for all affected models.
> 
> So don't disable INVLPG if the microcode is new enough.  The precise
> minimum microcode revision fixing the issue is provided by engineer from
> Intel.
> 
> And the erratum says:
> 
>     This erratum does not apply in VMX non-root operation. It applies
>     only when PCIDs are enabled and either in VMX root operation or
>     outside VMX operation.
> 
> So if the kernel is running in a hypervisor, we are in VMX non-root
> operation and we should be safe.

This should be two separate patches, one to do the precise ucode update check,
and one to keep PCID enabled for guests.

