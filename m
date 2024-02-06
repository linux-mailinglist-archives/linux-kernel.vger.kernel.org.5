Return-Path: <linux-kernel+bounces-55633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35E884BF49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119831C23511
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61A1BC30;
	Tue,  6 Feb 2024 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dA9es1Wr"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FB01B957
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255392; cv=none; b=k0kBylbE8ImIpS9ejmCwOvvfwuVKAI9/y9lToWNo5lo3fzKKzWM4ygaRSP03o9loQMRnxSsF8D2u0NH8qxz/74QJYeCVYoxUJaVy+TVBngyriG7M8+TlQGwSRUIyEQpJLLSr/LNpbEMjSCudZMUOWiDMOYAD23iKiNUj9sIegYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255392; c=relaxed/simple;
	bh=NkDlqApIbTfwx3Q1RSxj4xs5tlfBlWOTaY+5f+NNjb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWtbNR1F/ITZfcULQoTBqdgFFQJnjXw4zvgUYnpsfL2E59k7n8W/GYaIxdpdRrNUQkGHDJay0PSZMFNVMNGnIIpUtA29n4yMhgrru3kFHbeZ0l3gGQNsLWjpBj975bkKUUMG98eoYZ0wnwnTp2CsTaWMVcCSJ9KCEKu/8FmG6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dA9es1Wr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso10149052276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707255390; x=1707860190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=er4oE/byCTH2PRrgRT8tuMj9OpU5LggotG3s4/YchRI=;
        b=dA9es1WrPe7qht8Jx6qRUX7+5FDHwzF3tqdh9VjrtNiomSQ0psm1MMSGy3WKbd6fHf
         HgT/U0RTPsLCG7UTeSVzJtSJ6Z4Qd9ne0rOOSYeb9Y/+UyoY2GqfVk3npeDqpHxZ8zu/
         bWIJy8QZ3fIThLuehK3605XZENL/waCTma7pdCZvmquA2uqqfTBzI8awB6cOY5bV4bQU
         lnOnlgpKSDAELfrTV0zg/I5KZRFsP3qwAxaRqM4z74Wz572+qYJbUf6Tk6fIUNlFnPZf
         cWl4vRzBh8n1MgaZHMT0hlX/9iml+uivADVoJXdRemvXzn4ZERjVfXauuhxGdFtsChuZ
         eLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707255390; x=1707860190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er4oE/byCTH2PRrgRT8tuMj9OpU5LggotG3s4/YchRI=;
        b=TYJXcpCZbZZj2K5ns7CTLslp0D3nEgL2GVJk39i2c5J0gUDSMb4FD9NzANyeysEA7h
         TAN/lvQNrM+OLtBbYOuywex25JGGNMI0DSC8Cgg2Lpj/gSiZDu4AZE+AVUO8itIM3mbE
         I3z7Vi1veflzJMVPPLX1Tvm5py/EXG/Ox33jpyg9rkyvs1npZ9FC9VhQdIG+6OR3axM9
         /cdNpUNp188OIBBYAfC1qqVakBLCA/Bd78mNEdrWMXYkvhuWCc004qoTd8KZYKg4xYoR
         ij5pYnGXFyL7d+kNRoNSJdq6VyBnbG4HcJXtiEY2+4DlS8p9IflA0nj4UD1cUNDkN97k
         PjWg==
X-Gm-Message-State: AOJu0YyumIcrIXwtE+x9BcwjBeWkQj6PqMutCjxlaToqTyP7qqTmRQlG
	w2kCtVwsm3bmxt/gY+Sa0MYWCY+i4b7da0Jn9RWI3t++uaRz+pmqQ4XEaa0Nws1GnrpDBqEZw68
	0UA==
X-Google-Smtp-Source: AGHT+IHbFKc60lW+DAkcEqscHHtO+r3Bnf2mdnvF6kofoTO7sYjN4rOcax4DQFP874+yPL+DD8xNMyJ0twg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:98f:b0:dc2:4d91:fb4b with SMTP id
 bv15-20020a056902098f00b00dc24d91fb4bmr742512ybb.9.1707255389965; Tue, 06 Feb
 2024 13:36:29 -0800 (PST)
Date: Tue,  6 Feb 2024 13:36:11 -0800
In-Reply-To: <20231025055914.1201792-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231025055914.1201792-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <170724645418.390975.5795716772259959043.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] x86/asyncpf: Fixes the size of asyncpf PV data and
 related docs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Wanpeng Li <wanpengli@tencent.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 25 Oct 2023 01:59:12 -0400, Xiaoyao Li wrote:
> First patch tries to make the size of 'struct kvm_vcpu_pv_apf_data'
> matched with its documentation.
> 
> Second patch fixes the wrong description of the MSR_KVM_ASYNC_PF_EN
> documentation and some minor improvement.
> 
> v1: https://lore.kernel.org/all/ZS7ERnnRqs8Fl0ZF@google.com/T/#m0e12562199923ab58975d4ae9abaeb4a57597893
> 
> [...]

Applied to kvm-x86 asyncpf_abi.  I'll send a pull request (for 6.9) to Paolo
"soon" to ensure we get his eyeballs on the ABI change.

[1/2] x86/kvm/async_pf: Use separate percpu variable to track the enabling of asyncpf
      https://github.com/kvm-x86/linux/commit/ccb2280ec2f9
[2/2] KVM: x86: Improve documentation of MSR_KVM_ASYNC_PF_EN
      https://github.com/kvm-x86/linux/commit/df01f0a1165c

--
https://github.com/kvm-x86/linux/tree/next

