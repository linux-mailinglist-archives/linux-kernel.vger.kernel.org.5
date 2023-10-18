Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAFB7CDC04
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjJRMjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjJRMAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:00:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336C4FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5fB8TmUFpBX1N8fd7Rx6MSdwLNK8/3TDJL6O9yer/0RiJnEiclyBikK27k4nAUCisynvrBcxqs+i01RDm5KCdO+DwrfPK3pIQ9N/VosRAHPnASKsi2BRSZVeE8GUckSGEWrYbABhvycMiYTTay2xfF1chUtLB3T1hSlU5MgeYhI1SQHM0PTVcCsw69vVwHaIg6OOOhEKuSI/NeTathyTWBIlTVXYdNXwV9UK2eQW7uglFo6xyIwbPzZ4Gfoq4k/f56EjjAlEyuJkz37AGBqmiicUdq3Vw1ZcGjW9IHSTPb+k1bdfSXnYir3r+S3mz3MsuJrPnvsSh6L1UTOFV8adQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jinj9AH+FXwN7FpP7Piy7NaZeyEX7b9xiGeMSfWx7dg=;
 b=Apkbj106pWlHY5NAEviT/ZCKGNwnuEdaQBaFiJiLZzpCSmFfv+cRRNb2DJSOfDPfla5053eYTVJtJEPBFf2KrWvYjVqS9SQBK6vsdIwugXpE+TwpgQ6bKke89iCK63bY5ZpnK/SNQmSpOMqbXZoF+68CUEB9MtWKV7zbswJQbmDvv5XAxecm9vE7/LWou7dZ7k1GgYXtw6VORc+oJJ8lFpkDWBEaeIva2nb8znXRg+LUpnyWXg9QNH2nU3R17AoR2aP74MtJ9vgAOu2aWyoIk4S2zl50u+Q7eYeAK9MLo/9MhJx8j9Jh3CsfWOTxjo3Ib/ONMRo5FfLdSKKuhnWyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jinj9AH+FXwN7FpP7Piy7NaZeyEX7b9xiGeMSfWx7dg=;
 b=LKQYvuiJ3R33Yo2Y8MqHGffkCN1P9n1W2g3B2Y6zOfrWe2Ow6xRv8qyeYFdYhXoKx5ghfEe3wTWaTsWUwug/2gwydk6e8+fC5aOMKKte7hF8myx7VHl6AHBiJXWQzKY1SsnoNCSB279gFBVwxYANbR35GGOBYK/HKHsR9ZCu4406lLSyDVUDMGOOoZNzmLa6+BHolSNcC/C316o+5F5ihYkAAoMqR1dYztrCeP92HEsIautjwKCo4Pgq7r4r3+fWJ53sAqRXvWxA/NcjEfGIoiEhLR5s1yHHoc5FJHSqG6p0mZ9moHXS/ggQnXKXOxQybBraATBcSUOPHfK4Eg4SKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 12:00:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 12:00:29 +0000
Date:   Wed, 18 Oct 2023 09:00:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 0/5] mlx5 ConnectX diagnostic misc driver
Message-ID: <20231018120025.GQ3952@nvidia.com>
References: <20231018081941.475277-1-saeed@kernel.org>
 <2023101858-underwire-donated-3ae9@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101858-underwire-donated-3ae9@gregkh>
X-ClientProxiedBy: BYAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: d207c14f-8bfc-4365-8282-08dbcfd1d26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QEJgtwZIWa/U1i7H6TtKqjsARQUREFvT18A26Ap2BtSHWItnRqmiPOmWBH9rqjNG66JUZZRv10JDGLf0jkCb6lJOVsyndbcp+nRSGyDWHtYCCOw7/PrL5uNqnGFnL0DZiU1qnFLHlyqx1erkPGddGYQh/eoWqfKHW4S5GJHe7mOaBySAu0m/sl/wjDzM6D4rC3yE1RhC2LuceVNRynWaSePxpEXhF9Nkn5dJxb0bVd/VBvPWNpIZDo0Zrmljij+eB5NNLmqCTKG8k2t6cCdJ0mu5Yu/lgvhA1SmTfA25rdfu3xHLupvse8kYYNDkZsEmRq+U4ziBxyCTQzz+9kOqvfs8OB8zsAclKIPlFgn9NMd4GWfWATHvkTKZaPdOb4/h7xRj9JvJBOVmYE7ffPhJQgCXs6W3vPe7qnUxeAv0OqljuZMYk29aeUfqj61Lfy52lnUiNkKeDjBXx2IAf/GTqAd/2VtEE4lcHnQizebXwaxpPesvCsklYkKTAw6krtrvTTMLHHYlbEI3QLpmDLFBt4vllMyPytQGc8j5YWl4/Ly6JIWGY+1OWhP601aFp1FwGRBPfoabjwV1hmm/jAD+JmYu+YlzLVqHuR9usbvsdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(1076003)(107886003)(2616005)(38100700002)(26005)(6916009)(316002)(66556008)(66946007)(54906003)(66476007)(6486002)(6512007)(83380400001)(478600001)(6666004)(4326008)(5660300002)(8936002)(41300700001)(8676002)(2906002)(33656002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Psdtj9J9wTmHmnLRBBMnr3S91AaLdoF9kJrRHAozUBoZ3DKYfshaMvp+nZyw?=
 =?us-ascii?Q?emzxIuuI0+sWwa894qVJ2KGsGn4twYAbyBIQECSwOY1RoZl5sYoZ2VY6fQbH?=
 =?us-ascii?Q?rL/VcHIp147h0xPJFB4funxP6En+BcFeoJQP7CIRQ4aoiTj35hLdjzaR68Xp?=
 =?us-ascii?Q?frl+V23xGkmRmZZk6lF8NJoiNIebWsuVKGS2vLRJtA6FCmoB1j9kz0sG5y/V?=
 =?us-ascii?Q?CNfwYxIq2lNBAI0/hxGkA2dTvZ8ndncyzrt0BmJDT39bDovanHzdA42O4qfX?=
 =?us-ascii?Q?kUoBQMRoHf+bLJonRPPiDWA6lZjFRVupH4LrcP3xend6pH06EStd1LDTRxjI?=
 =?us-ascii?Q?kysXYIeFgumwusgmkA1tX8fxkHyJfIhoPaqss++u1lpEqzbzeHC6Oji49xb3?=
 =?us-ascii?Q?cvR3B19DhQRxgo275+fLou8jknLKW/5olAPeyKz4mKt2O79C2s8jFtzvsJiU?=
 =?us-ascii?Q?jsEcOXzAOtBAgF5IQ5l/1MzKn9zebwAuDqbGsKno7M2HQN3mmog9nkW7S+Ol?=
 =?us-ascii?Q?+Hb7k0WS13YtS8hKZXC8sCwU1xN+wgNfyYtTTRaKW7IrdkfDexqbUCs898CC?=
 =?us-ascii?Q?yccHNdRNHEyGqhyg0XsI0V+ClbCLwbSnhkkcs1VJl7kV+ARC/Oyaejf6vBLT?=
 =?us-ascii?Q?p5f6mrbsSobmBk8REk4UftQnBUg7aZb3Uxu237mLME/aYmYql5vmmesEtKfY?=
 =?us-ascii?Q?bRknybyjARBZ8ymQ2C+H/g+KUjWlhySb13PyhUV7RLONMUllQfWF1tgj23SN?=
 =?us-ascii?Q?JXL+FhQnRePKUzbh5A9ZyepWIMYB3wn72VLZ0qXz6Fi77Lqj3K3rYsVFZlpD?=
 =?us-ascii?Q?tHEe14M+PfUc8BNf93dsx4/w61tUy/N7hvwlhkq/knrL5JvaLBf7+o6ylAz3?=
 =?us-ascii?Q?T/JyZMVUP4jjX/3LJMvr0ikMj+tC2sbJw7aW3OPlzLYVBFQCBzRuhsiMSzjc?=
 =?us-ascii?Q?yjz8QaRrnCzNrQXlA4ryD+Haq2Rn/2kM4jN1izwphSxcbZnv6694gpcAXI9l?=
 =?us-ascii?Q?h5Or9UaER1cw8wCbx9RHqftmrIf9NJcE8CiiCFPSvCwQqJar4SS76jB31mtZ?=
 =?us-ascii?Q?79QgAyr4I+0h1KJhbwfLclKRQZcYm4ZCvRidyfQK8Kqkrl7PgaQBXMXTFdX5?=
 =?us-ascii?Q?sjmOO9KWXrSagEqgGrArLzicZAXOQl80lHBxKbYDuFtrPq9IX1GMMNi7ceqE?=
 =?us-ascii?Q?SwGg7bBC2zUMOrJOdspq7I3bPX2TZRc7lc7Hez/UaBa+tvAbDep9a18XcSvz?=
 =?us-ascii?Q?AQZV5bxp/hVqmCbMVIr5QWvW3TQ9vpvtZwS2vG3Jairjs6oM669Yx/C5otY4?=
 =?us-ascii?Q?6783WmbaR9uGpzOqHVHoQigrnDtnZ5B4Z2eJDgw41l8u0UC56Dkia0gi29lH?=
 =?us-ascii?Q?0ynkdhX17bI71oA1GViv1Ym3811Qrh8Ay1oiCvsGBZJtsRWpXydvhXnTWbs1?=
 =?us-ascii?Q?g44WbI7QgE99gouWJJPDwgJbDwIkbGKBXzfCiWNsJ11rMuzwCYwkxw9TWvOF?=
 =?us-ascii?Q?dXE6buktguBiMx46d8CouDA5qQPjOFMt4+o0ExJEf1IyBc7KO1FKXVkP1vzP?=
 =?us-ascii?Q?JbAGDco5qFUba+lH8HXl4/S5IImMtMGg+t/p6Xso?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d207c14f-8bfc-4365-8282-08dbcfd1d26a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:00:28.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfHV8XuS/Fg70YbeQsPRJVSh+W+myxsOLQTLdF5GToXWIFgdeF+dfi6ON/mCAL9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:31:23AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 18, 2023 at 01:19:36AM -0700, Saeed Mahameed wrote:
> > Historically a userspace program was used that accessed the PCI register
> > and config space directly through /sys/bus/pci/.../XXX and could operate
> > these debugging interfaces in parallel with the running driver.
> > This approach is incompatible with secure boot and kernel lockdown so this
> > driver provides a secure and restricted interface to that.
> 
> Why not just write a UIO driver for this hardware then?

The old mechanism relied on direct config space and sometimes mmio
access to the PCI device. We did a security analysis and concluded
that approach could not provide the required security for what our
customers want from the secure boot and lockdown modes. We cannot
allow a lockdown userspace direct access to those device registers.

So, it was redesigned to be RPC driven instead of having direct HW
access. The RPCs allow the device to provide the required level of
security.

This new misc driver does not expose any HW registers or interrupts to
userspace, so it does not seem like a fit for UIO.

Jason
