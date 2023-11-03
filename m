Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898597E0343
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376360AbjKCNBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376306AbjKCNBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:01:16 -0400
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA6883
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:01:10 -0700 (PDT)
Message-ID: <d838620b-51df-4216-864e-1c793dae7721@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699016467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaH5UbNRaPO1oWQKZOgotQmiFAiEJv+ANhhhq+28yXY=;
        b=otDa6uKlcfON6j7cYkCpPuFb00G3f2GvjKsL1YwWn5aOgWE8uh6uLqx2U/K59C/ECtbPxK
        5UN2DLVuLkeFGVoHMCxURnj7nwrF+XuB+nvAkKEZlaDn1PnHVq7WdY14vQINErOm53wcmb
        ZTTPx432IOr1nksJIwYJJtStaxP4HMI=
Date:   Fri, 3 Nov 2023 21:00:38 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
To:     Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        yi.zhang@redhat.com
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231103095549.490744-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/11/3 17:55, Li Zhijian 写道:
> I don't collect the Reviewed-by to the patch1-2 this time, since i
> think we can make it better.
> 
> Patch1-2: Fix kernel panic[1] and benifit to make srp work again.
>            Almost nothing change from V1.
> Patch3-5: cleanups # newly add
> Patch6: make RXE support PAGE_SIZE aligned mr # newly add, but not fully tested
> 
> My bad arm64 mechine offten hangs when doing blktests even though i use the
> default siw driver.
> 
> - nvme and ULPs(rtrs, iser) always registers 4K mr still don't supported yet.

Zhijian

Please read carefully the whole discussion about this problem. You will 
find a lot of valuable suggestions, especially suggestions from Jason.

 From the whole discussion, it seems that the root cause is very clear.
We need to fix this prolem. Please do not send this kind of commits again.

Zhu Yanjun

> 
> [1] https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/
> 
> Li Zhijian (6):
>    RDMA/rxe: RDMA/rxe: don't allow registering !PAGE_SIZE mr
>    RDMA/rxe: set RXE_PAGE_SIZE_CAP to PAGE_SIZE
>    RDMA/rxe: remove unused rxe_mr.page_shift
>    RDMA/rxe: Use PAGE_SIZE and PAGE_SHIFT to extract address from
>      page_list
>    RDMA/rxe: cleanup rxe_mr.{page_size,page_shift}
>    RDMA/rxe: Support PAGE_SIZE aligned MR
> 
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 80 ++++++++++++++++-----------
>   drivers/infiniband/sw/rxe/rxe_param.h |  2 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  9 ---
>   3 files changed, 48 insertions(+), 43 deletions(-)
> 

