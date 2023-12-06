Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450418074A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjLFQOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjLFQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:14:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A912F;
        Wed,  6 Dec 2023 08:14:47 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFCCD1FD16;
        Wed,  6 Dec 2023 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701879286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1DkhA2HHkFoqZbckox6DnGjYS+3CIXWrTjgL648Eh+A=;
        b=rVDYHIo4hZl3CgAy/qvw7vEZtNRCRdfTESHbRMBQO8VBw0d0rNW63/XBf/Nt+0AcZrcAvP
        7HHyoUUwu3H20JUtUchQvUVY2ao79AoQvoa75kb0Jbhj+X8fvkrg+bAKD80BaszybU2aiN
        aFpGKzpH5mVjokxaZEddOKTMp0FlU4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701879286;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1DkhA2HHkFoqZbckox6DnGjYS+3CIXWrTjgL648Eh+A=;
        b=wGcezhoFzNi07PvT4U4IYxRR6woz2UoJW+32KxW2B60ApVQRCkCpS9Zgns9dneDTvNVNSi
        xV3jnu9YFjbjnaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E9213408;
        Wed,  6 Dec 2023 16:14:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id ULPVLvWdcGWHXgAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 06 Dec 2023 16:14:45 +0000
Message-ID: <75a71276-dff8-ad3a-d238-fcfa3ab39413@suse.cz>
Date:   Wed, 6 Dec 2023 17:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 2/3] mm/slub: unify all sl[au]b parameters with
 "slab_$param"
Content-Language: en-US
To:     sxwjean@me.com, 42.hyeyoo@gmail.com, cl@linux.com,
        linux-mm@kvack.org
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
        arnd@arndb.de, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
References: <20231203001501.126339-1-sxwjean@me.com>
 <20231203001501.126339-3-sxwjean@me.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231203001501.126339-3-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: -0.60
X-Spamd-Result: default: False [-0.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         SUBJECT_HAS_CURRENCY(1.00)[];
         BAYES_HAM(-3.00)[100.00%];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[16];
         FREEMAIL_TO(0.00)[me.com,gmail.com,linux.com,kvack.org];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/3/23 01:15, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> Since the SLAB allocator has been removed, so we need to clean up the

"we can clean up", as we don't really "need"

> sl[au]b_$params. However, the "slab/SLAB" terms should be keep for
> long-term rather than "slub/SLUB". Hence, we should use "slab_$param"

I'd phrase it: With only one slab allocator left, it's better to use the
generic "slab" term instead of "slub" which is an implementation detail.
Hence ...

> as the primary prefix, which is pointed out by Vlastimil Babka. For more
> information please see [1].
> 
> This patch is changing the following slab parameters
> - slub_max_order
> - slub_min_order
> - slub_min_objects
> - slub_debug
> to
> - slab_max_order
> - slab_min_order
> - slab_min_objects
> - slab_debug
> as the primary slab parameters in
> Documentation/admin-guide/kernel-parameters.txt and source, and rename all
> setup functions of them too. Meanwhile, "slub_$params" can also be passed

Not sure about renaming the code at this point, I would just rename the
user-visible parameters and their documentation and any comment that refers
to the parameters. Functions and variables can come later as part of wider
slub/slab change if we decide to do so?

> by command line, which is to keep backward compatibility. Also mark all
> "slub_$params" as legacy.
> 
> The function
>     static int __init setup_slub_debug(char *str);
> , which is to setup debug flags inside a slab during kernel init, is
> changed to setup_slab_debug_flags(), which is to prevent the name
> conflict. Because there is another function
>     void setup_slab_debug(struct kmem_cache *s, struct slab *slab,
>     		void *addr);
> , which is to poison slab space, would have name conflict with the prior
> one.

Another reason to defer code naming changes.

> For parameter "slub_debug", beside replacing it with "slab_debug", there
> are several global variables, local variables and functions which are
> related with the parameter, let's rename them all.
> 
> Remove the separate descriptions for slub_[no]merge, append legacy tip
> for them at the end of descriptions of slab_[no]merge.
> 
> I didn't change the parameters in Documentation/mm/slub.rst because the
> file name is still "slub.rst", and slub_$params still can be used in
> kernel command line to keep backward compatibility.
> 
> [1] https://lore.kernel.org/linux-mm/7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz/
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  44 +++---
>  drivers/misc/lkdtm/heap.c                     |   2 +-
>  mm/Kconfig.debug                              |   6 +-
>  mm/slab.h                                     |  16 +-
>  mm/slab_common.c                              |   8 +-
>  mm/slub.c                                     | 142 +++++++++---------
>  6 files changed, 109 insertions(+), 109 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9f94baeb2f82..d01c12e2a247 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5869,6 +5869,8 @@
>  	slab_merge	[MM]
>  			Enable merging of slabs with similar size when the
>  			kernel is built without CONFIG_SLAB_MERGE_DEFAULT.
> +			(slub_merge is accepted too, but it's supported for
> +			legacy)

How about a shorter note (and always start on new line)

		(slub_merge legacy name also accepted for now)

>  
>  	slab_nomerge	[MM]
>  			Disable merging of slabs with similar size. May be
> @@ -5882,47 +5884,41 @@
>  			unchanged). Debug options disable merging on their
>  			own.
>  			For more information see Documentation/mm/slub.rst.
> +			(slub_nomerge is accepted too, but it's supported for
> +			legacy)
>  
> -	slab_max_order=	[MM, SLAB]
> -			Determines the maximum allowed order for slabs.
> -			A high setting may cause OOMs due to memory
> -			fragmentation.  Defaults to 1 for systems with
> -			more than 32MB of RAM, 0 otherwise.
> -
> -	slub_debug[=options[,slabs][;[options[,slabs]]...]	[MM, SLUB]
> -			Enabling slub_debug allows one to determine the
> +	slab_debug[=options[,slabs][;[options[,slabs]]...]	[MM]

I think we should re-sort alphabetically after the slub_ -> slab_ change.

> +			Enabling slab_debug allows one to determine the
>  			culprit if slab objects become corrupted. Enabling
> -			slub_debug can create guard zones around objects and
> +			slab_debug can create guard zones around objects and
>  			may poison objects when not in use. Also tracks the
>  			last alloc / free. For more information see
> -			Documentation/mm/slub.rst.
> +			Documentation/mm/slub.rst. (slub_debug is accepted
> +			too, but it's supported for legacy)
>  
> -	slub_max_order= [MM, SLUB]
> +	slab_max_order= [MM]
>  			Determines the maximum allowed order for slabs.
>  			A high setting may cause OOMs due to memory
>  			fragmentation. For more information see
> -			Documentation/mm/slub.rst.
> +			Documentation/mm/slub.rst. (slub_max_order is
> +			accepted too, but it's supported for legacy)
>  
> -	slub_min_objects=	[MM, SLUB]
> +	slab_min_objects=	[MM]
>  			The minimum number of objects per slab. SLUB will
> -			increase the slab order up to slub_max_order to
> +			increase the slab order up to slab_max_order to
>  			generate a sufficiently large slab able to contain
>  			the number of objects indicated. The higher the number
>  			of objects the smaller the overhead of tracking slabs
>  			and the less frequently locks need to be acquired.
>  			For more information see Documentation/mm/slub.rst.
> +			(slub_min_objects is accepted too, but it's supported
> +			for legacy)
>  
> -	slub_min_order=	[MM, SLUB]
> +	slab_min_order=	[MM]
>  			Determines the minimum page order for slabs. Must be
> -			lower than slub_max_order.
> -			For more information see Documentation/mm/slub.rst.
> -
> -	slub_merge	[MM, SLUB]
> -			Same with slab_merge.
> -
> -	slub_nomerge	[MM, SLUB]
> -			Same with slab_nomerge. This is supported for legacy.
> -			See slab_nomerge for more information.
> +			lower than slab_max_order. For more information see

		"lower or equal to" (more precise, while at it)

> +			Documentation/mm/slub.rst. (slub_min_order is accepted
> +			too, but it's supported for legacy)
>  
>  	smart2=		[HW]
>  			Format: <io1>[,<io2>[,...,<io8>]]

Thanks!

