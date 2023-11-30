Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39967FF1B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345995AbjK3OXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345940AbjK3OXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:23:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026DD85
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:23:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE68BC433C9;
        Thu, 30 Nov 2023 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701354235;
        bh=wZi0hGsQ3XSwYWlqArpLeqdlNCo/znhk/QdMHk4tYUk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dG68xzPyU20XZ30fUI7KF112zmAlPo7LLNpOLogfgPUVOG25PZTzaCKISCVXCNQH5
         vAmfvzQ5wSTCLD9v/km1KtpC8tGC+PdmSrNUMWkuuNSyENbR/kQxnw/Csu946O2Q7j
         PvA96I/ZxY8C1IG5aVog//9/ItsnjXqQITnhoefE7fjIzgocOUKlyCXK6XZQf3hJfG
         MeIbwy62yYT0qjuibndhPLU6qiYktfioL6Uk5V3bOui/Yd3M1a1M6CUmTRA51OYHEY
         05pvA00Q58cb/ODMJdQhpBnjPTFDABXbwwD05sLHM5CYIop9dlu7lXPgKJYVH8k9D7
         TGeqggUxTBODA==
Message-ID: <030c7d65-bead-46d0-8422-8a9ff0548d72@kernel.org>
Date:   Thu, 30 Nov 2023 16:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 6/7] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-7-rogerq@kernel.org>
 <20231120232620.uciap4bazypzlg3g@skbuf>
 <eeea995b-a294-4a46-aa3e-93fc2b274504@kernel.org>
 <20231121115314.deuvdjk64rcwktl4@skbuf>
 <6def78e7-8264-4745-94f3-b32b854af0c2@kernel.org>
 <20231130132222.w2irs5c4lxh5jcv7@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231130132222.w2irs5c4lxh5jcv7@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2023 15:22, Vladimir Oltean wrote:
> On Thu, Nov 30, 2023 at 01:49:03PM +0200, Roger Quadros wrote:
>> Thanks for the debug instructions. Indeed lldpad tries to enable MM TX and the
>> network drivers set_mm() hook gets called and returns success but still
>> lldpad sees some error.
>>
>> I've also confirmed that ethnl_set_mm() runs successfully and returns 1.
>> I suppose something is going wrong in user-space with libnl?
>>
>> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability supported
>> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability not enabled
>> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability not active
>> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner minimum fragment size: 124 octets
>> Nov 21 11:50:02 am62xx lldpad[708]: eth0: initiating MM verification with a retry interval of 134 ms...
>> Nov 21 11:50:02 am62xx lldpad[708]: ethtool: kernel reports: integer out of range
>>
>>
>> full debug log is below.
> 
> Ah, you got confused. Openlldp issues multiple ETHTOOL_MSG_MM_SET
> netlink messages. What you observe is that one of them succeeds, and
> then another one returns -ERANGE before even calling the driver's
> set_mm() method.
> 
> And that comes from here in net/ethtool/mm.c:
> 
> 149 const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1] = {
> 150 »       [ETHTOOL_A_MM_HEADER]»  »       = NLA_POLICY_NESTED(ethnl_header_policy),
> 151 »       [ETHTOOL_A_MM_VERIFY_ENABLED]»  = NLA_POLICY_MAX(NLA_U8, 1),
> 152 »       [ETHTOOL_A_MM_VERIFY_TIME]»     = NLA_POLICY_RANGE(NLA_U32, 1, 128), // <---- here
> 153 »       [ETHTOOL_A_MM_TX_ENABLED]»      = NLA_POLICY_MAX(NLA_U8, 1),
> 154 »       [ETHTOOL_A_MM_PMAC_ENABLED]»    = NLA_POLICY_MAX(NLA_U8, 1),
> 155 »       [ETHTOOL_A_MM_TX_MIN_FRAG_SIZE]»= NLA_POLICY_RANGE(NLA_U32, 60, 252),
> 156 };
> 
> You are reporting in .get_mm() a maximum verify time which is larger
> than the core ethtool is willing to accept in a further .set_mm() call.
> And openlldp will try to max out on the verify time. Hence the -ERANGE.

You are spot on on this. Thanks. :)

> 
> The range I chose for the policy comes from 802.3-2018 clause 30.14.1.6,
> which says that the aMACMergeVerifyTime variable has a range between 1
> and 128 ms inclusive.

I forced driver state->max_verify_time = 128; and now that -ERANGE
error is gone and the lldp test case passes.

I also applied your patch to ethtool_mm.sh and don't see the error with 
'addFragSize 0' anymore

Should I include your patch in the next revision of this series?

-- 
cheers,
-roger
