Return-Path: <linux-kernel+bounces-77635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28480860853
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157B6285957
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994F3DF62;
	Fri, 23 Feb 2024 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uh2wCVIs"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F3101C1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652175; cv=none; b=Bv+e9T3bi+9AnCU7SJQLlFxlIlqiQcJE0U19Fxh3ZgsI0twKSKU+izCLF7ciGBwsGhYhpDvB++BQPjKQDfcTtlMuM0ecCsahfRSSEgJNblqXhPhUn9vlBVXJmVC2AaI7ar5OjFkrYKkheE6gWGg0lPeWZQUnPHzHCCE46phZbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652175; c=relaxed/simple;
	bh=sKrhHjuZBnoJEAjzckFbQFS67R7q0pZfm+I3DqlFuOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rb1/j1zQGELHKS1KH1xVgC1ee2+QYOVxPpdryFV1z2INWizUZnQAZVg8i9Kf1J1PBWZE+mR+5cejLmoLsIVcQ7lmkIYhx9avkZxHSOuysEIHqLiYORYrw00TdUSk912lj6v434zm/IcWIZpWAi4pBFu1FA6RlyFW9bjKG606PQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uh2wCVIs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dbcbfff988so4281125ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708652173; x=1709256973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9lxD8rtJGOtHzWHBkC2Cn8UibSydBlXaSYkj0vfMms=;
        b=uh2wCVIsC7kEvemdnqrV8R8sjfwefeP4YpqsCg9RWiJTE9ZGpyIstQELxKnzK/pUfs
         KIo6RO6sizFyulDvI9FpFegALD4y0wC0peK9vtwywZtHYjXayZHNwhUbf700wk+lXr3p
         YbhTlb8AZbrSn6FI1l4FOUuiz2agotGyv0x6KBsjDTOnILfUdvEy0H5sxY53TEy1K92u
         MrDoMvax2nM5vNHllKgcVl8vzuzqI9mLg3HFa7c+O2LBPLw4CG/xcJhBx86fH88FhjNs
         V/ZcSs9BN+KbHk49/5bVbgiGuHdQu5SAAAEM/4kZQfXyQ4awOoCyvp97rXE88jxAQXw3
         eZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708652173; x=1709256973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9lxD8rtJGOtHzWHBkC2Cn8UibSydBlXaSYkj0vfMms=;
        b=bQAa/mg3kZGLv4r7uFgxKZ7R1bgG/6mGv06il3qPcWyQaLYMC9zpby5bEqihUlMa9d
         PD0HXKJ5vEY0BdBXHIi1NioAWksqZSsPiLzC/4qmzHm1W+tMU6Dbpev7ngJ0/85AFYAZ
         eIDoesBSgM1hER5p0T//KjLbMzKYNVdaXK127sCGzDfzrrttT8xP7COr6Pn5rpzY3f+T
         SYAnVFQJnYn3wVjn8PF7CKYWaxIJCA3o9SwMBI/BdmpKIHn1gk/JsAFPXV+ZnFvncvVg
         P08KVNaJ0Lm0lnj7mGthr1IOsseJ9a7cmTKPTsXHYLYUD4ABQ7aFAKOW13m8BMBuwHRN
         AcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmexLjN3sLi5lp+nfgsbjqHFkkzQ3GtKkrJDXOINRr9n1yJc1PbHjvp2whyz/SBWCGC1IB5FRwGunY3UYM4O2DOeEdkPY5OxaxKdoL
X-Gm-Message-State: AOJu0YyRXG/FiHGhUfdW6bXF9ccmW2MYSnEoZWTwicQtVYBO4gpjnWI0
	h1G0W1IhiMC3xMddHWwnezOeipxHreSmkqRST8DCD6O5SdstGw9dond6snOQFSTtU74E9lZtPa+
	rxQ==
X-Google-Smtp-Source: AGHT+IHnOxCfD8my0/2WhdbsmRzLGDIKJXPzf6QwrhuktCCwyrgQ67HqOMXSjHERWHC4u6alq80dk51rC/Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2351:b0:1db:c4b8:694f with SMTP id
 c17-20020a170903235100b001dbc4b8694fmr1555plh.11.1708652173025; Thu, 22 Feb
 2024 17:36:13 -0800 (PST)
Date: Thu, 22 Feb 2024 17:35:38 -0800
In-Reply-To: <20240209220752.388160-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209220752.388160-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <170864750298.3085684.5517698484958714659.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Cleanup kvm_get_dr() usage
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mathias Krause <minipli@grsecurity.net>
Content-Type: text/plain; charset="utf-8"

On Fri, 09 Feb 2024 14:07:50 -0800, Sean Christopherson wrote:
> Make kvm_get_dr() use an actual return instead of a void return with an
> output, which led to a _lot_ of ugly code, and then open code all direct
> reads to DR6 and DR7, as KVM has a goofy mix of some flows open coding
> reads and some flows bouncing through kvm_get_dr().
> 
> Sean Christopherson (2):
>   KVM: x86: Make kvm_get_dr() return a value, not use an out parameter
>   KVM: x86: Open code all direct reads to guest DR6 and DR7
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86: Make kvm_get_dr() return a value, not use an out parameter
      https://github.com/kvm-x86/linux/commit/fc5375dd8c06
[2/2] KVM: x86: Open code all direct reads to guest DR6 and DR7
      https://github.com/kvm-x86/linux/commit/2a5f091ce1c9

--
https://github.com/kvm-x86/linux/tree/next

