Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CBC7DCB4E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjJaLDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJaLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:03:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E6BA9;
        Tue, 31 Oct 2023 04:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3RRBWi0uAL6puUtDkTZlSgCkcjPdcw46ICtMAmz1t4dOjGHXerc+93bMNZCT0OMspCdktIEmmXOTBxr7xCzJzeOVhlh14IqBICdV0YQVa3EZYw4/hImSOi9mkinFHdKxrKjv+/JiQK+caM5r8942DZHZ3ezW9Qi/dJCVNgACR1YYeGeNauEAgxn9vyBvvZc3RADmh5O1TjoElur/2+wQiA6V0g0OnOATYvUCr1YQIwsKJTUtdEQ5bncs0jI6gCBBdd/Uiw4j8PUNp8ftYDL0WNIR8sZf29N/6g7sBKMjZKTkCDO5bghAWiRzh0vWnXf+Jyp2QdZmut8qECJSRtopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNimcfvKgfAWt2zpZq63dvC5jjShibX9sEitfYFj9SE=;
 b=FZiYXzbkRyNI2HeX1N7Xb9wvaMMmDKWHJouoNwR/4wZMAeUyYt8He96Z8VQ62xrm6IxiNelK+yuP1qjDHltUVn8i1NPGyVqyb09sVSVYoFO3J586Qm6tLmw2p62AXNih2kUiEOU3FJgONTljHqH2DN3BGScygfYX3JYpscjt9mjcFkNHUFc0V1QL7RcZyo6AjN3hcYl8C9CgNceg2ALiL7hAEmPoOGEVoinELcsx1Ph0ldpW/9mRIDs2HNmsDr0SusOFyTRuu3E8U2XU00jqt/eRapohmLxYPlvQmFa6QuOGxWHFpG2QF12wOPnrrNtST+pPxLpus49Vn23hQ5Wyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNimcfvKgfAWt2zpZq63dvC5jjShibX9sEitfYFj9SE=;
 b=GO+DFuItWq+tVIACd82zsTdqGMOJb0kBG/j3nspjfY8E0CHF5AqL2U3/bNV4m27eEfJDYp9cJBzcQqvOcZ5YNP+z59BBZKPNUgM+dAvkqoLGUXlldnIITSZIbF5zsD3imXCEwUBT6daUCpxcMkJ3KwxLsF/ZVHR8CzRd3cmKh5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 11:02:50 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::302f:131b:a9e1:7751]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::302f:131b:a9e1:7751%4]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 11:02:49 +0000
Date:   Tue, 31 Oct 2023 12:02:43 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/hdm: Fix && vs || bug
Message-ID: <ZUDe09oTQFz1gSsW@rric.localdomain>
References: <60028378-d3d5-4d6d-90fd-f915f061e731@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60028378-d3d5-4d6d-90fd-f915f061e731@moroto.mountain>
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1324f7bc-7277-42ee-00ca-08dbda00eb93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJRBYfQJ5qERdImnEyKN+WWBCNmm8MfF84xsUyjm5p2scdaYt6E2F7VyaaBNQ4EptHculr8qyU7nKQOj+sqcG22UqEbGld8w+KHFetliARvJ6vKSjfxwAHO1FfolMflGRxXKueF13zANeD3mSlmElDnd4vGEp/8879bgf5EZAdgjHrEtiLh3Y/E4jjO8fQy5eE7Fxan0Wq121/sleGYr/NMFBOAIhtTXPq34eS4l6sZjsqmEY2+VLoNFaUPf9Ku0c7mFB47h8p4acAHyTDhGW9Dgdelywt3JVf+7eS6NhdybuykWoaw4gNyKMAYRlb/2NrbbsZrgzzN0YWbJiO7bTfwNWO5LuZ+Q3XK/yw1U5GCMp+YGNclqcAodTbh6BTTB7hpIF910HfRqzETO6b+eabbxgVvWh/9H6AWdul80KyU1WGDF0ugPhceMtNvNCsWTqlQeIADZiaXjKGd4jeOuxMtYLi/8mSwzu4ERGFbDzyMLeLVftCEcweo0FjxgTrh5WS6eUxvPtSi7Vz+hRg+TdPusehUWu5BKuJ25/o4kNoPLRlUkRTCh4yTx0OAGWCXw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6506007)(6486002)(66946007)(478600001)(9686003)(6512007)(6666004)(53546011)(6916009)(4326008)(8676002)(54906003)(8936002)(66476007)(66556008)(316002)(2906002)(5660300002)(7416002)(4744005)(41300700001)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Av4yI9Cd8JGyQe18psjQeU3D5Svey7lSxmxSDXVwli0xbbL6PIKNsjjf1hSj?=
 =?us-ascii?Q?FuMT1MyzS38BHJEkDVbTIkFIKWMxswn54zrrqZXADQ1HbHLwq6RgRQRVpVoU?=
 =?us-ascii?Q?1gcdnQ5HkUGLdCLxuynF4wntwPQuIbE2EqjYCRvcSTxQjp/iGho2JkGZefAG?=
 =?us-ascii?Q?wWO0zYhSn5e5dOXcUyjzMsGaPI/1k4WMQL1dOW4617J860kyLyTKPnIYEnOp?=
 =?us-ascii?Q?VtSzVUC/XuicVCYMHEK903IycE9/jUQDQZlJEonD1tKkbvpmPBddgw12ZNy+?=
 =?us-ascii?Q?YJ/bP5y3abhw7tg2LdCO/vwxBDSGwQvEddj9kLcPP/yCO2NmRy6tspXHoQJu?=
 =?us-ascii?Q?zzslQlGiR/7r+znRdrvI8phwzsmUPa/0RtbmzrfZXFDXH+vWC8Ko/79QsjKd?=
 =?us-ascii?Q?RWIvrLPf86OX9pMlpLSi2AwgA4WoqUWxIwSBRCGSkCgkBGy82P81+hp//Q+4?=
 =?us-ascii?Q?gEY8fpUtk4FYk1S5Rt3kzplYZovuQGv4aPGmILzq48JTFFxpR1HyGkyw9gQ1?=
 =?us-ascii?Q?cYKDGkbzSCgWp/BU0qeGA6ORwgauLFmHeut1OOxMdbrFJa37MG5hot/VlYFs?=
 =?us-ascii?Q?P6Ni1AnrgzJe+HzVcycOp+cD2QcBmnKv/jNnh05sVLghW8AhruXWSaI/iI30?=
 =?us-ascii?Q?3CEDHo1hDGwByVItgOtglIAT6PJKJKa4FDXeZQmLAhH0Z2N+6YgY0+P/4z8e?=
 =?us-ascii?Q?pHbEEucX18TXgGgJxYnwvT9nNqRGgwWN5rk1A6atQQzJlLaMpUrGSSjAQ6Ej?=
 =?us-ascii?Q?dT1PCKEUlzonJ34xdTf/SqJlWtQKqLJlPhMtzcIo73Ruj+a8iCYZCmfpSDT3?=
 =?us-ascii?Q?tSRllq4nylp2ccDc+fJVab+Ws23UtpVfx028xoTKcjjvHAYGEyHdF5UOI2ly?=
 =?us-ascii?Q?6S3Q0UfGotTX78Jv417J384UQnGh93B/xmCpk+i0aUJ+MsLu7QtE43R+ekg9?=
 =?us-ascii?Q?e7V9u1LPf6Dlwzl6bI0RwfEVnfAZL1+0xP+JeO4BgTD5aw7flEoFvGEqMvzq?=
 =?us-ascii?Q?Kwr9PGKR5LD6lX6CgaTDYGwkf5mYw7GONlunj0K8tnlTMOcTuEqBS3rzEQL9?=
 =?us-ascii?Q?hfdsf325pgxhs87gT+1txAQP2QsXlWY0NIoC6CZ1btj2FdT7bOkaKOBGTWG0?=
 =?us-ascii?Q?bJS3b0zXwk39I8n5LmUZT7TAjmPBqiaYytjHQsBdfPhxJHiXjc98KMLLTiYH?=
 =?us-ascii?Q?p8prhmsD5F7VU29H08REp3g6iXUk7Oyv1CqcJOGxM9uKtEQNt3w4XQgVxWnq?=
 =?us-ascii?Q?2lBpmNR6WvwB46MVDSYLu8MHNfVpDvwyhJKzziK7Dponj6A3LmvdCOV/2guD?=
 =?us-ascii?Q?na1WTubBrO7ymOQQJB0g4U+2uBMn4gYORs9trFHBVetdi44at7J1Sa0drCXP?=
 =?us-ascii?Q?M1B3ZsBLZCSVJarZb8CNAr2ILVmWJvKVlCfT0/XlUSnPrapB6QumWxIROrqq?=
 =?us-ascii?Q?AxUzJ4LQYydVMMmCHg/QEzDV8m/0pDLiJ7pOoRyseWKxgJ5L0w4GdqYcGs6s?=
 =?us-ascii?Q?SZOeFKxTDhTA/rwEN+l3rIbt0L372WjajNpuHwCseY44W0TQEa6C7v2bv9Mf?=
 =?us-ascii?Q?S+CtIHDVU7uFKv3z9+usABRJw5rO6naOrivgbi8y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1324f7bc-7277-42ee-00ca-08dbda00eb93
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 11:02:49.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNiCKPTNCHXuiW2ZLG2Lc5YUmSgzikOZgAVab9tznFvHaAdZ54e2oTuUInajVsOi/AutJkvhA+F6fJE4VrzS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.23 12:53:52, Dan Carpenter wrote:
> If "info" is NULL then this code will crash.  || was intended instead of
> &&.
> 
> Fixes: 8ce520fdea24 ("cxl/hdm: Use stored Component Register mappings to map HDM decoder capability")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/cxl/core/hdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index bc8ad4a8afca..af17da8230d5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -146,7 +146,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  
>  	/* Memory devices can configure device HDM using DVSEC range regs. */
>  	if (reg_map->resource == CXL_RESOURCE_NONE) {
> -		if (!info && !info->mem_enabled) {
> +		if (!info || !info->mem_enabled) {

Right, there was a bug.

Reviewed-by: Robert Richter <rrichter@amd.com>

>  			dev_err(dev, "No component registers mapped\n");
>  			return ERR_PTR(-ENXIO);
>  		}
> -- 
> 2.42.0
> 
