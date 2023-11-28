Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2E57FB6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjK1KOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjK1KN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:13:59 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4ADDE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:14:05 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-332eac4dec4so784465f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166443; x=1701771243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PyeWkhuJYg+ePFp+kSJvaI5luSTG8Uu2UJZLlj/UZo=;
        b=fUee5sAhP5pSHGeIiOFKlKASNdkdG+h5VPDCiULGIhgGHPhRRQURh5W0VA2C/pvXYK
         YQe3rUZqXLQ6YFaH2WxYVVewfTrFoOna3SKl4i372DqOlXcauoExZ4vQDnhCfL2r1AQg
         Bmq6m5jBoIqWShGOS05tbtpo4J5+kGe/yl9cL/SlYN0H1XEy/n3t5SIn6L3PPcDqoIFp
         h3rHKgRgyc4N5v30Sk0Ak2mKJELWNCiG8mfIaAzlpu7CkDE6008ApZNCXvZeetNPuFbY
         uAgxisC5LBMtRPaYq/M3OWXidZGy2MYW5H2GHLceO2yn0X6GF9OKiYul5F0HBBl53Ejy
         7XUQ==
X-Gm-Message-State: AOJu0Yy90Lh2KTDSBsw7Js18Bafp2uPJ6Y1Bzkom0OUXNSHbsg9J5iPf
        b04ImoM774SQnkqc1EcyF6g=
X-Google-Smtp-Source: AGHT+IEhXK6aT8AMyc8alUu1ytihrGp9t8QAyTCs3EnK5NY0yhosUs59INceD/+o9lskOO1cBHEZVQ==
X-Received: by 2002:adf:e7cd:0:b0:333:7ad:58e7 with SMTP id e13-20020adfe7cd000000b0033307ad58e7mr2618743wrn.4.1701166443159;
        Tue, 28 Nov 2023 02:14:03 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a11-20020adff7cb000000b00332fda15056sm6524961wrq.110.2023.11.28.02.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:14:02 -0800 (PST)
Message-ID: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
Date:   Tue, 28 Nov 2023 12:13:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
Content-Language: en-US
To:     yaoma <yaoma@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Cc:     axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, kanie@linux.alibaba.com
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
 <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
 <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 08:22, yaoma wrote:
> Hi Keith Busch
> 
> Thanks for your reply.
> 
> The idea to avoid such a deadlock between nvme_reset and nvme_scan is to 
> ensure that no namespace can be added to ctrl->namespaces after 
> nvme_start_freeze has already been called. We can achieve this goal by 
> assessing the ctrl->state after we have already acquired the 
> ctrl->namespaces_rwsem lock, to decide whether to add the namespace to 
> the list or not.
> 1. After we determine that ctrl->state is LIVE, it may be immediately 
> changed to another state. However, since we have already acquired the 
> lock, other tasks cannot access ctrl->namespace, so we can still safely 
> add the namespace to the list. After acquiring the lock, 
> nvme_start_freeze will freeze all ns->q in the list, including any newly 
> added namespaces.
> 2. Before the completion of nvme_reset, ctrl->state will not be changed 
> to LIVE, so we will not add any more namespaces to the list. All ns->q 
> in the list is frozen, so nvme_wait_freeze can exit normally.

I agree with the analysis, there is a hole between start_freeze and
freeze_wait that a scan may add a ns to the ctrl ns list.

However the fix should be to mark the ctrl with say NVME_CTRL_FROZEN
flag set in nvme_freeze_start and cleared in nvme_unfreeze (similar
to what we did with quiesce). Then the scan can check it before adding
the new namespace (under the namespaces_rwsem).
