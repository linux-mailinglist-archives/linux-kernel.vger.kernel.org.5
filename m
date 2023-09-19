Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC03D7A64A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjISNSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjISNSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7669F1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695129434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uRsDINs/e79lqnEdCj7wsToZAdWNbdxEJbiEYfnp6Y=;
        b=MrrYUXYTsiQ5/A021ZY7d6kt8ULx0w/mXOXvANMcp87Zv/O1YEdqWgAg8dYQDsYWsRp0v8
        UK47iMEUSIZiLaO28hppu05OTBlBYi3CeNur5+GzfZdn2qP1ghY0lIBg+oaYaDZyfDnu/o
        hLi7VpL8t7fSVFTJrpi8115vprChnvA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-31x79jynNb2Kal3PiicYjQ-1; Tue, 19 Sep 2023 09:17:12 -0400
X-MC-Unique: 31x79jynNb2Kal3PiicYjQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-773c03f2bdaso372219585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129432; x=1695734232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uRsDINs/e79lqnEdCj7wsToZAdWNbdxEJbiEYfnp6Y=;
        b=ewL1A+qz4HE+2ezlEx6PoXSccYxiJccyXC900n6ZoBxEn/mreCeHtKuT24c43gt/BR
         LlIwZxiqcg5Vmijy73eqaKPEazMpeDkt9w8LF0a4jyMdP7vl/kUBZrQqdmrxCXPxDTJv
         11F5J6uf2BbzUVLG1WKp2CIxvGQEpVIvXaZ6bZnFIJ3/yoyY5MoFE2tCKiAXCn48p0BZ
         pUBIk0aic4icGFZbCztSHYz9UbkpaSM2yrt8HOJx3mAbxM5Ks8r31Mfkn6AMQRUHIou0
         MJe+N+qY0y6Cufs+OU4hckvsLekEvznUgByX6YsXxDklSTvoYboZo3dYlk/1h2azOorg
         g0Iw==
X-Gm-Message-State: AOJu0YwtSiZPVyb6arrv+UcdeuSUa6zMUQq/C6/pTFnTgn0MVWd0mmqU
        w8BIiXKEnYYiXHwJqI9lQHJqjn2qbvC9cvfMidk2DAME6JJT+q+c7l1TKg3LJ+KtJykDMIFyllT
        TT0teSfOB5o27rJcyWI0B6pjB
X-Received: by 2002:a05:620a:461f:b0:76f:bb5:9683 with SMTP id br31-20020a05620a461f00b0076f0bb59683mr14021014qkb.20.1695129432398;
        Tue, 19 Sep 2023 06:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDRSK2hqS3H5zwneLEp5LGhEUJyPaE75v0ThMemaZOnxG/7ZDlmjOVJqe4Hvmf2S5f12bBEA==
X-Received: by 2002:a05:620a:461f:b0:76f:bb5:9683 with SMTP id br31-20020a05620a461f00b0076f0bb59683mr14020993qkb.20.1695129432128;
        Tue, 19 Sep 2023 06:17:12 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id s11-20020ae9f70b000000b0076d25b11b62sm3945843qkg.38.2023.09.19.06.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:17:11 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:17:27 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Use snprintf() instead of scnprintf() when
 appropriate
Message-ID: <ZQmfZ/nPMgiJK9eW@bfoster>
References: <9a998be3e2dbedcd3a9eae5f81ae6dcc6c0f98c4.1694849375.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a998be3e2dbedcd3a9eae5f81ae6dcc6c0f98c4.1694849375.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 09:30:19AM +0200, Christophe JAILLET wrote:
> snprintf() and scnprintf() are the same, except for the returned value.
> When this value is not used, it is more logical to use snprintf() which is
> slightly simpler.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Seems reasonable:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/bcachefs/super.c | 2 +-
>  fs/bcachefs/tests.c | 2 +-
>  fs/bcachefs/trace.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
> index 2990eed85adf..773ea93e44c1 100644
> --- a/fs/bcachefs/super.c
> +++ b/fs/bcachefs/super.c
> @@ -1180,7 +1180,7 @@ static void bch2_dev_attach(struct bch_fs *c, struct bch_dev *ca,
>  {
>  	ca->dev_idx = dev_idx;
>  	__set_bit(ca->dev_idx, ca->self.d);
> -	scnprintf(ca->name, sizeof(ca->name), "dev-%u", dev_idx);
> +	snprintf(ca->name, sizeof(ca->name), "dev-%u", dev_idx);
>  
>  	ca->fs = c;
>  	rcu_assign_pointer(c->devs[ca->dev_idx], ca);
> diff --git a/fs/bcachefs/tests.c b/fs/bcachefs/tests.c
> index c907b3e00176..72f9bf186f9c 100644
> --- a/fs/bcachefs/tests.c
> +++ b/fs/bcachefs/tests.c
> @@ -926,7 +926,7 @@ int bch2_btree_perf_test(struct bch_fs *c, const char *testname,
>  
>  	time = j.finish - j.start;
>  
> -	scnprintf(name_buf, sizeof(name_buf), "%s:", testname);
> +	snprintf(name_buf, sizeof(name_buf), "%s:", testname);
>  	prt_human_readable_u64(&nr_buf, nr);
>  	prt_human_readable_u64(&per_sec_buf, div64_u64(nr * NSEC_PER_SEC, time));
>  	printk(KERN_INFO "%-12s %s with %u threads in %5llu sec, %5llu nsec per iter, %5s per sec\n",
> diff --git a/fs/bcachefs/trace.h b/fs/bcachefs/trace.h
> index 19264492151b..da303dd4b71c 100644
> --- a/fs/bcachefs/trace.h
> +++ b/fs/bcachefs/trace.h
> @@ -450,7 +450,7 @@ TRACE_EVENT(btree_path_relock_fail,
>  			c = six_lock_counts(&path->l[level].b->c.lock);
>  			__entry->read_count	= c.n[SIX_LOCK_read];
>  			__entry->intent_count	= c.n[SIX_LOCK_intent];
> -			scnprintf(__entry->node, sizeof(__entry->node), "%px", b);
> +			snprintf(__entry->node, sizeof(__entry->node), "%px", b);
>  		}
>  		__entry->iter_lock_seq		= path->l[level].lock_seq;
>  		__entry->node_lock_seq		= is_btree_node(path, level)
> -- 
> 2.34.1
> 

