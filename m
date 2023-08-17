Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665A377FE73
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354662AbjHQTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354665AbjHQTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:20:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60636E40
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZftHvh0zZ5URsiC1c3FRpLlXaxqRzfnhOqHuP6OACHPogigbMiusJEBlpavJXbnSN4PHzz4addiiFQLLHe87HLrFK72lqtSkl6MezjITs6YIbkLgtPuIlFcY1K/n1qsvUsTZgJ2523eiktjrDUG0nlHU+2U/VWkvdMpK3Ir53phXZDmNMe83lCAxpejlLfy1sU2QDjakQeXlXl+7y/NgSNZN4oTWxRTF4pMq32/Lot3qfXFMcjQwtZ6Ssn4+sViw+jmGxoLuz1y3Pl986B1WwtguEZYatMTIbLVFksdtbljW6LXmOOgDQPp6DWIao1U6LZX1XRB8qVINWU8fykv76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waH5IiglF4TUMZ34ml238If5ki3qbgn5ykg/Nc7YJIQ=;
 b=c46RZYLxBJCPMlsomb+XZM/OO+m8effkUCmMhxEmNrZp5IvX437i0D+ZgZA2f3fL+m8jGCgWSGGXUq1Cqw/MSjdMD8a8Gy6n99QNq9Fw9PdQiz0Zvobok5AaSIVcJRrlWovGqlDeKhJBm32z2dE1y9nP3faDGRX16zsgBuJQgtcxqMXF+GZAEQ1d4kNwBkFZUAu7w1OTFO1GjcW66rg6qcWjzDshXJVGQ8wcV6uKGR2692pLVoywMBSxyWlZQDAPgiQb+azSpCV42OvxUjFVZKeibwxBNMyQ0kOHY5ARj3VHO9iSSs6lYDs217sYouD6Wgs72nMhIsvu2gja2uVGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waH5IiglF4TUMZ34ml238If5ki3qbgn5ykg/Nc7YJIQ=;
 b=czeS4ASLbjW+7GibbmUYJqixwsyXLgYKiVMjy26R0HzNFH8Wjsw2uo5z/4yiLKUV5IMaqrlOH0pJolRpdCTkuCGsJ4i9k7SJgdOSAY8WkzsnK8tjnR2rZ8fhPQHWMg+rSBTwgfQDdAhV2CJWNOVDZxdv5kxhTderC1/tNBtNwW+l84lxRTjJ73n9H1VatBiwuSavFdiOGN5+d5B0PUy5HyESehCKB0l7uSHpOnl9Hym57eBUa92jJyiWMWfkQskFuNMmarJkZrWqahuHdRh8N/6fU8UZYxK99ZKNnVE32Ewf3n1zUOr9ccPrjdMOZejl9wrXAaeUFkpak4TT3xF85g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 19:20:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 19:20:01 +0000
Date:   Thu, 17 Aug 2023 16:20:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over
 installed_smmus
Message-ID: <ZN5y4N8ffSoiR/sm@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
X-ClientProxiedBy: BL0PR0102CA0036.prod.exchangelabs.com
 (2603:10b6:207:18::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: eedff55b-6739-44e6-1f03-08db9f56f43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPtx1Dq97soOqflCtkkqZ8K7RK8A0fgMTFhzrc+PZlJA2cyMevjMcx3yemj5Z7KAoQqk1Gwu+XUBtIaprJn35qH8Ach8tXWsEmhqcK0+uSWZYhZYkaTxEFEzTh3/FaxyXZcon7j43EJhWBVaNMcW5D2Mk9TEzReE7cmsFQzTyMthg/kV0Y+MFfV/3jfXmKTAlauQDPDbSrlF2wAF3gLgAh0JA2E+ruVnV/M5LNPYH1wsaoX+ppp7ZpKHO3Xg1fNrkzfeY4avip0o6UwM8OEN5/qrYg4aLdRjnJVPAssdccF0NofxUuV8t2zqQYir1kDE3VEoCgKVcF77ycJ65o+And8cB3wqObDImLCZs7+8Kv7KHf5YtIuuhXxfP/D1Cw4pk+ysb4lOx6hSZ0CDKADnWaY6Pmlm4kY4myGtdicAq6g/yuwlCgkH9H2nB2Sx+vYHcnwm1rNIz69kU48CYa/MnnDTf7x2O/2V4ldk4lVLa5BuEOh8XHGraRRGv+S6WNcsN0T3xFuxFRkmaml/wMwMXwe7AZaLlyXOxtVO0m1tOOIMxvs8FDFKcKGN5N/9pdiG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(478600001)(66946007)(66556008)(66476007)(6916009)(6506007)(316002)(6486002)(5660300002)(2616005)(26005)(6512007)(8676002)(4326008)(41300700001)(8936002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tn2X5UroJrtL+LUCSbZh2slC4dR1PC1yvmQJA3hMft/H5JTr405kFYMwUNZx?=
 =?us-ascii?Q?TM0wQSelAsJdnFDhKf1pQUi1ygK1rOcOvcsENUqDAemIo3ASkGlxGXuBkJ8l?=
 =?us-ascii?Q?eo9YFio20BxqKDvykIekbi3ncF0lOKOhj02L6qiQS85LuYiZtTDCReAHJBnN?=
 =?us-ascii?Q?hIi158LEwt85pC54wJDr3P1KYn5waPIEXcrYi1my3wBa3Tmu52oAhwJogbNb?=
 =?us-ascii?Q?sEO4oSUAbWmYFbvK7fVSek6rJ3FufYr33Hcp0ifoid20JcX2qnQMLVxO0XFo?=
 =?us-ascii?Q?cQIgCRh+sm2xJyMnKhBZVqGNdtztFbep4I727ap4BUwLR6JhEfw/Ugcd5rK+?=
 =?us-ascii?Q?tKNxh7Z8DvFCnVzLRiF0SjLwOaFd/ZCKfqQuYNLl95i1vcyaJzS6mwtxuI3I?=
 =?us-ascii?Q?7vMoEcELVKnel09/Y7+aJONTuOmDLZVcJMj3glbVHy+DAr+zJhs4Pg3waDsw?=
 =?us-ascii?Q?nQallOrrp2WSex7Xb0aukNQrOh6QlaJjBf2PPfx8GppPeh2vGpKxQ3Y5qiwf?=
 =?us-ascii?Q?AKrTWif4ajn4wQMgH+BtdhAajEsg8yMONkIJtqOZMRBLobg7pkRW1B3g1XoA?=
 =?us-ascii?Q?fVaiy3ctuCnPKfAQ3uegOr/VfC+XUD4L8hl6ySnzpw9H4GRaOlLIvmSHUCSB?=
 =?us-ascii?Q?EIQ4CWqrhg+2Ct+S+0HMqklW97Y6MMhE2wrNepJZkgxf3wc/aYkzj+Zf84cs?=
 =?us-ascii?Q?fgk7fF3DKdlX3IeRsekPNWitKKz0b5pXfUd14l79GcjVWB6gaODe7ZsBBOyB?=
 =?us-ascii?Q?/rXHLGZfotI/IhD7ZHyb2K98dWHSSs2he0CghH7Gozs5jRFkD/r9JJxI1JQS?=
 =?us-ascii?Q?thp0n4iWQMy1xsDWte5iYpW8aDM5XMrHxENqMuLFZC1fuxdxCLjYgG74VYBy?=
 =?us-ascii?Q?oo4u6F2pS5MJawQfMFGyGLPGJhKqgjO1Q3l4cEZfefkDT7/51Xyn046/zz+9?=
 =?us-ascii?Q?9HVS1Vo+KogNQl8R+yocd697y5WZUB67oqIVhuuzKyRmytFEKHiaqD/sDB8k?=
 =?us-ascii?Q?UxGxzcWUypAbr3qI7V80OrZjILkNzbRRNej4eunDhDOnNyEQ1MaYkFNlIAV0?=
 =?us-ascii?Q?M61qYhsji0R6DTKG3X+HlZI9xWbBWYYdcXuL07odeCQPGu2tf+Vacr3GvnL2?=
 =?us-ascii?Q?q6Oj47zT6Nklx+tz9Ax6t/wD1NjWjLkYKhfvedoXqsJlpEV2gMJav48GHDYD?=
 =?us-ascii?Q?pvhtEJnR+70CMRRrO07OLJl+xvJHTcCwrlwjUvu0jGP9dTtsWGenP6NJcGrv?=
 =?us-ascii?Q?5f07glq4URpGNqc2c/BhyoZcp+mV40S6SkYE2hWfkdxFvwh+ItQoxxHRDvaW?=
 =?us-ascii?Q?NSKDvUbuB08jZhjko12IcsjQcUyj26/JxkwmUaHZqfcZJGPFAGEED6JCR058?=
 =?us-ascii?Q?4ZKJ2uB82wyZF5/LYWSwEXKPXjlh49p5rO/ntvAE9/wANizhq4tD0YfiGadm?=
 =?us-ascii?Q?Bax/W7e7bW+m0rt51qR+Xv3jvuJIvTzEP3iZjOMpmfQIyyuMCLojBVa2sjmE?=
 =?us-ascii?Q?n2q1+Duw7zjuYEorgt/JBbefgbUyrsVcsXoEEovbP5PIvOS/bKw4IdvugR5R?=
 =?us-ascii?Q?Fhf2+KKb+pvxm1ML1PWfH30EW0qAO2EYiUYgSmvP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedff55b-6739-44e6-1f03-08db9f56f43a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 19:20:01.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NO24ZwLeulbrzIx8gNSTXgG2s9sC+kdnX0mQ8z2gGXb7gmCTgg2CKCrpXuoVUpds
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:16:24AM +0800, Michael Shavit wrote:
> Prepare and batch invalidation commands for each SMMU that a domain is
> installed onto.
> Move SVA's check against the smmu's ARM_SMMU_FEAT_BTM bit into
> arm_smmu_tlb_inv_range_asid so that it can be checked against each
> installed SMMU.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> It's not obvious to me whether skipping the tlb_inv_range_asid when
> ARM_SMMU_FEAT_BTM is somehow specific to SVA? Is moving the check into
> arm_smmu_tlb_inv_range_asid still valid if that function were called
> outside of SVA?

Logically it should be linked to SVA, and specifically to the mmu
notifier callback. The mmu notifier callback is done whenever the CPU
did an invalidation and BTM means the SMMU tracks exactly those
automatically. Thus we don't need to duplicated it. Indeed, we should
probably not even register a mmu notifier on BTM capable devices.

It is certainly wrong to skip invalidations generated for any other
reason.

From what I can tell SVA domains should have their CD table entry
programmed with "ASET=0" and normal paging domains should be
programmed with "ASET=1". This causes only the SVA domains to listen
to the BTM invalidations.

Jason
