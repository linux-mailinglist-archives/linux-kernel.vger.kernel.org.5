Return-Path: <linux-kernel+bounces-12911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BAA81FC8A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675F31C21FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D8317E2;
	Fri, 29 Dec 2023 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKYrmA6E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE415A3;
	Fri, 29 Dec 2023 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703816143; x=1735352143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mOJXqJigs2i6yc+lJ2f9bKcm8H4B3s5rrGDxyE7VwEY=;
  b=fKYrmA6Ee7vFUl8DwKRFLrOUyst8DAaSUx6ZpHRCrGSV8BxWPBFPvFsh
   ZCT8B44cXXyK4qA/BFh3uEvOzX8ulWHthMKfgRETTemg/CHn5koFCd9bW
   OsLXvRPRx3Vr2T6tDBskuT1XMuTLykFXKjrVNF2XOxchD8u9RDNOD0WRT
   5JiufVZqWgNF3QAqIQNRSbZtengT2t8Yb9r0HdmvSd7EyabRsv5mGzFyP
   HnAv/Az8nvsAE6KTPWYTJZHfrEIc0JVNu4v//Gf0c1XRcAdx/ZU0U1b1w
   DotJ6psM8Xj+etgx+thnDWuPHvRktOggMiaSlGfg6qYtHz04HuwKzxeU9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="460926394"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="460926394"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 18:15:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="27018870"
Received: from jkee-mobl.gar.corp.intel.com (HELO [10.215.249.184]) ([10.215.249.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 18:15:40 -0800
Message-ID: <c3dd8050-3d56-47b3-81a5-a4979ccf8bd9@linux.intel.com>
Date: Fri, 29 Dec 2023 10:15:37 +0800
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
 <d76e2682-8763-49d0-b46a-5f874eb61985@linux.intel.com>
 <20231221133526.n5tvtkm42lntg3xc@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231221133526.n5tvtkm42lntg3xc@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vladimir,

Sorry for the late reply, was on leave.

On 21/12/2023 9:35 pm, Vladimir Oltean wrote:
> (sorry, I started writing this email yesterday, I noticed the
> conversation continued with Paolo)
> 
> On Wed, Dec 20, 2023 at 11:25:09AM +0800, Abdul Rahim, Faizal wrote:
>> Hi Vladimir,
>>
>> No worries, I truly appreciate the time you took to review and reply.
>>
>> What prompted this in general is related to my project requirement to enable
>> software QBV cycle time extension, so there's a validation team that created
>> test cases to properly validate cycle time extension. Then I noticed the
>> code doesn't handle truncation properly also, since it's the same code area,
>> I just fixed it together.
> 
> We tend to do patch triage between 'net' and 'net-next' based on the
> balance between the urgency/impact of the fix and its complexity.
> 
> While it's undoubtable that there are issues with taprio's handling of
> dynamic schedules, you've mentioned yourself that you only hit those
> issues as part of some new development work - they weren't noticed by
> end users. And fixing them is not quite trivial, there are also FIXMEs
> in taprio which suggest so. I'm worried that the fixes may also impact
> the code from stable trees in unforeseen ways.
> 
> So I would recommend moving the development of these fixes to 'net-next',
> if possible.

Got it, will move it to net-next.

>> Each time before sending the patch for upstream review, I normally will run
>> our test cases that only validates cycle time extension. For truncation, I
>> modify the test cases on my own and put logs to check if the
>> cycle_time_correction negative value is within the correct range. I probably
>> should have mentioned sooner that I have tested this myself, sorry about
>> that.
>>
>> Example of the test I run for cycle time extension:
>> 1) 2 boards connected back-to-back with i226 NIC. Board A as sender, Board B
>> as receiver
>> 2) Time is sync between 2 boards with phc2sys and ptp4l
>> 3) Run GCL1 on Board A with cycle time extension enabled:
>>      tc qdisc replace dev $INTERFACE parent root handle 100 taprio \
>>      num_tc 4 \
>>      map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
>>      queues 1@0 1@1 1@2 1@3 \
>>      base-time 0 \
>>      cycle-time-extension 1000000 \
>>      sched-entry S 09 500000 \
>>      sched-entry S 0a 500000 \
>>      clockid CLOCK_TAI
> 
> Why do you need PTP sync? Cannot this test run between 2 veth ports?
PTP sync is probably not needed, but the test case already has it (I just 
reuse the test case), I assume it's to simulate a complete use case of a 
real user.
Let me explore testing using veth ports, haven't tried this before.

> 
>> 4) capture tcp dump on Board B
>> 5) Send packets from Board A to Board B with 200us interval via UDP Tai
> 
> What is udp_tai? This program?
> https://gist.github.com/jeez/bd3afeff081ba64a695008dd8215866f
> 

Yea the base app looks similar to the one that I use, but the one I use is 
modified. It's to transmit UDP packets.

>> 6) When packets reached Board B, trigger GCL2 to Board A:
>>     CYCLETIME=1000000
>>     APPLYTIME=1000000000 # 1s
>>     CURRENT=$(date +%s%N)
>>     BASE=$(( (CURRENT + APPLYTIME + (2*CYCLETIME)) - ((CURRENT + APPLYTIME)
>>           % CYCLETIME) + ((CYCLETIME*3)/5) ))
>>      tc qdisc replace dev $INTERFACE parent root handle 100 taprio \
>>      num_tc 4 \
>>      map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
>>      queues 1@0 1@1 1@2 1@3 \
>>      base-time $BASE \
>>      cycle-time-extension 1000000 \
>>      sched-entry S oc 500000 \
>>      sched-entry S 08 500000 \
>>      clockid CLOCK_TAI
>> 7) Analyze tcp dump data on Board B using wireshark, will observe packets
>> receive pattern changed.
>>
>> Note that I've hidden "Best Effort (default) 7001 → 7001" data from the
>> wireshark log so that it's easier to see the pattern.
>>
>>       TIMESTAMP               PRIORITY             PRIORITY    NOTES
>>
>> 1702896645.925014509	Critical Applications	7004 → 7004   GCL1
>> 1702896645.925014893	Critical Applications	7004 → 7004   GCL1
>> 1702896645.925514454	Excellent Effort	7003 → 7003   GCL1
>> 1702896645.925514835	Excellent Effort	7003 → 7003   GCL1
>> 1702896645.926014371	Critical Applications	7004 → 7004   GCL1
>> 1702896645.926014755	Critical Applications	7004 → 7004   GCL1
>> 1702896645.926514620	Excellent Effort	7003 → 7003   GCL1
>> 1702896645.926515004	Excellent Effort	7003 → 7003   GCL1
>> 1702896645.927014408	Critical Applications	7004 → 7004   GCL1
>> 1702896645.927014792	Critical Applications	7004 → 7004   GCL1
>> 1702896645.927514789	Excellent Effort	7003 → 7003   GCL1
>> 1702896645.927515173	Excellent Effort	7003 → 7003   GCL1
>> 1702896645.928168304	Excellent Effort	7003 → 7003   Extended
>> 1702896645.928368780	Excellent Effort	7003 → 7003   Extended
>> 1702896645.928569406	Excellent Effort	7003 → 7003   Extended
>> 1702896645.929614835	Background	        7002 → 7002   GCL2
>> 1702896645.929615219	Background	        7002 → 7002   GCL2
>> 1702896645.930614643	Background	        7002 → 7002   GCL2
>> 1702896645.930615027	Background	        7002 → 7002   GCL2
>> 1702896645.931614604	Background	        7002 → 7002   GCL2
>> 1702896645.931614991	Background	        7002 → 7002   GCL2
>>
>> The extended packets only will happen if cycle_time and interval fields
>> are updated using cycle_time_correction. Without that patch, the extended
>> packets are not received.
>>
>>
>> As for the negative truncation case, I just make the interval quite long,
>> and experimented with GCL2 base-time value so that it hits the "next entry"
>> in advance_sched(). Then I checked my logs in get_cycle_time_correction() to
>> see the truncation case and its values.
>>
>> Based on your feedback of the test required, I think that my existing
>> truncation test is not enough, but the extension test case part should be
>> good right ?
>>
>> Do let me know then, I'm more than willing to do more test for the
>> truncation case as per your suggestion, well basically, anything to help
>> speed up the patches series review process :)
>>
>>
>> Appreciate your suggestion and help a lot, thank you.
> 
> Do you think you could automate a test suite which only measures software
> TX timestamps and works on veth?
> 
> I prepared this very small patch set just to give you a head start
> (the skeleton). You'll still have to add the logic for individual tests.
> https://lore.kernel.org/netdev/20231221132521.2314811-1-vladimir.oltean@nxp.com/
> I'm terribly sorry, but this is the most I can do due to my current lack
> of spare time, unfortunately.
> 
> If you've never run kselftests before, you'll need some kernel options
> to enable VRF support. From my notes I have this list below, but there
> may be more missing options.
> 
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_NET_L3_MASTER_DEV=y
> CONFIG_NET_VRF=y
> 
> Let me know if you face any trouble or if I can help in some way.
> Thanks for doing this.

Thank you so much for helping with this self test skeleton ! I'll explore 
and continue from where you've left. Appreciate it.

