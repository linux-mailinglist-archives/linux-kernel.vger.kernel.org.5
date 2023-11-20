Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981FD7F1901
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjKTQoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjKTQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:44:35 -0500
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25AF1717
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:43:58 -0800 (PST)
Message-ID: <0c6e0cd5-d975-41cc-824e-10b5e28251a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700498637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4o3VOG4ILfrr1T6P8PAEWTvAp9sZLW5F5DWCMWcaJk=;
        b=rzLTLU2lqlffIevvY9geCyHiANnAhG5jcXbK47RH6QB7Um4NX0reB6N9SujkFNYlSOws4i
        TZaRQVi89F8PzHmyRY7ZfipNsf44iIvLisZVLVZQ2TtTY6yx0IDmTRPFv1FGBvGsk0SiGc
        Hf6w14c6ee9ihsCdof6TRfGV2LNZD4o=
Date:   Mon, 20 Nov 2023 16:43:50 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] dpll: Fix potential msg memleak in
 dpll_nl_pin_id_get_doit
Content-Language: en-US
To:     Hao Ge <gehao@kylinos.cn>
Cc:     michal.michalik@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, gehao618@163.com,
        arkadiusz.kubalewski@intel.com
References: <20231120090758.31378-1-gehao@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231120090758.31378-1-gehao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 04:07, Hao Ge wrote:
> We should clean the skb resource if genlmsg_put_reply failed.
> 
> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>   drivers/dpll/dpll_netlink.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index a6dc3997bf5c..54051cd34d43 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -1093,9 +1093,10 @@ int dpll_nl_pin_id_get_doit(struct sk_buff *skb, struct genl_info *info)
>   		return -ENOMEM;
>   	hdr = genlmsg_put_reply(msg, info, &dpll_nl_family, 0,
>   				DPLL_CMD_PIN_ID_GET);
> -	if (!hdr)
> +	if (!hdr) {
> +		nlmsg_free(msg);
>   		return -EMSGSIZE;
> -
> +	}
>   	pin = dpll_pin_find_from_nlattr(info);
>   	if (!IS_ERR(pin)) {
>   		ret = dpll_msg_add_pin_handle(msg, pin);

The change seems reasonable, but we have 4 spots of the same problem
in the file, could you please fix all of them in one patch?

pw-bot: cr
