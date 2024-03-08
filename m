Return-Path: <linux-kernel+bounces-96497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F16875D10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260CC1F21FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F82F2C877;
	Fri,  8 Mar 2024 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQ48m371"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3B2C699
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709871233; cv=none; b=eDt5jKtuNyY8Njc9OrZ3aBCPhecMh1D+lC8qsHBhoMIswXFj1Ks5sPhlMgpcBssfZs8+XFF8hRYKKSyshOpeeKHoYfo3dlJKEctYQkwKfZkaXtNS1WH5+onkRVYTwtmeVwSDH+eSaSsksJc54J62RE0jIjvda0Tun4LhHRzSzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709871233; c=relaxed/simple;
	bh=qCIxyfYIQ2YAaqFZdN2RArkHnfxMrj0cqgZmFTqPB00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZiNnrxyTDNCgvMNPiuY1NwDftrQtm+Um+wXs1DrhbaFTpT3jCmFZKCniK9983PyIfmKFPyGh6yykbndqLWCYNFAg56LaO32l7xayHuYWmiAbueFeqn/dEXUhFl3nZxzplP9AcaWWgBGi45asQNm/obR72eUox41Ot3+pEOw4hFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQ48m371; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fd9b371eso10063117b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 20:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709871230; x=1710476030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw7ZbqEsiKihQ0Zm7edjlrJvRegrpau9dDzQ/T5cB8M=;
        b=yQ48m371Fmb3slBEXDR0Az4e6jO+mgnvIwZcjMSHZFso52fIgBhSCSXE26asH7iSWO
         dN3+TqOKPf2yy5KEqBf02zLIL3hTPt8TpY0EWEN2lHNY/qaW/6ixQ94QAUJezNxjXuu7
         PDxewT0nU+YDhapdgJL9C7kTk0bRWAORKwkyzCySawaal4d3evs3tQ1Y4EQYn4W10Gaw
         Q5T7Td5579yoQp+pe3NCbtulO9xoUdNdy3MxSnVVcb1H8OpBpsKFFQowF03rBzNOERa9
         ENrUdEfx3xB0slB6pA0Fkp5gzpgyVk/NVtjd2YuiCQRAN67gXxwuVrDRKYr1aoebJK9Y
         4DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709871230; x=1710476030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw7ZbqEsiKihQ0Zm7edjlrJvRegrpau9dDzQ/T5cB8M=;
        b=BNe08TK51FOq7Jl5beuWOdPvq/73BKcpLIyxHefqph2KCGr+lTHlxEkFKXNIWbCYhd
         +wAf5K+39I8vJjPWtL/6bd46sH2eVJHErdYRsX69RMY5cLUbREENHbTZSmsV+McBqJK9
         QA/FlJgwgLLmf3I+LwJL3WIl9UpJza0KFl+zZzc35aroMjDaKy6yKT/Ceu3mj9CEFWZP
         Pnntm/8LnNut2AAYb93R5GwnVxxe7Z70WK0PQus2M0fpkzdGjNEA8LHID0FWlf5XNRVq
         bRgXWzsL8oYzqvAB60UJK42eke6FNAYgb6yD2uEEsGrMLt5rBGBXqG5N8EKN4NCmfU42
         8Otw==
X-Forwarded-Encrypted: i=1; AJvYcCWSaQbRlqeba4lNUcqHyEdNTOrVVhAPB1qUhMp3zoZ1VK0JLUkswXToZAx4lMU5QV7VylgJadvRwJJJCONQPR1a5FMX0lgXYSq1Klt6
X-Gm-Message-State: AOJu0YwoZH+PPDjK5UDssek0vh3T7oh5y98bnjJzXrLKIyAN9dn+Ho18
	Gn/GNG2z3VzoVdkqilfSSW0FxTMoMYKHVrmOanUZ8n7VCJ/dTo8HqKHgUSnIENTSUGN8BrtwFBR
	1sA==
X-Google-Smtp-Source: AGHT+IHadk63LQKc3OCg8CRe/y357x5bfyVRGi/E1H1s9xoMbsvXCiATXb0+tHK5W2MkF7MKY4NvFWSsH+g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3508:b0:608:4cec:3e65 with SMTP id
 fq8-20020a05690c350800b006084cec3e65mr4524747ywb.5.1709871230577; Thu, 07 Mar
 2024 20:13:50 -0800 (PST)
Date: Thu,  7 Mar 2024 20:13:10 -0800
In-Reply-To: <20240228101837.93642-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228101837.93642-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <170987090131.1157339.1162545682759176638.b4-ty@google.com>
Subject: Re: [PATCH 0/3] KVM: x86: Fix KVM_FEATURE_PV_UNHALT update logic
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Li RongQing <lirongqing@baidu.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 28 Feb 2024 11:18:34 +0100, Vitaly Kuznetsov wrote:
> Guest hangs in specific configurations (KVM_X86_DISABLE_EXITS_HLT) are
> reported and the issue was bisected to commit ee3a5f9e3d9b ("KVM: x86: Do
> runtime CPUID update before updating vcpu->arch.cpuid_entries") which, of
> course, carries "No functional change intended" blurb. Turns out, moving
> __kvm_update_cpuid_runtime() earlier in kvm_set_cpuid() to tweak the
> incoming CPUID data before checking it wasn't innocent as
> KVM_FEATURE_PV_UNHALT reset logic relies on cached KVM CPUID base which
> gets updated later.
> 
> [...]

Applied to kvm-x86 hyperv.  I won't send a pull request for this until next week,
but I do plan on landing it in 6.9.  Holler if the selftests tweaks look wrong
(or you just don't like them).  Thanks!

[1/3] KVM: x86: Introduce __kvm_get_hypervisor_cpuid() helper
      https://github.com/kvm-x86/linux/commit/92e82cf632e8
[2/3] KVM: x86: Use actual kvm_cpuid.base for clearing KVM_FEATURE_PV_UNHALT
      https://github.com/kvm-x86/linux/commit/4736d85f0d18
[3/3] KVM: selftests: Check that PV_UNHALT is cleared when HLT exiting is disabled
      https://github.com/kvm-x86/linux/commit/c2585047c8e1

--
https://github.com/kvm-x86/linux/tree/next

