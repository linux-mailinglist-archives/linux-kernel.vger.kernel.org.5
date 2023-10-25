Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE77D6B12
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbjJYMRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343606AbjJYMRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:17:15 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C39129;
        Wed, 25 Oct 2023 05:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyCbWjw10MmX8FzfDjLR0vBalPFfaiN+Nqt9DEhl2P+uhe5vkjVwPDIhUeCvdIkYjwCMbdPzJZtuLrbX3/M8fxe8Ij+K1+dDL/EwxdnHmJPef879UQMSgLNxhSoS322ufSU22gFjJ/HXqU5RFyM+aqGH3gyxQnU84cNkepMI6AUo0qL5BEd6IlqZRHZ8SpRPnpg1M7FeRT/cpKPM7u8B/jweVdG5UsmpSuLHT7wFUgpaew8Bsm421f7Z2nUG7939EBj1P0q9lFAeuAjiWQMl4bHdarBtj4PnvDf9enIpFlCvi74DMI2ovWKQUp+lUVbfhqFyxONX9ESU04aSxLZ84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tu+2gb5YViUp5RY5+zFmPh2ko6WQ/lWNL6Ymgv+XIbw=;
 b=U4U6xJeZOqkaSeoTcL4kyjjEi8oI8xJBNXxPfbczd9Fl39T0/aIFLhEgqceF5Sq+zfI5E+d4BGJTV9PO/bBxtPQZYZP19330nT/NtPcpRnQ0WaenBR0edniKa5bwWJOmw6cKN2aKTUdIHS05/O1kzGow0+8d8Vy/jfSmpFAtUC+fmO8w0SHcvCVxtHCQDnKu5g4xAvSOrYHzLLvTZ7FwDzbBc5n87+IrGSEtfDm3Hv6eiSFVoBu4PDwvewY5LW5yoduljNblqSuokB2S2yUq/DnIice82ArOb7b3GZMz7QO49bByK9+XY3XekJlAmR+6w2HPfXE1qex/4butfrhSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu+2gb5YViUp5RY5+zFmPh2ko6WQ/lWNL6Ymgv+XIbw=;
 b=NfPcGu+dOtkarHobUM2vy7hF0BGb+f/+bQ9zKhDIssYTFgCv4oOZpIFJY99JidPCBLtiwpfJXXQQ1+N1Z8MP4U9Kr/DhNOWhLFJOfBEdsOtGss0nHQPirxgdN70J7j3XObRaTkuqF0OMnX4jRpL7BDFdVyIzFzhuwHOqAOpqdOOyRyMz7oEsq8+wbDomunCrWQbiKWthfLQN+0YCZZg9wzd5NKiwIjwgYHSqEwIcw9TWm0gT985F1H6VwAq2vF9sUzf9Efy7R9IB+Kd6QP2aHYNdPXO737hHcrX+gEcIdw3VN+yxQwD0OIqGPrSV+6GqHCehxOqu24cXJz3C1J07pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 12:17:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 12:17:10 +0000
Date:   Wed, 25 Oct 2023 09:17:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231025121709.GC3952@nvidia.com>
References: <20231025154420.718e27af@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025154420.718e27af@canb.auug.org.au>
X-ClientProxiedBy: DM6PR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:5:174::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 401ef13b-46db-43e3-6b0c-08dbd5545088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLODbergEED/xeCoVIrmTqR2Uq2MQwMianyqEgvVWaG92oscscOPpGf5+2piQWsXrYNbzqwgu79IGO8jGoBo/x6RflCSt5GJ+9T2FgyenoDCjq1HJ6NZAdyVhiDPSSioDkhxmc3F1d0t81rzmJxdxHg8T5D25Cd9txqc91JfuuUitgXRg4sM0OY2BmzM7Nvjpy3jrRvUjU2qukf/gUvyaqZPrqiK5hNDLkC8KxYapAtW0643YOXUC52ybhHnn2MP0CmvnuMI5/AN2tkOXl/L5Xs+0aQJyAbntdtMp5rE5KSHc9nOeNBVvgycyWy8GMH7LLxSIHbwNKoL5jMTRKTfLfDny05nU4pYmLACgMCXDscCQUm57593fUIQYTHJ0Kv/RYT+skqmQZU/oMN1s6QpHQDPFeIH8sylwerNDGEytY658rOb6z0awIeGR6BBSnKvpHgATFUiHRNEXDBZ6TVsmTzrjpnHuD1S8DK4nw3yKHiWFTxx6EJd2PJxDY62s1Ki7+8X2gqVyqilxgCPVn/tV2s7UtP8pbuRiRL+BmZVYj5pq9r/wXiWWaBIHJUiAsDy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(36756003)(4326008)(8936002)(8676002)(26005)(33656002)(38100700002)(86362001)(4744005)(2906002)(5660300002)(41300700001)(6486002)(6506007)(478600001)(66946007)(6512007)(6916009)(66556008)(1076003)(66476007)(54906003)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FGbLLhDhZFzm000KB/m3X75FnoeAGFdpKPkfyXHVNlR1PCWCJ8jxk++ml8b2?=
 =?us-ascii?Q?6qc2Tv4caVzuPxcFJ5ACShKrzIvt6OR+h18SP3PS7xnw0sWCZPPj0TauqfsO?=
 =?us-ascii?Q?TmF0sywTI4YgHm4Vkmg2YV6niFbfiNoDBEPH61aSHZDOawnZkl90JsIaQiHg?=
 =?us-ascii?Q?uE9p0KAzz29rKIlz3G0zlmhkDifQ2Ypbc+I6TwJHx6610K/+nJ2nW6YNEKHd?=
 =?us-ascii?Q?GSA/bXjHP7zut6Y7VTHzULEmr1mT58zhpNhLa0RsLiyufhSob040WPaSTFhX?=
 =?us-ascii?Q?F62L9VSnlwQF9OI9rkJOCoTy7jbkTzS57cxvYLJXvItZA1DrwtbK71Nz8uSu?=
 =?us-ascii?Q?81k3xXWUTA6nOxHeeHiFKivu0AhvqDx8/xJTczdXbtzeoD3hZ+z1uYuGLWdS?=
 =?us-ascii?Q?m1F0srPXQNkXlTOuqeVq4CQ9ZVqFzzMqeIjUba2AibvSOZ5y5FoMioESR4YD?=
 =?us-ascii?Q?MLx4IW70aZ59mQTPVBXmEdt+QPtIztVKmsJ32c7qNHE9qvTP+WUSvP7RHN/B?=
 =?us-ascii?Q?iSC8O/hK3i3eb+zqUVWRpZPrnyGuzfUHI7fxK6CSBl7iXmmoUJoGspbrUAre?=
 =?us-ascii?Q?tmd3amVhpsu7J0CfIxgujTSEybCd7LGC7rEtPIoekIBLTezxDV6yvqoYEvo8?=
 =?us-ascii?Q?WgezDbD24XbaNhCd/xLioepOoeYzSyS7yMWxH6dFCokn671pUY1evKbQt9+U?=
 =?us-ascii?Q?V/29rOMlbLPvIB2txJD3WWiMg+opUiqWXhi30I6xC0TVSv00Xpi5smLgqSca?=
 =?us-ascii?Q?IKMmZGveAz+J838m8fjX93Lzjej3jYAKbnuUAwUDOfhQgzIPQ7ixlU4gAVcQ?=
 =?us-ascii?Q?Ckx0Maz9jCD9n/cD9W28twlcijp66UzDijPLRcs7WqV7qZHWgEOoRPmqNa2r?=
 =?us-ascii?Q?+setuU4KNnwKLrdUiEKzS3S1qBW1lYTTcIRR2jSWsQAY4ypfzyv9MXG8A4pJ?=
 =?us-ascii?Q?8v5xxzX8esc3c0XRvgl8qfWbN9V+sh8yYqg9vw8LbUXmTqKVt4lrJTndaAIn?=
 =?us-ascii?Q?PI5WlP5wsyImSQggv9vi6/QI3lzdpZ277YZGnzprtskCaT1/FuppJrobS4IP?=
 =?us-ascii?Q?N2Qvith1HtRrMtWR5zRRLdJNL7SNkABJmDneURQH2Gbp9b8aIbeP7VPZUK8S?=
 =?us-ascii?Q?F8M1ZY1V8EqJe3CPqJXKvKdKYmobkru5m4cCf99Ll+Lmr4rEk+bzdPfM9Fso?=
 =?us-ascii?Q?Md+miD5XQM1A7UduincgA8HpDB2iHFCSo7coqaRN4IYEiD9fqjg0skaer+hF?=
 =?us-ascii?Q?/eNTZAIukI6Z0odAA71rLBa1NVGXSSfBLZGLtcHURPlISkELnstdv5/O1Co1?=
 =?us-ascii?Q?zmsnRO6qRTRX9gnehp1GFxIk9p+a9IuvqODczvnae7SfuXsbPhfqWFzozcIu?=
 =?us-ascii?Q?HthcH0NZs4yHtSv0hLJh1ppdJxhz4fF0jFUBgmUDOIARcpopDFXnFRIwNXO3?=
 =?us-ascii?Q?io9N7mug15e9sLoOkIbU6SN/eb2ZV0LY7Ywha9Ctya6e0yj5APOPajaGNdXb?=
 =?us-ascii?Q?n2Z/G9709qlNOzAhPkn1ao9jUqW1OUp7E7HPGIrOzqyZSw1xogpuEGYuJAB/?=
 =?us-ascii?Q?qsihEpQfm4gdbwYPh5vQyHciD1hCDChKAw/xh5Of?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401ef13b-46db-43e3-6b0c-08dbd5545088
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:17:10.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5ko8gdKxvjJWUr0d75rS4WXqwe45muSp5M1vsGa4uukGIwVXE7Naxl1jppndt8G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 03:44:20PM +1100, Stephen Rothwell wrote:
> diff --cc include/linux/iommu.h
> index b5b254e205c6,f347bf31761f..000000000000
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@@ -64,8 -66,10 +66,11 @@@ struct iommu_domain_geometry 
>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>   
>   #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
>  +#define __IOMMU_DOMAIN_PLATFORM	(1U << 5)
>   
> + #define __IOMMU_DOMAIN_NESTED	(1U << 5)  /* User-managed address space nested
> + 					      on a stage-2 translation        */

One of these should be 6

I'm going to change my tree so __IOMMU_DOMAIN_NESTED is 6

Otherwise looks OK thanks

Jason
