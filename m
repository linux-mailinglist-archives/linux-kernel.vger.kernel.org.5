Return-Path: <linux-kernel+bounces-96312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F404875A0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B46B285FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E6B13DBAA;
	Thu,  7 Mar 2024 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFCVoZc9"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A1C13A25F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849567; cv=none; b=Nn9o1jta/IW7ws+FPYryi74UsedZhjJGratd6ObrNb5k8+zM7ytTxHcMqaNvkwcNnMtUkkiZbsfi07S2abYeKRj0LFq3hKctpEFiuoyOkukjl/W1g0n1jqTDgu9GW3Eb6BQY30YYzZPQh2+a/GdfqPNEsE8W0SWbMQPFX/MFpXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849567; c=relaxed/simple;
	bh=UpPXWVFavkocwH+DQfJRWTog2e6sgaLgTUkxT2Sm4r8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WdgrGjxFv6/Ph6Ym3BVnbJ9IdddzVHszF2iXVDm6zw9Ymtk3ae9YP3TZ7fcCO0by6MSiZMcyf09y6tFpslHy52zWngO/NRt+u8pRLhf33l6a7qig1cw+z/g8lmaallRhaERzoEJEdkkAEI1a53QLHP3bf+OCcRhDYL0TsaTGgOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QFCVoZc9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso670109276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 14:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709849565; x=1710454365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xstMafkx2yqZfXLXJgRyZIp8AL5793h3Ux7d+Yx1pmc=;
        b=QFCVoZc9fl5Kg9cg+M893BdaeMryb7UYTRXIoqg2FnWMl2X5UuWY6UeqCrJef16djq
         tp2ju9HlD5ZklVvkPd+thcRk8Qz0fDoMjx2t9JZMvHTgCRwLtLvZ+PRUX3zhszjgpuke
         Lo7GqMBSna1GfH97HxrydJp/8ATm7Con2XtbFVc2m/9HsECQmOLMwVrnBj0gw8TmK0YH
         8TnIEhThly0srnb1DSeAWHip8uk3FYhstKUDG9qPw+nqtNW4DRCNWo/yZzcWvKgeDiAN
         VoEtBDNRg4B9cUA7+BR9hreE9nlIwMWthjpYnWe4p8Lks0TtF5jMhqnxuUynTTUt0R4P
         3fSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709849565; x=1710454365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xstMafkx2yqZfXLXJgRyZIp8AL5793h3Ux7d+Yx1pmc=;
        b=jGAoUE686okaCxIbVCRjSbUg4Do3ZcwZusryK7WFsrhbyhuQySk6EnlD5Vm5QB+75s
         w/z0ru8ixOoZXY4oXPJLbiBzzrwk0mLW6VkQ5M0fe6vvnwHF+sYeQ8Juil5Pd0oDW1Xw
         8u6zwgv9Ki/cn9+Dq454Br1yU+Tr2JNdlswdFwXiHY0JirDYA68MBvId6G2d27Yjjptx
         pOUYfWedc3LWfseq/K0ONzzMglE73q/jHf8oSOs9FPEJbx20b9BhJ67MB7Y85VLzmQBh
         92BICsL0HVId20O760YH7oWfdYpRVEKbFbxMWe7z7mMhabDkydV1km7ICENHbR+gydaB
         QqXg==
X-Forwarded-Encrypted: i=1; AJvYcCV/h7f+VAF6MLJKxPOsv9DUPW0CQM6EfV6jqW8mEEHQLk+ZeKH5HsM9DRfzt8Xaf2fj1im5PTuhtGuCoonc7wb2BIgD6WQ4k2IvMpOZ
X-Gm-Message-State: AOJu0YzugPYwU+4p2aD6IKdzA7wSODVSdsbLI862sRmgNlJjm4KL6WJi
	iZRLABLLIqh2paCYBcGoReGA671+ka7AKQS7HPJaq0YO8liD72JdvyF9jmOEMAnhJnozuYNBksd
	5Iw==
X-Google-Smtp-Source: AGHT+IEcyyc6xDSeTizB9j1TJ3L/LbbzFyRBUULITFEIXv8kFQM86M1rp+X6Q+wuyVoczAKUb+xmAqNNh1s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:154c:b0:dbd:b4e8:1565 with SMTP id
 r12-20020a056902154c00b00dbdb4e81565mr760788ybu.4.1709849564897; Thu, 07 Mar
 2024 14:12:44 -0800 (PST)
Date: Thu, 7 Mar 2024 14:12:43 -0800
In-Reply-To: <ZeonIc8KFbYssLzk@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-2-yosryahmed@google.com> <ba8a51fe-7b22-46b1-be5f-1e4c837d085c@intel.com>
 <ZeoMTzNSyZ1ValBb@google.com> <ZeonIc8KFbYssLzk@google.com>
Message-ID: <Zeo724RK1CEDPhVq@google.com>
Subject: Re: [RFC PATCH 1/3] x86/mm: fix LAM cr3 mask inconsistency during
 context switch
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024, Yosry Ahmed wrote:
> On Thu, Mar 07, 2024 at 10:49:51AM -0800, Sean Christopherson wrote:
> > On Thu, Mar 07, 2024, Dave Hansen wrote:
> > > I know we all have different rules, but any time you could spend absorbing:
> > > 
> > > 	https://www.kernel.org/doc/html/next/process/maintainer-tip.html
> > > 
> > > would be appreciated, especially:
> > > 
> > > > The condensed patch description in the subject line should start with
> > > > a uppercase letter and should be written in imperative tone.
> > 
> > And while you're at it,
> > 
> >   https://www.kernel.org/doc/html/next/process/maintainer-kvm-x86.html
> > 
> > which my crystal ball says will be helpful in your future. ;-)
> 
> I am sincerely hoping that there are no contradictions between different
> maintainer docs, otherwise my brain will break really fast.

Heh, as long as you don't contribute to net/, you'll be fine.  kvm-x86 mostly just
follows tip, with a few minor exceptions.  But the exceptions are explicitly
documented in kvm-x86, and I am intentionally forgiving/lax on them, because yeah,
getting pulled in multiple directions is no fun.

