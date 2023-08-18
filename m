Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6E7810FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378807AbjHRQvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378774AbjHRQvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:51:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5456C2D64;
        Fri, 18 Aug 2023 09:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfH/otTwOilZnJaFdt8oWojczcV3uJ4gWBhzCJB831SHNmFDGGS3E+WLgv+l79oB2Wr0yV0Zz/DAaLUYoSvRkYR+yAiEBgydhHKWnX9gyDo+XHwXOQphu59WFwDQffvqJ+f+EKT2QMn4E2KXkhlVmu8cTsatX0I81agIsbve28kpmfn3xbwBCKrYUCBgd7GSlZp5DRCOQn4P/wXdEaXlkjX1nYPZzN7Vq1FTw/wGKfTe5W2N1LnPqv9ZeE5wu9UEgYNhsqdfYHmNpr2W1OlmKrtSiY21JYJW3S2/oiBv3+/x5NdQwRTJUgYOjHvOm1s/c1EaIOXaGCOGSXI1x5nfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWy3MqAmy3A1zOkrWt3gqIcP8Zk3sUZ5dFlzQEHYoEE=;
 b=oXx4byN3eOAJ5ryNXaH7R6PLZ8huSQSIgbCajZC9zu35ojgsH9H604EmN7vwxLli6Neaz9fIWAefxFM7ERkFuETBmj1/or9jvZeVxukJ4qYQu6TPlgZ4dAl8ZBdjRTDUNIXMSVKN3+YU1ZGVVteN0f447kBxnpu31O3FH1o2XE8X8zx+GIX/HYDjJKxUrkb1uNCSit+mcZF5566Opfv5JG459+Dv/JDyKSXxFOGDyKM9pUqAYvtG1hje+PV5blqlUxr8picr1+aAMEp9Q769lHtgpg8ZRqp+25BZgphZe4VtQORjb3K6D6nhnhVydnnDwnX1jB/xi60LUNBO31ccBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWy3MqAmy3A1zOkrWt3gqIcP8Zk3sUZ5dFlzQEHYoEE=;
 b=HGYM4zA9aWurWxXyMxuIHYPadKly2ei1NNDQVg4Hl8jL6K9bN+K3BLRB53u7p+9YcZU4YJG/pP2LaLRq4vBW+z4XL1vGBiWh/+qgLYoJtQuW/uUAzxZv8dIOf9AeaJaPqDCujeSBG+gj0S+kaxwlxY7CkowOu30FyVoTUvtenI+4mnwZjvxQgPtKJblD/06pK2+FwX3n9kUO20GCGvXHCdQPW4itsSTGLkoNfnpcXkGRxh98DJcrRruFPodfZMyPRGqrOAxi2STGPXc6zjbebAfH91whPSkFpFDgMIHyVn9Z8tp0F/ktqyQdxsH4x++7cnVFAY/f0j5bokxntvRA+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 16:51:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:51:02 +0000
Date:   Fri, 18 Aug 2023 13:51:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
Message-ID: <ZN+hdYiubQkjviwI@ziepe.ca>
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
X-ClientProxiedBy: BL0PR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:207:3d::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 9400bdb7-fbfc-4cc5-0767-08dba00b4e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MckZO9GX2200qK8cRFCq8uetipJd1Vs+VUVove04fqaEb80OBnonA2IH7cS/WL9xkEmhACinpIpv+hnQ4HbLQ18jqoZeo5xKISgRgmE2xlkxQ+xog9IILutsW6vNjnZ0JlBI+jwxSpETNdWF3u6+mopYjhGyRjBR3cpnvtR4u7NLfFIo/2Xnk4U/b+E1TeqfWH7QgLHuRU8GuNQSiZX2Hse1n74mt8InUpJEkzCPsJ7O4AL50fj2P70PUvlJPDmAsgEjTHQVP35Jla0Zvw+SWjr0gQd4c+oVHI+MF4AZ7jfcIHIkM47N3XUfXjWz2ALCa29H17w32PJ3idLJC6nU5nq5AWsATS/SZy6mkDnMTDMjA/7oF+eOV5TQb4azWcQx3sMMEGTMokv6MWrQjjSmGT8oMk3xBG4Bu7Nj+Xa2hOKd0zqVuvr+SjKzqNCuoErOG65tsnJnmcmKKjUpM9JXlZDvgesHPK08csMe4irfINuiZx5CmVoBh0zF02JXJ3nbDZnPxle9uH9QZahbxexEHFaczmXrVrdR8KVIHVNouKo31Vw+3dLu88dxMR/PHIeh+IoPFgoWnPT0heszdd4bbZvhixsD5yFt10TYCSOoqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(1800799009)(186009)(451199024)(66899024)(4744005)(7416002)(7406005)(2906002)(478600001)(6486002)(66946007)(66476007)(6506007)(54906003)(316002)(6916009)(66556008)(5660300002)(6512007)(4326008)(9686003)(8936002)(41300700001)(8676002)(26005)(86362001)(36756003)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GMc4OuAGNQzbLAYQY2PIzWAX7tHhgXnmzqVyAuv+cE0Wkas0ApV+cTxqTp7G?=
 =?us-ascii?Q?7RNunQdYfONLsFACN01YkGsVRXVd5PjX5mQwqVRtttYPSE9TSDXz7vq+dh0k?=
 =?us-ascii?Q?TZMhBaVLCAkNgHjaS4GTdxZbXGJuvqE2WwhzehAUV+WkQI+edlP6yJ2RoJ9M?=
 =?us-ascii?Q?hDSGDiz9v1GQs5XLpuHVBMnsztmigQX3ZF0y8JqbV2fsHK7Ov9gaSmk2TwvO?=
 =?us-ascii?Q?zB3S2C8CMvVsnAPlTEcAxXL1LL4rPQujd8YH/9+BVZQE4KFcHrHoERKpiSk2?=
 =?us-ascii?Q?b8wDSqyvq/zAaPU+2V3GSd4aZziduUi9NXzpLksZGGDggfppYvexzzcYSN9C?=
 =?us-ascii?Q?PJog2RXWUdBv5/xj7yGVuohnpPewtMNXh17ZawJLT9JB4b7lMWOLRy/fRLxX?=
 =?us-ascii?Q?6M1VO664C2kyJCEsKncEoLU8mq4JrpkmIkCj3X4kHGKLOh+6RH8JVGRHC3js?=
 =?us-ascii?Q?ZR9BhAtrpkUngirgRvL4j82idBav/ekqf78dZj3lCnHQGoxh6vRgbfaBPQRQ?=
 =?us-ascii?Q?nF6rBzYn0x7LD/zeJEEqA+3dd1qwdWhSdj5XibdyosiOtc7iNgef6KWHXgmJ?=
 =?us-ascii?Q?8ryINA608j28n+s8q0/GNohw8lNAMk5t8t08GWrjRx8FM6gi8QZBNp9jmNfh?=
 =?us-ascii?Q?Ncu/DVFVEFgJsqAISjAWxiRDcva/5Fwd5vgN/0zcGWpjKW7k8CMNDlst9F4z?=
 =?us-ascii?Q?k4BcSyhTidwJWuYKHq7KH1StQz0UbFzEh9C++sRGLRB3Pzx1BSjKClbPheFV?=
 =?us-ascii?Q?+DmCjiUjcup/mVvTkjM5Goyh/6WEdX4ta9vPNu9yyAGXFCtjDGK3W11s2tMP?=
 =?us-ascii?Q?BUxl/Tpqlm71pRabRvZnisa3e1kMs0oZ/Mt6OGU78YpUMn4M2jMkIOLnGmZO?=
 =?us-ascii?Q?AgQs7Xs90ktycSwkya5HZjHfXBW6O+S0FNayg0LBmPZyQVA6i9rAt4UbSBjn?=
 =?us-ascii?Q?BRS9l59KsyeLj/kMJ09Wgu07MK6m0WiFycm7V7ywtMsYnzpCDXxpBO5Vb/Fe?=
 =?us-ascii?Q?1QwHgV/867/rb1TYm3Lqq60Cg1tHYKx4FxxH8WvpnPnEV3kbSvxaI/Krr9j/?=
 =?us-ascii?Q?t64H10pV+jrYCuK83O+b9In36K+XA1W0VzUSOM8I73P5nylEnXC9lD5dMhe8?=
 =?us-ascii?Q?7MF3YpdDG34VdVwHtKe7Y7gSNpmpvRafY8hXtOjqGi7pWelOllbeEH8G4QH/?=
 =?us-ascii?Q?AuBK2Vmhglx99crs1WQWDcwagUH7Y8EJ1TyXc07Xnf13bOhmLziYZKtmNYVo?=
 =?us-ascii?Q?aoE8JD9ZVYfoCrcOQT3Di2y84ZPtCeLwodnXWgg++ECg8ot3en6RVpc08Mpy?=
 =?us-ascii?Q?UAgN+x1Z1jmWNfaj2C6l/SwMJT0YLLL1JMecTygZcUF5M+OzadMRl5SFiilD?=
 =?us-ascii?Q?wGnW8UkaC6U+3Q81qw6NFLyV1LJhpzR9Vr4czx+fhZ1Xho+syZOpwgUNa76K?=
 =?us-ascii?Q?fF0lm/St9MFVm1pwNxZ/+GlCyZam8bj+jJyhBc/FWKdMVqK2bwLsnuG8scbr?=
 =?us-ascii?Q?f1uiwseTZFYEtPVQiFjFrOGcEMppzBgRf2L6pgrbFpUhheZbnLZyaAMt8Eek?=
 =?us-ascii?Q?TJOYbL9oKCj5myPgNKRjWaZBi1rghXlBrlFUrSMb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9400bdb7-fbfc-4cc5-0767-08dba00b4e7f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:51:02.7147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6z3FWapc2cHzyAuAVFEYAxWmtTwa7HqsfQbPwYMnsi7jS8PNn8soMMN61k1O8JM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:00:00PM +0200, Niklas Schnelle wrote:
> Hi All,
> 
> This patch series converts s390's PCI support from its platform specific DMA
> API implementation in arch/s390/pci/pci_dma.c to the common DMA IOMMU layer.
> The conversion itself is done in patches 3-4 with patch 2 providing the final
> necessary IOMMU driver improvement to handle s390's special IOTLB flush
> out-of-resource indication in virtualized environments. Patches 1-2 may be
> applied independently. The conversion itself only touches the s390 IOMMU driver
> and s390 arch code moving over remaining functions from the s390 DMA API
> implementation. No changes to common code are necessary.

It has been another month with no comments, what is needed to get this
merged?

Getting the arches converted to the standard dma ops is a big deal,
can we please conclude this?

Thanks,
Jason
