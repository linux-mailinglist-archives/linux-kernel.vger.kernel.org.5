Return-Path: <linux-kernel+bounces-40625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A0A83E35A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636AEB24273
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5196C2374A;
	Fri, 26 Jan 2024 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbrIcWtj"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C322EF6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300745; cv=none; b=Fi5LG1o5sGXNu2vD1b5fGkWagSeiPykE55pY4SqVyKkEZxwHKtsh7sf6HQZyX/8S4mAtIp1VpIOs6OHvLQU9yzaQA6dj5XHiEq65uwmi2H9/LLfDwg8GkUYQdT9OM3nOiw68kHAWeukK9QDu5isNrfqGeP8Df5iQf21yA16/IDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300745; c=relaxed/simple;
	bh=3cIgTjRr4HktkHh94CWSDggXBSkYHF5KchgT06kgK8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R3PY4ZDb8ed0CZbS+FnasSef6eW4sf28pCvKYJHyDsDkJ/s1hTLph8/LVAwT32y7FeJ7OXu39mYR098J4fErtBLy7FfOm6Y8zbCBPQHyC7R5NtFM/YELidZlTLPMe9kOB5SdX+azlIGdeiKukHGwIyRCx7MfzaX8gRUYeweZyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbrIcWtj; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5ce632b2adfso908141a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706300743; x=1706905543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz9w/MGSJCfVJoFxXdjwOXlp0YlOCXLVVNfaqF8/1eE=;
        b=mbrIcWtjdN77LO/573eRyQAH0VvCYfhC2nHyg6CIIcd69DwESQE6AUgI/tdyWfm7Px
         kAEYrjAlkdSeoAhVh80jS2goOcyWynSzTQ5sao0qHBnC/M3joZhi4oyYVifix4NM9VAW
         Q0EnPDSVUZCo8r1scxBMJZ+CBSt7Oh678NZhExGxOf2YeI3dgh71xr35XdrEWYunCKCy
         P9f0NOHtbkEWyyXnoPwpkZ/WfJhJbWVTjbS/0k8rwa8v/u5vMXn66EVsFtM0A4f1UVrP
         GVo2lx6TdiQ1FeWl+lU1blCBMyMrg9UDs/HZZjzFJd+7WV+ZC3gQ5Ozi5FrJ41/+x8U1
         tEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300743; x=1706905543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz9w/MGSJCfVJoFxXdjwOXlp0YlOCXLVVNfaqF8/1eE=;
        b=ttoYy8o7q7OxhW99mc6jcjCDdyGVEFyUgFMJPhW46B/1eNKuYVD9NVLe7BWlG45Jl8
         0xvmz36FvhG6PGHnGd27BA27FFcKEztrlmEzkE8fVY1lW2Cej0EVE+Z1t1twhMA2IDe1
         ILpndSmqjRzHBBJgTL1A0e+CuQgpk5+x1tntRMydEs7KaZ9bm7dXWtwRFkXU88jd55KH
         o22xBNZQU1hBptxELz5L79zGQDSREThJbmBFpXzKjg8PwAxjXWHkcu4RCI916m2oNO1x
         wrfOT0KS7Y9wqw7B3qdBpuImjBY7BS44Oiw/LMnKUfYr8ZjYWOBE9E3jbxN9NeSPiDi8
         jNuQ==
X-Gm-Message-State: AOJu0Yx3PxSl9v3vNeyQvzENQiUkBGxfE0EdT13L++G+2eoyq7EFK0WO
	O6/L27cT7XzuAeyzATJsk3JKcICzkQgok/WctnMbSiMPfqqJsr9QOk29/j5p1nN9DAS0M0tuAF2
	O3A==
X-Google-Smtp-Source: AGHT+IF3uGps9y8JiME3Q7HhNRDpz9fB3O2K5T+wbXcJt2yNTs/tyQVPf6ztalhofyaP4n1VGV7ie9wiTj0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:78a:b0:5d7:97b9:3084 with SMTP id
 cd10-20020a056a02078a00b005d797b93084mr2394pgb.0.1706300742964; Fri, 26 Jan
 2024 12:25:42 -0800 (PST)
Date: Fri, 26 Jan 2024 12:25:41 -0800
In-Reply-To: <20231117052210.26396-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117052210.26396-1-shahuang@redhat.com>
Message-ID: <ZbQVRX3V1P-ZE2Wf@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Fix the dirty_log_test semaphore imbalance
From: Sean Christopherson <seanjc@google.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="us-ascii"

+Peter

On Fri, Nov 17, 2023, Shaoqin Huang wrote:
> When execute the dirty_log_test on some aarch64 machine, it sometimes
> trigger the ASSERT:
> 
> ==== Test Assertion Failure ====
>   dirty_log_test.c:384: dirty_ring_vcpu_ring_full
>   pid=14854 tid=14854 errno=22 - Invalid argument
>      1  0x00000000004033eb: dirty_ring_collect_dirty_pages at dirty_log_test.c:384
>      2  0x0000000000402d27: log_mode_collect_dirty_pages at dirty_log_test.c:505
>      3   (inlined by) run_test at dirty_log_test.c:802
>      4  0x0000000000403dc7: for_each_guest_mode at guest_modes.c:100
>      5  0x0000000000401dff: main at dirty_log_test.c:941 (discriminator 3)
>      6  0x0000ffff9be173c7: ?? ??:0
>      7  0x0000ffff9be1749f: ?? ??:0
>      8  0x000000000040206f: _start at ??:?
>   Didn't continue vcpu even without ring full
> 
> The dirty_log_test fails when execute the dirty-ring test, this is
> because the sem_vcpu_cont and the sem_vcpu_stop is non-zero value when
> execute the dirty_ring_collect_dirty_pages() function. When those two
> sem_t variables are non-zero, the dirty_ring_wait_vcpu() at the
> beginning of the dirty_ring_collect_dirty_pages() will not wait for the
> vcpu to stop, but continue to execute the following code. In this case,
> before vcpu stop, if the dirty_ring_vcpu_ring_full is true, and the
> dirty_ring_collect_dirty_pages() has passed the check for the
> dirty_ring_vcpu_ring_full but hasn't execute the check for the
> continued_vcpu, the vcpu stop, and set the dirty_ring_vcpu_ring_full to
> false. Then dirty_ring_collect_dirty_pages() will trigger the ASSERT.
> 
> Why sem_vcpu_cont and sem_vcpu_stop can be non-zero value? It's because
> the dirty_ring_before_vcpu_join() execute the sem_post(&sem_vcpu_cont)
> at the end of each dirty-ring test. It can cause two cases:
> 
> 1. sem_vcpu_cont be non-zero. When we set the host_quit to be true,
>    the vcpu_worker directly see the host_quit to be true, it quit. So
>    the log_mode_before_vcpu_join() function will set the sem_vcpu_cont
>    to 1, since the vcpu_worker has quit, it won't consume it.
> 2. sem_vcpu_stop be non-zero. When we set the host_quit to be true,
>    the vcpu_worker has entered the guest state, the next time it exit
>    from guest state, it will set the sem_vcpu_stop to 1, and then see
>    the host_quit, no one will consume the sem_vcpu_stop.
> 
> When execute more and more dirty-ring tests, the sem_vcpu_cont and
> sem_vcpu_stop can be larger and larger, which makes many code paths
> don't wait for the sem_t. Thus finally cause the problem.
> 
> To fix this problem, we can wait a while before set the host_quit to
> true, which gives the vcpu time to enter the guest state, so it will
> exit again. Then we can wait the vcpu to exit, and let it continue
> again, then the vcpu will see the host_quit. Thus the sem_vcpu_cont and
> sem_vcpu_stop will be both zero when test finished.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
> v1->v2:
>   - Fix the real logic bug, not just fresh the context.
> 
> v1: https://lore.kernel.org/all/20231116093536.22256-1-shahuang@redhat.com/
> ---
>  tools/testing/selftests/kvm/dirty_log_test.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index 936f3a8d1b83..a6e0ff46a07c 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -417,7 +417,8 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
>  
>  static void dirty_ring_before_vcpu_join(void)
>  {
> -	/* Kick another round of vcpu just to make sure it will quit */
> +	/* Wait vcpu exit, and let it continue to see the host_quit. */
> +	dirty_ring_wait_vcpu();
>  	sem_post(&sem_vcpu_cont);
>  }
>  
> @@ -719,6 +720,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	struct kvm_vm *vm;
>  	unsigned long *bmap;
>  	uint32_t ring_buf_idx = 0;
> +	int sem_val;
>  
>  	if (!log_mode_supported()) {
>  		print_skip("Log mode '%s' not supported",
> @@ -726,6 +728,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  		return;
>  	}
>  
> +	sem_getvalue(&sem_vcpu_stop, &sem_val);
> +	assert(sem_val == 0);
> +	sem_getvalue(&sem_vcpu_cont, &sem_val);
> +	assert(sem_val == 0);

Never use bare assert() in selftests, they'll either get compiled out or IIRC,
will cause the test to silently exit if they fail.  Either do nothing, or use
TEST_ASSERT().

> +
>  	/*
>  	 * We reserve page table for 2 times of extra dirty mem which
>  	 * will definitely cover the original (1G+) test range.  Here
> @@ -825,6 +832,13 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  		sync_global_to_guest(vm, iteration);
>  	}
>  
> +	/*
> +	 *
> +	 * Before we set the host_quit, let the vcpu has time to run, to make
> +	 * sure we consume the sem_vcpu_stop and the vcpu consume the
> +	 * sem_vcpu_cont, to keep the semaphore balance.
> +	 */
> +	usleep(p->interval * 1000);

Please no.  "Wait for a while" is never a complete solution for fixing races.
In rare cases, adding a delay might be the only sane workaround, but I doubt that's
the case here.

