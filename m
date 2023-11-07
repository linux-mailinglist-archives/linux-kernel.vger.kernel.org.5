Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB07E351B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjKGGPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKGGPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:15:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A0BB4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:15:03 -0800 (PST)
Received: from [100.98.85.67] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A5C56607487;
        Tue,  7 Nov 2023 06:15:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699337702;
        bh=UO9SZyFsggdxfY36saWKyFKL+wVbyR71EIKjDsiX6dA=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=UTlvnSybCpdZm6WxgcDrPqUNJitlXLGr2t26zdmZiLynt0BjAsHTly2icZjjdFXJq
         07+uHzc3fXijS6xgYoMFROvUSrP8/3w9R9BT5uhRob9nICB8pSL6+utnAHVKofSarm
         g175UcbKhq1qqLygnwSaQ2pgvsxrHmNmCZuU6lhC5Ly5oAaP7kkf/UQ3pX6bSgOWpO
         SCdAXBWize4kzznRwOrYCWg5eIdLf+3zFUVi6knrnoc99UWWXGDVdKh15SW40oo7FZ
         rKVFZO94pt+t5ZV+4lhDKO3CPrc5cMwd6CQ7DC0E9AI+qyjjtCnSzsJjHxOYJI/qhz
         JMXJKr4SovnkA==
Message-ID: <3c8bd9ab-0da0-4c12-8a3e-ce1eef1499c8@collabora.com>
Date:   Tue, 7 Nov 2023 11:14:57 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/mm: check that PAGEMAP_SCAN returns correct
 categories
Content-Language: en-US
To:     Andrei Vagin <avagin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20231106220959.296568-1-avagin@google.com>
 <20231106220959.296568-2-avagin@google.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231106220959.296568-2-avagin@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 3:09 AM, Andrei Vagin wrote:
> Right now, tests read page flags from /proc/pid/pagemap files. With this
> change, tests will check that PAGEMAP_SCAN return correct information
> too.
> 
> Signed-off-by: Andrei Vagin <avagin@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/vm_util.c | 53 ++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 3082b40492dd..ec3478b96e4c 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -4,6 +4,7 @@
>  #include <dirent.h>
>  #include <sys/ioctl.h>
>  #include <linux/userfaultfd.h>
> +#include <linux/fs.h>
>  #include <sys/syscall.h>
>  #include <unistd.h>
>  #include "../kselftest.h"
> @@ -28,19 +29,65 @@ uint64_t pagemap_get_entry(int fd, char *start)
>  	return entry;
>  }
>  
> +static uint64_t pagemap_scan_get_categories(int fd, char *start)
> +{
> +	struct pm_scan_arg arg;
> +	struct page_region r;
> +	long ret;
> +
> +	arg.start = (uintptr_t)start;
> +	arg.end = (uintptr_t)(start + psize());
> +	arg.vec = (uintptr_t)&r;
> +	arg.vec_len = 1;
> +	arg.flags = 0;
> +	arg.size = sizeof(struct pm_scan_arg);
> +	arg.max_pages = 0;
> +	arg.category_inverted = 0;
> +	arg.category_mask = 0;
> +	arg.category_anyof_mask = PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN | PAGE_IS_FILE |
> +				  PAGE_IS_PRESENT | PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |
> +				  PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY;
> +	arg.return_mask = arg.category_anyof_mask;
> +
> +	ret = ioctl(fd, PAGEMAP_SCAN, &arg);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("PAGEMAP_SCAN failed: %s\n", strerror(errno));
> +	if (ret == 0)
> +		return 0;
> +	return r.categories;
> +}
> +
> +static bool page_entry_is(int fd, char *start, char *desc,
> +			  uint64_t pagemap_flags, uint64_t pagescan_flags)
> +{
> +	bool m, s;
> +
> +	m = pagemap_get_entry(fd, start) & pagemap_flags;
> +	s = pagemap_scan_get_categories(fd, start) & pagescan_flags;
> +	if (m == s)
> +		return m;
> +
> +	ksft_exit_fail_msg(
> +		"read and ioctl return unmatched results for %s: %d %d", desc, m, s);
> +	return m;
> +}
> +
>  bool pagemap_is_softdirty(int fd, char *start)
>  {
> -	return pagemap_get_entry(fd, start) & PM_SOFT_DIRTY;
> +	return page_entry_is(fd, start, "soft-dirty",
> +				PM_SOFT_DIRTY, PAGE_IS_SOFT_DIRTY);
>  }
>  
>  bool pagemap_is_swapped(int fd, char *start)
>  {
> -	return pagemap_get_entry(fd, start) & PM_SWAP;
> +	return page_entry_is(fd, start, "swap", PM_SWAP, PAGE_IS_SWAPPED);
>  }
>  
>  bool pagemap_is_populated(int fd, char *start)
>  {
> -	return pagemap_get_entry(fd, start) & (PM_PRESENT | PM_SWAP);
> +	return page_entry_is(fd, start, "populated",
> +				PM_PRESENT | PM_SWAP,
> +				PAGE_IS_PRESENT | PAGE_IS_SWAPPED);
>  }
>  
>  unsigned long pagemap_get_pfn(int fd, char *start)

-- 
BR,
Muhammad Usama Anjum
