Return-Path: <linux-kernel+bounces-77636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DDF860854
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8631C22612
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4F110A0F;
	Fri, 23 Feb 2024 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAhzHpv8"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B81BE49
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652181; cv=none; b=B16Q6W/PXsgi09cknC9W+6MIU1jpj0edW7wla+9wiJFFgJdVLhIeuLtnWj1NFM7QgzRqlRfJ+yrUe2+nBmR2fysxskDdjxzhGW2AEtAF7kha+AUetnT8vuXXTIh1H5Z3URxaQ41CdWJQgiXhqYRrRSIh6n4shFZm/1jyde5v4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652181; c=relaxed/simple;
	bh=P6KynTd25mmA5nnWS7DZ67ACtBg36Ii/fR5FpU2kyHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JLQtW6rdY4mKhzTDiuxZ4adw5Tr5dcGXmxOUMt28x6GltOuDxdhqgNC3uxtbNFdbnM4nKjGa+Ub8DKaqSJnjW4i+VQsT2anw7KGKA03KZL/w8dv+LO7kXVfJLR+IOLAMsRWIejYAESmTGVDi7G5xQG7ZOcSMhXc0MODiXVcHejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAhzHpv8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so643092276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708652179; x=1709256979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rcw8tudKzhaatewYgd0UihB3Ym1E2teLVbr4vLLJgk=;
        b=OAhzHpv8Rnk8Y4AxX3m9KEz+3Z5wetA7Ct0ZHlRL1WEebfjIU4iuV+Ew4FeVnbNRd0
         Qx2tKf0c0DYwMzfdRUNR14Tq0L1OgKw+hvaFb2L5WJ4A1syJ0nXknEWlz9UABgWPpBSZ
         NB/xQ637Tm2U/6mRDMmZlWbem/MHbOClbGCLhCoVRJriaEieQqYokr8fB4Wg81wuZlFq
         1bRELBfoHzAmB+lRnFem2zwPfiscVj7fDjBItbxIQiJXuwfSgC4dcxoBw6p0HrCVNISZ
         z0G0T4iahp3/s4RcuaPEcoV+ZYPrZB3n3rMG7uDLxq9A5N8kftlXxKssbiuZlnTab1WX
         aEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708652179; x=1709256979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rcw8tudKzhaatewYgd0UihB3Ym1E2teLVbr4vLLJgk=;
        b=AURfW6v9opGPdccaL86U7V7HJ0QPvAcHw4JpuwVLGuZZ59wCAQy4RPR5qaagMOfVql
         XQkZiGdXvwrkCvLP79jE3x5gZevo/4LktdfhPHd5U2pVYF7Q1Ph31jSAKGTb21ztrezx
         vcusn2MlY38TN9LWZmwgVkT/B4XYx0wcxP2henGSJyNs8jZ/Hytk/mev9bKLveJYZIZK
         klI2ESB2Lmp6pgZBlqPJyMiUzHpSHBTuaJ9/NdM+WVRRimFXFImaeyOk61lVCQcU74V9
         gaeeqCR6/xNjOS/S6Em1qo8pvSvp/cSrEHrNRBLaHKwNchEs99CoD3V1ChaEFnZivfcs
         M0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSQ3bVUmEYDtQ1KM5yYHOl2QaT4B+VgDTYWhHvHj5CWnpPQyXghvr/yfmOAR/lahKgy3apILYU79JLn7VT64AvTE22+MYu7SCB0K1H
X-Gm-Message-State: AOJu0Yx645kEuWtKljUEAk8vD6EvNvHNPc1U1WOK2J5J31u9RjTvHsLY
	mT/46Q9sh5kmeZs7fXtNdovajuSbVjoFP4r9QvdWQ6kbRlONgvZ9aq2w+dQtBGdv/swxaHQUH5N
	CwQ==
X-Google-Smtp-Source: AGHT+IGZTlgnDqcnrCbRRfkgaHHxqSojuVx8LUBEdz+ygbdpV4uhRDNfZTkLAnCCFRjmF1Jf3lX1Yiw5ssY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1007:b0:dc7:48ce:d17f with SMTP id
 w7-20020a056902100700b00dc748ced17fmr218627ybt.10.1708652179382; Thu, 22 Feb
 2024 17:36:19 -0800 (PST)
Date: Thu, 22 Feb 2024 17:35:40 -0800
In-Reply-To: <20240209222047.394389-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209222047.394389-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <170864806790.3089707.15358518741225122287.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: kvm_has_noapic_vcpu fix/cleanup
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 09 Feb 2024 14:20:45 -0800, Sean Christopherson wrote:
> Fix a longstanding bug where KVM fails to decrement kvm_has_noapic_vcpu
> if vCPU creation ultimately fails.  This is obviously way more than just
> a fix, but (a) in all likelihood no real users are affected by this, (b)
> the absolutely worst case scenario is minor performance degredation, and
> (c) I'm not at all convinced that kvm_has_noapic_vcpu provides any
> performance benefits.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86: Move "KVM no-APIC vCPU" key management into local APIC code
      https://github.com/kvm-x86/linux/commit/a78d9046696b
[2/2] KVM: x86: Sanity check that kvm_has_noapic_vcpu is zero at module_exit()
      https://github.com/kvm-x86/linux/commit/fc3c94142b3a

--
https://github.com/kvm-x86/linux/tree/next

