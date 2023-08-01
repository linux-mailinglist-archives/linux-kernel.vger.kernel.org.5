Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7498E76A754
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjHADKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHADKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686C919B0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8410612D8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40A1C433C8;
        Tue,  1 Aug 2023 03:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690859400;
        bh=X6Z9QOKzikJGxKFX2tBf3wIQdI88JGKWEXi24Ybq4MA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iIfIeVSu/c4UcRznqKtcdxa18wlnj6ChVSHG7EctmvUsjFt5BapHNNtlwbkJMhOfi
         idGdgH3pQzvmNXj7OI9N9IWV8kI1hur293KpzgusRRmQ08/0nsVuHciWtiIPdUKwNI
         +SKstyRjcz6u6KKccx3JDeD/FdwgkvcrX7qnj89BqtETiNd5ojEXD8Y8VEY4reu64B
         enGGr8yrpHakvkmIrapnuPG2KAYSrOB+XnBCBuVadIIVvP0RddBYDKdjJxj7iP7K5h
         yjRjLmYzhAGFHk4YbcdYWREx+KXVt9c9RN7Phj/XTW9qIWUrrE7eZG/61ZSpxT0Xbj
         oAZcdQLNpr8fA==
Date:   Mon, 31 Jul 2023 20:09:59 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <simon.horman@corigine.com>
Subject: Re: [PATCH v2] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Message-ID: <20230731200959.2019cb9c@kernel.org>
In-Reply-To: <20230728121703.29572-1-yuehaibing@huawei.com>
References: <20230728121703.29572-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 20:17:03 +0800 Yue Haibing wrote:
>  #ifdef CONFIG_IPV6_PIMSM_V2
> +	int nhoff = skb_network_offset(pkt);
>  	if (assert == MRT6MSG_WHOLEPKT || assert == MRT6MSG_WRMIFWHOLE)
> -		skb = skb_realloc_headroom(pkt, -skb_network_offset(pkt)
> -						+sizeof(*msg));
> +		skb = skb_realloc_headroom(pkt, -nhoff + sizeof(*msg));

These changes look unnecessary. You can leave this code be (as ugly as
it is)...

>  	else
>  #endif
>  		skb = alloc_skb(sizeof(struct ipv6hdr) + sizeof(*msg), GFP_ATOMIC);
> @@ -1073,7 +1073,7 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
>  		   And all this only to mangle msg->im6_msgtype and
>  		   to set msg->im6_mbz to "mbz" :-)
>  		 */
> -		skb_push(skb, -skb_network_offset(pkt));
> +		__skb_pull(skb, nhoff);

.. and just replace the push here with:

  __skb_pull(skb, skb_network_offset(pkt));
-- 
pw-bot: cr
