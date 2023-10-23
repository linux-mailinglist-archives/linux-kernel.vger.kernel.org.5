Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B187D4137
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjJWUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJWUrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:47:00 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2DBC;
        Mon, 23 Oct 2023 13:46:58 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c9e06f058bso35039685ad.0;
        Mon, 23 Oct 2023 13:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698094018; x=1698698818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrX5rfIviWZ3MV5YYguySJMRct/o0TPbHAjKwB4P258=;
        b=YZ1R5emjRFSj4vkSQvDvhwNs1TDS2+de3huXOo6mt8juubRv8Im62NLGZjplN6eFMm
         W609OWTOELyq5Aykkyaegvva42N70RutfXDOaHgCMBXqIpDHANsSfMPX/6RT67GMntjB
         cHHgybbR6NnpP5fqp3JZRMASYJcNnh5owtUYRBsLS2Mth/lCM1zp0y23f/HDr7dMPPIn
         VBbox4n7QzA069IFZzfRMpAs7/v8+CNHeH3d+f865lveKSaX5kfdsLa+JpFFz3MdnPhp
         1XKzTIX83u52tIzCyFBnm5Y+nmDPbRdOmXhzWPonulEmzFPfX7v7nn4F51LKQKGL8wH4
         rBvA==
X-Gm-Message-State: AOJu0YzJOSeWM0Neack/37ZQC+zLb03kAVL/bDXQiA+ZTc+nWW6XBTyO
        3MlclIF1RZ6oo5BUlh6rOhs=
X-Google-Smtp-Source: AGHT+IEGyNmPgn+1seQ+b4IjU4nfs2gp2xs00S0dIBo0hrLMQ/8SZczxdMFBCPg0uRGXq7DkgYgzGw==
X-Received: by 2002:a17:902:facf:b0:1c5:d8a3:8783 with SMTP id ld15-20020a170902facf00b001c5d8a38783mr11972847plb.11.1698094018130;
        Mon, 23 Oct 2023 13:46:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:14f9:170e:9304:1c4e? ([2620:15c:211:201:14f9:170e:9304:1c4e])
        by smtp.gmail.com with ESMTPSA id 18-20020a170902c21200b001c5f7e06256sm6322466pll.152.2023.10.23.13.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 13:46:57 -0700 (PDT)
Message-ID: <d8b5db3c-cd0a-4e88-ae08-e17b97bdfc55@acm.org>
Date:   Mon, 23 Oct 2023 13:46:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 8/8] blk-mq-tag: allow shared queue/hctx to get
 more driver tags
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
 <20231021154806.4019417-9-yukuai1@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231021154806.4019417-9-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/23 08:48, Yu Kuai wrote:
> +	if (!busy) {
> +		ctl->timer_running = false;
> +	} else {
> +		ctl->timer.expires = jiffies + HZ;
> +		add_timer(&ctl->timer);
> +	}
> +	spin_unlock_irq(&tags->lock);

[ ... ]

> +inc_busy:
> +	atomic_inc(&info->busy_count);
> +	if (!tags->ctl.timer_running &&
> +	    try_cmpxchg_relaxed(&tags->ctl.timer_running, &timer_running, true)) {
> +		tags->ctl.timer.expires = jiffies + HZ;
> +		add_timer(&tags->ctl.timer);
> +	}
>   }

So the choice has been made to let the timer expire after one second? I
think the choice of the timer value is important enough to mention it in
the patch description.

Thanks,

Bart.

