Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B77A65A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjISNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjISNpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:45:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750AA1701
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695131073; x=1726667073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9caWP9THVO1o1ECNp5T5WAk7w3+H4KLREX779huemRQ=;
  b=ZIlkXtTU6/PekU2wqx4M5NfEG6OLLfbvpYloz0ulEkXIey76XkcgXeg9
   ign8kmVDZpmOOcZXzflUCbKTSGSqvsda0ucz3KxVGmCw66Hg4HXlVkrtI
   L3MOpcXRxugyjF4lcYeWEkAjCNIdflwXfvc4O0ioGPV3TxWaVM5m2slsO
   K957VAFtOrhH846gZjTBNgzQ8HapLtx7PmbLN1JOoD3iGIlzu3OQMoA3I
   tHJzMJQ7dVgbcirGB5UkZrR02/ga2GOlL0lfRuwg3Cz9TqW+I696AEDFa
   fWom1TTRWRCAUF1j42ghn4/EOjpg3MDD5lAxiXxdmvA0UtB9D3Lyjl5ie
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="379843150"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="379843150"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 06:44:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746246652"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="746246652"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.97.38]) ([10.209.97.38])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 06:44:25 -0700
Message-ID: <13c2f8b6-f0ca-8c68-603a-a0efdc80164f@linux.intel.com>
Date:   Tue, 19 Sep 2023 06:44:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
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
 <9ffe31b0-a6ff-991d-85ad-97306abfc684@linux.intel.com>
 <106c0cef-2cde-7330-7a18-31db92c5b04a@amd.com>
Content-Language: en-US
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <106c0cef-2cde-7330-7a18-31db92c5b04a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> specifically "... combining up to four Intel 7-built tiles on a single
>>>> package, connected using Intel EMIB ...". Perhaps the one from Qiuxu
>>>> Zhuo's report does not contain multiple tiles.
>>>
>>> I think what Arjan was saying that despite them being build using
>>> multipe physical tiles, they describe themselves, in the topology leave,
>>> as being a single tile.
>>
>> and more than that -- from a software perspective, they truely act as if they are 1 tile
> 
> If possible, can you please elaborate on the "software perspective". Say
> CPUID leaf 0x1f reports multiple tile, would the data access latency or
> cache to cache latency see a noticeable difference?

no. (not on SPR unless you turn on SNC, which is a whole different world)

> 
> I would like to understand what the characteristics of a "Tile" are and
> whether they are similar to AMD's CCX instances discoverable by AMD's
> extended CPUID leaf 0x80000026. That way, in future, when the generic
> topology is used by other subsystems, the data from "TOPO_TILE_DOMAIN"
> can be used generically for both Intel and AMD.

SPR for all intents and purposes for software does not have tiles. So please
lets not design for that ;-)

The reality is that we really should not hardcode topology things to cache things.
Sure today tile is an L3 boundary for AMD, and on all no-tile systems by construction
of the topology tree.
But maybe some smart person in AMD decides
that for a next generation, it's faster to split the L3 in half -- or to make that
extra HBM-like cache span 2 tiles or .. or ..

CPUID enumerates cache domains pretty much separate and that;s a good thing.
We absolutely need a "cache view" of the system, but that is a mapping to topology,
not hardcoded in topology (so one level of indirection + of course cached/computed
bitmaps etc for cheap access)


