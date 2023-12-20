Return-Path: <linux-kernel+bounces-6318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE0A819721
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23ACF287002
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15718F41;
	Wed, 20 Dec 2023 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vr2vQ5xS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B03E156DD;
	Wed, 20 Dec 2023 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703042716; x=1734578716;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7tG7uUz/0Cp/tMpJo2Y2RuTuyuh7GtcWVTgWV880FJA=;
  b=Vr2vQ5xSvyxoLfnu2n8eS0q5CqJCCNqBkIl7r+Dfe+p9XaG/4pk4/M8Z
   GaKzs7dTT6F0FwZcyPDHQ7iE2Zl3bbKXuklWSLWPRsuQ/DnEMXENJzomF
   k2BzMfj13f50DDf93JxNPkHMMZZoTK3Xwf0A/GNJ/e6sc22u9tPF1SLTB
   igCSeHOYdPhnSodHbiUjNjsTNvMZ8FUknnxvPoSIVnYFR55AnuiVnncVE
   VDiQgkk0XZAscQjABW20dA2RTKPUE2Mao2u0ggCFHp7uY1cDNbOw21+vY
   1lX/233VToatD92ireL50VlapKHsP67YTcD0bnHIT2TicfUdcv7VJouzY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="481946535"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="481946535"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 19:25:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="769440701"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="769440701"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.107.26.22]) ([10.107.26.22])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 19:25:12 -0800
Message-ID: <d76e2682-8763-49d0-b46a-5f874eb61985@linux.intel.com>
Date: Wed, 20 Dec 2023 11:25:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 0/4] qbv cycle time extension/truncation
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
 <20231219165650.3amt4ftyt7gisz47@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231219165650.3amt4ftyt7gisz47@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/12/2023 12:56 am, Vladimir Oltean wrote:
> On Tue, Dec 19, 2023 at 03:14:49AM -0500, Faizal Rahim wrote:
>> According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension,
>> the Cycle Time Extension variable allows this extension of the last old
>> cycle to be done in a defined way. If the last complete old cycle would
>> normally end less than OperCycleTimeExtension nanoseconds before the new
>> base time, then the last complete cycle before AdminBaseTime is reached
>> is extended so that it ends at AdminBaseTime.
>>
>> Changes in v3:
>> - Removed the last 3 patches related to fixing cycle time adjustment
>> for the "current entry". This is to simplify this patch series submission
>> which only covers cycle time adjustment for the "next entry".
>> - Negative correction calculation in get_cycle_time_correction() is
>>    guarded so that it doesn't exceed interval
>> - Some rename (macro, function)
>> - Transport commit message comments to the code comments
>> - Removed unnecessary null check
>> - Reword commit message
>>
>> Changes in v2:
>> - Added 's64 cycle_time_correction' in 'sched_gate_list struct'.
>> - Removed sched_changed created in v1 since the new cycle_time_correction
>>    field can also serve to indicate the need for a schedule change.
>> - Added 'bool correction_active' in 'struct sched_entry' to represent
>>    the correction state from the entry's perspective and return corrected
>>    interval value when active.
>> - Fix cycle time correction logics for the next entry in advance_sched()
>> - Fix and implement proper cycle time correction logics for current
>>    entry in taprio_start_sched()
>>
>> v2 at:
>> https://lore.kernel.org/lkml/20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com/
>> v1 at:
>> https://lore.kernel.org/lkml/20230530082541.495-1-muhammad.husaini.zulkifli@intel.com/
> 
> I'm sorry that I stopped responding on your v2. I realized the discussion
> reached a point where I couldn't figure out who is right without some
> testing. I wanted to write a selftest to highlight the expected correct
> behavior of the datapath during various schedule changes, and whether we
> could ever end up with a negative interval after the correction. However,
> writing that got quite complicated and that ended there.
> 
> How are you testing the behavior, and who reported the issues / what prompted
> the changes? Honestly I'm not very confident in the changes we're
> pushing down the linux-stable pipe. They don't look all that obvious, so
> I still think that having selftests would help. If you don't have a
> testing rig already assembled, and you don't want to start one, I might
> want to give it a second try and cook something up myself.
> 
> Something really simple like:
> - start schedule 1 with base-time A and cycle-time-extension B
> - start schedule 2 with base-time C
> - send one packet with isochron during the last cycle of schedule 1
> 
> By varying the parameters, we could check if the schedule is correctly
> extended or truncated. We could configure the 2 schedules in such a way
> that "extending" would mean that isochron's gate (from schedule 1) is
> open (and thus, the packet will pass) and "truncating" would mean that
> the packet is scheduled according to schedule 2 (where isochron's gate
> will be always closed, so the packet will never pass).
> 
> We could then alter the cycle-time-extension relative to the base-times,
> to force a truncation of 1, 2, 3 entries or more, and see that the
> behavior is always correct.

Hi Vladimir,

No worries, I truly appreciate the time you took to review and reply.

What prompted this in general is related to my project requirement to 
enable software QBV cycle time extension, so there's a validation team that 
created test cases to properly validate cycle time extension. Then I 
noticed the code doesn't handle truncation properly also, since it's the 
same code area, I just fixed it together.

Each time before sending the patch for upstream review, I normally will run 
our test cases that only validates cycle time extension. For truncation, I 
modify the test cases on my own and put logs to check if the 
cycle_time_correction negative value is within the correct range. I 
probably should have mentioned sooner that I have tested this myself, sorry 
about that.

Example of the test I run for cycle time extension:
1) 2 boards connected back-to-back with i226 NIC. Board A as sender, Board 
B as receiver
2) Time is sync between 2 boards with phc2sys and ptp4l
3) Run GCL1 on Board A with cycle time extension enabled:
     tc qdisc replace dev $INTERFACE parent root handle 100 taprio \
     num_tc 4 \
     map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
     queues 1@0 1@1 1@2 1@3 \
     base-time 0 \
     cycle-time-extension 1000000 \
     sched-entry S 09 500000 \
     sched-entry S 0a 500000 \
     clockid CLOCK_TAI
4) capture tcp dump on Board B
5) Send packets from Board A to Board B with 200us interval via UDP Tai
6) When packets reached Board B, trigger GCL2 to Board A:
    CYCLETIME=1000000
    APPLYTIME=1000000000 # 1s
    CURRENT=$(date +%s%N)
    BASE=$(( (CURRENT + APPLYTIME + (2*CYCLETIME)) - ((CURRENT + APPLYTIME)
          % CYCLETIME) + ((CYCLETIME*3)/5) ))
     tc qdisc replace dev $INTERFACE parent root handle 100 taprio \
     num_tc 4 \
     map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
     queues 1@0 1@1 1@2 1@3 \
     base-time $BASE \
     cycle-time-extension 1000000 \
     sched-entry S oc 500000 \
     sched-entry S 08 500000 \
     clockid CLOCK_TAI
7) Analyze tcp dump data on Board B using wireshark, will observe packets 
receive pattern changed.

Note that I've hidden "Best Effort (default) 7001 → 7001" data from the 
wireshark log so that it's easier to see the pattern.

      TIMESTAMP               PRIORITY             PRIORITY    NOTES 

1702896645.925014509	Critical Applications	7004 → 7004   GCL1
1702896645.925014893	Critical Applications	7004 → 7004   GCL1
1702896645.925514454	Excellent Effort	7003 → 7003   GCL1
1702896645.925514835	Excellent Effort	7003 → 7003   GCL1
1702896645.926014371	Critical Applications	7004 → 7004   GCL1
1702896645.926014755	Critical Applications	7004 → 7004   GCL1
1702896645.926514620	Excellent Effort	7003 → 7003   GCL1
1702896645.926515004	Excellent Effort	7003 → 7003   GCL1
1702896645.927014408	Critical Applications	7004 → 7004   GCL1
1702896645.927014792	Critical Applications	7004 → 7004   GCL1
1702896645.927514789	Excellent Effort	7003 → 7003   GCL1
1702896645.927515173	Excellent Effort	7003 → 7003   GCL1
1702896645.928168304	Excellent Effort	7003 → 7003   Extended
1702896645.928368780	Excellent Effort	7003 → 7003   Extended
1702896645.928569406	Excellent Effort	7003 → 7003   Extended
1702896645.929614835	Background	        7002 → 7002   GCL2
1702896645.929615219	Background	        7002 → 7002   GCL2
1702896645.930614643	Background	        7002 → 7002   GCL2
1702896645.930615027	Background	        7002 → 7002   GCL2
1702896645.931614604	Background	        7002 → 7002   GCL2
1702896645.931614991	Background	        7002 → 7002   GCL2

The extended packets only will happen if cycle_time and interval fields
are updated using cycle_time_correction. Without that patch, the extended 
packets are not received.


As for the negative truncation case, I just make the interval quite long, 
and experimented with GCL2 base-time value so that it hits the "next entry" 
in advance_sched(). Then I checked my logs in get_cycle_time_correction() 
to see the truncation case and its values.

Based on your feedback of the test required, I think that my existing 
truncation test is not enough, but the extension test case part should be 
good right ?

Do let me know then, I'm more than willing to do more test for the 
truncation case as per your suggestion, well basically, anything to help 
speed up the patches series review process :)


Appreciate your suggestion and help a lot, thank you.





