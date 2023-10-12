Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E326C7C738E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379464AbjJLQ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347332AbjJLQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:56:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D8FC6;
        Thu, 12 Oct 2023 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V4rFGSP5JFIEI2sq2NeM0mZr8WrfWiX4hsfdvnzQej4=; b=Qtqa/PNKC1EliRxvyGVMNzwj2P
        1qpTg4Ywi9r25/rsElVnmV9Vt68C2M3a8yjFgL4qVQ8RESrg8briEKKjsehAjS8YsYUHnx2HJqiK3
        GX+GtACMktsh9zisAwaUgMPcJHLP9Kt4HmuZKdt6Q+d/12hQzWZLT3qPo+R5dBupEXfG6RdOGZY1l
        PHXe/WX4OY2vB6piX3TuUHxcyLzN+nLx8EGAHm8AOEsqx+857nzF5NWQMPDpB629CkFURaoYEUsBh
        1GZTSOaMPZgUbpblEZe/Dygt1HVh3fqUY2/ccIOfSvTDrQVcPGrDfgcY9jcGBkmUGTeFl3St6Zb5h
        TV8FmNEA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqyyw-001T60-1S;
        Thu, 12 Oct 2023 16:56:18 +0000
Date:   Thu, 12 Oct 2023 09:56:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joey Jiao <quic_jiangenj@quicinc.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] module: Add CONFIG_MODULE_DISABLE_INIT_FREE option
Message-ID: <ZSglMlKdvhpNq2Vy@bombadil.infradead.org>
References: <20231012014720.19748-1-quic_jiangenj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012014720.19748-1-quic_jiangenj@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 07:17:19AM +0530, Joey Jiao wrote:
>  
> +config MODULE_DISABLE_INIT_FREE
> +	bool "Disable freeing of init sections"
> +	default n
> +	help
> +	  By default, kernel will free init sections after module being fully
> +	  loaded.
> +
> +	  MODULE_DISABLE_INIT_FREE allows users to prevent the freeing of init
> +	  sections. This option is particularly helpful for syzkaller fuzzing,
> +	  ensuring that the module consistently loads into the same address
> +	  across reboots.

How and why does not free'ing init help with syzkaller exactly? I don't
see the relationship between not free'ing init and ensuring th emodule
loads into the same address. There could be many things which could
incur an address gets allocated from a module at another location which
a module can take. I cannot fathom how this simple toggle could ensure
modules following the address allocations accross reboots. That seems
like odd chance, not something actually deterministic.

> +
>  endif # MODULES
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 98fedfdb8db5..0f242b7b29fe 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2593,7 +2593,8 @@ static noinline int do_init_module(struct module *mod)
>  	 * be cleaned up needs to sync with the queued work - ie
>  	 * rcu_barrier()
>  	 */
> -	if (llist_add(&freeinit->node, &init_free_list))
> +	if (llist_add(&freeinit->node, &init_free_list) &&
> +		!IS_ENABLED(CONFIG_MODULE_DISABLE_INIT_FREE))
>  		schedule_work(&init_free_wq);


