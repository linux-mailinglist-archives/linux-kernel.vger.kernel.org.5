Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA25787653
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHXRCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbjHXRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:02:34 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11041B0;
        Thu, 24 Aug 2023 10:02:32 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-689f9576babso90921b3a.0;
        Thu, 24 Aug 2023 10:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692896552; x=1693501352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MO7O1kGOwFS/EawXS/x6fpyq+z0MGjgPDj7Ob5YzAfo=;
        b=PAog45iQqHFoFCMzvY/6N7lD7430+3nKfIT3QT3daIY0QIE8U1EX9lCGYL6W1pSrsC
         /uIc8OaKt+ut+buwzyq3XHQ7aW8icpQTHauB0x8R67cE6KNba+GSvRppd+E51JTKLhH4
         V9cgkpfpiQTNk63y5rVvMCBO8NLhgMScjghXyh7Z2QUITmloIClP2lpy6bWeWaAWwpus
         2STCwTZJOzunysEzZTqZdiNC0WRaxYnG4ORt3xJkhG8pfW/XYFZ1/wyVGL7JbZXwwEGn
         Sd/Jbgmm1XtyC2AL68fnzzFTghTxXpR4bazI8K2tIcqGZ9BlPzfatF+ZyrLtkai4P7Or
         L5Yg==
X-Gm-Message-State: AOJu0YzWZwL3M2NZ5ih++rn/5LRg6FTamyrd5kk3PbxRtYw4gxiy5Hrt
        HG/aj/AvzwaABUu57kUlxeI=
X-Google-Smtp-Source: AGHT+IF3ln2fx6jVdhLG2TITnTUr0jZ9VXG2QusjVA6MG79oOYp0rA5bKlVvBkyv1SqOK12SertYnQ==
X-Received: by 2002:a05:6a20:8e01:b0:13e:b7e9:1a71 with SMTP id y1-20020a056a208e0100b0013eb7e91a71mr17005086pzj.14.1692896552070;
        Thu, 24 Aug 2023 10:02:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e6ec:4683:972:2d78? ([2620:15c:211:201:e6ec:4683:972:2d78])
        by smtp.gmail.com with ESMTPSA id r15-20020a62e40f000000b006887037cde6sm1499780pfh.60.2023.08.24.10.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 10:02:31 -0700 (PDT)
Message-ID: <e4701e0e-57a3-6ee3-8686-6b1d3750c124@acm.org>
Date:   Thu, 24 Aug 2023 10:02:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 0/6] blk-mq: optimize the queue_rqs() support
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230824144403.2135739-1-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230824144403.2135739-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 07:43, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The current queue_rqs() support has limitation that it can't work on
> shared tags queue, which is resolved by patch 1-3. We move the account
> of active requests to where we really allocate the driver tag.
> 
> This is clearer and matched with the unaccount side which now happen
> when we put the driver tag. And we can remove RQF_MQ_INFLIGHT, which
> was used to avoid double account problem of flush request.
> 
> Another problem is that the driver that support queue_rqs() has to
> set inflight request table by itself, which is resolved in patch 4.
> 
> The patch 5 fixes a potential race problem which may cause false
> timeout because of the reorder of rq->state and rq->deadline.
> 
> The patch 6 add support queue_rqs() for null_blk, which showed a
> 3.6% IOPS improvement in fio/t/io_uring benchmark on my test VM.
> And we also use it for testing queue_rqs() on shared tags queue.

Hi Jens and Christoph,

This patch series would be simplified significantly if the code for
fair tag allocation would be removed first
(https://lore.kernel.org/linux-block/20230103195337.158625-1-bvanassche@acm.org/, 
January 2023).
It has been proposed to improve fair tag sharing but the complexity of
the proposed alternative is scary
(https://lore.kernel.org/linux-block/20230618160738.54385-1-yukuai1@huaweicloud.com/, 
June 2023).
  Does everyone agree with removing the code for fair tag sharing - code
that significantly hurts performance of UFS devices and code that did
not exist in the legacy block layer?

Thanks,

Bart.
