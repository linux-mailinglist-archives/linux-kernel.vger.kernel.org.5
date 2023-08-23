Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387F6785AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjHWOjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjHWOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:39:43 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C7E54;
        Wed, 23 Aug 2023 07:39:42 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-68a40d8557eso2457071b3a.1;
        Wed, 23 Aug 2023 07:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801581; x=1693406381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OE/HnNTZ2Hp/wY8Q6I9B3Ei2exAHrxqSNYI7mKbQYn8=;
        b=i8m+8MWM9IN+2X7rHA5Up63A8PYUfTOqJOgyhK3bWszS8i+/lwVGU1NWjpqiA+ICCq
         k+1CasbzG1WkaE9wYuRxiGylZr3l5XpygdPBqOIcvyqeM0zG0OaAc1vfruPvafn9ZfnX
         ZD5/6bBpQhHqcriHhCuSUlEybwYeLdbsSTCpuybvfry14+7siip0jJKEjPekIOSgfOIt
         e7TX7jBXmQ90oA15HUocRL02htePXurAxo/HKcQsnMfDb+hEJ8O3lf8opVacpvRpXoim
         3Nw9Sburxoua8g6/gkfzWz9UKRzd+w/8Bli34a9p/HGeQAIhqXVLeNuYqQThir5gvOMA
         I5pw==
X-Gm-Message-State: AOJu0YxVHFkJ20z9lFpJzneb1rcHWws8jsY/XpzDA/cZn7UVIfTs/rIT
        ODNnORGQa3sxhL6VLXIJBXs=
X-Google-Smtp-Source: AGHT+IHhnR2ucNMEn2wuM5A6KFR5XPYQ4RXZhV7erEPjJ5ekpOYgI+YrPjaoYdZc8SevXOOZpc2Jdg==
X-Received: by 2002:a05:6a00:4806:b0:68a:2c6e:c2cc with SMTP id di6-20020a056a00480600b0068a2c6ec2ccmr13264882pfb.0.1692801581537;
        Wed, 23 Aug 2023 07:39:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ecb6:e8b9:f433:b4b4? ([2620:15c:211:201:ecb6:e8b9:f433:b4b4])
        by smtp.gmail.com with ESMTPSA id 1-20020aa79241000000b0065a1b05193asm9507594pfp.185.2023.08.23.07.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 07:39:41 -0700 (PDT)
Message-ID: <4751eb9b-755f-f890-cdda-03abff15e6f4@acm.org>
Date:   Wed, 23 Aug 2023 07:39:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 3/6] blk-mq-tag: remove bt_for_each()
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230823090441.3986631-1-chengming.zhou@linux.dev>
 <20230823090441.3986631-4-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230823090441.3986631-4-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 02:04, chengming.zhou@linux.dev wrote:
> Change the only user of bt_for_each() to use the introduced function
> __blk_mq_tagset_busy_iter() to specify queue filter when iterating.
> 
> Since blk_mq_queue_tag_busy_iter() is only used to iterate over started
> requests, __blk_mq_tagset_busy_iter() already have BT_TAG_ITER_STARTED
> filter to iterate over started requests only, there should be no
> problem.
> 
> Only one potential disadvantage I can see is that we lost the
> blk_mq_hw_queue_mapped() filter, which maybe not happen for now.
> Unmapped hctx was used to dynamically map or unmap when CPU hotplug,
> but we don't do this anymore, we always map all possible CPUs now.
> So it seems unmapped hctx may only happen if something wrong with
> driver's tagset map settings.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

