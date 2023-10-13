Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443777C810B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjJMI5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjJMI5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:57:00 -0400
Received: from out-203.mta0.migadu.com (out-203.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCDD95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:56:58 -0700 (PDT)
Message-ID: <2c7a813d-bbbf-4061-b8ad-efa4e7f03d26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697187413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buruCN/2QVN4PwlAqjp2tz9lsRhDJNGAaY3eMM7JqzM=;
        b=W8cVnmBBDGjI6CVsC+xWcY1+6N0JsdIdCNY3rRqkPSgEjEv+GxL7OYzlYA0FijIfFDfB3S
        bRi78p5Bxd3HkwOOaHMKbYWwFJIE10E9yrqZUXyp+WV69+IarSKzirMzMdAhnR6akVPtWo
        g85UjIl4PNxxn6zrq/pFm0ZtegCybtE=
Date:   Fri, 13 Oct 2023 09:56:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] tipc: Fix uninit-value access in tipc_nl_node_get_link()
Content-Language: en-US
To:     Ma Ke <make_ruc2021@163.com>, jmaloy@redhat.com,
        ying.xue@windriver.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20231013070408.1979343-1-make_ruc2021@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231013070408.1979343-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 08:04, Ma Ke wrote:
> Names must be null-terminated strings. If a name which is not
> null-terminated is passed through netlink, strstr() and similar
> functions can cause buffer overrun. This patch fixes this issue
> by returning -EINVAL if a non-null-terminated name is passed.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   net/tipc/node.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 3105abe97bb9..a02bcd7e07d3 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -2519,6 +2519,9 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
>   		return -EINVAL;
>   
>   	name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
> +	if (name[strnlen(name,
> +			 nla_len(attrs[TIPC_NLA_LINK_NAME]))] != '\0')
> +		return -EINVAL;

The better choice would be to use strncmp() with limit of
TIPC_MAX_LINK_NAME in tipc_node_find_by_name().
This patch fixes tipc_nl_node_get_link(), but the same pattern is used
in tipc_nl_node_set_link() and tipc_nl_node_reset_link_stats(), these
functions also need improvements. Changes to strncmp() and strnstr()
will fix all spots.

>   
>   	msg.skb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>   	if (!msg.skb)

