Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9617B2B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjI2FSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjI2FSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:18:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3771A2;
        Thu, 28 Sep 2023 22:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695964687; x=1727500687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QE7xX2WezWE3ftoKtKzbLcE6HA7lPFiTOPv5jyc5Dxg=;
  b=k8Xej6e+XfUBBUh5r1eZGNDVjbkdh8vTGg/hj5JFASW/kB7JCNS1zMWf
   JSVO7wQLc1u8S4QYgqPFmG1OAFnkXk1tOyt7DQwpzcIckltHHKXhlAM4s
   DMykTbOhcghXxqiwR499LbX4UPHUrAxRtPTFuc0LIIAj+Dwv7lfw2R0Fe
   4Nx5tBiwMoA617jnuAWws4tfTqKL3OL/oGClxX3oEzMytVEMXibEBjLDR
   OBr3MBXXDQpFh+dyrcG80MWsPDE9LZmo9Zmv4mmxqaSCkO9h1ava7XGBg
   GEY6JQ/UJ4HEg6KkDvS7BQQQZ2oqA/9kAWAsDeY8MJblYHx8Df7zVOrGl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="3807790"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="3807790"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 22:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="840171527"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="840171527"
Received: from pglc00352.png.intel.com ([10.221.235.155])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Sep 2023 22:18:02 -0700
From:   rohan.g.thomas@intel.com
To:     robh@kernel.org
Cc:     alexandre.torgue@foss.st.com, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, fancer.lancer@gmail.com, joabreu@synopsys.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, peppe.cavallaro@st.com, rohan.g.thomas@intel.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Time Based Scheduling
Date:   Fri, 29 Sep 2023 13:17:58 +0800
Message-Id: <20230929051758.21492-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230928180942.GA932326-robh@kernel.org>
References: <20230928180942.GA932326-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohan G Thomas <rohan.g.thomas@intel.com>

On Wed, Sep 27, 2023 at 09:09:18PM +0800, Rohan G Thomas wrote:
>> Add new property tbs-enabled to enable Time Based Scheduling(TBS)
>
>That's not the property you added.
>
>> support per Tx queues. TBS feature can be enabled later using ETF
>> qdisc but for only those queues that have TBS support enabled.
>
>This property defines capable or enabled? 

This property is to enable TBS support for any Tx queue. Why this
added is because I think TBS need not be enabled for all capable
Tx queues(Tx DMA channels) because of the following hw limitations.
1. As per DWMAC QoS and DWXGMAC databooks, TBS cannot coexist with
TSO. So TBS cannot be enabled for a Tx queue which is for TSO. 
2. Also as per DWXGMAC databook, "Do not enable time-based scheduling
(or enhanced descriptors) for the channel for which TSO or transmit
timestamp or one-step timestamping control correction feature is
enabled".
3. As per DWXGMAC databook, "Use separate channel (without TBS
enabled) for time critical traffic. Mixing such traffic with TBS
enabled traffic can cause delays in transmitting time critical
traffic."
More explanation below...

>
>Seems like OS configuration and policy.

Tx queues need to be configured for TBS during hw setup itself as
special enhanced descriptors are used by the hw for TBS support
enabled queues. Switching between enhanced and normal descriptors
on run is not feasible. So this flag is for enabling "Enhanced
Descriptors for Time Based Scheduling". This I think is a hw specific
requirement.

>
>Doesn't eh DWMAC have capability registers for supported features? Or 
>did they forget per queue capabilities?

Yes, capability registers are available. For DWMAC5 IP, if TBSSEL bit
is set, then TBS is supported by all Tx queues. For DWXGMAC IP, if
TBSSEL bit is set, then TBS is supported by TBS_CH number of Tx
queues starting from the highest Tx queue. But because of the hw
limitations mentioned above, TBS cannot be enabled for all capable
queues.

>
>> 
>> Commit 7eadf57290ec ("net: stmmac: pci: Enable TBS on GMAC5 IPK PCI
>> entry") enables similar support from the stmmac pci driver.
>
>Why does unconditionally enabling TBS work there, but not here?

There, Tx queue 0 is not enabled for TBS as it is used for TSO.

>
>> 
>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
>> ---
>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/>devicetree/bindings/net/snps,dwmac.yaml
>> index 5c2769dc689a..db1eb0997602 100644
>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> @@ -399,6 +399,14 @@ properties:
>>              type: boolean
>>              description: TX checksum offload is unsupported by the TX queue.
>>  
>> +          snps,tbs-enabled:
>> +            type: boolean
>> +            description:
>> +              Enable Time Based Scheduling(TBS) support for the TX queue. TSO and
>> +              TBS cannot be supported by a queue at the same time. If TSO support
>> +              is enabled, then default TX queue 0 for TSO and in that case don't
>> +              enable TX queue 0 for TBS.
>> +
>>          allOf:
>>            - if:
>>                required:
>> -- 
>> 2.26.2
>> 
