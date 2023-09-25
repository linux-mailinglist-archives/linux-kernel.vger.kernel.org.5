Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0647AD978
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjIYNrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjIYNq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:46:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D6CB3;
        Mon, 25 Sep 2023 06:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpZQZj751Zwjq3nrNVdawky48KABXz0Rkkh7i/8Dc8V98w8gcVYfasw3C+ws+KtHWs5mZB/8ZDir+Ocmsa4yMdKppZsfVAPqLi1jo6t8gsQB8Z79vKIUNbUWCpzUc95I+SGXzBqPY2+KizyU65lR7Mbxl7+6r5xOQ7D3XZDFp8YkqU0WZdBEmF55Hqtqn7DcFJvfQIsf6EPhhL9YHLLhOMZOL4DGLo0p8vAFxWBQwkbRuCPOMHMLMY1KiDDAc5Bq42beREJTcHvpJHo4QThrATsEpBIgg+b5Mcoai7THwS+/VH3/kwQ0W0u/Mo6PFByxKt5tZ/zsW0lS8RMh7Hprww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPhOsksxiW2H+qmbctn8ZcR9Y/mtRIyyVectba202bU=;
 b=jrhQW7zAhV0xPEJKJtigXdk82fPtPUCLj1cOFu/f+CGKS3j8C+4WSuLomOZkTTEb7aRvzVlFhL3pLpqmX7Hq9wSLUxzZ646kYUS03RkkNPsm5HusrEquzCiM2+HWAC4NQglzUUwj3l9Bg3erPDf72lvPYYTe2KKEwVk8U5hcZEjLkK957+5ZNeX9N2m7yIPjbVvpv7m8pJVlUTcGrWg7LJHRMiS1SWnaTIk3Ya9CpZQV1af1BeaUvyzTOyy6Lq+H2ZL18JA2Y5jn9EhuYIFDp3wTlw0twnJIGVDYf0iyfE2ATm20mE07+GydiJ0ePZu0CkYq7DdI23gC4sZFZjIAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPhOsksxiW2H+qmbctn8ZcR9Y/mtRIyyVectba202bU=;
 b=MpunAQD5tZWrsTwyoTEkzP+C6FPjhoGvB3KdLOTK5YVXjKHclnApNN6W7/khcjW2bX8j9k/6CO9pcz22G6r71ZhzFhpdXQNT7YFeXgoAsyLbqNDl/O1yPNSqnKxrpCVuocO+Qw3us9kPhdY/JPSQi3+GrAhxsOOugffzIggyyixeMhJAktn/l1YEzs5zmI4TsVBayDiatrdLTC81P8EVv2yyzb4toe0UUHo0iNuZoLUyUfXsSYaKul8QopZkxhuuoOSE7nSKbzAjmly3GqCd4AddVN9ErBjx9oDwSnvNCPrqJkswm0WABgqm/hN7hu2cadOH4vBCLABV7ckMEXzNUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 13:46:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 13:46:48 +0000
Date:   Mon, 25 Sep 2023 10:46:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC 6/7] vdpa_sim :Add support for iommufd
Message-ID: <20230925134646.GC13733@nvidia.com>
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20230923170540.1447301-7-lulu@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923170540.1447301-7-lulu@redhat.com>
X-ClientProxiedBy: BL1PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:208:2be::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 0592dd27-acc5-4d54-bc44-08dbbdcddd1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lC1mlRAP9RZ/Nv2dC5KM6xLkpTTI5k+mdAPmaXjGzp451YK4CthAt+SsZTdx43eRNZM2pkX6J+Xky1nX5DeXmwr7mCkCD7JSsKyI+kF5WsdlGfaDS2GDlQmPCYeRThvNdP4iR+pyBA9l8nSzUuDvlNEq5Bm79aIcWSEIiUwqw6r1ONnbe/Wg+SHINcUTKD4xNDiaF+/Ya1HG91lPaujOPM+Te9ARG/ZbSwVxN2nmPIueJ0WNxVO33xOfnAseC98nrK9yBVYjVK/bruNpsKGqVqgMu753GSuJ32f/IWBHtiHQkV3x1IJ+N47HrOSculf6mtSooJXqwLRg19EvnvOGsQIB6Gp/VN2LDL4Xe/TUicRg+5UxFQLs1y2ApjwX5dIAWaWRCpSsoe7FXfgFiL4CyGuAJkTM2cQKy8nTygigFw7/XwXa6RZMWqzuS1zlC1+BUEtvspvuq46gHrYzrpEb+C7T31K8Vm2SnE+s5i1fQA+VxKPX+OSzUcr6MYQtSN+chL0rJaiJeGfQMWy/g6iM5l3TQ7hdBblGOiuO1DA95PRCmvMERgC9kpmc2LhPV9I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(186009)(1800799009)(451199024)(478600001)(8676002)(6506007)(83380400001)(66476007)(66946007)(6512007)(6486002)(6916009)(66556008)(316002)(8936002)(1076003)(5660300002)(4326008)(36756003)(38100700002)(86362001)(33656002)(2906002)(4744005)(41300700001)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5mneuuNa4820R8KCBeT/nTVPab1YsRD0E00wmF4cu0M4+PSEk8DiXBWRcY1Q?=
 =?us-ascii?Q?TubstUxdUCMpqxm7FyEJvg0yoRWAOY8hdshf2Xy7LnMFYmvNt2c+PBpR0Mpj?=
 =?us-ascii?Q?4yIK3kngDFOqKVUuYTQE2xPzi5pOAcTy5Vm/7gTe+NOMhTYmuHEShFvoJvlC?=
 =?us-ascii?Q?1c2JKI5b/fZhbkK+wSoZ2UP4GzvEig03I9FW3FcoN95Q9JKYtECXk3AfkYH1?=
 =?us-ascii?Q?WwgaV5I9nbkVQ3l2+MkiVwbP3+J6mNFwiPjMBpAGpay2epJoc3GCJTTjoT+i?=
 =?us-ascii?Q?GQB7y8n7CDGzv6isnqRcKP65UBnmkDx8weXgf5jM5teiWD4pQgnIFODDWM4i?=
 =?us-ascii?Q?FQtkYXkfrdqultX1STUiY53RHkjjKMJSKNSn60gs9+el4rs3IvsL5rHZsiiL?=
 =?us-ascii?Q?5qSXAj2aEU91NSf2VRu2P32Lleff3EMBLmizeJu/N25Cn7NBdO/CIRqwYOLQ?=
 =?us-ascii?Q?pysLoIarvtSyrA1BrFXXtHZ5MqCqy0JXcr8l83DWY8VWC6z719d5KnacrUHt?=
 =?us-ascii?Q?x+lSZcEnYbWDiwrDdT4Vwj+eGvV/t9OcdkfRJ9wOlI/DmUwjYgdTmETJ3fXX?=
 =?us-ascii?Q?OopF2ZS99L9C+GrayVv44RtXnPRCV5oRlWRnMUrDhLgJoDI6pAdYDwGwAL1S?=
 =?us-ascii?Q?3cMsLLrGUfvnNWEh+UPT0i9EyzeAAFOAe1kpCOridKU/dZo5tHu0/IiICPQF?=
 =?us-ascii?Q?XQ5oXb07a9fNnGSc6RUjZ2hX9UWnFXxdS4idWk0wVSBnLneapKw793RiJRNB?=
 =?us-ascii?Q?+ZjW9L7iV22KZWhXT2Vs5P4Lo2zw79S0ITp6RbUX510WLqFHOeuzgXUkRQpq?=
 =?us-ascii?Q?ZxzxIvQXphyoCnE2YCZDfeuXITceFPzvUQwnYhQPUlu5Y20/rlTNXXwn2IHY?=
 =?us-ascii?Q?pSQ0boLlDNubgnb4X0dAevGPF/PxsJh+wpAAMpRDLRich92qxqC8QpjIyj9b?=
 =?us-ascii?Q?fv/54Mma1KoRrkVBjA3VokUI7byulOiZwq2dBhQzOIgIwSI8sX03KnF0ilpC?=
 =?us-ascii?Q?ck58iSLKaCP3hnl0bAyT0C0symS3SXLuAYZLgpHcbsPu7BAdRkhjdcdD46xl?=
 =?us-ascii?Q?XROX3TU5mnhtfgH7gd1qCm1Zjg/ArydP/RPy0UEdm+sDvvp2erWajdytpyLZ?=
 =?us-ascii?Q?IUIeahEMSu9SiERTxVRJUmT15se5VcZ+6uPFEwGZXxDAOSYfMg7t+Bd8Qd5o?=
 =?us-ascii?Q?msC9PuxgZy/iBD/AWCzoeX6fo3hCRc/ni+w6c1gRGEzXukEsHbEgLiH0KC+l?=
 =?us-ascii?Q?g8BrJhEG++uXBpcA7Jx73ZIZQPaeIHktr5N6BJzXjL3Hk28djLNOjb1d3eyf?=
 =?us-ascii?Q?mcz7I77+UAgMuRG52DGuC82o+FVobXeZZ01+2thVZBShogLXN3aV+LjMJxA3?=
 =?us-ascii?Q?F2gZgWeeQTJklQ9TrZxaCjklBbhO2Je6cpsVz72AM9DsgsPudlGmOyH8HIQv?=
 =?us-ascii?Q?DSNafkFZW5AyM9V2BNyRfUmp045PBX8qNPvq9q6TkjZJGdcSmBnMmXqBRE6p?=
 =?us-ascii?Q?ZGuWzAlXSSrly5vgB8Tj42uWBXNlD9DZVc8Y7RzDlxGq0wuKxox+J8FVoqA4?=
 =?us-ascii?Q?hfYJFUfSfaZIJhcVAivGBuX1EkxOOZZDUHsLQabe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0592dd27-acc5-4d54-bc44-08dbbdcddd1c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:46:48.0142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6ZUI/lb9gRqmVETV+D7IqiZqZ2jYvwTreOyy66PrFBGRBYplGMHv6gTY0kwc0+q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 01:05:39AM +0800, Cindy Lu wrote:
> Add new vdpa_config_ops to support iommufd
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index cb88891b44a8..55e6f45bb274 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -727,6 +727,10 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>  	.dma_map                = vdpasim_dma_map,
>  	.dma_unmap              = vdpasim_dma_unmap,
>  	.free                   = vdpasim_free,
> +	.bind_iommufd			= vdpa_iommufd_emulated_bind,
> +	.unbind_iommufd			= vdpa_iommufd_emulated_unbind,
> +	.attach_ioas			= vdpa_iommufd_emulated_attach_ioas,
> +	.detach_ioas			= vdpa_iommufd_emulated_detach_ioas,
>  };

Er, this series never calls iommufd_access_pin_pages() or
iommufd_access_rw(), so something pretty big is missing

Jason
