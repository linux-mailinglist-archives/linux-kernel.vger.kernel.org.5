Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E242B7CDA9A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjJRLhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:37:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15080FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:37:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 359921FD6F;
        Wed, 18 Oct 2023 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697629036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fIRiXBPL7Hak/bdjYHHvjv0yyYXIySVMFM3XCbnxNDU=;
        b=oy+2Yhqsw+VpnlGmcnaP87XLdexh64fnz9buU1Ckkiaif84HeGj3ahsDJL39+5S/vNpuZp
        dHzuNmsJiyDADqBNF8YpuYBlBBnj+OzalbRRtx1NZpJDRULQ5KFQuG4C5V3HH27lnpYJS4
        CYX1LAJM/fsLXH56OxvsB1666mr/BhY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1709A13915;
        Wed, 18 Oct 2023 11:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MGCbAmzDL2UhdQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Oct 2023 11:37:16 +0000
Date:   Wed, 18 Oct 2023 13:37:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/oom_killer: simplify OOM killer info dump helper
Message-ID: <3hjarpoab5paboraql2ibgqb7hexj2n2fog7rctwgintrvlu24@kwljdjthirws>
References: <20231016113103.86477-1-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016113103.86477-1-ryncsn@gmail.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 1.50
X-Spamd-Result: default: False [1.50 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(5.10)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-10-23 19:31:03, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> There is only one caller wants to dump the kill victim info, so just let
> it call the standalone helper, no need to make the generic info dump
> helper take an extra argument for that.
> 
> Result of bloat-o-meter:
> ./scripts/bloat-o-meter ./mm/oom_kill.old.o ./mm/oom_kill.o
> add/remove: 0/0 grow/shrink: 1/2 up/down: 131/-142 (-11)
> Function                                     old     new   delta
> oom_kill_process                             412     543    +131
> out_of_memory                               1422    1418      -4
> dump_header                                  562     424    -138
> Total: Before=21514, After=21503, chg -0.05%
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/oom_kill.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 44bde56ecd02..9e6071fde34a 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -437,7 +437,7 @@ static void dump_tasks(struct oom_control *oc)
>  	}
>  }
>  
> -static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
> +static void dump_oom_victim(struct oom_control *oc, struct task_struct *victim)
>  {
>  	/* one line summary of the oom killer context. */
>  	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
> @@ -449,7 +449,7 @@ static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
>  		from_kuid(&init_user_ns, task_uid(victim)));
>  }
>  
> -static void dump_header(struct oom_control *oc, struct task_struct *p)
> +static void dump_header(struct oom_control *oc)
>  {
>  	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
>  		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
> @@ -467,8 +467,6 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  	}
>  	if (sysctl_oom_dump_tasks)
>  		dump_tasks(oc);
> -	if (p)
> -		dump_oom_summary(oc, p);
>  }
>  
>  /*
> @@ -1029,8 +1027,10 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	}
>  	task_unlock(victim);
>  
> -	if (__ratelimit(&oom_rs))
> -		dump_header(oc, victim);
> +	if (__ratelimit(&oom_rs)) {
> +		dump_header(oc);
> +		dump_oom_victim(oc, victim);
> +	}
>  
>  	/*
>  	 * Do we need to kill the entire memory cgroup?
> @@ -1072,7 +1072,7 @@ static void check_panic_on_oom(struct oom_control *oc)
>  	/* Do not panic for oom kills triggered by sysrq */
>  	if (is_sysrq_oom(oc))
>  		return;
> -	dump_header(oc, NULL);
> +	dump_header(oc);
>  	panic("Out of memory: %s panic_on_oom is enabled\n",
>  		sysctl_panic_on_oom == 2 ? "compulsory" : "system-wide");
>  }
> @@ -1155,7 +1155,7 @@ bool out_of_memory(struct oom_control *oc)
>  	select_bad_process(oc);
>  	/* Found nothing?!?! */
>  	if (!oc->chosen) {
> -		dump_header(oc, NULL);
> +		dump_header(oc);
>  		pr_warn("Out of memory and no killable processes...\n");
>  		/*
>  		 * If we got here due to an actual allocation at the
> -- 
> 2.42.0

-- 
Michal Hocko
SUSE Labs
