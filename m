Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D347F5A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbjKWIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:51:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2A792
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:51:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D3FA221902;
        Thu, 23 Nov 2023 08:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700729467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=udBEUjYcPicLpK46H3BbzFQivSojujoRMSapQr3MUVo=;
        b=dHfHv2fZn1fRdP0GHiHbDgFUEmZ5n5tImiYp1lahaLPUzW4Fjt7OKxcmO6cuPGzIf0sfnB
        BoImydeJY0XJhQqW6+ZWcZDLJKOAivvoGi0spri9lCnUwFcoupJCIm5oMqrsQfgy3JvJhP
        1gT4EUVoSF1vPR/TP2xMs3/SK+Pu3ac=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A82AC133B6;
        Thu, 23 Nov 2023 08:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cmn3JXsSX2XbCgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 23 Nov 2023 08:51:07 +0000
Date:   Thu, 23 Nov 2023 09:51:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     gaoxu <gaoxu2@hihonor.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>
Subject: Re: [PATCH] mm,oom_reaper: avoid run queue_oom_reaper if task is not
 oom
Message-ID: <ZV8SenfRYnkKwqu6@tiehlicka>
References: <400d13bddb524ef6af37cb2220808c75@hihonor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400d13bddb524ef6af37cb2220808c75@hihonor.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.07
X-Spamd-Result: default: False [-0.07 / 50.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.97)[99.85%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 12:46:44, gaoxu wrote:
> The function queue_oom_reaper tests and sets tsk->signal->oom_mm->flags.
> However, it is necessary to check if 'tsk' is an OOM victim before
> executing 'queue_oom_reaper' because the variable may be NULL.
> 
> We encountered such an issue, and the log is as follows:
> [3701:11_see]Out of memory: Killed process 3154 (system_server)
> total-vm:23662044kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB,
> UID:1000 pgtables:4056kB oom_score_adj:-900

> [3701:11_see][RB/E]rb_sreason_str_set: sreason_str set null_pointer
> [3701:11_see][RB/E]rb_sreason_str_set: sreason_str set unknown_addr

What are these?

> [3701:11_see]Unable to handle kernel NULL pointer dereference at virtual
> address 0000000000000328
> [3701:11_see]user pgtable: 4k pages, 39-bit VAs, pgdp=00000000821de000
> [3701:11_see][0000000000000328] pgd=0000000000000000,
> p4d=0000000000000000,pud=0000000000000000
> [3701:11_see]tracing off
> [3701:11_see]Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [3701:11_see]Call trace:
> [3701:11_see] queue_oom_reaper+0x30/0x170

Could you resolve this offset into the code line please?

> [3701:11_see] __oom_kill_process+0x590/0x860
> [3701:11_see] oom_kill_process+0x140/0x274
> [3701:11_see] out_of_memory+0x2f4/0x54c
> [3701:11_see] __alloc_pages_slowpath+0x5d8/0xaac
> [3701:11_see] __alloc_pages+0x774/0x800
> [3701:11_see] wp_page_copy+0xc4/0x116c
> [3701:11_see] do_wp_page+0x4bc/0x6fc
> [3701:11_see] handle_pte_fault+0x98/0x2a8
> [3701:11_see] __handle_mm_fault+0x368/0x700
> [3701:11_see] do_handle_mm_fault+0x160/0x2cc
> [3701:11_see] do_page_fault+0x3e0/0x818
> [3701:11_see] do_mem_abort+0x68/0x17c
> [3701:11_see] el0_da+0x3c/0xa0
> [3701:11_see] el0t_64_sync_handler+0xc4/0xec
> [3701:11_see] el0t_64_sync+0x1b4/0x1b8
> [3701:11_see]tracing off
> 
> Signed-off-by: Gao Xu <gaoxu2@hihonor.com>
> ---
>  mm/oom_kill.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 9e6071fde..3754ab4b6 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -984,7 +984,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	}
>  	rcu_read_unlock();
>  
> -	if (can_oom_reap)
> +	if (can_oom_reap && tsk_is_oom_victim(victim))
>  		queue_oom_reaper(victim);

I do not understand. We always do send SIGKILL and call
mark_oom_victim(victim); on victim task when reaching out here. How can
tsk_is_oom_victim can ever be false?

>  
>  	mmdrop(mm);
> -- 
> 2.17.1
> 
> 

-- 
Michal Hocko
SUSE Labs
