Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C578B336
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjH1OfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjH1OfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:35:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5380C9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693233298; x=1724769298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0GPJBVETKr0elJKyjYnsO6X1WEkBJ4D5Uo2VZCV0EuE=;
  b=gZvGbaG0v341cfBohGNtg0Tf0f1SiDAqsfB+fmAij+Q7aJNvj3WyGmWF
   BhN2N65DQm7Tw9XqPhdadEKe4JaSxuxuNr4KQ4IL8Z4jXGgrIAjvOEnIg
   fAN+505ImKs2Lpt2QcQe2qDknddnf2eLY6la7CJfllv6TEv+EubSP+e6i
   nH3C+qxZmOqjm1k5IwK4yHGEef5KNCUj0oYULCxCjcf7OCfkA9d9txo7H
   EpsCf/fXxC5aiMXsE09/9eYLdWMAHgYEJfSxg16Ti02ToXChXXE01pz7/
   Fg2SLvHaL1q43FeE1+Y/oPDoHuWQORkn14DVy0PUiQNSMmzMV8xrFiPNz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="461491140"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="461491140"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 07:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="773281598"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="773281598"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.114.105]) ([10.209.114.105])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 07:34:32 -0700
Message-ID: <abb65e60-4e8b-7036-4401-d21b273b6d67@linux.intel.com>
Date:   Mon, 28 Aug 2023 07:34:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
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
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/2023 7:28 AM, K Prateek Nayak wrote:
>>     - Are these really different between AMD and Intel or is this some
>>       naming convention issue which needs to be resolved?
> 	They do have different characteristics since, on Sapphire
> 	Rapids, the LLC is at a socket boundary despite having multiple
> 	tiles. (Please correct me if I'm wrong, I'm going off of
> 	llc_id shared in this report by Qiuxu Zhuo -
> 	https://lore.kernel.org/all/20230809161219.83084-1-qiuxu.zhuo@intel.com/)
> 

Sapphire reports itself as 1 tile though (since logically it is) as far as I know

