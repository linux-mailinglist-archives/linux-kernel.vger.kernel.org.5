Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB5803CF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjLDS0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjLDS0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:26:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1584D2;
        Mon,  4 Dec 2023 10:26:15 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 129681FE65;
        Mon,  4 Dec 2023 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701714373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ONuLqtXtJkgprRpS4BZ7hiMbFehCE+Bu6DodZsigLIk=;
        b=p6BnC6BTug7Xu69WbnF4r5Wbt+TFKrrRyfn7ABQr1fpL5xBr6PDbW9wNt7LAoALRT6c7r7
        dvmtlccTuNq3UJG183OVWyXHl0pU9aZDZGZ3JDcOlrSE1RonUzrz3hWL32cYx9+3Zjj+Xl
        IQQeIcx3U8MDxOQJntdDg2hbMrm+Cbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701714373;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ONuLqtXtJkgprRpS4BZ7hiMbFehCE+Bu6DodZsigLIk=;
        b=rRfuwwmE7JEywJ3AIf4KFjHbhQpy01UZRhkcCYt6dah1H93/zp+FipJmRXlRfE0jV6wkLs
        UQYV6OcMd7j5GxBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F0251139E2;
        Mon,  4 Dec 2023 18:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id cwdaOsQZbmUXXAAAn2gu4w
        (envelope-from <jack@suse.cz>); Mon, 04 Dec 2023 18:26:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 99C87A07DB; Mon,  4 Dec 2023 19:26:12 +0100 (CET)
Date:   Mon, 4 Dec 2023 19:26:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v2 24/35] block: null_blk: fix opencoded
 find_and_set_bit() in get_tag()
Message-ID: <20231204182612.kms2dbxsupesborq@quack3>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-23-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203193307.542794-23-yury.norov@gmail.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 6.00
X-Spamd-Result: default: False [6.00 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(5.10)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[21];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,kernel.dk,opensource.wdc.com,nvidia.com,redhat.com,wdc.com,bytedance.com,samsung.com,gmail.com,suse.cz,alu.unizg.hr,infradead.org,rasmusvillemoes.dk,linux.intel.com,linaro.org,acm.org,omp.ru];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 03-12-23 11:32:56, Yury Norov wrote:
> get_tag() opencodes find_and_set_bit(). Switch the code to use the
> dedicated function, and get rid of get_tag entirely.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/null_blk/main.c | 41 +++++++++++------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 3021d58ca51c..671dbb9ab928 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -760,19 +760,6 @@ static void put_tag(struct nullb_queue *nq, unsigned int tag)
>  		wake_up(&nq->wait);
>  }
>  
> -static unsigned int get_tag(struct nullb_queue *nq)
> -{
> -	unsigned int tag;
> -
> -	do {
> -		tag = find_first_zero_bit(nq->tag_map, nq->queue_depth);
> -		if (tag >= nq->queue_depth)
> -			return -1U;
> -	} while (test_and_set_bit_lock(tag, nq->tag_map));
> -
> -	return tag;
> -}
> -
>  static void free_cmd(struct nullb_cmd *cmd)
>  {
>  	put_tag(cmd->nq, cmd->tag);
> @@ -782,24 +769,22 @@ static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer);
>  
>  static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
>  {
> +	unsigned int tag = find_and_set_bit_lock(nq->tag_map, nq->queue_depth);
>  	struct nullb_cmd *cmd;
> -	unsigned int tag;
> -
> -	tag = get_tag(nq);
> -	if (tag != -1U) {
> -		cmd = &nq->cmds[tag];
> -		cmd->tag = tag;
> -		cmd->error = BLK_STS_OK;
> -		cmd->nq = nq;
> -		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
> -			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
> -				     HRTIMER_MODE_REL);
> -			cmd->timer.function = null_cmd_timer_expired;
> -		}
> -		return cmd;
> +
> +	if (tag >= nq->queue_depth)
> +		return NULL;
> +
> +	cmd = &nq->cmds[tag];
> +	cmd->tag = tag;
> +	cmd->error = BLK_STS_OK;
> +	cmd->nq = nq;
> +	if (nq->dev->irqmode == NULL_IRQ_TIMER) {
> +		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		cmd->timer.function = null_cmd_timer_expired;
>  	}
>  
> -	return NULL;
> +	return cmd;
>  }
>  
>  static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
