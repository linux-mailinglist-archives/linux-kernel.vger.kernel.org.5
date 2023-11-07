Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26857E3FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjKGNPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjKGNDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:03:54 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9958F3C06;
        Tue,  7 Nov 2023 04:49:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3oxFWc3euX5uloezuJ3LzXt/BrcfcEgR6pjyY0WH2bV9+EudFZN67/FTGBeQEByg7caAlRJHpb+mMOsrupX2X6bWgRB4p9Pg+SzwX+lWBV7epm3VwtwkEwUgi4J7472J3h1quZ6hGaOol7Bf0wcDy+pPHHw1bpY4UUjNgL+ttUFl/vsZ0m8+gxYXyEkFxJKG+e7yBgsiM5wKR+MX/zQE5RhC90SxzQS9siD1ggF0pfpUIAvUrELQMuAxk/fvp+CkbC4JMUIohBPyQS0z+2Fj5DcCwih8iMos3PC0BLIihoJ6L3vLFiLYYx4L7mPI3osTaxc5JO/NKrrn3imaNoIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jILaPK3XW5IBAPu2pU3nmp6cIQpGpaDO+5XtMVyiczs=;
 b=GGb5qPR6spAVauDxtO6ZS+EuV12Mt19+h/5IyPcgeRZSOqDQm9mssLTHsiwpmbYISgdNlYCzmTzvX4/xlcoXnn1c2CIIxUXYxWTeltBwQYejXhN7iR2mGHjMULRcjR7GwAL4anxGRqzLxUabmUXi92M2bKM6GvTJC8d9eqq9WITjmUEc47dzvaCDarmAtDlwpGWvEFGxXd0jsSWyYYWnVushJ4dtcIau9ZawkyRirYLn3a6OYlnbdW3uQD3JjRBjO1sajR8RC1/KN7cOMIfgPDd5SkuaCSnn9aCzfMS36dBA+ERCgIUKPDiCDAALbuq0zvSxfnaOGhBDQCx6caSZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jILaPK3XW5IBAPu2pU3nmp6cIQpGpaDO+5XtMVyiczs=;
 b=fDi3PyKoOn4CrjQ3vH31LJPmN6n3gxat1L3HpT6+4xJFfyuOibGWJBIYyCcC9e27S2DQFEsaRpKFG1NHipqFGsP2D+yhJztuRW7sKoFaz0JGYbBWHkMJ1JW6uk8rtCM7lozwoAiT4UCbRdTRHUH+Zg15n91GsNmQJGY3sF4q1QJCbpmTCDXiXjTiOHa5ZPqI11l5g+iX4jK19lFQ+9dc5AFx+nXl0k6fVEI9I9ks51o8vahAZiBmVp/fQw1OWYUEwdGlZCwsh1LiSWA541MmiZhz8Y3lTbVAvKHZuqYKk2vFXoCb9wW+vpYQrQ5P32mzCHGboY+cByI9XdFlf0DzBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30; Tue, 7 Nov
 2023 12:49:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 12:49:03 +0000
Date:   Tue, 7 Nov 2023 08:49:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107124902.GJ4488@nvidia.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107022847-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BL1P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 460a72ab-6fde-4221-a1c3-08dbdf8fec08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Q/PJQtLTIMKPQ5AIhQo6VxNIXrr4Cnbtw6ZVfznrMlH/30TddcP7+hKH9w5CYd5B4bpzmndDD7f4jakJwDWcKktger7D1OgW02xK+qgp1YszpcRSS2iSW64MyUUS1K/s854wHLZnN3hWol/9HLJDCjAvhS+SaSoq6yGVVO1NdWN6SaSR5Zhsf25pmzoLT/twARu+yATWf5AJKz3lfioEYeCjAPblzDrNGEXyjhf6o4lFuCYsDakvXY9Gkma+/mMRQZ4yRjPq0ulrAZFrbrCI3mZzDoPqfX1wLxriF2kaZPSzdNUkZ8XdbFuf/CPPTZwOcut/djM45Tuu8rtoOjhMuh4VPJlAD9zMuW6Ym7DCPHC5TQHYb/g2VS/ObbJzE+excimbXf6pXSTF5eZUvQ2/o/Yc/w9PF1pRHtsSGHJDdon9PKGUrQxKDpu8oyxGLdvzayL0JmpQ3PpPYbDIa9dy/UhWAYIPYqIiXDdPGfQDi6QQQCJrunE99pCjr5VJeFMkgrRbKRMui1HrE3cZqrDFEf5Xh5ex4t4REyz/+ZoPC1y1VRZ4/jHtFPKVHD2Fh+H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(5660300002)(36756003)(33656002)(2906002)(4744005)(86362001)(41300700001)(8936002)(8676002)(4326008)(6512007)(2616005)(1076003)(478600001)(66556008)(316002)(6486002)(66476007)(6916009)(26005)(66946007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B21OuYyObUYvFbsyaptJCqB+ZaQxc589OdGxxWg14oKC2O/im5X9zxscwmN2?=
 =?us-ascii?Q?TGV/Wqh4hF5DDKTkPFJkBFi5YZVU98hkMofR9GzaJVWrsFDuRzZYd3KvoerV?=
 =?us-ascii?Q?81cnfvbXgDedrObHFemhWhoIzESLMrwVJUOlPQkuQLw9+G6htdtFN87TRHuq?=
 =?us-ascii?Q?PQfeiIIjJtYZBZKj1KPo0Q6KIer88OwjMYcNawlm6CasWI7PJZ8HoiJhCZyW?=
 =?us-ascii?Q?60tmhCAb6Sc8kh3sQXc22zc7VimOVlzjYuBamHefh+Blnqskd1MP8xE07C4J?=
 =?us-ascii?Q?gCQARjeEuJOdgevgzcrOc1ngWeuIcsXzbcHJ+YCSeL/lsjXtH5I6ya2QkEhJ?=
 =?us-ascii?Q?p3xmzLkqvBHCr+jpzxhRZw1ZXsSY6UGZVN9jBbW5UyxOQgjxJglgCfswCahm?=
 =?us-ascii?Q?fYfc68ktfoR82YOahKNdbyTi1yhqMvJIbmPdM+eYgVN0czRT7Oc0Vg+hCj8s?=
 =?us-ascii?Q?JooTfX8wz8V+r4hUV/wYNklC8Y+S43zVMZ1rPfIIJk7lKT5mXoihhATW419L?=
 =?us-ascii?Q?3h8HwrNqrsd1g0UK26CChFnsBi4z03mjcltUU9rgULHSpTDI0wWCNQmrWhii?=
 =?us-ascii?Q?YGFPcogkmZ6Iklqhit+rva71Hy27QFjUbbQCq4PACtMqhSRRl8BJCuPo6E6F?=
 =?us-ascii?Q?Qh/V/u4otssNv+E8xwCG0pLQU6i4Ob27paAZAly0kYJyl0Ojm1X66Lgf9xnz?=
 =?us-ascii?Q?SqosmkyL3uXrZQYYOt2k/lw/FRHaftuA0De1CFawbcz+qSlEJU5GOWmHbPhs?=
 =?us-ascii?Q?uCI+zecDWJlthmxtrS29MPGZJWYHVjnH2lvQrOinfqLGJjD0n+jmCRc+txSn?=
 =?us-ascii?Q?ZwFxHdaKptpF6jPnM38nGJkV5WCJz0rL9bk38ZLGX60p0JTMvpLDBG0455Sr?=
 =?us-ascii?Q?vbomfy28/mqgLx2NPISkzLJ0h+qTD4ORYGLOQ1Do2yD0IM0kF+ZYsWJP/vmN?=
 =?us-ascii?Q?ecOJb6QcvkbFfhd47NuRvo6zifT5SVUxqav5hu03eZsYsryxsCSzXi/qXR8M?=
 =?us-ascii?Q?dMocu6Lf9n8X2+5BaDmnDr2MpcFKLBo3nevlUeb5gLwArhPxBAoKloodIulq?=
 =?us-ascii?Q?MBxtZvYWMpnzurO3t6Oa+Pv6M584IhrCQBA3DJlVhAmzXv05L44MI432XDHI?=
 =?us-ascii?Q?5ZsDuBfwSRVUcpwWFk7leN0IE7tlzXT1/4wTMQeqWN1XQhxOeJAVwFoCui6q?=
 =?us-ascii?Q?deIkr9vJ2oEUQ3HXVFLoCC9wPh3+xfk83u6cyK2Zt64v5fZorlvk2QUa66Sp?=
 =?us-ascii?Q?3txBxVqzYXBmATa3ZpIUlBC6YKXMuX71B4Z4xOH3mqZXNzOuQGtYbQdIVjpt?=
 =?us-ascii?Q?dH5QyX4V++AD1WFa3ThJfwUROtnkhwgiNrtUz3loapjiU65aJCM5Zficr6SJ?=
 =?us-ascii?Q?J69QcsfVVfl/cJ1LjiGHh0VK4yEBfIOeQcIhdHzkMcv0NtIrwgOGVIXNmvW4?=
 =?us-ascii?Q?IPE3U7bEz7+eRQoaJB2PpTa1YOgX5AP6TTRbr34XpdwFLFguTx35ZotwQfSj?=
 =?us-ascii?Q?79TWD3vnBE7yxFnWuJnSkShPL/kZpilxM8zqo85U4jKlMZkiNGO9noMs6QHq?=
 =?us-ascii?Q?WmaEDuUX9O+jSUqJS7XljStp1iKCDnoLe+vrJ0jc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460a72ab-6fde-4221-a1c3-08dbdf8fec08
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 12:49:03.7684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zsWd3vWwbODOmqfSKCdlGqWk0TMVG8NT06krhRA3YCZtQPew16UoKph6wMbHVeJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 02:30:34AM -0500, Michael S. Tsirkin wrote:
> On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> > 
> > Hi All
> > This code provides the iommufd support for vdpa device
> > This code fixes the bugs from the last version and also add the asid support. rebase on kernel
> > v6,6-rc3
> > Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 
> 
> What kind of problems? Understanding that will make it easier
> to figure out whether this is worth reviewing.

IMHO, this patch series needs to spend more time internally to Red Hat
before it is presented to the community. It is too far away from
something worth reviewing at this point.

Jason
