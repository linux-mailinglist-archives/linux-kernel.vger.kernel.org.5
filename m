Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595D276EE5E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjHCPmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjHCPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:42:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3D610C1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVT6545w7HJ25PbYYTgDKPSSvzwuGr010WKy8fZHkCucFXMoGWuZUH2bwR5LkFEuxl6rkVPAjzmmmehSlkI4k+Mpg30lpvjmsyLrtX/r7Zc7cdRktGimrr2DRMNK0rt4ceJPoXo2sDszxrXmiXicMPRmh7ArhZjajOZiR+SedsoYBe5ZGqXwjAIL/SSYFp93uH5QRCWCpV6LzONN6dmIDP1N5zwPgl0+PZc8yk4KFuG1HACu7hbvAgLx2eBbBZag4uDqarnIba8/YfcPNPMBe9TfPMvOIlz7+ASyVSLkq+bB/TrioquzNNVK820Vt+/VU/7SAFx7HV0+vU4lA6tRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxJpDM4Y/xZa0R+S0sdutBvDI/MysLcDc/lQ3FXfI2s=;
 b=ZgRz+nxk5yxcX+wZ4SWP+V+AIgMHBWZXIOW4Kq7el7E7LJa0zngWJKpCedvHodxPY5wPxuIv9KoHorl9LullUL7GAuMtqhI9QWzTDvsnwInU6gzS3C32pafSzKkeXntYrxcnSw3Ya8sDYQLE1xEkoCU7x+a90GrAlaGfo3pY2TLbnwghyciqSg6EoSNWg6+UhIQhzfSHmvF1n9diOasKUJYyTH10+Zj8F2Sgt51vYN10s7WVacWEisEhJnbhAPLH9GZmS332O8/unYPcEEKEv07fCntpcWXqfaztiJw8Fi9rFI4G8r0Vr33wV8MT+F4yvEcunrGZEFWyfIxZuZcrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxJpDM4Y/xZa0R+S0sdutBvDI/MysLcDc/lQ3FXfI2s=;
 b=csIVYNCZJCRLuIwl6uAi9Pk4qUCub0RZYkru4/tM7Ah3lfhlCOICtWetdXblTFWfrkfxN72cAiG15h03mCYXy6+A+fd+jQLmJ1WI0kHVSAv3nbQWQOnZU18h0Od3nf7CMdRr8EOox3lE7O3dCgSHzi51qYmTt/u3QV/heBfpQcJeRd7OMekM85YQGI3cSe/qHp/8+AD37vuqyXw3WSfd7u79aSOwWadopV3s7KtnMGjTTZKjOPcip3CKlahQE0NdjG390DYYOXTzd/D6NUtlvhccPfaxNZWYpcNJvChYmU1HmTd6JlKpFITi+T1RzszNDNv7toPvwvmnx1Xgn/o17A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 15:42:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:42:08 +0000
Date:   Thu, 3 Aug 2023 12:42:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
        nicolinc@nvidia.com
Subject: Re: [PATCH v5 2/6] iommu/arm-smmu-v3: Keep track of attached ssids
Message-ID: <ZMvKzwx2IhgXO+F8@nvidia.com>
References: <20230803101351.1561031-1-mshavit@google.com>
 <20230803181225.v5.2.I8db07b9eaef3bd5ef9bfc5c8c6d44768a4d95293@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803181225.v5.2.I8db07b9eaef3bd5ef9bfc5c8c6d44768a4d95293@changeid>
X-ClientProxiedBy: BL1PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8cc114-0276-43e4-0e40-08db9438324d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qD8MXkPNXVxEnmbFqhKn0a+ZQi/dGB+9CxjtHIqOmdU+FF3n4YyMD213UaGWbGgSSXJpqmXuT5eLRTA78WtLBKsdOmTBJwwLmv85vpD/dDth+XKArnD8pvWw6sKI4iqX6uTODzD3sj+mgtLx25Wx/LRwcuS+bpZgH/GEA+5wM6P3ff3r6u0WN+0BJq9XCasAp3SLopb+93/CPh+K2U1VhlnvzOMS7p5h8XdlmVOPCcTvnd0ogMUeUMz7wjc/xZS9qD9QIy0lhoX1Oswhnoet0ArwuqCAq93un+ydtBMb4hsx/1B5+sAF2SZ/Tf/Ii73ATeQ6tEf6j6cfQ1uvRPPQKqOHDeJB1lhzGm6tY17PWqQq5QrGKhyWqBoAabt/ZuqDiO6WwNLOUcM/OD0HJSh7thf+VfVW+nv59oC/GqUuhOA1Qjf/BAG7DJFapwm1p9Ym8Pn6Ks5V8n54XBvADpuUhqz8uKDW2guLuLQLPhN0F0SpYGbPzPqfA3er+HQhE2yly4sd4+edfFIy3tOuILCKxTLYspSaNlT4CdzI5kjVsybnMg5IB+Aq08rDHVpjkDK6vaJdtU6HFFR+oapKqxfelfhxhFOLFtt81zovUBuYeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(86362001)(66946007)(66556008)(66476007)(6916009)(6512007)(2906002)(6486002)(107886003)(4326008)(36756003)(478600001)(83380400001)(41300700001)(38100700002)(2616005)(5660300002)(8676002)(26005)(6506007)(186003)(316002)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KaR0kxgy8NheLiSiPCDPLJQNaTfbK81SRWpgbtZKTkk52eurN56EfHeIo1zY?=
 =?us-ascii?Q?c40yta1w4gEqAo6J8QhbHotUlCBN73CXknXqJMQu3HvrgHPyqbgBWaXC6In4?=
 =?us-ascii?Q?IHuDek0Pr/avRcqkDfkFlT05WJfxd+Lhw/aZ4H9aFq4tp54/VbcH+Hl0yeFw?=
 =?us-ascii?Q?663miBfPfY3P96QH4uwxQcnVv9ebVsgzaulAJYlMbmK2JeEwNiCO9aQlhbMJ?=
 =?us-ascii?Q?k47qCihaioLAMNmMtBnXzRE3lsk6xWv7V/QSg0oe1q4N1UO4J56GMli9uM8h?=
 =?us-ascii?Q?2feLllWvEqtaPbUfrrhWugBMQ7n41C9vL9dlJNizlvS+DxfFmfDCyoDQ3lyv?=
 =?us-ascii?Q?xjeN8o7hdNtXMUwqH4MaJDHmmwIpxq2uM2bH2iElkbDvUsqG/kmYh9yhXis3?=
 =?us-ascii?Q?FIDIevJCgs+gG/46/kBuuffhfxNPSu2tFgjD2xsW7cXJrU40ggeMe3V0slyc?=
 =?us-ascii?Q?vwsrEJ1sPE+83V3byTrT95QtCnlqNPgHTpymR/aWyDibE4+7lCjGvmx/ppm4?=
 =?us-ascii?Q?brfwjAE3rxY+FfB0cgwihLHqOF24P1IuXCl+B/jAmpS7D7gk7qPIe0EhXB8c?=
 =?us-ascii?Q?gSh2BYEXwBSSxVxerBALmS2IL1IzxK01RDIyvhSib9CZ9PLZJUW5C7MKRlpi?=
 =?us-ascii?Q?I4W1R9J1hnVk5LAZtQiwlZ4DDka4UNp1GkKZD6dZDOL++gfO6Idg8DlIYiKu?=
 =?us-ascii?Q?KgohN89GllK8WL+p4xmTK4cTOL5x0nSBM+NTrqgKkx47Oc0m1i4pDqcLOljL?=
 =?us-ascii?Q?UpoW2loEVyeCeCWmXF+n8eLuuJYeOs/9JwZK0MrdJX14fu7YEh/IYRXA1Raa?=
 =?us-ascii?Q?dbdMFNdN1lFm3ozs9j4NbZX5HNhx4Zyqztt1XnQbt4jd/2D/mFKR/IdtWnrt?=
 =?us-ascii?Q?LDLNT7Tf8F9wURIpcSHuAe+zGScN1RP04uX6Td83028CxTpuxUgfvCpDdg9f?=
 =?us-ascii?Q?FFIlKVqWICd29YlCnydzAHUDKCpKIFsnuNAfrvFKt2JokPIeU/8E7dXiEw+P?=
 =?us-ascii?Q?xSC+Er5ePv8RCuN0TJe8kULMv1uOG8t6ZIB61zEiZZimj5uz5zGVUzbuZfkq?=
 =?us-ascii?Q?6v3F/a7Y2Q30x+GBEXiEERmD0ufdpRWjkUXv52LeE2m5pA8rXRYt5GheOXNg?=
 =?us-ascii?Q?fzfYm8WmWjppYJNF6GtaqHWdGiYpq9FP0JwXdWRLW3C1hQLb0xhx8TXWAG6a?=
 =?us-ascii?Q?hH5FcW0yy68//2UWcVx7m0Ot4vYtaGstS3FesyfxtgDOfVFv2dZ7w72/wbQv?=
 =?us-ascii?Q?odFTBzkQXkMUxd2l2QtyIbs49Hg1jwhrrmzn7PWOtrGRgEKjAsmx2Mw3cpeC?=
 =?us-ascii?Q?8HjRChWnRNWQnoxLZbblljV00kQbDL22uBcnf9irR1lzmiYt/vth67maOjB8?=
 =?us-ascii?Q?pUhPjxgZ2mkAONcTeTZ2BRMiCIs+IIMC7zgysoQbQR7vKgmJzy8hoc/5e8tN?=
 =?us-ascii?Q?T09+gLrG3kjFunOWnQe9V+5q5UrZXL2jZ7jSqoe4ydwDaHdB4k8EcZJjhNCL?=
 =?us-ascii?Q?w68cPXWCUnQqORgJ4OyTsEE4BygMfDellgeEjEadOkpw3XCpjV8GRM3kPkWG?=
 =?us-ascii?Q?v536U27O9yA97n37TzPFIVNJaAWZt7tm2LzVlCZ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8cc114-0276-43e4-0e40-08db9438324d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:42:08.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEA6mVasm3xDEoe2IBoEANlFLHzz+ZanDdq40zqTQOKOEwqx4JV5AOTA4eve/QGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 06:12:22PM +0800, Michael Shavit wrote:
> The arm-smmu-v3 driver keeps track of all masters that a domain is
> attached to so that it can re-write their STEs when the domain's ASID is
> upated by SVA.

Wah?

A domain's ASID shouldn't change, why does it change for SVA? Doesn't
SVA use CDTE's only? Why would it ever change a STE? I'm confused what
you are trying to explain here.

> +/*
> + * When ssid is 0, update all the CD entries that this domain is attached to.
> + * When ssid is non-zero, write the CD into all the masters where this domain is
> + * the primary domain, with the provided SSID. This is used because SVA still
> + * piggybacks over the primary domain.
> + */

What is a "primary domain"? Why can't we fix SVA first so it doesn't
have this weird "piggybacks" or:

> +/*
> + * If ssid is non-zero, issue atc invalidations with the given ssid instead of
> + * the one the domain is attached to. This is used by SVA since it's pasid
> + * attachments aren't recorded in smmu_domain yet.
> + */

fails to be recorded?

This patch is not making sense to me, the goal in the commit message
seems logical, but why is tracking CD entries introducing this concept
of a primary domain and doing special stuff for SSID=0?

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index e76452e735a04..66a492cafe2e8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -689,11 +689,19 @@ struct arm_smmu_stream {
>  	struct rb_node			node;
>  };
>  
> +/* List of {masters, ssid} that a domain is attached to */
> +struct arm_smmu_attached_domain {
> +	struct list_head	list;

I like to call this something like

 attached_ssids_item

To help understand where the list head is and that this is a list
element.

> +	struct arm_smmu_domain  *domain;
> +	struct arm_smmu_master  *master;
> +	int			ssid;
> +};
> +
>  /* SMMU private data for each master */
>  struct arm_smmu_master {
>  	struct arm_smmu_device		*smmu;
>  	struct device			*dev;
> -	struct arm_smmu_domain		*domain;
> +	struct arm_smmu_attached_domain	non_pasid_domain;

Probably should consistently use the word ssid not pasid in driver
internals. 

The smmu spec talks about the substream ID being optional and the
behavior is controleld by the STE.S1DSS (Default substream)

So maybe non_subtream_domain ?

> @@ -730,8 +738,12 @@ struct arm_smmu_domain {
>  
>  	struct iommu_domain		domain;
>  
> -	struct list_head		devices;
> -	spinlock_t			devices_lock;
> +	/*
> +	 * List of arm_smmu_attached_domain nodes used to track all the
> +	 * {master, ssid} pairs that this domain is attached to.
> +	 */
> +	struct list_head		attached_ssids;
> +	spinlock_t			attached_ssids_lock;

So ssid = 0 means that the list entry == master->non_pasid_domain ?

It would be clearer to just test that directly if that is what needs
to be determined.

At least these struct changes seem aligned with the commit message :)

Jason
