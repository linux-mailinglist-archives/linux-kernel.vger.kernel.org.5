Return-Path: <linux-kernel+bounces-84056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC986A1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1761C23589
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C142014F967;
	Tue, 27 Feb 2024 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2q9JW4q"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1A14EFE1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069489; cv=none; b=SqS8ML0RZ+62jjPuDUKLzNhY93BnE+j1YEYzezXpR+yC77oJL5kTNiTlwlJCe8/fWcbjX9eo6AD7obPPXMKyEO59Aj6TplAfv2IhxYKdDm4IhEd9GR81GCh6ypmWk7OFshURB8QaS75TwMHI/iNU4h/7JqmStCqo5YD0GoAHotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069489; c=relaxed/simple;
	bh=1ngWzFe6552eXSygHbHQWcAZZReIAzpNojL6T+WcIv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I8UoXZRQzza69RIyzEWSCmH4w7Qwesc76u3hEry1pWSmPCQYOZhpZmic58NDdpy/fkag2UA7LcC0GQlTG021CYPCIVs8GmE0843bDtApck/kgTfeL89DlQmefIfxtnI0xXKZIZBnTMUXsXYGEbFkKeVoQ49ePBo1uzzPDlDNKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2q9JW4q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so6075818276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709069486; x=1709674286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZP15haE9JalPlKvzqt0FWShTWzP89HEcDeWVmjgfEs=;
        b=s2q9JW4qhwf+kyq1+52HxMyBAc2FgHuoPNe8moEBDBakTIje4+kvUXju55tkZOPWgI
         BXSj3mDlx9+RkziNB0Otwncu0gdO0Ifq0JtVvSTy6mqebMk5k4rOanLIwDWFYwqHQfRd
         1VDv6yPqTsHySKr1Y8Ebt8/ZBrOGiKPEa9mS0dYFEWNzbHj7b00ugDKXd0Dxr7e+07zt
         UNvVM+APPZ5WKXilr4e0trsMZmB5yF49O7kfhUyh075pY5B4RR/JwtLPg/1PvL5Ihm9h
         Paj1LqUKjkkM/P6UuUQCQYP6wFePPDg7HOGTRQvqpMfnP/5JOlSDqXHm4rCwjvmd3WY8
         7qPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709069486; x=1709674286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZP15haE9JalPlKvzqt0FWShTWzP89HEcDeWVmjgfEs=;
        b=pfXcOxeLHFAoLjUx+DvXzmtcdNhJRROON9EcZcY34uwKsWoqrXAccTpq/8YYzQ8+js
         ZT1mOLldPdtUs8qnmGTdY1B23ZZozUK5ljwf7wHDsDMruyRabIbRAGWB6a+xV3wq4Xqv
         KaC7gWPkxZR+bcVIepAmKXfkBATeFHcIEVlV1LPQvxkK/SvT3P7WJI+wQHVovQwTgiOG
         di+KKfmkLmWI6Wed473StukpJIShGvO2NnhOnL38a41D4T50DH5oaHvZs07IKIhQQGud
         QLKQHQEsGERX92YzuCSLfQNXWuXCQ96EfaYHzvu5ZEM2CRNc2nVHwA+gCI1zAQGWbV/q
         8XJw==
X-Forwarded-Encrypted: i=1; AJvYcCXqfxu48GhhE9JH109S/Ww6aXPaj+BFghAC/JJV90gdIWqGVZR96+MLZz5+AuZ0ozOQl316E65ctxXSwMXhEfhea3plqh66Cvefzqbw
X-Gm-Message-State: AOJu0Yz7nI/R95Iotjf4ORTFVcLRAmOxKsvKqhTiiHb+8ilgXPv0c7oZ
	wvGlGGnUi8Y4yiWu+VNb+pNPRz3Mo+Dl6m80CaMiX6JmlrJkncE/s+kfrjM9Jyst41L4jsqDDA0
	PnA==
X-Google-Smtp-Source: AGHT+IE40eaTQIy4w8adAPFQCTUbDyi33sF2AxJ4EP+nO/Hdde6NYg8So6iu9F9Goc4SPQMp+xou9z4+mvs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1082:b0:dc7:9218:df3b with SMTP id
 v2-20020a056902108200b00dc79218df3bmr51209ybu.10.1709069486746; Tue, 27 Feb
 2024 13:31:26 -0800 (PST)
Date: Tue, 27 Feb 2024 13:28:20 -0800
In-Reply-To: <20240223202104.3330974-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223202104.3330974-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <170906381686.3811155.13601943682251493126.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] KVM: VMX: MSR intercept/passthrough cleanup and simplification
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 23 Feb 2024 12:21:01 -0800, Sean Christopherson wrote:
> Clean up VMX's MSR passthrough code, in particular the portion that deals with
> userspace MSR filters (KVM needs to force interception if userspace wants to
> intercept even if KVM wants to passthrough).  As pointed out by Dongli, KVM
> does a linear walk twice in quick succession, which is wasteful, confuing, and
> unnecessarily brittle.
> 
> Same exact idea as Dongli's v1[*], just a different approach to cleaning up the
> API for dealing with MSR filters.
> 
> [...]

Applied to kvm-x86 vmx, with Dongli's suggested comment indentation fixup.

Thanks!

[1/3] KVM: VMX: fix comment to add LBR to passthrough MSRs
      https://github.com/kvm-x86/linux/commit/8e24eeedfda3
[2/3] KVM: VMX: return early if msr_bitmap is not supported
      https://github.com/kvm-x86/linux/commit/bab22040d7fd
[3/3] KVM: VMX: Combine "check" and "get" APIs for passthrough MSR lookups
      https://github.com/kvm-x86/linux/commit/259720c37d51
--
https://github.com/kvm-x86/linux/tree/next

