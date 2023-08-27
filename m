Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159157899F1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 02:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjH0AqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 20:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjH0Ap7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 20:45:59 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3683419A;
        Sat, 26 Aug 2023 17:45:57 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-68a3082c771so1416469b3a.0;
        Sat, 26 Aug 2023 17:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097156; x=1693701956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0noXuCw4diQPVVy5tMWjuaRU2NrMA9lPR9xkJ2qTPY=;
        b=azA0pKXL4z+pCUgeG6MDwvEnAEn7gpMCm1RcrMk9EyVa1DSibYdGFZC5DO6/GTEkyx
         MykGtdgr2BtbMkUES9hSqswzybjc0miW73hRKIPuPkN4lhoVo+K0Wqe3Bbfqx0eLZPWS
         S9rEnIMyMNc169VA1ApWUBVFr7Z8OvPf+ptbavvkHVh723DdGlZIMYnLS5R1723QeFyt
         Vjl7wuulTG8DUh/OiAzy75ldlGXapJP3zfcPphkTFt3P3evzuOCok5pYY7G1onTJMJ85
         lhuvkqZsG7kf3sx1h21Te1wfak105VgF/m/z00sIE2xRB8hjMUHN/YbXIwdFpYCdDBuP
         dFjw==
X-Gm-Message-State: AOJu0YypGh7bvBbqiZBzCbY8/1jsIo/zacC3dLikm2EI858eEhQb1EYG
        9swcGQCD3bX2jNo9KLjAbeI=
X-Google-Smtp-Source: AGHT+IEgibIA76mDWHaRopAmphTXDvMSnqQaRh2bxRTFviWwjc2MyEgi19ys/Gu6OUOtT4Kq3DUVsQ==
X-Received: by 2002:a05:6a00:a1f:b0:68a:6149:71cb with SMTP id p31-20020a056a000a1f00b0068a614971cbmr24088914pfh.5.1693097156403;
        Sat, 26 Aug 2023 17:45:56 -0700 (PDT)
Received: from ?IPV6:2601:647:5f00:5f5:4a46:e57b:bee0:6bc6? ([2601:647:5f00:5f5:4a46:e57b:bee0:6bc6])
        by smtp.gmail.com with ESMTPSA id x15-20020a056a00270f00b0068a4cd8b530sm3858797pfv.139.2023.08.26.17.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 17:45:55 -0700 (PDT)
Message-ID: <c48a294c-a8a9-63ae-182f-e1d757f6179e@acm.org>
Date:   Sat, 26 Aug 2023 17:45:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/6] blk-mq: optimize the queue_rqs() support
To:     Chengming Zhou <chengming.zhou@linux.dev>, axboe@kernel.dk,
        hch@lst.de, ming.lei@redhat.com, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230824144403.2135739-1-chengming.zhou@linux.dev>
 <e4701e0e-57a3-6ee3-8686-6b1d3750c124@acm.org>
 <84c857f7-9966-6125-92c4-1b2fa96fb98d@linux.dev>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <84c857f7-9966-6125-92c4-1b2fa96fb98d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 01:24, Chengming Zhou wrote:
> I don't know the details of the UFS devices bad performance problem.
> But I feel it maybe caused by the too lazy queue idle handling, which
> is now only handled in queue timeout work.

Hi Chengming,

The root cause of the UFS performance problem is the fair sharing
algorithm itself: reducing the active queue count only happens after
the request queue timeout has expired. This is way too slow. Last time
it was proposed to remove that algorithm Yu Kuai promised to replace it
by a better algorithm. Since progress on the replacement algorithm has
stalled I'm asking again whether everyone agrees to remove the fairness
algorithm.

Thanks,

Bart.
