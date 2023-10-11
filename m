Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A037C4B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344614AbjJKHK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344424AbjJKHKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:10:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173208F;
        Wed, 11 Oct 2023 00:10:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39B7ANGn099618;
        Wed, 11 Oct 2023 02:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697008223;
        bh=/ikIzpbP4MhvEkj+kWK6Ua2nOBGaGs9tu8ydrAU8p0Q=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=QII5sxmphypDKCRIAgwQ3K2ZKHtvolBQyZiQvVOSXQhzAW7iiJz2fiuFKIRt37Ifa
         RZR7h5kBiRrhK5HO2uj25mh5pmVewJb8Pmy3HsXOiUGoGO4ec3ySmzpOW3pU0H90qm
         BbcKS6zqa9+O2UPbfnN08w1Q89IgTnU4YbsJQc9M=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39B7ANjF052089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Oct 2023 02:10:23 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Oct 2023 02:10:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Oct 2023 02:10:23 -0500
Received: from [10.24.69.31] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39B7AH5F079403;
        Wed, 11 Oct 2023 02:10:18 -0500
Message-ID: <7456cbc2-7ea1-b68c-ce75-fa4b5392ec8c@ti.com>
Date:   Wed, 11 Oct 2023 12:40:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4] net: ti: icssg_prueth: add TAPRIO offload
 support
Content-Language: en-US
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <vladimir.oltean@nxp.com>,
        Simon Horman <horms@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Roger Quadros <rogerq@ti.com>
References: <20231006102028.3831341-1-danishanwar@ti.com>
 <87cyxr8jtk.fsf@intel.com>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <87cyxr8jtk.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/23 04:01, Vinicius Costa Gomes wrote:
> MD Danish Anwar <danishanwar@ti.com> writes:
> 
>> From: Roger Quadros <rogerq@ti.com>
>>
>> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
>> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
>> configuration. EST allows express queue traffic to be scheduled
>> (placed) on the wire at specific repeatable time intervals. In
>> Linux kernel, EST configuration is done through tc command and
>> the taprio scheduler in the net core implements a software only
>> scheduler (SCH_TAPRIO). If the NIC is capable of EST configuration,
>> user indicate "flag 2" in the command which is then parsed by
>> taprio scheduler in net core and indicate that the command is to
>> be offloaded to h/w. taprio then offloads the command to the
>> driver by calling ndo_setup_tc() ndo ops. This patch implements
>> ndo_setup_tc() to offload EST configuration to ICSSG.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>> Cc: Roger Quadros <rogerq@ti.com>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>>

[ ... ]

>> +
>> +static int emac_taprio_replace(struct net_device *ndev,
>> +			       struct tc_taprio_qopt_offload *taprio)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct tc_taprio_qopt_offload *est_new;
>> +	int ret, idx;
>> +
>> +	if (taprio->cycle_time_extension) {
>> +		netdev_err(ndev, "Failed to set cycle time extension");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (taprio->num_entries == 0 ||
>> +	    taprio->num_entries > TAS_MAX_CMD_LISTS) {
>> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "unsupported num_entries %ld in taprio config\n",
>> +				       taprio->num_entries);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* If any time_interval is 0 in between the list, then exit */
>> +	for (idx = 0; idx < taprio->num_entries; idx++) {
>> +		if (taprio->entries[idx].interval == 0) {
>> +			NL_SET_ERR_MSG_MOD(taprio->extack, "0 interval in taprio config not supported\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	if (emac->qos.tas.taprio_admin)
>> +		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
>> +
>> +	est_new = devm_kzalloc(&ndev->dev,
>> +			       struct_size(est_new, entries, taprio->num_entries),
>> +			       GFP_KERNEL);
>> +	if (!est_new)
>> +		return -ENOMEM;
>> +
>> +	emac_cp_taprio(taprio, est_new);
>> +	emac->qos.tas.taprio_admin = est_new;
>> +	ret = tas_update_oper_list(emac);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =  tas_set_state(emac, TAS_STATE_ENABLE);
> 
> The double space is still here...
> 

Sorry my bad. I'll fix this in next revision.

>> +	if (ret)
>> +		devm_kfree(&ndev->dev, est_new);
> 
> ... as is the free'ing of 'est_new' while 'taprio_admin' still points to it.
> 

I will add below line here to assign 'taprio_admin' to NULL once
'est_new' is freed.

		emac->qos.tas.taprio_admin = NULL;

I will send the next revision with these two fixes. Please let me know
if this is OK or if something else is also needed.

>> +
>> +	return ret;
>> +}
>> +

[ ... ]

>> +
>> +void icssg_qos_tas_init(struct net_device *ndev);
>> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>> +			   void *type_data);
>> +#endif /* __NET_TI_ICSSG_QOS_H */
>> -- 
>> 2.34.1
>>
> 

-- 
Thanks and Regards,
Danish
