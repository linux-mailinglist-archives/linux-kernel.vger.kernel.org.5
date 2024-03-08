Return-Path: <linux-kernel+bounces-96496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E325875D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0534281EEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB252C84F;
	Fri,  8 Mar 2024 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ak0/tgLA"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADF2C692
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 04:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709871187; cv=none; b=u2/QtIgeOWsjHIj8w1eDJiyO8xo1BWXbdnm4EctJDzlQcEzW9+LS7+MKX1Ccn8nHbemVhgBTuiprcRfEh3bT9oZp0M8cGG29rCkqgtuKaoDuBy29IenXuYS4kLyaIse6ijqP++Vt3Vt/7Td5AITSGf1qSFa8phiDgsOI20kv8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709871187; c=relaxed/simple;
	bh=AeRpt4+v7cCy4+3vCNw96MLNgKrnO8fJH0hMxbx69gc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jzPlSAnBjpclkC4Zkl1rXvIV1/ENlrcvLPn4xtDmw1UfDhh/tuKpVXlZZsatwdfpTEqjIsAWKKlqtEM/bU6IDrLPS1IvGR3ZWHO0P523wtp03HySGBP2SlJXbYP4xMpAWYF+JD/+y9Q4bod0tQQtsNlZQ9zS7ICiGmoXfNhR6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ak0/tgLA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso840752276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 20:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709871185; x=1710475985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mj63hagGLUMaRYk2iLjbA9QcmRz0KuPSTj9KjO2msrI=;
        b=ak0/tgLAtj2ROpUaeY7Lt7BBVMHnfrlK3XEvyV6xhqW0pSe6x5mxjhTpn0XxMmNNEc
         R4c/BtRMrbIUQpiocGrzvhtTF6zkHX3u73HDq6rAUW8uRgAaiMQ9jgNY1z4JCgynHENe
         Ge3tKlCYHhnC80reEyWEG/FkWGgTYD7Wt+9n7KaBDpzjrU+Z/x0JrganW/T5mYF1n8b2
         gFz0ZEhopWZhp7esQhK7sUMoJJGZUBsSywgLlsapVr/eYOFzBeio5k3V7VFfv/p/U+xl
         jYBcLVRWz78MWsrWefOuitcvsbbjGOLQn8cID5weXJ7wdqpcDfTwwIZ9HS9Ptve2vcQt
         qtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709871185; x=1710475985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mj63hagGLUMaRYk2iLjbA9QcmRz0KuPSTj9KjO2msrI=;
        b=P8HivnjqF45gB6xHh4ycBLqRKmP/UZTxUrwfJhAfwJez2oMQJH0Ow+Hn+6SNRUvKHe
         Q5KW3nFIgkqJ3aeQ1FyxYbrT899GCXnBYYKnLSKVSYuePVUUBhqMmUytsPbZr+hz21Em
         XZjnrIf4kX5jVviNPJ/lXwCGGxrhkKXj5yTmIrKXwWfHgotGQCeOsfJF5YEY+qDahis7
         LNVL4vfKdTKxgrssMNBtF2JKwG7MH3gJ/cFLuiSkqcicvJZe4HPPiukTxw90+NIovG9x
         yFIup5V5cPK3/rFwXjU8mXXz3IWt5WJY0L5MbuP7vR4RTA2p1/IcBc4KTclfTdrRSIqq
         nZgA==
X-Forwarded-Encrypted: i=1; AJvYcCW32eHf5qgQ+eBsbhcaqCyflJ4eZkSky9ypUKpJ7ZQ3bPLfNMFhoVSf0pTgS0RYJjgjbOWOezpZmve/f5vWC1dggz9WlrXC9mV7boTQ
X-Gm-Message-State: AOJu0Yy/zG4IZqDIFgHlMV2rnbdpXel6I0TeRla+449fNUsTa2sALKku
	Pp5ctXPG85PsSo5Cfhmgc9zX9fHanQmDoivXNMtu3IJPS1E+a47D67wXckNNVLSRD6nCoBoTbiu
	V9Q==
X-Google-Smtp-Source: AGHT+IEEzQKCqmCDgLT7slyDa1v6F8u3g8HNWFIIE1LiLMSBqXiq/ENpKvqqF6yQ6FhTMbffx8puphwC7fc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ce82:0:b0:dc8:5e26:f4d7 with SMTP id
 x124-20020a25ce82000000b00dc85e26f4d7mr5153882ybe.13.1709871184930; Thu, 07
 Mar 2024 20:13:04 -0800 (PST)
Date: Thu, 7 Mar 2024 20:13:03 -0800
In-Reply-To: <20240228101837.93642-4-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228101837.93642-1-vkuznets@redhat.com> <20240228101837.93642-4-vkuznets@redhat.com>
Message-ID: <ZeqQT1DAxnji75KZ@google.com>
Subject: Re: [PATCH 3/3] KVM: selftests: Check that KVM_FEATURE_PV_UNHALT is
 cleared with KVM_X86_DISABLE_EXITS_HLT
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

Shortlog is a wee bit long, I went with:

  KVM: selftests: Check that PV_UNHALT is cleared when HLT exiting is disabled

On Wed, Feb 28, 2024, Vitaly Kuznetsov wrote:
> KVM_FEATURE_PV_UNHALT is expected to get cleared from KVM PV feature CPUID
> data when KVM_X86_DISABLE_EXITS_HLT is enabled. Add the corresponding test
> to kvm_pv_test.
> 
> Note, the newly added code doesn't actually test KVM_FEATURE_PV_UNHALT and
> KVM_X86_DISABLE_EXITS_HLT features.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

..

> +	TEST_ASSERT(ent->eax & (1 << KVM_FEATURE_PV_UNHALT),
> +		    "Enabling X86_FEATURE_KVM_PV_UNHALT had no effect");
> +
> +	/* Make sure KVM clears vcpu->arch.kvm_cpuid */
> +	ent = vcpu_get_cpuid_entry(vcpu, KVM_CPUID_SIGNATURE);
> +	kvm_sig_old = ent->ebx;
> +	ent->ebx = 0xdeadbeef;
> +	vcpu_set_cpuid(vcpu);
> +
> +	vm_enable_cap(vm, KVM_CAP_X86_DISABLE_EXITS, KVM_X86_DISABLE_EXITS_HLT);
> +	ent = vcpu_get_cpuid_entry(vcpu, KVM_CPUID_SIGNATURE);
> +	ent->ebx = kvm_sig_old;
> +	vcpu_set_cpuid(vcpu);
> +	ent = vcpu_get_cpuid_entry(vcpu, KVM_CPUID_FEATURES);
> +
> +	TEST_ASSERT(!(ent->eax & (1 << KVM_FEATURE_PV_UNHALT)),

X86_FEATURE_KVM_PV_UNHALT already exists, all we're missing is a helper to get
a CPUID feature from host userspace given a vCPU.  I added this

	static inline bool vcpu_cpuid_has(struct kvm_vcpu *vcpu,
					  struct kvm_x86_cpu_feature feature)
	{
		struct kvm_cpuid_entry2 *entry;

		entry = __vcpu_get_cpuid_entry(vcpu, feature.function, feature.index);
		return *((&entry->eax) + feature.reg) & BIT(feature.bit);
	}

and used it in this test instead of open coding the reg+bit.

