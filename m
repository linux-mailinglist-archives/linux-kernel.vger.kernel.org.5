Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ECD7D4308
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJWXFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWXFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:05:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D180D68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATGioy13VD6K/nv+05WpYOzBnnciq39Uqmr44Acx4wNvbAeLWUNsFsqYVf4zUMaTL5FUdfGQaKO9+MfB7554Fva0xtvJA2YIp1X6K/+DYhrhZz1uFfbxNsHxHuGi0w3iRKbePRJ2Tzu0z15Kc7RAywI0shA6aH/bjmPiD/0l3ZUwxy1W25HXt/36ZfAyRxXfPk5aMOcp/dEObRBaO9kUQ+yn9T1MfMU9XChQHgY3gCNeCOiphgcc6cSikgQ+jBKNbdx2ervwru8EuO7T+DpALlGiKr6SGF3RpCbbCVCpB2HX4TYc4ySYaIuWD/I6rwgwq+idDqC714fx8abJ0mPHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTf98KYnCTe6TM7784PwvLi7+AcSwkoEDf628IPDlWc=;
 b=QgllVO1MS3RSbl9gOc8jsYoxxUuDyN3rorT/BFq+fPOBVnDHrogtoCjT8O/4rLXSB3kkyRosjVNFTt/TjTi1ByR2pVouoRwKQ69UYM6e2GOpAHM8wsaqQxXjBMEkiB2Ro/XsF16QFTQM9lXBsOBxNO+cduMna6ETVo3yNmUC7JcrvW9ASyDdMlO3thjp8i9I27CaEG9mcqNOTcyfVqvxWsQXQEAz6KUcIpAoF/CUlW9DnMo13zrN7fDBbfXwIZuMLUdhib6uVZUzB0HJcTFVM49zdI+IHcXdZ9IGp10v7MUJE7DLrvK8aPX4OAwmHiGMcJ/YPjjrAUuRIGUpon1vIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTf98KYnCTe6TM7784PwvLi7+AcSwkoEDf628IPDlWc=;
 b=Km43WF7xDqIuPVQAz37DjFbTx2xeSdv2eqHZxQRVr+9qazdxMF5Vb/xIAjjTFg05ZGXdFyYwFz7jr4PT/A7zZUTl+3YnAAWCowlSV4qPbS4a9IeBGLFBWAPRUJi9RN1fMtIT+uaXdUEEjDYP/L4hnVn+R5RfYABFIYogk1/IHAT9527a+NoUhSXWCGL61OGJctum/CQheAUt192untX6KdcUOz64PX3l6DDx5pXekHWomg2OzcpBnlGJnYnYh0VcdXcNCZdYcut5D6Fq9LSBFqDx+p0orSlyIxpPIofH+feisVEWoL392g257gsVDMy909eHuo3lZGZK/BozA+tWxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 23 Oct
 2023 23:05:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 23:05:10 +0000
Date:   Mon, 23 Oct 2023 20:05:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, baolu.lu@linux.intel.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yi.l.liu@intel.com
Subject: Re: [PATCH v3] iommufd: Only enforce cache coherency in
 iommufd_hw_pagetable_alloc
Message-ID: <20231023230509.GI3952@nvidia.com>
References: <20231023185700.11407-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023185700.11407-1-nicolinc@nvidia.com>
X-ClientProxiedBy: SA9P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 40649f8c-680e-496b-6bec-08dbd41c81d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8vRTHytfUlRKCE73etYRyYGsXb9uzDgrT+ao4oyKSDVv2Zj3e7O8oT5UZABuWiM+vTTrGPJZmId6NqVpuveZFBCZzg1kZwbojW6usGF4qmMtUof0/b7ITfI2VLzzLPYJ3q7HleoKRn0dTJGsRY7q+jMIp27anGoFJF3Ssz+y8TT8SIqIqaW0fYsupRBIjHBKJuq/KP6M9Fa/2BFEEd2AzGDMylJDg7Mlmc0YoECyj+FOsMR30sMViqFt6mAjs+fEIt30qQCVXHTbCASphzfZM0BW1o0mq4b2UAh8Uj61psCnSrx0A8vZWvYnkaWGxTX0wbsSX6kShlv/rGEJn17t4Lrgh8eKoWJ/Ygz7P3hVWEvvllXnIVd51nXD5zVMOdONv5KpoZsKGyzc9pgzL+iF0AyI7tzmjWA2FAmPzU/h+gIKDbB7WUGYJOvc6rMmcOpKzeLZAb+UVA8O1L/wLCyBFYRVeYrWn/syQitA6FFGSzEX7nqj6L+19auFth/GE7QT7ywYm+QkStJr7KC7wY/Q167oCMRp/mtZfZMuEymXCZ8gg71SAUytT9NqkMde4yxRFfmjkgAcCgWLZ5re3n4orDNuIcc/eHZ5SEWtOop3UV85yRVlvayKlfEZrkzbUMILXF3CEkeTbKM4cIYyLDn+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(966005)(478600001)(6636002)(66556008)(41300700001)(37006003)(316002)(6486002)(8936002)(66476007)(4326008)(8676002)(6862004)(1076003)(66946007)(5660300002)(6506007)(83380400001)(86362001)(2906002)(6512007)(26005)(38100700002)(36756003)(2616005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sRnaZzpNMh5+hSu5W+t6F2jGwumzu8fQcQwXhQ2O0ab8nzJuPuG/zXFLJMt4?=
 =?us-ascii?Q?9fmyGzm32jQqv05TGGRxwgwrWUm+i/SdyzL9UFq1HJdVnxDVO9Vs2YLEI6ZW?=
 =?us-ascii?Q?O+OV/G4zKA+DjMd/+XJcFqZKePZG9nBV5QKWnGyodMTgalaMFtWB3k4vloY1?=
 =?us-ascii?Q?ORu6xctUqUAv1FplZ6Ib54j0JDi1Th2a2aU/2j9sjDat6BBhYqY5RXrpy+q2?=
 =?us-ascii?Q?7CrobWeOiyBFuecurlStZ/zceOCtAZLRfHXLTkdeZwrlq0rvoaPYlmra0pur?=
 =?us-ascii?Q?4DXQ4URsL1Rb1NjExzJAwkegEniLzDU5rVQKxCWP9qPaWe4sh0zqVK4kQqHW?=
 =?us-ascii?Q?xwTZmiezK5gjuYmEpE0QIup3c1WkaotjVdXN1qOaiR2/4MbYsnMEVK4/UY3y?=
 =?us-ascii?Q?WTxkXFGu9j21Z36lMvwKum2LQcGb0Pz+jCCRHWXE9nqiLV4LBethCoKHMQkK?=
 =?us-ascii?Q?T59ccManjoxSUuLKNH0WXUzBHVmsTHvLicBZg57kiXGWEtspGbHVAII8I8D+?=
 =?us-ascii?Q?GUMPpw9gb+LtKFxJZhTKckngq1vK4CdyIj8Udy4oU7+cNoU19l0/F0CelrMw?=
 =?us-ascii?Q?DUde4k/0DUFyxVB/3tpxwv3QnnQM2e1ItnA7hTZe5OfAqd2TvZGqLQ2E2Gbf?=
 =?us-ascii?Q?MB/OO7ceokjcuPogxHg3UaYXFqGrBR8UFv4wXmeW8fVMO9T3drz54mQ7GFfV?=
 =?us-ascii?Q?aJioRTj1Ukci/fcmbDPWGnglxTWByy2tZtf1OAJS+Rkiv7ruJ/9+yfcexlZq?=
 =?us-ascii?Q?7/BqMjPO49S8Rro8mvw64jYun4k11QkwEuLiVH2oPcTNczWZlNo1mKFmJ0NG?=
 =?us-ascii?Q?IP7P2phu5G+wloy0Ak0Uvd4CHlIkfaoXlA4svR+vTHwInh3pWWv8vRstKLNa?=
 =?us-ascii?Q?BmePrgbBhugt2WXK7E9eyZZqqTbDoZrRb8inYsKuWTkXCjCYDMVugCUEnNOi?=
 =?us-ascii?Q?0k9GNE7URB7zKlvIkQ4+WvV5lQCyENHnINugc56EL0Y+FhpftcY0QfdSIenG?=
 =?us-ascii?Q?cPancdl0xRdFspZXHZX0PdvSlO2FslVAeuQLA75hp3lR7chvrhvKYH0q8wH2?=
 =?us-ascii?Q?EdUcCI9wFnUpIN9giJnWdnsYrjhUjlKedJSo1+z89O3EUZJ9Pzf1Tuwz/sls?=
 =?us-ascii?Q?ud9SaQ3ywEaLVWmDq9KHXH2zTaymyy4DlkUcVq566JRjiH1FyjKz5QFokUlt?=
 =?us-ascii?Q?t0zwX8t6hYJC66TyeDCj1K5rLWgi3loJUqEx9DpAZbKHxK2Y0w74MdDIPY81?=
 =?us-ascii?Q?Mx3JBXhtcqBIaUSAanUrvcBEFcanbENYTjDOKyKNy3WWVk9i7OXQbV4f/ViL?=
 =?us-ascii?Q?S2Ki4bIYk7CPK1hA8VhoNufSAO8L2q57Ikj9vEaoRJ7etnUaYm3oss0RB+g3?=
 =?us-ascii?Q?Vibywg6IJozdfiWkGWo2jFvSD0VWOWZ0JWh1rlRLfLA83LhsOXEYAAOlU19w?=
 =?us-ascii?Q?HAXNuU1ZehgqAWsZqNaSoLVrGXGYk3/LG1oDep1r68JPPue72DcNB0h5oxNa?=
 =?us-ascii?Q?aJNPuFJdwb6yyJogtNlku6/BPwpJXGvnrrTICtovNIug2pI1qJE0GmwYtpAI?=
 =?us-ascii?Q?Mk1PAhMfVAbQrnjRqPZQjQQ3SJgMhg4aBtVbF5vN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40649f8c-680e-496b-6bec-08dbd41c81d6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 23:05:10.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /S2k8UoTIp4qPINJ/9/TQnexilp9D6PKAMuG70tFHXmDHISkz9EnrSkF+sS3kN3W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:57:00AM -0700, Nicolin Chen wrote:
> According to the conversion in the following link:
> https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/
> 
> The enforce_cache_coherency should be set/enforced in the hwpt allocation
> routine. The iommu driver in its attach_dev() op should decide whether to
> reject or not a device that doesn't match with the configuration of cache
> coherency. Drop the enforce_cache_coherency piece in the attach/replace()
> and move the remaining "num_devices" piece closer to the refcount that is
> using it.
> 
> Accordingly drop its function prototype in the header and mark it static.
> Also add some extra comments to clarify the expected behaviors.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
> v3:
>  * Reworked the first line of the added commets.
> v2: https://lore.kernel.org/all/20231023035733.27378-1-nicolinc@nvidia.com/
>  * Dropped "fixes" tags and merged two patches into one (Jason)
>  * Added comments to the remaining enforce_cache_coherency call (Jason)
>    [Please feel free to rephrase, or let me know what to change.]
>  * Replace "num_devices++" with list_for_each_entry (Baolu)
> v1: https://lore.kernel.org/all/cover.1697848510.git.nicolinc@nvidia.com/
> 
>  drivers/iommu/iommufd/device.c          | 20 ++------------------
>  drivers/iommu/iommufd/hw_pagetable.c    |  9 ++++++++-
>  drivers/iommu/iommufd/iommufd_private.h |  1 -
>  3 files changed, 10 insertions(+), 20 deletions(-)

This looks OK to me, Kevin is it what you think it should be now?

Thanks,
Jason
