Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76047EEB21
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbjKQCge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 21:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjKQCgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:36:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173611A7;
        Thu, 16 Nov 2023 18:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700188590; x=1731724590;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=nhO/RuLvLI/Qzv/uO4IXRzJbtBt6rCc4se0l/kw/tSc=;
  b=TRNdKwltfxW91QlnR2nTe8MVGJ6Xwgfkd2U+V96IFNadPpShoHbAcTxC
   8wiZjOlN86ayOarlmuvjiCDb2tRfKEVQCfUcgNdW2fRF1Gg4IJ2attpD4
   9gHQboMDmX0u50LEp01TBdcP/GoDPHImCcMTvqbGiSicjt7c+FD8356Xu
   /bEUPjqQrjgrnhTrVZEg5c7jpzyjHGhplzhCe7s5hxl7n1lqQgcwDJyVv
   cZIfxSZeAkMHZAn9x7W5qEb4hPpMGqbM8rIyUK1EJ+fTfvkLbSvk8zdBL
   2Mf8XQkifm5DK4nTq9oLTR5RGbEri6DxoL5TjmVPToY4BeKaZfUqW1/EE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="394076414"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="394076414"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 18:36:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="856199725"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="856199725"
Received: from jlelizal-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.255.229.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 18:36:28 -0800
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 4/7] net/sched: taprio: get corrected value of
 cycle_time and interval
In-Reply-To: <20231109111146.qrnekz6ykyzrcpbd@skbuf>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
 <20231109111146.qrnekz6ykyzrcpbd@skbuf>
Date:   Thu, 16 Nov 2023 18:36:28 -0800
Message-ID: <87h6llqf6b.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> On Tue, Nov 07, 2023 at 06:20:20AM -0500, Faizal Rahim wrote:
>> Retrieve adjusted cycle_time and interval values through new APIs.
>> Note that in some cases where the original values are required,
>> such as in dump_schedule() and setup_first_end_time(), direct calls
>> to cycle_time and interval are retained without using the new APIs.
>>=20
>> Added a new field, correction_active, in the sched_entry struct to
>> determine the entry's correction state. This field is required due
>> to specific flow like find_entry_to_transmit() -> get_interval_end_time()
>> which retrieves the interval for each entry. During positive cycle
>> time correction, it's known that the last entry interval requires
>> correction. However, for negative correction, the affected entry
>> is unknown, which is why this new field is necessary.
>
> I agree with the motivation, but I'm not sure if the chosen solution is
> correct.
>
> static u32 get_interval(const struct sched_entry *entry,
> 			const struct sched_gate_list *oper)
> {
> 	if (entry->correction_active)
> 		return entry->interval + oper->cycle_time_correction;
>
> 	return entry->interval;
> }
>
> What if the schedule looks like this:
>
> 	sched-entry S 0x01 125000000
> 	sched-entry S 0x02 125000000
> 	sched-entry S 0x04 125000000
> 	sched-entry S 0x08 125000000
> 	sched-entry S 0x10 125000000
> 	sched-entry S 0x20 125000000
> 	sched-entry S 0x40 125000000
> 	sched-entry S 0x80 125000000
>
> and the calculated cycle_time_correction is -200000000? That would
> eliminate the entire last sched-entry (0x80), and the previous one
> (0x40) would run for just 75000000 ns. But your calculation would say
> that its interval is =E2=88=9275000000 ns (actually reported as an u32 po=
sitive
> integer, so it would be a completely bogus value).
>
> So not only is the affected entry unknown, but also the amount of cycle
> time correction that applies to it is unknown.
>
> I'm looking at where we need get_interval(), and it's from:
>
> taprio_enqueue_one()
> -> is_valid_interval()
>    -> find_entry_to_transmit()
>       -> get_interval_end_time()
> -> get_packet_txtime()
>    -> find_entry_to_transmit()
>
> I admit it's a part of taprio which I don't understand too well. Why do
> we perform such complex calculations in get_interval_end_time() when we
> should have struct sched_entry :: end_time precomputed and available for
> this purpose (although it was primarily inteded for advance_sched() and
> not for enqueue())?
>
> Vinicius, do you know?

Sorry for the delay, I thought that I went through all the messages in
this thread, but missed this one.

I think what is missing is some context, this series from Faizal also
includes fixes for taprio "txtime-assisted mode", where we try to
support for 801.1Qbv schedules, including cycle-extension and schedules
with arbitrary number of entries.

The basic idea is that during enqueue, taprio will calculate the txtime
of a packet so it "follows" the configured schedule, and pass that
packet to ETF, which is running as child of taprio. It is a bit of hack,
but it works well enough.

And I agree with your opinion, that this part of the code is
complicated. I have one permanent item on my todo list to spend some
quality time looking at it, and trying to make it simpler.

But fixing it to make it work with cycle-time-extension comes first.
Then, it's on me to not break it later.

Sorry for the rambling. Does this answer your question?


Cheers,
--=20
Vinicius
