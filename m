Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3B7C612D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376524AbjJKXiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJKXip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:38:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D9BA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP9GXGEtVUwSQC5xmJLAkakhHHgDKOXufaoV5XJ8AgW/Wz97TLoJ+ybEI0osFpqI4A9rZTEVeaefCCN6vtyQi6NHce+W97NPCBedLlmxY3VmxxBQtgq0M1x2pOC3bhnQiJ2UEQ3baaEVY7y38bva48H52W4m88HpXDgI3zNCBi6Nv1X9U0GQTROo96pNEigLU9T9crzjg9YF2J03Dh4gQ3AVNY21NdLJGS/GQvnXfkoIvZ7hzmzzBH+fPFMxb49w9yS8q2PzU2BhXrG4iQxzxhdwRsGY5X8BBUsRiayDS4VCV6pfUOYqeGZqpq5aX0dY5K/+2R9LOA3fVgze8f6kAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj/N/TvDQNyhgNNC2SGvY84uZPPSdTidydFhnC8kq04=;
 b=AohI7cVV4HqEzrrdA+jdpBOXadrB5btcG4Sd8ftqDroOicQgCVTHmQgT8gl7Lo0CLWdY0qUu2BlMYIMak+23Iu7Ym26k/e8FgvhkIvzoIGAh9+bYFD0bRIJl/EpSNL47p+B+RVctYKx5JZ/oZolz9adNdTsHMtcO62nJCG8P1U/q1AFPDvVwPtMCdDvTZPlfKGagQv/2D66qutTAhKyYVWVxXeQhpCfM6x+0AP9+iuqg8qpKILxPH0zBHkWXcibXNuAxxpiKR8DFO5vX4O9vGQyfFsIENeOUTyWppW4ln2zUYWtXfIcXLjQ1NW7yvZHjAF+vzCPd/hd6UhkLLgOZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj/N/TvDQNyhgNNC2SGvY84uZPPSdTidydFhnC8kq04=;
 b=h+XB2CdwcwsnZd5bMtT8Kw1YYjg3m2cdIXP+DxzhYr30pIDnj3nUZ6WhJCLhNLTa53Ce4xoWNp7QhWVFbbBH1broOgiPJefLxlb/Nad/2egTi+bGO2gwO/cMid/6HIU71OyS+W7LvyCrVp0UyOa5gPHbstnBNgHYYa4AjCoi6EeCF9x8wFOBzKmkEkFIQnWQRFbNQRpQuPYHM7R/pI/mTfYRDPjOiBvgbMtgiVsyh0Q/ID8sqXXo7iVnlfGiO6vp0xaHY9brkYEvJB9CZORn/M+mQ3nrNi/AgzPRgr9/oV4pfAGw++nDQ+y4vo1jdfpGnS2JEBReLBR3EkLzRsMrgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 23:38:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:38:41 +0000
Date:   Wed, 11 Oct 2023 20:38:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] iommu: Decouple iommu_domain_alloc() from bus ops
Message-ID: <20231011233840.GE3952@nvidia.com>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <81a0a66d76b3826f1a0b55d7fbaf0986034c7abc.1697047261.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81a0a66d76b3826f1a0b55d7fbaf0986034c7abc.1697047261.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL1PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edce219-e350-480e-4fb2-08dbcab3334e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtS5Z9ouNr1GT3dIoJQynE9XBhFd23f61iQihO97pDxeY0YBz0RW+lMzX0pqx13502A1vBtDTBDKCOyES0fRszeH53sPczgpdF51U1wy7JqVP3ly3hJUX2u8pHGfGynPvw5nu1DGKtjVqaAHeuCfDlHG2+sV7vCUPO2pyakBXMyDqXr/ayZM5jRT1A0Gm8w9dWg/zCQbnmJvh2F4TBagpVo2QI/XqIHb/K1SklHK3EsBdLg4Rb+NZWWI1AUq4nLPJ8QgWWmgktSxuPxcjUCpIHXFEcM4bh4/UhkhW/fhMfqK6Ks6QjR7lY6S3UBVxd/8ceTcCGFEPw1cpP3vVNs2Iiv3H+yA2+kms8ZnYu4Q24FjWKNCHdh8PtIOO1KybDhJ7nViLMxtz6MqN7RSjuVUNQnzJDa3ccjII+qIzEkoWWw5PmL+igr9+uYZVQcNSMf3OnvucpL8vC2wEahOctVajjxNxth6Dchy/YhVgxFtgBir6oF7mm2ILo+wmE6TSWGYGDeNfLC5aMBCiyFjPG7CF9J9LGYTjuifmabdty3nZQvoxN93OP3zYGVlwELG7Tc/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(2616005)(26005)(1076003)(36756003)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(33656002)(6916009)(66946007)(6506007)(5660300002)(41300700001)(83380400001)(4326008)(8936002)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MB/VT17GQG61rpWVA2kZ4LynNUECWwuLHx5YLVBNwIfoP6vb8eUlx7R9LA5b?=
 =?us-ascii?Q?lriOxa5I+mGkfAXxypYZSAjnf0/R8UO8W3xY2RRNWHSv4kDW94pdxOICDuLL?=
 =?us-ascii?Q?6tXOup0lS9dGf4Slw3r2kB21+taRLc3L/jeP8RFoM5K4EfFkGpmufBKvJ40/?=
 =?us-ascii?Q?1vEYcfVHSRH23GK1NHqLL57PsikDH7ML7Eza0+FjP6uI0qioiRinfA/6plFV?=
 =?us-ascii?Q?NsqANDUJMxGvC0TwJVpe17rhV05k31yyemfg7pQBq6AGHBnJOrXrAlIqZbeG?=
 =?us-ascii?Q?ZpGmiDp5i93O932ZFIek6QvNbYnbzOuOhlcjUzhRcaKdy/g7UHEFJOUoex/+?=
 =?us-ascii?Q?ME1xmDEaV9srIvln9xCADDLETx9EjIio4ZUfEB/7aMF7rxRpS/mfixmmuneL?=
 =?us-ascii?Q?XtqVtSvp/fHOukA84LReRafriI7Wc9Xne4hH/bqYjvLTEw2S/CAqQgll09fA?=
 =?us-ascii?Q?9Ft0ZjKAnYnC+R9sk9NsOiGELS2HXZhT5gAw177DvtEq2qK/PHMV+H9pyK9n?=
 =?us-ascii?Q?MiVZJIVgQezPn5W6EJGEREsEDtV+CwI4O7hdAOwQ0KlFcmR4l1iVHfKD8P9A?=
 =?us-ascii?Q?UmZtFP6GXFYfa3qsFjS5Botj45X5K0533gksJwKLFXCwc6Gn2rPpAdyl083J?=
 =?us-ascii?Q?fVJnW5AZW31k5phyrooVt+FgjqsEPVrty/oraUMYEa+FToo+bZICReWc7Y7J?=
 =?us-ascii?Q?vYQzbPchNZXTQBOAR5g1nXfFM47BURA+WWS+dioat/OSWXXLGEiJE1kmGDz/?=
 =?us-ascii?Q?ws4h+kCzbeOcWruRR/oTVcxiFsQNLWUoz4VkvoBM7/EnMgiKSgTGdDmqkDow?=
 =?us-ascii?Q?8Ii4uoTOv6PlzGU9rw61ZvtTC2RRpLuAkJV+s/Mpp0WyVrxwyFe+ygtDz/u2?=
 =?us-ascii?Q?kOdaJQbCVbfOcwh6TcajTMc0Pc0BkXE5VbhTTAvE07lT3CSpLxj5tGhXEEIc?=
 =?us-ascii?Q?rGZ8XxSDmDgh0KWNM5Rt6p7FC8H6YdzR8gaX42h8J0QABfgeOOAOeyiW9PSv?=
 =?us-ascii?Q?QFUXncxl88O9xs3BwTTz7nb4lhqqmKQbw8c7DnlxHDUpQJTU83PwKv6CPpCh?=
 =?us-ascii?Q?wfEf+CDvfakEsF4UmoKOlijujHgtpMYYp4drD5dzyNFD/gp+LjGYkZKhmjSr?=
 =?us-ascii?Q?1Pw356S5ywQyNU3eR3OFT/1nr+/47D8/+zjGA4GFeHzkS2+BiQ47Hn9KHACE?=
 =?us-ascii?Q?4brwB00UtyE5a+yCv3iNlHuU0wZ6wO5l5vBPU4oqD2I937jLropoLahcKZKO?=
 =?us-ascii?Q?hhQwTFt+4ZS3dk4D8ByaKEOi/sqj4ybBr/5ULJ/XI78kn6ntsAPibC5QVKtg?=
 =?us-ascii?Q?vTh2fSDPPPyWA5r/HhR73+3No65LvIxewU5NlB4U+AQ2oK4wBYoxEd8jgWwc?=
 =?us-ascii?Q?FJ+bNT5e6mL08zQXAqjEZgV70XSiJryJ6P8ITGzZwW+JTzthIbbe1jJDZFuc?=
 =?us-ascii?Q?jjD5l3Ds3kNkEjHn6EZRmuTBR+3Qo5qu9guK6gueBmM/wwA4t7yFsu77/2rX?=
 =?us-ascii?Q?GxOfGGx9lojE6qGf0FowzKct/5xg8iEv1hdVG5nZORBleETC0EkcKHpbUWEh?=
 =?us-ascii?Q?/hk2hFLOfl+AYzhM0J9k+MPa6lwTLT5b9phPMP3s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edce219-e350-480e-4fb2-08dbcab3334e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:38:41.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5+IfhLAobqCx64MbdwZ1IlBXC/ZrlpERpBuhffvtJqphd5A6EFnlXlP6EMINoMp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:51PM +0100, Robin Murphy wrote:
> As the final remaining piece of bus-dependent API, iommu_domain_alloc()
> can now take responsibility for the "one iommu_ops per bus" rule for
> itself. It turns out we can't safely make the internal allocation call
> any more group-based or device-based yet - that will have to wait until
> the external callers can pass the right thing - but we can at least get
> as far as deriving "bus ops" based on which driver is actually managing
> devices on the given bus, rather than whichever driver won the race to
> register first.
> 
> This will then leave us able to convert the last of the core internals
> over to the IOMMU-instance model, allow multiple drivers to register and
> actually coexist (modulo the above limitation for unmanaged domain users
> in the short term), and start trying to solve the long-standing
> iommu_probe_device() mess.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v5: Rewrite, de-scoping to just retrieve ops under the same assumptions
>     as the existing code.
> ---
>  drivers/iommu/iommu.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

FWIW, I was thinking afterwords that domain_alloc_paging() probably
should have been:

(domain_alloc_paging *)(struct iommu_device *iommu, struct iommu_group *group)

Most drivers can use the iommu and ignore the group, a few special
ones can do the needed reduce operation across the group.

We can get to that later when we get deeper into the PASID troubles,
it also requires the deferal of the domain creation like the bus code
probe does but the fwnode path doesn't :\

Jason
