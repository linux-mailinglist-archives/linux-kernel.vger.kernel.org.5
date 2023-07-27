Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E090765879
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjG0QVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjG0QVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:21:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937282D4D;
        Thu, 27 Jul 2023 09:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAyFIc0+s340FrSS33x+Ep81mtw7rFUKWWKAJlklsNJ7NdRVmJmj3CqU/iak199eGBoW3RzqF9hfsKyda4IEFfYR9Rx6Uft1pvQeHmplaLnD0KM9gizq3Mt+GvNcyUg4rIAIw1hV8UQzgcp7caFqbuzaKZGoHPNZXtToJB6scK0Qa6vTTlCNTCNQGt4EU9YFCPOls/SHCRUfJ0iTRAjW0rKu6iHAsGu++9XS8xIKSdpz0uIX4AeH5IsmS5+eAv7ZvUgvDlLYLpHLmT9rhGl9DoPfRD5p0VqFzIhxjN0DDvCNrYOqnPLkAPUl7xv1I4fW7AeRbKBcOlmixP/xg441Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9BPossyxiu3GPrzMmSXY4slYI+6J6waCQr4n3sia/U=;
 b=GE09Ki9bCH1RN0zJGklEVsfkzXjCm7cVxyMhOD9cBW5j/zuQsyAVKt8WXMAEGDRpR9AcM8JNebeevd9Bw+Jd5N8kVGiFOsugfGrtL0ruJASLN2u4nOBDD7SDECMGJZ2WffBypBbOLoAIWxBDrefO2Ul4tHvB9cLiIutmwjDqw+tDRu+N3aJmWEdgAPWmHtbfjUJ80a3oAx0l8Ztsae9c227PV8ieW3SVCQ64UPFuoZjsOy97MVjreHXpEu9RYJ89tMv0hsGPVPfpGgDGGTzW2Rg43ODJUYzQEccJTcdVhVO4Bifit0XpXSfVKOCfMmxSznIRTdzTv/v4RDq6WmuHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=strlen.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9BPossyxiu3GPrzMmSXY4slYI+6J6waCQr4n3sia/U=;
 b=szsiwFfDju0ux6jFWvVSJKUNyhLVkyNB4QhWBaXWVO9nszAsXBXNcEPhqbwb/atHzIhAdk2RDMID7gLuj3kzkA2ogVj6p0Nyy95C1aFUoCbbV9ZR/YhEZNJrItZtVjXEqT17H9Lf1IvW7CtXxcMAt4LAZwGO9wV2QUrkglfdVA1W3BHakqloupYHJV4NXj8txynPsqI+mSYCM7E9dV7gUgX7UXaDQ+orVs0qHOZR6a4fWj0ug8nrqZtjMAxPQCbxyrq5wLbnOddLER38DPm0ZRUKLRYEuLCZV41dKq2qwYzdBcBfzjTONnm3Vrgu4pMw1mS2Yi9z3p4RJSZVsHNglQ==
Received: from MW4PR03CA0241.namprd03.prod.outlook.com (2603:10b6:303:b4::6)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 16:21:10 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::23) by MW4PR03CA0241.outlook.office365.com
 (2603:10b6:303:b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:21:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 09:21:01 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 09:20:52 -0700
References: <20230727062814.2054345-1-rkannoth@marvell.com>
User-agent: mu4e 1.8.11; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vladimir.oltean@nxp.com>, <claudiu.manoil@nxp.com>,
        <alexandre.belloni@bootlin.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <olteanv@gmail.com>, <michael.chan@broadcom.com>,
        <rajur@chelsio.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <taras.chornyi@plvision.eu>, <saeedm@nvidia.com>,
        <leon@kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
        <horatiu.vultur@microchip.com>, <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
        <simon.horman@corigine.com>, <aelior@marvell.com>,
        <manishc@marvell.com>, <ecree.xilinx@gmail.com>,
        <habetsm.xilinx@gmail.com>, <peppe.cavallaro@st.com>,
        <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
        <mcoquelin.stm32@gmail.com>, <pablo@netfilter.org>,
        <kadlec@netfilter.org>, <fw@strlen.de>
Subject: Re: [PATCH v1 net-next] dissector: Use 64bits for used_keys
Date:   Thu, 27 Jul 2023 18:17:28 +0200
In-Reply-To: <20230727062814.2054345-1-rkannoth@marvell.com>
Message-ID: <87r0otfhr1.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b63d14b-9594-43dc-df96-08db8ebd7cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itH2oTQcPZZ33kEJKrxCOGcmBRAX3jaiTnHFcQS/skyVYNbra7vfJ8s5CKhLIgFaPZ5wDsy3FSzBWlIfp6QgzQFWdPkEDpJkCshez/hawyTZl0/LVGRNJ6bP3mFatj38VLl7nXUj3od4p3IBhVa4VwYPvndoJHTY6hBtXR/ehRdO7QAwSYFodPwPZN3pkZjD3+3DM5yTmmoQx+jZ/8fzCKgEh/M+iqOMdAyOTjzUDbP5rooinmyakoOCJq7wlA2k81jOPAh7Np7u+Jar2azT1B52zxVblHUpCWkh83+BwhhamUWyqcC2ORBS8HPrefgNZ5GAvSRnG5NzaMIXhtJu2HKsYD/e+0g8Hg3pdNh6yEJqtZy/6gUHX+mH549OjYSuh1wZvLStXMb0aOEd6cweggz7j/BSX7d1OQ2ZnzMoTKG7MUPvxGXqp1vUOIhiy4h3uwBuzWv3fsJxCmfuk/M6JJdVMjJBYwl4yMdqd40PTBRDWn+rzzj5hoRPojE4eKXI+Dj+OLxbRDfGXRWL8ACJil3D30WXSdpH7M00Ve42eCbj0jPCtMAc3uN3AUjEO1mjBTBP/AI1lMwLpelEv7vC9p2UQLfDGLNPZek0eheO7hMVjKhTBCguIDINtFXWir0pU6Vfy2sURQK/UWJDS37nEYJUNiSH2clLnzgTlfSESZDFQ9uie+Ax+reuz5y7xpEzugGOiucPubtFtiCQnsALsCalnJoq4FNeTBO3TvnEgGj5LWJq2rOmvRb0f7D1FFeel/VAF5fguZe4cy2CxkSSCg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(26005)(86362001)(478600001)(16526019)(336012)(966005)(186003)(2616005)(36756003)(54906003)(4326008)(6916009)(70586007)(316002)(70206006)(47076005)(36860700001)(7406005)(41300700001)(2906002)(7416002)(426003)(356005)(8676002)(8936002)(5660300002)(6666004)(40460700003)(7636003)(40480700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:21:09.8505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b63d14b-9594-43dc-df96-08db8ebd7cf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ratheesh Kannoth <rkannoth@marvell.com> writes:

> As 32bit of dissectory->used_keys are exhausted,

But s/dissectory/dissector/.

Also the subject should probably be:

	net: flow_dissector: ...

> increase the size to 64bits.
>
> This is base changes for ESP/AH flow dissector patch.
>
> Please find patch and discussions at
> https://lore.kernel.org/netdev/ZMDNjD46BvZ5zp5I@corigine.com/T/#t
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

> diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
> index 8664ed4fbbdf..830f06b2f36d 100644
> --- a/include/net/flow_dissector.h
> +++ b/include/net/flow_dissector.h
> @@ -370,7 +370,8 @@ struct flow_dissector_key {
>  };
>  
>  struct flow_dissector {
> -	unsigned int used_keys; /* each bit repesents presence of one key id */
> +	unsigned long long  used_keys;
> +		/* each bit represents presence of one key id */

This unnecessarily adds an extra space before the field name.

>  	unsigned short int offset[FLOW_DISSECTOR_KEY_MAX];
>  };
>  
> @@ -430,7 +431,7 @@ void skb_flow_get_icmp_tci(const struct sk_buff *skb,
>  static inline bool dissector_uses_key(const struct flow_dissector *flow_dissector,
>  				      enum flow_dissector_key_id key_id)
>  {
> -	return flow_dissector->used_keys & (1 << key_id);
> +	return flow_dissector->used_keys & (1ULL << key_id);
>  }
>  
>  static inline void *skb_flow_dissector_target(struct flow_dissector *flow_dissector,
