Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFED760F80
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjGYJj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjGYJji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:39:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C81BD8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:39:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7F6C4222A9;
        Tue, 25 Jul 2023 09:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690277929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M/fb9U4sUdPHFWFNYTFOglXTMUSDaspUuygCKmGisj8=;
        b=qoB5We5Jr4OyHZbxtGAByAR98cifEkZosUxgoW5JskM3d3ppepRGNhU6Q2+xV/ueAWdxDk
        IdMy6em0/BRbKRojw/dLTYz1LpqM2VuXw0xIPDmvWqKlFSr7H3eqbGGsTswGq5mhiomdtr
        BgsjIjiXNHbghHePQzLuvZiLVZSfxoI=
Received: from suse.cz (dhcp108.suse.cz [10.100.51.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7FFB92C142;
        Tue, 25 Jul 2023 09:38:46 +0000 (UTC)
Date:   Tue, 25 Jul 2023 11:38:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Rong Tao <rongtao@cestc.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples/hw_breakpoint: fix building without module
 unloading
Message-ID: <ZL-YKHxMfTIg16Hl@alley>
References: <20230725082546.941346-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725082546.941346-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-07-25 10:25:36, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> __symbol_put() is really meant as an internal helper and is not available
> when module unloading is disabled, unlike the previously used symbol_put():

Ah, I have missed this.

> samples/hw_breakpoint/data_breakpoint.c: In function 'hw_break_module_exit':
> samples/hw_breakpoint/data_breakpoint.c:73:9: error: implicit declaration of function '__symbol_put'; did you mean '__symbol_get'? [-Werror=implicit-function-declaration]
> 
> The hw_break_module_exit() function is not actually used when module
> unloading is disabled, but it still causes the build failure for an
> undefined identifier. Enclose this one call in an appropriate #ifdef to
> clarify what the requirement is. Leaving out the entire exit function
> would also work but feels less clar in this case.

> --- a/samples/hw_breakpoint/data_breakpoint.c
> +++ b/samples/hw_breakpoint/data_breakpoint.c
> @@ -70,7 +70,9 @@ static int __init hw_break_module_init(void)
>  static void __exit hw_break_module_exit(void)
>  {
>  	unregister_wide_hw_breakpoint(sample_hbp);
> +#ifdef CONFIG_MODULE_UNLOAD
>  	__symbol_put(ksym_name);
> +#endif
>  	printk(KERN_INFO "HW Breakpoint for %s write uninstalled\n", ksym_name);
>  }

I see that both symbol_put() and symbol_put_addr() are defined
as noops twice:

   + when !defined(CONFIG_MODULE_UNLOAD)
   + when !defined(CONFIG_MODULES)

This patch is enough because samples/hw_breakpoint/data_breakpoint.c
could be built only as a module, so feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

But even better solution would be to define symbol_put_name() as
a noop in both situations and use it.

Best Regards,
Petr
