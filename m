Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EC67E2C26
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjKFSky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjKFSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:40:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43847A2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:40:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBD2C433C8;
        Mon,  6 Nov 2023 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699296049;
        bh=ySS1W0Ki+weixhaKVOMuwHjGI1PUiM9vnD8heeyo3GY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HWht/2qopG8QEr/1Hu1hJ7JcorRlrr1oT74fBpBNJYoP7EWqYeRLdDPeOgZdRfrEH
         PmtYOM58qJxzMIAgdO7I/i/k4HbHKZ9Rcv5mvdeTT6WMjAG5znKlxYMdG0qCYw6uuh
         Pxb+EG37USSEuQkUz7xsV2K2i2+pomTJgOWKbjh8=
Date:   Mon, 6 Nov 2023 10:40:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] mm:vmscan: fix return negative unneed to detect VM_EXEC
Message-Id: <20231106104049.1ed5ba7976f0c0633fb729f5@linux-foundation.org>
In-Reply-To: <20231025154432.314-1-justinjiang@vivo.com>
References: <20231025154432.314-1-justinjiang@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 23:44:32 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:

> The reason that folio_referenced() returns negative is because
> rwc.contended is 1, vm_flags is 0 at this time and so there is
> no need to detect VM_EXEC. And only when referenced > 0, pra->vm_flags
> will be filled with vma->vm_flags in folio_referenced_one().
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2095,7 +2095,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  
>  		/* Referenced or rmap lock contention: rotate */
>  		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
> -				     &vm_flags) != 0) {
> +				     &vm_flags) > 0) {
>  			/*
>  			 * Identify referenced, file-backed active folios and
>  			 * give them one more trip around the active list. So

I suspect this email did not make it through the linux-mm server.  I
can't find it in my archive or at https://lore.kernel.org/linux-mm/.

So please resend?  Prior to doing so, please update the changelog to
describe the before- and after- userspace visible effects of the
change.

Thanks.
