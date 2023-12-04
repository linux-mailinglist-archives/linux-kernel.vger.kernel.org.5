Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF968038C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjLDP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjLDP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:28:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD39DC0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:28:34 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 398411F8B8;
        Mon,  4 Dec 2023 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701703713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhM9TspgCLXE7hNDqvbME/NvDDvk0vZddm+UOV6znaw=;
        b=KefSqzufCmAoYTnhCiQM/HiSQZ039lAtfkXe/6RKCrH3AJXh+LU4LFDOpNmyuhL21NdpzF
        NjZiIAmGFw/XfwrDr+Zr4vagh3NNtA3FplK5ALw9emEjLh8yZ/PPa1bR1auNT5cT5Vu8pn
        Kidjuc+z73TDVLb2sL1IsP/E765Pyd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701703713;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhM9TspgCLXE7hNDqvbME/NvDDvk0vZddm+UOV6znaw=;
        b=PogRzCcH5uvyKwfduvxa689E9cTOR2CbtoXvd2OdVJ41jWRFQwoZKwJT/L3PU4VmXJV0qM
        SPopx6LZY4gfLWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 286CC1398A;
        Mon,  4 Dec 2023 15:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id btN1CSHwbWUkVAAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Mon, 04 Dec 2023 15:28:33 +0000
Message-ID: <f8bb6a60-af0d-e54c-cd81-6040890b8c89@suse.cz>
Date:   Mon, 4 Dec 2023 16:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm/rmap: Fix misplaced parenthesis of a likely()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20231201145936.5ddfdb50@gandalf.local.home>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231201145936.5ddfdb50@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[5];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 20:59, Steven Rostedt wrote:
> From: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Running my yearly branch profiler to see where likely/unlikely annotation
> may be added or removed, I discovered this:
> 
> correct incorrect  %        Function                  File              Line
>  ------- ---------  -        --------                  ----              ----
>        0   457918 100 page_try_dup_anon_rmap         rmap.h               264
> [..]
>   458021        0   0 page_try_dup_anon_rmap         rmap.h               265
> 
> I thought it was interesting that line 264 of rmap.h had a 100% incorrect
> annotation, but the line directly below it was 100% correct. Looking at the
> code:
> 
> 	if (likely(!is_device_private_page(page) &&
> 	    unlikely(page_needs_cow_for_dma(vma, page))))
> 
> It didn't make sense. The "likely()" was around the entire if statement
> (not just the "!is_device_private_page(page)"), which also included the
> "unlikely()" portion of that if condition.
> 
> If the unlikely portion is unlikely to be true, that would make the entire
> if condition unlikely to be true, so it made no sense at all to say the
> entire if condition is true.
> 
> What is more likely to be likely is just the first part of the if statement
> before the && operation. It's likely to be a misplaced parenthesis. And
> after making the if condition broken into a likely() && unlikely(), both
> now appear to be correct!
> 
> Cc: stable@vger.kernel.org
> Fixes:fb3d824d1a46c ("mm/rmap: split page_dup_rmap() into page_dup_file_rmap() and page_try_dup_anon_rmap()")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Pragmatically speaking, stable maintainers haven't been following the stable
rules for a long time, and a commit with Fixes and without Cc: stable is
often backported on the assumption people forget Cc: stable, and "Fixes:"
implies there's a bug to fix, and it's good to have bugs fixed in stable...

We have (repeatedly...) had mm extempted from this and Cc: stable is
required, which is good. So if Steven thinks there are reasons to backport,
then I'd rather let him keep the Cc: stable, instead of this later becoming
an argument to question the mm extemption again :)

> ---
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b26fe858fd44..3c2fc291b071 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -261,8 +261,8 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
>  	 * guarantee the pinned page won't be randomly replaced in the
>  	 * future on write faults.
>  	 */
> -	if (likely(!is_device_private_page(page) &&
> -	    unlikely(page_needs_cow_for_dma(vma, page))))
> +	if (likely(!is_device_private_page(page)) &&
> +	    unlikely(page_needs_cow_for_dma(vma, page)))
>  		return -EBUSY;
>  
>  	ClearPageAnonExclusive(page);

