Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB075B76D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGTTHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjGTTHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:07:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D622719;
        Thu, 20 Jul 2023 12:07:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C54C22C8B;
        Thu, 20 Jul 2023 19:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689880021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQnVQG0q9VVm8UuQ6nnXG9ncuTRurJ8jeV6JO3bPO7w=;
        b=dHn9dnqz9JSek/gmyfpDHzzdj8FbSMF6ZOoM0sYdkS70bTwWMfsCiPtasUYVerbZOJCwuw
        3GyOAHI6RsM3MdMiQ13FO3v0ny1LnG10HYosfOo5fFlo9aFxoT4OgQlN9zL3RjtQ2o3iHK
        bH2UFCrvlf9VUwSI8SdZu6Jz3yiZCO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689880021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQnVQG0q9VVm8UuQ6nnXG9ncuTRurJ8jeV6JO3bPO7w=;
        b=Xpyr/kcbASNlPiEYokGoGexQCErIE4MJIDylmSIM/14CJerJOjby3Pj/hvaYeGJvV0bzsn
        D+azY3e/AudeRIDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 336A1138EC;
        Thu, 20 Jul 2023 19:07:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +DLjBtWFuWRmfAAAMHmgww
        (envelope-from <krisman@suse.de>); Thu, 20 Jul 2023 19:07:01 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH 1/6] sbitmap: fix hint wrap in the failure case
Organization: SUSE
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
        <20230720094555.1397621-2-chengming.zhou@linux.dev>
Date:   Thu, 20 Jul 2023 15:06:58 -0400
In-Reply-To: <20230720094555.1397621-2-chengming.zhou@linux.dev> (chengming
        zhou's message of "Thu, 20 Jul 2023 17:45:50 +0800")
Message-ID: <87r0p24d2l.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chengming.zhou@linux.dev writes:

> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> ```
> hint = nr + 1;
> if (hint >= depth - 1)
> 	hint = 0;
> ```
>
> Now we wrap the hint to 0 in the failure case, but:
> 1. hint == depth - 1, is actually an available offset hint, which
>    we shouldn't wrap hint to 0.
> 2. In the strict round_robin non-wrap case, we shouldn't wrap at all.
>
> ```
> wrap = wrap && hint;
> ```
>
> We only need to check wrap based on the original hint ( > 0), don't need
> to recheck the new hint which maybe updated in the failure case.
> Also delete the mismatched comments by the way.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  lib/sbitmap.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index eff4e42c425a..5ed6c2adf58e 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -144,12 +144,7 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>  	while (1) {
>  		nr = find_next_zero_bit(word, depth, hint);
>  		if (unlikely(nr >= depth)) {
> -			/*
> -			 * We started with an offset, and we didn't reset the
> -			 * offset to 0 in a failure case, so start from 0 to
> -			 * exhaust the map.
> -			 */
> -			if (hint && wrap) {
> +			if (wrap) {
>  				hint = 0;
>  				continue;

I think this is wrong.  If you start with an offset in the wrap case and
the bitmap is completely full this will become busy wait until a bit is
available. The hint check is what make you break out of the loop early,
after wrapping, re-walking the entire bitmap and failing to find any
available space.

> @@ -160,8 +155,13 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>  			break;
>  
>  		hint = nr + 1;
> -		if (hint >= depth - 1)
> -			hint = 0;
> +		if (hint >= depth) {
> +			if (wrap) {
> +				hint = 0;
> +				continue;
> +			}
> +			return -1;
> +		}
>  	}
>  
>  	return nr;

-- 
Gabriel Krisman Bertazi
