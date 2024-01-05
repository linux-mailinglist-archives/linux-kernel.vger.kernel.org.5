Return-Path: <linux-kernel+bounces-17511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E551A824EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2571F21B16
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D451DFDA;
	Fri,  5 Jan 2024 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zybvHjHP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24B1DFCB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704436073;
	bh=wB37rMC+UTPbLNXffCOSvGSP759jg7mEntQlnz7Bg2A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=zybvHjHPeSbfVmJifd5o50z8jGboYHWpyzshj4d3i8s34ntFuYlAYZSCPihEgBxJD
	 1idGR1jZx9/EH4fOJulDB0MmQRZqNkva6PJ/x1TaLN7+y03VLibJzKT9rWWn0D8qiQ
	 sxZsor5meAJQxo5xeuJhqYz0bSwNzjmuLmmtvE6K8g3Py30LRbMvx1HPtMxopx+xrL
	 x3o3pV2rY4xGaQf/2yw3hV+YBgWK1AWXUQ8BPRBYRB2BYUnQ39t4KLyFRprG7GC0F8
	 Texi117xPPa6YLrlK42fVtyYl4UYCBiEN6QUGimXhpGEloLdDLguUNMiq1y6rHW6v+
	 BT19DOso5UYmg==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 028D237813B6;
	Fri,  5 Jan 2024 06:27:49 +0000 (UTC)
Message-ID: <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com>
Date: Fri, 5 Jan 2024 11:27:53 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
To: Jiaqi Yan <jiaqiyan@google.com>, linmiaohe@huawei.com,
 mike.kravetz@oracle.com, naoya.horiguchi@nec.com
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 akpm@linux-foundation.org, songmuchun@bytedance.com, shy828301@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, jthoughton@google.com,
 "kernel@collabora.com" <kernel@collabora.com>
References: <20230713001833.3778937-1-jiaqiyan@google.com>
 <20230713001833.3778937-5-jiaqiyan@google.com>
Content-Language: en-US
In-Reply-To: <20230713001833.3778937-5-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm trying to convert this test to TAP as I think the failures sometimes go
unnoticed on CI systems if we only depend on the return value of the
application. I've enabled the following configurations which aren't already
present in tools/testing/selftests/mm/config:
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m

I'll send a patch to add these configs later. Right now I'm trying to
investigate the failure when we are trying to inject the poison page by
madvise(MADV_HWPOISON). I'm getting device busy every single time. The test
fails as it doesn't expect any business for the hugetlb memory. I'm not
sure if the poison handling code has issues or test isn't robust enough.

./hugetlb-read-hwpoison
Write/read chunk size=0x800
 ... HugeTLB read regression test...
 ...  ... expect to read 0x200000 bytes of data in total
 ...  ... actually read 0x200000 bytes of data in total
 ... HugeTLB read regression test...TEST_PASSED
 ... HugeTLB read HWPOISON test...
[    9.280854] Injecting memory failure for pfn 0x102f01 at process virtual
address 0x7f28ec101000
[    9.282029] Memory failure: 0x102f01: huge page still referenced by 511
users
[    9.282987] Memory failure: 0x102f01: recovery action for huge page: Failed
 ...  !!! MADV_HWPOISON failed: Device or resource busy
 ... HugeTLB read HWPOISON test...TEST_FAILED

I'm testing on v6.7-rc8. Not sure if this was working previously or not.

Regards,
Usama

On 7/13/23 5:18 AM, Jiaqi Yan wrote:
> Add tests for the improvement made to read operation on HWPOISON
> hugetlb page with different read granularities. For each chunk size,
> three read scenarios are tested:
> 1. Simple regression test on read without HWPOISON.
> 2. Sequential read page by page should succeed until encounters the 1st
>    raw HWPOISON subpage.
> 3. After skip a raw HWPOISON subpage by lseek, read()s always succeed.
> 
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
>  3 files changed, 324 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 7e2a982383c0..cdc9ce4426b9 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -5,6 +5,7 @@ hugepage-mremap
>  hugepage-shm
>  hugepage-vmemmap
>  hugetlb-madvise
> +hugetlb-read-hwpoison
>  khugepaged
>  map_hugetlb
>  map_populate
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 66d7c07dc177..b7fce9073279 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -41,6 +41,7 @@ TEST_GEN_PROGS += gup_longterm
>  TEST_GEN_PROGS += gup_test
>  TEST_GEN_PROGS += hmm-tests
>  TEST_GEN_PROGS += hugetlb-madvise
> +TEST_GEN_PROGS += hugetlb-read-hwpoison
>  TEST_GEN_PROGS += hugepage-mmap
>  TEST_GEN_PROGS += hugepage-mremap
>  TEST_GEN_PROGS += hugepage-shm
> diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> new file mode 100644
> index 000000000000..ba6cc6f9cabc
> --- /dev/null
> +++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> @@ -0,0 +1,322 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include <linux/magic.h>
> +#include <sys/mman.h>
> +#include <sys/statfs.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +
> +#include "../kselftest.h"
> +
> +#define PREFIX " ... "
> +#define ERROR_PREFIX " !!! "
> +
> +#define MAX_WRITE_READ_CHUNK_SIZE (getpagesize() * 16)
> +#define MAX(a, b) (((a) > (b)) ? (a) : (b))
> +
> +enum test_status {
> +	TEST_PASSED = 0,
> +	TEST_FAILED = 1,
> +	TEST_SKIPPED = 2,
> +};
> +
> +static char *status_to_str(enum test_status status)
> +{
> +	switch (status) {
> +	case TEST_PASSED:
> +		return "TEST_PASSED";
> +	case TEST_FAILED:
> +		return "TEST_FAILED";
> +	case TEST_SKIPPED:
> +		return "TEST_SKIPPED";
> +	default:
> +		return "TEST_???";
> +	}
> +}
> +
> +static int setup_filemap(char *filemap, size_t len, size_t wr_chunk_size)
> +{
> +	char iter = 0;
> +
> +	for (size_t offset = 0; offset < len;
> +	     offset += wr_chunk_size) {
> +		iter++;
> +		memset(filemap + offset, iter, wr_chunk_size);
> +	}
> +
> +	return 0;
> +}
> +
> +static bool verify_chunk(char *buf, size_t len, char val)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < len; ++i) {
> +		if (buf[i] != val) {
> +			printf(PREFIX ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
> +				i, buf[i], val);
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
> +				       off_t offset, size_t expected)
> +{
> +	char buf[MAX_WRITE_READ_CHUNK_SIZE];
> +	ssize_t ret_count = 0;
> +	ssize_t total_ret_count = 0;
> +	char val = offset / wr_chunk_size + offset % wr_chunk_size;
> +
> +	printf(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
> +	printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
> +	       expected);
> +	if (lseek(fd, offset, SEEK_SET) < 0) {
> +		perror(PREFIX ERROR_PREFIX "seek failed");
> +		return false;
> +	}
> +
> +	while (offset + total_ret_count < len) {
> +		ret_count = read(fd, buf, wr_chunk_size);
> +		if (ret_count == 0) {
> +			printf(PREFIX PREFIX "read reach end of the file\n");
> +			break;
> +		} else if (ret_count < 0) {
> +			perror(PREFIX ERROR_PREFIX "read failed");
> +			break;
> +		}
> +		++val;
> +		if (!verify_chunk(buf, ret_count, val))
> +			return false;
> +
> +		total_ret_count += ret_count;
> +	}
> +	printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
> +	       total_ret_count);
> +
> +	return total_ret_count == expected;
> +}
> +
> +static bool read_hugepage_filemap(int fd, size_t len,
> +				  size_t wr_chunk_size, size_t expected)
> +{
> +	char buf[MAX_WRITE_READ_CHUNK_SIZE];
> +	ssize_t ret_count = 0;
> +	ssize_t total_ret_count = 0;
> +	char val = 0;
> +
> +	printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
> +	       expected);
> +	while (total_ret_count < len) {
> +		ret_count = read(fd, buf, wr_chunk_size);
> +		if (ret_count == 0) {
> +			printf(PREFIX PREFIX "read reach end of the file\n");
> +			break;
> +		} else if (ret_count < 0) {
> +			perror(PREFIX ERROR_PREFIX "read failed");
> +			break;
> +		}
> +		++val;
> +		if (!verify_chunk(buf, ret_count, val))
> +			return false;
> +
> +		total_ret_count += ret_count;
> +	}
> +	printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
> +	       total_ret_count);
> +
> +	return total_ret_count == expected;
> +}
> +
> +static enum test_status
> +test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
> +{
> +	enum test_status status = TEST_SKIPPED;
> +	char *filemap = NULL;
> +
> +	if (ftruncate(fd, len) < 0) {
> +		perror(PREFIX ERROR_PREFIX "ftruncate failed");
> +		return status;
> +	}
> +
> +	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +		       MAP_SHARED | MAP_POPULATE, fd, 0);
> +	if (filemap == MAP_FAILED) {
> +		perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
> +		goto done;
> +	}
> +
> +	setup_filemap(filemap, len, wr_chunk_size);
> +	status = TEST_FAILED;
> +
> +	if (read_hugepage_filemap(fd, len, wr_chunk_size, len))
> +		status = TEST_PASSED;
> +
> +	munmap(filemap, len);
> +done:
> +	if (ftruncate(fd, 0) < 0) {
> +		perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
> +		status = TEST_FAILED;
> +	}
> +
> +	return status;
> +}
> +
> +static enum test_status
> +test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
> +			   bool skip_hwpoison_page)
> +{
> +	enum test_status status = TEST_SKIPPED;
> +	char *filemap = NULL;
> +	char *hwp_addr = NULL;
> +	const unsigned long pagesize = getpagesize();
> +
> +	if (ftruncate(fd, len) < 0) {
> +		perror(PREFIX ERROR_PREFIX "ftruncate failed");
> +		return status;
> +	}
> +
> +	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +		       MAP_SHARED | MAP_POPULATE, fd, 0);
> +	if (filemap == MAP_FAILED) {
> +		perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
> +		goto done;
> +	}
> +
> +	setup_filemap(filemap, len, wr_chunk_size);
> +	status = TEST_FAILED;
> +
> +	/*
> +	 * Poisoned hugetlb page layout (assume hugepagesize=2MB):
> +	 * |<---------------------- 1MB ---------------------->|
> +	 * |<---- healthy page ---->|<---- HWPOISON page ----->|
> +	 * |<------------------- (1MB - 8KB) ----------------->|
> +	 */
> +	hwp_addr = filemap + len / 2 + pagesize;
> +	if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
> +		perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
> +		goto unmap;
> +	}
> +
> +	if (!skip_hwpoison_page) {
> +		/*
> +		 * Userspace should be able to read (1MB + 1 page) from
> +		 * the beginning of the HWPOISONed hugepage.
> +		 */
> +		if (read_hugepage_filemap(fd, len, wr_chunk_size,
> +					  len / 2 + pagesize))
> +			status = TEST_PASSED;
> +	} else {
> +		/*
> +		 * Userspace should be able to read (1MB - 2 pages) from
> +		 * HWPOISONed hugepage.
> +		 */
> +		if (seek_read_hugepage_filemap(fd, len, wr_chunk_size,
> +					       len / 2 + MAX(2 * pagesize, wr_chunk_size),
> +					       len / 2 - MAX(2 * pagesize, wr_chunk_size)))
> +			status = TEST_PASSED;
> +	}
> +
> +unmap:
> +	munmap(filemap, len);
> +done:
> +	if (ftruncate(fd, 0) < 0) {
> +		perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
> +		status = TEST_FAILED;
> +	}
> +
> +	return status;
> +}
> +
> +static int create_hugetlbfs_file(struct statfs *file_stat)
> +{
> +	int fd;
> +
> +	fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
> +	if (fd < 0) {
> +		perror(PREFIX ERROR_PREFIX "could not open hugetlbfs file");
> +		return -1;
> +	}
> +
> +	memset(file_stat, 0, sizeof(*file_stat));
> +	if (fstatfs(fd, file_stat)) {
> +		perror(PREFIX ERROR_PREFIX "fstatfs failed");
> +		goto close;
> +	}
> +	if (file_stat->f_type != HUGETLBFS_MAGIC) {
> +		printf(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
> +		goto close;
> +	}
> +
> +	return fd;
> +close:
> +	close(fd);
> +	return -1;
> +}
> +
> +int main(void)
> +{
> +	int fd;
> +	struct statfs file_stat;
> +	enum test_status status;
> +	/* Test read() in different granularity. */
> +	size_t wr_chunk_sizes[] = {
> +		getpagesize() / 2, getpagesize(),
> +		getpagesize() * 2, getpagesize() * 4
> +	};
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(wr_chunk_sizes); ++i) {
> +		printf("Write/read chunk size=0x%lx\n",
> +		       wr_chunk_sizes[i]);
> +
> +		fd = create_hugetlbfs_file(&file_stat);
> +		if (fd < 0)
> +			goto create_failure;
> +		printf(PREFIX "HugeTLB read regression test...\n");
> +		status = test_hugetlb_read(fd, file_stat.f_bsize,
> +					   wr_chunk_sizes[i]);
> +		printf(PREFIX "HugeTLB read regression test...%s\n",
> +		       status_to_str(status));
> +		close(fd);
> +		if (status == TEST_FAILED)
> +			return -1;
> +
> +		fd = create_hugetlbfs_file(&file_stat);
> +		if (fd < 0)
> +			goto create_failure;
> +		printf(PREFIX "HugeTLB read HWPOISON test...\n");
> +		status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
> +						    wr_chunk_sizes[i], false);
> +		printf(PREFIX "HugeTLB read HWPOISON test...%s\n",
> +		       status_to_str(status));
> +		close(fd);
> +		if (status == TEST_FAILED)
> +			return -1;
> +
> +		fd = create_hugetlbfs_file(&file_stat);
> +		if (fd < 0)
> +			goto create_failure;
> +		printf(PREFIX "HugeTLB seek then read HWPOISON test...\n");
> +		status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
> +						    wr_chunk_sizes[i], true);
> +		printf(PREFIX "HugeTLB seek then read HWPOISON test...%s\n",
> +		       status_to_str(status));
> +		close(fd);
> +		if (status == TEST_FAILED)
> +			return -1;
> +	}
> +
> +	return 0;
> +
> +create_failure:
> +	printf(ERROR_PREFIX "Abort test: failed to create hugetlbfs file\n");
> +	return -1;
> +}

-- 
BR,
Muhammad Usama Anjum

