Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454077834E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjHUV3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjHUV31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:29:27 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D0DF;
        Mon, 21 Aug 2023 14:29:25 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-569deb93999so1128015a12.2;
        Mon, 21 Aug 2023 14:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653365; x=1693258165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seo9OOZ2wPwWlK3idVGSYJZmdTQ8nxxlznTSBaLlvCg=;
        b=CLOAR4urYInsykh1MqWm7Ob0TbGL/OADcLRAA655LxOmFqgYbG98uxUJ7xvpDAxtEW
         kSwRHlnzcZO/FDsl80zjGPW+FfRPhvb/r0FJ088Wj3ROdc2BkbLYNELYgUbs1BDPCZsf
         uJkM1UHPvFSv9jlvLkra5HxYFXha6DlVBUFpkYm5aXORZcPOicauTvY7CU/kfHEtw9aH
         3bzfh5ic5sDmkxlyexp95auHqWLeNGvj8zGR5Vb2aYZqnDCOa30KarWNpbS6hmHTVcjs
         vfFqgawoZeJi573GQwof2SP9Na6hgjrOrZXFce6Pb//n6t07OKVrrm6zECgrEXIuhhrB
         hUWQ==
X-Gm-Message-State: AOJu0YxV1XeTwiDaHdMiUnD/rXgG13O1VztLdxTCgsPK3bBibde5IIBc
        NasvQOzzYKkoPAbg8Ek3rOW5NGU3sso=
X-Google-Smtp-Source: AGHT+IGKwRBJd5E93lTCwNrJboY4Z2pqGFOZIYPqxRGq0HCXvXsw7d3xhOer8m3EJx7ivvra6mdbRQ==
X-Received: by 2002:a17:90a:ca89:b0:26b:7d8e:edf9 with SMTP id y9-20020a17090aca8900b0026b7d8eedf9mr4264562pjt.49.1692653365232;
        Mon, 21 Aug 2023 14:29:25 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ef58:6534:ec7a:8ab2? ([2620:15c:211:201:ef58:6534:ec7a:8ab2])
        by smtp.gmail.com with ESMTPSA id gm6-20020a17090b100600b002696aeb72e5sm8405668pjb.2.2023.08.21.14.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 14:29:24 -0700 (PDT)
Message-ID: <59eb0dc2-1f95-1bca-74d2-b6e04826a83f@acm.org>
Date:   Mon, 21 Aug 2023 14:29:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 3/4] blk-mq: delete superfluous check in iterate callback
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230821073528.3469210-1-chengming.zhou@linux.dev>
 <20230821073528.3469210-4-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230821073528.3469210-4-chengming.zhou@linux.dev>
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
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The blk_mq_queue_tag_busy_iter() already has BT_TAG_ITER_STARTED flag
> filter set, only started requests will be iterated over.

Please consider changing the description of this patch into something like
the following: "The previous patch in this series changed the behavior of
blk_mq_queue_tag_busy_iter() from iterating over all allocated tags into
iterating over started requests only. Leave out the code from
blk_mq_rq_inflight() that became superfluous because of this change."

Thanks,

Bart.
