Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A463796DA7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbjIFXhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbjIFXhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:37:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7883994;
        Wed,  6 Sep 2023 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694043457; x=1725579457;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WbYu9Oe2D0TTa+maLk3z8eDFJ1OYmdIYH7jQnzRHx8k=;
  b=RyTXkiKKRXNfYK1rNDWESObfDMl9iV9TdBfW8VHRvMa7SGfJpsqgdePD
   zVGc2rD8S5wZq8ZQfKAyayKd0rCu83ryY7nW6Es/xDJwtSilnEvAbcQ13
   ZiBsczUp640WThkZ17sRfp2rnT/pXN0EfmThUfN0mTCOOsHYaFlFesKgM
   4fES/NOMnF3ivI6tFp/UcDm1COKb/60fUV4Ryhu4Fsf31TzWa50aQC2fa
   OHfbG0bIOqJ7zCCqPtqa9vsVbXalnQmjiTOdLo+O/nsGDurxboVuiR7P/
   EgUt5fTFtl9BEeqIuz9w6oFPWWpnWo9HfsqruXDVI8IXyhR/1aV1ugEjV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="377124927"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="377124927"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 16:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="865361694"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="865361694"
Received: from mcewe-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.251.10.12])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 16:37:34 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, sasha.neftin@intel.com,
        Ferenc Fejes <ferenc.fejes@ericsson.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        Andre Guedes <andre.guedes@intel.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net v1] igc: Fix infinite initialization loop with
 early XDP redirect
In-Reply-To: <ZPkDaLo4ubFRpPg3@boxer>
References: <20230905213753.697461-1-vinicius.gomes@intel.com>
 <ZPkDaLo4ubFRpPg3@boxer>
Date:   Wed, 06 Sep 2023 16:37:34 -0700
Message-ID: <877cp2rhz5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Tue, Sep 05, 2023 at 02:37:52PM -0700, Vinicius Costa Gomes wrote:
>> When a XDP redirect happens before the link is ready, that
>
> When exactly link was 'ready' in your setup? You said it was enough to
> launch traffic towards igc iface before running xdp-bench. Was the iface
> down or up or?

In short, the interface was up and it was brought down "externally".

I should have explained my test better: A is the system under test, B is
the monitor; 1. initially the link between systems A and B is up; 2. I
setup the vlans and xdp-bench; 3. I start sending traffic; 4. on system
B, I brind the NIC connected to A down; 5. infinite initialization loop.

>
>> transmission will not finish and will timeout, causing an adapter
>> reset. If the redirects do not stop, the adapter will not stop
>> resetting.
>
> Please highlight that this driver shares tx resources with netstack. I
> believe the source of this bug is that the watchdog is responsible to call
> netif_carrier_on() from a workqueue which happens to be scheduled *after*
> clearing __IGC_DOWN in igc_up().
>

Sure, will add this information to the commit message and send a v2.

>> 
>> Wait for the driver to signal that there's a carrier before allowing
>> transmissions to proceed.
>> 
>> Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
>> Reported-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
>> Closes: https://lore.kernel.org/netdev/0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com/
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Tested-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
>> ---
>>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 293b45717683..98de34d0ce07 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -6491,7 +6491,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
>>  	struct igc_ring *ring;
>>  	int i, drops;
>>  
>> -	if (unlikely(test_bit(__IGC_DOWN, &adapter->state)))
>> +	if (unlikely(!netif_carrier_ok(dev)))
>>  		return -ENETDOWN;
>
> I thought about keeping the bit check as well but given what i wrote above
> it is probably redundant, so:
>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
>>  
>>  	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>> -- 
>> 2.41.0
>> 


Cheers,
-- 
Vinicius
