Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6774976F2F5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjHCSrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjHCSrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:47:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15FF49C5;
        Thu,  3 Aug 2023 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691088389; x=1722624389;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3gq1m1Q2ya0GLFc6+cnheSBbzbHrqHzRXeNNrsdtKU4=;
  b=bD0zXqidljWnSMboyHAikSW3KU6ayRRDiboKmLZy2GbDWfkzuR9BI/YI
   SHGnCThzjnIttRD5BZnN3uv6xM2lnH1xUSGrxNyQs3+MfDaB5MakXgmsY
   dE6eZvxLSJA7GMq6NwhPLaBPtKHjKMKInaTm7LAoAM1OuIvmJo7LPuWwt
   V6mdY1YZ69OTmyGY03h9DNeDw+M4BGg6invLN/DyYAisKVrKIewPP+BCw
   ws1n44I+LGXXrqdWhhhCaDaT58W0tofhlkqKsh8mGaPD9Iq5FcnpAmtRT
   xFLjAjWdYcL7Z1hMLJOVPICIas/yo+Avm70hngHt+/8SnkUXBxIaSIhRs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="350269092"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="350269092"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 11:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060414875"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="1060414875"
Received: from cgahan-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.253.5])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 11:43:17 -0700
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
Subject: Re: [PATCH v3 net-next 09/10] selftests/tc-testing: test that
 taprio can only be attached as root
In-Reply-To: <20230803143347.7hhn27hzjymdvvw6@skbuf>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
 <20230801182421.1997560-10-vladimir.oltean@nxp.com>
 <87pm4510r0.fsf@intel.com> <20230803143347.7hhn27hzjymdvvw6@skbuf>
Date:   Thu, 03 Aug 2023 11:43:16 -0700
Message-ID: <87il9w0xx7.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> Hi Vinicius,
>
> On Wed, Aug 02, 2023 at 04:29:55PM -0700, Vinicius Costa Gomes wrote:
>> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
>> This test is somehow flaky (all others are fine), 1 in ~4 times, it fails.
>> 
>> Taking a look at the test I couldn't quickly find out the reason for the
>> flakyness.
>> 
>> Here's the verbose output of one of the failures:
>> 
>> vcgomes@otc-cfl-clr-30 ~/src/net-next/tools/testing/selftests/tc-testing $ sudo ./tdc.py -e 39b4 -v
>> All test results:
>> 
>> 1..1
>> not ok 1 39b4 - Reject grafting taprio as child qdisc of software taprio
>> 	Could not match regex pattern. Verify command output:
>> parse error: Objects must consist of key:value pairs at line 1, column 334
>
> Interesting. I'm not seeing this, and I re-ran it a few times. The error
> message seems to come from jq, as if it's not able to parse something.
>
> Sorry, I only have caveman debugging techniques. Could you remove the
> pipe into jq and rerun a few times, see what it prints when it fails?
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> index de51408544e2..bb6be1f78e31 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> @@ -148,8 +148,8 @@
>          ],
>          "cmdUnderTest": "$TC qdisc replace dev $ETH parent 8001:7 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 200 sched-entry S ff 20000000 clockid CLOCK_TAI",
>          "expExitCode": "2",
> -        "verifyCmd": "$TC -j qdisc show dev $ETH root | jq '.[].options.base_time'",
> -        "matchPattern": "0",
> +        "verifyCmd": "$TC -j qdisc show dev $ETH root",
> +        "matchPattern": "\\[{\"kind\":\"taprio\",\"handle\":\"8001:\",\"root\":true,\"refcnt\":9,\"options\":{\"tc\":0,\"map\":\\[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0\\],\"queues\":\\[\\],\"clockid\":\"TAI\",\"base_time\":0,\"cycle_time\":20000000,\"cycle_time_extension\":0,\"schedule\":\\[{\"index\":0,\"cmd\":\"S\",\"gatemask\":\"0xff\",\"interval\":20000000}\\],\"max-sdu\":\\[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0\\],\"fp\":\\[\"E\",\"E\",\"E\",\"E\",\"E\",\"E\",\"E\",\"E\",\"E\",\"E\",\"E\",\"E\",\"E\",\"E\",\"E\",\"E\"\\]}}\\]",
>          "matchCount": "1",
>          "teardown": [
>              "$TC qdisc del dev $ETH root",

Hmmm, I think that this test discovered another bug (perhaps even two).
When it fails here's the json I get (edited for clarity):

[{"kind":"taprio","handle":"8001:","root":true,"refcnt":9,
  "options":{
        "tc":0,
        "map":[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "queues":[],
        "clockid":"TAI",
        "base_time":0,
        "cycle_time":0,
        "cycle_time_extension":0,
        {
                "base_time":0,
                "cycle_time":20000000,
                "cycle_time_extension":0,
                "schedule":[{"index":0,"cmd":"S","gatemask":"0xff","interval":20000000}]
        }}}]

Thinking out loud: If I am reading this right, there's no "oper"
schedule, only an "admin" schedule. So the first bug is probably a
taprio bug when deciding if it should create an "open" vs. "admin"
schedule.

The second bug seems to be in the way that q_taprio in iproute2
handles the admin schedule, is just an object inside another, which
seems to be invalid.

Does it make sense?


Cheers,
-- 
Vinicius
