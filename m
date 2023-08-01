Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE9876C141
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjHAXxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAXxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:53:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE83A1BD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrybTMP7i3PFHK4Ieivsn7DhJ0fthB9Exhjbt8h6M4Ogrw5THfL58KnDf294UjYMwPzDdu+z7kX1CLZVEvC5kn7I3V4obtOrbJTcrUy71zZSOwXyoBAZ2ICct6wPpJWxctImwQuNWvOKp+L7sQ6sLS2ujug6k//r5HdZ+gghxL8hR4rpT4ZuekSwTgFeGSqKULyw3Zv+/j0WjyFWHxc5c5dk4AjL1HD9BJG20BeQXZ3S8qoT2wXiMw2KbgySEW7HdmOrgsE4xC4XUkra6fPHS7ONCTAOc/mpgcD2xl6VJpvbxG0gDnSrDg6OthzN0LRI8MUw5JHoMN+adLP3OcjY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AbfoO2Hlyi4EvUIdKhG9l10n2exRpp/qzQ0G2mAU6Q=;
 b=SL/goJplmZ94GO20yxaRYK5Dy+JAJZFkUOOx8MSMONeWfNVBzQIHU0mq0tG5JOa4Jvxgz/t2An91GKG4HBq+aTpWAxglyfHusW/c5QW3rUnceDORu5srFtb4w5iTW57lJN4CT8olQ9TaC+QVP9D+SDoVTP5HoptyU3O4xMcAy2HveRhSiGPwALLiNm7jU2kXLl1zCP5306nRR2x/MM/72UE6xANGTLfnjxO+ljsbdM9VzB3w6xUGOLAYw3HCn8BoxXeub83GP+Xj9M8DtYKHJZaxg6PgBThBjoetItGZ2yrp+bvDVFqxAIPJ1hUbDodG6ZN6l/XuTFn/qwdN2n4BlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AbfoO2Hlyi4EvUIdKhG9l10n2exRpp/qzQ0G2mAU6Q=;
 b=DL44Tr1rCjugxK35Wx4VJschqCI26LHGYNh9WEUIISQ1xHJ6VhAs9YwUWtlppJ+Pp+LnEEvWfRxeXJeiscS93ZsYW9jdlYGf+K7DbdqtU8Zv2cZ9GPpUYLZeWvg3enUEA0lQZ/bBTXKFcTQ6G+0m/n5VhuA7bKzNmQVoOmC3YgzavAaSmgYyiwJjV06NaFoFXKJrXG6gjUupQl+B4pn7ELtM/UhzmoNPAg+OoIRiSVjE6chFQfO1SkHtRNEIrdZ4MMkf0gZX/WfuRDQ+HYIMytUoxuAPJfTxVXoC16jHs39m6sqVRtFDVGNHd7JfLpE+IWdWySAnD+OKxx1kt3QBsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 23:53:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 23:53:35 +0000
Date:   Tue, 1 Aug 2023 20:53:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org, nicolinc@nvidia.com
Subject: Re: [PATCH v3 6/8] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZMma/qk0otN9eyW3@nvidia.com>
References: <20230801183845.4026101-1-mshavit@google.com>
 <20230802023524.v3.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802023524.v3.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
X-ClientProxiedBy: YT4PR01CA0287.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a19eaf7-ef3d-448f-379b-08db92ea84eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YH4StwGeoIRAf/aImMqHCKBySSWit9giiHp6bVUI1Yaa8Q8LNm1NHbvarkRrzt6NTxenWyp0MBsaZxtAi1da6U26MOFPBlwe2TDl3bb/h18YgIMyAnOf9i+rSJu4aKS8p8FVMlecXtf2jPh6hiexSapJVKzO7lo1F8JUafOZiclpCXRYG/qjzxfBXtcX4MtHWr+r+sU9J0himlQb83YXBxZjQaSJHZOxxz7drYIZMLn13SGdHXkmyTJ2hHLEJTEUiLna6YU0CiAou/NlnYhSiX9TQj32dFjwIRq9/ZU+bklpyXCU4sfjwxaitDimiIEeJa/HaDQ8rRBmEBqdxAPCTd0NrmfUDdPJfz+WVCEsKfP6wjkOLSNCGuLj1v0hWqHfwoe5fNwQzQEIIcZqR9vbvFgN3XzFFl5oh5dKXIFOBkDv++reaE21lu9mHsbiVGJ/8Q2OWDIQFONg7tF0nnH2cSzQ/93F7VS8zt4qAyf2MResut/ZOD9gEQTKY5Cn/WIjwo3XSq32Bor3nznsDievsXeKMNlPDMADWGsaqAG8XBAfwYWBCPxpACaBrMbgya46
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(6512007)(5660300002)(186003)(66946007)(66556008)(66476007)(4326008)(6916009)(478600001)(6486002)(316002)(41300700001)(107886003)(8936002)(8676002)(26005)(38100700002)(86362001)(6506007)(36756003)(83380400001)(2906002)(4744005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BvXhFei+sJdkXbXNJNLKoB+a74P0ELO/cHiSV76FJhWn1BB+g66SCNfAlLOU?=
 =?us-ascii?Q?exxfUp8m04IjXDWeJ7ilytDHU4jqLsxa/AwaJNSSm3N7rHWYmO81BYOLVyXD?=
 =?us-ascii?Q?G3HVb50cFO7729qZfnvHenKyjGsGJxy6yqPq+phRx+4AIYoHkyGtjIj/fwA3?=
 =?us-ascii?Q?dBABXsCITSsvU+G7Mgmd9CaGridR4iquCPcl0X6AYJGB4gMKfpUVEGnC2oNB?=
 =?us-ascii?Q?7yeD+AOgCwCx+5WBr1J7POFdupCrhxgsMgDiPUivSA6W/zRVru4vnYxcrXM4?=
 =?us-ascii?Q?VwQYe3R5v9KQF/gLrJHkaNIty3d+Ikjsaq80VUEqjsIRebcNp1t+xHukJsN4?=
 =?us-ascii?Q?HlAhm3fha78Z/078MkvrVYbR/suZp2NcnA+vBuB4Eo1r4lQJNtHtpVVKeQof?=
 =?us-ascii?Q?FeC4nWJxgMbmJ4CN1U18uPIneaCvpjrFxEeEIZqVjyPtJHw8J7dvpMDD31+P?=
 =?us-ascii?Q?iFWfIj6FHldsU7TFrl2JoP/RYvwPEkHOc3+qeD2iPqQDLINX8KwmQAPiQo5R?=
 =?us-ascii?Q?Resv9QQ1n7E+NvhMNZHkmCxtlXSLIunhJrunrxSb5R2xlkSLwF+LiVwYxH+B?=
 =?us-ascii?Q?joc4tnXsWYCfbM/TjR+qWQ+ePj6A+cUud5NptC+lBnUHwuFWlCuOt1Z19JHU?=
 =?us-ascii?Q?dLcDZieqMrjIJrTa46DkkZiTF7mFP+iV2mHP8rHUPTXqZRE3g0e1AutLONOV?=
 =?us-ascii?Q?YSaXfMdH7E2QOKf/J3tCeJaZbivwvrZhSRjckc3v7A/osatNbbL+KTWt5Ih1?=
 =?us-ascii?Q?06fsz670ZFLbUrkDjXH0q9prXCaUfbceKH/JBqptXOcfLpw/aQBRn8OhXoaI?=
 =?us-ascii?Q?qc5KZLVFOsGMIBsl85Ah6mWWPCbbfsgII93SUgd2uVLG4nHX0YN09mxh3sNs?=
 =?us-ascii?Q?g0+tPvh/l+QOGnct8uRgYj45OqxGp7jPMcysBp64EvNlWWPN5l0kisOSsg0b?=
 =?us-ascii?Q?YoTI30MwJESU7eCaUrcayQwAXgPhS11p1nGJ5nVJFTtQ4m0exCFTXddN4ad9?=
 =?us-ascii?Q?AgFPFtXy7EPU/Ct/veapPRKaZNscKUZ6G6lju1oPZ2Ml3KRwQ1AEEMR6JtY2?=
 =?us-ascii?Q?ITTEXYvKQxWXuD8MiBIdQ2AGf3CXbXLSmP5iPFlX32p86ia4Xz8CaJ5fbe0n?=
 =?us-ascii?Q?SFBsT6eFUB9G3YlA6y4E4vjRU/7OlmaVbWJieN0qZ4qjXL984aMMgNySskjY?=
 =?us-ascii?Q?8E19xNQ8dNCJ/rUDAcaV0faVLlf2/YP5i9gAjg/xsv6pdBS4nZa/37uXLutf?=
 =?us-ascii?Q?E7O34uJB89JmCWivQP2YTNf2bwtKAvHY3fH4255pipuFlVYXwp3v0vLJyji3?=
 =?us-ascii?Q?q/S9GM3qeuDhpWxB6f4KY7CUc57UFzT+VuPfhW+5wVbNpeVLT4K19lWASJp1?=
 =?us-ascii?Q?AVbDV9Oauyv+ZL9zC70OgPlxOOEmbxX8ZmW8ERMrd9YI9zhqJ67YQ21SCkjx?=
 =?us-ascii?Q?f1q40zPimZTKFZDY3JTZnipR5BGdNY3uPW8PW5EMxtcPKRU6sWWeRYcTljKM?=
 =?us-ascii?Q?oWqdl3gr0DnET+wtLYYWNjVc1xX6AT8CiZch6bnVAYUcAr8x6OlfWzDt1KKo?=
 =?us-ascii?Q?+aWA60yCvLkmP5fFBl63I4L/9HELGqCKep4UrGAE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a19eaf7-ef3d-448f-379b-08db92ea84eb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 23:53:35.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkTbyNN3BI26/r5p7zVJBamdlBxn9ISduBk0gYO536fYZ/3wH/2zzDeponThBuW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
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

On Wed, Aug 02, 2023 at 02:35:23AM +0800, Michael Shavit wrote:
> @@ -2465,6 +2440,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
>  		master->ats_enabled = arm_smmu_ats_supported(master);
>  
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> +		if (!master->cd_table.cdtab) {
> +			ret = arm_smmu_alloc_cd_tables(master);
> +			if (ret) {

Again, I didn't look very closely at your locking, but what lock is
being held to protect the read of master->cd_table.cdtab ?

> +				master->domain = NULL;
> +				goto out_unlock;

This is only the domain lock:
	mutex_unlock(&smmu_domain->init_mutex);

Which is no longer sufficient.

You need some kind of lock in the master struct to protect the shared
cd table and everything in it?

Jason
