Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D75783B21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjHVHtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjHVHs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB3D186
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B1096321B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7583C433C8;
        Tue, 22 Aug 2023 07:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692690535;
        bh=TY1ZJtopoqZnk/J8WbRWRY1hYCrRXFrV6KOhV78sRnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6r/3Yus1QRiINJbp5xlvLPjOQ6ZSK3tVHwSJOu7Jf+gHnUd6ndqe9Iq+cMKB98Zs
         ogyARRLYKBu6zujIdjfxkYsQbk6+kPsl0lISXzEspHy6Pr0trupAdoMhQQqP/4Onbo
         WQI0agE82vSs1mPmhZ1tQ/DYoO/QdJrdYPhj16Euzo/1o85hIe7lux1YbtIsK62LLT
         MaypxmFXFYY4g87PMVVqFUCEAVYFf2KkASgJn57snen0S3D5dqCuvxdx6pU6wUt2Jr
         mMImxLs7WierhbFiYBIEJZ9paa/awfKoNhLBuF/z/53uZ0thIFQw8urT9D9XoAhTk8
         iiBj3n3R+HZNA==
Date:   Tue, 22 Aug 2023 09:48:50 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
        xiyou.wangcong@gmail.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org, shaozhengchao@huawei.com,
        syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Victor Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix a qdisc modification with
 ambiguous command request
Message-ID: <20230822074850.GS2711035@kernel.org>
References: <20230821191305.68275-1-jhs@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821191305.68275-1-jhs@mojatatu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 03:13:05PM -0400, Jamal Hadi Salim wrote:
> When replacing an existing root qdisc, with one that is of the same kind, the
> request boils down to essentially a parameterization change  i.e not one that
> requires allocation and grafting of a new qdisc. syzbot was able to create a
> scenario which resulted in a taprio qdisc replacing an existing taprio qdisc
> with a combination of NLM_F_CREATE, NLM_F_REPLACE and NLM_F_EXCL leading to
> create and graft scenario.
> The fix ensures that only when the qdisc kinds are different that we should
> allow a create and graft, otherwise it goes into the "change" codepath.
> 
> While at it, fix the code and comments to improve readability.
> 
> While syzbot was able to create the issue, it did not zone on the root cause.
> Analysis from Vladimir Oltean <vladimir.oltean@nxp.com> helped narrow it down.
> 
> v1->V2 changes:
> - remove "inline" function definition (Vladmir)
> - remove extrenous braces in branches (Vladmir)
> - change inline function names (Pedro)
> - Run tdc tests (Victor)
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/20230816225759.g25x76kmgzya2gei@skbuf/T/
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_api.c | 54 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index aa6b1fe65151..4c51b8bef1b8 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1547,10 +1547,28 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>  	return 0;
>  }
>  
> +static bool req_create_or_replace(struct nlmsghdr *n)
> +{
> +	return (n->nlmsg_flags & NLM_F_CREATE &&
> +		n->nlmsg_flags & NLM_F_REPLACE);
> +}
> +
> +static bool req_create_exclusive(struct nlmsghdr *n)
> +{
> +	return (n->nlmsg_flags & NLM_F_CREATE &&
> +		n->nlmsg_flags & NLM_F_EXCL);
> +}
> +
> +static bool req_change(struct nlmsghdr *n)
> +{
> +	return (!(n->nlmsg_flags & NLM_F_CREATE) &&
> +		!(n->nlmsg_flags & NLM_F_REPLACE) &&
> +		!(n->nlmsg_flags & NLM_F_EXCL));
> +}
> +
>  /*
>   * Create/change qdisc.
>   */
> -
>  static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>  			   struct netlink_ext_ack *extack)
>  {
> @@ -1644,27 +1662,36 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>  				 *
>  				 *   We know, that some child q is already
>  				 *   attached to this parent and have choice:
> -				 *   either to change it or to create/graft new one.
> +				 *   1) change it or 2) create/graft new one.
> +				 *   If the requested qdisc kind is different
> +				 *   than the existing one, then we choose graft.
> +				 *   If they are the same then this is "change"
> +				 *   operation - just let it fallthrough..
>  				 *
>  				 *   1. We are allowed to create/graft only
> -				 *   if CREATE and REPLACE flags are set.
> +				 *   if the request is explicitly stating
> +				 *   "please create if it doesn't exist".
>  				 *
> -				 *   2. If EXCL is set, requestor wanted to say,
> -				 *   that qdisc tcm_handle is not expected
> +				 *   2. If the request is to exclusive create
> +				 *   then the qdisc tcm_handle is not expected
>  				 *   to exist, so that we choose create/graft too.
>  				 *
>  				 *   3. The last case is when no flags are set.
> +				 *   This will happen when for example tc
> +				 *   utility issues a "change" command.
>  				 *   Alas, it is sort of hole in API, we
>  				 *   cannot decide what to do unambiguously.
> -				 *   For now we select create/graft, if
> -				 *   user gave KIND, which does not match existing.
> +				 *   For now we select create/graft.
>  				 */
> -				if ((n->nlmsg_flags & NLM_F_CREATE) &&
> -				    (n->nlmsg_flags & NLM_F_REPLACE) &&
> -				    ((n->nlmsg_flags & NLM_F_EXCL) ||
> -				     (tca[TCA_KIND] &&
> -				      nla_strcmp(tca[TCA_KIND], q->ops->id))))
> -					goto create_n_graft;
> +				if (tca[TCA_KIND] &&
> +				    nla_strcmp(tca[TCA_KIND], q->ops->id)) {
> +					if (req_create_or_replace(n) ||
> +					    req_create_exclusive(n))
> +						goto create_n_graft;
> +					else
> +						if (req_change(n))

Hi Jamal,

a minor nit from my side, which also came up in v1:
this could be else if, avoiding one level of indentation.

> +							goto create_n_graft2;
> +				}
>  			}
>  		}
>  	} else {
> @@ -1698,6 +1725,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>  		NL_SET_ERR_MSG(extack, "Qdisc not found. To create specify NLM_F_CREATE flag");
>  		return -ENOENT;
>  	}
> +create_n_graft2:
>  	if (clid == TC_H_INGRESS) {
>  		if (dev_ingress_queue(dev)) {
>  			q = qdisc_create(dev, dev_ingress_queue(dev),
> -- 
> 2.34.1
> 
> 
