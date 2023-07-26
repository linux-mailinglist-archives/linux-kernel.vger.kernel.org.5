Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8274762F30
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjGZIG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjGZIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:06:21 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374AB5257
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:58:40 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52218903f41so1102759a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358318; x=1690963118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rArkLhnWUlIK4304QM/qMQbcdjqKn5ft/zJeEhBuNj0=;
        b=XIzN9RecS92t8YlHN8t2c/RQuqX/QY+mS0bCi/pJA0s28U8I5zVaJD4mlg2ZPj3F1g
         b18F/DGLY2soT962KTHvNlU7T5LrRAnhztc+FCDsDofV5Md1mEJhIqzeVvYnTOji89fP
         YjpRHYwQy6WhX2+dVyd4z4uIxWyAkA+7m8zhXlM1OEZgZR0Jh0JeQ/ZQ5Md+EPoKpH3a
         QKb+yRNZXI7XfaD+cn5hDXcumtqNz3NxHQG2pd1g2GV0SgGTrIR48WufLzGFVnJ5JowX
         Q2YD1MgH95/gh6hPyfBrW4MiDz/NTVT9QnpedSQkEozTowmUUS9zioudpi+fjoG7ajXN
         sX/w==
X-Gm-Message-State: ABy/qLb+ER9uHnmKD7afE96bfK207CZeJH0jgCy0kuhC7OU92eWQTBuq
        Uq9/j7rIqYPFFQb7Hec0UXI=
X-Google-Smtp-Source: APBJJlE75PBRDWnYZDfkulwH3fm6QqsNZRSZ1N7P13z+sDsfk/xykOgPxCQQusachBN1RjIoVLR6rw==
X-Received: by 2002:a05:6402:278f:b0:522:3f32:52f1 with SMTP id b15-20020a056402278f00b005223f3252f1mr1109591ede.3.1690358318560;
        Wed, 26 Jul 2023 00:58:38 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7d9da000000b005226f281bc5sm517939eds.25.2023.07.26.00.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:58:37 -0700 (PDT)
Message-ID: <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
Date:   Wed, 26 Jul 2023 10:58:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Pratyush Yadav <ptyadav@amazon.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230725110622.129361-1-ptyadav@amazon.de>
 <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> If a device has no NUMA node information associated with it, the driver
>> puts the device in node first_memory_node (say node 0). As a side
>> effect, this gives an indication to userspace IRQ balancing programs
>> that the device is in node 0 so they prefer CPUs in node 0 to handle the
>> IRQs associated with the queues. For example, irqbalance will only let
>> CPUs in node 0 handle the interrupts. This reduces random access
>> performance on CPUs in node 1 since the interrupt for command completion
>> will fire on node 0.
>>
>> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
>> information for the NVMe devices. This means all NVMe devices have
>> NUMA_NO_NODE by default. Without this patch, random 4k read performance
>> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
>> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
>> both nodes get similar performance (around 315k IOPS).
> 
> irqbalance doesn't work with this driver though: the interrupts are
> managed by the kernel. Is there some other reason to explain the perf
> difference?

Maybe its because the numa_node goes to the tagset which allocates
stuff based on that numa-node ?
