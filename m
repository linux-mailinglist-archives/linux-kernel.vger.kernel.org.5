Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FDB761E09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGYQHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGYQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:07:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2104.outbound.protection.outlook.com [40.107.223.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FC8210A;
        Tue, 25 Jul 2023 09:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqWQW4QY0L3SrsYc4dYiy/oZ8ryZhMcU+3IAZrl7lqvThgMhlfX+50rB1ssdUugFGtTE0XJHzDo7SzGG6xfoHBXDmV48dZ041iJkNhXgA3c9WpuriBSYHYEKjiBpzqrjpKR5326+IgOh6MMTrIURUO8aSX6UmDENpDPYxL5k0MjXmIclpWEs/w0THjFbu9iYtLag5J80y6IFpX1ulNi1b7seCSjbr2/izCIIJpoB3wCYv7wMPOPDKXZaSJdRdRj96apk+6xBwdS8JihRmzQ7AjntQOk3pSTapaF6xywKcphxjJcd2HEnc6uaYNOcaMuHMoTL0fdGubJg1qlf1cL89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Efj0Rs27lqZ4lT8mv3E9sFl11vieYLt7tWnQ+oZK8Uw=;
 b=THBwlHSMIeYc5U0MYRqjnCXBmRQDeSpukT44X8CF4ysiEVVmwnEEN4Lmwl8CgjnTbc0yP3LxesCviuYZsMGno1OR2d2pg5PHrr6D6QXcxYOnEKkDddw/dRUmkLimjVMnitmSLekD3A+TS1eZpwOPGNU8PjPccPxi0BJnTq2C+h27tBElspyTfK78VP1nhaC3elpahbt3HvNMwpHbJmQFUo9ylVwKjAQxBkEHh4hD3IjZCT5IlqbtfKI1LGijDfpdfjZY6Sb81eVVVGXi3gTvrIjqD9Y41vBsqOoCntD1f9ZbVQCg5/4AC3cGPidiY3y80MPJyK9QsYVUayRup4ZNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efj0Rs27lqZ4lT8mv3E9sFl11vieYLt7tWnQ+oZK8Uw=;
 b=WJJMFcf3BcMLHHfoVHa2N8uaXBf91vuJ7gKOAjMfxrnapGTHLYS7iM2F0q8EGw8Q2YguYSv0juJxs799wSoBTyNDzQBzYp1Sjfk95bLhtxwCxZ6GTlSGynR0UVV4/HIQuD1+i8lei47qqSaig7yT2dF4ItFdIiiN0ZXFiJJokJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4880.namprd13.prod.outlook.com (2603:10b6:806:1a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 16:07:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 16:07:24 +0000
Date:   Tue, 25 Jul 2023 18:07:18 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com
Subject: Re: [PATCH net-next v4 03/11] net: phy: nxp-c45-tja11xx: prepare the
 ground for TJA1120
Message-ID: <ZL/zNmrewrVtp+0g@corigine.com>
References: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
 <20230724141232.233101-4-radu-nicolae.pirea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724141232.233101-4-radu-nicolae.pirea@oss.nxp.com>
X-ClientProxiedBy: AM0PR02CA0183.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ff7186-fa27-4982-4a1d-08db8d293ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tpsd0n6o9seLKjUHZ9g0Diw/HR/v3gTnig0u7lMQyVgXfsNYMGXhb+mc/qVqCJR8WaAn6PCYNtIrHrU3CMucL1prPGotcZlOWTE6f8eh/GyKqEZnoMpQ3deNcM3iDy0j3nKi1b66wIe7/FHmBaENlLLvPzzqsU6A7fjQDCShmtEpxTC3iKYQZ02PrCc3hWwJbFDPWT4ohSjqyXYOQPNFPjfETIG0+IcngH3T2cgeCwnmkdHaxkGQ71UdTq/PnTuSQNgyUwrYEnPPMcCULmJHvGw7yhKtEXCVo14/HHILRvlECXdErKAil+OTX+iNAzPcl2tDme6d7BecmsJ+uMt7RVJ74rWMH9HOn7aUKZPYsgJWk+Z5OU921GgKj7riVcXgS7ZLHamsSwmYZSufWJRpNjP8hCUnhG7UGNUB9t8U2PGbtTG7kbw+IfHoUJpoq750RbHoumsGq5bV+E6ux4ZkOi7NaYuwSS76By0wOrM4jnHSaTMWhGUQJ325h5QIlODUnAKAt9y5jxhqmbq41M4b5io/c3YMY+kEm7KlDqfkJzZDDDv4U6gLw4X1Z/HeZ+CD1YTBuUPBgLqqhfraNRUMYEKqe1QHzxAyHPWTBLH+0Ag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39830400003)(451199021)(2906002)(478600001)(6486002)(6916009)(4326008)(4744005)(44832011)(36756003)(66556008)(7416002)(41300700001)(8676002)(316002)(66476007)(66946007)(186003)(966005)(38100700002)(6666004)(6512007)(5660300002)(86362001)(8936002)(2616005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F5wli+ochlISvTg82EtZl1Hu1Nckw59oLYlxMwCq99TW8YFzDseG8J2Uwz5K?=
 =?us-ascii?Q?HpkznYrEb9GOxCv6sc45T0MYLow2Y8AILYZUc2zdlmS7AD30KIfJXbdGR4Aq?=
 =?us-ascii?Q?5spoqNdUSzItho2I8rX+ebckh+JD3l6ogWdkNduSqQ859UoY8AJQAMzRxd1/?=
 =?us-ascii?Q?M1Xrv6QlSmvZ0KAq1qhEhdLe3J9GvCRBnx+OuPMxEjfwENiA0bCHdI2C53ke?=
 =?us-ascii?Q?hoPCQx5rz5+lYLSSeL+mKvfhGX2hkXP758abw5qPDkqiBwrd2KvVm/d+DyAb?=
 =?us-ascii?Q?sXt2AbAn77O/tQctEZtonvO8og4L6/0pZU5Fjt5WR6j7kYFLsFEMNXKnl157?=
 =?us-ascii?Q?IUKJwRq6DuduHSVbb6iIgCjbGCf3+Vjv7CzQOTy014n2+hFsDX6IxRX6QqrG?=
 =?us-ascii?Q?Do3mATesmw+P8HVDicWNA3zUzXIYzb5yMSyFSZzqYccSUX0kadp+Hoix+54+?=
 =?us-ascii?Q?Z+gaN+9LcRb2A7UFwF5A00HSiUOzfkN2cTj1eQAM1nPSc9LuFsvTQfI1B9kG?=
 =?us-ascii?Q?lfw8VAjclFmd01SzbUhGw8K8GFAnrpNCaQQ9BECqezPEJ/D2f2JYZdQ9ZI0R?=
 =?us-ascii?Q?0FQFYvjuQdJqIAGvs0HH+BpUOUf995IcpGQZUcOI7/1TbCEs+1HKG0otBj48?=
 =?us-ascii?Q?VEkVI1OXRHy1zaywEXEQJjhrF5qYkLrONe4KRjlRQKJmp/TAQyga2b4JJ94o?=
 =?us-ascii?Q?m714JE2Ut01BzJ262Z1r/ABa4/6Z4d9Op7Rdw7aF5b+csZ1aiLgQkhRv6B5T?=
 =?us-ascii?Q?gu5WwV+QLdZkmYEPvbBfhAHZZs6vrsfF+HEhOupF4khPjmJ6+ee9kgolorTe?=
 =?us-ascii?Q?vBtqsuH//p9iHJcZ9rd5GmVSqz2lEDRPjxDm5Eo6haqMEDvS/NNFev2u951T?=
 =?us-ascii?Q?1Z1Nh8cn8UGzsObV7Cxu0zU5fAchZ6/T2/ekEf/5aa5JfjvAWiJavCKMkFw9?=
 =?us-ascii?Q?7AVpKXFBT2C+4Fct3YZVU74gdInzXF+fgSqS29e3RCZaNyws8vzs+Rb+5IA7?=
 =?us-ascii?Q?FgkeAvJ/QftE23b5KOuB9odvqOjiKbYCLg80HvPdtqyCKGn+SVkfhlBl/lyi?=
 =?us-ascii?Q?hLLmu+VhvaOVSMCPtgiEtS/N0hqVbEkeYlKOs/ju3Hl0FvSxxzIfx98hrdpc?=
 =?us-ascii?Q?Wginau/SihsgPxqlbuxErz+HCOUaksBis2xmWQZphyO6pscgl62F2cqjWY1Q?=
 =?us-ascii?Q?G4hnYO+7foNeCEXNutUMCfS1jX+5CeYDXt7GAgX8fHkhlp3o46UtNRKghHlq?=
 =?us-ascii?Q?vWV0jcnY2D676H9RsWHdfZ0hetGgrlwWt0LRFHAkZawHsaCIqth00hih2vCw?=
 =?us-ascii?Q?OjTlgnpky1dz9dXDqc++E/FIo4F0lG6lUBoD/3R49IN9KrKyqXC7gnKuNtD9?=
 =?us-ascii?Q?T4fUzyWr/3lHuujoEkrhvB+3apHd4E5Pcl5CYr84YDNS87ojXjD+fWvswyw1?=
 =?us-ascii?Q?qfCsVmRzPBSXD+qpPvKqONlkJgrnASKqHTKYJLNSrBKTfpd3oZfNAp433x7m?=
 =?us-ascii?Q?6G1ux93JGZGDX6pJQHQDH5uzX7Ubwvl9CMgFxO8V6JYQIxRtQ6j0FjnqJjq2?=
 =?us-ascii?Q?m6RomCgLCW+DBBOqjQDulo9R4pWmgiFbjNyRSXsQwRgaDwyot0p2atN18Pd8?=
 =?us-ascii?Q?Ba4Bn10IEZw9qmNtSHAp4tDLdbXSIOoWvsYMgr2Fm0ntnwLlZrhyo6R92W41?=
 =?us-ascii?Q?a2aJgA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ff7186-fa27-4982-4a1d-08db8d293ba0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 16:07:23.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiV8oK4r/gCyb0pDxubh4zhhyF81C47Iy6KVUqWUokzd2Oq+mLtsXdSD6zw5xx5GB+YvInDru8dS/6cvKMDg2JuVjdOTcNe6mBORUkv5zfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4880
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:12:24PM +0300, Radu Pirea (NXP OSS) wrote:

...

>  static void nxp_c45_get_strings(struct phy_device *phydev, u8 *data)
>  {
> +	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
> +	size_t count = nxp_c45_get_sset_count(phydev);
> +	size_t idx;
>  	size_t i;
>  
> -	for (i = 0; i < ARRAY_SIZE(nxp_c45_hw_stats); i++) {
> +	for (i = 0; i < count; i++) {
> +		if (i < ARRAY_SIZE(common_hw_stats)) {
> +			strncpy(data + i * ETH_GSTRING_LEN,
> +				common_hw_stats[i].name, ETH_GSTRING_LEN);

Hi Radu,

Checkpatch suggests using strscpy() here.

Link: https://github.com/KSPP/linux/issues/90:0

...
