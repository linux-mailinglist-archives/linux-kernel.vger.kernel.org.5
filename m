Return-Path: <linux-kernel+bounces-130251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0473D8975EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D341C26039
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C246715253E;
	Wed,  3 Apr 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icAdKWSy"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174A152513
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164051; cv=none; b=IAkF98IWvJW9RSOtN73CnjOqL+lUNhM/v6Ngk+RHcQQKWmjQMnOKlvn1J8iR9ArflYR+O1GOAHJCSqghVcruLCI0zQ7A0+OrOtlLWX5rnzpawyeOG5Vfijhq5MBPK1F6XMWzr8a3X3ihqfd190ZvWHRkBoAQxhZyfU/uGufi0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164051; c=relaxed/simple;
	bh=gX73Fd71Hr9LdsAlOuJUtvzibpHcNhprefVg3paVgDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h2x9Tm3/UNaw4Ir2DQ0zEpzmzjUQzNtj9FWNInjXtV4b/l2G2VTqZDhbO1rbbSjTVLMFTgdvQ+PHss273BiqGrL1b9k+YVCR4QV7XftzMFtnYTaJ/15SpDow5fdCTXSFnO+zW9k2W4be/cq/+qDz4KPTS78Hofs8P6BZt6/Fe1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icAdKWSy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so190328276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712164048; x=1712768848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XE+PG9zC5omixfQJghjjzCZLVaoeIvGmD0Or6PABHlQ=;
        b=icAdKWSyvRSCf9tjeMZICzYfOPKdz7214hlszOGzL3yil1XhYOI6qzpm+L5C/GlbgU
         HxmMQ5p2emVaMg8FcbzMm6pP7bW78qD+Fq2q7Hz8wV46dD82aR3fxYUMHwPdB8pndLtv
         mC6NW/gk6qcTmiY42o303NuW8am9UoAB6C7b5PSMS/J/NqMXzC2gDiORn3YKbzpc0A1g
         nMmj5abcLp0OPXyK/6TXRpk4juXZl8ITDpsqTdWMHxFiKqZ4A3jzPV8l4a/Y7L1t3vdh
         Ev2jE1BXQzb9+0PXKyzuiMhzEoW6qj496yA8Va49UXaAq2MjZPFEgO2rrqfQbZpb1MjD
         EMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712164048; x=1712768848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE+PG9zC5omixfQJghjjzCZLVaoeIvGmD0Or6PABHlQ=;
        b=qBzvgheeAzJ4W5Tptisz26CyBuNnV6QR4fxXNFsGogZa1PCZv3DHNtQU5TjybXVdmD
         aQW+l0OPOPYbrZGZviTFVcbofNVxVFjUA+4Vfo16ynXFvtltEebc0PFSjJZ7soAh2eUd
         ZRcIT+XnGnwdqC7+Poi5Kd1yNY/IxA6ISVBqzqxRf+KvtOaIcJp2xxH5KN85dXtVZoeH
         jqoBqvRU2p4QQZc+wd3XqGgm9uijyyCM0G1S8xk/CVg4CTn9gVL4IPRy3MYdLNgHnJc3
         dC/U2mw0vm7ghsQ3b0Slq0nLXeTFwW27RWBVDuGsfMazvgm/vzOXuIuBJY0acbH7+uv+
         6mUw==
X-Forwarded-Encrypted: i=1; AJvYcCU3B+Lm/ZHdKuF7fSxMSn+yENS59+dKZAcl51uo6m4Q9PqjIA4AiPAuWXNS9IZJdLS/f3aHXM51plQ2HFYksKckRezsn2MKF3j85FHJ
X-Gm-Message-State: AOJu0YyM8wYTrVfBlrvtkN+PUcPFysgLdczx3Vre4t9Jg6srnx1Ec7nq
	gbDgu0DvVzUpVvS+cKvnxvpdEJbh/HI0DdZ/xri+pEd1uv6hFGY/ciAwXdcLbLtJPqrpuaM1TUM
	WiQ==
X-Google-Smtp-Source: AGHT+IGJ6fjY3qPzfcuQ+Uj01adGJDcVM5deoqEJfvQ1/h41CQ3qzBzMvVGNTIzpPWuDCJzxpn4gGWghwiI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1005:b0:dc7:48ce:d17f with SMTP id
 w5-20020a056902100500b00dc748ced17fmr10456ybt.10.1712164048738; Wed, 03 Apr
 2024 10:07:28 -0700 (PDT)
Date: Wed, 3 Apr 2024 10:07:27 -0700
In-Reply-To: <20240403164230.1722018-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403164230.1722018-1-rananta@google.com>
Message-ID: <Zg2Mz5ZcF6cO9Ipr@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Fix build error due to assert in dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Sasha Levin <sashal@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 03, 2024, Raghavendra Rao Ananta wrote:
> The commit e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in
> the dirty ring logging test") backported the fix from v6.8 to stable
> v6.1. However, since the patch uses 'TEST_ASSERT_EQ()', which doesn't
> exist on v6.1, the following build error is seen:
> 
> dirty_log_test.c:775:2: error: call to undeclared function
> 'TEST_ASSERT_EQ'; ISO C99 and later do not support implicit function
> declarations [-Wimplicit-function-declaration]
>         TEST_ASSERT_EQ(sem_val, 0);
>         ^
> 1 error generated.
> 
> Replace the macro with its equivalent, 'ASSERT_EQ()' to fix the issue.
> 
> Fixes: e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

Just to be super explicit, this is specifically for 6.1.y.

Acked-by: Sean Christopherson <seanjc@google.com>

> ---
>  tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index ec40a33c29fd..711b9e4d86aa 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -772,9 +772,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	 * verification of all iterations.
>  	 */
>  	sem_getvalue(&sem_vcpu_stop, &sem_val);
> -	TEST_ASSERT_EQ(sem_val, 0);
> +	ASSERT_EQ(sem_val, 0);
>  	sem_getvalue(&sem_vcpu_cont, &sem_val);
> -	TEST_ASSERT_EQ(sem_val, 0);
> +	ASSERT_EQ(sem_val, 0);
>  
>  	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
>  
> 
> base-commit: e5cd595e23c1a075359a337c0e5c3a4f2dc28dd1
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

