Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9737B2A67
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjI2CzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjI2CzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:55:17 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824F199;
        Thu, 28 Sep 2023 19:55:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 4E48040003;
        Fri, 29 Sep 2023 02:55:09 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 28 Sep 2023 19:55:09 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH v3 2/2] Make num_actions unsigned
In-Reply-To: <ZRWDCGG5/dP12YEs@calendula>
References: <20230927164715.76744-1-joao@overdrivepizza.com>
 <20230927164715.76744-3-joao@overdrivepizza.com>
 <ZRWDCGG5/dP12YEs@calendula>
Message-ID: <8f531b29873587b4f9b7ee64c745b667@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: joao@overdrivepizza.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-28 06:43, Pablo Neira Ayuso wrote:
> On Wed, Sep 27, 2023 at 09:47:15AM -0700, joao@overdrivepizza.com 
> wrote:
>> From: Joao Moreira <joao.moreira@intel.com>
>> 
>> Currently, in nft_flow_rule_create function, num_actions is a signed
>> integer. Yet, it is processed within a loop which increments its
>> value. To prevent an overflow from occurring, make it unsigned and
>> also check if it reaches 256 when being incremented.
>> 
>> Accordingly to discussions around v2, 256 actions are more than enough
>> for the frontend actions.
>> 
>> After checking with maintainers, it was mentioned that front-end will
>> cap the num_actions value and that it is not possible to reach such
>> condition for an overflow. Yet, for correctness, it is still better to
>> fix this.
>> 
>> This issue was observed by the commit author while reviewing a 
>> write-up
>> regarding a CVE within the same subsystem [1].
>> 
>> 1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/
> 
> Yes, but this is not related to the netfilter subsystem itself, this
> harderning is good to have for the flow offload infrastructure in
> general.

Right, I'll try to look up where this would fit in then. I'm not an 
expert in the subsystem at all, so should take a minute or two for me to 
get to it and send a v4.

> 
>> Signed-off-by: Joao Moreira <joao.moreira@intel.com>
>> ---
>>  net/netfilter/nf_tables_offload.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/netfilter/nf_tables_offload.c 
>> b/net/netfilter/nf_tables_offload.c
>> index 12ab78fa5d84..9a86db1f0e07 100644
>> --- a/net/netfilter/nf_tables_offload.c
>> +++ b/net/netfilter/nf_tables_offload.c
>> @@ -90,7 +90,8 @@ struct nft_flow_rule *nft_flow_rule_create(struct 
>> net *net,
>>  {
>>  	struct nft_offload_ctx *ctx;
>>  	struct nft_flow_rule *flow;
>> -	int num_actions = 0, err;
>> +	unsigned int num_actions = 0;
>> +	int err;
> 
> reverse xmas tree.

ack.

> 
>>  	struct nft_expr *expr;
>> 
>>  	expr = nft_expr_first(rule);
>> @@ -99,6 +100,10 @@ struct nft_flow_rule *nft_flow_rule_create(struct 
>> net *net,
>>  		    expr->ops->offload_action(expr))
>>  			num_actions++;
>> 
>> +		/* 2^8 is enough for frontend actions, avoid overflow */
>> +		if (num_actions == 256)
> 
> This cap is not specific of nf_tables, it should apply to all other
> subsystems. This is the wrong spot.

Any pointers regarding where I should look at?

> 
> Moreover, please, add a definition for this, no hardcoded values.

Ack.

> 
>> +			return ERR_PTR(-ENOMEM);
> 
> Better E2BIG or similar, otherwise this propagates to userspace as
> ENOMEM.

Ack.

> 
>> +
>>  		expr = nft_expr_next(expr);
>>  	}
>> 
>> --
>> 2.42.0
>> 
