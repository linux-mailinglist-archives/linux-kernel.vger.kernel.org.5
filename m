Return-Path: <linux-kernel+bounces-147350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A878A72CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E001A28474C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72646134CD4;
	Tue, 16 Apr 2024 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WfVJJAY5"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F89134418
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290890; cv=none; b=PTfwVQMoG6Kcuavo8KrgroQ8eg8xN87jtmNxyHpMPLDA+uFRt+Vmo8S5FbMlIt1OSivEnwcm8qgt2wzgG6vck0w41N2bmeednvyU/Bnqcq66pDPqdfnhohQcJL6a8A0t385I4pzdFNI1BzQ5JofciqF8KvS3G/TXgq2iATANmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290890; c=relaxed/simple;
	bh=dalzfTEYCYjGOblMe0r3aLy4BV8iHIA7aipkh8S2tvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I6uqDqJuic8QHjldRVnaYFYxqn4K4R9aAylDGIN+Y4NoCFKSqR9U2eRcerwiSGPHgi1fNhEEgAyHDM3M7QbFLZbHh/nG+snD0St8euSDsQIVeCbeD2Hsm2xn1sACsH2lHOD8zEGnHDVxrhN4Q/kO2Z30aNqWPRdS3WF8Ba/PZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WfVJJAY5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5f44b50ed93so4223895a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713290889; x=1713895689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NXFbTNmgRTmWdXHjoGcJmo7VfIOfY8bpyY2TmZpqkM=;
        b=WfVJJAY5BeeVtJ+7bFSiJECv+C5ZvLbvU36V1sqzvApW/v0rGS1pRNSv510r+rw2vV
         Ihy6Ekeg7//lj85gfyJUYyCZ/qVm8sI91V+Sw+XyrwH44ghIBdTo3nfuCyCyDo+bxQKF
         NGuoKOJdd6S+vDQ+22DggzEVmWbPdtH9l5CAk9Yo9XP8SIUyASYeN1sb/2xT76ewCkqv
         FqhtAvh3mlS+3hoou1WpD8dNXdGHMA9zKYLQL44is04vt7gZPM8x2fSyLs8iy6QmJJvD
         kg9QPWKYzwCaSC7+i/A89aMzzlYz98QgY97ees2fdx5HSzocoq5JVNjC4MIcJD1NfHpv
         uJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713290889; x=1713895689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NXFbTNmgRTmWdXHjoGcJmo7VfIOfY8bpyY2TmZpqkM=;
        b=Sn1/rGG1ptI3l/elKVttskJLqMAVM/9FTENHSTfZz5TOUf07em51r5cTy0n44l8+9v
         2h0Ua/ffQOqCZjqqp5is5YGm9ECU0bn8qT0uFzhIB9HHqzjvruobx8Y9xA1cYTj96/vh
         tNk2JnJFeQXUipAkTkuQrtkiRBBKQGM4aPIKG0KwF3Fx+LowP0rjF40RyM5Xkv2tQ/uz
         GLMreXKmRkdZQpFi61WIHiOSSiJAUFu/kVrmy30ykA0YHxOQrEc1KBl97zcVnRmKSI99
         ifaEjjkkd6Ef5U8FmycZuRs9JGnskGoInZhD/wJAOtnrVlE+rttsEM9s90Y5+hnGJT2j
         6n9w==
X-Forwarded-Encrypted: i=1; AJvYcCWQF18GaZ1EyM2OJ0aE2VZA5U36Z6kgtmem9ukib4+x4FHeS7JlQH87umyEHtZOWLC0nKYDgTjjmI57NLIhq07VCgbLIfdaeUl9rd5u
X-Gm-Message-State: AOJu0YyJCiE5F3XRkAgHAhbbGwlm9x8Z6t91I9eOn3kM0lYLppkk5bE3
	BE79RXbBhay16P/hRfB8i0eFlYysXr2Om9KlHew2h62j98KPNzr+uVlCrh3A1YsC8OOa/tSMpz2
	6sA==
X-Google-Smtp-Source: AGHT+IHMEi2dtQaCnI98nM7G0T0kqOCgAJIj2lV4Qjlm4alyJci6L5bVl6ln7u7+4Ci1dp9+rMXL0KUBeeE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:90c2:0:b0:5f7:76da:fbdb with SMTP id
 a185-20020a6390c2000000b005f776dafbdbmr671pge.8.1713290888985; Tue, 16 Apr
 2024 11:08:08 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:08:07 -0700
In-Reply-To: <20240215160136.1256084-1-alejandro.j.jimenez@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215160136.1256084-1-alejandro.j.jimenez@oracle.com>
Message-ID: <Zh6-h0lBCpYBahw7@google.com>
Subject: Re: [RFC 0/3] Export APICv-related state via binary stats interface
From: Sean Christopherson <seanjc@google.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, linux-kernel@vger.kernel.org, 
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, mark.kanda@oracle.com, 
	suravee.suthikulpanit@amd.com, mlevitsk@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 15, 2024, Alejandro Jimenez wrote:
> The goal of this RFC is to agree on a mechanism for querying the state (and
> related stats) of APICv/AVIC. I clearly have an AVIC bias when approaching this
> topic since that is the side that I have mostly looked at, and has the greater
> number of possible inhibits, but I believe the argument applies for both
> vendor's technologies.
> 
> Currently, a user or monitoring app trying to determine if APICv is actually
> being used needs implementation-specific knowlegde in order to look for specific
> types of #VMEXIT (i.e. AVIC_INCOMPLETE_IPI/AVIC_NOACCEL), checking GALog events
> by watching /proc/interrupts for AMD-Vi*-GA, etc. There are existing tracepoints
> (e.g. kvm_apicv_accept_irq, kvm_avic_ga_log) that make this task easier, but
> tracefs is not viable in some scenarios. Adding kvm debugfs entries has similar
> downsides. Suravee has previously proposed a new IOCTL interface[0] to expose
> this information, but there has not been any development in that direction.
> Sean has mentioned a preference for using BPF to extract info from the current
> tracepoints, which would require reworking existing structs to access some
> desired data, but as far as I know there isn't any work done on that approach
> yet.
> 
> Recently Joao mentioned another alternative: the binary stats framework that is
> already supported by kernel[1] and QEMU[2].

The hiccup with stats are that they are ABI, e.g. we can't (easily) ditch stats
once they're added, and KVM needs to maintain the exact behavior.

Tracepoints are explicitly not ABI, and so we can be much more permissive when it
comes to adding/expanding tracepoints, specifically because there are no guarantees
provided to userspace.

