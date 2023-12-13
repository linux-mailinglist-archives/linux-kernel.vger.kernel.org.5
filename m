Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB888113C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379257AbjLMNz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjLMNzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:55:04 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBB2325E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:52:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0rIf6Fx3nsPrY4oK2Gs3lrFAGPkutcmPkp+6U8cm44PBKN44U5a0c+T9TBy8BDSRg46HRCr1IhmXTcWL1lXHgys84it4a10HKA+xAIZtSHILyeAWJhrsMxcFm5Cx4QYtWjNXpTFuF8i36QwT7GWkoxcbFMegzYbPmkmDH7jGxVQoFMEPySU+MtNyMDE/CgA+S2tFo5wX4x1TmTKO9sHjUEBR+msDDDomdiUqmRob6FmKerdaLp0Ae4sIX9zwx4rsO33J/JMrMjXj9GION1JpuGSo/Uqw3Otxn3bfuNedmyhgRxiya86qzSxWiWpFkxGQbbmJTyIJKOjZB9FHsi0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2CRgq2UCwRa9dSKeecIRcmiltKp/KoraYTrZFnv+Cg=;
 b=dY6pEvOYOdPV+967FVtcaT3MMoH/0kM5rBhg89xv4dQD3BisB6ikhs52M4buWUyqxULcWkcbosuSa3PHAhCBYT796R8vkTPqM7zX8z0ZL/346c/aTz9lzJIDen2eDOdXzOLutCkU4lhV2B5+wEwqnazS6wUzREU/RI+3dDH7fWsHv7IEb7tRS1sarPRZb6YXn0envT5Gxidy3Lsxujw3LJlIM09765ONhjP9wTQJIMOluZel4fz5DR85+mS4i2PcEY8GfkhnrWQR+JoOch2DU3kA52AYFuMgGPN1TQ+M/x1w6eFcCM3bUmQl8bJRG0uYU/jFuO6L1XP1PH4WCKILng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2CRgq2UCwRa9dSKeecIRcmiltKp/KoraYTrZFnv+Cg=;
 b=gaK5pJXckIn/sc6fKgaMKULw/I6dOUfIMM3MBissPB6Fumd9SX7jpupGyNDzKfGUdgAYNOZ84y0iYpf9YLHV9Zc+Vu4O42CQBJGNn3VcLIXts6H78z2mq5FJE9jpPRXVOjLCxYyCx+dX+BhDkCCBCvTpD4j657fPYIapQoCwKA1p0ckA4zmgMHXZHOGzMOeFGBLFmguZQ85s1X+WH2CZiyDYcZlkTbdivC/G7/arco4EWPFuV/n6fO3rEG3IHf+Vknynm7aM7UE+jf90DU71xqfHnkCgVfr6G198Fwry7mUTLiM9ctwtVJ8HvCsnX5VcwPxI24oPQu7MreZg7H6ktg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:52:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:52:07 +0000
Date:   Wed, 13 Dec 2023 09:52:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, yi.l.liu@intel.com, kevin.tian@intel.com,
        nicolinc@nvidia.com, eric.auger@redhat.com, vasant.hegde@amd.com,
        jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
        pandoh@google.com, loganodell@google.com
Subject: Re: [RFC PATCH 6/6] iommu/amd: Introduce nested translation support
Message-ID: <20231213135206.GD3259566@nvidia.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212160139.174229-7-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL0PR0102CA0064.prod.exchangelabs.com
 (2603:10b6:208:25::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: ba22807f-3a96-4e56-a759-08dbfbe2b211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbvAwN85RGSSvVGOPDALEE2roaQ37hX1IxtIgpEnuqRuep+2MQfIzmiqvJtv2azOPga8O4zjOQ0PoflubDVi+zPGNt8PeR4XIHWIGnJGJvjkdzAOxcNvU2NObGVRcILSAed+VZ/8huH7IRpPW7M+B0hlqp7Z/Vw2k8bRRB/lpTbPaMLqd4edTEZLsNgm3Mf0Ah86PzEoW6zcKGJ4Je2XAqf1drV1r/TpOau9LXHk4Ysag4GYoD6KSTnLJx3Br9PVm7eBRT07qwtfjm3ZgNLlHypA1QCSRCYD7LFoiKRUTZLfs0kmZ7/OJR/0D6ceD/0Nos1GZjuXk6za8LbQbPEgcrT6XZsy6KDdxWjqK6si21VSyhDNWR34J2h0A+SiPN/DJOkJ467Hwu8TbeBMrO4Nk+48DUkzTfcJ5ElzUhFaFhNZPsCKxuD+O3nv4dQ82braclZtfTjrFtyuPuYEs0nb4eQ7jyLWqdxq0OXHwr8X5TQPHWtt25wbUeGbSA6kAu1Yg+1zxAqYOKMgGy4oq2MhiMSTxriuDI5s596nWmY0tz6dvlRPKq8LVNAlqLIBYQXf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(66946007)(66476007)(38100700002)(33656002)(36756003)(86362001)(26005)(83380400001)(1076003)(6506007)(6512007)(2616005)(2906002)(7416002)(6486002)(6916009)(316002)(478600001)(5660300002)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+a6CLWS3o4kdtt7MKkfv8yYwYl2txDoah9BBVtL9e7lOS7kqDCCNxSRD15zL?=
 =?us-ascii?Q?RWrr7yCOVNQt1ao4xZ779I3ICb55Izcl4RdsQoA+z+eCOMdGVHG3BfNk1O/y?=
 =?us-ascii?Q?WbyvSOzWz3iV395irDo5P3Ja3UJ8AhpXanb0GQgPx4NcrxmerXLO3wHHF9qr?=
 =?us-ascii?Q?BC7VE1a90ct30RkCeV0TMOz75waRaPdZP7HZ6TqTLntcnP6lKiFx5hw6+3eX?=
 =?us-ascii?Q?8UK0g9HMYZXrGccgfWBUeRW49PcImFtDbF8DUTVSkUZ09eMts2p+YchnHnIG?=
 =?us-ascii?Q?OivAtYudMtY8EZeuLo0vlpHqmXadNgeU7dE3e+KTkKDnzRUwZRHPxoiastDl?=
 =?us-ascii?Q?lK9/l/xpC+bZqd4msGfuegcuvBH0fThvtZOkCJvO/vVel1bW/yWWc3HFdIpR?=
 =?us-ascii?Q?L9r007UNH5+SlXhPKVyR4x8rQGgIXikGav0CeXoUZo7wgBaKhaC4sxCqNhwY?=
 =?us-ascii?Q?Y7I90NHNQuegXDdNZqNSO5BYJjUy2R2YHIsSUYU0nlS0d4Qyg5pWNLfGtkSR?=
 =?us-ascii?Q?ZZ8Ldw3hBOz6JBjJZRxIxhomYBmkUluyg8k50WY1DmaHyr0QN5/rntfvQVBN?=
 =?us-ascii?Q?8riC2F6k46u55wDoD8pg6DpIoviJiSle9zoKc3dNkn2tGa6Nd6Uh9ILBnPeQ?=
 =?us-ascii?Q?WxaUrk0xBc/gOiFR5A5GIkbuG0iBEKUR8Pp6g2wpXJGSI/tJdA6K2R8d+wvt?=
 =?us-ascii?Q?lwHrP7zx8Yklm4kX3KWbt8HyzFUupZm6jnrkZFovCGxknJ4apaZTStQZ4A2F?=
 =?us-ascii?Q?pE2EL3aqgp9R1iYSU6wSTAcc7Vla2s1Ut4xcsWRSo1OPhKCD8/zhXm3J5sEi?=
 =?us-ascii?Q?IOvqcMAHNjeD63p8rc/Hv+VFL854pMjOwLtCIN0i6OhK/1TsB9oToE5K8fTn?=
 =?us-ascii?Q?T9XS+3ksjnP/IMUlvv9XopxNRXDX6QTdzRTvO6SPFijjbCStDeBU/cGLEHg5?=
 =?us-ascii?Q?ukguzUJfCTjsDov4NsNc0DtUrSWHgDS7vAgDpaSmbZARw5zft5EreCA3ZJhL?=
 =?us-ascii?Q?Rjn+69piOn84sMAz3zdWxzqd0+JFACl7Dwt/qAxeqnDH2PmLXiFhUA+XoRTt?=
 =?us-ascii?Q?21exA/UaJb7KrwnQ4ndhzCdZ765qeJiml/37H+Y6KE1cwdMrSGIbkLuo1Wao?=
 =?us-ascii?Q?Necb8I6CzWWEkvUadEg9j+GUGg9fr2xe7tAwydKbLkq15t64FndKOEhI8PpW?=
 =?us-ascii?Q?sIKyuBVHDe4+fJEO90GXsb19fznrNKcGzS7lKcK6flFDZkuu5wXAS0hQXWKe?=
 =?us-ascii?Q?bRWZRRTgAyGpCXrUex/DzEd/Vn9TlzK8aP2M1Sev6wpHgJgbxrRcghQmxrqu?=
 =?us-ascii?Q?jSgJXJKGKKcOW0XycuoDMwhWZkHLlVMqhOGtI/bquiggrr5YgTxTzhkDvzM9?=
 =?us-ascii?Q?CkjFeln3xz2QVnPwtEIH6UNLCnZUgxgM8dVHC6zAxucu2KlRBZ7eNqdTVBiF?=
 =?us-ascii?Q?XCeXdguLofKShMe6OZ7WitItZ9YY/GbIO+f1GUOPJeIUHVCiCEd7ee2hvzHH?=
 =?us-ascii?Q?Xw8RG112T9se2z/6VtkSW3YbM0krL7yeG+7dbw+Z/BCLmHSSnkRbq2eLto51?=
 =?us-ascii?Q?rfS1HT+gan4POkj7VnSnlCqIfjpuObvxWPXs3U+a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba22807f-3a96-4e56-a759-08dbfbe2b211
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:52:07.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mw6AAeJ8hM8ZiRpEjwDoKBKWP9AY7atJK5ns048m8Ykn414SNjezTA5SnzvV+xLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:01:39AM -0600, Suravee Suthikulpanit wrote:

> -	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
> +		ret = udata_to_iommu_hwpt_amd_v2(user_data, &hwpt);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		return amd_iommu_nested_domain_alloc(dev, &hwpt);
> +	}
> +
> +	/* Check supported flags */
> +	if (flags & (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
> +		       IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	if (!check_nested_support(flags))
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> -	return do_iommu_domain_alloc(type, dev, flags);
> +	dom = iommu_domain_alloc(dev->bus);

Please don't call iommu_domain_alloc, call your internal function and
force it to allocate the v1 domain..

> +static int nested_gcr3_update(struct iommu_hwpt_amd_v2 *hwpt, struct iommu_domain *udom)
> +{
> +	int ret;
> +	u16 hdev_id;
> +	struct pci_dev *pdev;
> +	struct amd_iommu *iommu;
> +
> +	iommu = get_amd_iommu_from_devid(hwpt->iommu_id);
> +	hdev_id = get_hdev_id(iommu, hwpt->gid, hwpt->gdev_id);
> +
> +	pr_debug("%s: gid=%u, hdev_id=%#x, gcr3=%#llx\n",
> +		 __func__, hwpt->gid, hdev_id,
> +		 (unsigned long long) hwpt->gcr3);
> +
> +	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(hdev_id),
> +					   hdev_id & 0xff);

Huh? "hdev_id"? This is not OK..

The device you are allowed to look at is the "struct device *dev" passed
to alloc. You cannot pass in a struct device and then override it with
another value.

> +	if (!pdev)
> +		return -EINVAL;
> +
> +	/* Note: Currently only support GCR3TRPMode with nested translation */
> +	if (!check_feature2(FEATURE_GCR3TRPMODE))
> +		return -EOPNOTSUPP;
> +
> +	ret = amd_iommu_set_gcr3tbl_trp(iommu, pdev, hwpt->gcr3, hwpt->glx,
> +					hwpt->guest_paging_mode);

Waah?

This is touching the dev table? That is not right, allocation is only
*ALLOCATION*. The dev table can't be changed until you do attachment.

Please look at the smmuv3 patches and try to be structurally
similar. AMD and SMMUv3 are *very similar* in how their HW works
excluding the viommu stuff.

You also can't assume your parent is currently attached to anything.

The construction of the DTE has to be from-scratch based on the parent
domain and the provided values in the "hwpt". Again see how smmuv3
does this where there is one function that builds the entire DTE
(called STE)

I'm skeptical you can do this properly without also restructuring the
DTE logic like I've mentioned before, there is a reason I did that for
SMMUv3. :)

> +struct iommu_domain *amd_iommu_nested_domain_alloc(struct device *dev,
> +						   struct iommu_hwpt_amd_v2 *hwpt)
> +{
> +	int ret;
> +	struct iommu_domain *dom;
> +	struct protection_domain *pdom;
> +
> +	dom = iommu_domain_alloc(dev->bus);
> +	if (!dom)
> +		return ERR_PTR(-ENOMEM);

Also no, do not allocate a normal domain and then 'wreck'
it into a nesting domain. Refactor the allocation code to be in
smaller chucks so you can alloc and init the memory directly here.

Jason
