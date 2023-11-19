Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE17F0742
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKSPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:54:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D28C0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:54:24 -0800 (PST)
Received: from [100.98.85.67] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4EB146602F2E;
        Sun, 19 Nov 2023 15:54:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700409262;
        bh=fW2ihMsH4k3bg/a3NV4eyz3V5tCtUH+zAhUHRItn2/Q=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=h4KeTh5d6oYOxNuOIOykmJZSmVYkMQLrBElYZF3xrAK21Uua7aQNoH17lSWsJTXZu
         waYfsC8OKwPBbVeEW0b4YDBVEREs3gELk6ICKcemnzRPu205RXl3c9iD5OsYKq/LWk
         pMVZlGZc1/ESL5fYWCU7OAB0MK/PaXJzw0gSA4+ur0ah7uuPVvowyRJvW5aguc62zw
         1O8WJAJKqU5ORDzb8Hlgub80L+6r74vR+sELnXqIHsRvRRSK1e/ESi9GxW6N0mxJl+
         4ikzywIxJZgB9iEwvl0dq2Aa3sSaa8wpfFCMvs/InfbUIo/lcifNxlvfqashUD+uQc
         bZCHTdPjTRN0A==
Message-ID: <9d257ca7-c823-4427-8f57-cbe53b0c3b54@collabora.com>
Date:   Sun, 19 Nov 2023 10:54:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/3] mm/pagemap: Fix ioctl(PAGEMAP_SCAN) on vma check
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231116201547.536857-1-peterx@redhat.com>
 <20231116201547.536857-2-peterx@redhat.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231116201547.536857-2-peterx@redhat.com>
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

Hi Peter,

Thank you for taking care of it. I'm on holidays after LPC.

On 11/16/23 3:15 PM, Peter Xu wrote:
> The new ioctl(PAGEMAP_SCAN) relies on vma wr-protect capability provided by
> userfault, however in the vma test it didn't explicitly require the vma to
> have wr-protect function enabled, even if PM_SCAN_WP_MATCHING flag is set.
> 
> It means the pagemap code can now apply uffd-wp bit to a page in the vma
> even if not registered to userfaultfd at all.
> 
> Then in whatever way as long as the pte got written and page fault
> resolved, we'll apply the write bit even if uffd-wp bit is set.  We'll see
> a pte that has both UFFD_WP and WRITE bit set.  Anything later that looks
> up the pte for uffd-wp bit will trigger the warning:
> 
> WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
> 
> Fix it by doing proper check over the vma attributes when
> PM_SCAN_WP_MATCHING is specified.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Reported-by: syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/proc/task_mmu.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 51e0ec658457..e91085d79926 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1994,15 +1994,31 @@ static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
>  	struct pagemap_scan_private *p = walk->private;
>  	struct vm_area_struct *vma = walk->vma;
>  	unsigned long vma_category = 0;
> +	bool wp_allowed = userfaultfd_wp_async(vma) &&
> +	    userfaultfd_wp_use_markers(vma);
>  
> -	if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
> -		vma_category |= PAGE_IS_WPALLOWED;
> -	else if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
> -		return -EPERM;
> +	if (!wp_allowed) {
> +		/* User requested explicit failure over wp-async capability */
> +		if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
> +			return -EPERM;
> +		/*
> +		 * User requires wr-protect, and allows silently skipping
> +		 * unsupported vmas.
> +		 */
> +		if (p->arg.flags & PM_SCAN_WP_MATCHING)
> +			return 1;
> +		/*
> +		 * Then the request doesn't involve wr-protects at all,
> +		 * fall through to the rest checks, and allow vma walk.
> +		 */
> +	}
Very simply done. I've really liked it.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

>  
>  	if (vma->vm_flags & VM_PFNMAP)
>  		return 1;
>  
> +	if (wp_allowed)
> +		vma_category |= PAGE_IS_WPALLOWED;
> +
>  	if (vma->vm_flags & VM_SOFTDIRTY)
>  		vma_category |= PAGE_IS_SOFT_DIRTY;
>  

-- 
BR,
Muhammad Usama Anjum
