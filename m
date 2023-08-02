Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8D776D09B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjHBOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjHBOvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:51:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AC1196
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlf+tuUxbcyZLlTNEntGF9F+hgdad/6IeD71zorowL0ls5Ixqrk3H/vVTdiJqjGDGM9d0osDKpYRcUdwj+l5/H5xKMdVKN//7MkB/aTxTldzt4IU0j1LOT9GWsdCiaS00GAqMMZ/AVhcp0pqSTm3Xp22cu7B1kzTimPhishZ970cBj5Rd2SgPm7hHQ+pIdyaH4Y1qzlgN5k9/hls+EIDdft6SEzn6Cr1n3qW8FTuvdNNBV0vBsVJZTTQ9DyHRTAcwTKZEBj3Ar7auSiZiDOGjQ+8oDpNbVZcBrSYqjKckD4KxqX8fwGVdoXa6Strhma0G6M7W7r1SWSQIndj+5M7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVrQ0UQSo7o3INkIluyoozRerAuBHcpFftZbqjkfwdU=;
 b=kme5Qpw8PjT9woG2VAx5csFxcGrUzmsr+cWp1PUnZK9743OR7VmsgGmmD7RW28LLEYOGQji7AI5W8YTlxzMPi3imqpUKr0DEbsY6Bvw1J6v1tjG454zzGNwg3JEG0m/TkdfwJlD5eoMxWofeIhwdfrYacKosgf0ZPYlIoNRPplztn/m95l9jWLHDU7gg/hl9rE30jLii+H1py8EjF3YkwAVzLfRvxul6hw1uhDyDvne/C8QsUWE1tEjSBDlgwzTMVBYyXWlYO0sKWj4Ovtb+PK71pE1Mnq8MAUQh3Hr6wVXk4OeYsiN7iKAYGlrTekcjlDoS83V2tlU/WvqXpXD/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVrQ0UQSo7o3INkIluyoozRerAuBHcpFftZbqjkfwdU=;
 b=iBU7Lhl83xDnFRnjn1RpVeZXl6YIt/Ig8/+fUKw3lb8oOwyrnJi91Gg/6aSozINW/Rzr+BiGfkxRaaDwGlrpT/ITUGBdveqYxN2uPU56Cu18ubNADI53FnLlugwaymMDp8TkTjvcJtzmtG6s//zMKon917IFuZxQYMxJnAt+0prR2+lXtoCAi86WPxPHmrMyv5Mi4+N3vDMjKY5JhSLcGw1xHT8LOiQr/E8+CP5BhSdTqEtdduOl1nzDJyHXyDY8gF+ryMyauSpLX2JDdvuHTruyCqpxHi7JLFzHsQDC67aOQ2hi6WzOBkLSyGnFBu7q5GtNpXMLXLfOwTLod9LJPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:51:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:51:29 +0000
Date:   Wed, 2 Aug 2023 11:51:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, Tony Zhu <tony.zhu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v11 8/8] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <ZMptbm4BEmEP4Z1J@nvidia.com>
References: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
 <20230724222538.3902553-9-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724222538.3902553-9-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 570bedb8-4878-4c99-8d92-08db9367f41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXRFaA3kvaQuNUMn+lpCtIskfZ0V/JDyDjs/8ExJz11p6OZFr3g09CPD7LMm3J2+FAmWQx7iw4vhIf5J48n7l00akm0n0+r/Ffsr4zjwFRqHpnLaaEnIQF+V3/c9KbAmK3NVre19O/vN/HNa2WTOfoILtZQecANGtaZ5bzv8fHa35WhfNPj7TCGUXkYLDYZs/Flw1MOzNWFTMf8H0mQxAUB8bJOojKLJoOvnjwv+1bYcVPDCsH/T60f7IAPddQAoePD4P2lFmtTZJv3sir9MtxXieF+bsKTZePxCn9EVbcl6EBPyguK8SZaViWYSDMSDvGovw/FG4bmYg96rBL9gd0jHDiAPEOQJstulciLO7RbcnAWwElvdl6RFhmOVZ6GMyRZ/3Aog9cBlfQ6S+g1HtPV7B6ByacmG72QmHjeWtgo+Bh46laqpveYkmnzzoJHDduLowrga/vFFpQjkpPKRN7Yj1LVv3SAzG6q9Xv08Um+WD/iiKp6hyyzlJRX1CLca5QNtgpMvAjEEU7hx8Atl6j7SQEZzucF3cltbgevbFJNY8rj2P4kOum0dUw83d/qMgohcSzJocAXtSa7twQoYnS/pW2E+EVpvqQa7Cn5RcQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(7416002)(41300700001)(5660300002)(2906002)(83380400001)(2616005)(186003)(86362001)(478600001)(54906003)(316002)(26005)(6506007)(38100700002)(66946007)(6666004)(66476007)(66556008)(6486002)(6916009)(4326008)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W65IWVW1oWVxGcGLRwOwYyJoRDvulq26Y7aLMdIdAOQmn1AP3aAyWFnughM2?=
 =?us-ascii?Q?m9/qZ/foswv01VVAWYTqnoOgNUQdiEvF3RukyMAufm17Ps8fkjho0rXonBex?=
 =?us-ascii?Q?063BYgOaW4odvJBJW1OHbXb2lOn7qe59sAXqfr4l9qniZ+QfCkmd0Edi/TUR?=
 =?us-ascii?Q?RMFJMrhtO3dSkWOK2bEoNzTp9QHqXIE4MO3zvmm1nZhMQ0FDSn7i57WAefU2?=
 =?us-ascii?Q?W7DBj2LnAe1YB31xf9tHTbz8+wme4TT5q2HzUDgLSIOf6y4g8S6ZPdSuMS3P?=
 =?us-ascii?Q?38meE1UsLr7MGnrycBi7tM9+FA+bNi/wJWgerb7WMSTWEUkRW6BJy6KxZmgq?=
 =?us-ascii?Q?B7Ya3wIvYDeSual/x9trZlEXMq9CKjzPGL3CGg9xR+dsW9UbJpVefRNeUO4L?=
 =?us-ascii?Q?HP0S42VGAwHWCJslK1CxIVuwjuOHJZzPs3tSZMR0nJ0yI5ycQazXIFL06xhh?=
 =?us-ascii?Q?G810cJeU+s+Y/J/5uARDtOp444az11ka+gssaYVTYPquNNaw9RyXBdodTW6o?=
 =?us-ascii?Q?6si28vPo+/Iaucw8lw83uHdctANynQr1QxoNOHQ04spYcveM6wzSzQSDAgJ2?=
 =?us-ascii?Q?Rd+CW4A3h8OQcfYR7LBrP+e3eeQGDFEXp5i/xamno6CkDvxfS/XceZvSRjYE?=
 =?us-ascii?Q?PDVuH4p1jjG/ngl6dM1SHa0LnIkw5xiW0Pz0jOGJNDyMPoDXyyNwXzB1S2IW?=
 =?us-ascii?Q?1MMFrpKe+gFTsk6ATy/eIRqBbrEf+oSGudKZBd5S+QwTsxJx9sQqnv8l4/KO?=
 =?us-ascii?Q?JvEhasWxVgb8AmXuAE2S+22vim8+QxBE4m9lb+vRFxmi4OUXn+QhUjvvphHA?=
 =?us-ascii?Q?YsR+PKtfUopYVRIwkbImpeqRqEKnm7PmqNYf8xgtgfBAJJUhX8VtV+nPNj72?=
 =?us-ascii?Q?U9EjJEcqxyjxKBsvSyr4H3POiTm/NwD46pU5LbpDAqP5Gb5qiaQoOTYAZBvU?=
 =?us-ascii?Q?mz4vFAisfD51S6derGzuArGgVoBwtBBuDEmkYcqAr5HwKdyVqyGdaBeU33Q9?=
 =?us-ascii?Q?9VtuA2S37mN35d7fxbNMmdbL9kZH1pmN9GhW+Zj3WdEKzP+F/3M0hgyNCPUN?=
 =?us-ascii?Q?z/HE6azjJYBqWlLORMlfZhIS5+laqEjtdEycL+RhR3n/Xam3XlOIiDv/z6Br?=
 =?us-ascii?Q?ly0sOOq2uuJsG4GjsV+vruc7lzxciNPtImRpaBa3RwldHDqdcI5P0blkxF2h?=
 =?us-ascii?Q?9FZSnUAxFWApI9zvZjfXR3+/dmr2aaK9/46XikKE/AXlJ2S3Io4D+mEkPncp?=
 =?us-ascii?Q?00BfXLXJNvgjLW7jqH7cOJN6aOOZBWP6o2onHxHuaNt9dWLZhCQgvNUKb9jY?=
 =?us-ascii?Q?qchrOFeO4HqYraLpjpZ6v18ZS+HxP3cP7YmH15Wc3tPTTMyhTBxD6GGM5wKH?=
 =?us-ascii?Q?6/IsCKRXZbQOoaGJ6UPhHIu7DM8VqbZeKKGk+3XPQUOYAiMVlxpNAxOwD3e6?=
 =?us-ascii?Q?2z0iXk45m8059LQ8y61PF0+DOXfFY/CzKNHyPGqzvICtwy1v01NuimJ2NtCn?=
 =?us-ascii?Q?ui/biq0AnPin4j4m6Tx/wlWsJXtGQAv9YSBE4usXvLibWr30xaPl4iCkAFtl?=
 =?us-ascii?Q?TuM/hHKFHQCsi2yIvqMNo0P0Czt3wt6J0oe7uxNr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570bedb8-4878-4c99-8d92-08db9367f41c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:51:29.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52fgqz3wJCvCJKfOt8BiFTa8eEMmvZhwtLDpe2xe4geZlj9FLA0DeAIn2clVvKqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:25:38PM -0700, Jacob Pan wrote:
> Kernel workqueues were disabled due to flawed use of kernel VA and SVA
> API. Now that we have the support for attaching PASID to the device's
> default domain and the ability to reserve global PASIDs from SVA APIs,
> we can re-enable the kernel work queues and use them under DMA API.
> 
> We also use non-privileged access for in-kernel DMA to be consistent
> with the IOMMU settings. Consequently, interrupt for user privilege is
> enabled for work completion IRQs.
> 
> Link:https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v9: Set user IRQ enable when device is enabled for system PASID
> ---
>  drivers/dma/idxd/device.c | 39 ++++++++++------------------
>  drivers/dma/idxd/dma.c    |  5 ++--
>  drivers/dma/idxd/idxd.h   |  9 +++++++
>  drivers/dma/idxd/init.c   | 54 ++++++++++++++++++++++++++++++++++++---
>  drivers/dma/idxd/sysfs.c  |  7 -----
>  5 files changed, 76 insertions(+), 38 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
