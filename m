Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27722785A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbjHWO2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjHWO2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:28:19 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F5CE54;
        Wed, 23 Aug 2023 07:28:18 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso37414965ad.0;
        Wed, 23 Aug 2023 07:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800897; x=1693405697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifSk/zsvJJFaiG6xt0kd3cwJmAV4kGD5Bq/Ohxo7ks0=;
        b=VbDoCHj83wm/8SG6ANgr0zjOR9/U54QTTvoYixMWTrCO8Hgg8osQhTe5zqQrHIfDGm
         Md8lmizmjjELb8UR4Hv4E/4oYPrpZi11uoIcpmpowNf+YfNgPVax1hf0/AhBnLMVNvZE
         gycWq5YvVrPzCp8teUS20z7IMuPzLO+81KXnX9q5QQeMJU2bNOBz2rlBa5Fg4I5sJhlP
         yJ4LZ57QRgwMPnwwEgTKkY4PBqd5Uipdk9nOaIEaGaI1CVmqYvAEnChbzfuDcJ4YrLsR
         4frZbSuQnH4D0wPJMYec3D4dmeD7mtScBL0lRuIQI1psbhdDv2ltRcAxaOfTcF4Koo+X
         uRAg==
X-Gm-Message-State: AOJu0YzOjSz8PRwBL9jOEnIRN8u/ikHO9qMRr3OvFGCszeL/JbJJ4d82
        SmJHC59kA7ZfGStdxFGbB0Q=
X-Google-Smtp-Source: AGHT+IFwpdtgp8F8RGlrjvFxJk+k7IAaPAnQOVe4Lxqk60PIWuIuUzZMOwAcfCHMHKa65pYms/sLIQ==
X-Received: by 2002:a17:902:b582:b0:1b9:e591:db38 with SMTP id a2-20020a170902b58200b001b9e591db38mr9367083pls.8.1692800897460;
        Wed, 23 Aug 2023 07:28:17 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ecb6:e8b9:f433:b4b4? ([2620:15c:211:201:ecb6:e8b9:f433:b4b4])
        by smtp.gmail.com with ESMTPSA id iz22-20020a170902ef9600b001b9da42cd7dsm11107382plb.279.2023.08.23.07.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 07:28:16 -0700 (PDT)
Message-ID: <a1732d82-2b5d-7865-d13f-dde1f31257d8@acm.org>
Date:   Wed, 23 Aug 2023 07:28:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 1/6] blk-mq-tag: support queue filter in bt_tags_iter()
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230823090441.3986631-1-chengming.zhou@linux.dev>
 <20230823090441.3986631-2-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230823090441.3986631-2-chengming.zhou@linux.dev>
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
> The only user of bt_for_each() is blk_mq_queue_tag_busy_iter(), which
> need to filter queue when iterate the tags. In preparation of removing
> bt_for_each(), support queue filter in bt_tags_iter().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
