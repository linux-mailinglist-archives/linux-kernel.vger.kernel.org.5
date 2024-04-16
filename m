Return-Path: <linux-kernel+bounces-147425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8D8A73D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350BF1F22100
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB513792A;
	Tue, 16 Apr 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VV7QYurP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD622137777
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293423; cv=none; b=bk9+xdLBdumKju7ooPaMXBzqRrHNS3Jy1zpmSY8LcwCCPC4kuI6ixQXCQxXVqusFGlBCTOC1jgNg/y/fpUm9X8k984y1H/Ei7hyGgt5lC4Rjzm2u3WOzmmrK3ZCC+X3HslsNfzEFRSs2IlXZi3Q6xXHqHwkBOe6ET8g4Fe78BbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293423; c=relaxed/simple;
	bh=KrLRBto3JssKwlYjlBIyxafefBjA3IrDNNlM/vJJ9hI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GhxIGtAb3ypKVVXhDywH/xyArH9aWuGu1xKJp0C9nBU0knnJuKxpGYUrjUVI97d+ZjYkl4+gKOgzEIG/rfJyJBHh/qIRx/Vka5KKE5De0Ndjjoail7oYxVRMuZLpVVB8if5u5sTeqr3ACcLNy+l/sQdUu8A0TCtfK9kObX7QML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VV7QYurP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6188040f3d2so85957897b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713293421; x=1713898221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=71fCbdfH1vAW84WFTiCdLyvSqDYlBpK8GsY+uanrllo=;
        b=VV7QYurPOp5zTg7ny6efPCKGEtrNWZI7feSbb11SZC4ZxHrZ647dEqDP0PmvYgPrCe
         V+XvbGOWpm2/JXVRMM6uWr4AsKw04ODhBIoFBJXEwwhAknQ4Fk8/iZz+lzY4z+s2am0b
         unw70iZR+6DwU34un3OdJZ6qJePX/QcmkBlpVIZO7xAQM+j+2ikzQpCimYhhkSclQMw8
         S0sj9D6DKvGtGAsTShKSMqnzLBrVAC5ipzPrdizdutuVineV4W5CW1ozoBqA8SieoaTi
         x9y7mDoIKLcFBiVoOC4qoqVj3Cz+++E1hYI0y0w0s4jmFoqPbBwNFWB7/bcuTybpLqbX
         lC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293421; x=1713898221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71fCbdfH1vAW84WFTiCdLyvSqDYlBpK8GsY+uanrllo=;
        b=bF86dNVfxlJU+CaUd/ZX0s8ni+88bI/Kc7CL/6Zgokhu7UERPX8PBvd+0SAlJm6aoC
         K8DJj83hV3FxUYWwWxF6LFgewvbn79ij77LFGI041MCdLCxtJTWWPs7hX6uKckeimU0G
         U5SpFvRHJ295dDcCLqZ4eLnGwr4/ggcO/n3HozEPmKOZETmVeYxPZK5+r/Clu51LA0TJ
         j44YjSqIrLhO1cfF/Xx8HQfB7BD8WeDqj15myOWi5dYIMbY/sxqp1TXqpNkjN5lWSIu/
         iZJbpqiBPq3qbamvg1GfmEAEAYPw+Gf6XUPCXWehiVmS/YIdxtXBvgZsrE4U5ms5alpG
         d+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhgs+jEKhthPBpl/QkZApIEw2oTwMarOMyX+jB5qqkQ0Ue1ammct2PirY4fGA0905AFHGl/FJmhZVXOeWzzDmeHAvxJzEnHR4xVcWs
X-Gm-Message-State: AOJu0YxSHcdXuIpO3vZQlxL5Pi75cWBZJaghKBRoS5R+vBj3PKHKQLMS
	RbglnfhJgJgKMk8KpATp20PASqQuzhHMKfYSYpIT6ExE7u4GcqjWat9w9GxvatDmGp83/Peckbl
	v9A==
X-Google-Smtp-Source: AGHT+IHgjpuzWhjz2uabzMwzuba3r3n3pXCUudSHE4FaID0UFJjuojA5qYXAZzXF16Fsmgo1kqxASxbfYuQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1081:b0:dc7:8e30:e2e3 with SMTP id
 v1-20020a056902108100b00dc78e30e2e3mr4217093ybu.2.1713293420969; Tue, 16 Apr
 2024 11:50:20 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:50:19 -0700
In-Reply-To: <Zhz8xNpQoi0wCQgL@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZhkhvtijbhxKKAEk@yzhao56-desk.sh.intel.com> <diqzr0f7jbj6.fsf@ctop-sg.c.googlers.com>
 <Zhz8xNpQoi0wCQgL@yzhao56-desk.sh.intel.com>
Message-ID: <Zh7Iay40VQgNvsFW@google.com>
Subject: Re: [RFC PATCH v5 09/29] KVM: selftests: TDX: Add report_fatal_error test
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, sagis@google.com, 
	linux-kselftest@vger.kernel.org, afranji@google.com, erdemaktas@google.com, 
	isaku.yamahata@intel.com, pbonzini@redhat.com, shuah@kernel.org, 
	pgonda@google.com, haibo1.xu@intel.com, chao.p.peng@linux.intel.com, 
	vannapurve@google.com, runanwang@google.com, vipinsh@google.com, 
	jmattson@google.com, dmatlack@google.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 15, 2024, Yan Zhao wrote:
> On Mon, Apr 15, 2024 at 08:05:49AM +0000, Ackerley Tng wrote:
> > >> The Intel GHCI Spec says in R12, bit 63 is set if the GPA is valid. As a
> > > But above "__LINE__" is obviously not a valid GPA.
> > >
> > > Do you think it's better to check "data_gpa" is with shared bit on and
> > > aligned in 4K before setting bit 63?
> > >
> > 
> > I read "valid" in the spec to mean that the value in R13 "should be
> > considered as useful" or "should be passed on to the host VMM via the
> > TDX module", and not so much as in "validated".
> > 
> > We could validate the data_gpa as you suggested to check alignment and
> > shared bit, but perhaps that could be a higher-level function that calls
> > tdg_vp_vmcall_report_fatal_error()?
> > 
> > If it helps, shall we rename "data_gpa" to "data" for this lower-level,
> > generic helper function and remove these two lines
> > 
> > if (data_gpa)
> > 	error_code |= 0x8000000000000000;
> > 
> > A higher-level function could perhaps do the validation as you suggested
> > and then set bit 63.
> This could be all right. But I'm not sure if it would be a burden for
> higher-level function to set bit 63 which is of GHCI details.
> 
> What about adding another "data_gpa_valid" parameter and then test
> "data_gpa_valid" rather than test "data_gpa" to set bit 63?

Who cares what the GHCI says about validity?  The GHCI is a spec for getting
random guests to play nice with random hosts.  Selftests own both, and the goal
of selftests is to test that KVM (and KVM's dependencies) adhere to their relevant
specs.  And more importantly, KVM is NOT inheriting the GHCI ABI verbatim[*].

So except for the bits and bobs that *KVM* (or the TDX module) gets involved in,
just ignore the GHCI (or even deliberately abuse it).  To put it differently, use
selftests verify *KVM's* ABI and functionality.

As it pertains to this thread, while I haven't looked at any of this in detail,
I'm guessing that whether or not bit 63 is set is a complete "don't care", i.e.
KVM and the TDX Module should pass it through as-is.

[*] https://lore.kernel.org/all/Zg18ul8Q4PGQMWam@google.com

