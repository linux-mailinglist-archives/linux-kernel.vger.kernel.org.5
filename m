Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95809803CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjLDSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDSWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:22:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3EBD2;
        Mon,  4 Dec 2023 10:22:30 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BAC5F1FE65;
        Mon,  4 Dec 2023 18:22:28 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A9FFF139E2;
        Mon,  4 Dec 2023 18:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id 62t6KeQYbmVTWwAAn2gu4w
        (envelope-from <jack@suse.cz>); Mon, 04 Dec 2023 18:22:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 36BC5A07DB; Mon,  4 Dec 2023 19:22:28 +0100 (CET)
Date:   Mon, 4 Dec 2023 19:22:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v2 03/35] lib/sbitmap; make __sbitmap_get_word() using
 find_and_set_bit()
Message-ID: <20231204182228.7qzfgjyfmx7ubmx2@quack3>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203193307.542794-2-yury.norov@gmail.com>
X-Spamd-Bar: +++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [13.99 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(5.10)[100.00%];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(4.60)[~all];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[13];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,kernel.dk,suse.cz,alu.unizg.hr,infradead.org,rasmusvillemoes.dk,linux.intel.com,linaro.org,gmail.com,acm.org,omp.ru];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 13.99
X-Rspamd-Queue-Id: BAC5F1FE65
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 03-12-23 11:32:35, Yury Norov wrote:
> __sbitmap_get_word() opencodes either find_and_set_bit_wrap(), or
> find_and_set_next_bit() depending on hint and wrap parameters.
> 
> Switch it to use the atomic find_bit() API. While here, simplify
> sbitmap_find_bit_in_word(), which calls it.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  lib/sbitmap.c | 46 ++++++++--------------------------------------
>  1 file changed, 8 insertions(+), 38 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index d0a5081dfd12..b21aebd07fd6 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -133,38 +133,11 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_resize);
>  
> -static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
> +static inline int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>  			      unsigned int hint, bool wrap)
>  {
> -	int nr;
> -
> -	/* don't wrap if starting from 0 */
> -	wrap = wrap && hint;
> -
> -	while (1) {
> -		nr = find_next_zero_bit(word, depth, hint);
> -		if (unlikely(nr >= depth)) {
> -			/*
> -			 * We started with an offset, and we didn't reset the
> -			 * offset to 0 in a failure case, so start from 0 to
> -			 * exhaust the map.
> -			 */
> -			if (hint && wrap) {
> -				hint = 0;
> -				continue;
> -			}
> -			return -1;
> -		}
> -
> -		if (!test_and_set_bit_lock(nr, word))
> -			break;
> -
> -		hint = nr + 1;
> -		if (hint >= depth - 1)
> -			hint = 0;
> -	}
> -
> -	return nr;
> +	return wrap ? find_and_set_bit_wrap_lock(word, depth, hint) :
> +			find_and_set_next_bit_lock(word, depth, hint);
>  }
>  
>  static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
> @@ -175,15 +148,12 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
>  	int nr;
>  
>  	do {
> -		nr = __sbitmap_get_word(&map->word, depth,
> -					alloc_hint, wrap);
> -		if (nr != -1)
> -			break;
> -		if (!sbitmap_deferred_clear(map))
> -			break;
> -	} while (1);
> +		nr = __sbitmap_get_word(&map->word, depth, alloc_hint, wrap);
> +		if (nr < depth)
> +			return nr;
> +	} while (sbitmap_deferred_clear(map));
>  
> -	return nr;
> +	return -1;
>  }
>  
>  static int sbitmap_find_bit(struct sbitmap *sb,
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
