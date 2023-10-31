Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B027DD92A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjJaXPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjJaXPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:15:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D6F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:15:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD56EC433C8;
        Tue, 31 Oct 2023 23:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698794113;
        bh=pejAIftFE2imDJQpddTcrQQ2QqxCdUUSl8uEj814KDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FQVtNDT6Ryb9s+ZkcHNKvpyiBy3ZLiy8zXZ+Ba69XXSzqWSnWbkcXZ0wk0xtnXMvN
         L1X21up2oQfWirzDaxoGHJUaEGGNhxMAvmuLfavOXhqvTs5yJPOsnurYcsVadeeVQ6
         KycDFo3V6Uc7SmlEOOLlI1IbGOuy3pdNvl+NEHcrw7yg/obCRyAyltjMcSaryt5Y5e
         N8PiJ6xATCT7mcxqpzFvWMrTRkjBpidk3K+T4SVxzdwVKwcEnyAxwIpMegkg0r4nfT
         oRMOk8poIqDn3V5GtXm+M5xjAFVJ79uXMa/bfefIjeo4FknB1W1qK1wsLCWAg0nqmY
         0JZtym9UoJV0A==
Date:   Wed, 1 Nov 2023 08:15:09 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH for-next] tracing/kprobes: Add symbol counting check
 when module loads
Message-Id: <20231101081509.605080231a2736b91331cb85@kernel.org>
In-Reply-To: <1868732.tdWV9SEqCh@pwmachine>
References: <169854904604.132316.12500381416261460174.stgit@devnote2>
        <1868732.tdWV9SEqCh@pwmachine>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 31 Oct 2023 23:24:43 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> > @@ -729,17 +744,55 @@ static int count_mod_symbols(void *data, const char
> > *name, unsigned long unused) return 0;
> >  }
> > 
> > -static unsigned int number_of_same_symbols(char *func_name)
> > +static unsigned int number_of_same_symbols(const char *mod, const char
> > *func_name) {
> >  	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
> > 
> > -	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
> > +	if (!mod)
> > +		kallsyms_on_each_match_symbol(count_symbols, func_name, 
> &ctx.count);
> > 
> > -	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
> > +	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
> 
> I may be missing something here or reviewing too quickly.
> Wouldn't this function return count to be 0 if func_name is only part of the 
> module named mod?

No, please read below.

> Indeed, if the function is not in kernel symbol, 
> kallsyms_on_each_match_symbol() will not loop.
> And, by giving mod to module_kallsyms_on_each_symbol(), the corresponding 
> module will be skipped, so count_mob_symbols() would not be called.
> Hence, we would have 0 as count, which would lead to ENOENT later.

Would you mean the case func_name is on the specific module?
If 'mod' is specified, module_kallsyms_on_each_symbol() only loops on
symbols in the module names 'mod'.

int module_kallsyms_on_each_symbol(const char *modname,
                                   int (*fn)(void *, const char *, unsigned long),
                                   void *data)
{
        struct module *mod;
        unsigned int i;
        int ret = 0;

        mutex_lock(&module_mutex);
        list_for_each_entry(mod, &modules, list) {
                struct mod_kallsyms *kallsyms;

                if (mod->state == MODULE_STATE_UNFORMED)
                        continue;

                if (modname && strcmp(modname, mod->name))
                        continue;
...

So with above change, 'if mod is not specified, search the symbols in kernel 
and all modules. If mod is sepecified, search the symbol on the specific
module'.

Thus, "if func_name is only part of the module named mod", the
module_kallsyms_on_each_symbol() will count the 'func_name' in 'mod' module
correctly.

Thank you,


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
