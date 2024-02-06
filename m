Return-Path: <linux-kernel+bounces-54535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD1384B06F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2BB1F264BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090612CD96;
	Tue,  6 Feb 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ud0wWkc1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E512C81A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209661; cv=none; b=OingwLRpLfsW9gAgSXHxv7bGb19F2bo+gHGr3s2TxtzZBnhOzC8WO5YOdz5DgfTJUxKR4p1jAhH1IaWelf9ZUMGT1oNO1X3XCxj2pnJps36SKhUrWTjUFSGD1G8vCvHy764e0yZ/MeXd3l19+fkbokKynKxm+9a3TZmeYahryMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209661; c=relaxed/simple;
	bh=aazENfqtOUGTlV9wdum2yY1QQawhdPN8d0nGlVzMOS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLCs08EVrHK8oOTF11e6PzjOQcG1VH6aAV7tcQvw4Ab3HW8QG+PjeQl9PgnXAr9K/pQSV0RQ66mPTy9xUH9P0LOlVv3fszl/i7QsKDp6W8PzGGHDNLDouM2uYAxz3GA9oCMKI9dApe70UT4GY8pO5/jwYeHS/InVXOdAePHuKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ud0wWkc1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707209658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6jeTGXlTgd7sq1RCPaLQ4vJaHshuSOrnrjXVHXXGG4=;
	b=Ud0wWkc1XwQBZo+G1X9y+lql8koybpfgy+QmpknIZ5Sth1r8cCoOSz+7wi09U/1TgMHWTJ
	E2nFEnrqeNhdhwXvc392tN1Neiqjw9vqqFbcUMKN2KAXdDlb3+CPrlw5Rt0gjm3Rxsjk45
	BBr3+mOVoO10ghA+DAIwsSGfCdP01sk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-jCOfyzGgP4myvRykug3f6w-1; Tue, 06 Feb 2024 03:54:15 -0500
X-MC-Unique: jCOfyzGgP4myvRykug3f6w-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6da5a9defd5so1823131b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707209654; x=1707814454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6jeTGXlTgd7sq1RCPaLQ4vJaHshuSOrnrjXVHXXGG4=;
        b=P5+hnXVNoHl3ubqK6pT+pt2kz50cWG7YtLC24A1D6x8lbCxCsZsu7M9p4EmGLO+Ct7
         nC3WuLr8ZinCwQPke81R3q8mz/hzyEt4xRajLtHwi2MiJm50cbRvulDr2kiOKlu4BE4v
         /Mhcl1ykkzi+B8G7+bvpRIneeK7hDAql6rhLZ4XbaMXhbD+o9O17UdfNvxFFcYDHoOEu
         iwFbSbGml8A6Hw9XTYLXx3ua9DObv2CwNpIYhIt4crMpR/3j2poxqlNZMs5Q+Jl4oQfC
         Cqnmv9c4hPAXlvZgNyWYD7xefpzc42r0ekv6vhj595xYlXvwYB6LdIrdtoihSV29lQzx
         q9qg==
X-Gm-Message-State: AOJu0YwbnjCRNY8/t786Ek9BYW5ryhWXtJ8ScbtmUgcfu1chW2MnReQk
	gvGH8s4iqDf0KzWsTGG/1IusbrBqdMNXq+DgJKKsvhKVIcvgkfyq4gTjuIJ7H17hOThX17qho+A
	ozyhSlHPIgdrQrkwAcUCARGMWmyL5p5eaJHji2WOgaH9SWQogUC1q39fcheF5kQ==
X-Received: by 2002:a05:6a00:6ca1:b0:6e0:4576:f7e0 with SMTP id jc33-20020a056a006ca100b006e04576f7e0mr2247688pfb.2.1707209654359;
        Tue, 06 Feb 2024 00:54:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvN3y4+2Rw5wySrw+h3tMkLwaaLTuYCiyjGtL1y1ARDrZzfL7lEreaHm2OW4eOTmHSrywPIg==
X-Received: by 2002:a05:6a00:6ca1:b0:6e0:4576:f7e0 with SMTP id jc33-20020a056a006ca100b006e04576f7e0mr2247674pfb.2.1707209654034;
        Tue, 06 Feb 2024 00:54:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXgojwDuPwoSHBcnxvnh4eUxUfIAR5xwz/+stE6MwvGDIrJpPrLbUkveKky3x9HiRB2n2p1QQJn3vNs1cUKlg09cGWSW9Kmtf6HTPl2KAc570ys1TaAvFpcXwJbRF+gT+wjBJoL5VRKai3yxT4vxgiG7QcWWDDT
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b006e03be933cesm1349409pfj.96.2024.02.06.00.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 00:54:13 -0800 (PST)
Date: Tue, 6 Feb 2024 16:54:06 +0800
From: Peter Xu <peterx@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shaoqin Huang <shahuang@redhat.com>
Subject: Re: [PATCH] KVM: selftests: Fix a semaphore imbalance in the dirty
 ring logging test
Message-ID: <ZcHzrqpoUlUl5OhU@x1n>
References: <20240202231831.354848-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202231831.354848-1-seanjc@google.com>

On Fri, Feb 02, 2024 at 03:18:31PM -0800, Sean Christopherson wrote:
> When finishing the final iteration of dirty_log_test testcase, set
> host_quit _before_ the final "continue" so that the vCPU worker doesn't
> run an extra iteration, and delete the hack-a-fix of an extra "continue"
> from the dirty ring testcase.  This fixes a bug where the extra post to
> sem_vcpu_cont may not be consumed, which results in failures in subsequent
> runs of the testcases.  The bug likely was missed during development as
> x86 supports only a single "guest mode", i.e. there aren't any subsequent
> testcases after the dirty ring test, because for_each_guest_mode() only
> runs a single iteration.
> 
> For the regular dirty log testcases, letting the vCPU run one extra
> iteration is a non-issue as the vCPU worker waits on sem_vcpu_cont if and
> only if the worker is explicitly told to stop (vcpu_sync_stop_requested).
> But for the dirty ring test, which needs to periodically stop the vCPU to
> reap the dirty ring, letting the vCPU resume the guest _after_ the last
> iteration means the vCPU will get stuck without an extra "continue".
> 
> However, blindly firing off an post to sem_vcpu_cont isn't guaranteed to
> be consumed, e.g. if the vCPU worker sees host_quit==true before resuming
> the guest.  This results in a dangling sem_vcpu_cont, which leads to
> subsequent iterations getting out of sync, as the vCPU worker will
> continue on before the main task is ready for it to resume the guest,
> leading to a variety of asserts, e.g.
> 
>   ==== Test Assertion Failure ====
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
> Alternatively, the test could simply reset the semaphores before each
> testcase, but papering over hacks with more hacks usually ends in tears.

IMHO this is fine; we don't have a hard requirement anyway on sem in this
test, and we're pretty sure where the extra sem count came from (rather
than an unknown cause).

However since the patch can drop before_vcpu_join() by a proper ordering of
setup host_quit v.s. sem_post(), I think it's at least equally nice indeed.

> 
> Reported-by: Shaoqin Huang <shahuang@redhat.com>
> Fixes: 84292e565951 ("KVM: selftests: Add dirty ring buffer test")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


