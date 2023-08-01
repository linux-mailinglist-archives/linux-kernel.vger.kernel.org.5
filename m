Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4176BB76
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjHARj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHARj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:39:26 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A417E53;
        Tue,  1 Aug 2023 10:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690911565; x=1722447565;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=UonUIoBUCNktB5rB1/gE9ziHWmQHQrb//uJtkHY7PGw=;
  b=lZuNKAh+9xnIyMr4GI1x5LN53eSdHufxbIcODJ8r5jGSeJ3ND9Kbb//q
   LZhuqTUY8LFwFxnD9LOSsoYch3YwgfBWoahfpenW5f9aNUQtT0d/YBY4m
   iFqEJew0HXvVmXpnhvOhhdrff7l6oMDWjAaOl0xXZKKzKFI2bgffceH+a
   bzBlY0GaE+6/reJAgLDHHQPmxJuUc9WQRyY/OTV+Pmr1PvQUJiLJxduA7
   oUyM/151hkLxXEmPoygcXEbUAfOgWGfNm5ttZWQWV05cJ6olK9zOtJmA4
   gxtFdUZFhGcBoeUuQM7QSK5l3B3eCo6xF8OY4H6GRSRvOk9ImPFS8UdYX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368270365"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="368270365"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872149547"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.17])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:39:26 -0700
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
In-Reply-To: <20230801164534.2nklcql2nh6x6p7y@skbuf>
References: <20230613215440.2465708-1-vladimir.oltean@nxp.com>
 <20230613215440.2465708-8-vladimir.oltean@nxp.com>
 <877cs5twqn.fsf@intel.com> <20230801164534.2nklcql2nh6x6p7y@skbuf>
Date:   Tue, 01 Aug 2023 10:39:23 -0700
Message-ID: <87o7jq64s4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> On Wed, Jun 14, 2023 at 05:06:24PM -0700, Vinicius Costa Gomes wrote:
>> > +static int nsim_setup_tc_taprio(struct net_device *dev,
>> > +				struct tc_taprio_qopt_offload *offload)
>> > +{
>> > +	int err =3D 0;
>> > +
>> > +	switch (offload->cmd) {
>> > +	case TAPRIO_CMD_REPLACE:
>> > +	case TAPRIO_CMD_DESTROY:
>> > +		break;
>>=20
>> I was thinking about how useful would proper validation of the
>> parameters be? Thinking that we could detect "driver API" breakages
>> earlier, and we want it documented that the drivers should check for the
>> things that it supports.
>>=20
>> Makes sense?
>
> Sorry, I lack imagination as to what the netdevsim driver may check for.
> The taprio offload parameters should always be valid, properly speaking,
> otherwise the Qdisc wouldn't be passing them on to the driver. At least
> that would be the intention. The rest are hardware specific checks for
> hardware specific limitations. Here there is no hardware.
>

Trying to remember what was going through my mind when I said that.

What I seem to recall is something that would help us "keep honest":
I was worrying about someone (perhaps myself ;-) sneaking a new feature
in taprio and forgetting to update other drivers.

I thought that adding a check for the existing parameters would help
detect those kind of things. If anything unknown was there in the
offload struct, netdevsim would complain loudly.

Perhaps I was worrying too much. And the way to solve that is to keep
active attention against that during review.

> The parameters passed to TAPRIO_CMD_REPLACE are:
>
> struct tc_mqprio_qopt_offload mqprio:
> 	struct tc_mqprio_qopt qopt: validated by taprio_parse_mqprio_opt() for f=
lags 0x2
> 	u16 mode: always set to TC_MQPRIO_MODE_DCB
> 	u16 shaper: always set to TC_MQPRIO_SHAPER_DCB
> 	u32 flags: always set to 0
> 	u64 min_rate[TC_QOPT_MAX_QUEUE]: always set to [0,]
> 	u64 max_rate[TC_QOPT_MAX_QUEUE]: always set to [0,]
> 	unsigned long preemptible_tcs: always set to 0, because ethtool_dev_mm_s=
upported() returns false
>
> ktime_t base_time: any value is valid
>
> u64 cycle_time: any value is valid
>
> u64 cycle_time_extension: any value <=3D cycle_time is valid. According t=
o 802.1Q
> 			  "Q.5 CycleTimeExtension variables", it's the maximum
> 			  amount by which the penultimate cycle can be extended
> 			  to avoid a very short cycle upon a ConfigChange event.
> 			  But if CycleTimeExtension is larger than one CycleTime,
> 			  then we're not even talking about the penultimate cycle
> 			  anymore, but about ones previous to that?! Maybe this
> 			  should be limited to 0 <=3D cycle_time_extension <=3D cycle_time
> 			  by taprio, certainly not by offloading drivers.
>

Good point. I have to review 802.1Q, but from what I remember that
sounds right, cycle_time_extension greater than cycle_time doesn't make
much sense. Having a check for it in taprio itself sounds good.

> u32 max_sdu[TC_MAX_QUEUE]: limited to a value <=3D dev->max_mtu by taprio
>
> size_t num_entries: any value is valid
>
> struct tc_taprio_sched_entry entries[]:
> 	u8 command: will be either one of: TC_TAPRIO_CMD_SET_GATES, TC_TAPRIO_CM=
D_SET_AND_HOLD
> 		    or TC_TAPRIO_CMD_SET_AND_RELEASE. However 802.1Q "Table 8-7=E2=80=
=94Gate operations"
> 		    says "If frame preemption is not supported or not enabled (preempti=
onActive is
> 		    FALSE), this operation behaves the same as SetGateStates.". So I
> 		    see no reason to enforce any restriction here either?
>
> 	u32 gate_mask: technically can have bits set, which correspond
> 		       to traffic classes larger than dev->num_tc.
> 		       Taprio can enforce this, so I wouldn't see
> 		       drivers beginning to feel paranoid about it.
> 		       Actually I had a patch about this:
> 		       https://patchwork.kernel.org/project/netdevbpf/patch/20230130173=
145.475943-15-vladimir.oltean@nxp.com/
> 		       but I decided to drop it because I didn't have
> 		       any strong case for it.
> 	u32 interval: any value is valid. If the sum of entry intervals
> 		      is less than the cycle_time, again that's taprio's
> 		      problem to check for, in its netlink attribute
> 		      validation method rather than offloading drivers.
>

Thank you for the time it took to give this amount of detail.


Cheers,
--=20
Vinicius
