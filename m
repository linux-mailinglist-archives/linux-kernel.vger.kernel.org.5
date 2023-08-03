Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219FE76E24A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjHCIA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHCIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:00:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3605A4239
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:48:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC52A219C4;
        Thu,  3 Aug 2023 07:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691048894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WeMsOzXlxvCejYnrxUhfCgP4tceAgG/CNRKt23OGuuA=;
        b=gOTje9xmo+3RbqEQOJvHyFL3yKgE9G9NwkYHgx/Sk31KKd6F4WHPaaIxHgTx2hF2dovYTi
        rIG4FwaGyT5f1VxZZhipTN26Db9adIv+OkxVTj40uG9MnzWL9zA2oPQWw+4JFQMJoTA4i1
        7FP/8MhxFACPjCslca41aDbGjYsthA0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4C521333C;
        Thu,  3 Aug 2023 07:48:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y5T2KL5by2RGPAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 03 Aug 2023 07:48:14 +0000
Date:   Thu, 3 Aug 2023 09:48:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog/hardlockup: Avoid large stack frames in
 watchdog_hardlockup_check()
Message-ID: <ZMtbvscFCtu9WRCe@dhcp22.suse.cz>
References: <20230802122555.v2.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802122555.v2.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-08-23 12:26:00, Douglas Anderson wrote:
> After commit 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to
> watchdog_hardlockup_check()") we started storing a `struct cpumask` on
> the stack in watchdog_hardlockup_check(). On systems with
> CONFIG_NR_CPUS set to 8192 this takes up 1K on the stack. That
> triggers warnings with `CONFIG_FRAME_WARN` set to 1024.
> 
> Instead of putting this `struct cpumask` on the stack, we'll allocate
> it on the heap whenever userspace tells us that they want to backtrace
> all CPUs upon a hardlockup.
> 
> NOTE: the reason that this mask is even needed is to make sure that we
> can print the hung CPU first, which makes the logs much easier to
> understand.
> 
> Fixes: 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to watchdog_hardlockup_check()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202307310955.pLZDhpnl-lkp@intel.com
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Allocate space when userspace requests all cpus be backtraced.
> 
>  kernel/watchdog.c | 44 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index be38276a365f..25d5627a6580 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -93,6 +93,8 @@ static DEFINE_PER_CPU(bool, watchdog_hardlockup_warned);
>  static DEFINE_PER_CPU(bool, watchdog_hardlockup_touched);
>  static unsigned long watchdog_hardlockup_all_cpu_dumped;
>  
> +static struct cpumask *hardlockup_backtrace_mask;
> +
>  notrace void arch_touch_nmi_watchdog(void)
>  {
>  	/*
> @@ -106,6 +108,29 @@ notrace void arch_touch_nmi_watchdog(void)
>  }
>  EXPORT_SYMBOL(arch_touch_nmi_watchdog);
>  
> +static int hardlockup_all_cpu_backtrace_proc_handler(struct ctl_table *table, int write,
> +		  void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret;
> +
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +
> +	/*
> +	 * Only allocate memory for the backtrace mask if userspace actually
> +	 * wants to trace all CPUs since this can take up 1K of space on a
> +	 * system with CONFIG_NR_CPUS=8192.
> +	 */
> +	if (sysctl_hardlockup_all_cpu_backtrace && !hardlockup_backtrace_mask) {
> +		hardlockup_backtrace_mask =
> +			   kzalloc(sizeof(*hardlockup_backtrace_mask), GFP_KERNEL);
> +	} else if (!sysctl_hardlockup_all_cpu_backtrace && hardlockup_backtrace_mask) {
> +		kfree(hardlockup_backtrace_mask);
> +		hardlockup_backtrace_mask = NULL;
> +	}

While unlikely, this can race with the consumer and cause either
use-after-free or NULL ptr deref.
-- 
Michal Hocko
SUSE Labs
