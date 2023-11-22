Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642B67F54CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjKVXcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344066AbjKVXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:31:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E35D47
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:31:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264D8C433C8;
        Wed, 22 Nov 2023 23:31:44 +0000 (UTC)
Date:   Wed, 22 Nov 2023 18:32:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2 01/33] ftrace: Unpoison ftrace_regs in
 ftrace_ops_list_func()
Message-ID: <20231122183200.409e982b@gandalf.local.home>
In-Reply-To: <20231121220155.1217090-2-iii@linux.ibm.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
        <20231121220155.1217090-2-iii@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 23:00:55 +0100
Ilya Leoshkevich <iii@linux.ibm.com> wrote:

> Architectures use assembly code to initialize ftrace_regs and call
> ftrace_ops_list_func(). Therefore, from the KMSAN's point of view,
> ftrace_regs is poisoned on ftrace_ops_list_func entry(). This causes
> KMSAN warnings when running the ftrace testsuite.
> 
> Fix by trusting the architecture-specific assembly code and always
> unpoisoning ftrace_regs in ftrace_ops_list_func.

You must be very trusting to trust architecture-specific assembly code ;-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/trace/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8de8bec5f366..dfb8b26966aa 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7399,6 +7399,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  			       struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
> +	kmsan_unpoison_memory(fregs, sizeof(*fregs));
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, fregs);
>  }
>  #else

