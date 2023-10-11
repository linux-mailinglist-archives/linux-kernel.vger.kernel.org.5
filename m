Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E427E7C4D55
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjJKIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJKIff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:35:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8FA93;
        Wed, 11 Oct 2023 01:35:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 647541FDE0;
        Wed, 11 Oct 2023 08:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697013332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQCMhVkGK0KEiWJk03Hrnl55AUUio//OS/Yw6YhNLx4=;
        b=xoK9v6AqjGyzyqqdwNNonK4Yq8cpD7QWWHef2vCkdTA3qiZdRHsad9OmHUs0Zi7sBiUhrn
        /eN3BxdfWSeU9O/3RbOi/7axgr1UPi2Y/coG7NJ25kspc3FOBirsdAcRx8PLl5o4ihRhTg
        NK6mUZcAadIflI/RsmdtWetg3GOI3Jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697013332;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQCMhVkGK0KEiWJk03Hrnl55AUUio//OS/Yw6YhNLx4=;
        b=zzSLTWf5sedJ06koAas/MG68a62y0FI4RA1N9u6JUFy8QeH9I0gheB7LeQuWmFFCe/7yHH
        g+snkQ2RK4Qzd5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42DCB138EF;
        Wed, 11 Oct 2023 08:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qiF0D1ReJmXAJAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 11 Oct 2023 08:35:32 +0000
Message-ID: <7b94fcb3-9ffe-1fc8-3f9d-6a7176069aeb@suse.cz>
Date:   Wed, 11 Oct 2023 10:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] mm: abstract the vma_merge()/split_vma() pattern
 for mprotect() et al.
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <cover.1696929425.git.lstoakes@gmail.com>
 <b9bf27ff9ac19985f9ce966b83a7dbbe25a31f9d.1696929425.git.lstoakes@gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b9bf27ff9ac19985f9ce966b83a7dbbe25a31f9d.1696929425.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 20:23, Lorenzo Stoakes wrote:
> mprotect() and other functions which change VMA parameters over a range
> each employ a pattern of:-
> 
> 1. Attempt to merge the range with adjacent VMAs.
> 2. If this fails, and the range spans a subset of the VMA, split it
>    accordingly.
> 
> This is open-coded and duplicated in each case. Also in each case most of
> the parameters passed to vma_merge() remain the same.
> 
> Create a new function, vma_modify(), which abstracts this operation,
> accepting only those parameters which can be changed.
> 
> To avoid the mess of invoking each function call with unnecessary
> parameters, create inline wrapper functions for each of the modify
> operations, parameterised only by what is required to perform the action.
> 
> We can also significantly simplify the logic - by returning the VMA if we
> split (or merged VMA if we do not) we no longer need specific handling for
> merge/split cases in any of the call sites.
> 
> Note that the userfaultfd_release() case works even though it does not
> split VMAs - since start is set to vma->vm_start and end is set to
> vma->vm_end, the split logic does not trigger.
> 
> In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
> - vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
> instance, this invocation will remain unchanged.
> 
> We eliminate a VM_WARN_ON() in mprotect_fixup() as this simply asserts that
> vma_merge() correctly ensures that flags remain the same, something that is
> already checked in is_mergeable_vma() and elsewhere, and in any case is not
> specific to mprotect().
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  fs/userfaultfd.c   | 71 +++++++++++++---------------------------------
>  include/linux/mm.h | 60 +++++++++++++++++++++++++++++++++++++++
>  mm/madvise.c       | 26 +++--------------
>  mm/mempolicy.c     | 26 ++---------------
>  mm/mlock.c         | 25 +++-------------
>  mm/mmap.c          | 48 +++++++++++++++++++++++++++++++
>  mm/mprotect.c      | 29 +++----------------
>  7 files changed, 142 insertions(+), 143 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index a7c6ef764e63..911ab5740a52 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c

<snip>

> @@ -1671,26 +1651,13 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			uffd_wp_range(vma, start, vma_end - start, false);
>  
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> -		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, pgoff,
> -				 vma_policy(vma),
> -				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> -		if (prev) {
> -			vma = prev;
> -			goto next;
> -		}
> -		if (vma->vm_start < start) {
> -			ret = split_vma(&vmi, vma, start, 1);
> -			if (ret)
> -				break;
> -		}
> -		if (vma->vm_end > end) {
> -			ret = split_vma(&vmi, vma, end, 0);
> -			if (ret)
> -				break;
> +		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> +					    new_flags, NULL_VM_UFFD_CTX);
> +		if (IS_ERR(vma)) {
> +			ret = PTR_ERR(prev);

This needs to be PTR_ERR(vma)? Probably v2 leftover.

> +			break;
>  		}
> -	next:
> +
>  		/*
>  		 * In the vma_merge() successful mprotect-like case 8:
>  		 * the next vma was merged into the current one and

