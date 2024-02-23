Return-Path: <linux-kernel+bounces-77640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB2586085C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F64D285B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AAFC8E0;
	Fri, 23 Feb 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osxwkRAB"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8E12E54
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652208; cv=none; b=i1a8sPOsKcIMHG2n2icyesgI9qYh7U+2ckjnuLtEW+wqJEHur79/PVJKizsDDWF2zg1XiLJNHaoCjmElrOtF2Yt7M2yX5aLjVUr0IJ6kUX0fRx66Uxz//ALmnXuBWIxqUOXskOf3CjN1ulMOrZMF2+st4m/YXZsiyov9L5wK2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652208; c=relaxed/simple;
	bh=2FxZ/2y9h0cyCDXMWJtzCKitKqi1L/i/xpoqPuGWrDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MjTqibwP/Zy4/Lxk8Y1cbREoWDWR9PfKG5BYmQMwQEIKsLkzI1KgtobTDk71z0Myztk2aN9szvS3vNTF0mpY6FDxRONof0RCZzoJYRGfwh5qDX+pDe5IBMgIr3CASHBe2rH0sRfsgI0Fn/c3zmYFR5geCTPG/OXg8lt4e2YdfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=osxwkRAB; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e04e1ac036so296716b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708652207; x=1709257007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAEnH53gyl19Xvz57rxQWG5qLmmOqrN1Psq5JZEUAA8=;
        b=osxwkRABjEhFGBzrV9MmbctD/ZjWFgE0BoXLACPOjkhAjkkEamdgFn2/+jKii6R4Nb
         lE5KGATdUc6wS6FCDfOKYXwbONYtUZAUZ+JR5tLfFhn1orFvrz1yfyd5LrLoS8iBVt83
         yw7JUFT0VtL5pz6Ae3h2VllygXpqAvhrZO8ylXlnfsHu1zIqBbX8zFzQC3fTX3gNC46S
         1ajKDZq48gIjKV4TwBzBR+p0eilYiUCfE847rW1TC4zpqjrLd1nMoGvJFQV5lt+qrQWG
         pgBylZkFcoriHCLDjsnc6unnU7U6p0gugd50uKAzWw3ke0uuL6ZrBvJM8RtdfAayo//W
         3hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708652207; x=1709257007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAEnH53gyl19Xvz57rxQWG5qLmmOqrN1Psq5JZEUAA8=;
        b=IRuQpJ38PNBb5763MzZb6OjUIV2CLD+gM1Hn623djKjaTQE/vrt1BCM67yz488tCZW
         FiSNRvh8WStQA97A+wqQVBeOLi68N8MPn84jaF3KBLpc/H/OPO4d6h0dB9Qsf0vaxn5e
         9QAph/WkB2QBjLXpF+eIUgysURiFJUhy/VarUU+YLOcpJakgzD7xLrkQyxPkO5CfEP7a
         26N0G1tvQVgYtaFH3IjkM1J+YiMr1lUX+Vt+o4VJdorC3CNCy+92UrvYmqHtazg5jUNd
         L87sGV4TDjAiForaTwPAk4PJTj50+8hgJqWthQL/otxN/0wx+JvQeErubasNEtckXsnK
         84Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVndAClGBQk5mHwvAAyE72PwERfEFr5sf7q5s7OPiFZhBx6LPb7BSuF1DdMS6zqECGNQKYp9r2bLEMibGpuiSeARyMitPToXVNfsrf/
X-Gm-Message-State: AOJu0YwVB0h0NcQqzTFstC3uy7Vkavi9J6IgwY5t0vRWqEcL0oylCmRu
	OPKv8ZP0xO9FbvDIv/RNkeu1323354A+LaHjnwNGipRXD60r5KFEg5DOAxUfoWtHTaKeGFEgc3a
	wHg==
X-Google-Smtp-Source: AGHT+IGyi1yHu9JhG+/KzPqWHOTY++D1xZ8ZkQBsJAuB3+/V/uPZ8hrH6eM6PN5PhtewBXVxg6GUsdPHmg8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:92a6:b0:6e4:d0a6:ac5 with SMTP id
 jw38-20020a056a0092a600b006e4d0a60ac5mr35459pfb.6.1708652207029; Thu, 22 Feb
 2024 17:36:47 -0800 (PST)
Date: Thu, 22 Feb 2024 17:35:48 -0800
In-Reply-To: <20240203002343.383056-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203002343.383056-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <170864763228.3086330.15607952198938732743.b4-ty@google.com>
Subject: Re: [PATCH v2 0/4] KVM: x86/mmu: Clean up indirect_shadow_pages usage
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Feb 2024 16:23:39 -0800, Sean Christopherson wrote:
> Resurrect a 6 month old patch from Mingwei, add a few cleanps on top, and
> fix a largely theoretical race between emulating writes and write-protecting
> shadow pages.  At least, I'm pretty sure there's a race.  Memory ordering
> isn't exactly my strong suit.
> 
> v2:
>  - Drop the unnecessary READ_ONCE(). [Jim]
>  - Cleanup more old crud in reexecute_instruction().
>  - Fix the aforementioned race.
> 
> [...]

Applied 1-3 to kvm-x86 mmu.  I will likely apply patch 4 for 6.9 as well, but
assuming it doesn't get attention "soon", I'll apply it dead last in kvm-x86/mmu
so that it's easy to discard if my paranoia is unfounded.

[1/4] KVM: x86/mmu: Don't acquire mmu_lock when using indirect_shadow_pages as a heuristic
      https://github.com/kvm-x86/linux/commit/474b99ed703b
[2/4] KVM: x86: Drop dedicated logic for direct MMUs in reexecute_instruction()
      https://github.com/kvm-x86/linux/commit/515c18a64e70
[3/4] KVM: x86: Drop superfluous check on direct MMU vs. WRITE_PF_TO_SP flag
      https://github.com/kvm-x86/linux/commit/dfeef3d3f310
[4/4] KVM: x86/mmu: Fix a *very* theoretical race in kvm_mmu_track_write()
      (not applied, yet)

--
https://github.com/kvm-x86/linux/tree/next

