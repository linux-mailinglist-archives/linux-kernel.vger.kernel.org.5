Return-Path: <linux-kernel+bounces-147365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF97F8A72F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61E41F21B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156AB1369B9;
	Tue, 16 Apr 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WWYc187"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4E134CE0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291582; cv=none; b=fWV5XrnZ3HEQeuUN4pz95DDHQIL64EwHWKI37sbePe+80KVo8znN6kIsRYtyAilYv9k0ghBoBMPgo+i0C2KUDEvrstuvtMBA52ZUEqUzSpJKGPz1AuqcSNqs7jqVCl454QhUQemnekxUfdaz8fsdTqgB7We3MTsDfSrHeI1K9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291582; c=relaxed/simple;
	bh=jw3qGNAzG64ELX4Tee1Sk0cisqm/f/xYf4XyruOjn+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D+Uf2woucavQzpuLUvEaUgRAJEzUB+FmJqLy6QQbkjYvkqjdqR+lG/c+gT5/JA2gLBvV0Gl9yWS7oc/HMvPBbii699/MD9ZoHj8G9kn91/v69VwWgBnbiyxCZK/SRzj2S3rlToEncFIXCJjvh5qEI9+C6LtoF+46qEV5SXKhOwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3WWYc187; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de3d9eacb57so3229335276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713291580; x=1713896380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWimoGAi6TC7EJDWUZBrD/1JzkjLqta1O0Lm+vlOf58=;
        b=3WWYc187kVef3M/fHYAepoeN4BVEU/3eQPlX8xa0ciX0HtjNIcEmIALYg3sUDXt5mf
         HtY44XkpvUO9Fg/511jyxbkaXazRfuYjFuP9dAfOX695q40Qer3A2Z2kEjFmzUweepaL
         /YMQHRX+xKjx0yRjoJh0Sfw0+jMYwIp00hLhDl0jhhT+WyySid5EVoIREcwslajWrs7g
         7LhkJjl0g7fja3r/uEPSryxPCPTKvU1/ahCIJr5z4oYCTIgm5VYGzCpBmhswxiktm8m7
         Z/bjVIcMkCpbp2D5g55CXMbnOuB6XAeewEOuAeuvDp4LS2WsaxBAPnURozXth+wFW1Jf
         PPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713291580; x=1713896380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWimoGAi6TC7EJDWUZBrD/1JzkjLqta1O0Lm+vlOf58=;
        b=UeyoeA6mV/aCkynWNedtJyEvmhqz8azI+2pBFmYb0SLfrh9uYTV6xHFxt+JPKDrQYn
         T3svYdTqd9Bt+TKJlpucILyvPz65aMkprwCZ+jqQijjOH3C9zE9/XM/O7qUmZNeQjjYb
         sp4tIxmMUeBMMItRfbIR4xVuB1DzAlJxaDrX0EJgGYAA1REmIEx5YUxCGbhCdmWQiw9m
         pu7nqdK9n/bue/WI+/LEZAA1Xdh7WXaD/jZgmXLfO1/ykVy5k6vB+qR8Kb3/10rJL0O1
         6BObrZDSTw8PLM3nlCEDc3KngCpL0NbP5H37798NFR+oCvC8qQFxpto0CcY3C0N54VK/
         Goiw==
X-Forwarded-Encrypted: i=1; AJvYcCUUvkYHf7D8cVTGr9slk7vZWH3fBtwr7msI54RFaIcrPnDOLQgD6EOGuNquijv1i/DJEU2l5hY3+zYgwCag7FiEhsDTz4np4Mr1g/aR
X-Gm-Message-State: AOJu0YxgZcXl7JY0O/1irEKr3ClSVhApA1oLj+LufJziHsRidPRvmyKP
	vdy5IsUWdbCjsjo2ryxd9MBhMLn/a607E6+bBv40g16/szXc7jk54W3Q518wQrRj8xjIm1Ah7t9
	Hyw==
X-Google-Smtp-Source: AGHT+IFzVARd/Kh0xIbFd5v7iROgL00nXUhGqCqXhr9Y/J4BM+3WLtBzDPbCqJ4yUpAnAOVRksXuoAC3WAM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b0e:b0:dc6:5396:c0d4 with SMTP id
 fi14-20020a0569022b0e00b00dc65396c0d4mr4383816ybb.1.1713291579879; Tue, 16
 Apr 2024 11:19:39 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:19:38 -0700
In-Reply-To: <20240215160136.1256084-2-alejandro.j.jimenez@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215160136.1256084-1-alejandro.j.jimenez@oracle.com> <20240215160136.1256084-2-alejandro.j.jimenez@oracle.com>
Message-ID: <Zh7BOkOf0i_KZVNO@google.com>
Subject: Re: [RFC 1/3] x86: KVM: stats: Add a stat to report status of APICv inhibition
From: Sean Christopherson <seanjc@google.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, linux-kernel@vger.kernel.org, 
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, mark.kanda@oracle.com, 
	suravee.suthikulpanit@amd.com, mlevitsk@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 15, 2024, Alejandro Jimenez wrote:
> The inhibition status of APICv can currently be checked using the
> 'kvm_apicv_inhibit_changed' tracepoint, but this is not accessible if
> tracefs is not available (e.g. kernel lockdown, non-root user). Export
> inhibition status as a binary stat that can be monitored from userspace
> without elevated privileges.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/x86.c              | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index ad5319a503f0..9b960a523715 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1524,6 +1524,7 @@ struct kvm_vm_stat {
>  	u64 nx_lpage_splits;
>  	u64 max_mmu_page_hash_collisions;
>  	u64 max_mmu_rmap_size;
> +	u64 apicv_inhibited;

Tracking the negative is odd, i.e. if we add a stat, KVM should probably track
if APICv is fully enabled, not if it's inhibited.

This also should be a boolean, not a u64.  Precisely enumerating _why_ APICv is
inhibited is firmly in debug territory, i.e. not in scope for "official" stats.

Oh, and this should be a per-vCPU stat, not a VM-wide stat.

As for whether or not we should add a stat for this, I'm leaning towards "yes".
APICv can have such a profound impact on performance (and functionality) that
definitively knowing that it's enabled seems justified.

