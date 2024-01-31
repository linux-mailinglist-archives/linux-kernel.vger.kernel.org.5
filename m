Return-Path: <linux-kernel+bounces-46715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC0F844312
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A891C21CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A53128397;
	Wed, 31 Jan 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfRaxlP/"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B869D22
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715103; cv=none; b=NEhHorJI870uObNJdiCqv0i4m37ub19SRhc6QtzV92x2ihnMMDvkr1ytT2XdNGnPByqcTKAx7dsMnC7GdUSooHPRK6/Bazsi67KzqlozuBdMBqlha8ARtAFTzAOWtdxMg00Dg9o9uz5RnWCgdjnpWooNB3S+hEHKbGlzXxG5Z5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715103; c=relaxed/simple;
	bh=oL4W9D8uTGF08rS1s/ZYdHS1i0mWCq37SyhQwBq1J/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pDlgDGkCb2tx4jAAySwKNPwFu1o7Zk0ES1p2ZbRK5ViSXMxWd2owkS0hmb91jbvfV7DS5Rysp6K1Z6D/ol0mzDZiEEcafid1jICcoB8bfJlZpiiOW9wQKVkR5NdQ9BriVLlQc3LDZCSbHklG1IKywKRVKgeNpPlv4aaHMDOMaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfRaxlP/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6de331e3de2so961861b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706715101; x=1707319901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLI/CdVyu9eHQa8UHfDtmUbiN6ljlyx0ki16JonNEL4=;
        b=XfRaxlP/wEWHmRB8W4qh16naOXVxrnXbKK9v7R6GTvB3Xw5YP8A8K9HBrioKIaNPsW
         Oh2KGtNCBJp7Wi+1ppueO66FuDd7NcrAI7r2kKkQGS5E3NzWoX6wz2Ss3Kf7NkucYL4s
         TxfbemAIA7jIhwtzneXJudfw3jXy8NvfqhHeCqdE96ktNG2XcPSHN2WbWEZcy7qJMOg0
         EQ9sE+bKVtw7eV9iZ1MdJo0RozdLFxkUCbJiPxvr6H1UIP2Y/E9b3AkT/xGCgRgNZK8H
         UE6VMEEE3JYUpHu8RGr1zluteiM0sc8fISNEpZDUnH7l5hdVN8bxZ+2b1lzEWztvQ80q
         eG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706715101; x=1707319901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLI/CdVyu9eHQa8UHfDtmUbiN6ljlyx0ki16JonNEL4=;
        b=IPWJ0acXMfYYuv/QmX+4h5ix3pRXCaWBjO7HGx25SZlG9xECOerOK1II7jl81iZMSW
         fBhT2IKvKbPhzBAquuxiePhgQ9qMEGCw7OHF2rOHuCflZpxdnK+IprZo0Q0FptSCY91C
         qbiEILvdre5XzqeGw34CeZgx/GfNp85zHaW/ZYJc71PcXS4Fw0iJsYjRu4TvN5J3Og0E
         Bs3UxVYky643qud7zezfI83x0cGk3tP4/1g1y821ejWKT7XB1m1y8tlt9cEe6WvlIBQ3
         6CQ/nYnoaDvRCJZMrCjyHJed9B2ql5HiBYW/Eb3L7zoZ/xNAgHtfwVcncVPraI1IXwgP
         bQog==
X-Gm-Message-State: AOJu0Yzl+JwFpxCDO/XnhequV2dz2YWlmH2Sp8432VZWSOrWh9LfBVEq
	Hi/oz46fvs3h/fj7593g19Kx8xHEMjQkK5JU4se09YN8jEEOIetAIl4yZhkKKZYqrUB8ZqCZBCn
	INQ==
X-Google-Smtp-Source: AGHT+IGakOzZSxJMYgkN0htnKhLJoZV0JKpLbOKc2nO+hNe/P1Xdl9Oswur6+6pTCFd171+nGMSVDK6fWyg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:cca:b0:6df:dd47:ff3d with SMTP id
 b10-20020a056a000cca00b006dfdd47ff3dmr85585pfv.0.1706715100889; Wed, 31 Jan
 2024 07:31:40 -0800 (PST)
Date: Wed, 31 Jan 2024 07:31:39 -0800
In-Reply-To: <d24dc389-8e73-4a7a-9970-1022dcbfa39c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109230250.424295-1-seanjc@google.com> <20240109230250.424295-17-seanjc@google.com>
 <5f51fda5-bc07-42ac-a723-d09d90136961@linux.intel.com> <ZaGxNsrf_pUHkFiY@google.com>
 <cce0483f-539b-4be3-838d-af0ec91db8f0@linux.intel.com> <ZbmF9eM84cQhdvGf@google.com>
 <d24dc389-8e73-4a7a-9970-1022dcbfa39c@linux.intel.com>
Message-ID: <Zbpn284rPe3pMBwI@google.com>
Subject: Re: [PATCH v10 16/29] KVM: selftests: Test Intel PMU architectural
 events on gp counters
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Jinrong Liang <cloudliang@tencent.com>, Aaron Lewis <aaronlewis@google.com>, 
	Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jan 31, 2024, Dapeng Mi wrote:
> BTW, I have a patch series to do the bug fixes and improvements for
> kvm-unit-tests/pmu test. (some improvement ideas come from this patchset.)
> 
> https://lore.kernel.org/kvm/20240103031409.2504051-1-dapeng1.mi@linux.intel.com/
> 
> Could you please kindly review them? Thanks.

Unfortunately, that's probably not going to happen anytime soon.  I am overloaded
with KVM/kernel reviews as it is, so I don't expect to have cycles for KUT reviews
in the near future.

And for PMU tests in particular, I really want to get selftests to the point where
the PMU selftests are a superset of the PMU KUT tests so that we can drop the KUT
versions.  In short, reviewing PMU KUT changes is very far down my todo list.

