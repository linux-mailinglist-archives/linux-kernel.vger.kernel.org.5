Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6958C7DFE62
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 04:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjKCD13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 23:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKCD11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 23:27:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2741A19E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 20:27:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45865C433C7;
        Fri,  3 Nov 2023 03:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698982043;
        bh=9LT1+qDnNn2RNVUpkmD/wQ5PnuRan+wlGSZF4IJKXj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hZEBM6jA7kPxoqpEu7bNHQCacASE0ulPskriERVuBGaqrYc5oDBxo2EpDF/ksZvZg
         KAJ1QQUCXTmiom3C2rT8JPWta+B0dfFhQrQopm19u61L0h38+sY/D+UVV8c34q2+8F
         58LzL/Ud6/UaphDbCoSNztt9PyHXumQAJyez7hhJ/2Hv9wOhDeDvozqCnHFu4UsMRB
         +4G/DT0+tedMCIPe8NowyOpjUK27PQWEkoioQHbdnfxggh/weC9ehF3L/JrNUJGgY4
         Y/vW3iCY0qL/0XD7ngACJ3Q0+swTatxapPZKkSZN7xLC9MmcrUoOZOZs0Lf37UvA45
         U6mT6AJcLvJ/A==
Date:   Fri, 3 Nov 2023 12:27:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH for-next] tracing/kprobes: Add symbol counting check
 when module loads
Message-Id: <20231103122719.829de1daad83a08fe09ab2bd@kernel.org>
In-Reply-To: <5987802.lOV4Wx5bFT@pwmachine>
References: <169854904604.132316.12500381416261460174.stgit@devnote2>
        <1868732.tdWV9SEqCh@pwmachine>
        <20231101081509.605080231a2736b91331cb85@kernel.org>
        <5987802.lOV4Wx5bFT@pwmachine>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2023 14:57:12 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Hi!
> 
> Le mercredi 1 novembre 2023, 01:15:09 EET Masami Hiramatsu a écrit :
> > Hi,
> > 
> > On Tue, 31 Oct 2023 23:24:43 +0200
> > 
> > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > @@ -729,17 +744,55 @@ static int count_mod_symbols(void *data, const
> > > > char
> > > > *name, unsigned long unused) return 0;
> > > > 
> > > >  }
> > > > 
> > > > -static unsigned int number_of_same_symbols(char *func_name)
> > > > +static unsigned int number_of_same_symbols(const char *mod, const char
> > > > *func_name) {
> > > > 
> > > >  	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
> > > > 
> > > > -	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
> > > > +	if (!mod)
> > > > +		kallsyms_on_each_match_symbol(count_symbols, func_name,
> > > 
> > > &ctx.count);
> > > 
> > > > -	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
> > > > +	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
> > > 
> > > I may be missing something here or reviewing too quickly.
> > > Wouldn't this function return count to be 0 if func_name is only part of
> > > the module named mod?
> > 
> > No, please read below.
> > 
> > > Indeed, if the function is not in kernel symbol,
> > > kallsyms_on_each_match_symbol() will not loop.
> > > And, by giving mod to module_kallsyms_on_each_symbol(), the corresponding
> > > module will be skipped, so count_mob_symbols() would not be called.
> > > Hence, we would have 0 as count, which would lead to ENOENT later.
> > 
> > Would you mean the case func_name is on the specific module?
> > If 'mod' is specified, module_kallsyms_on_each_symbol() only loops on
> > symbols in the module names 'mod'.
> > 
> > int module_kallsyms_on_each_symbol(const char *modname,
> >                                    int (*fn)(void *, const char *, unsigned
> > long), void *data)
> > {
> >         struct module *mod;
> >         unsigned int i;
> >         int ret = 0;
> > 
> >         mutex_lock(&module_mutex);
> >         list_for_each_entry(mod, &modules, list) {
> >                 struct mod_kallsyms *kallsyms;
> > 
> >                 if (mod->state == MODULE_STATE_UNFORMED)
> >                         continue;
> > 
> >                 if (modname && strcmp(modname, mod->name))
> >                         continue;
> > ...
> > 
> > So with above change, 'if mod is not specified, search the symbols in kernel
> > and all modules. If mod is sepecified, search the symbol on the specific
> > module'.
> > 
> > Thus, "if func_name is only part of the module named mod", the
> > module_kallsyms_on_each_symbol() will count the 'func_name' in 'mod' module
> > correctly.
> 
> Sorry, I looked to quickly and forgot about the return value of strcmp()...

No problem, strcmp() always traps us :)

> 
> From the code, everything seems OK!
> If I have some time, I will test it and potentially come back with a "Tested-
> by" tag but without any warranty.


Thank you!



> 
> > Thank you,
> > 
> > 
> > Thank you,
> 
> Best regards.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
