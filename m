Return-Path: <linux-kernel+bounces-77632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D2586084D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE780B22448
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3EDB657;
	Fri, 23 Feb 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKe6orUq"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEE946C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652151; cv=none; b=UCvOFgA69ZJZet+xCXjCoUAzJs9ow5NFyt4L6L13mvm+hjfJeICPKFidSn5lTAcvU7ndBsURvEef0dR8XlnMybJw3Fjmqp7YQ9dtz7JEE4NYUmxViHCeSoax2yX/X0PID5TvK2bUE/Z7w2Q00NlWgXfEzF1CyUbVQBfVC9hAg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652151; c=relaxed/simple;
	bh=p4d3Q0Ezf7xGBghQvwbWJdhARUgaypqvkJKM9BnPDz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mzYIZl1gBPuUHF6jCPtSLN0t0Tq+upKKV2dP3K6T94c9pSgrql9p1EzKTj/RHiRRfib3dXXUw50F8a9mMbxTl6L/PD5M6AnrxUjggBNmfaPny1tntaPPF6jpFPD7/R1LsFot3WRvj9MO1B+JqX+eXIuBoyW7jhzuqggjwwNEiDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKe6orUq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so556230276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708652149; x=1709256949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wM73uSKwWS47RUq68QegjT1HnyhxD9Ii9nwZABJn6I4=;
        b=kKe6orUqSNLsObiOLhBjWxOTM/lyU7jFR6hpcIf6kKhZeHOflQsntFjS02MSygG/59
         wunGz210vE4eNBXBUKSjH6yxhRxoI1JFz1J/6HwVFKt2o6Zu0dC8GXGOXSQxq0Kac+7O
         irLWE36fI8bFE5dHkyzkqpa38wck2t6rYXbjxV+25nf0ms2FHUB0l/Plx30DubLQ6k9n
         UHcYsTOn7V+12/x0MVoPd7YlJK2JLcRn8p4wAkI0w0rgifyfGe4Wtc9ZPUZ9RWoEe34D
         nxl5NnSwq/kRmbpH59sHZeFUh+WJhS/S1TF6mjaJs6egKdfLO3emhtsnfpX4Xi4CEC6M
         ziiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708652149; x=1709256949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wM73uSKwWS47RUq68QegjT1HnyhxD9Ii9nwZABJn6I4=;
        b=lliy+Cgkxoq4mF1AUukUNtuArDsBNhCrTUDwzavdojp81T9Zyo5MEm68BNg7MAV9TY
         xxr7ryhEEPm4Sw1nTy6IjIehhhGktaaOrpZgZ8Qb0Ya9EoikFECKB4rm5n6mPDeyGQfe
         Ax25+l6E9jyySMbwS8CEHpCpbZ6s7i0gTrpQjgMY5VEIdzbVQ8s3PyhyB1DvgYT4ECXd
         AGi1gjIX9PYxjfhUe7eV5H9Xv647dQdmxUfT1orWIbrS6lNdCulsIgC+55ZtNtGial3V
         ISJ1vSNTpmap/QDcunXLzE6bl+wgAjfl2RvO+Y2BUutUlYUGKBbQWh5tJjwImxF5hBxO
         huiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs7VEOisRqYUHsPJ0cbsN65NwzNkKX8CjdIWjPlktoSiWjEpxLyAB+oBDVwsIay5tXWnuMVXdBU50zB/88a1AKa/VpmLAKnJ3HzZVh
X-Gm-Message-State: AOJu0YxiQYlwMF+r9tOeSTUV2dlJYr5n55jOqtyGz/yu8u8caelFW8mN
	Ww6KHClNC/9K5hc1C/KHQ0BNNJ+7Vn7dEcQSapbAQWXObHLWc9pPcIjgFldLH2Wnz/GXFQ+GRr5
	ysw==
X-Google-Smtp-Source: AGHT+IHA2JNk7sue8BnBcUvK6I6CX/uQlY+iUi0rCInDpHy6xd2yG/qDics+T39rRD2l5LCFyspd5l5pqnw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18c8:b0:dc7:68b5:4f21 with SMTP id
 ck8-20020a05690218c800b00dc768b54f21mr215694ybb.9.1708652149006; Thu, 22 Feb
 2024 17:35:49 -0800 (PST)
Date: Thu, 22 Feb 2024 17:35:32 -0800
In-Reply-To: <20240222012640.2820927-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222012640.2820927-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <170864687051.3082005.15844066182287586773.b4-ty@google.com>
Subject: Re: [PATCH v5] KVM: x86/mmu: Retry fault before acquiring mmu_lock if
 mapping is changing
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Friedrich Weber <f.weber@proxmox.com>, 
	Kai Huang <kai.huang@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 21 Feb 2024 17:26:40 -0800, Sean Christopherson wrote:
> Retry page faults without acquiring mmu_lock, and without even faulting
> the page into the primary MMU, if the resolved gfn is covered by an active
> invalidation.  Contending for mmu_lock is especially problematic on
> preemptible kernels as the mmu_notifier invalidation task will yield
> mmu_lock (see rwlock_needbreak()), delay the in-progress invalidation, and
> ultimately increase the latency of resolving the page fault.  And in the
> worst case scenario, yielding will be accompanied by a remote TLB flush,
> e.g. if the invalidation covers a large range of memory and vCPUs are
> accessing addresses that were already zapped.
> 
> [...]

Applied (quickly) to kvm-x86 fixes, as I want to get this into -next for at
least a day or two before sending it to Paolo for 6.8.  But I'm more than happy
to squash in reviews/acks, especially since many people gave very helpful
feedback on earlier versions.

[1/1] KVM: x86/mmu: Retry fault before acquiring mmu_lock if mapping is changing
      https://github.com/kvm-x86/linux/commit/67e4022ffad6

--
https://github.com/kvm-x86/linux/tree/next

