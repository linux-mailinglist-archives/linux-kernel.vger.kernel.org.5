Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F097AD987
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjIYNvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjIYNu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:50:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A711C;
        Mon, 25 Sep 2023 06:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWB2gxwI14S8NNLpnp1wa3Y1NCijnM0qD0/93B7Nog34FossbgnwCs9NyVPtkAb29YqYevcj/ovjrCfW4/87VISY7Low4iS8DVi/lVGCz7kVsvIZuKRguFEBj/hKzjXVUja2CEjUQEdQBgK6dHj9VEEinbD1VwDCfdxRJd1YC7O16bTXpf8FDOelvkK6LOYMHvRe+irx/rLzbudCA+gdIsQxNGYYDuiKYAMU4Qeoe3A9xiWUp0VioMtK335V7UgLTHQpboZUW7Yh5xCxWWtUnaTDCB/h+HczvgZxUd369BiWn268Dwpgc4LeuCstItB/5FIOtD3CvlTBCzCueNZcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzC0n85HRRSc86nUzRfeqTQzt8FPwuVasSDT4PCOY3U=;
 b=jtrTAdEOj1yaHd81aBVOs7wkeRljtbfMwQ9nzoOa6lDwMxNmCvDaStdOJhvauZYTIYXOn1qYolfVxGgNrrQrsGVe7Vux1opz995n7nCsHOuQfz0AI4xcC5hYbNrQPWfuogJznOXU9IzRpuY0CPFQuCeWdqHdmRaWDMHynY2Ogb3ATUjwtB9dtHq5HAA/wcLeJ59VYLWfsX+q25iRIfY2QkdgO6RUHICl9Jm91Q+oLjQkOwfN9PgUEihf0t+rwaNFWCRQeeZS0vpSpXLGB0/4CPLy5/K6jWkQWIbj245wZ2v1QvH12U4V3pE8xgDrBfSMu/OPTn15j+qWgOIgR1AhBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzC0n85HRRSc86nUzRfeqTQzt8FPwuVasSDT4PCOY3U=;
 b=qD4jlRBJJhQkGBov2dG4xj7Qjqy2d+VIZhE1+swSAXdhXqmrY4gPYo/6nA75PxgTzNmrRfM6dxq293n3okqUxelKTqVdnEMAcvsTh1tLh86XaRzpBbHhJE74NKbiH8rUSD8QBIfRKQrfZNPCjqYi7Fp37HSqVxSkhP3WF0WX+pWTzTB4ycNWP5LJMn0zTjFhGvDB+nLdNlOV3V6Hh9gMFH01wIDn76OY3zlB6Q6/Q9GEDxSiCnNJMghVw+zh3f7kV7i/FmnQgB2zKtQsvd3Y/cbgQ76o72A2Q/CpCu1xEbkEBDh1CDz5W8uFX+fRCFf6nRvvBppgElqT/msxcRF2vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 13:50:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 13:50:48 +0000
Date:   Mon, 25 Sep 2023 10:50:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC 7/7] iommufd: Skip the CACHE_COHERENCY and iommu group check
Message-ID: <20230925135047.GE13733@nvidia.com>
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20230923170540.1447301-8-lulu@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923170540.1447301-8-lulu@redhat.com>
X-ClientProxiedBy: MN2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f5a43a-e86b-4789-4a67-08dbbdce6c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOlrgJeKXErTG+vbPrEyer52IY1XuuGG+BPFn1HrgFVx605svuSYKMEoCmuDqNoJBelVvQ0BGsodAoUziakcRns1RtKzDrniLGPgR6yUcCZd48MqF8gfRZkwq7D3JWdLqOZwURFqjKTzrz6f6hKNW8ZGEWzo7cd2XpNIKb5Y8Brj3ibK+eGzVqA5JA391VqO2Rp9ioTASG7CuT6RN5rWgOLYIXQEH/BmGzuptO8ncbCYpA4zX0Gb8PfznwxMwJQc0WgZJti2AeHd0uRCCUHvJvEMIGajW4NNY7PhrPs2XfDumax0MsgXh2UnQL330BEIFpx/C5x/+I9vkWBw2eER7A92OxX/ran1kt5D5Ey1tJkyvyuDoAb3YMXZN1Va36mSVVdKWR9/vMU967i/7H0GtDzc/yad7qxsaN3zCag0K7uAANwCcp1NpwOa8zVAFZbHs+UZzeRJo/u/aTFs8qc0guZ5ZeKaNFRcNaJGfxSbvCnfy6f/SOI0LUILH4w5KbV1DPxOaJrXsyj/Sg+ewUcnyh5YGJuaPZ71OGgwmgLGWlNrDmpkVMgKAGf6Xnyz2w1y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799009)(6506007)(6486002)(478600001)(86362001)(38100700002)(33656002)(2616005)(36756003)(26005)(4744005)(1076003)(66476007)(5660300002)(2906002)(66556008)(8936002)(4326008)(66946007)(6512007)(8676002)(41300700001)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B3QWSaK0sapDbw3tIgk/vDBogy+Spczm0qiIx7U6/YWtUH33T6gYXinZyP8K?=
 =?us-ascii?Q?6qng3mR9qDzY+SdkfEPlcSMA46OWyxIRJOBQe+4YhKJgvyERecdb/OKTcncr?=
 =?us-ascii?Q?dL7vB4+Ry4Tp2jMY6foIAwP4T5+LbpaHmILLphvD6Ld+K8pWMNPvAjHonGn0?=
 =?us-ascii?Q?BCQtCuF7W9efPdqtTTT1xGhq/gsSQKmOWSKVb1ljzf1Qeec8gx51bnYKeIT/?=
 =?us-ascii?Q?/VO4YIC5j6YdDSZEKnoosF9+QIxgHWBcNKRXXVR0j4AzQ7bqbljnThC7qSvc?=
 =?us-ascii?Q?cDu2xDSatuxbUaUgxVkbKLm1L7/3hksaJ7zUl6FgAuerHTlDZ73qOCZ0V4HF?=
 =?us-ascii?Q?S9NN5yKEg5Ntpx/4tOAdgD9ejuZoWSUMJ4PoA7Zk+E0IkWBxlLJ3fhhqLONX?=
 =?us-ascii?Q?uq0OFUs8PYPvZi36wr8EsMYOvjg4hxo0Ki9+Wu9/OFUd7RT0GQ+qP3rWye6A?=
 =?us-ascii?Q?Q/zfJ87q80afGyOhrZW0Fqejgol4fNtUfDTG467ZKGMiKMfWi2XAgjPheKVb?=
 =?us-ascii?Q?b/+Ulbv9df0z979Pr72vtBBrqOgRvHCZLV02sSvuh3Q5APuDd4AgG1Sx5d5q?=
 =?us-ascii?Q?R46WMzGenbMMuIxhTwkXvdzuntF+1A7MYwJI8UhSOezjsXTA4xynBvi6lKXH?=
 =?us-ascii?Q?CFcTQE9obNHzLGh4bp/UZXkHr55gNfr3pCQc1L4ia+WFlbpmlQpEO1Ds6HVq?=
 =?us-ascii?Q?WwyGhECT5FtDrIjihkcrWDiG63OO4nZXtbFAQxcWXXF++rvINcEl1YaOxFlg?=
 =?us-ascii?Q?bteb0lJLCR6UN1WIEZ/604CZW621tLeCHPFohD8gqyMGwzd8Ti/AxN8iRbdz?=
 =?us-ascii?Q?IcvubwwrJZDRaBkp/dHw+vNQC+zdGWJvaiA4LV1fbaFt7DTA4dk9Ajk//O0Z?=
 =?us-ascii?Q?Xf1QMkkCBRPxhZJd0B7cuIaGPJ9VxiHliIH6pWazc6ltxBkp69l/f0c0DU31?=
 =?us-ascii?Q?mWTie0KyMinV37jTNvj2LNMhk27m63xxZIeOXitwNekQYE2FRH3xWpYwR4lf?=
 =?us-ascii?Q?gs0ZDnItKg7zxZp05RTq/dNv/EVZY5vCExIgyZc7ovTgSBKEHPDDJrNVT+wc?=
 =?us-ascii?Q?mNj8I4Z+sKyDz8AWDKWaAgR751bC+vXWn31/b1rAUSdAtkYEyRLX6sMSBJLP?=
 =?us-ascii?Q?m6GmaGIGfa50xEv6SDtsuInjcp7ecjh151lbTdJjf7BJhx091Dcf04wy9yD/?=
 =?us-ascii?Q?XMkkKrTeU75R4+tuLWh3qo9BBDSnKeW/JN0+EK2SdPZG0FxCjp3ehLkC0CeG?=
 =?us-ascii?Q?UWlvVokKSf2jnGFGE1mg5NBRSDKPFsJqXbDUnD38s6hgDluV9p3f4uXhStU+?=
 =?us-ascii?Q?Uaw4FRC9tVVYljWUdqN/Owy9fmQkZXaIPLNkNtGyWuU4v0f9QKiCZnI/f1g9?=
 =?us-ascii?Q?fAaaJgFK9GXEPkiOGAEdABgYoI/rEFmUvScV6XU0uxYvxEBkJVG3WtzbMbOn?=
 =?us-ascii?Q?hyBT7xinOyiY6HlJZruneVIcbuPGQ+ya5eVa5xEu/NAv7z11FQ0acyPwYL0c?=
 =?us-ascii?Q?fmz7j3ZXGGGit6cExxHA4ocahfutYFro457RnFHCmjf+Ioqq08HmuBqHqd9e?=
 =?us-ascii?Q?0DlDx3Y4G5u/ATQLf1cZAnpxdpNvXamnMsfkvpra?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f5a43a-e86b-4789-4a67-08dbbdce6c95
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:50:48.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1M8ia6DDYRYGM5OYvy/OiE/U1qWbCaWxltxMLVWz2vqqOKNJcBuHYtdBj0N5GEiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 01:05:40AM +0800, Cindy Lu wrote:
> This is just the work arround for vdpa, I Will
> fix these problems in the next version.
> 
> Skip these 2 checks:
> 1.IOMMU_CAP_CACHE_COHERENCY check
> 2.iommu_group_get check

Uuh, something has gone really, really wrong if you need to skip these
checks in the core iommufd code..

Jason
