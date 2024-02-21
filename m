Return-Path: <linux-kernel+bounces-75590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415485EBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D8BB231A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A112837E;
	Wed, 21 Feb 2024 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="u7udHJWe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29883A1F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553519; cv=none; b=VaEplbXy4YVEPxorInVKAm5mJUe/afkLN52WHirZoSxRA1kT7IoMs2ftyyWgCQ7IM2eMMe4VXDS3o3rFhNIbyUld1o05lKGn9vbh0B8HotLxKXAThjxgOKkxk5kPYu62NIga5pr9x/G2ZjVUrDYM99e+1TuU6TRyflIfWUR+N1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553519; c=relaxed/simple;
	bh=MpuFyYpFGbhwPH3WeRDv8S0Vma53RRU34+TszDKayw4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZXuaWrQdoZVGTsOFJe0gRxKKXxubEOiG2/wCqK7RWf5o+d8mMEgF/moywR+mh/HXxrj2agUsDkftT6bbqU60qCpuYtWADqWywQ/+LAiov5NGdDX3wdtiADLayGC2GNdQDxwClEwVTJkrWbQ7o3efxDmJ1o1h6+ZD7Qkq4BaUSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=u7udHJWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936BEC433F1;
	Wed, 21 Feb 2024 22:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708553518;
	bh=MpuFyYpFGbhwPH3WeRDv8S0Vma53RRU34+TszDKayw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u7udHJWeb4Lxq2B0dedbNkNBduktONYRoy1qUKS3shYfrrB1Tto8nzQhCkK/CgzGG
	 2N6HZCRpqLVVuIYQUEkPkzZzevfnV0Ej2LGiKTttHjW2zfdAAcjUQ4cWxR+P1I/cJx
	 SoHUXJnoMdCBtrAvLzJVxe7oK5Rop3s7QihEVv14=
Date: Wed, 21 Feb 2024 14:11:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: mhocko@suse.com, zokeefe@google.com, david@redhat.com,
 songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
Message-Id: <20240221141158.8217ff2caf4f86c11a430058@linux-foundation.org>
In-Reply-To: <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
References: <20240129054551.57728-1-ioworker0@gmail.com>
	<CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 17:30:11 +0800 Lance Yang <ioworker0@gmail.com> wrote:

> Updating the change log.
> 
> khugepaged scans the entire address space in the
> background for each given mm, looking for
> opportunities to merge sequences of basic pages
> into huge pages. However, when an mm is inserted
> to the mm_slots list, and the MMF_DISABLE_THP
> flag is set later, this scanning process becomes
> unnecessary for that mm and can be skipped to
> avoid redundant operations, especially in scenarios
> with a large address space.
> 
> This commit introduces a check before each scanning
> process to test the MMF_DISABLE_THP flag for the
> given mm; if the flag is set, the scanning process is
> bypassed, thereby improving the efficiency of khugepaged.
> 
> This optimization is not a correctness issue but rather an
> enhancement to save expensive checks on each VMA
> when userspace cannot prctl itself before spawning
> into the new process.
> 
> On some servers within our company, we deploy a
> daemon responsible for monitoring and updating local
> applications. Some applications prefer not to use THP,
> so the daemon calls prctl to disable THP before fork/exec.
> Conversely, for other applications, the daemon calls prctl
> to enable THP before fork/exec.
> 
> Ideally, the daemon should invoke prctl after the fork,
> but its current implementation follows the described
> approach. In the Go standard library, there is no direct
> encapsulation of the fork system call; instead, fork and
> execve are combined into one through syscall.ForkExec.

I pasted the above into the v1 patch's changelog.

However I'm not seeing a good level of reviewer enthusiasm.  Pertially
because of the lack of quantitative testing results.  Is is possible to
generate such results, to give people an overall feel of the
desirability of this change?


