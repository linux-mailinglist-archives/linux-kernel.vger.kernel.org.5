Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042BF7AF481
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjIZTz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjIZTz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:55:27 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72299D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:55:18 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40471c054f9so28420625e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695758117; x=1696362917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx3P9XMJrUWs/rcJWQ9bHQisSJ4667Rmi6WpZzvHcL0=;
        b=gSmCall1GT+FaU9OHrP1iSkbod3jw8SWOAlvFqIpvxHDqJWZlMohRIYx3tXhzCP7oz
         Ql4Yjqp8C+oVed0d501aA80LUK/+RSqjG5YAb5T6fALu+i2L4nESrzo6DwYZ1EKUI8+1
         3/2/gy3pVWd1Cg/tFI67qJ5IPIk49SyFz1hMOr62s1RIZ+TXpIGEKSxLKumoTg67R8Ry
         2GdPmqtpnbX/JCoISC2BptPLM0DmTQWI8Y1SmOXbwJ1lMjsWbSBsXDm8kptDpNrah1om
         94H35YXGI3dfCJsczX1gGHYxKqhUQ2WtcSHCrHlxs491HcZdidg1+z+To2dWJj8aIuPE
         vq9A==
X-Gm-Message-State: AOJu0YzdUOr1uFPR9rP2lQdyDQ3uyGPEnvy586s0EAIyGtKGEoMqtCzd
        ualuB92TjsfaaEpLAXvI7cI=
X-Google-Smtp-Source: AGHT+IFXNKdjd1NGv/IuiM7qzfv/r8HWdZCSufDFGqBU8Zq1onz7/xYA0lEqCceiUKgF7NgIBoX+MA==
X-Received: by 2002:a05:600c:4e05:b0:405:3cc1:e115 with SMTP id b5-20020a05600c4e0500b004053cc1e115mr9594967wmq.3.1695758116659;
        Tue, 26 Sep 2023 12:55:16 -0700 (PDT)
Received: from [10.100.102.67] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b00321773bb933sm15558190wrp.77.2023.09.26.12.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 12:55:15 -0700 (PDT)
Message-ID: <709e6baa-8ac5-4f2c-984b-0d7b06deb7d0@grimberg.me>
Date:   Tue, 26 Sep 2023 22:55:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-rdma: use spin_lock_bh() on rsp_wr_wait_lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>, hch@lst.de, kch@nvidia.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230926172208.55478-1-dg573847474@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230926172208.55478-1-dg573847474@gmail.com>
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



On 9/26/23 20:22, Chengfeng Ye wrote:
> It seems to me that read_cqe.done could be executed under softirq
> context,

It doesn't though.

>   as done callbacks always do, and it acquires rsp_wr_wait_lock
> along the following call chain.

The CQ polling context is IB_POLL_WORKQUEUE, which does not
run in softirq.
