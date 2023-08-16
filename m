Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0EA77E7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjHPRfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345251AbjHPRei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:34:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F317CC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wi6+33QH+CrFR2+gNECT5ZMMKOkfwWLr5eD6jBkhsILZ3INQIkPLy/2UL+zW2aLBBOCZBukXyF75Q08+9yvUL+0DP8vQ5qavbPS365IHP79A+3MXjhBXFAE6CxaPhy/5NmgeEDvzHzmJmUZrdp++45/mZKj2NFX/aUcOrIGB0bcaE4/1g9BvC4KKV72n0Qq6vDbiWjcjgNisyfWVLMskExzPKkdDa5WU57ezxv2lSvEGTh0HprKlcIevLydFD58z+k07jJJyd4r6fMgilAjmYrHoYNLqL9Km1VSMWOaQip8D3QXWp2LlSnUG3Or8AOjqRQWoxODDyrc9UZnC8dDwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK0sT7eFerEJpYNYABA3j2Mk1yzGzdUyddF2qMAknUs=;
 b=YZYOewgPNF+EaXT/fqI0hbxu9R4jOMCksfFbXwppAvpMuKJh9id3YWHqc3cZIJh0Qu3gfXZjd8l34tpL4DkNsdRwJky+bkc/vq7dUzIEF1yNMDt/3LGSRq7V01IS2qwxQzmt/zg3NRgbuecec8+ZhGMZJGus7jJSeFahUJo4afDLyh8gri6CX95qPdBYwVQBb5UzCGL6lvRBLCP6XHiMZoqdGFvwhzHSI/fRj2MgjngxAubCJe9yPpAT0Vr3wQ0DqjKIXIkJpSzZHo7k3RuuKYfon1AMcHMKbbU/leL7lyqi11M7ouluxwn0nVBOH9h1tGYx8Lpb+C5m/wY3M7ffvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK0sT7eFerEJpYNYABA3j2Mk1yzGzdUyddF2qMAknUs=;
 b=cFOlHriX+yi5lrUWDdZSQMguE4ZsQj1H4tZLhR0eJuo9dMVBhtDE5vURujDOahh/GucPw3d/OO70THqS3x+leC/VrSpSwtoSLuF0WYk2+uCOCg808yZCtiD16wPiaIb633gC19M3b3/X7b8/HJIAEJTTTJDolaTQiqm6MZPAHJtoBeAjkzjfufSAGXtQtzSvEY0EA0/ifpvM0jVU2UcRH5iIPtmQdIbqk5EmyfW3j0HaRJCW4GSgh98QdTCaOBY3D0JZyAAkXgtDU2dlmCm7R0Hayfp7YNaXi5FpFFjpwGWECErDTwUOrcGT5g7OzZL38nQbqSMC34R/dHdBVl9O1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 17:34:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 17:34:35 +0000
Date:   Wed, 16 Aug 2023 14:34:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        jean-philippe@linaro.org, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add a configurable
 tlbi_range_max_n_shift for TLBI
Message-ID: <ZN0Iqf9xrCEOOXUJ@nvidia.com>
References: <20230814215701.5455-1-nicolinc@nvidia.com>
 <ZNy6Pw/Jxn6jsIxl@nvidia.com>
 <ZN0CciT2hBISXxoJ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN0CciT2hBISXxoJ@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:208:329::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 1015c7d2-9d1f-45d7-78db-08db9e7f0ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWeiiRbiw4ZSagKIebNRh2T0DvQn0dbyfTTdfuH4uxdZ/95pjShW0ITm3ZQss+3xpFGsxgPtwxbwSeQNA85qO934RDFtS22DyHECrhbKhUc1k8lPML8PkU5ppMet/fqAgSLAtjVnTFjBMCgbTsG5Cik9Oo5dYNLI3ZoARSVqcW/pVEfdPeq7miMaqcEl5xzz3AWFtc1cWq/WA4XMPZTqd9nxJyXY+U/M2lcChx9baPfICzWgNpFC7qvztvoghfI9CFR53FE96BW1DNSxFHVeWU/pFWLJ4zs5Yf0xowVm6mXoo1WBVAuO8ABg0MyagTLvC7ILcIRUJ1MI0zRjG8UdKYSb2RRvotsJQB5643MfZeFgRzsGN+vHh0aO6WIleL3cvz95IUE9BbxtRu/o4YeRpHo465EBvowxTxF7xH286bjHYJQcEmqBPU1U1Tk6Nk/5Rev257Z3vhm4KR8PWLXdpUP5+w0Y1rpFJXiNgGNufQy77XWSt+istCL19SiWwR9DxPMUJRhcffMRkBwaLPrEgtGimNEsHg+LwSPe7+72fJ8Vqlww5tqwvS7TMBvy3yrL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(186009)(2906002)(83380400001)(4744005)(86362001)(478600001)(6506007)(36756003)(6486002)(2616005)(6512007)(26005)(5660300002)(41300700001)(37006003)(6636002)(316002)(66946007)(66556008)(66476007)(8676002)(6862004)(8936002)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UGDqZCW6gTjcY9AXB8ogM5YHx9DDTQ00ylTvDfN/qfcuqCdlGOhhIc5NlwVI?=
 =?us-ascii?Q?igxf17+kiOPV3r5TC1Upec+RiMSCbG9eaOC5QAQ5C0s/dRp3fn/FYEYihr36?=
 =?us-ascii?Q?JvYiq15seAwn740QVrym72fpwVROVVvPOXtd072zDAKo+6qifI3MyDw2kfEn?=
 =?us-ascii?Q?HjWUeR8bSunMZv2vDm0kv/uurES8PXkOldX/RjTPrHX5bMYu5AdvbdYYYgxB?=
 =?us-ascii?Q?aGv9B9dHFD/9SidP88Vum1dgdfIyZ4qr8eyDL5RVtINuXxWGRfm5/9/czXhT?=
 =?us-ascii?Q?YuqoX5UX6nU96LUJMlJOArojxbbXM7JI66do2Ce+nK7i7y9YC1ZOFutGxr9M?=
 =?us-ascii?Q?AsTTdjaCOj9wbvAqTF8Ew4eUWQp/q1t4ja9Fj0vPX3vomKjBEZlCSptX5zk3?=
 =?us-ascii?Q?EgpJO6lsf2UZ6PNEan/SPIzd/rtHIF0te8iFCNURxqRh3i3byeWx57k5WssB?=
 =?us-ascii?Q?bSk5uiNwRmnTxgEgmUmZccE/vDNfx9b2JhJiJk20AoJB1BgXiTYnevBQ4lnX?=
 =?us-ascii?Q?Rc4CwbKd8susFzWTm1ROxxXKb8UvFD2V0GI14Rw5mrrU3ZCR/U2SRWEKq2JD?=
 =?us-ascii?Q?g9HuE5Af2te8zfyHAlaMpJUxl2nQuaQEDpy6uGY4GyVgbkH3uYurNyd41oMK?=
 =?us-ascii?Q?MWGOwyFRuizAdgnD/GJ1XJcdyWy59WGjToFuhDox6kH+YD6TKXdCfRvmmiM1?=
 =?us-ascii?Q?wSfsgUhvADFYB9jJLEEeL1n1wH9dPdDHP33Dyiscr8Uh7JKlAbcMp1FY39PJ?=
 =?us-ascii?Q?oJYw34+0HHrnQaviWqDm+/5Fw86O0/OMA0g0BWOcmOkcvf/MfebGNztIUQIn?=
 =?us-ascii?Q?A6BsfLLKq1ZadqWVfOFs1I2jy0qDnCChr/9ZxR0LBaFevEpLIUtPTlBijoe2?=
 =?us-ascii?Q?b24FGzjkzLKxUsloO3Rni6QNmF99RI8MGiS4j+54gGbd9pB5FhhCU4FeZi5W?=
 =?us-ascii?Q?AtLXPa49yCieako/RnoUH6aogieaj3rvacs4WwKYxfGdKuf81KsuYZ6pKUdV?=
 =?us-ascii?Q?c6GwkX57uHe5guH02iJ2T4C9BCYJQ+ZWcbk9r4Ff+F3Lew39wvmOZbboHZAO?=
 =?us-ascii?Q?6mkQqwgIiOlYSrbWho3uFpdNn96k+Y6CGL1HWVq5ikpiVHtvkuuglqDv9S1k?=
 =?us-ascii?Q?+1PWzoBMpqcedzFhLxT3LDt7NNDED8mMBswIsaZWvi+cCshr3EtEgTcLEOMT?=
 =?us-ascii?Q?e8jfEzTBJwAG/cCNQn54MU+adIR81f0KLYKfN4SEgQHXF9fOBdCNjNTQbyW0?=
 =?us-ascii?Q?aXaa7bmdri0FNA+nMpXjzn/HtgcP+corC1OwXe43hW76PUztmaohlxxuAI0a?=
 =?us-ascii?Q?CTq+tK2suXa/IQsp4UwvQ+PJWo+qXfyWy8PAQPEW/QYL2oebl3sXgDQS1PDA?=
 =?us-ascii?Q?1FOPYHGkmE0hzlf/3ap0sMPE5xIbp4SMMfit9sA5fhL8lf8pq48xXvr6s/Mj?=
 =?us-ascii?Q?ZL3Mow/pk+Jf6z5+pUMWTq6QDfx8rnmlt90CI+4004xk6tdyBekn9fhXFzdA?=
 =?us-ascii?Q?qqepc55NNwJvcaJgfSt5Exnpa8I+K4peAQDYLhG64Yr0fnXo8TUOnbiQOW9j?=
 =?us-ascii?Q?6MPqmmF6yV5zFmN790lK9LGNY4nZxAvtS8OQuEB+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1015c7d2-9d1f-45d7-78db-08db9e7f0ecb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:34:35.0785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGNL8GI/xfcL44QBX6fQa3X8n6hZEmteb/WIHQdqit+6Dq3Ix7XnlaALaGGEcr9h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:09:20AM -0700, Nicolin Chen wrote:
> > This seems convoluted for a uapi, you should just make it
> > 'invalidate_threshold' in bytes or something simpler.
> 
> Hmm. That'd be a direct 64-bit size configuration, and very likely
> to be at upper 32-bit range, so I feel the value would be very big
> that might be hard to read.

hard to read is fine, it is sysfs

Jason
