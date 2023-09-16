Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECC7A2E2B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 08:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbjIPGR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 02:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbjIPGRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 02:17:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9ABCC0;
        Fri, 15 Sep 2023 23:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694845046; x=1726381046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dpw80PtFYNDVGjI+iulRnzMBDHhLG8ZhcBIQvgHxF4s=;
  b=Wngwpc/9UFg3VxmQUA2UopDoOpA101MO/XPtYsa8oPSsgOSzrcqCZd9P
   PcKp2Jw0D2+jcgpfDLEAYaCqOGXbySWIWslZ/S8uLTajWSBohiPzhu+U7
   lTGE+tUSBxR40zDq/AjINTpzMMLuDG+8MU3FNaZodprMtLinihLkezGxg
   LsRXK/1eh2LhSu1JgGXnJo4C5GYJ4F9zXzY9bFdXXT1UVaPg/vJ+eUBJ0
   coyxRrNiyr/2akBcFJxj8iydEdONanUIwCOCQazk755APtciBxqp/G48Y
   K8xvDI1YbDj9muEgQYMlPorfYna2Nw2tnjcQHTrqtYiANufxe8whWwIdg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="443461809"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="443461809"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 23:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="738564989"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="738564989"
Received: from pglc00032.png.intel.com ([10.221.207.52])
  by orsmga007.jf.intel.com with ESMTP; 15 Sep 2023 23:17:21 -0700
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
Subject: Re: [linux-drivers-review] [PATCH net-next v2 1/3] net: stmmac: xgmac: EST interrupts handling
Date:   Sat, 16 Sep 2023 14:17:18 +0800
Message-Id: <20230916061718.336-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915154258.GA3769303-robh@kernel.org>
References: <20230915154258.GA3769303-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohan G Thomas <rohan.g.thomas@intel.com>

Thanks for the review comments.
Will address this in the next version.

On Fri, Sep 15, 2023 at 05:54:16PM +0800, Rohan G Thomas wrote:
>> Add dt-bindings for coe-unsupported property per tx queue.
>
>Why? (What every commit msg should answer)
>
>> 
>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
>> ---
>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> index ddf9522a5dc2..365e6cb73484 100644
>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> @@ -394,6 +394,9 @@ properties:
>>                When a PFC frame is received with priorities matching the bitmask,
>>                the queue is blocked from transmitting for the pause time specified
>>                in the PFC frame.
>
>blank line needed
>
>> +          snps,coe-unsupported:
>> +            type: boolean
>> +            description: TX checksum offload is unsupported by the TX queue.
>
>And here.
>
>>          allOf:
>>            - if:
>>                required:
>> -- 
>> 2.25.1
>> 
