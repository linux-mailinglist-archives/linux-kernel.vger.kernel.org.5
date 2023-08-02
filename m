Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820E476D0BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjHBO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjHBO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64EA11F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 544CE617F0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F19C433C8;
        Wed,  2 Aug 2023 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690988333;
        bh=B7PJRVoGZn23p+r9ALJfQkaFSMSdvGQQe71SQW5MouE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mFSg7MtuMOK79DRkwdkU1CdTUuLXgUd5UXk21tLHtAp2+//+xfRPaGBeq6q+c+8V5
         PchdJkSbL89oPhlZ1LqTQ0RluHHPPJ4dmC7ExFVW4BjAtW59549gjAO8Liq+A2AFzr
         KBqjk3Y/yN2afvObEQkvHOn45mc2ClgEoM++82Q/FFKOXS4pKl7dhMtfgUPhTBG1NX
         5U2Ko34ctP+R5STcvGTLg/ndWCFbaanRDFCx6/PP8XT+xpIwuD7aFB499wHKo41APy
         zmvXRuBkfcxK2E3CnSySGbgYgjB5ml5HhmYZtRiZLlst16MDSNVNyXN563YsQfy9B1
         kJ6istljo0Njw==
Date:   Wed, 2 Aug 2023 17:58:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de
Subject: Re: [PATCH 1/2] mm: Mark nr_node_ids __ro_after_init
Message-ID: <20230802145809.GE2607694@kernel.org>
References: <20230802112458.230221601@infradead.org>
 <20230802112525.564928240@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802112525.564928240@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 01:24:59PM +0200, Peter Zijlstra wrote:
> Just like nr_cpu_ids, nr_node_ids covers the side of possible_map and
> is thus constant after init.
> 
> Mark the variable __ro_after_init to both improve performance and
> enhance security, since the variable is exported. A module writing to
> it would be 'unfortunate'.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/page_alloc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -305,7 +305,7 @@ int movable_zone;
>  EXPORT_SYMBOL(movable_zone);
>  
>  #if MAX_NUMNODES > 1
> -unsigned int nr_node_ids __read_mostly = MAX_NUMNODES;
> +unsigned int nr_node_ids __ro_after_init = MAX_NUMNODES;
>  unsigned int nr_online_nodes __read_mostly = 1;
>  EXPORT_SYMBOL(nr_node_ids);
>  EXPORT_SYMBOL(nr_online_nodes);
> 
> 

-- 
Sincerely yours,
Mike.
