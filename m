Return-Path: <linux-kernel+bounces-129634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA9B896DA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB289B2746C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3EE1411F1;
	Wed,  3 Apr 2024 11:04:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6CB135A5F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142249; cv=none; b=cbFMQnRd4AC7lIZ4H6y8jjkhBArcNKzm6BIz3IJUvWhN00Ebk6y9BgB3yvONLd6QRll7hBaBSRe/N45OR0Q35W0Uwj9nmMxxn6RbTYevQ4J/TXTZsQG1j2A5ZnWHI5uctAvoWa8vIkPsMVUdwlbWnmXQjGEn4J1PnkRGMZZm6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142249; c=relaxed/simple;
	bh=BbwddR6/RNAakXtOlCpMOZ9Mx5a16dbieqopNhfP2qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlbfEBH327lNZC90EVNqiwF2wWHRFy5+Yudd5ereKdW/DZgKQP4VP7osBdZO2m6zdpxI96fPGYSyHKAFuteOBgelD+S1ggI4uPBglXvPdjVYn+Xw/JjDtRZpX5+6cNbZ1TeqnwJPg8FulTtGRhic4t/ZrJ96Bm+bsBfX+vuMt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03A461007;
	Wed,  3 Apr 2024 04:04:34 -0700 (PDT)
Received: from [10.57.72.245] (unknown [10.57.72.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB7543F64C;
	Wed,  3 Apr 2024 04:04:01 -0700 (PDT)
Message-ID: <1c20b717-c5b5-4bdf-8fcd-d46db135b7fa@arm.com>
Date: Wed, 3 Apr 2024 12:04:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: Fix hugetlb mem size
 calculation
Content-Language: en-GB
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 David Hildenbrand <david@redhat.com>, Nico Pache <npache@redhat.com>,
 Muchun Song <muchun.song@linux.dev>
References: <20240321215047.678172-1-peterx@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240321215047.678172-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

On 21/03/2024 21:50, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> The script calculates a mininum required size of hugetlb memories, but
> it'll stop working with <1MB huge page sizes, reporting all zeros even if
> huge pages are available.
> 
> In reality, the calculation doesn't really need to be as comlicated either.
> Make it simpler and work for KB-level hugepages too.
> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index c2c542fe7b17..b1b78e45d613 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -152,9 +152,13 @@ done < /proc/meminfo
>  # both of these requirements into account and attempt to increase
>  # number of huge pages available.
>  nr_cpus=$(nproc)
> -hpgsize_MB=$((hpgsize_KB / 1024))
> -half_ufd_size_MB=$((((nr_cpus * hpgsize_MB + 127) / 128) * 128))

Removing this has broken the uffd-stress "hugetlb" and "hugetlb-private" tests
(further down the file), which rely on $half_ufd_size_MB. Now that this is not
defined, they are called with too few params:


# # ---------------------------------
# # running ./uffd-stress hugetlb  32
# # ---------------------------------
# # ERROR: invalid MiB (errno=0, @uffd-stress.c:454)
# #
# # Usage: ./uffd-stress <test type> <MiB> <bounces>
# #
# # Supported <test type>: anon, hugetlb, hugetlb-private, shmem, shmem-private
# #
# # Examples:
# #
# # # Run anonymous memory test on 100MiB region with 99999 bounces:
# # ./uffd-stress anon 100 99999
# #
# # # Run share memory test on 1GiB region with 99 bounces:
# # ./uffd-stress shmem 1000 99
# #
# # # Run hugetlb memory test on 256MiB region with 50 bounces:
# # ./uffd-stress hugetlb 256 50
# #
# # # Run the same hugetlb test but using private file:
# # ./uffd-stress hugetlb-private 256 50
# #
# # # 10MiB-~6GiB 999 bounces anonymous test, continue forever unless an error
triggers
# # while ./uffd-stress anon $[RANDOM % 6000 + 10] 999; do true; done
# #
# # [FAIL]
# not ok 16 uffd-stress hugetlb 32 # exit=1
# # -----------------------------------------
# # running ./uffd-stress hugetlb-private  32
# # -----------------------------------------
# # ERROR: invalid MiB (errno=0, @uffd-stress.c:454)
# #
# # Usage: ./uffd-stress <test type> <MiB> <bounces>
# #
# # Supported <test type>: anon, hugetlb, hugetlb-private, shmem, shmem-private
# #
# # Examples:
# #
# # # Run anonymous memory test on 100MiB region with 99999 bounces:
# # ./uffd-stress anon 100 99999
# #
# # # Run share memory test on 1GiB region with 99 bounces:
# # ./uffd-stress shmem 1000 99
# #
# # # Run hugetlb memory test on 256MiB region with 50 bounces:
# # ./uffd-stress hugetlb 256 50
# #
# # # Run the same hugetlb test but using private file:
# # ./uffd-stress hugetlb-private 256 50
# #
# # # 10MiB-~6GiB 999 bounces anonymous test, continue forever unless an error
triggers
# # while ./uffd-stress anon $[RANDOM % 6000 + 10] 999; do true; done
# #
# # [FAIL]
# not ok 17 uffd-stress hugetlb-private 32 # exit=1


Thanks,
Ryan

> -needmem_KB=$((half_ufd_size_MB * 2 * 1024))
> +uffd_min_KB=$((hpgsize_KB * nr_cpus * 2))
> +hugetlb_min_KB=$((256 * 1024))
> +if [[ $uffd_min_KB -gt $hugetlb_min_KB ]]; then
> +	needmem_KB=$uffd_min_KB
> +else
> +	needmem_KB=$hugetlb_min_KB
> +fi
>  
>  # set proper nr_hugepages
>  if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then


