Return-Path: <linux-kernel+bounces-131043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1BA898252
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F4A1F299F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988D5B1FB;
	Thu,  4 Apr 2024 07:39:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E131B59B67
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216386; cv=none; b=R7nePXf8F5yM+CFAnQvzUsmyop0FzgoETnb4Vyri/5TWZLScYrQRZVWYzt5J4LlaxXC80qG6m59Oc36StgY1jvpd9nJ1mOaGGhy/WJaVuwWkHQM7JP4VImxN35lCEvO+za+fnjIDHQcWDjk11Vmhc+UoO++ocVCWlZ+9C6tuExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216386; c=relaxed/simple;
	bh=WrO84vaqN/tGkvA3GXl8H7twPrwOEXGtLcpsE6FFd40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuUEAQyrd24pGk7srlbnB+B+lv8ThqwNt0pNIdcimbkvhG1ZFs/BL/Ss/jgXIYNRXBKCOReR4dfvU2G8DwTiL78n5xpZDD4WU6u371s89CudhCrU7bY9eJtmrDK4WNVOIW1rHoOCnYm+guIaBZhF1i4Ifu27h3aED1dFYXdJuu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CDD1007;
	Thu,  4 Apr 2024 00:40:14 -0700 (PDT)
Received: from [10.57.72.245] (unknown [10.57.72.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49FE73F64C;
	Thu,  4 Apr 2024 00:39:42 -0700 (PDT)
Message-ID: <d968a109-7f74-4cce-b2fa-98165048a2e9@arm.com>
Date: Thu, 4 Apr 2024 08:39:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fixup! selftests/mm: run_vmtests.sh: fix hugetlb mem size
 calculation
Content-Language: en-GB
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 David Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>
References: <20240403200324.1603493-1-peterx@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240403200324.1603493-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 21:03, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Fix up a breakage on uffd hugetlb test due to removal of a temp variable,
> as reported by Ryan [1].
> 
> Instead of using the previous calculation, use the largest we can
> have (which is put in freepgs) and cut it into half for userfault tests.
> 
> [1] https://lore.kernel.org/r/1c20b717-c5b5-4bdf-8fcd-d46db135b7fa@arm.com
> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

All passing again for me:

Tested-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index b1b78e45d613..223c2304f885 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -298,7 +298,8 @@ CATEGORY="userfaultfd" run_test ./uffd-unit-tests
>  uffd_stress_bin=./uffd-stress
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
>  # Hugetlb tests require source and destination huge pages. Pass in half
> -# the size ($half_ufd_size_MB), which is used for *each*.
> +# the size of the free pages we have, which is used for *each*.
> +half_ufd_size_MB=$((freepgs / 2))
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16


