Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C7C7652EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjG0LyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjG0LyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:54:15 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0910D272A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=levbpftPR0RnkP22GarDBKMu9vQbeSPlv2b9oA9bLvWSv3Amluk/ZN8Qd65pGSJfZXdhXcQM8HtpH6XfvqaB3ySi9++1yZOhAgOKfdk1jZo27/gRKX/HKfiimURGyTsEKVkxrWuCekl9V7yALZUymKC4U5trwLgTDSUXPtIrPAwUup8QKBVgoqVf5bdFR8A2Ur8o0PalbE3F4RxD1fBL9Zr7M8gJAb8SM6Eh46nDsr//AeVyVMrO4C7sYLVDEoLAHZlPRiFIpK5mVuqXIhacM1BnGITMMrMeEhgbeJ1NeRwPd6UgCSq0/9IjLxT13XIBe0Mib8Q4Q0ewyP3xmB32rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYxchqoz8SRyKqbBj2EVQ4Hz4x+pFpI7xzw+wDw1llk=;
 b=S/cX0L4390ugnlbYfea/RCo9MRG5FLV2kPjPQC3AnT6bF2lkOzx6JvxJDSNpUoGNPddv+6siKg+76i0fhh96VgIBKOpEHpjolLr3U/PqOUQtOwfhqLOdWURmg0bHEpEm6qXN6bNDx5ftvPj0XlMncyzoQ+EO7gtd1V/KN7AVpSmfzsAGDPrKtJtBSIITCHaE0HRcy8E1FNrlywj2w7/DMKxL5xJMDtW+SjHCwC7M0gqS3vYh9nVckqx4QNCP69okm263cvmDYhGLqWcZlwjSgkz5cMMEZHkr7Zziu/d2wnc883PiIk1r4LDlieTFndWPI4O9yTLX2qK7BUP1nyhfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYxchqoz8SRyKqbBj2EVQ4Hz4x+pFpI7xzw+wDw1llk=;
 b=uKwW2WcwijIownHuc+liioy0YcnnQdHUVJPLc/cBbA02QEfX5QwFJzEIKpubrJ2w/VwUwAN6eyDwsWGFUcn1q5cusJsJ5v5oyrtggVNMBBsIzAKtGy5uRi3CLUuBzUdmyUotM2vjAHkG4EyrTepS0SR002ScxVMdftWsIcqL/pRPkGfo5uC5yz9HoCk+K6L3qcdkwtdo5WD8pK2aOBZU/GV81hFAWqrz1k9GVbOX1MIJGrJ//OYlUw61rPBZO5N16YOPxLJpXhEl0pK0EgDBM9UxONPUEgGQV2H28lu3m+eUM6SBGrcRmbfMt6/YdYjOmhWLYuJhWn1e37Z9N/lbkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:54:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:54:09 +0000
Date:   Thu, 27 Jul 2023 08:54:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZMJa3kGHD2iE0/za@nvidia.com>
References: <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
 <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
 <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
 <ZLFLyh1b+wiqb7Ql@nvidia.com>
 <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
 <ZLU0IZJr6WSjknHf@nvidia.com>
 <CAKHBV25QZn9xApRT+=oAtwQRAjCD--S46uXRDwW+E5=at0ESQQ@mail.gmail.com>
 <CAKHBV26sRpFJv8-_f4n2jsTKiOgnHF0_FZ07KBbVaueX+T2kWA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV26sRpFJv8-_f4n2jsTKiOgnHF0_FZ07KBbVaueX+T2kWA@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 2772427f-8fb5-4173-e655-08db8e982fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dc6Mmt/+7j5Idj3JgJs1MOeGiQmjsGVDZSwi1jv8WCc9DalaDQaXSnD/N5LI5tl94trnhAD+NGgucDtE99RF6crLlhpwxlK8HcM8yCUXb0BEwFODf8qtTMNOEB08edeq6u4HwQGfYE/d8xoT9JXjlnRqtW057Vo4gm7Sl7YpmY4TNBj7RV+L1cyrGCuJNms8Pzs77/3WlXWJutc+WzSgE+Eob2t0Daf8n71eOgy/xjjM2wIMLuwhvqgJYVtyg2vdVw6ig8R/WBCV/fWy5X0D/DrxyqNxoPQHYsdbvlhkDVn9f6CBAAjXjUC7Nr9USVIj/KBtS7m/cHrMqHjqIiriD+o27uYIxs/Fv+rleqOZ963HIqvul8P11cRUrrGZmd+yjjYnSS3QVX14W3cXaaQu+Z/5Lk2CBLY51IP0zprCLM0EgS6QoD+cn0nGqBYn3+Ktk516hKPEp/XIYZ5oVYGhNKUNO0aVmDHQkd1B7fAsBMhCfT1NO8oT3AOsGZuTKk8Sqwwc4cUtG+EnlPm7xInhByF1YBdP3E+45aeKRtCvIQHQHbVfqHeuDQpkmqHpXs9b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(54906003)(6512007)(38100700002)(6666004)(6486002)(478600001)(316002)(41300700001)(5660300002)(8676002)(4326008)(6916009)(8936002)(66476007)(66556008)(66946007)(2616005)(186003)(83380400001)(26005)(6506007)(86362001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yTOfb7tzwHO3DBB3Q2PcNo/gIgDe9uNq9wp/o5zAnGWpRp8no1NqWGwy/MW0?=
 =?us-ascii?Q?oT4BJPksNWpkc/8y0N3UKg6C7an3VYJQLfEBP8PyzBRJM1MeAfddg8nSsh9Y?=
 =?us-ascii?Q?GIBhTIOz0HEBILhHztsSMW6g3gqOuYz6niwLz/UGP9I1iDSF7nrJsBvvL+sO?=
 =?us-ascii?Q?Dnld5GDP1WUEdg66XeuJBbTrhb7MK4IgcR4nDFI2azutsTCJA6ongtAO3slG?=
 =?us-ascii?Q?O6+gGBOMF5pkuhrB3TCIox7t/j0M9V9DUU4zhRtBOg/bRAmLdFWO2qlkk8mp?=
 =?us-ascii?Q?U4pYKTeF94EtOKnOqfCZtmOi9IcvmCefZ3sgVEAwK9JgT5I+7FCl6jp5yamW?=
 =?us-ascii?Q?JFVuKKklZ7Bzzc6wzDQ7IjDpBFoL3SaIFqSleFUlKpGDi4NWyc1uzQrxuGO1?=
 =?us-ascii?Q?CKbQdNNr9n8m/L6FIoQiqaO1bmmx5KLB/vAwngemodbfMe0n0JglZokYKy3d?=
 =?us-ascii?Q?7LzgD9d7iQ8kjnYc1E2lj/4YPu6cAz+0BEaPaEBDpFhyOPlymX6DulM3rdym?=
 =?us-ascii?Q?lWuPrHboX2IFjjL1XPPk/786Tn2XJoHcKV/1EO3/D/4zPgT0Xz6Aqm/9Yj+L?=
 =?us-ascii?Q?0AYY5n3lpD7k3cvTJtxLnDIwWNCYqtOvbRZTUpJJaG9cY3lqFo7wDwoSzyb6?=
 =?us-ascii?Q?BGFBBd8QLJQ3XCTl3aRos0VGrLK8Q9FJelsES07zlDPesbeSEyTDxF8dmFY1?=
 =?us-ascii?Q?Iv4FyKJUGmh8NqkvlTnlATuXXa/mia7ZDkkvf0xhV7NlaP96dJBcZI5dtdPV?=
 =?us-ascii?Q?LSzq+14CuQyh7QEC/ru6xPzHxodmffaJkgu8RkzCF2yDKuNWEk/VWxoxbPmr?=
 =?us-ascii?Q?FIQSy+TE1X8lRg++2PIYQ2KORiEvPdWpsRmllgAis+qp+ZY6Fe2Qr5Gf5yuW?=
 =?us-ascii?Q?WZFmvIBxvDhb8i9LVNTIpOyE7VEolUvYA8HMCEX0/pi3+bBi93IebzrBiGGk?=
 =?us-ascii?Q?1qqpiOsxXiFRccXJ3P4yvdjqKMuR+nl0Cfx+e2Jey+L4CN8yKwZwYIhgS/Xc?=
 =?us-ascii?Q?CRc7fv193TYtEO2Ow44LZgpkXNaaqQ7UFdaMfGw9Wy1VNzcrIWN49yK02RpO?=
 =?us-ascii?Q?V8zFzyobaFG497GDZ25oFvjBL4KP4w0l2wlV48weGU0lNr5Ku6j8wiaqEBz3?=
 =?us-ascii?Q?nOnB3g9lRQN2YWnKnpvbAUCHXZuBWqDDqgZ1K2pwxWMldFEuqocadNoLFBP7?=
 =?us-ascii?Q?mrTsonQv2b27lXfGbK4gMoygnr2ZUULvn7QLQ5u9WffaY0HwXTI6NgUWGSO3?=
 =?us-ascii?Q?VpVYCBFqYTbMRA1e3C/pc4mENpITVJ3M9z3A4a4cm1AhhFSbP9F4iSNSx/uO?=
 =?us-ascii?Q?hYsbRcUm8LV/ySwt4r4mN+Xvq9WKoSWWV/DOns5/vC1LXMP+KojQKLf5TGw6?=
 =?us-ascii?Q?mbCQxQif29SYKHjfCaZwzZ45HInhTRGKo+m0r9XOyMwrliLpfqT9D6uqdRkM?=
 =?us-ascii?Q?EYZDgm9jiVPlO7cAI96+wVDe0QSS8uQclDrKIzNR3C4B2M05FPo/cRfCDaYQ?=
 =?us-ascii?Q?7KjScUoMG4KjvJKw8iHqhNvdIIDJQ+NeRqK5ws0yae0vgCcXCIdCPup4gDLc?=
 =?us-ascii?Q?WuBd7bccgg8B/CLlBKpr5lJHbAIyfGwqvxEbaQZA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2772427f-8fb5-4173-e655-08db8e982fae
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:54:09.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqnNS7cnDI13JXY6jTn8vtjIy8GtpZcCDaeyTQ3k8HpknxS3puZwzPxOSqkVW8L8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 07:22:05PM +0800, Michael Shavit wrote:
> Sorry for the delay; I'm trying to refactor these patches now.
> 
> > I think the master should have a pointer to the iommu_domain that owns
> > the STE or if NULL the master should assign its internal CD table to
> > the STE.
> Just to clarify, does the nested domain patch series require writing
> CDs into the user-space's CD table using arm_smmu_write_ctx_desc()?

No, CD entries in nested CD tables are written by userspace only.

> Or is there any other requirement for writing a CD into a
> domain-owned CD table from arm_smmu_write_ctx_desc?

Not that I know of.

The only time the kernel writes a CD entry is to the shared CD table
stored in the master.

> 1. The CD entries STALL bit value in arm_smmu_write_ctx_desc depends
> on the master (e.g. if STALL_FORCE is set on the smmu device). This
> could potentially be encoded in arm_smmu_ctx_desc_cfg, at which point
> that CD table is only attachable to masters with the same
> stall_enabled value.

For cleanness I would orgnize it like this.

> 2. arm_smmu_write_ctx_desc must sync the CD for the attached master(s)
> in the middle of writing CD entry.
>
> This is all easier to handle in arm_smmu_write_ctx_desc if the table
> is always owned by the master.

I think it is fine if you start with a shared CD table being 1:1 with
a single master.

Making the CD table shared between masters (eg for multi-device-group)
is a micro-optimization, and I'm not sure we have workloads where it
is worthwhile. We already block PASID support for multi-device-group.

Though resizable CD table is probably a better place to put efforts.

Jason
