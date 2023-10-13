Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2458E7C81D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjJMJUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJMJUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:20:33 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DDE95;
        Fri, 13 Oct 2023 02:20:30 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qrEKy-0006XP-FO; Fri, 13 Oct 2023 11:20:04 +0200
Date:   Fri, 13 Oct 2023 11:20:04 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ma Ke <make_ruc2021@163.com>
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: Fix uninit-value access in tipc_nl_node_get_link()
Message-ID: <20231013092004.GA4980@breakpoint.cc>
References: <20231013070408.1979343-1-make_ruc2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013070408.1979343-1-make_ruc2021@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ma Ke <make_ruc2021@163.com> wrote:
> Names must be null-terminated strings. If a name which is not 
> null-terminated is passed through netlink, strstr() and similar 
> functions can cause buffer overrun. This patch fixes this issue 
> by returning -EINVAL if a non-null-terminated name is passed.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/tipc/node.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 3105abe97bb9..a02bcd7e07d3 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -2519,6 +2519,9 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
>  		return -EINVAL;
>  
>  	name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
> +	if (name[strnlen(name,
> +			 nla_len(attrs[TIPC_NLA_LINK_NAME]))] != '\0')
> +		return -EINVAL;

If the existing userspace is passing 0-terminated strings it would be
better to fix the policy (tipc_nl_link_policy) instead (and set NLA_NUL_STRING).

And if not, above change breaks userspace.
