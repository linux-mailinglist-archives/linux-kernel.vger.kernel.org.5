Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011F17A2D78
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbjIPC2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbjIPC2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:28:23 -0400
Received: from out-226.mta1.migadu.com (out-226.mta1.migadu.com [95.215.58.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20C1BF8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:28:17 -0700 (PDT)
Message-ID: <a3a0c874-8a92-0018-2593-f18a28545080@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694831293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvtGlibQ0yiv0zX+Y4QAMspnPl76rPSHm/0SF9GzIiA=;
        b=CIYfBgQ2nOj+uwXfF3zhuTSiSGT4cGUE2wiUXUkMx/z0eQyUW1n9uyeDX9UnS7I4auEGax
        2TCGkZ1gt2YohH/mpJhhNQzwsZa3Shw5Mv5omaUKC988avV00VZgsFCgzYP7UeaKwFzsJA
        EdgiBVxspqyAhIKpsaow5ECJccZw8Uo=
Date:   Sat, 16 Sep 2023 10:28:06 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Call rxe_set_mtu after
 rxe_register_device
To:     Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
References: <20230823061141.258864-1-lizhijian@fujitsu.com>
 <20230823061141.258864-2-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230823061141.258864-2-lizhijian@fujitsu.com>
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

在 2023/8/23 14:11, Li Zhijian 写道:
> rxe_set_mtu() will call rxe_info_dev() to print message, and
> rxe_info_dev() expects dev_name(rxe->ib_dev->dev) has been assigned.
> 
> Previously since dev_name() is not set, when a new rxe link is being
> added, 'null' will be used as the dev_name like:
> 
> "(null): rxe_set_mtu: Set mtu to 1024"
> 
> Move rxe_register_device() earlier to assign the correct dev_name
> so that it can be read by rxe_set_mtu() later.
> 
> And it's safe to do such change since mtu will not be used during the
> rxe_register_device()
> 
> After this change, message becomes:
> "rxe_eth0: rxe_set_mtu: Set mtu to 4096"
> 
> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

In rxe_register_device function, the correct dev_name is assigned.
So the rxe_info_dev in rxe_set_mtu can use the correct dev_name.
I am fine with it.

It seems that it is a trivial problem. If the Fixes tag is added, then 
we can know which commit introduces this problem, it is better.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,
Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index a086d588e159..8a43c0c4f8d8 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -169,10 +169,13 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>    */
>   int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
>   {
> +	int ret;
> +
>   	rxe_init(rxe);
> +	ret = rxe_register_device(rxe, ibdev_name);
>   	rxe_set_mtu(rxe, mtu);
>   
> -	return rxe_register_device(rxe, ibdev_name);
> +	return ret;
>   }
>   
>   static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)

