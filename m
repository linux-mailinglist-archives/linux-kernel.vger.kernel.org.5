Return-Path: <linux-kernel+bounces-82600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098908686E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18751F216BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EE154BE4;
	Tue, 27 Feb 2024 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzwC5LgQ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AD554BC3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000517; cv=none; b=mb/GQRPY4l65Tm3RsZcb2L7YLxHA8BycI9xwccVp99InkCPY4xEnrw9MQNQLkA6q2JrN14qP0Jq/BPOALRa2BGutS+wQbdS9XagMLmaemAafzB692lG8ntccn7Ub9tlenUSirSnl3ZJaMPEwvJleCweC45K81r03wX2h/qrAvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000517; c=relaxed/simple;
	bh=SP3wECQuNsGizvBDLcQeElF0hhZLPHhC3anTjy4uCjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DfX+iYofFqO+u1+anBqirtYUUEEIOnBaT56lDaeigaGCreZGXRNkxWw1e1vZjMlaIRwc9oRTcPJ2ugA4H2+FeTCBlwsQj81iYusIoK0/suUtvdsl3ekvBRC4VJzCz1L884afwMWCYXK9J4h9i66Wip+YdmaXXm4/qcECW0IcIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzwC5LgQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60925cacbb7so4050887b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709000515; x=1709605315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gD/GJ68X0cVQGr5FjGXj7WBsDK+In0culAJ288XBYzk=;
        b=IzwC5LgQTEaLnY8mA9DN+WrSuS9nT+RJnDbNcQ7JeVTwIKnzzQG3xthKYAWQv85AZr
         wsvElYD70g09r9mszAQ3aD7QlggVoBvwZEUcDInU2HFPjFneCBZqwdNCyPgWM0v3/3Vl
         ESs484eOh4pfSBsvpN90oE0eth8LHDVs//fp9LFXsrI+EVqFhN8ptaJfGYYgZlwdBk4M
         8FMoYF8gmprX93JkSgCufwHKxI252tfqZinv7TDE4IRs3hgldEnzYV78Ikeiwy4sRXXQ
         zkMbZbCc/Tzm85/uwSdPlTqv9QQLqCyptaf9Q6ZaiiXtSbe18q3DmV/d6qUCelx89/iK
         Uo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000515; x=1709605315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gD/GJ68X0cVQGr5FjGXj7WBsDK+In0culAJ288XBYzk=;
        b=naVHOl5qxCFvuuAUtBg1bdBujkwi3F4ikWOAbOgXQNv1jxa+x7QEpYirxzxXpCDmyn
         YwigaMhw+cL1wgCmcS3UHTKfFLfMYMe+5xU2dzl4bSXN8PzEv3d4JV2neLfqDc3/NjU2
         ljPYrTvG+zQfnZH25H/jAC5FWN5yO195IJlnk1hRdCssqFPk4gXAhqnH48RsBZ0/2l7d
         GbKriFC1P9HM9nTSzy/SCmdPPKnwA05OSeZZsjXiptdIRdLTAVdXw+OrMGQ4RnkIwKrY
         j8afrxoV4OC1z0+kB7A0i98P2OCZwE8b4ST1CwsrIeB3jk53If3neZwuPSODx6aZrhP7
         jq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXihNJwRJ6ZUsKKXmkvKKCVF3rF0nRDQVEd7+zvGlTsx9Qam1QJv/0/12cy4zdQj8yHTc9/hzcyct+1/gxX51zqTwrqBftwhlBHnUdx
X-Gm-Message-State: AOJu0Yw+is/GLS2+s7iSQSlA2QrtO50kE/yEubgWb008H7+IC4qWL/NE
	aP9Hx6lAVntb/VP11RrYabwbfMd5SwdwZq+D4rm/SPNcg3H5xw7HbV3SnmrSWbb1CXT1S2+U2h4
	QKQ==
X-Google-Smtp-Source: AGHT+IGySX71rsoZHQXEKCFWAzA8N1hjTbbEs4eGPFYiN/yqiIDehY1AvBVxznlEWhqTc915C808bTjpV/Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:84:b0:609:1fd9:f76 with SMTP id
 be4-20020a05690c008400b006091fd90f76mr201794ywb.0.1709000515502; Mon, 26 Feb
 2024 18:21:55 -0800 (PST)
Date: Mon, 26 Feb 2024 18:21:12 -0800
In-Reply-To: <20240208204844.119326-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208204844.119326-1-thuth@redhat.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <170900036555.3692027.1057525433723685864.b4-ty@google.com>
Subject: Re: [PATCH v3 0/8] Use TAP in some more x86 KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 08 Feb 2024 21:48:36 +0100, Thomas Huth wrote:
> Basic idea of this series is now to use the kselftest_harness.h
> framework to get TAP output in the tests, so that it is easier
> for the user to see what is going on, and e.g. to be able to
> detect whether a certain test is part of the test binary or not
> (which is useful when tests get extended in the course of time).
> 
> Since most tests also need a vcpu, we introduce our own macros
> to define such tests, so we don't have to repeat this code all
> over the place.
> 
> [...]

OMG, you didn't tell me this allows sub-tests to run after a failed test!
That alone is worth the conversion :-)

There's definitely a few enhancements we'll want to make, but this is more than
good enough as a starting point.

Applied to kvm-x86 selftests, thanks!

[1/8] KVM: selftests: x86: sync_regs_test: Use vcpu_run() where appropriate
      https://github.com/kvm-x86/linux/commit/e10086285659
[2/8] KVM: selftests: x86: sync_regs_test: Get regs structure before modifying it
      https://github.com/kvm-x86/linux/commit/221d65449453
[3/8] KVM: selftests: Move setting a vCPU's entry point to a dedicated API
      https://github.com/kvm-x86/linux/commit/8ef192609f14
[4/8] KVM: selftests: Add a macro to define a test with one vcpu
      https://github.com/kvm-x86/linux/commit/992178c7219c
[5/8] KVM: selftests: x86: Use TAP interface in the sync_regs test
      https://github.com/kvm-x86/linux/commit/04941eb15439
[6/8] KVM: selftests: x86: Use TAP interface in the fix_hypercall test
      https://github.com/kvm-x86/linux/commit/69fb12492005
[7/8] KVM: selftests: x86: Use TAP interface in the vmx_pmu_caps test
      https://github.com/kvm-x86/linux/commit/200f604dfd07
[8/8] KVM: selftests: x86: Use TAP interface in the userspace_msr_exit test
      https://github.com/kvm-x86/linux/commit/8fd14fc541c7

--
https://github.com/kvm-x86/linux/tree/next

