Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B87D5933
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbjJXQx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344029AbjJXQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:53:54 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE79C;
        Tue, 24 Oct 2023 09:53:53 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1cab2c24ecdso29837455ad.0;
        Tue, 24 Oct 2023 09:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698166432; x=1698771232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21+/3OMeV0g7LIWMnvWxRg2TMggNtT9PBLq3wQT7afE=;
        b=Olou7P6IPvdpTXvr85VQNMjLSMSKY+14A/qRNTxg8DHkbU/iuZSKP9ARJhK6DOQbF/
         Ikjp67+cY6y5HxQClSkBeYPm/5YmJ8VW4ofRHu+HmrnQ8Xd9698NKzxHrWUIPM1CliCF
         SyIwfinW2F70Y7CBKS5edyeHlq4zzlcoPmn9a2DvWArrEujjGAxNP36m0dhyxY58FJZW
         vtodlypWGMe1qLH5CUGhvOZladPzZl7dySlygmUEf3R3P7ECs66qTywnSzmeyW1xLdld
         p7G6lDKqYiVaE2JXpUryS+AbHHpel8GBUUDt3Wp5BXmBGIW8oOycxSbkTAsasKy2iBpZ
         k07Q==
X-Gm-Message-State: AOJu0YxD8uGebbe7GWtVcfoWMt0yOCosmS+aCuyemJdL7i8wMu4g/wbM
        9473XIG5/oQNhPflF3cvGzk=
X-Google-Smtp-Source: AGHT+IETsSfhD8/8QMcRaV47sV7R40OaaVTmGMwhyYPKs3ng7Rdoy7Jcm5YbXWqR2ppbxnLNwiK2yQ==
X-Received: by 2002:a17:903:41cc:b0:1ca:20a0:7b14 with SMTP id u12-20020a17090341cc00b001ca20a07b14mr12238599ple.55.1698166432470;
        Tue, 24 Oct 2023 09:53:52 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b089:b200:3b6d:bf8? ([2620:15c:211:201:b089:b200:3b6d:bf8])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170903048a00b001c60c3f9508sm7668047plb.230.2023.10.24.09.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:53:51 -0700 (PDT)
Message-ID: <293c16d2-f556-4d42-ab06-2e0acf1cc601@acm.org>
Date:   Tue, 24 Oct 2023 09:53:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] blk-mq: don't schedule block kworker on isolated CPUs
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20231013124758.1492796-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231013124758.1492796-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/23 05:47, Ming Lei wrote:
> @@ -3926,6 +3941,15 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>   		 */
>   		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
>   
> +		/*
> +		 * rule out isolated CPUs from hctx->cpumask for avoiding to
> +		 * run wq worker on isolated CPU
> +		 */
> +		for_each_cpu(cpu, hctx->cpumask) {
> +			if (cpu_is_isolated(cpu))
> +				cpumask_clear_cpu(cpu, hctx->cpumask);
> +		}

What will happen if this code makes hctx->cpumask empty? Code like
blk_mq_first_mapped_cpu() and blk_mq_hctx_next_cpu() assumes that
hctx->cpumask is not empty. There may be other code that assumes that
hctx->cpumask is not empty.

Thanks,

Bart.
