Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FD3785AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjHWOkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjHWOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:40:16 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAFBE6C;
        Wed, 23 Aug 2023 07:40:08 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68a2bf8d404so3045987b3a.2;
        Wed, 23 Aug 2023 07:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801607; x=1693406407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4P9cGQmQ1aa6ihOJDcvqSptgPyazuBXLIyyVFrXDX4=;
        b=hslAmqsCh9a1bcHktZkXPrmiJoJnlodp6LAlVyNHs/KPtgj+sN1oi/3uRQxG1+TuVZ
         ke5rlWKHt9LnRwpxfzmYGvLCt3B5G54VZLSG2DIemjpIlyXH7MOXFWnphQ08+dG2EX8C
         HGhrmuL5kBdWarWL+nYeBaMo46+Rl2NYu6dUYeioSP5ho3Ee5h17gYb7M4gFzJncafh0
         JANzgpZSutzf8fz9vvzQJv9uYw+6Xtw3WbNQTzbx0448AeETX0AZVRSoFJPMICzhdi/D
         adEP6hvblAO4tD83HgqBTzgMcKFrWuKFBznLrr9nJ8Bd9hoMxHQXh6lhjlZ/58UbFsmQ
         MuNQ==
X-Gm-Message-State: AOJu0YxqxYA+3SRVhUWRp9GYuvnjzICSvTcHKdsfZT0k3axhtolFp1ld
        h8YiIzjb4hlI32IX8H8Olp0=
X-Google-Smtp-Source: AGHT+IGARscpNm3kGU1DL+jFozDCAf3w/jNFhr2Q0T7m+wMvFfDGTDf8jw1LAIyhxGp6crwKOXnn8A==
X-Received: by 2002:a05:6a21:3d82:b0:13e:f5b5:48f5 with SMTP id bj2-20020a056a213d8200b0013ef5b548f5mr9987438pzc.27.1692801607320;
        Wed, 23 Aug 2023 07:40:07 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ecb6:e8b9:f433:b4b4? ([2620:15c:211:201:ecb6:e8b9:f433:b4b4])
        by smtp.gmail.com with ESMTPSA id s11-20020a62e70b000000b006887037cde6sm9513954pfh.60.2023.08.23.07.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 07:40:06 -0700 (PDT)
Message-ID: <6929b5d6-7f16-e217-57c6-5081c093c71f@acm.org>
Date:   Wed, 23 Aug 2023 07:40:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 4/6] blk-mq: delete superfluous check in iterate
 callback
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230823090441.3986631-1-chengming.zhou@linux.dev>
 <20230823090441.3986631-5-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230823090441.3986631-5-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 02:04, chengming.zhou@linux.dev wrote:
> The previous patch in this series changed the behavior of
> blk_mq_queue_tag_busy_iter() from iterating over all allocated tags into
> iterating over started requests only. Leave out the code from
> blk_mq_rq_inflight() that became superfluous because of this change.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

