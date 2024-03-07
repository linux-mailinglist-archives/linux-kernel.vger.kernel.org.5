Return-Path: <linux-kernel+bounces-96216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECFD8758BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7ED21C21493
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9E139598;
	Thu,  7 Mar 2024 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhpHmfmc"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077581386AF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844262; cv=none; b=Q4TgsDY7/2GqwuvHMxpC05II8lGGZ3rxc+tFIUO+/tmGoMdXOyNMT0yWekZEGjcwtngKpt8xv/yIPBeGALzD3FDZ14k5BWWpgDpTP/I4YIjPprkwiV/3us1kjfkETrnrKXKAopDQs/qLSu6MfdPJzcp6cAgBKBlGXHK2pJUU7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844262; c=relaxed/simple;
	bh=ZCKEQVFsMoGu4KOqHwtBGncW8PsODsz93I+BGT3bDig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OMJ4/p5I+2Ed+tj0jGCCwij4wSiAai4Z/7/ORxFw0I2Ep65/5xit2Dvh8D/WVKC+GfmbcjbhkKPsxEFmMNRAv/RC0PVZ+JQxpbgeDH4Kn4HeJFACm1ucqI6YKp/bK1UutPojIF2hlG+fXFlXn/tMnjC2Ii79OwgYcrXcecYcK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhpHmfmc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso1961764276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709844260; x=1710449060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4LW3EWsRP9cPPLUOasI55J/A9AqyiyCJWPOpMhXGYA=;
        b=rhpHmfmc3GBizbNYYmVOZum+WDFoygGkZSnX78qlrmm8I5kMldZKI/SwAzlrI3e2Ni
         18nVU37JHXWM0ZmMmW1e/IdNxQoV4HyCc3+ZmXqcUAq87AqYGRhwah4CriM56AL3k/VW
         ULCnyD/5p42jmNrA8hZ/RpWPPTaf1aSjESKk/N3eASmnFqkOGoCVKzBhyUlJCFOWkGpd
         mbL98nRCLQYvFi5ByIhxSAV+IdjJWduKh2LCUgM7ruVnlGKPb7x5mwbkssofRGh63jYC
         SP5O5Z2rcLAJcu3BaZuAMGbYB+DtJW7NXzW39CAMVPqyDqKrNBk739IUG/9QxtqCkBw8
         UppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709844260; x=1710449060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4LW3EWsRP9cPPLUOasI55J/A9AqyiyCJWPOpMhXGYA=;
        b=AH6wKHwZpjPcLqwY5sf0Dn3Irygh1MzWzsOjDw2j0tXrXJRNwbG1deULE4WoqXuxGg
         4+FKjEe34eAOYbNGM7nf4kTSUhQ//XgbAvgKfYCG3kIwVyLeL5vjEkhiHPVGQxmiB8Q0
         VQYFzAJgnaAlP2ntOblGW5nxS3ED2tz/bWLLkoMDmlo9VL7sAM/dHnTVlzA4yX7O1AyX
         1ygPQf4D82xVYzkQmwx4rs8Cck4jUafgRzOSUP1ptpOidbQ8Qs2e/wxZO/jtUxae6KF9
         TEpvfepyZsI7QD/GLsSPi+d/e5AYPV6vhivyuOLMwbJSOmYC0MicSVWfwCy7xVdaVT+4
         RNqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3O0MveO48Iu/YU8veiMIPvC36xOFaUPJ2itNjtY3Upu8I3pwjBRasKYzBmH8XcL+/Np7qA0XuH6yCpftS+jovG+DQnGSpucYAcyMT
X-Gm-Message-State: AOJu0YwowBorNebGZeyQ9tcMl+S7tcd4fUIrSIn6BpsHtQX/JK2Rl0mW
	oxGTMiS4RupW/Lnp9CW74QBTyIv+r9M6qM7Q5OGmT93yKRGPLptPuowEYccaoowWvDB3l1kAYfP
	r1ZB65RyyFZjGMltgpg==
X-Google-Smtp-Source: AGHT+IEzWqzMKAyT7gIP2lFbuVWKpl6J6FL9wwibaKYospIHJ6VEknrmFfBoI5AnZKEEMj/j6+R7qbS0KtEgVzUG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:f307:0:b0:dc7:4af0:8c6c with SMTP
 id c7-20020a25f307000000b00dc74af08c6cmr778917ybs.6.1709844260013; Thu, 07
 Mar 2024 12:44:20 -0800 (PST)
Date: Thu, 7 Mar 2024 20:44:17 +0000
In-Reply-To: <ZeoMTzNSyZ1ValBb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-2-yosryahmed@google.com> <ba8a51fe-7b22-46b1-be5f-1e4c837d085c@intel.com>
 <ZeoMTzNSyZ1ValBb@google.com>
Message-ID: <ZeonIc8KFbYssLzk@google.com>
Subject: Re: [RFC PATCH 1/3] x86/mm: fix LAM cr3 mask inconsistency during
 context switch
From: Yosry Ahmed <yosryahmed@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024 at 10:49:51AM -0800, Sean Christopherson wrote:
> On Thu, Mar 07, 2024, Dave Hansen wrote:
> > I know we all have different rules, but any time you could spend absorbing:
> > 
> > 	https://www.kernel.org/doc/html/next/process/maintainer-tip.html
> > 
> > would be appreciated, especially:
> > 
> > > The condensed patch description in the subject line should start with
> > > a uppercase letter and should be written in imperative tone.
> 
> And while you're at it,
> 
>   https://www.kernel.org/doc/html/next/process/maintainer-kvm-x86.html
> 
> which my crystal ball says will be helpful in your future. ;-)

I am sincerely hoping that there are no contradictions between different
maintainer docs, otherwise my brain will break really fast.


