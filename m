Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC476B7E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjHAOoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjHAOoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:44:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72005122
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKtiU7+qiq0n3Yl0xAf2sl20qUd0B8d2c06PI8iIWLurOyHNRyMnLqYfMC4wgPhEuxEs2+O7mdMYYc/e9tPLoxJcktU+1IqYo1efwtXUxdxgQSXnLl1Zuph0WrZefqaJfluN+0B8ORSR7lf3vL7nDAyPGRBJlyr6MIiG023Q2BuMeL/1j7CI6GZWvHzXuTyZKiyVSiyW8mT0cNvtZC/mNK3Sxj2Kl10lB1UtOv0aZ6DGwn8biYsApHUQIaSlqEuEgbcO3QKp0E+kuLJFYtAX7HpSjBsy/lBNH2G9GkbrCPacH73no/26EVQrOSiB9BYT77wMCpEIoBI3VZj99GQv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXBtWByhlcqC/XNGUq75qVoFghxJapRc6Fa/+v5xu0Y=;
 b=ZxTdEunAhDSzqrSTIGP4HNPgL1YIKn3dzfSIBOxyfY1xK02I6GAaDq0TOYdG94A63aLraELBlJO5JYiMADMx706xmekMkVG20iK9mijzKe/+wNsvvKbXHnqH0Izon41Uv3HfX4rNT/EcZdjUV45s3QSO6KfhYdC38JACh70wWkSU4XtldABETMsMerQB9l+pWVFpimc5kGfXndqaik92bGnpf6krjkhezP9skF3w2mUvyMBgJdR39PhkZrTwSXcyPFe+R7jzf4VJHi1FIpDmoJhoJD0vTp+cfKybPK9nYSNlgHGkVS9j2X0Chwz2ztoMo6bj1A/MMU5BxlLA91PZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXBtWByhlcqC/XNGUq75qVoFghxJapRc6Fa/+v5xu0Y=;
 b=XI6KqGdmvr4FvGHyJdboZPjRRGDqL926dDK/IjhkWC3adI0jv8qBOcc1w/hpfY9yVGt9jyDpLj7Cqow4a6bxmak4Y/HhiFcif0fUiPcABwn96QmpYYdIJsJzRNu6bfQVOO25fIzuxM4f/PoKu812LDxYz6a2hBKOzRm4QZNjURpZ7LwSdW7qFfC9naAjhUyo79KebVjKICxRcIgm9TfxuE/Ln2swF3Ko5BlwFGlT+h60FO347Jub2wKeWkcBDbHkv8YV5DUhybK7x0Pp6kIEUGUsvJlvQ4jUAlZbdku2uAoH4ugLGhGEkBmAy5sZ6cHTAFMr99sd/kEP0RTJh7miYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:44:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:44:13 +0000
Date:   Tue, 1 Aug 2023 11:44:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v2 8/8] iommu/arm-smmu-v3: Rename cdcfg to cd_table
Message-ID: <ZMkaO9z2HH1cs0+n@nvidia.com>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.8.I5ee79793b444ddb933e8bc1eb7b77e728d7f8350@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731184817.v2.8.I5ee79793b444ddb933e8bc1eb7b77e728d7f8350@changeid>
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 0032cb37-9dbb-4a94-92e2-08db929dc5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSjHhhJTqj3gYDPZqmLJba5bAsihyIIavHjzscmNwHpFY4YhdkWihMfIbsTA+R5dQLB5z7AU0FcHvK7Gw81GaSXOfGUN2viWES5SHdpcTtXJAKYjPXR3+sQKYYBEubc7JovHnUGJO3JKxE7cd50BSoO7BqBiLbereQ8UdyZQFfQPc4/mxdEBHZcnXyTLCJwx2SJF0r+9PfWsayKN7yos9eUibHXI1TcKbnwypeJin2Xd/MarakejI9VFRtC4ps10kjKjxCmuAF4sOtzqd4tqs65WBlOuYKOobi2QtQ5EvDH6ATBfDpB9e3CWq3r21AghctOodIxNazrzEf7ZQ1QGdrFVN5gNVJ/hxGqSBGANPyqjY9Xp0ByIk27SmJJsARtXX1wINCAYtGbSiBK74cJx0/XO80C6JmGN2VgXRUYpafgpN0K9tTDQDfIqne4HmT0yCQedqpTKvGajUdP9OIxFiQFkXc6BNjdWLSzVgyil6BQGB8gA82I7U+Fr8GdcxnMJwNewYR8nzWXm/lx6+ARPhK671lHvoJfqpvAbbR+SO+IJfAghhwHWbT6yQRMt7ExEBzY+imr0BTOTc4kUGa8D/FCsgnMCHmTHHYrb2iuHDqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(2616005)(36756003)(26005)(6506007)(6486002)(6512007)(478600001)(86362001)(38100700002)(186003)(83380400001)(66476007)(4744005)(41300700001)(8676002)(8936002)(316002)(6916009)(5660300002)(4326008)(2906002)(66556008)(66946007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pXZRlVWGKHDRoFIhzGk8wHWhSHTh39rBfQUvDKj2TP94aE9gyJfwrgnhH8EI?=
 =?us-ascii?Q?QaLTIq/C61ICRdaBERuAxotX82FTCMzYqvMxyQ7XMlL7FlRNdRr6cA9t9Dif?=
 =?us-ascii?Q?n7ujCxT+hZIA8Vf8Ch/qpTtPlPA9NmDWWXW9iKYyHlIihDokk3DJL0V0irc6?=
 =?us-ascii?Q?9AG/4Xf1YCEO0hVVnudl4QPcKUBocaVYtgKcfDNroZnKV/MKKrVlRVfiuu5Z?=
 =?us-ascii?Q?pccmZbosKRbiUWGrKOzuqcahr19t/16dK8gec1j31caq//eSJIop4BwNBtm2?=
 =?us-ascii?Q?jahutXE/G6f/nk15ZWZ7nk8ai8YSpB383+3Qd0kb7z12y/jHNaRyoLtzpE0q?=
 =?us-ascii?Q?QfCe1vAgCgkeucidgT6wIMrPwtn2TqzIjjsTG6vxktkik3ti5FKjMH59qiNs?=
 =?us-ascii?Q?cBv0jJcfn6yB0PRZHgNfX6OTnjlAksxmc+eDzGGlCLROdhE/zPA90BLDweVF?=
 =?us-ascii?Q?CcvWLh3pSmQ1DofZ072mvUGZTqzWQ3q7HpdbjFn45/RHXS9tXVImFhdlcikr?=
 =?us-ascii?Q?UbqxNIAqfGA6uKih7u3RFVAgPa9msI5kM4F4MOi1/5KXi2NjhrOZ737PJ7iH?=
 =?us-ascii?Q?//CUFxK+6+QgLHTynscjVx6gRfC07xEzFLLS14vo1d/e6lR9K37pn3P/aJEF?=
 =?us-ascii?Q?FgE4/NJf105ilvTNeX4SUU/mO6Wzoxubp/IFEtEdD1lNP2Hv8P5+FbF70gjy?=
 =?us-ascii?Q?NP7ANvQdIZCsrucd7wKFfF0yqy4aolaFFoFiyeoE+A0OmrQWNvBOWjO+VNOP?=
 =?us-ascii?Q?5R8o+MTTRrsfrzsfot8u75Vzyn1tFf4Fy00CEks4P1aBW5xZ9YcXX7XkmCwz?=
 =?us-ascii?Q?b+eGijNmQ3r3DDlu/5zZjlapCHNi2xINl/nreQyhj73bKrHY5QFz7P4VawCp?=
 =?us-ascii?Q?B0SSPwtLt1t/bZVLJLbYdwYRJt5u3dkXbqpSa89cMuVc0ab6zVEqzyNWPdxT?=
 =?us-ascii?Q?I1AzadXfAtVQo4FlCAEmmFSQ7M04pLYmQLBU6g3phwUdXOwtW058So0hvobY?=
 =?us-ascii?Q?YPwfaPxlGlFCaAcpLu0P67eGyhkuFxbul3cHQL6+08w3UlDx/wL2MGgPY+YU?=
 =?us-ascii?Q?7MGqYVgvnL3vbsZaRefJgLenlchPVCra3n6tc9U2pl7VNAzy1pktKvpuL1M/?=
 =?us-ascii?Q?X2ea3XaCtkvh1MDWKwxQvuXchw4534pczDF6dnIC7Tzx0mUj+PPIeyIpM5Og?=
 =?us-ascii?Q?olscLpu4PEBIUzopmkhp7/Y6INPYbXRbAxhcC3pylEy6G3D8Ut2fLMUyWSqb?=
 =?us-ascii?Q?/NDEw1zyqy4KMzA4uzjOV8btXCdYzLwOdEiEAi8Tl7L27facoLcjVw7m0iTE?=
 =?us-ascii?Q?cNhhC6KUv8nnuz60/ZznCfXIooVqIi5HQhkk57pF19jpbgNBbvYkoghnfQt8?=
 =?us-ascii?Q?lx59/EUPWmZZrY0IQQxXlvVLOlKgI4AX05wimQ58EHA29EN3t2MSZHi4R66V?=
 =?us-ascii?Q?FPMSh+SPQRsYukCGUFehIyqKxyQxgmnkW1QoyJ/yb1HNwtfu2cHaAeenhZTC?=
 =?us-ascii?Q?nlZnHgtY1EhlW10843/XLSJeRZe8FNVkzCAGM3wkG1N3GpuAUMUIF1WfLxpS?=
 =?us-ascii?Q?wdMaY2lC6T9rNWf7DGMEw/nm9w9WH8gm8PK8tHoU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0032cb37-9dbb-4a94-92e2-08db929dc5e5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:44:13.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aptAfWaCjukTNqkLi/6RAaojKQRjg/wa8idrp7d7Tj7Vjv0jZMFYYnSJupnJcTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
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

On Mon, Jul 31, 2023 at 06:48:18PM +0800, Michael Shavit wrote:
> since cdcfg sounds like it represents a CD entry when it's in fact a CD
> table.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> Changes in v2:
> - New commit
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 ++++++++++-----------
>  1 file changed, 33 insertions(+), 33 deletions(-)

I think more generally it is confusing what 'cfg' means in the context
of this driver.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
