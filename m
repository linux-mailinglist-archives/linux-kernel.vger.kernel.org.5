Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2C80C2C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjLKIKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjLKIKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:10:49 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B581DD5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:10:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyDC938_1702282251;
Received: from 30.97.48.179(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VyDC938_1702282251)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 16:10:52 +0800
Message-ID: <9fd5a85e-2521-4295-938b-bedb9ee1b67b@linux.alibaba.com>
Date:   Mon, 11 Dec 2023 16:10:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] erofs: support I/O submission for sub-page compressed
 blocks
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, dhavale@google.com,
        Yue Hu <huyue2@coolpad.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
 <20231206091057.87027-2-hsiangkao@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231206091057.87027-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/6 17:10, Gao Xiang wrote:
> Add a basic I/O submission path first to support sub-page blocks:
> 
>   - Temporary short-lived pages will be used entirely;
> 
>   - In-place I/O pages can be used partially, but compressed pages need
>     to be able to be mapped in contiguous virtual memory.
> 
> As a start, currently cache decompression is explicitly disabled for
> sub-page blocks, which will be supported in the future.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

...

> +		cur = mdev.m_pa;
> +		end = cur + pcl->pclusterpages << PAGE_SHIFT;

In this patch, here should be
end = cur + (pcl->pclusterpages << PAGE_SHIFT);

but since this line will be immediately updated in the next patch
as `end = cur + pcl->pclustersize;` so it will have no impact.
I've fixed it up in the development tree.

Thanks,
Gao Xiang
