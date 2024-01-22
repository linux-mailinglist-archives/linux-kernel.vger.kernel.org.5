Return-Path: <linux-kernel+bounces-32940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F770836238
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C48128B6B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD4F3B1AB;
	Mon, 22 Jan 2024 11:37:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110153D0D0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923430; cv=none; b=SZT1o2kietSG5Ujg8dCyxKK+YI32HEQ9wSdM8KpqGcgYEdyjfFT5JYgn3As/mPtT81iiniT2NSAoZZYtnP9lvP8cjaweFA+YJvmtReQPYMuoiTHVQdgq/h1hxLLJMiPBwNSeeTobwRBLvf70ocL6JHsOEmUny47uc10mYxT+JuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923430; c=relaxed/simple;
	bh=tc07Hoo8kUBjMgipl68tFHV4GELQ+lwU9IO+Vcd3l44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0nce/hWojkNPsq8S9dhjD6uCi7RlcLUxzER37i+2Asn5AP4jf/1l1k6vuDrdAQOCfHegrcAfw+m2ko3iMamAsPgaSzAqPdLUeBVrMj869TOG8oNW1XV5F0BC4HIFqjlUJ9AXRWh0ZiGY7fCJ5TO0zekPXfRN3s7KwF9hS+h0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4166F1FB;
	Mon, 22 Jan 2024 03:37:53 -0800 (PST)
Received: from [10.1.33.151] (XHFQ2J9959.cambridge.arm.com [10.1.33.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E09E3F5A1;
	Mon, 22 Jan 2024 03:37:06 -0800 (PST)
Message-ID: <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
Date: Mon, 22 Jan 2024 11:37:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com,
 shy828301@gmail.com, cl@linux.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
 <Zav3UK7ESNxCMjyP@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zav3UK7ESNxCMjyP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/01/2024 16:39, Matthew Wilcox wrote:
> On Sat, Jan 20, 2024 at 12:04:27PM +0000, Ryan Roberts wrote:
>> However, after this patch, each allocation is in its own VMA, and there is a 2M
>> gap between each VMA. This causes 2 problems: 1) mmap becomes MUCH slower
>> because there are so many VMAs to check to find a new 1G gap. 2) It fails once
>> it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting this limit then
>> causes a subsequent calloc() to fail, which causes the test to fail.
>>
>> Looking at the code, I think the problem is that arm64 selects
>> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area() allocates
>> len+2M then always aligns to the bottom of the discovered gap. That causes the
>> 2M hole. As far as I can see, x86 allocates bottom up, so you don't get a hole.
> 
> As a quick hack, perhaps
> #ifdef ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> take-the-top-half
> #else
> current-take-bottom-half-code
> #endif
> 
> ?

There is a general problem though that there is a trade-off between abutting
VMAs, and aligning them to PMD boundaries. This patch has decided that in
general the latter is preferable. The case I'm hitting is special though, in
that both requirements could be achieved but currently are not.

The below fixes it, but I feel like there should be some bitwise magic that
would give the correct answer without the conditional - but my head is gone and
I can't see it. Any thoughts?

Beyond this, though, there is also a latent bug where the offset provided to
mmap() is carried all the way through to the get_unmapped_area()
impelementation, even for MAP_ANONYMOUS - I'm pretty sure we should be
force-zeroing it for MAP_ANONYMOUS? Certainly before this change, for arches
that use the default get_unmapped_area(), any non-zero offset would not have
been used. But this change starts using it, which is incorrect. That said, there
are some arches that override the default get_unmapped_area() and do use the
offset. So I'm not sure if this is a bug or a feature that user space can pass
an arbitrary value to the implementation for anon memory??

Finally, the second test failure I reported (ksm_tests) is actually caused by a
bug in the test code, but provoked by this change. So I'll send out a fix for
the test code separately.


diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4f542444a91f..68ac54117c77 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -632,7 +632,7 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 {
        loff_t off_end = off + len;
        loff_t off_align = round_up(off, size);
-       unsigned long len_pad, ret;
+       unsigned long len_pad, ret, off_sub;

        if (off_end <= off_align || (off_end - off_align) < size)
                return 0;
@@ -658,7 +658,13 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
        if (ret == addr)
                return addr;

-       ret += (off - ret) & (size - 1);
+       off_sub = (off - ret) & (size - 1);
+
+       if (current->mm->get_unmapped_area == arch_get_unmapped_area_topdown &&
+           !off_sub)
+               return ret + size;
+
+       ret += off_sub;
        return ret;
 }

