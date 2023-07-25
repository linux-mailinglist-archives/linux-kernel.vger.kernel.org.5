Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40277760BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGYH2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjGYH1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:27:22 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2092.outbound.protection.outlook.com [40.107.101.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A109F2;
        Tue, 25 Jul 2023 00:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4hKvXjDvypb1zNFSgworeLkRuvCY+fAN6qiyjXUWOcJFeOO4bVvotaeGDjgzHFPnQVEnK+XYRwySPWzeJKyDIJzclzFiaxGh9tGyBAu1FZOuAMYUFDzEBKusTwMRzkeenBivQS94YIUjP0TV0X+4rY15uEklW69Q/jBdekGEuvd1K2VjOb9gkf4ynwUJtYqvjQT2xtzY3hAtCMcnu/pPnZxBcBlTWLGl2sZq6XG0v+6N4BnOKTz9s+v8Qf/tCNKPJHYZ4zLUdY97VLzL9DWcZVp+3AN5LK9KP9iqJdKU6JynkToE+vihM8AocOysAZv+4R+qEmKtvTPhyAerPB+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GaPYfnlOkLgO3Ra+JGe16BN6CCDpRjOU0Z8d9d5sxI=;
 b=lE1lzThimhUaHHGCTojclbcQFVX0ORIQ0VAqmRY+jw10ESdNenXI0TZwQ4F7rTGKs9IEP9X8POR2fhVW6tB7NdlzcoBLTddVCntTX4S1ETvn6ORmGteF2VyprGj7PNhlhVqQ0vtTZVDh5FdPiTBb3nyIi4w2npkIUMwxQ3a0qHIbxHccyl898zZQ8H8k5iGTPsVbzKAo+pp8bbgQJh7kjqpVDszg6jhwlOIbGTzleS3HAxrCpCJnAWIUDN0275nLgD7U6tvoEmGSAW0vca+P/T5ClEJwMd7DKTEUKYmqK3/+5T2KCSezCWWV3B3bI01LRfohQmRS/+mRqu62oOSYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GaPYfnlOkLgO3Ra+JGe16BN6CCDpRjOU0Z8d9d5sxI=;
 b=mjGILJfjvtpj6dADmlHxj+btoWK4r/0+GyQ4w1i72lxJcC4/eONc7pOFcmnR1HjywB9JgYKe8R1HJzWLx0CfyGknHIzYnXFh0116AP72rSQdFP1Lfui3Hj68+DNvt6eJ1hwbFP7gVHVMHixb95dnhpeUbM9+ijmRcy7siQzRaM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN7PR13MB6131.namprd13.prod.outlook.com (2603:10b6:806:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 07:25:57 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:25:56 +0000
Date:   Tue, 25 Jul 2023 09:25:48 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 03/10] net: ti: icssg-prueth: Add Firmware config and
 classification APIs.
Message-ID: <ZL94/L1RMlU5TiAb@corigine.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
 <20230724112934.2637802-4-danishanwar@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724112934.2637802-4-danishanwar@ti.com>
X-ClientProxiedBy: AM4PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:205:1::44) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN7PR13MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: f130f460-2933-45d5-5423-08db8ce06317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oacCLqk/6V//hjdEHbkmuvpUClcVGO7fHiXZs4IXsV4VrtDJb4regix8ucktTwxdK97mmcGxfZCx+isDiExhH4u3D6quI/DHoBBOERiYQek/48g3Tz/a9gSiquyCeBjEz2y5Bz28FnPEa7MN+b1GLHL2ReOk1AR28kYoKgauDn8Sba9szYU6qIk0BTo3modqtqj7OJ3wpmNeOhHnPIOODO42L2ltAdP58AaWHEmx0DvaPx7T8UgUvtW4tVvnLPtNnCAiuV3/Inj9uu4xXeNuJCrDsdVFficwUgeeaB17zHy1i0Fz1cy3TGdmHAIf/T1OVucn7WhJkDvrM/s1Z2n1Dd0ISM0MTs10QvlKRig005K/TL2TCTNy/tZsa13uVpVllHC0eXCy/kq1py3WriPf64jnd95x01tU6YDVjgvtvm84KM8IisUsKauL5oFESzkTZuyEqtBVzfP3zPPJ6ad7VurIF9CpVLP85YJuQxn+hhUUEp6Ssv6YhdAPchVsKvLG/4fW/+LmroRKCkLcq5fvHsNAhwl6WHywksNKLaF60CVG+M01M2x4n0snn0zyGfJ2NyTdVRNpbKCoXm3D+5geLMKVHhaKMXIJz3xU01fB10k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(346002)(396003)(136003)(366004)(451199021)(5660300002)(38100700002)(44832011)(8936002)(8676002)(7416002)(86362001)(66899021)(41300700001)(186003)(83380400001)(2906002)(2616005)(36756003)(6506007)(54906003)(66946007)(66476007)(66556008)(478600001)(4326008)(6666004)(6916009)(6486002)(6512007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A/Qw0Ym4YNG0IXuyTjCnb8h43DZdjJMuTpEpvOFJ6gCk6y7eadaNH+obN+xo?=
 =?us-ascii?Q?WYNUE+xEAX7Zz7oZbk4OR6ygaghDw7MmHdP8+LHWHUzBw4M+h/yhJgfH0itM?=
 =?us-ascii?Q?cdYeTJuUr5BnGlvM1pLTmRj7xwrET3cSw2stvEayW7ZGjZODCSb9dVKc58sA?=
 =?us-ascii?Q?hoqJKX5ckmifIZPnQQRI7RGo/U8JcJcumpjoX/kmBzNtZuUnfKBbsjvdJuC2?=
 =?us-ascii?Q?x2aIoItUevIXTgnKrdENnK+SNnypTMGr7nPajtBKh9TAI0uzJ7Jm/1TQ6gNa?=
 =?us-ascii?Q?Y9bM9koGjLn17trDmTSTTmWy5Peyt3OFzAFlgNaiNldv/yJKHOtXiTKjRl4r?=
 =?us-ascii?Q?GzpED3YUHmqsweUl3yuK+AH7KYZArgx3I73Hea21hZ+vaUO8xSnn7Tl7s/iY?=
 =?us-ascii?Q?fsWRPJKu6DRfXURJCthOulsyu4OA8p2KSzPWQ1eYWiyc93ZE3S4gT0c0z5nb?=
 =?us-ascii?Q?OncCMsb5UAtMuow4EIX/UBBB5ncs5JUO/rUwQUknTeFxXwjAV54MuEhI+op/?=
 =?us-ascii?Q?JLUOc1VMW2zICD5Icbe0WJ8Q5U3W49HIziSf39gwgRoZk/q73nw+ncEgsArr?=
 =?us-ascii?Q?/kksKVBuDAVYHj6G2tpra+DxASWNLYpDMDv5/BYYJsiH5oISU3syISvyeSzK?=
 =?us-ascii?Q?GCkUflWj0uhYfSxbMol+rR3Co4m6cIzgph4XJEnNQPIV5mw/+saIH6YWCxac?=
 =?us-ascii?Q?tEbFLsKOVXWw03pPlVuQ9sZeE4w9k+MlROYl348ejGOglIgikyhgeCX+Qk1M?=
 =?us-ascii?Q?s7SDWaiblFNr8SjkNTTkAhwBjT7BCDppmSUlcVuecLZlFc9eXjRzs6oGi8/B?=
 =?us-ascii?Q?F6KCuudyrp3mG7JJg5lh+eqPxYTMpsxWo0X43Nb7Dt1tuKYB8Car0JxexQHO?=
 =?us-ascii?Q?dc9WjvICXhmwYQ1zcs2qzkNe10rxGp4+XZMsSO84tTDgGLoDUkYeqTzMQR8V?=
 =?us-ascii?Q?c1dOlVdJn8Tjcq2gE3Wfvcguj7T6fXT6+pqwMtkyQwDzCuTOqOBUZoqCy/7O?=
 =?us-ascii?Q?1gzs17/noApJoePzrtmvDiN2Kr1wKq8yTbNKiC8R9cakoD4MKkQmnfT6sHgr?=
 =?us-ascii?Q?xftMEPIZ8euEjqKoousoRatGEzll4WBA85b0E3qi1AW7JTmUJKmjPVCmQzwb?=
 =?us-ascii?Q?Z8KFsy4rlWQ7yVMllITyeTr8i7g+IwYX8El9hW+BtXoPr/bm8taDo9557Yd7?=
 =?us-ascii?Q?UWHuRrcG4CBcgEAJ2WyitM3ZbNsNNjTaHlIa4tz6f6KKWij6tArZ+TyUXcx/?=
 =?us-ascii?Q?4IxDvthAmptUs9GwbfAkaHPALHiV7HPdhKf7q0g8nwoDF4K78b2oVsh6cnoK?=
 =?us-ascii?Q?KXHjlqYnNCugCiD6sNWsqLpEvAvyk+2JENDr/ZJdnC86LR57M/Syu01W17Nq?=
 =?us-ascii?Q?tOne9mgk/i1k3ZpzZ23+NNMMc764JN5rHJGbOntfLwhAZcgFDMnLUhNMLS7M?=
 =?us-ascii?Q?Cdl46+SHluj9KXkCl53V4Brq+gIX6gG6YGPm80NNeFFJqYBbZRjpccFvXjvn?=
 =?us-ascii?Q?m15hagNYV4mopebqMSQVfi0vu9I3GWVoExRR5JV0bSBieOYPZKxwLpqacpKV?=
 =?us-ascii?Q?uErwFGhpSKcYEnxP7QGG2X9QM1s6YJ0M/gLsr1UCNLcPLZtjSHv1MwCH9skZ?=
 =?us-ascii?Q?5xMWIOmTw29RLAVCVG1I+oUedLkzlmFPPXIkTZ/0H6RMtVyYVvHp1ThjNaDq?=
 =?us-ascii?Q?FWb2Wg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f130f460-2933-45d5-5423-08db8ce06317
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:25:56.7489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L735baJbN9O0dXBsQtSoVSSUa5ZhEwqDbRGYs6UrVTpqchmtdHgQrC3UGprIUDGIo+mslEwDNpZ2V7DshqQMUp1EiTE6qYG0HghrIOEERI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6131
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 04:59:27PM +0530, MD Danish Anwar wrote:
> Add icssg_config.h / .c and icssg_classifier.c files. These are firmware
> configuration and classification related files. These will be used by
> ICSSG ethernet driver.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Hi Danish,

some feedback from my side.

...

> diff --git a/drivers/net/ethernet/ti/icssg_classifier.c b/drivers/net/ethernet/ti/icssg_classifier.c

...

> +void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)

This function appears to be unused.
Perhaps it would be better placed in a later patch?

Or perhaps not, if it makes it hard to split up the patches nicely.
In which case, perhaps the __maybe_unused annotation could be added,
temporarily.

Flagged by clang-16 W=1, and gcc=12 W=1 builds.
Likewise for other issues flagged below regarding
function declarations/definitions.

> +{
> +	regmap_write(miig_rt, offs[slice].mac0, (u32)(mac[0] | mac[1] << 8 |
> +		     mac[2] << 16 | mac[3] << 24));
> +	regmap_write(miig_rt, offs[slice].mac1, (u32)(mac[4] | mac[5] << 8));
> +}
> +
> +/* disable all RX traffic */
> +void icssg_class_disable(struct regmap *miig_rt, int slice)

This function is only used in this file.
Please consider making it static.

...

> +void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti)

This function also appears to be unused.

...

> +/* required for SAV check */
> +void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)

This function also appears to be unused.

...

> diff --git a/drivers/net/ethernet/ti/icssg_config.c b/drivers/net/ethernet/ti/icssg_config.c

...

> +void icssg_config_ipg(struct prueth_emac *emac)

This function is also only used in this file.

...

> +static void icssg_init_emac_mode(struct prueth *prueth)
> +{
> +	/* When the device is configured as a bridge and it is being brought
> +	 * back to the emac mode, the host mac address has to be set as 0.
> +	 */
> +	u8 mac[ETH_ALEN] = { 0 };
> +
> +	if (prueth->emacs_initialized)
> +		return;
> +
> +	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1,
> +			   SMEM_VLAN_OFFSET_MASK, 0);
> +	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, 0);
> +	/* Clear host MAC address */
> +	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);

icssg_class_set_host_mac_addr() is defined in icssg_classifier.c
but used here in icssg_config.c.

Please consider providing a declaration of this function,
ideally in a .h file.

...

> +int emac_set_port_state(struct prueth_emac *emac,
> +			enum icssg_port_state_cmd cmd)

This function also appears to be unused.

...

> +void icssg_config_set_speed(struct prueth_emac *emac)

Ditto.

...
