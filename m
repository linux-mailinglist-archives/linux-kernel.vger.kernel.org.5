Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF8C7D6AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjJYMMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJYMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:12:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D68F;
        Wed, 25 Oct 2023 05:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgW1H+6tlUFd/29Xuf66soY365ahc/AdGddXxZ3PYOn9DdgcssoOoG8WK7LAzT+Z806Ey+mcBZOit7HbpmAsCovvOXi/CpW3nv8bPqLP+PmtYxcuO0NSGMQ8YNKmDh7ULMiZT1zUvbIewxz5n+LLRfgGpZFfB50ugqQ5Q6Sc6E3m74ot0afHeQVA4m2YBufmCO1E1XCoD5er/yiSkNPA75x86IuaLp2oPOIH6PXnKP6ljVUns1A938gSm7VfeSMFGrgBNNoZEK0/TtCh+159j+vCcOttwVuZ9oQ4T7QJ2vqlSzT2fG5RjWUnWw5yUa8wrmmA3LV20/dKtjTsqDl7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O4tIlwFPw7JtipVfrkmPO+67wzNOTPJiHv7ns9SxMA=;
 b=m3/fKeF1WqfLEILptzAKMITtYPl+2wC0mQ9Nn8fLzrVx5wz1P+rWu6u2WZZpPufucyXMICWbnmSVK8Jq8tu0fUIjuQ8nrzT9jouq5FRHWeY5Ltqt/8WePx1mY06QSd0Px8tB0WABVL3V8T5mWS2fBhZnT3Ffhg+wyotkW/nNrySTWqSxJvY77hcXS9Ln/kFpI6lz6qg1BxexYYRwNNxQrAgPtBXu1GFSG1LJgJ70sWGi7/wrneNJiJazI580Awg9ZiOTOXrs7BtyZEk10gY1QW4OKcv6KjSHaP/Cw+2dKESDEduLD31Y+HzTnVFmpRsMzEFe8QCsa6iq54exsC/Hag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O4tIlwFPw7JtipVfrkmPO+67wzNOTPJiHv7ns9SxMA=;
 b=oqWRcS+d91DZnexCiYzjgymeg+WlpX1VxBBh9KHfiqv34FIFc2vZP45Q3eOvTWPCm7hG0AqsV1dIZtKbHbL+axbNtjrooQiU8DstKeh/6KIcmeVpwmYQjhGmnD5C0kyEzN0GjaB3W2uEWxjhzHrv/8jlqzT8uz+ZMLzeQjoUZDGmq8/j9UeTh9tYUAUhAOXIOr1Ab8ZysBYs2fwwxRZZEK+3QnuPjE3D0sVA6N/oTGPoGDWpBec0YuaOeyJH0kqIGByFysccI7i2SUufHyLtA7k02wEHnHMly8WvjcFZ5UWrvMuU0wrFDGnLuyENk+auwBXT80J67cz6l32cPvr4wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Wed, 25 Oct 2023 12:12:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 12:12:14 +0000
Date:   Wed, 25 Oct 2023 09:12:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Yi Liu <yi.l.liu@intel.com>, Kevin Tian <kevin.tian@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231025121212.GB3952@nvidia.com>
References: <20231025153455.283c5b12@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025153455.283c5b12@canb.auug.org.au>
X-ClientProxiedBy: SN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:805:ca::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c01a1a-aa5e-418c-89c1-08dbd5539f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NG9RnZOgJrJM5jey0YBm2AjTJv3D9w9H6LS3Bm3LcchSGqLapNOOQGsTh1VfEaN9gn2iijDKz54C2yCIrqzggpWSjUbuPcRUUVT4OcEmYLTXBhZj56HMoM6m93Lan+d0qNUrlqcBk9RYTbJGn1lp0c2HcfIuMldwv338ZeGhO4Q2/cgdlLmwF1OFilC+txZFXkJp9gIn1p3xKFVFq9FYjvIjHaIeZ5hHcs68Nr4CGQdmE7BotQ7NzJ9JDpjf0bgiW2J4lcXz8M/4nNUrxQaP53mhUrns3xcLvcCcerTzW2HFTLeH05RylPILK2B4Pj+Ct6oybGMIdmmcYmnUEcNqaFnolP4Wa50iHvoGn9ulqRkkWvcElBpQ1hK2/EQOYk8kES6NhsGSX6wyMY7pu6JAM43pVdVvQRM6NiX18V0kF3719cMtqqaJ/w2bHXFg5P8pZzKX2v3RfjWvaSnefdlqxuZDYnS7xUWob6znhVhfLY3DjDoWi6Rlqh9WE3pHrRQKLCAuTKkF6OHgu7O8N8TEDy5avEqtKGi6+BtmsjPtpCeggHErsXQp5lX+U/62CG6u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(33656002)(86362001)(1076003)(66476007)(6512007)(54906003)(26005)(316002)(38100700002)(66556008)(66946007)(2616005)(83380400001)(6506007)(2906002)(478600001)(8936002)(110136005)(7416002)(8676002)(6486002)(4744005)(5660300002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VvrYcQjN6z4usbmxIC7sWAj+PBMTpsL3ieBlsCZ+dkq5NFrMr/n/8up3BWgV?=
 =?us-ascii?Q?NA2hAUt+hWg0rFmYtjCbC4Kq2lOm4LEpcnt5k8Ze3qj38eu0Pgo0X6hLxT93?=
 =?us-ascii?Q?sT7tfKUHoxHV/8JwD18BfWBncsNXkVYMMt/k+nUb8hlI/0woB+Uyti+No45P?=
 =?us-ascii?Q?oq4dYz3xMs0WFQUbVqUBVVy+zQka7blK9eF3N2wCCHYQ4zN9pAm9C3sUTEYp?=
 =?us-ascii?Q?9QETZQH0Z/SM5ixFXuarcz4h3XunOTlRESDmNwj+RTv641ePkoHcC9mkWuW+?=
 =?us-ascii?Q?0+JAeINggjq43V6Wd5IuHz0w/VblfHQkQp5q2Hd8P3zcQjojBN9gJMBHQYAW?=
 =?us-ascii?Q?mhYClb+fF6gLirHfOh2HOlTrEk0YQrreYMCWFtcTW0z9vxzkOSUJQalAar+8?=
 =?us-ascii?Q?SV2wyVPZDAvt3mdExKn+F7FEf2CqWRvjKxFBFjTyNsl8zM0HYgoBiX2AddWk?=
 =?us-ascii?Q?wnc8zFn/98V52zI4pkDF3I/smHlexirjrfwhfPP6eL0vHN0KKKyeahyPn2Es?=
 =?us-ascii?Q?LqMCX4p1LhDGK2n/3JaOpp86ePGGeyWCeKb5g58WYEY6zKppNruJnP5DvqYs?=
 =?us-ascii?Q?HLb/6eN7qpdq2Cwf48ZZ8Q4kupjSj8wLGaacYtxGROd2OHuyQs44bboiV547?=
 =?us-ascii?Q?ZRiWLYEodWqAMGr0ZLdMfxvfftqxkyelFzTEYcbKhFs4yWOp/RM/43yyTHRe?=
 =?us-ascii?Q?PqiCRP5y3fSxbNrBGPeZRMEogUQ7+lB/PF+1nemjNS5hWkAkOdGSln2hpMfF?=
 =?us-ascii?Q?bjTqq2aJu9B0l6wOsdOURMPdQ5QCOhP4siOuD77cor4ZYAV9XA9MhXnPxbS7?=
 =?us-ascii?Q?uG0uI0KekBn2yOWlmf5T6bAjcE7BD7XKFQOwXPuR1GU7whXzgceeX1wsQ7su?=
 =?us-ascii?Q?JBBHqKjcWh6vI2B4XYbiEJHrk3o1PaX/X2nyiMotbibnQAsAetkDXYnHsTSx?=
 =?us-ascii?Q?zMpCMQFkKhvm5dmPtocH5ud7++CfZCff3SYW6sW8Oc7SEUx3L6Jq9ubWXBlk?=
 =?us-ascii?Q?cK7RfPdPWTmSlVCRvDeTMX+XN18CLLBBLPZm0qoB0T2vl9S59MEBNfR9nUwV?=
 =?us-ascii?Q?Wf1FKDebs9aZ/ueJHWI9ra1tNO/LDVorULtvdGXEUjvF7M2cDNcNnukNlUBB?=
 =?us-ascii?Q?PNqU18r6rHePAEsvtuyImq9UzmbceoC+wVIPI1lrjLD7+I4WW3KdX1sQhVAB?=
 =?us-ascii?Q?/hpnNQW0GWim/1AD9/TiqurztZsSwbuxwhXX2xHeluDq86ZrBJGGjZAsELfx?=
 =?us-ascii?Q?RLXHa6aBll5bRWmJHzKQzgxbxmjbe+U0V34rWI5bLky+982D7ghuC+3fke+u?=
 =?us-ascii?Q?xhuetOVMJhUADqHfmhxCjhg+9BlNrAEQyNyz8Bok2cMxk35ZDW1xeVSVCDfQ?=
 =?us-ascii?Q?lqwZ3riD/5DtN4X+/quCa3HS9zwunjm3RdDrVuvtwFWo2dylI9fM8afb3q9u?=
 =?us-ascii?Q?HhL1J1uqW1bb3aOrPWG7b+InSyTRPy5gZSmo97grEgIH+sYHs+K696CAbWNz?=
 =?us-ascii?Q?yRaIvaZd6L6QHg0C6/iD1Vef/ZsnfAAcAKOkpKGSO4+5JKVeiTuvLPpWDfFH?=
 =?us-ascii?Q?mwwZNFNP4+VDcI1fbgj0SdULRUnl730li+6Lh3h0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c01a1a-aa5e-418c-89c1-08dbd5539f94
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:12:14.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoQm71dBYfeE/g4vNUtPKWrAeKilN8Vqal83F3gf2JuvIyObBL70DoKhXk0szpjd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 03:34:55PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the iommufd tree got a conflict in:
> 
>   drivers/iommu/intel/pasid.c
> 
> between commit:
> 
>   c61c255e114c ("iommu/vt-d: Remove unused function")
> 
> from the iommu tree and commits:
> 
>   f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
>   cbf8b441ea08 ("iommu/vt-d: Add helper to setup pasid nested translation")
> 
> from the iommufd tree.
> 
> I fixed it up (the latter added a use of the function removed by
> the former, so I just used the latter) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial

Intel folks, this is not nice :( Why was the first commit done at all
if the nesting series needs this?

Thanks Stephen, it looks good
Jason

