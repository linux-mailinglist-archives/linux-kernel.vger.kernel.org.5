Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7174C76BBEC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHASGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHASGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:06:48 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1CE45;
        Tue,  1 Aug 2023 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690913208; x=1722449208;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ve0GLrNyb6qus8tJyRujyYE4bCPvWKsCpTU0sMope34=;
  b=EcT1bf3fi/pM2YGDPY1dq6MWpqQnJDOp7n+YsqExFmCn4/BBo+Zm8CDn
   0POi9uEbNCLoE3pF2mrWFBcz58a8s81fhtlWDSGscsKwLCdJaKpL+rNv1
   u/h0iqryE/BisU8375Me8u/h4l+wsJYwYKN0EAZuioqA+ur67LFu/Jobi
   6KIC91uTvKeubF7yKGdcMuU6WM2AETSp92T2LC2qVkCkq8BB47J7UhLMy
   7DbmcIJvwFmVVxeFXDSZaYPzOvZcw4Eeux5zG+9BE1fZhI/iE1v52DzMU
   ZlHmdtw/xbVfV1F8TWL92nXnS38+4ummv6/WlDt2+iY1GbKTNNOnF0xl6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="348979331"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="348979331"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 11:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="722564294"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="722564294"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.17])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 11:06:46 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: Re: [PATCH v2 net-next 7/9] net: netdevsim: mimic tc-taprio offload
In-Reply-To: <20230801174347.gtmxoqybhvbbl2rg@skbuf>
References: <20230613215440.2465708-1-vladimir.oltean@nxp.com>
 <20230613215440.2465708-8-vladimir.oltean@nxp.com>
 <877cs5twqn.fsf@intel.com> <20230801164534.2nklcql2nh6x6p7y@skbuf>
 <87o7jq64s4.fsf@intel.com> <20230801174347.gtmxoqybhvbbl2rg@skbuf>
Date:   Tue, 01 Aug 2023 11:06:46 -0700
Message-ID: <87il9y63ih.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> On Tue, Aug 01, 2023 at 10:39:23AM -0700, Vinicius Costa Gomes wrote:
>> Hi Vladimir,
>> 
>> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
>> 
>> > On Wed, Jun 14, 2023 at 05:06:24PM -0700, Vinicius Costa Gomes wrote:
>> >> > +static int nsim_setup_tc_taprio(struct net_device *dev,
>> >> > +				struct tc_taprio_qopt_offload *offload)
>> >> > +{
>> >> > +	int err = 0;
>> >> > +
>> >> > +	switch (offload->cmd) {
>> >> > +	case TAPRIO_CMD_REPLACE:
>> >> > +	case TAPRIO_CMD_DESTROY:
>> >> > +		break;
>> >> 
>> >> I was thinking about how useful would proper validation of the
>> >> parameters be? Thinking that we could detect "driver API" breakages
>> >> earlier, and we want it documented that the drivers should check for the
>> >> things that it supports.
>> >> 
>> >> Makes sense?
>> >
>> > Sorry, I lack imagination as to what the netdevsim driver may check for.
>> > The taprio offload parameters should always be valid, properly speaking,
>> > otherwise the Qdisc wouldn't be passing them on to the driver. At least
>> > that would be the intention. The rest are hardware specific checks for
>> > hardware specific limitations. Here there is no hardware.
>> >
>> 
>> Trying to remember what was going through my mind when I said that.
>> 
>> What I seem to recall is something that would help us "keep honest":
>> I was worrying about someone (perhaps myself ;-) sneaking a new feature
>> in taprio and forgetting to update other drivers.
>> 
>> I thought that adding a check for the existing parameters would help
>> detect those kind of things. If anything unknown was there in the
>> offload struct, netdevsim would complain loudly.
>> 
>> Perhaps I was worrying too much. And the way to solve that is to keep
>> active attention against that during review.
>
> Ok, so I'm not making any change to the patch set as a result of this
> comment, would you agree?

Agreed.


Cheers,
-- 
Vinicius
