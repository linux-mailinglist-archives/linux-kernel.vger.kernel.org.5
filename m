Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC57E4F57
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjKHDLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjKHDLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:11:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106821B1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 19:11:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3042DC433C8;
        Wed,  8 Nov 2023 03:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699413088;
        bh=XrfxF33CtZroqoRvXEVVo9b4OjgfMCzhx0zqg4YE8t4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lo97rqIaR3NWuDiOEw/miwFH3Pk1b7BSXgLGuhlGndfslxiuIl0pn7komQiSEqjlk
         XHBBxPiKcPKfIbWZyjhSXWUXn0FUZRSbMkIl2lrp2kFe5atwgazDzsON8ZbXHWm7of
         Jd1Lc7nJ1x7PNLpec0Whcl2PTtTu5/GIgG1fT2GvFNbELZan2bg5nNCebBNmot8UBg
         SQim/Y5pKsG/ZIpJODmRbXd7Ee8LtOJoH6t9usNF09jey5G+a5DFh7UFxYqAwqb77u
         PLN9O6v3C1nDWaQ1d25LbqSGhBz9pp9AimXwT92KVrTyw0j+axo5jVbjUcmKmzoh7g
         2hwcWarz8/yyw==
Date:   Wed, 8 Nov 2023 12:11:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v1] lib: test_objpool: make global variables static
Message-Id: <20231108121123.881efce0a736a3e98f6e99d6@kernel.org>
In-Reply-To: <20231108012248.313574-1-wuqiang.matt@bytedance.com>
References: <20231108012248.313574-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Nov 2023 09:22:48 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> Kernel test robot reported build warnings that structures g_ot_sync_ops,
> g_ot_async_ops and g_testcases should be static. These definitions are
> only used in test_objpool.c, so make them static
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311071229.WGrWUjM1-lkp@intel.com/
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Let me pick this to probes/fixes.

Thank you,

> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  lib/test_objpool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/test_objpool.c b/lib/test_objpool.c
> index a94078402138..bfdb81599832 100644
> --- a/lib/test_objpool.c
> +++ b/lib/test_objpool.c
> @@ -311,7 +311,7 @@ static void ot_fini_sync(struct ot_context *sop)
>  	ot_kfree(sop->test, sop, sizeof(*sop));
>  }
>  
> -struct {
> +static struct {
>  	struct ot_context * (*init)(struct ot_test *oc);
>  	void (*fini)(struct ot_context *sop);
>  } g_ot_sync_ops[] = {
> @@ -475,7 +475,7 @@ static struct ot_context *ot_init_async_m0(struct ot_test *test)
>  	return sop;
>  }
>  
> -struct {
> +static struct {
>  	struct ot_context * (*init)(struct ot_test *oc);
>  	void (*fini)(struct ot_context *sop);
>  } g_ot_async_ops[] = {
> @@ -632,7 +632,7 @@ static int ot_start_async(struct ot_test *test)
>  #define NODE_COMPACT sizeof(struct ot_node)
>  #define NODE_VMALLOC (512)
>  
> -struct ot_test g_testcases[] = {
> +static struct ot_test g_testcases[] = {
>  
>  	/* sync & normal */
>  	{0, 0, NODE_COMPACT, 1000, 0,  1,  0,  0, "sync: percpu objpool"},
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
