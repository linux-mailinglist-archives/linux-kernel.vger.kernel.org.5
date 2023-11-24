Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A32C7F77EB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbjKXPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbjKXPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:35:20 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E45199A;
        Fri, 24 Nov 2023 07:35:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KssHfeUrBgnk0k/B9F+2/fhd0DD3vX503EacQVohNNwuRmfF5b9njHpje1Nel968tv1jMgJ2KO+5JVawwwP/SyJE7VG1f9DLHFuz7QWM+gnHR9lD6/3e24qRkoIj2ds2X6uOIkNg+4Y0xvhVXn7xDVon2epxTZKBjwcMdrGeerEDL3Du6kTjZtqYR6akq6PB5St35UFQahC2S7/D7we/uHT8M8FRxfWaYLYMRIgj8OoR1yJrUy7sm5KXL1Oggs47I07yp9ouyoAzed8V/WNIMRijrHguQFYDHV2r9WZud3COFkNZK3pq0UypSeIq9rcqXZvlL6eC3he7tTo6x8cEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28FYHT2Sw9QobHVYU08OcWvAnUNMG7iYHtCHvLIoW5k=;
 b=UjvY3gvg0woDHjrwDP6l20eQiTB/fdXX3IwvCB4IilLoFGmytG0sb4mb0lOUlaJREVQPgzbs7Xm9v6Yz8iIHSZ0wLC9tpDEnlL+WatyjGIkqaiwxCHPXh9dhIZ6oM500nt6ri22JA+9p1nRVlSMw+3RX5KFcxdqNx/Jrf3tauNO4CoIFWvXtMFb7KsD97QVH1A8adNRHU3hdRs2FtIjoxt5EoDm6Z2K41ozR2WS+l/9Z1peoZc/vBKAoyrQ2efCLHPT/K6KhwrH/ZQsPHcZZbyovqYWK7O6AGit0QaxXMj3KnGMFZS6/uukKCgPHjvCBpcjwneKRrqBqwrHzUUyibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28FYHT2Sw9QobHVYU08OcWvAnUNMG7iYHtCHvLIoW5k=;
 b=Ogcdb8XNAX3+JsMxriAm7s2gCRejB9yd0Eoc9a9ZKNf0wRSuCmnjqSXIlCOYB5iViOBv+5meJHHnwrasX9pjhj7r6WgIznpt1uffXMYXZ6bKtHrjiShSTqIAaUBjKfs+UTGcljY71o5p6+6nZkAXQ2YGmhkH3VzSQAJBjdOiwYi+eW4O1rkdRCQflF3qoXoSkvtB5faoEtO2expQQnE6zGolD19m1jFC+guuaZ3xvF2yC6U/L7YPhLLOzrhwgPegvvxeXdqQdFGz2/Gi6AiUgUxkZjbs3hKLsOTf/7Q12uOkDeHXT5ZwObFiQ1gIsDpA7sFI5Od5c9nDyi4tdyKbKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 15:35:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 15:35:22 +0000
Date:   Fri, 24 Nov 2023 11:35:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, lpieralisi@kernel.org,
        andre.draszik@linaro.org, quic_zhenhuah@quicinc.com
Subject: Re: [PATCH] iommu: Avoid more races around device probe
Message-ID: <20231124153520.GA558245@nvidia.com>
References: <16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com>
X-ClientProxiedBy: DM6PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c59bf0-76d8-42c9-a8f9-08dbed02f898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bP2xlG9KnMJrsVdXYUy/CZOj2kFDmi/9Drc3SlRrTIlgxEHMAeQ8K/f3fjYcVqqhlugXaFYAssj5L/fS7cn+st5Ff1N7zFNfLzTaTCJRlubjgB3/cbi9uY/wepzq+ydXf5eWWUU7og6kQZyPLaEeS7rTWsVLTLhQbeGqK+9lQT8M/BQ+NAXOsk+kEC3fhGlrHaZUsQNiRV+y7TDUxIXAFEbqYsmxXpK2ctS9IIqaUyAZR9EDR5gFjxt9jHQS0JR8w4YkqVqGEsRJze9xA8C/F9dDtf16d5j8XgMD93VeiF6mfaBR8XKpNL6pXMYwNX9+RLbUNWTdZdUOXoKmG+o2CtS1RO04jxAGlfDqPEQo8C7reWbsXYjVE7Gr2zARcA2wLqZl/XI1RoiTMtRlgBu3oF4D29OJaOMA9XRdJSIyitCOoE9EvjmVa822UZwle60Hz9wY0/b/TubCOV9bKec5ecMJoUBbRn7k27RxOyHZgnTVVO8bnL4eX3+oL+H/fQjpaygzGmGLHzV+6G7MB08kDd+5Rp35eMWpTBHAtcMuox+JwQq4kn/75FO4rds57QlYT8QRebVMinA6fm7eaaRp+fkYGWtadRtGEMG1RRrZyY1UewJihfmiQ9xaZSgVHpkfsuByZx+G7gmoCYCOI4rIpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66946007)(38100700002)(83380400001)(6486002)(966005)(478600001)(66476007)(6916009)(316002)(66556008)(6512007)(6506007)(2906002)(33656002)(36756003)(4326008)(8936002)(8676002)(5660300002)(7416002)(26005)(2616005)(1076003)(41300700001)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EQEK8Xba3Mpsd6v9+QGyFg7z5YQFNEbg2vpHOhXuv++EyISewaE0OfvkDgqZ?=
 =?us-ascii?Q?Ods007LfKHTAPlSQmnDzNYwWvAztNUCZ93Cg51M0JM+J4zUp5Rqi89Il2qa6?=
 =?us-ascii?Q?MQ1N9GmMnBKSWOKbL+9U3oCT3awS1fK/bdC+MRkAvM+BbuXGhx41RK74xw1o?=
 =?us-ascii?Q?fun2i5fb7xBO54YaMthCPqOtB6tz2J0D8PLj3CDZh/YP6j3leiiy4/bwzN8T?=
 =?us-ascii?Q?b339Tg3DbjXi0hlqd8dDpzUPIpcHOnp2I4hJmPrpwhPHrSYdnCn3HN1BFh4y?=
 =?us-ascii?Q?CXvpsUIpnvct4joEhhyn1e/n9z+eOKvt7CgBstNcBNYpvdT89I8nzOmVwY7b?=
 =?us-ascii?Q?McyitDd6rqqKQYM4dmBqP0SovSYaMKXtYFNR7wQA7lNswBwP+6ANNTm4CbYD?=
 =?us-ascii?Q?nnwAPSqeMSL0AslkpvNVCP7w0VsEy42MFoR8gSJmt+wXW7T7m8w9p51hI4uy?=
 =?us-ascii?Q?WozEBAkY2LdxVXIfoazfarfhqgDogbH3IrgTJv14afzEZ1UnqR2Tk82HlqjA?=
 =?us-ascii?Q?V4pkeJ2RIICXrTBtGbduUHYQYOT2y7oMndEwNZ9ZCUr1CdlWrFiNVk1PU8zz?=
 =?us-ascii?Q?r5vLWgYqBeF9B4FomLCjiucESudipiioSNsLr3gc0/a36QyhvDhMwQAx/dbO?=
 =?us-ascii?Q?jKSBjp4x80vK4bFt5uaU1jIYsySPKitZtZo9IRgVneGi9EmFWjSdor+oMjHN?=
 =?us-ascii?Q?xcgQgPX63IVXeYxXOIMrplnpgBUt4dlWwB+WZTnlSQOPdeYcUxz9ZHtJtU+S?=
 =?us-ascii?Q?RvatPPfBu6P3wc0o/LogjnSlENH0tzEps7w5eLxPCzYeaRva8jroNRMVKP4O?=
 =?us-ascii?Q?9a+596wrlpgxO+4UlaUTUxQCbs7TNVE2VElMeAVApL1azlPYzrrnIPx2FuJd?=
 =?us-ascii?Q?4RE94/CK2V7yMyJkfTT0v1QeujY2lTCe1cvtR8YDy1kQOX4Rd62VCeulDJwH?=
 =?us-ascii?Q?MdA4vFrKNp2L3ltwrvuIGIIMaYrjBk4TYon1lGqwfPA0MtH0NtUFTKcYgmvl?=
 =?us-ascii?Q?HjTNeP8HtXXFHmRuNCid2FNvSfFDzNvwm9BfOoDFtH1NSVHmVcwzsMd1pDV6?=
 =?us-ascii?Q?4P9ZxiiRuJYyBSl8UaXwPB+0jQncCqmkY7rF44FvPs5D3S6+oW9YV8XTuM4y?=
 =?us-ascii?Q?tvrWxH1bKRVwVfJ6fQ1eCssLwAgymMxBjAXHJvY5nBpmW9MPlgf1Wao1aynh?=
 =?us-ascii?Q?5itIPZ6UUmH4i+aFGCSB1bK8ZwuKVYKeEqXESo3hITHlZob9tvTpZUbJ/RVa?=
 =?us-ascii?Q?C/Px9FpHsUfCyw7GgA6CLPkEo5DqKHyBcrzBkxNYm4z7iigsk+I73jjvjLKX?=
 =?us-ascii?Q?AUat5n7weoGsegmrhqBpgGjmCLyFHBQoZAmoJcf865WdZfcFMMbK2S9DnYGn?=
 =?us-ascii?Q?Fl0yR4cE5/aqnlyTxkAoFkZS4cLOUt2U7PuJdV/op2TrDumrMd+Sr6GO79nC?=
 =?us-ascii?Q?1rE8Z2iaL0F1rXCtzfGhxfkodNs51owgMFQg2OtrX0krT8UnivOrL2ZOIAzs?=
 =?us-ascii?Q?jaxKFLIIMZhWtmQHXDohzjsS+MssqF+bI+lciakqKnh+lYwJ7jx8VNP1aRSt?=
 =?us-ascii?Q?NF8g4YaCAUPZEBaW4IwGKCVKZFTmfvsGW91/a4Bl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c59bf0-76d8-42c9-a8f9-08dbed02f898
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 15:35:22.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lL6e2eHMcHzLTjjAeYwUY2OQek3O00vkEUYw0QLzl/fQzgqODL8gA3S2oD3cyTji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707
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

On Wed, Nov 15, 2023 at 06:25:44PM +0000, Robin Murphy wrote:
> It turns out there are more subtle races beyond just the main part of
> __iommu_probe_device() itself running in parallel - the dev_iommu_free()
> on the way out of an unsuccessful probe can still manage to trip up
> concurrent accesses to a device's fwspec. Thus, extend the scope of
> iommu_probe_device_lock() to also serialise fwspec creation and initial
> retrieval.
> 
> Reported-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> Link: https://lore.kernel.org/linux-iommu/e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com/

Apparently this is "Closes:" nowadays

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f17a1113f3d6..e0c962648dde 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -485,11 +485,12 @@ static void iommu_deinit_device(struct device *dev)
>  	dev_iommu_free(dev);
>  }
>  
> +DEFINE_MUTEX(iommu_probe_device_lock);
> +

Please put this at the top of the file with the other declarations, I
will rebase the lockdep annotations from the other series

Thanks,
Jason
