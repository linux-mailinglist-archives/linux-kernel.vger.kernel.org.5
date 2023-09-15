Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05877A206A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjIOOFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjIOOFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:05:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3421FC9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694786704; x=1726322704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=69LddkQM4INNX/w5+YF6yd/6UhDinZxSfXjUTrLMCdE=;
  b=NI02U2AJYWEua9TnjYb6ovVSzitiJQS0kB9f44bqKH/FZDD9qABLpd82
   B8LZQzhEWGodCFn5Pxx7cxqajTWSZaSfflsTfUK6t8Vg1ZwyZrYoS/OE2
   MDqNGIq90F07Zu0NfnUfiGovdcG9mAJMFjpeKKMeSHHER6EwP5Lnehnw6
   cR1faKN9y6p4D7mGY3LnlsfyyVAhlgXkEYDtQOM1YswzMOoH3F2MUL3ki
   WQDUkiWMrpGbw8odnTIaC0oFatF+JFtnd8OQqV5sJvT3Mv9KVh5W9mn5b
   syGgfcVegbqdDImba9X5sxuwoiwcTtUs9hXQEaviswLGg10luYOIhVeOy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410191172"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="410191172"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:04:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="918663553"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="918663553"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.255.228.100]) ([10.255.228.100])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:04:56 -0700
Message-ID: <9ffe31b0-a6ff-991d-85ad-97306abfc684@linux.intel.com>
Date:   Fri, 15 Sep 2023 07:04:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com> <87r0nn8ots.ffs@tglx>
 <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
 <abb65e60-4e8b-7036-4401-d21b273b6d67@linux.intel.com>
 <6f101718-7ee1-1c3d-3e0a-3aa708928ecd@amd.com>
 <20230915115428.GD6721@noisy.programming.kicks-ass.net>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20230915115428.GD6721@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2023 4:54 AM, Peter Zijlstra wrote:
> On Tue, Aug 29, 2023 at 08:46:14AM +0530, K Prateek Nayak wrote:
>> Hello Arjan,
>>
>> On 8/28/2023 8:04 PM, Arjan van de Ven wrote:
>>> On 8/28/2023 7:28 AM, K Prateek Nayak wrote:
>>>>>      - Are these really different between AMD and Intel or is this some
>>>>>        naming convention issue which needs to be resolved?
>>>>      They do have different characteristics since, on Sapphire
>>>>      Rapids, the LLC is at a socket boundary despite having multiple
>>>>      tiles. (Please correct me if I'm wrong, I'm going off of
>>>>      llc_id shared in this report by Qiuxu Zhuo -
>>>>      https://lore.kernel.org/all/20230809161219.83084-1-qiuxu.zhuo@intel.com/)
>>>>
>>>
>>> Sapphire reports itself as 1 tile though (since logically it is) as far as I know
>>>
>>
>> I believe there are some variants with multiple tiles, at least the
>> following press-release suggests that:
>>
>>    https://www.intc.com/news-events/press-releases/detail/1598/intel-launches-4th-gen-xeon-scalable-processors-max-series
>>
>> specifically "... combining up to four Intel 7-built tiles on a single
>> package, connected using Intel EMIB ...". Perhaps the one from Qiuxu
>> Zhuo's report does not contain multiple tiles.
> 
> I think what Arjan was saying that despite them being build using
> multipe physical tiles, they describe themselves, in the topology leave,
> as being a single tile.

and more than that -- from a software perspective, they truely act as if they are 1 tile
(you can do SNC to break that sort of but that's not default and has its own list of downsides)


