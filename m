Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0817C6E57
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbjJLMiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjJLMiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:38:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4B410E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM0GoR7aY8hNkePlU1L2ap1jFPpIEJnkSUezAZ0i8SCoVmm1By0MEMbF0Oj8RKLnapXdzmSarCXRR10C3eDtegba/AdAPFoTwqMzCdZXv6TBciLohPKf8Cgt7CRlBhM3KQPcK1qHJLjyepnKidcFBoAdb/7qmQMT2tSr5nK0b4vX65X+KjdK38Zk2PB5BvACw/UNLLN4oSw5WaGeAuIWUQOMegHjAtyn2zjCUGufVLO9V2Q1Hl5/KFHxDPRQnzB3chZY1jvWHc6CGmliuuVtaSR389YfQ7C9KiglH54G81KPP4p8o6LD9sxuMR58CRD1/AnK8PKERZbtmgiz8/3opA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vmtfy25K/dFkJEmqD+D4PhgNnu79u/8OHJx9c4fKGRg=;
 b=JTk7c+s5fs+ntoq9u4Fo5WqAOJCud/617owsab5sH4fmu6MdeI5UuWKz6u8y8ROksdvi3vTjzYq7SxR/l06SYVefwHSbbWNyn53epBbjgsPwbO6zF3w37UapSewrgz7KPdHIEOxj4ADVKughtR6OkTmeE2SnS6ZZHgV7TtIlLtmtu1VkXMLpOtY21FNnFYvi0cZBwmWPzKnw5LGcm+XmO9mbrJ2DKjy5J0lz/cD7Dt3K0nDPCBbukjT91dyJOBeEUtlivTgqLHpi0QSFe2fuPUmzHaYa8V65ZLHgNIe7WeqEkfw/cyjqdH2WQaBjl0b13607I72cn4HeM7Nzp3hpgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vmtfy25K/dFkJEmqD+D4PhgNnu79u/8OHJx9c4fKGRg=;
 b=bRsD/TRifn1d15qR7VrDXMebH2kXIhcCweHr3+jJzRwfIP6c7zUrdKUmBcAIz+W35VgZONk5W4w+wuGXyyDBGRY27NcZGmHIiv76bq0jZudm4S9Z8aZ8Isn1rs0LF952LiGZp3Ks0VwCbNDfQYJpYvooU5dXTjzOfyLxA2moix+BuykvJdngg4LYtFYkTwHT5pfSMjKGmgdFfbZFByVMzmBl2suvU+CfSr0zTppCIk87IhxH7y3hEFsG9h6gaNEwNqgElyA+bpvJMGXi7wEX0FmWESh8xGX/wKiK7t6b3SSIT/DsCYboh5fHUZcaR0XIZYfoHNqyTwVcFyf+TG5kBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 12:37:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 12:37:57 +0000
Date:   Thu, 12 Oct 2023 09:37:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] iommu: Decouple iommu_present() from bus ops
Message-ID: <20231012123755.GH3952@nvidia.com>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <6711338e24dd1edfd02187f25cf40d8622cefdb2.1697047261.git.robin.murphy@arm.com>
 <43ca2a88-942e-4d65-87f1-30a7cf537edd@linux.intel.com>
 <42bbeab4-84f3-470e-bd42-2dae31b5775c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42bbeab4-84f3-470e-bd42-2dae31b5775c@arm.com>
X-ClientProxiedBy: MN2PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:208:120::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af437ce-44d3-4ce4-e144-08dbcb200ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Uellmcmj4wURvY50IZ5t61pb+WkHTg2k45gdiNC5hGtuRFk5y8ikhS22zDjtZEB+qVTpjFvoEUxYLA4/slboFGTgp5QLgY7qtgvPAtK2VpWnAooxj44XAuZ7BecRAydn+1h7XOBmbY77tBYdUZMNN51HMh2WhcuCd4fPgsG7PzeHbqS18aTQ9ZX4M5wToOCjp7lZL9PY2FvzAC04iRMA3rArnFnl8MeckZ29J4TpRIpF4eZ8zg7tUIhslgIqARNryp2ifw8ibiGOFPaUZcdPM+jj3kE0lheU51j3ghKUg84p+bxS1p/vKeeCG0cJFP2zFk59iq57BjPRUBsM0nX/RcaSwPeLsvaZKNtiMlMLWd74dqhUOWql/crgbxhlNYL2TiFRAvh0A2VaIcmgh+UF07psFop1eeuKQrOU+I99b73YI1xBACNo7PB4atNT1/OhKGgv2InPIu+S3VCXt4+BSEKPc/jvAVQXUfHA4wG2Oim2x5HrCnU0jxtHij4rUKwo5TBjEBCN/zBqljB15Dfpgh3899kPMT4uQdLz1iTc/YdmSeA/N2Z1Rk3yZKSwbZx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(2616005)(1076003)(53546011)(6506007)(41300700001)(316002)(478600001)(4001150100001)(2906002)(5660300002)(8676002)(66556008)(6486002)(6916009)(66946007)(4326008)(8936002)(26005)(83380400001)(36756003)(66476007)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUk5Q29ObVE5SWJnNDR3UTFaSXZicGN6S3ZTTGMybmpZQkFsb1NyV2xwbTJn?=
 =?utf-8?B?NWhDZ3FKSXBxU1BKOEhuYzExTWdmdDJyUlJzT29Cc25hcWdKWHYycGZJRTdU?=
 =?utf-8?B?L3NBMW53Q1ZPalFEbEN0REplS1hZUWQ0S0VSLy9iMTVCUVJ5d0JzNzhlelBG?=
 =?utf-8?B?SFMydXNwRitWV29nUllRMFdyTjNDMVNEaXhNZnhVcWFaUVQ5RUhCT0xoQUgr?=
 =?utf-8?B?NC85QlFwbnVZR0RzKzRwYmhybnZpQXFDY0pUL2xlZ0VmNDA0RmNzL0dZTW9D?=
 =?utf-8?B?OWVGWlIwaGFiUUIrbU85OVc1TmNWa0Rxelkxc0FzbElYQmd4S3J0Sk13cGNS?=
 =?utf-8?B?NGV4Vitxa0FQZjdMTlVZZU1tRjc0b1M1aU5xTkYrWU0wdHk3SVoybXNTNWQ1?=
 =?utf-8?B?Zk5xWURibHVqWnhaRmVpOEdONXJHRmRvYzd6YTFLbWs2dm8wR3htQjMxMzF4?=
 =?utf-8?B?MUdySWVIMlZoTzl2Z1VMZzdXcHpnaDEzN1hDTnZMczA1T3U4d2thcldteE1R?=
 =?utf-8?B?RXNxQjZxMTdPS2RSeE50SWRMd2hScjVrMnIreEF4aEpPQXlURFNORXgraFAz?=
 =?utf-8?B?aHNnQTJBem5TRSsyaGxEb24xN1NrTnU4cGJpc0RGajEyTUk3bkc0dzdMM2c5?=
 =?utf-8?B?U3V0NEUvTU5NaUlCRUpWSWVxa0FQVDd1cS9hdjh2MlI4c3Y2RzBweFNNanJn?=
 =?utf-8?B?YmdYMnJkZUhTNWZDYmV2V1lEWVhBd2R1R1JEMnl6TXVXaGdmaVhRbFVuYStY?=
 =?utf-8?B?dytzR3NheGg1R09hdzFjY3g0WUdGT3k0cnB2amtIcTRqSzZBcldmRnU1V0Qr?=
 =?utf-8?B?c2tubEhmekg0alpxaHgwaFUwbmJSL0tGWFgvNlpEbFh1UEgyYzFnT2pRS1hQ?=
 =?utf-8?B?ZVZRQ3RqVW5icmk1TkFKWC9BYlVucm5OTFNwK3I3VGZvTngxWEhpYmMxalBL?=
 =?utf-8?B?aEtjZEE3MkRIYi9odE9lS3Riemx5b2htZGxwdUsxUkZRZGNwZzI1Y08rNy9y?=
 =?utf-8?B?YmppRDBZYUFZbW94dHZKTmxMcHJ0czhwTXhUdithWmxxLy9VeW5JVk5XV1VU?=
 =?utf-8?B?S1d2RWpYazM2OEJmUmRjQWVBN2lxUitiTGZEcTJtZW8rK0UzU2RZVDJ6OWFH?=
 =?utf-8?B?YStlb2RPN3JZb2NoYzRJQXU4a0JydlU5Vm5lUUI3MnE1T3krWjRiR3JOOFhC?=
 =?utf-8?B?UGtsMWN3TlMxVE1Rd01XL1ZsRVdRWlo0TW1OUThvdXRjcEZBOGZvMm4xMW10?=
 =?utf-8?B?dElYYm1ER0oyZStDNkViUm5sUTR3Mzk2dTNPc2t2blUxbkNKQW9XOFY0L1VV?=
 =?utf-8?B?ZVZ6THRsTFZjdEhOWGNrNzVkbVhNZWVsd2hOTFc1S3NrcnNFT0U5Y1hQSW9E?=
 =?utf-8?B?VkR0Y0tRSXZkbFg1TGRBbjJ4cVMxbmpGTnozY0dKZTFaL0JsejRaMm00NHFX?=
 =?utf-8?B?WjdsN29uYVd4Q3k5R0VNalNsdDFkcWdpeENCTFV0N0dXRzVJTUVhcWJmckxJ?=
 =?utf-8?B?ZmlKY0N1MnJkMHZUcTJjY1dQaC95VHZyUDdESWVzK0JEOHRJMllTeHZzNFJ5?=
 =?utf-8?B?QTFidjJOQmlCYlQ1Ty9PSEgveVZacEkvVGZPUXpqVGZxQjdNNFpYTlQ1a29O?=
 =?utf-8?B?Tk5DN2RKc05SRDFMcFNyT3V3UlVXV3A5YXdKa2ZhQThQWmpJOW84OTNVVXhx?=
 =?utf-8?B?UGtwRkVLRko1WVUvQzRnR2hoRVNGaVYyNjFIeDdXVnpaUU41S2w0Ym1IYzNF?=
 =?utf-8?B?L1FSS0FCUURTYW5mVVFxYTJhNGt6cW9vS3lpek1JY1RZekVnb1pZV0RGOE5l?=
 =?utf-8?B?OWEyZWVnMGd3eDZSREtWSFJkV1RWU2hzR0pPWVBhcTlGVVpUbDJxZFZiWWNM?=
 =?utf-8?B?Q3JZNnlwOHppV20yVnVydHczUzF2WXYrSnBiUkZKbDYxekY5azREelRHSUU3?=
 =?utf-8?B?bTVidFJlV2R0RnRLMENTMnA2MlNTUGp6c2Z3aVFVbnRIL1JCR0lzWFgrYTJm?=
 =?utf-8?B?dkdJNXNCaFplMC9sNmZvcEZkeFRkUS9UUGFFYnVXRnJjcWNRRnR2cGRHNUl3?=
 =?utf-8?B?NHhERlVSY05WLzV3WHl3YmxFQXJCeDZtbk92Vlh6MjV4Vkl5ZDVTakdVdVNy?=
 =?utf-8?Q?OJKlZyLvmDYBiW/1cnMvUC7Ch?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af437ce-44d3-4ce4-e144-08dbcb200ff3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 12:37:57.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yqob9pNeo2q69q0Mfgw1GPyRX+65SaN2OyCQqOeOUoDmJtlDdrrn+HTfxSTtl0zv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 12:40:01PM +0100, Robin Murphy wrote:
> On 2023-10-12 07:05, Baolu Lu wrote:
> > On 10/12/23 2:14 AM, Robin Murphy wrote:
> > > Much as I'd like to remove iommu_present(), the final remaining users
> > > are proving stubbornly difficult to clean up, so kick that can down the
> > > road and just rework it to preserve the current behaviour without
> > > depending on bus ops. Since commit 57365a04c921 ("iommu: Move bus setup
> > 
> > The iommu_present() is only used in below two drivers.
> > 
> > $ git grep iommu_present
> > drivers/gpu/drm/mediatek/mtk_drm_drv.c: if
> > (!iommu_present(&platform_bus_type))
> > drivers/gpu/drm/tegra/drm.c:    if (host1x_drm_wants_iommu(dev) &&
> > iommu_present(&platform_bus_type)) {
> > 
> > Both are platform drivers and have the device pointer passed in. Just
> > out of curiosity, why not replacing them with device_iommu_mapped()
> > instead? Sorry if I overlooked previous discussion.
> 
> Yes, we've already gone round in circles on this several times, that's why
> it's explicitly called out as "stubbornly difficult" in the commit message.
> The Mediatek one is entirely redundant, but it seems I have yet to figure
> out the right CC list to get anyone to care about that patch[1].

Please just have Joerg take such a trivial patch, there is no reason
we need to torture outselves because DRM side is not behaving well. :(

Jason
