Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FAA7B54FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbjJBOQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbjJBOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:16:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7CB4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBHdAjmFtVU7iJMjhvvb/vs0Dry8RdN2YuGOnhXV6Klcsfc+bJEO/wMJe+X0j4zl5WS5sHv/79PdT1Dx4FkWTNV6jWeIt5S2ty2IalKFXNlO35T8vt1JLn4L+1csxTq9DN87MeX9Naj1CaEelQzf3iQ3fT9VD/CULGdZomD2dNgm1lL1MfbXRrXFWgIPzxthXjNSHl979Xp1k9+4/xRpLQzRaYOW3nVFxA9jXb76u5rimujETRzp853ygEgKO/dztepcaYjoDIyy6rzu2duw2OkgzR879GQ21DDu1N4YJinRbaRRDvwlMtiUP9T0NJ4u1oONRbk4qE448MsRQ1pNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGDLL6WE3FxSzuc6Rfize2j+50A+/RsNVWuOxlBsoKI=;
 b=IUM4LDyEkmykoMrxAqcwy20foJex+c/2p4jkd1Nn/27Sa5LAASpscuniWyErpYv3cvfBNJp2sZnCWAXLiPaoT8J2J/c8L/QxhZGsgl0C/SMsKcH3Vpinz86E/ElX8V+kzf6v7+yB9WR0WboHggyfCMOLGhuWPT3vOaUgLjcami2r7DRiTsRaVoC5xeTiQtY0CYC7jwp5tnCigDQEUX3W5U92ClH9rPhTMAfcP11nJa9P4e6uwZ8SMWIuzDOVAz/tJsQDMHI1S8vLtqMah1GZX6sELeXmYJD1ttZIoyXE6kHIlCPyJLa028nfIQ94WQEnnF8f5OVGt9Tn3ddJ89RkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGDLL6WE3FxSzuc6Rfize2j+50A+/RsNVWuOxlBsoKI=;
 b=QqjQbERuZUEREXWgjsRM1L5pAdBXPQUP0APi3GAT3gtAOuF+aWRKoIfVGHwke4tYapk/uOkLbg3vmN1Ctk9y2RrX/HuKxxQPLvHjaLiMuxEJWiE+x7YMVyKjFL4ndY/yrqxnk6Lov+DSoIzJv1nx2Fk/neOvHUIlk0tVl0qMBC5oNJ8zODCE4N6ql6b/seKjGLiB2QbGAOkHLcMXu3T0eGj0AfDO9kTh/d2rAbs0VexUP8R0oHssz9BdzIRKlypb82z5kTVBjdxjc2Qq/98G2Px3VwBHWJuwVjbBHNTxFhX/cs3qc0C5GoJ6cGBsKqNd7UJsH7v2Z3oJvdd5qaVKOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Mon, 2 Oct
 2023 14:16:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 14:16:18 +0000
Date:   Mon, 2 Oct 2023 11:16:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] iommu: Switch __iommu_domain_alloc() to device ops
Message-ID: <20231002141615.GA650249@nvidia.com>
References: <cover.1696253096.git.robin.murphy@arm.com>
 <458dd0ed839541693a49da33239b33cf4c48b8ec.1696253096.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458dd0ed839541693a49da33239b33cf4c48b8ec.1696253096.git.robin.murphy@arm.com>
X-ClientProxiedBy: BY5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6b1768-924c-4e2c-d2db-08dbc3522566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4EldfDCBAxcSeHju3A8kSf7aQzjSUXm//R4SyJ7Uo/ZfvB6H/popkYIUZJo4UK7sRiHAVTXmK66+aH8bHwqb8/mzE29fQnK1t8vCcz9pGQbLhenl+pt86IdRT/Fh662vh5lA2V7pz3t6Cm7mHMBL8Wg3uQG4e985im+1jBUvRkVmwRZNZdeK0y0gXgZgbh9b1CEG5Qqg9ZfYV57S/z0KGUhSc1u5ncRH0yletTaOETTCCrhLuQ3bxcBxBOm614BhZVgrfoNqOx6EuQ6cFQuAGCPB8enFcm5U3VhFEflMMOKdB8InKfd5s37+L8oI4kDzszIHkHA68YvQNwUs46crxndTGbXgSLaL+AU0bWFOBwfLxDnw7mEiscqGk/ayWVRkoNV9BzQPEQWRoW7OsLVhIjEZxyimDIzDLiuGS95kOCifFiKmMnLqM4eTUMKQifWlePlLpAJ29rLI66JmoEX2ISj5SO/wPvU8PTnWImS1qUcf1yGvTpYGFj1C83aNGEivNQrBlbTgdICZP+oR/0CPOSJEBztJpxBpF5YYhKiBDdjtTXDLVs7cwvMM6h3jCqwtWuO0mW7YNQHvhA86jMJUf0l44Jbgazras9C+0RS2fjXHsRI5a1GwcC017cReLkBU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(5660300002)(4326008)(1076003)(8676002)(41300700001)(26005)(36756003)(66476007)(66556008)(2616005)(66946007)(316002)(6512007)(6916009)(8936002)(6666004)(6506007)(83380400001)(478600001)(6486002)(33656002)(38100700002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fdMdqQNE/5QVW78UzUQZA6CEZzXOra49ASVm4+s8yn9wqldp0+hcmzM4JWw7?=
 =?us-ascii?Q?EvuOLW7sLzpnCwiQsfUEIcfS0wMaCYcb0j6YPNARcjWVlAh7HoLmw82L05n6?=
 =?us-ascii?Q?PDA3lhtRxYgEWTmSiVbLEOH/garcy6iLTk4OznNhooU+rCwQJwdhBtHmFwts?=
 =?us-ascii?Q?fvMVoenE/IODRbGkwLo6Qp7I9r3hHNwQz+GLcWQCwBqOu5t1fsvjsx4ZxHOo?=
 =?us-ascii?Q?IAfJCK5Lw+aVD8Xt5/cinQlV4yqMMzHKo7vg3+qJoFm8ausIBK6opxjr3F49?=
 =?us-ascii?Q?TgAC5F1tZL+Lq+mXuaBaxh4kyjKQuqByUbv5IbbAV7TkHIFtT5HD3TRFxF8+?=
 =?us-ascii?Q?NhBr/CB7NfguCv2jjHou60kNlh/+ZmrMETreXWSk5U+mN81FBfpIYYiWDhwx?=
 =?us-ascii?Q?4uaHqudSfF+lmy3X2GOm1t5wW3QMeITvdTiHlou1ByeXA1Al9r4qiBr6YkIv?=
 =?us-ascii?Q?YhOdXnv8FoQF3C5gs5PWv+RcdZp5CNpuWSGW9uFVYUB0FKo6uknHAIgrltB4?=
 =?us-ascii?Q?XrMLr2qfdZAKGdtLtTgDD6J0eIVFnDeYX9SuzkKol2Qfq/Pt1ejfRr/QIgik?=
 =?us-ascii?Q?gugq+CyDU8kJuYhKqXmIldh01mucFSUOeeG87itTbhAsnd0FeEuGOkAFCHFR?=
 =?us-ascii?Q?4eFW5jfDDtfAe+EAseISPWGeQUNzqcWz3X/jPAPYrgw6R7SsSp+uotOzB2oD?=
 =?us-ascii?Q?CgBSf+cZw7DmoyJYyNwUUuY+ug+s70yz1fhQ6xIhXJsWUNxw9tL4gYvOhNIW?=
 =?us-ascii?Q?ze9rzmTenptZCHMaoQWcOk3QiHVwlCua9lhXUjZNT4CqacwTwH5+5FCkZ2QR?=
 =?us-ascii?Q?dE1r4KFCUqZBWsg+CJCXOEluhsGcIoYAEQlWDZdTxVjheYeDirzop8F96xXQ?=
 =?us-ascii?Q?55g9kN07cEtWf1whjfHvLSIkeJvG8r1a3ve4QWprlG/ni1BSo3PbCUzA6Dc4?=
 =?us-ascii?Q?sdmp0qTszBxYKxYu6pDimuTKVZX1qW2GYsxmDQp7KIBtVoASS6e85tsEIEGx?=
 =?us-ascii?Q?r3ZfTRbmXW50D93+S3rUpsGVdlsIIJ6sB/hEoJg4X6c+jM1JbgiHJKFSm7GJ?=
 =?us-ascii?Q?KbngyIllwMjFPMaxMlmJcSkw35Bz1mchJ0c4s8NjD47Z/bSVHMt/utchL67n?=
 =?us-ascii?Q?nCe2V2rwezn4HQrgEgO9iV5kwP/9Q1nEQ6EaM2S9H4ShpYUE6Vr3z66Wo3b/?=
 =?us-ascii?Q?pz6GZW2BrwCaOTuxFbSd6wsM263gzvShu8BYZtBVnsjUw5yx7bjN3tAiNWTr?=
 =?us-ascii?Q?isJzTEZcUExXpS2Yhr5LvIoOhWg2hAkehZJEDLf+T2ZwfKs2XlCCNVumdnlJ?=
 =?us-ascii?Q?IWQ8c28YxUsFvF7kBj/4nqbbi/fjgdXclRgG6LO6GutHil2TF4VOU+/eun2y?=
 =?us-ascii?Q?4VJbYnRr+y6Xfn/yLS6mMiI4ALDdxpJPZFeSCIH+FwLVeqJ+ZyYviTuGYkU3?=
 =?us-ascii?Q?urAVCHO0kpTAjyxnCJR3rhS8EsNSKw94tdnVVbhTFMAMn/D+tTY5BN1qqNUN?=
 =?us-ascii?Q?OPrAKSYocKrKnHokpepHy8UTqr1WXmD9jgjt6EjP33OfbdCPKrSLNOg3yJEA?=
 =?us-ascii?Q?enW5kX1a/yuk+/lmRHcHAvknAp3Vzl33VsIK3Dia?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6b1768-924c-4e2c-d2db-08dbc3522566
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 14:16:18.6279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7O8BbZOX5XmFk7kpFMAFDI+xixQ5TyDPI4gNFl4X80fNOcmwdyJFfB7/G2kdApR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 02:49:12PM +0100, Robin Murphy wrote:
> @@ -2120,20 +2120,30 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
>  	return domain;
>  }
>  
> -static struct iommu_domain *
> -__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
>  {

Why? The point of this design is that drivers are not allowed to
allocate different things for devices in the same group. So we always
force the driver to see only the first device in the group even if we
have a more specific device available in the call chain. 

This patch has undone this design and passed in more specific devs :(

The new code here:

>  struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
>  {
> -	if (bus == NULL || bus->iommu_ops == NULL)
> +	struct device *dev = NULL;
> +
> +	/* We always check the whole bus, so the return value isn't useful */
> +	bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev);
> +	if (!dev)
>  		return NULL;
> -	return __iommu_domain_alloc(bus->iommu_ops, NULL,
> -				    IOMMU_DOMAIN_UNMANAGED);
> +
> +	return __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_alloc);

Should just obtain any group for the bus and pass that to
__iommu_group_domain_alloc().

Also, how does the locking work here? Definately can't pass dev
outside the bus_for_each_dev() like this.

If this needs to sweep over arbitary devices that are not the caller's
probe'd device it needs to hold at least the device_lock to prevent
racing with release.

So I'd structure this to find the matching device, lock the
device_lock, get the group refcount, unlock the device_lock then
get the group_mutex, check for non-empty and then call
__iommu_group_domain_alloc()

(there is a missing lockdep annotation in
__iommu_group_domain_alloc(), the group mutex is needed)

Jason
