Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA3B78B135
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjH1M7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjH1M64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:58:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DD3123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sW6LnirGj6+UAWdXfqY7HvMqDfZlm+4cGoHT4etwnio=; b=DwxaEdEkOpnHUeh+o4K6hwLan+
        J4jaFWBUR3yQ8qBIJGOGRiZ69PArsWJEltwc9GFb+6rpYbI0sn+uvAQ9H1Qoo6FYAaDEMTgmP6SnP
        YefpfQQfdJaKgSgL4ayk/6Fd+F7vHy7OR5EXrtVKsvCycvMj1BGoN6KB5vt9AhZALiYefwPdwIpCK
        PC/jazFaJ1vUh9Vyc/FsI+75VfPkBmpR1JDL91UQ8qq2lptsdZ5oHcxMzwBsNlALQNyvoMg62r120
        8/e0XK56De7ZVoQS4XfqDDSX04PZtEpxkp9EZEg3vFNKVEebAXsDtdFEZ0yjX3fk4yeKziwG7S51h
        osWPvy6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qabp6-000Mau-9z; Mon, 28 Aug 2023 12:58:28 +0000
Date:   Mon, 28 Aug 2023 13:58:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xie XiuQi <xiexiuqi@huaweicloud.com>
Cc:     akpm@linux-foundation.org, irogers@google.com, acme@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] tools/mm: fix undefined reference to pthread_once
Message-ID: <ZOyZ9FgRUOGPh3qm@casper.infradead.org>
References: <20230828122157.1541087-1-xiexiuqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828122157.1541087-1-xiexiuqi@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:21:57PM +0800, Xie XiuQi wrote:
> diff --git a/tools/mm/Makefile b/tools/mm/Makefile
> index 6c1da51f4177..9997b2e401ae 100644
> --- a/tools/mm/Makefile
> +++ b/tools/mm/Makefile
> @@ -9,7 +9,7 @@ LIB_DIR = ../lib/api
>  LIBS = $(LIB_DIR)/libapi.a
>  
>  CFLAGS += -Wall -Wextra -I../lib/
> -LDFLAGS += $(LIBS)
> +LDFLAGS += $(LIBS) -lpthread

Is this the right fix?  I'm pretty sure you're suppose to use -pthread
in CFLAGS in case there are other things the compiler/linker/whatever
need.

'-pthread'
     Define additional macros required for using the POSIX threads
     library.  You should use this option consistently for both
     compilation and linking.  This option is supported on GNU/Linux
     targets, most other Unix derivatives, and also on x86 Cygwin and
     MinGW targets.

