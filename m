Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41DC7655D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjG0OWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjG0OV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:21:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB0122
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTwootOXtnqnZuK0ui/S2Xn630wo3bVgIvtjYwQ9+s+m5RSgwZs4H6BKgVsz4mT3CIzI4OTGG2wOjTBlIV4dy+zXT5HcKinyt+kAy5+kPfsO12Xz2Vdc6fTEAJ/cCLS41ZmbRcRHr2h7YBfTiFyGxJCa1o9SF1l/CE4FlKaBJpzY8VYr8RGsoD8M+LaTlC+KeztbYMjpTDHwDeF7G0MQ4XRelD0kKWcxa+dMulFtVEgOBXO26ZTdx/jpyQKD2mgrBGiWOAvbywnwr416BJzTVcRKb+bxV9XQQFxWWlZYkwNfGVg0+dA3JNiLE/bDFTHX8ZYBMZudJeceSVj77qD5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5eoWbzuWVAsayEzJ1Cu5d63mu1fIKB2/rWjThsEmkY=;
 b=X9JrlsCwg5TIHow4M02AWawl394nNbhdHC1h8ICqgqVFpgNUV37BDTqGaOUCJZc4+MpKW/niGnA7uhMk9oc+sE3NO1LqQA0lUtIklmSteo+vJjjAnIepcCHsJk+GV6vxdW6vQxOg16i/FHRVAO2GJfi2untF6TspWpqHlQD81dDGmV6UYwb7lv6S1H1lZJU9+/pBaIe0hYQVHSkm1EEbA3F8/8EapW/cy2t/8WJxy+i9kcfuRNSeySKKKXo+bZRhAl/tVhdV8C5pBHrq8zDACKoUH0ndUFKlJS4lo/Vu1oJxpL4u1W1mlhhPRQY4yqDewwVHQiTlpKXGP1X+wDuyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5eoWbzuWVAsayEzJ1Cu5d63mu1fIKB2/rWjThsEmkY=;
 b=rVaEKlfA5Jx0SD23CbdJj2QFj1TZBzmKUZR+NxBZGjfu7UZxtU5QUBeuxlNx6dlEl99hVf5QEdNm/3rQ2lLUKrx7865qkVBb8OUcOFaZAdk2bs87oaSFlZ19E7e6QGqHzuiZhzJMpo/SssKNUjoKTjB3nH5n/XKIvfh0wm4aU0bmwkU3pg2XdTdwvy+SPHtqaxKmOlUdgxp8zPYpAl0DU6R4DID5KwBpK+o7kVBM9S1I6EMOWp43WSrurcIl6JhrQ6tqpv0Mjtr3XcK++sZxzwcPy+WZq2FGLkGoVtOogxzOC6G+qEekBP/KOZG+LryMNtlOZufAWwDPshzmvT516w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 14:21:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 14:21:55 +0000
Date:   Thu, 27 Jul 2023 11:21:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZMJ9gYM+Rp8yxpv2@nvidia.com>
References: <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
 <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
 <ZLFLyh1b+wiqb7Ql@nvidia.com>
 <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
 <ZLU0IZJr6WSjknHf@nvidia.com>
 <CAKHBV25QZn9xApRT+=oAtwQRAjCD--S46uXRDwW+E5=at0ESQQ@mail.gmail.com>
 <CAKHBV26sRpFJv8-_f4n2jsTKiOgnHF0_FZ07KBbVaueX+T2kWA@mail.gmail.com>
 <ZMJa3kGHD2iE0/za@nvidia.com>
 <CAKHBV27kr540gTDbgGwzYt6_X7J=NfdNONVe-_y0-XpAQjc4jQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV27kr540gTDbgGwzYt6_X7J=NfdNONVe-_y0-XpAQjc4jQ@mail.gmail.com>
X-ClientProxiedBy: CH2PR14CA0051.namprd14.prod.outlook.com
 (2603:10b6:610:56::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b005a0-a28d-4def-4df1-08db8eacd464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jj9Tg8EdAKfv/JZJVgrj6mBIrCQQuKSq71XvBARf/7OgB+GEpM+we/DpZrCbS3UJ6W0ZHDXOowlF85AWd6mrA1Hgt8EZolUgBxvDinIovH7hdzefkEiVwbMsHonC3k6iW7FXQnmsZH9pHo9jPAzG6uTAyUVv/EPcJcJWWIJKpAAhHptRb28kuk+HUdblrAzLy7Kw1bcEYC+r9kez1N0LXMwqfwKBR6VxvDLKERX5mdROcMEDrNAbDdjvlVa1/a8UOkMz7VMg+krCxYHn6QLR/xCVAPD9t+U8RNyki3H/l09P3AMZ6Oa9YzrwJ56Vw94+svRU/FnLplb6LdQHrTWk/EoiCShsEVzDRTWNpcEa8F//J3LqL29Tdf7E3+2Ftly0j6uhzkuEIgX2IOLwLuVvEzDYPv2PVvFSASn18GJDkoXc1FC5c46xuy6HQgfHbLFN5ccOu++CINsd9nz1dcvF4Vp3q4Jf7rONiAqdtSzq+4i8LbMuY3jR5J3N8mlbtiHDWUJc8W5huwLFmEU0gM3lUXuW1RgwCtpf27SGnSgDoXqI7REn0/oS7Jfakm8RVwzChsf+3brBAPDbOUaKm3JQ225aqJLghURusbTswVjeN5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(26005)(6506007)(54906003)(478600001)(186003)(6486002)(66476007)(4326008)(6916009)(2616005)(66556008)(83380400001)(6512007)(38100700002)(66946007)(5660300002)(41300700001)(316002)(2906002)(8936002)(8676002)(86362001)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qyseGlp8oJBHKtWcmzUYkPHThKpquZmlJKw0RtFzE60ODLCVNg+FzyxkmM5D?=
 =?us-ascii?Q?RKF82sf9AdWUGpqnNgjEUxvSs4LOcZ6FRSCqh9npXkwmFukABx91k4by5VOw?=
 =?us-ascii?Q?Wb0AlMPJ0903MsNJQ8Y5XrxM9EMB/QyS2Te1lYg67jfScF8hL4H60P3DTRjV?=
 =?us-ascii?Q?XH00YKJh06cproq0WuphGLn/nny6gvhewjuTTYieRvgFynkVLnRvZSwt35u1?=
 =?us-ascii?Q?P5Q+qUnLGtRpny8YvYMJcC1b2aUMScKJ3MdtGhFK560R9UO/4vdCbqPoZE3F?=
 =?us-ascii?Q?t0tiQ3Fe1NsEe4X0pjP+FA3aL0KLm8+m4CIT1mnepqHZKhFRZKSGqi3Uhvs/?=
 =?us-ascii?Q?AF8p2MrmykLOUiMnFJOXsBJRxn22fN2kQTvRfnalvpjfAAeiCHWB3DU/9Npp?=
 =?us-ascii?Q?wCUkAC7tHLXxNMM58LSUWA+AbZ3NEqiL1JbSPl/JJza/TxWWgArdo971n9MX?=
 =?us-ascii?Q?GpcVy8+eQPWjIN2rmwdcqrvPsHUSGVsFq1bFDzA5AbynwKfMhc2KcsmOg6uw?=
 =?us-ascii?Q?vTCkQTeI4Hb7jV9YIjR+f5ljXk+EpnsRiRepydxMMNYMnc9m9JFqTN9zT7y6?=
 =?us-ascii?Q?VQCt2tKN6mdm+mqHkG7c/tpYZb7YcVD8NqKwo4Vqc/0ye9kLt2+4z5J4/CUt?=
 =?us-ascii?Q?tbxRh/YBkZLZo4KfX8FEmE5qaTiz3oTs+h8l4R0O11vxxdYtDgKGi+/NOSr5?=
 =?us-ascii?Q?IYArd0V+t6RVWaTXV/7du+IiWOKAp1up0RMLxNS1hiSBGr41nXSj2CZ0QMCh?=
 =?us-ascii?Q?6EOBP+25lWgdOe1uCls5eaSU7cfskYGe/jSIZ2aO1SUaxwArqakTWWTUbhTE?=
 =?us-ascii?Q?etah/ayuo1CHWarWSf+9dNbJcV1Jleq8Pppr24TBxyq7LUP1kQ6mmAMzWtbk?=
 =?us-ascii?Q?Nbxan/jyfzg/frJ+T3TzGTjnn4iUjsaIofV46h/fEuLB5D7L1uDtdsmQ92dq?=
 =?us-ascii?Q?GZ0LHjh8LbenUY/QHMxc5/pYHe7gikdESRuvSRoc/mM/ScdGqqm4hSQF0Ys0?=
 =?us-ascii?Q?yidAuCduOUC69twugPtajqCNQIyvJQVzfCiP/Oh4exhPzc+Uqu2gB7/mzXfi?=
 =?us-ascii?Q?zsMI+RI73DntIuq30omJ2a0+cbQJbPVHv2Csb7OweaC57iyVEF+ELO6eT1DR?=
 =?us-ascii?Q?mCsUJ1stFHMcQcXnCxXOqrIBW9zAP9i29uyBXxTJ5UT6O0FP04+otAgRuhGt?=
 =?us-ascii?Q?7066md6Q1+DRfTm+mXVmaoikwF6/oQb6BIpbBoYWYXlztIuNWlAQRyVe5VgI?=
 =?us-ascii?Q?MJ1y3tez3zZV1pOyDWSGyLZgq3x7MdFfcWHoH3ecyywrUZewVEC12hY7x9I0?=
 =?us-ascii?Q?ikbOWToT/9t3Gp4W88P7y4PFE8wPJvijKwx3oyMDXgwKfKAkiVf9nlwDAK8p?=
 =?us-ascii?Q?So8KKadoUPFSrRt8ADTTrQT0zCpnhGdvvz1hph7jyC9fqHKs64/3WloPoREF?=
 =?us-ascii?Q?28rM0iFG9wOIadbIvHkAvwni8VnCqPVTCb35roGblKO0ei10AbTggGgjhAqz?=
 =?us-ascii?Q?xEDEX/vuASZdtc6lau/RokO011pO7VOtV32X66suoQQ4AkB1KtWXivTAM/Ft?=
 =?us-ascii?Q?t+2laYNyHtmaHf3NIpNCYnNyFlTXkaJ+21jGPddA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b005a0-a28d-4def-4df1-08db8eacd464
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 14:21:55.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpTIlFux2ubO2PCP+FxsNRb7ktTFjThHcqoz2OxA4BZBRavZ1zM8IoO3OnKRMd3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:04:04PM +0800, Michael Shavit wrote:
> Awesome that helps a lot. These are the patches I have in mind:
> 
> 1. Move ctx_desc out of s1_cfg
> 2. Replace domain->s1_cfg with `struct arm_smmu_ctx_desc_cfg cd_table`
> 3. Move stall_enabled from domain to arm_smmu_ctx_desc_cfg
> 4. Accept an arm_smmu_master instead of an arm_smmu_domain as the
> parameter for arm_smmu_write_ctx_desc
> --- arm_smmu_write_ctx_desc can simply get the cd_table it writes to
> from master->domain->cd_table; this get's replaced by master->cd_table
> in subsequent commits.

Makes sense

> --- SVA is weird if we cut changes here: it iterates over all masters
> a domain is attached to in order to call arm_smmu_write_ctx_desc(),
> which ends up writing to the shared cd_table since in master->domain.
> This becomes more sensible once masters stop sharing the cd _table in
> subsequent commits.

Seems like it is OK inside the series

> --- arm_smmu_write_ctx_desc is used to sync the cd for all masters the
> domain was attached to. Now that SVA is calling it in a loop, and to
> break the dependency on arm_smmu_domain, we should only sync for the
> master passed in as the parameter

Sounds correct

> 5. Introduce a skip_cd_sync parameter to arm_smmu_write_ctx_desc so
> that arm_smmu_domain_finalise_s1 can skip the sync_cd before the
> cd_table is attached to the master. Before the previous commit,
> arm_smmu_domain_finalise_s1 was calling arm_smmu_write_ctx_desc()
> before adding the master to the domain->devices list, which was used
> by arm_sync_smmu() to issue sync commands to masters. This
> optimization was broken by the previous commit since we stopped
> depending on domain->devices.

Tracking if the cd table is not yet installed in a STE might be a
cleaner approach than a flag?

> 6. Move cd_table from domain to arm_smmu_master->cd_table.

Yep

Jason
