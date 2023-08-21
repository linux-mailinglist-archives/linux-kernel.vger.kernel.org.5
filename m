Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950E7832A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjHUT7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjHUT7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:59:09 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBD918F;
        Mon, 21 Aug 2023 12:58:59 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-56c2e882416so792050a12.3;
        Mon, 21 Aug 2023 12:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647938; x=1693252738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwaB1aNpCSPTQqMR1zA27jiuAOxFmRQuBCIOZpDrf6U=;
        b=C9PC9IlQ8L00iZZVk8yDFzTFZfuDrnTGij/ydLP4TFs+MqBJU4MdJgIxkcVZu6lQmw
         U+oAKc+p+0Z7hu9kN8Ndd3per21VNDZZYOUX/EPyPfG/X5KQedbJUOFyEPOHnuweOlIR
         8gY1rzaOLpKkxDOBYGaK7tFBLFxLCE11BiXc+X5ebtEGIhjd2w+MsMVcTKYC8LbU/enb
         hwgbF8JPMFsxf435Bi7v9YJgtIQKGUrdTWGZEScJ1ZDCwvmI4X9MrUnAl8CSQjWt97aW
         HfqhZlDeMeX/4kipaX4OU45f8HonlsC1XW5tvTpx01ls/I+wrBBmnBxkxoHrho5g2FPv
         XTsA==
X-Gm-Message-State: AOJu0YzfODv0GY8hsBc/QK7dZJR2H9np3pCogAfXVJoepokKQESbTZqF
        xUqZ0U094eaZxhR/FnPC05BTmoKhMaM=
X-Google-Smtp-Source: AGHT+IH9y6NpDGBZQ0oRJQ3yXUzg91wjjsuvm2N37SLNzSqo+T2IlJu+XXuqtH59Qjqb7j6K6w1q3A==
X-Received: by 2002:a05:6a20:96d0:b0:133:b3a9:90d with SMTP id hq16-20020a056a2096d000b00133b3a9090dmr4740638pzc.36.1692647938403;
        Mon, 21 Aug 2023 12:58:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ef58:6534:ec7a:8ab2? ([2620:15c:211:201:ef58:6534:ec7a:8ab2])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b00686ed095681sm6523618pfb.191.2023.08.21.12.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 12:58:57 -0700 (PDT)
Message-ID: <f3495925-d681-ba7f-5c2f-d2c19453b067@acm.org>
Date:   Mon, 21 Aug 2023 12:58:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 1/4] blk-mq-tag: support queue filter in bt_tags_iter()
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230821073528.3469210-1-chengming.zhou@linux.dev>
 <20230821073528.3469210-2-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230821073528.3469210-2-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 00:35, chengming.zhou@linux.dev wrote:
> @@ -417,7 +425,23 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
>   void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>   		void *priv)
>   {
> -	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
> +	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS, NULL);
> +}
> +
> +static void __blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
> +				      busy_tag_iter_fn *fn, void *priv,
> +				      struct request_queue *q)
> +{
> +	unsigned int flags = tagset->flags;
> +	int i, nr_tags;
> +
> +	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
> +
> +	for (i = 0; i < nr_tags; i++) {
> +		if (tagset->tags && tagset->tags[i])
> +			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
> +					      BT_TAG_ITER_STARTED, q);
> +	}
>   }
>   
>   /**
> @@ -436,16 +460,7 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>   void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>   		busy_tag_iter_fn *fn, void *priv)
>   {
> -	unsigned int flags = tagset->flags;
> -	int i, nr_tags;
> -
> -	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
> -
> -	for (i = 0; i < nr_tags; i++) {
> -		if (tagset->tags && tagset->tags[i])
> -			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
> -					      BT_TAG_ITER_STARTED);
> -	}
> +	__blk_mq_tagset_busy_iter(tagset, fn, priv, NULL);
>   }
>   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);

One change per patch please. I think the introduction of __blk_mq_tagset_busy_iter()
should be a separate patch instead of happening in this patch.

Thanks,

Bart.

