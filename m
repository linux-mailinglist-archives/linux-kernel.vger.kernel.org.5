Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08557C8ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjJMVNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjJMVNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:13:12 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E949AB7;
        Fri, 13 Oct 2023 14:13:10 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1c9b70b9656so18666705ad.1;
        Fri, 13 Oct 2023 14:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231590; x=1697836390;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFfUBfp0ylGGMlfj6k7w0PNxEF/kGtQC5wyiNRvjhTE=;
        b=N9D5LhZtHleJGbANPwZQ2m9I9zq9MdgC/t2CxAWflBJLdwWH5R2L8SFE2VDG1UxqJB
         y0QkAPHGisIEGonc0Iiy4IO8bE6WEKMxhQOML0TCW+q1/iFyoGLdjYRbpzE/FtQYsS2d
         SH9iSRtbYeAGINHxXeD4aBt4lGUuw4W2brwIaaj/FEfi5Wq8DGVMTls11kRw2G3fiA+A
         GCimIOpzJhMFI0ZZogwhlzL+AAY5S07OTOkdSh7nV1JydHtjni5dmtrQRYs7XALLhLYZ
         1jsckniLIQjDr9x/WLAl5S7NyQKPnYnpo9S2C+DtPkPrP/bU1yvG0vUyBqYCHgJ+d9G0
         9dCA==
X-Gm-Message-State: AOJu0Yw4MUhr6iQLi+2sb1BrqyVq+eWkiPl0fx586vHePWyvyZYv/f+F
        KXlIj8lrj5UfBNS4aEaQl+Q=
X-Google-Smtp-Source: AGHT+IHMkZ5ZWeGP68xaGNnRabOnrq6JWUtxcf+pufkOCiZaywjZHVef1xnlHoXlAffUIyZ6SqWtGQ==
X-Received: by 2002:a17:902:e809:b0:1c7:1fbc:ba02 with SMTP id u9-20020a170902e80900b001c71fbcba02mr31279327plg.47.1697231590270;
        Fri, 13 Oct 2023 14:13:10 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id z6-20020a170902ee0600b001bba7aab822sm4344531plb.5.2023.10.13.14.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 14:13:09 -0700 (PDT)
Message-ID: <35e3e173-8018-42d8-a6e8-7ba994ff6b17@acm.org>
Date:   Fri, 13 Oct 2023 14:13:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Consider inflight IO in io accounting for high latency
 devices
Content-Language: en-US
To:     Gulam Mohamed <gulam.mohamed@oracle.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231013195559.1306345-1-gulam.mohamed@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231013195559.1306345-1-gulam.mohamed@oracle.com>
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

On 10/13/23 12:55, Gulam Mohamed wrote:
> @@ -1015,7 +1018,13 @@ static inline void blk_account_io_start(struct request *req)
>   			req->part = req->q->disk->part0;
>   
>   		part_stat_lock();
> -		update_io_ticks(req->part, jiffies, false);
> +
> +		if (req->q->nr_hw_queues == 1) {
> +			hctx = xa_load(&req->q->hctx_table, 0);
> +			inflight = blk_mq_hctx_has_tags(hctx);
> +		}
> +
> +		update_io_ticks(req->part, jiffies, inflight);
>   		part_stat_unlock();
>   	}
>   }

blk_account_io_start() is called by blk_mq_bio_to_request(). So if I/O
statistics are enabled and if there is only a single hardware queue,
blk_mq_hctx_has_tags() will be called every time a bio is submitted?
The blk_mq_hctx_has_tags() function iterates over all tags. I would be
surprised if anyone would consider the overhead of this approach
acceptable.

Thanks,

Bart.
