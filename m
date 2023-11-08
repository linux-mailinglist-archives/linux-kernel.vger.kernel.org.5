Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD297E5006
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjKHF0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjKHF0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:26:37 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147D498;
        Tue,  7 Nov 2023 21:26:35 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5b9a7357553so5025712a12.0;
        Tue, 07 Nov 2023 21:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699421194; x=1700025994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RetVwMMps3v0wuYvBP5PRz6XNs49BLOh+F6Kj2NY2i4=;
        b=J0f8t9yrd7wcaFw3SNV4MriaiZqbjcJhCQZuMOzm5suzQ+j4IGp5nWKDEUkfRAA/9B
         jWO2Rqk3dN2StHpdPokJnfIDiB0+/Q72mw3rq/3/V+w9aFE7AVcU4xDIjSqqNqEI4YIE
         QbEMw/EB2wcYIab189b79Y8QDehubpsYFu75r4Ejb/eirGL1fHENji+G2YxcT33vLR2y
         65AvEsZuFcrrPvqp14bE7A9Yn28KmEw1xRYTayFibq6aHVaG2vQFZFdEghpde0F8AxE5
         Q+Be1a1Wvw+VdqUgj/p85hE4MwkCcA1yMVAm0K1VWwajmhZyyT1nMF+nxC6uM1t+mZq3
         I23A==
X-Gm-Message-State: AOJu0YyU59UvNNeOBN/zLRxTnr4MzPxNnZKL9rdMjUCK6YAzfGxtfqGb
        rdw+ZP5zjxqbZD0c6mHhAMo=
X-Google-Smtp-Source: AGHT+IG6r/xsxVWQjB8Trj0a2s94siLsxt+R7G2yf3eYYClkPjWYNhRjMsrSNaVLbA/3OxVfkyigpQ==
X-Received: by 2002:a17:90b:805:b0:27d:6dd:fb7d with SMTP id bk5-20020a17090b080500b0027d06ddfb7dmr900492pjb.17.1699421194228;
        Tue, 07 Nov 2023 21:26:34 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id em16-20020a17090b015000b0026b12768e46sm695943pjb.42.2023.11.07.21.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 21:26:33 -0800 (PST)
Message-ID: <25a94b23-b42b-49fc-a1c8-3e635f536aae@acm.org>
Date:   Tue, 7 Nov 2023 21:26:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: fix warning in blk_mq_start_request
Content-Language: en-US
To:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000000e6aac06098aee0c@google.com>
 <tencent_03A5938DE6921DDDE9DD921956CFAD0DE007@qq.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <tencent_03A5938DE6921DDDE9DD921956CFAD0DE007@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 18:46, Edward Adam Davis wrote:
> Before call blk_mq_start_request() in null_queue_rq(), initialize rq->state to
> MQ_RQ_IDLE.
> 
> Reported-and-tested-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   drivers/block/null_blk/main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 22a3cf7f32e2..0726534a5a24 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1724,6 +1724,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	cmd->fake_timeout = should_timeout_request(rq) ||
>   		blk_should_fake_timeout(rq->q);
>   
> +	if (READ_ONCE(rq->state))
> +		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
>   	blk_mq_start_request(rq);
>   
>   	if (should_requeue_request(rq)) {

All code that changes rq->state should occur in the block layer
core. Block drivers must not modify rq->state directly.

Bart.
