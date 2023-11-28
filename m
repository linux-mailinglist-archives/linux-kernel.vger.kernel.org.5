Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9F7FC23D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbjK1OH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345463AbjK1OHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:07:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5E7B5;
        Tue, 28 Nov 2023 06:07:31 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8B5A721992;
        Tue, 28 Nov 2023 14:07:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 696C11343E;
        Tue, 28 Nov 2023 14:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id 5JUxFyH0ZWXyNgAAD6G6ig
        (envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 14:07:29 +0000
Date:   Tue, 28 Nov 2023 15:07:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        tj@kernel.org, ying.huang@intel.com,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 04/11] mm/mempolicy: modify get_mempolicy call stack
 to take a task argument
Message-ID: <ZWX0IMfR3S3rRzen@tiehlicka>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122211200.31620-5-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122211200.31620-5-gregory.price@memverge.com>
X-Spamd-Bar: +++++++++++++++
X-Spam-Score: 15.00
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        spf=fail (smtp-out1.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 8B5A721992
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         BAYES_HAM(-0.00)[23.75%];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         RCVD_COUNT_THREE(0.00)[3];
         MID_RHS_NOT_FQDN(0.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[19];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 16:11:53, Gregory Price wrote:
[...]
> @@ -928,7 +929,16 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  		 * vma/shared policy at addr is NULL.  We
>  		 * want to return MPOL_DEFAULT in this case.
>  		 */
> -		mm = current->mm;
> +		if (task == current) {
> +			/*
> +			 * original behavior allows a kernel task changing its
> +			 * own policy to avoid the condition in get_task_mm,
> +			 * so we'll directly access
> +			 */
> +			mm = task->mm;
> +			mmget(mm);

Do we actually have any kernel thread that would call this? Does it
actually make sense to support?

> +		} else
> +			mm = get_task_mm(task);
>  		mmap_read_lock(mm);
>  		vma = vma_lookup(mm, addr);
>  		if (!vma) {
> @@ -947,8 +957,10 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  		return -EINVAL;
>  	else {
>  		/* take a reference of the task policy now */
> -		pol = current->mempolicy;
> +		task_lock(task);
> +		pol = task->mempolicy;
>  		mpol_get(pol);
> +		task_unlock(task);
>  	}
>  
>  	if (!pol) {
> @@ -962,12 +974,13 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  			vma = NULL;
>  			mmap_read_unlock(mm);
>  			err = lookup_node(mm, addr);
> +			mmput(mm);
>  			if (err < 0)
>  				goto out;
>  			*policy = err;
> -		} else if (pol == current->mempolicy &&
> +		} else if (pol == task->mempolicy &&
>  				pol->mode == MPOL_INTERLEAVE) {
> -			*policy = next_node_in(current->il_prev, pol->nodes);
> +			*policy = next_node_in(task->il_prev, pol->nodes);

This is racy without task_lock which I do not think is helde but it also
seems this is not a big deal. pol is ref. counted so it won't go away
and if the task->mempolicy changes then the return value could be bogus
but this seems acceptable. It would be good to put a comment here that
this is actually deliberate.

-- 
Michal Hocko
SUSE Labs
