Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0576785A83
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbjHWO3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbjHWO3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:29:41 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9216BE54;
        Wed, 23 Aug 2023 07:29:39 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1cc87405650so2050872fac.2;
        Wed, 23 Aug 2023 07:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800979; x=1693405779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVPsImqY9zUWDGiut17nagmDeGBMfQyIFhH7z+M3iFs=;
        b=eDgJyseedSI4BoRU7ly8qZUWHHXsxjbS/KRnMMO+o8Qwkkvb6kZiEtz+yVPW5T2hpP
         pbHI3IMPFRxAv6L0xwyNXc5E6fBUIdGrAz0PcsGXXfuHnpvUiVfXjhHrBMYSd95RCSqU
         0m8Kf0kUA9n651ub/lWcF8UUEl6DWRkkonN6cAg/v3Tpjr56JfhEk5yaU1QicsjKRbRr
         erWeeA93vY9a/B4f3G+Qeh70dsb9yc4K0lYLvHuMaIlSA7zYTc5OXX1dtNZrgkHxR3uN
         NkuPbI+IjuI7DqhU1D0oaG9zOEovDv2Td19IXL0SrhWUd7EZ3p5d53T0zVYB5ppXZPSg
         F4Gg==
X-Gm-Message-State: AOJu0YyqDKmXDB/i1sfX7Fe0i7gkdX779pqqlYGWJ8LkNorH0uR94vid
        Gf2QEJYdqXUU6p2m3gl1ZqLvrBGU6n8=
X-Google-Smtp-Source: AGHT+IH4g+dl1D9eDLNljo2VY3UcD9u8pkJtu3XjEPhwv6CLxh5XbnolUBziW+TrfMvRSEU9Y90Rzw==
X-Received: by 2002:a05:6870:64aa:b0:1bf:50e0:95d9 with SMTP id cz42-20020a05687064aa00b001bf50e095d9mr16033028oab.26.1692800978780;
        Wed, 23 Aug 2023 07:29:38 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ecb6:e8b9:f433:b4b4? ([2620:15c:211:201:ecb6:e8b9:f433:b4b4])
        by smtp.gmail.com with ESMTPSA id mu13-20020a17090b388d00b0026d54b2abe9sm8866711pjb.37.2023.08.23.07.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 07:29:38 -0700 (PDT)
Message-ID: <5069d917-ed83-4036-709f-f97871968d13@acm.org>
Date:   Wed, 23 Aug 2023 07:29:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 2/6] blk-mq-tag: introduce __blk_mq_tagset_busy_iter()
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230823090441.3986631-1-chengming.zhou@linux.dev>
 <20230823090441.3986631-3-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230823090441.3986631-3-chengming.zhou@linux.dev>
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
> For support of specified queue filter when iterating over a tagset,
> we introduce __blk_mq_tagset_busy_iter() here and all current users
> just set queue as NULL which means have no queue filter.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
