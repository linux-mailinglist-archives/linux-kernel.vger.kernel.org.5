Return-Path: <linux-kernel+bounces-53243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D72C584A290
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2FD1C241B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36C481BF;
	Mon,  5 Feb 2024 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x2EhI2Y0"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA345953
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158455; cv=none; b=cpayAkqceuw1+wuzon48ZykVsLRAcXmjoZqGZU30yCxJzjz/OPrMAS0wBA3fPIDHP+vrTvg32b/TJ4fAXYwhB+ecvfOFDknRfti1j5Ye3AG2SnQvRB608dHc/KJW2SzrByhKUybd4QXBfkQSQsPYxcn0en7KPK5Jz7oRKqMzWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158455; c=relaxed/simple;
	bh=5KzOV2uFBphcx2s5QvJ6Q/kFoGTmnuoVCQbC2QKOQGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D/ImOrXtJi6hQ9tP8xKViynWpwD+ov3OXkeMPmU+VKofAJvdUdrJl18+ZVdUnY30ilQ1sIDfS4aTB3V5Wr8FAL6O2CUeH1EIhV0vzweyeyHaRjvPHUs/QjBTQVnf3wq0JSrT7DRGfbAqa81dqZXx4XZ9cpBbftZQuveiUnrW6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x2EhI2Y0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso95276276.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707158452; x=1707763252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=55LWoOSB/WgS8nNcVu6xiIo2AyT6nK2cpDVJl/BcjxQ=;
        b=x2EhI2Y0w0IVZyCXec8Fon02Ano/Sl5QgF/z8gFkScthDXtwWwq/iVj5102mEftGov
         ebT9tL09F5EhEVJN4WgKivaGg+7BSuj4IGwR4d+2+enjs8vdKA3Hmgqaa6xCVypk0KEw
         JmTifuQEJfQDhgpPTS/h46FevXCGypeLJCqMoJlA/WsEyS1/5uukzBXcZ73HK4FdftF+
         s39rY19B/8HgHcJPldFm4dh/fZ1OxPPZFm5B7MSRTGJHwne2FiZkrAfHiT2VCv9VPTL9
         QbGV9m9GCVwJENquAswUCXW+SE7q1cdHfVP2tzxXjJJhwdybEitQoTD7QJQIZ1oPJbfH
         7+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707158452; x=1707763252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55LWoOSB/WgS8nNcVu6xiIo2AyT6nK2cpDVJl/BcjxQ=;
        b=S81J3aEmmDnCv/X/Q3IlMN0PQOm/XuVd4WYLRkElRUTDg+UWsnuFKN710dIBNn8n13
         U1z5/k6BpoY6/7qe6nuOG+h89e1aeHCmQpyoX7aGySANOQLuxLMKSifP6ak2o3jAswHD
         o/fHJtITfcLh/tBMxDz7nc/PWv3BzNq1ymyE2Sq+iAEnOSHNed8mfRUxWwqgm/50nodv
         Anie91A0mkun4oNhvDYEiQIlNPQZCLH9Uh0JGrx2bQcDJGJyYvBMzBf99lp7/OKeByZi
         eU4ab6WwqV88C7PdGsn/DbaZiOeMCbvyCGFTInDHr9tPqDQZjRGdv069Xq971a5DF4j+
         2+Og==
X-Gm-Message-State: AOJu0YzVwjbaMPWKYBxCbCmQVquEKw66brEXu6RmiOhnpZ67KCSeYW2w
	peFyTk26KihdR9UymXsOJ34C+0TQcTGDdOELoaWP+JYbMHTPj0o6usEqOHBssTjN+R1G40CC+XY
	wRg==
X-Google-Smtp-Source: AGHT+IHKLPkeYHcfXMgqmEnDGn9kOtx3MQxMRSSWm2xZYTcoPRnwVxSy9KnDJZTc5wGZHtfWJfC2KD+3mQA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2186:b0:dc6:ece2:634c with SMTP id
 dl6-20020a056902218600b00dc6ece2634cmr6729ybb.11.1707158452741; Mon, 05 Feb
 2024 10:40:52 -0800 (PST)
Date: Mon, 5 Feb 2024 10:40:51 -0800
In-Reply-To: <20240205173124.366901-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205173124.366901-1-avagin@google.com>
Message-ID: <ZcErs9rPqT09nNge@google.com>
Subject: Re: [PATCH] kvm/x86: add capability to disable the write-track mechanism
From: Sean Christopherson <seanjc@google.com>
To: Andrei Vagin <avagin@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	kvm@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Zhi Wang <zhi.a.wang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 05, 2024, Andrei Vagin wrote:
> The write-track is used externally only by the gpu/drm/i915 driver.
> Currently, it is always enabled, if a kernel has been compiled with this
> driver.
> 
> Enabling the write-track mechanism adds a two-byte overhead per page across
> all memory slots. It isn't significant for regular VMs. However in gVisor,
> where the entire process virtual address space is mapped into the VM, even
> with a 39-bit address space, the overhead amounts to 256MB.
> 
> This change introduces the new KVM_CAP_PAGE_WRITE_TRACKING capability,
> allowing users to enable/disable the write-track mechanism. It is enabled
> by default for backward compatibility.

I would much prefer to allocate the write-tracking metadata on-demand in
kvm_page_track_register_notifier(), i.e. do the same as mmu_first_shadow_root_alloc(),
except for just gfn_write_track.

The only potential hiccup would be if taking slots_arch_lock would deadlock, but
it should be impossible for slots_arch_lock to be taken in any other path that
involves VFIO and/or KVMGT *and* can be coincident.  Except for kvm_arch_destroy_vm()
(which deletes KVM's internal memslots), slots_arch_lock is taken only through
KVM ioctls(), and the caller of kvm_page_track_register_notifier() *must* hold
a reference to the VM.

That way there's no need for new uAPI and no need for userspace changes.

