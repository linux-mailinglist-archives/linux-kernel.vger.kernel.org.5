Return-Path: <linux-kernel+bounces-147381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD1E8A732E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850CC28469D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B380A13699F;
	Tue, 16 Apr 2024 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qv87wSdK"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5401135418
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291924; cv=none; b=WT8fZ/saQqpGjSwlw1vBIVBX3oK9afKmruDsKrHQvZM8eqKZYkg4ttX9MDg+18SiT16DCKWRwNGYeUGeYKsLRud6VG8gwDFzWb+jp77OSUVsTmmZjuuXdfT2gb2fYU2W1q9QIThen9A/BUctsAp4G9UH3qQ+AnrRzZZc9eKe2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291924; c=relaxed/simple;
	bh=CqgJtn/U0iyjaFLsjBDLqtvJ8ikrUcQ5Qn+PGsol6rE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oNPMEBTS80psKi0+nhNlYf6TsoKK6U12/mBjIXed3fjnhZLb0vZhKjaCVOzb0iReag5WTa3TIV2TNnTrrmSDDzKGvTegx3rTPCQzJZg5MhFAeexNQCYvkEmw/11DCFpuJdakGxkZU9KEg5jx2E9kAm2NmGz9em1bxodEI+7Viq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qv87wSdK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ed33476d82so2938574b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713291922; x=1713896722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0Dy+gDviAJ2o/sam9sz8dePiRRUzN8Q+NvPrgStXcE=;
        b=Qv87wSdKfNOvj6VSclYj9cN2R9JwVoGAM+HZwoCxwQ2x7MoEUpvkxHgZAyYoXr+QjZ
         L+96q7lhnjcO/4UX7WlT/bn232RW4U7rpoVwngAS/LXkK4kLH8Nl9c38YgQY0Rp1uJBU
         vYAxavOOEedRwIwWsuXQUyrFvcpmtKuA6j38sPTOZ1QeO79AbOIWqNnZzspsS64xtr9q
         s4yfda8cJl1tuPfpdZtHZSre1LWit2cdnnllAogRKuK4CtwlsnovB+6bJVNd/49NL8L6
         h45xH7LPXvxrH/pT4jHupvQFnHNZMGYdx4qQIhGlQl+eSOWcGF8bop1Bj8FILyKWItf5
         txdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713291922; x=1713896722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0Dy+gDviAJ2o/sam9sz8dePiRRUzN8Q+NvPrgStXcE=;
        b=XDy572CZHkDFGpglTQgY1wvFTl+EVzn6UimM4EDm61sknXzu/Eh8GIIk63+EgM1bxR
         fFjAnD7lOSNTxBYanHdDyPnj8iwSVT/LmXqQw5j1aWXvapYq7vHsnnRa/FE96K4IaWt4
         LsLZy13nnCqpTcbRp4q+Ut06h/VhVth0tdTGd5DV9gQIM1eRZ12QAYzCj3DT63/hY+Ng
         Hm4LAUdyL3CiaQdbKH09xaAoGsE2cOxZyZdRj341yqKTqGlZWFwYjNG42A+wUVZysmNy
         P4IEqckrNMegs6i80Bm0EzQxO9s7r0r3H0oJtpcrddcS6tgGa85IsGDF/rLA3xBKYhxT
         XFcA==
X-Forwarded-Encrypted: i=1; AJvYcCXdk2D8PfULoU/uxkLOuaxEO6YQ8j/S4WU8eAtRpr+2irJRRhcMUbQHuQOV6T5CSZrF5THCbmm7qGoWQPn0u2D6B5yBcXNMK9kSrT8x
X-Gm-Message-State: AOJu0YywtT1AsB+CJd3N/ZnjAyKbpEVvZV/ipNLfO/MY7OEWI8GMQVlo
	ggjZ+mMhUpo5ATr6uiK8W1axvUrBc2OVHbbjwId8qma8DaHuDaQ9KfgAgL3RrmR3zs21wWy8xzs
	UCQ==
X-Google-Smtp-Source: AGHT+IEmMZLs1XVA5JJMAoDzFbN9/szK5kFwYcf+Pj3O7S7VH65wvM2tAsiEyJxMlCMnZhB+I6kUJt/hrbk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d94:b0:6ed:95ce:3417 with SMTP id
 fb20-20020a056a002d9400b006ed95ce3417mr470265pfb.5.1713291922192; Tue, 16 Apr
 2024 11:25:22 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:25:20 -0700
In-Reply-To: <b7177278-2a39-4fe6-9690-573b70e2ed0e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215160136.1256084-1-alejandro.j.jimenez@oracle.com>
 <20240215160136.1256084-3-alejandro.j.jimenez@oracle.com> <56130d48-706f-d1d0-bd23-69544298f353@oracle.com>
 <b7177278-2a39-4fe6-9690-573b70e2ed0e@oracle.com>
Message-ID: <Zh7CkBHFXES9HeIL@google.com>
Subject: Re: [RFC 2/3] x86: KVM: stats: Add stat counter for IRQs injected via APICv
From: Sean Christopherson <seanjc@google.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	linux-kernel@vger.kernel.org, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, mark.kanda@oracle.com, 
	suravee.suthikulpanit@amd.com, mlevitsk@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 15, 2024, Alejandro Jimenez wrote:
> Hi Dongli
> 
> On 2/15/24 11:16, Dongli Zhang wrote:
> > Hi Alejandro,
> > 
> > Is there any use case of this counter in the bug?
> 
> I don't have a specific bug in mind that this is trying to address.  This
> patch is just an example is to show how existing data points (i.e. the
> trace_kvm_apicv_accept_irq tracepoint) can also be exposed via the stats
> framework with minimal overhead, and to support the point in the cover letter
> that querying the binary stats could be the best choice for a "single source"
> that tells us the full status of APICv/AVIC (i.e. is SVM and IOMMU AVIC both
> working, are there any inhibits set, etc)

Yeah, but as noted in my response to the cover letter, stats are ABI, whereas
tracepoints are not, i.e. the bar for adding stats is much higher than the bar
for adding tracepoints.

In other words, stats need to come with a concrete use case (preferably more than
one), an explanation of why userspace needs a KVM-provided stat, and a decent
level of confidence that KVM can provide deterministic, sane, and broadly useful
data.

E.g. this proposed stat is of limited usefulness because it applies to a very
narrow combination of IRQs and hardware.

