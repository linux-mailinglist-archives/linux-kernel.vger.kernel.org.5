Return-Path: <linux-kernel+bounces-93172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF77872BD0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A349B224F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479706FBD;
	Wed,  6 Mar 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0euno7dS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86E1870
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685542; cv=none; b=IVP4YQFc46FJ/UuuhD9ywKIaP+V8us9zQMust6TYaZmxwZW3lcwheQhNYw9dGttqQck7Ho1TZhq8Da4LWsGTTyCx7oXXf2NPZPVisJDxWMRGn9QoXCRNNjmRC6AL7BY3MUL9Nc59CJcqF20d6BwCQf6h8Fle0v28ba8isoOy01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685542; c=relaxed/simple;
	bh=19srNkeRmKulCVt7yRP8P5lYwBwZ5dAunV44wgovb7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fo7fCQrEeGV5fuOpiD+/rX6SfdH2lir9d32SmNkekbKWNhMux1ig9tEBByo6LB8j2A4F37D9rR5PPbnIKS5dlxVC5juRZlmDpm/Uob1qFeQVrD0+OQgMYjmfeTauqLTRVL54MD17uBf9yQ+Bl1NFU0axNezp5f8pSiPm27hRHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0euno7dS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so11587011276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709685540; x=1710290340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/i3rfw64O52qXGZ4d4T6bC7gn+jBl0OoygyLhiTiv84=;
        b=0euno7dS8aC+u17jPskbyw25I+CmThVyNw//SFdM8p0duoJBxvxZmstx0FB3sGNdd5
         AmpKmqx+ECNlPIyI33oEcJKjWN4v3a3F9I3LIscKFXtS3LEOvggtRWrP/Sx8QeyZ7nK2
         hCnHuo46js8srw01wQiVSKMQl5kP/DXQPgM8WdVgjq25NuVVRv3yzLfzAOH7VZDagA9P
         Nciym+UUNNRAl2nRpZH+4PLkM1vHaIlMaZCTgOJuGar1CU7CAeSPdLGGSqcB6lGUVeug
         wKX7S1uml7E0q6DVf3/7lQxNtvNSlubas+1KlYRO9ziLUVG107V5pCgHeTOzYZ8ap9IR
         Yp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709685540; x=1710290340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/i3rfw64O52qXGZ4d4T6bC7gn+jBl0OoygyLhiTiv84=;
        b=BlwcgHfeF5mdXkHjb359t/jXOEY0lQfpWYW3p4O2neTgSyZgBs/TUqj4o62fCdvjUY
         KJjWUt7wMfLdOL29szONmVwzzXjNQtI3qMP2oVIVpUvQL428pq7yaDrO1269XXVZBgAI
         eoHB21kWkise6o286up5tXX0h7eqD98o+qN1zPLpO2/jvzfnaI63gAakkf2UW/JrNjFX
         mPvbQlhlNxgsnM/rb2V1Sp8MORToRrMcNVE+H0wdckxtDtc09XGeT9DZHxLVfDQv4sBM
         14on0B60rZcwXamRv+9L8gIHxrYRhWfL8kLaHORs9YZGKGKZRSZfL0zBjLI0162JCNac
         WRLg==
X-Forwarded-Encrypted: i=1; AJvYcCVft0nNmha3hqikazHMjj31p3im2ClpfCFv8qr9RIWHDJKir3gcLx6v8QD4UVq7Zpt53L8q+doWpaOfZNPA5ASzOJt2GC6TiZUvg7IU
X-Gm-Message-State: AOJu0Ywuo29my2UVYa8PM2htGZHJVNiflmc08kJWgb+lIt29IA+DoZ2H
	wqlv9HdIkfswlCycfYi98MB+1GoFnDHKdneJ+KyJVpETIZqTlZtbz+IfdSMye1C/M/hooU6kVDu
	KsA==
X-Google-Smtp-Source: AGHT+IFjhgqkeSA0IBuHXaVbpAtmbjXg8WehUV6+fYD7o5Lypw9IdoQz2wGD2lYjE7lDaFO7denBlZbiDQI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:dc47:0:b0:dcd:25be:aefb with SMTP id
 y68-20020a25dc47000000b00dcd25beaefbmr3445801ybe.13.1709685540197; Tue, 05
 Mar 2024 16:39:00 -0800 (PST)
Date: Tue, 5 Mar 2024 16:38:58 -0800
In-Reply-To: <adbcdeaa-a780-49cb-823c-3980a4dfea12@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-10-seanjc@google.com>
 <adbcdeaa-a780-49cb-823c-3980a4dfea12@intel.com>
Message-ID: <Zee7IhqAU_UZFToW@google.com>
Subject: Re: [PATCH 09/16] KVM: x86/mmu: Move private vs. shared check above
 slot validity checks
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 06, 2024, Kai Huang wrote:
> 
> 
> On 28/02/2024 3:41 pm, Sean Christopherson wrote:
> > Prioritize private vs. shared gfn attribute checks above slot validity
> > checks to ensure a consistent userspace ABI.  E.g. as is, KVM will exit to
> > userspace if there is no memslot, but emulate accesses to the APIC access
> > page even if the attributes mismatch.
> 
> IMHO, it would be helpful to explicitly say that, in the later case (emulate
> APIC access page) we still want to report MEMORY_FAULT error first (so that
> userspace can have chance to fixup, IIUC) instead of emulating directly,
> which will unlikely work.

Hmm, it's not so much that emulating directly won't work, it's that KVM would be
violating its ABI.  Emulating APIC accesses after userspace converted the APIC
gfn to private would still work (I think), but KVM's ABI is that emulated MMIO
is shared-only.

FWIW, I doubt there's a legitmate use case for converting the APIC gfn to private,
this is purely to ensure KVM has simple, consistent rules for how private vs.
shared access work.

