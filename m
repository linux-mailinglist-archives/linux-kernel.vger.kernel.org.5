Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE3F7834E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjHUV0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHUV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:26:32 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E6AD9;
        Mon, 21 Aug 2023 14:26:31 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-68a40d8557eso1128401b3a.1;
        Mon, 21 Aug 2023 14:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653190; x=1693257990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYdThbcfPBUfAaFKHVhMtwKpLsWs6Eist/KgBO2PSlY=;
        b=akT5ng2e/0lx8UgWEwwgqMYUuGPOL40tP1dezkIFqGIzUnOI5cch44ZMbo5OAwFdgg
         PwtmMMgJs15Iw2ID8DVssJrmNZbHxYgRPz9+c6zCzAJCGol/8AXYs+XCMHWae1ov0sRA
         ij4cLPxC4SAA59xHfofz2lfMxznbtDh/i98pQeaLcVg98hsgVpHIw3uDfiJCpVawuD9V
         +Yg5dfzzCKyQhN8rk+qo+mM8NWzmFbb5MX6kJmI38qRXLFyWtk/31r894fcQoamuxb38
         M6ZBG/BnyxknBm7vPufY5QXfzyf3iE6jT+AdfJ+wsHvrz4s/3qa+bPkDVamJSHOc2yRA
         PDTg==
X-Gm-Message-State: AOJu0YzJPZb9foyoaKMUBIzljUU3sg0XfrOnpDH7FxShn95DoEKwSIv7
        F7OtJBoHbk1ocBPSbEJjF4k=
X-Google-Smtp-Source: AGHT+IHFiJ6TbnbMo3l/fAvwmNGMqr1Mazp/xHt1GPCte/CcOQYWGI0JIq3sR90N4ef3MnojFAveIA==
X-Received: by 2002:a05:6a00:15c1:b0:684:bb4a:b86e with SMTP id o1-20020a056a0015c100b00684bb4ab86emr11738582pfu.1.1692653190273;
        Mon, 21 Aug 2023 14:26:30 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ef58:6534:ec7a:8ab2? ([2620:15c:211:201:ef58:6534:ec7a:8ab2])
        by smtp.gmail.com with ESMTPSA id f11-20020aa782cb000000b00688965c5227sm6558492pfn.120.2023.08.21.14.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 14:26:29 -0700 (PDT)
Message-ID: <98296794-01e6-7192-ef3f-0ea454527aaf@acm.org>
Date:   Mon, 21 Aug 2023 14:26:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/4] blk-mq-tag: remove bt_for_each()
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230821073528.3469210-1-chengming.zhou@linux.dev>
 <20230821073528.3469210-3-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230821073528.3469210-3-chengming.zhou@linux.dev>
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
> 2. __blk_mq_tagset_busy_iter() has BT_TAG_ITER_STARTED flag set, so only
>     started requests will be iterated, which should be more efficient.

The above motivation sounds wrong to me. The goal here should be not to
change the behavior of blk_mq_queue_tag_busy_iter(). Although
blk_mq_queue_tag_busy_iter() iterates over more requests than only started
requests, apparently blk_mq_queue_tag_busy_iter() is only used to iterate
over started requests (blk_mq_request_started()). Please mention this in
the patch description.

Thanks,

Bart.
