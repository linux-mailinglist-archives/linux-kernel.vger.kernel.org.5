Return-Path: <linux-kernel+bounces-150740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3A68AA3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929471F22CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D96817F368;
	Thu, 18 Apr 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NraMZAa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220F15CD43
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471479; cv=none; b=bpMBConQF9/IwDahyP1g7L0b9tcYYCToF28NYfn0uNYwP+tzDftr3dkqWzLUeQKKhJFeBPbGXZSaxdBhglbd/oBFPliJJbhX61CdK/PzyASS2TrGN8maPzHt+JDfGAqkwMCTVKU8N/Y7n+gV8GQ/Fw8MY3iZERpheMPflaPoicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471479; c=relaxed/simple;
	bh=2+Iu6rboHTU4pX23XKc3js0Lcx0WQKJI0I/FuIkKTMI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YXyYxSA6UXK6ZnGnFh8+RyyUnO/yCKpf3ZXP9fDxDuAFJ1idBEWNrf8odf52KUQgSMWcyuWn6d1tsaXlFGQJChqcxV+1MICtVG6cssjbnRKYhMX7A9kkBIm+sMCU5oULWK2zBxvx71CxEap0D87k4XBHpONA+BvMVR7TCwp77MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NraMZAa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D87C113CC;
	Thu, 18 Apr 2024 20:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713471479;
	bh=2+Iu6rboHTU4pX23XKc3js0Lcx0WQKJI0I/FuIkKTMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NraMZAa9mMPDgVOfAPJlJzcl/uoR8Q3StueDMKYV9BNc+RLuv/17p36JUBkEnyN3e
	 6YcvzIiVUnL5IaKZkGA7Cmf9W+wD80jOi2lJctETtTfuSIHS0H/hY+k8vEoUbeiveR
	 EiqtHO3PM82Zw8VXCcU+tYG3t4us67xEkEgw3F8s=
Date: Thu, 18 Apr 2024 13:17:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, ying.huang@intel.com, vernhao@tencent.com,
 mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
 david@redhat.com, peterz@infradead.org, luto@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v9 rebase on mm-unstable 0/8] Reduce tlb and interrupt
 numbers over 90% by improving folio migration
Message-Id: <20240418131757.cd05a8e7c7e66b3e90508c11@linux-foundation.org>
In-Reply-To: <20240418061536.11645-1-byungchul@sk.com>
References: <20240418061536.11645-1-byungchul@sk.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 15:15:28 +0900 Byungchul Park <byungchul@sk.com> wrote:

>    $ time XSBench -t 16 -p 50000000
> 
>    BEFORE
>    ------
>    Threads:     16
>    Runtime:     968.783 seconds
>    Lookups:     1,700,000,000
>    Lookups/s:   1,754,778
> 
>    15208.91s user 141.44s system 1564% cpu 16:20.98 total
> 
>    AFTER
>    -----
>    Threads:     16
>    Runtime:     913.210 seconds
>    Lookups:     1,700,000,000
>    Lookups/s:   1,861,565
> 
>    14351.69s user 138.23s system 1565% cpu 15:25.47 total

Well that's nice.  What exactly is XSBench doing in this situation? 
What sort of improvements can we expect to see in useful workloads?

I see it no longer consumes an additional page flag, good.

The patches show no evidence of review activity and I'm not seeing much
on the mailing list (patchset title was changed.  Previous title
"Reduce TLB flushes under some specific conditions").  Perhaps a better
description of the overall benefit to our users would help to motivate
reviewers.

