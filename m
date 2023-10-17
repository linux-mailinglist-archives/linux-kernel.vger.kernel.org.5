Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023417CBD03
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjJQICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:02:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AF595
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:02:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B7FC433C8;
        Tue, 17 Oct 2023 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697529734;
        bh=hBRPEhQBiSI81nd4KdECGTfCnCSML4Jby3geJfist6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKwx6j6u/UIx6P1emJ78Stnx1hzg6hAQBKTU/o0ndP6yoyFeYSjl3lGrC4upjk8gK
         ng83qjzrrR1yRpmdxJEYbA/bSuxyrV9bSxfMia2GQedncXLVpylwH/Tr21pLL5K8YR
         taPsPmlkSmXoICL8DdIKS36l/Zpi+NKUhsrRE3u9rCeN2EQXCOlh7NzoX+ry4C59+S
         LQpqijokc6aOlFUuwWL02pQo6emKmcCxrIu6uhkO/nurt4SuSM802JUgCgMWOc19PL
         fQ+r17C+T+RtpgAEy1wBy4CH7+z/snf+GepHZTNm+zSrG/dzSyoqbNnxOj0pqh7sm+
         TbUjAMMyVNVmg==
Date:   Tue, 17 Oct 2023 10:02:10 +0200
From:   Simon Horman <horms@kernel.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        Liam.Howlett@oracle.com, netdev@vger.kernel.org,
        oliver.sang@intel.com, kuba@kernel.org
Subject: Re: [PATCH v1] Fix NULL pointer dereference in cn_filter()
Message-ID: <20231017080210.GG1751252@kernel.org>
References: <20231013225619.987912-1-anjali.k.kulkarni@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013225619.987912-1-anjali.k.kulkarni@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 03:56:19PM -0700, Anjali Kulkarni wrote:
> Check that sk_user_data is not NULL, else return from cn_filter().

Thanks,

I agree that this change seems likely to address the problem at the link
below. And I also think cn_filter() is a good place to fix this [1].
But I am wondering if you could add some commentary to the patch
description, describing under what circumstances this problem can occur.

[1] https://lore.kernel.org/all/20231013120105.GH29570@kernel.org/

> Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@intel.com/
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  drivers/connector/cn_proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 05d562e9c8b1..a8e55569e4f5 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -54,7 +54,7 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>  	enum proc_cn_mcast_op mc_op;
>  	uintptr_t val;
>  
> -	if (!dsk || !data)
> +	if (!dsk || !data || !dsk->sk_user_data)
>  		return 0;
>  
>  	ptr = (__u32 *)data;
> -- 
> 2.42.0
> 
