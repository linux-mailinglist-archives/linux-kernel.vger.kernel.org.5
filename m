Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D3A7A341D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjIQHmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 03:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjIQHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 03:41:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3642E18C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 00:41:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116BBC433C7;
        Sun, 17 Sep 2023 07:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694936504;
        bh=APaNspLALsiBsFXQNIWCkSkFARw/RMvsiO/lb4zZxy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kn0/lfu3IwSGV+LowwyzpZuBOA7AV6mYAiKLPKFoUYSTFsbmGTdRAbBBcXR0mgLEb
         CP8TaHx/NfzCo/WGlfxreGMn5u5BOb5KeUx0ugScy+jdn3Km3iz0yS4m8Q70IHR6to
         f7tZ9DxEOSsKHiZy1V1D/goquQOeM5/JcomtiZslCtv37Qnwxg5B38iOnj5aCvwRQ6
         5FxOhXX9ovGDoqd9mbdXq1n8XM3OGn8TyPd51isg+rbvAvlwwAmeOeWQjiRMy+pskF
         WWBbkLq43YugVf18hmH/1u/kqxnb+4oArdq0CYPkbWbeHF5b26WEyuZOSOStxCJW65
         QaIBW3e15AtIg==
Date:   Sun, 17 Sep 2023 10:41:05 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH]  x86,kexec,ima: use memblock_free_late from
 ima_free_kexec_buffer
Message-ID: <20230917074105.GC3303@kernel.org>
References: <20230908233127.0af375d1@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908233127.0af375d1@imladris.surriel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 11:31:27PM -0400, Rik van Riel wrote:
> The code calling ima_free_kexec_buffer runs long after the memblock
> allocator has already been torn down, potentially resulting in a use
> after free in memblock_isolate_range.
> 
> With KASAN or KFENCE, this use after free will result in a BUG
> from the idle task, and a subsequent kernel panic.
> 
> Switch ima_free_kexec_buffer over to memblock_free_late to avoid
> that issue.
> 
> Fixes: fee3ff99bc67 ("powerpc: Move arch independent ima kexec functions to drivers/of/kexec.c")
> Cc: stable@kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Mike Rappoport <rppt@kernel.org>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/x86/kernel/setup.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index b9145a63da77..b098b1fa2470 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -358,15 +358,11 @@ static void __init add_early_ima_buffer(u64 phys_addr)
>  #if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
>  int __init ima_free_kexec_buffer(void)
>  {
> -	int rc;
> -
>  	if (!ima_kexec_buffer_size)
>  		return -ENOENT;
>  
> -	rc = memblock_phys_free(ima_kexec_buffer_phys,
> -				ima_kexec_buffer_size);
> -	if (rc)
> -		return rc;
> +	memblock_free_late(ima_kexec_buffer_phys,
> +			   ima_kexec_buffer_size);
>  
>  	ima_kexec_buffer_phys = 0;
>  	ima_kexec_buffer_size = 0;
> -- 
> 2.41.0
> 
> 

-- 
Sincerely yours,
Mike.
