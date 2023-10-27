Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0680E7D916E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345511AbjJ0I0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345505AbjJ0I0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:26:35 -0400
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 01:26:32 PDT
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAEB1B8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:26:32 -0700 (PDT)
Message-ID: <53c18b2a-c3b2-4936-b654-12cb5f914622@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698394680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cdou9Hk0U8eWsNWSfaIsEXBZ0PmjOPDEb5pe3jgkQTw=;
        b=T4QQCqnqZv2Akii99keI8aXZ4xhlsoZ2lKV5HG7n/KP8YJ4FxVISSUnTrmfIJ4SPXpidk+
        QnhkkpuwdjXefx0vztz6SW16PCi0aRdjQ7mMv9pPcr1xNcsvMf2owxXjWb5R9F3aXrtvRa
        2GydmeMmoVRTd7zYGxlNx4kqf9qceCI=
Date:   Fri, 27 Oct 2023 16:17:42 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
To:     Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231027054154.2935054-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/10/27 13:41, Li Zhijian 写道:
> mr->page_list only encodes *page without page offset, when
> page_size != PAGE_SIZE, we cannot restore the address with a wrong
> page_offset.
> 
> Note that this patch will break some ULPs that try to register 4K
> MR when PAGE_SIZE is not 4K.
> SRP and nvme over RXE is known to be impacted.

When ULP uses folio or compound page, ULP can not work well with RXE 
after this commit is applied.

Perhaps removing page_size set in RXE is a good solution because 
page_size is set twice, firstly page_size is set in infiniband/core, 
secondly it is set in RXE.

When folio or compound page is used in ULP, it is very possible that 
page_size in infiniband/core is different from the page_size in RXE.

Not sure what problem this difference will cause.

Zhu Yanjun

> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index f54042e9aeb2..61a136ea1d91 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -234,6 +234,12 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
>   	struct rxe_mr *mr = to_rmr(ibmr);
>   	unsigned int page_size = mr_page_size(mr);
>   
> +	if (page_size != PAGE_SIZE) {
> +		rxe_info_mr(mr, "Unsupported MR with page_size %u, expect %lu\n",
> +			   page_size, PAGE_SIZE);
> +		return -EOPNOTSUPP;
> +	}
> +
>   	mr->nbuf = 0;
>   	mr->page_shift = ilog2(page_size);
>   	mr->page_mask = ~((u64)page_size - 1);

