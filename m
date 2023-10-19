Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3707CFFF5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbjJSQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjJSQvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:51:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF3912A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTD70KSWjbMbHbLLbt10Ti9TgrNTNLjRNUHqj8IylDgfb7/4xOW46ElvdEx5NNiId4HYUBpf1KQDEvaGd+PYzEuO40ohbjA3tQTavVAFgl61YNEwmQsZUAhjSjp+o241aiJL207UWgekwdeRuvOIuRlf/CMaE8MYZ889idvou6mlLZoCq5ap9N4wX3703FE1bSBG0Vdlxw/D7MTnsSUxESsWliFacyM1Uo7zucKlqh/jGHjJEyMUSPSqSqkK3w/VdnA3oz+FWaSaEWKvFvfd2j8Q2Z/XIb0KJ+k5qN36y6EORlHBHCOzfQL+zKWwa73rTOmzyUO3TkGE2FZhcNT0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo9+aQiQ0G3EBhXW4BCLE8jG54DYVi7cunU2HQ+etAI=;
 b=g0+tNNz4746zINku1fRDP6TemHDVb0J1rAYtDY9SN35pR9eXK9wazI7qESHSzUyrmVxpe9VQIguTEOINkY90fUoXt9/G/HxmnKPsGfBmD3pt36+hCOEHb1OxVfBBCc8lqJ6oAtadS/2vxU7S3ujX3sOfv6BGNU6ipjG6movsBoElRnqEX326KvDBO1P4OvQ6Vx5jVEy+AZMBOJJbGmJxHlqJXIrg/8n3TFUhDMjoRmLU7Fi5YmFT1hhiCSwlZoTkohQyYhhjBN4ydaduqWfTunGZxZTG69NI69iPvhcPBAwN7Ghq0eYUl7f7LHoBNMyEBHnmtvKICXL8MaZv5BGmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo9+aQiQ0G3EBhXW4BCLE8jG54DYVi7cunU2HQ+etAI=;
 b=lHH4qhveZHORymvuiaCF531yxmE70qMXv9NnyXN6BdvouK0q0Pe+XztGTglpted7gUF1E74UFki1t+u+/kNHyNp54yWyTD+jctW3/yIvnwEK8ECPT+spJxQ1ACK+dgbQlu0uwb815e1Tvwy+Qa+rUldD3e7raIRgjFWUvGOWGYf9qQoYnK6E/5hN+La+7sUEsElCx5G/WqwZ3U/BkhTk2j+w9aAlq0Ll05gM7kMIa+muhYtoXF2TvP/dXvmNO89fw457KKfyPCWATOcK4oIr0Ox+GHpa7NU4DpdTa4ZjGuwhm6WvQUEx7oug+XFCQwYDT8NAFLiVlbcBAuhT/pwkow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 16:50:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 16:50:57 +0000
Date:   Thu, 19 Oct 2023 13:50:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: mlx5 ConnectX diagnostic misc driver
Message-ID: <20231019165055.GT3952@nvidia.com>
References: <20231019082451.785aa123@kernel.org>
 <2023101923-tried-provable-72e7@gregkh>
 <20231019160145.GS3952@nvidia.com>
 <20231019092346.3387fad6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019092346.3387fad6@kernel.org>
X-ClientProxiedBy: BYAPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:a03:114::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 72deaf7f-db57-475f-0a39-08dbd0c39105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNNXdovB9ZeNBdMVuKIup6yIVBfkyV/V4HPCnsF1s68di/nscCnAEPZz1SCLr0Sce2Rh3OX/7NHjxUADTOR6RmQtRlmid8o0soRmf8Yi1ciIgx5nRwkC+Uot5HU0jTwTVH2nqP9HMMY8lEbAywewu0+MkTfvLTQ9ytgbZmes6tU0YFosuxSYDtLkYdLxdfZ3M7/4QrakZOwtDVZv86Li5oaypvySd6wDMpem/O27Xc+ZSFf2eb5db636e9OZyTGK4gzZK03vXs5/QOl/g59cL4jalF2GINjblY5iHB7qV7/F+gx1IycJzF5rm6oxafLcFV8q7rRCCaY2zi8WAs3iW8ZNIwjeRpmrPUD1Ut2AK1Z0AePbcI8mwu5vzgMnunaiGEyRMyxqm/W7MdSpqAQ+0jLAmgzc7mpx+Hdje1VqJEZOxmynA95QFF5fYqESQpSs3Vja24EJ6Es++1L1d2LcRMryZ9bLznjrupAox0Ao6MSeRYiDJ2Usx1nKCOg53tJYm2H8B5XJNXI/CT82TrV1faef4Axo8PO4RRkeYUCk9GZVZzttOq3f2LPbH1pkJddCuuN/sCldmrMCQsajNHQlIT3l4TtVymtjLDIGKD1J74U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38100700002)(8676002)(478600001)(966005)(83380400001)(54906003)(6486002)(66946007)(5660300002)(66556008)(66476007)(6916009)(6506007)(4326008)(86362001)(41300700001)(2906002)(316002)(6512007)(1076003)(26005)(8936002)(2616005)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2QeUGTSIhugvMw4yqr/yxoQr1ewUJgzCdBGv+WpqooXHD2JQUG+g0k8JF0X?=
 =?us-ascii?Q?kcUEveujD4kEbOSSbONfK0+E7S/zRdg/ler5pHBpLQi3OWYKEaIzkpxxJm4f?=
 =?us-ascii?Q?afnViiWya+S5oAanP1Zs1AwEnV7ZOhdmnWspzQIuIcpmtWFPqgYW+4M/Tb7Q?=
 =?us-ascii?Q?oeMARqUhHNKIFQVoBNBhGZyHyJH2/QTchqWNxdZHkmxhpS/wqPfGjvzMXGZg?=
 =?us-ascii?Q?3DqCmIXgZUAsM0YHZwEFx7TEAu6sllsDfumwteXogPYAVGyQEUFVgoy19iPS?=
 =?us-ascii?Q?PslKofodAd1s2cCvWIn8mPEE2BTo4hxyelBk2Wc16cuQtQz4Ieao/gViTPHd?=
 =?us-ascii?Q?ekqDnW55nlbGbcd/wNLQ1K+v4syDpHAx/IyYk8DR6r2Jl9p4vRhwB+GNzs4E?=
 =?us-ascii?Q?UTSmHNNjCEGaAn1llRkVj8okUquPIgrkCkAa+GFRPr1o7fM21EW6q937zyEZ?=
 =?us-ascii?Q?LUNTZ6WzQLrQ2wbisIQh0RNUvcP+Is1YrqIl9n25vWNG2hb22++tRNJO11Rs?=
 =?us-ascii?Q?i/4h6ccno+i909BHSK6MeTCto6Razl3+oxa3NurW+8EX0aKYPKW0PTPq0U11?=
 =?us-ascii?Q?B+I/8pPbeBAgaj6r7yjE1qzm4HW9H6afA14nOtym1fLGdfyMvhydwkIkEnLT?=
 =?us-ascii?Q?rWDlqGNr4m/yoQbWELoJDNiWpPQiNJJ4dt7Fbqae6DToEOqKXAjo2QXNGVt1?=
 =?us-ascii?Q?lK4jl4hhnumhVS4ryUFd6/M7vMRHuja6ZOGBqebVXwSoYCZQ73dgSB5zob2G?=
 =?us-ascii?Q?lNnHeFXO7W/v48vQQQNYdMycLrKZn6WBAWKGHnB26Yf+9Zcd7kUTemj5wRrN?=
 =?us-ascii?Q?W4e3QYP/BMK7LsvZG8BsSpQDatcVxMbDEejr+GPDXahrWWnzPve7JUSHwQF5?=
 =?us-ascii?Q?6wUKwIyXtL6RJNEJDjdYqqps5e92nq3271SDx3hfXryrgPY4+mQ9HNWv8WYt?=
 =?us-ascii?Q?1Mof2XmqHa1dVKPbzRWoxLtd9X/nHinm2zoDYMkd//3qiU5AvhTpya3y+LJp?=
 =?us-ascii?Q?u8yrg1LqdrXTZ+xCQiD934fRJBoZgKoJMgpOmE8C1FUv7ZY/JHyHQjSJLWHy?=
 =?us-ascii?Q?Gtvfiios06olKO6D334iSaau0avwuvd6oxmIXoyXdVdN/ksijMVaNam6IqXA?=
 =?us-ascii?Q?oIyppcvm/LSq0XWs9fXhYjuMzvK9A1mSv/JX2kOyNpkqDi0knyK/xlfLC8O/?=
 =?us-ascii?Q?/lrJv1Gb53/G2kfXTGbQ4swtTk1QvNtkBtjemiHqP9DGEquSROE0kDSWnAbb?=
 =?us-ascii?Q?PfK8viB3c/iZq8PhuBPzTo6b85FrYyqDq6NVVuejgpnPLdcEto7zYUpaC++2?=
 =?us-ascii?Q?m3vZ3kB16CkyfadZt9AIiczz8hZm3EkQYSX8ObibVyi7pCozxZqqvkHv2rpp?=
 =?us-ascii?Q?bxc05Bh2ImDrsF4nHhhi50Ky4OZQqxKhFt+7if/OdQfzKcxLVxgi9DwuF4kf?=
 =?us-ascii?Q?Nx292Vx5LWkC6lcnU9t0QeWCCl7vA9zrbq7kPcYbSvMS+bVERU9cqqWKK/zh?=
 =?us-ascii?Q?AUk3dFvWGEUJ1t+rZ+bMrFh+ItKZ80u5qMHaln7DPMw6jW8LJVaIHhXtfFFz?=
 =?us-ascii?Q?HQRb2+UKCtFwPivmlk9uBbuQDHiNjGtFLSf4azdp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72deaf7f-db57-475f-0a39-08dbd0c39105
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 16:50:57.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOz6+CoxcaQ6lm7cPlmm/RpxzDe6Ly4hW0XDrx6tNke6dTFz9JfamUCmqhERo4LW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:23:46AM -0700, Jakub Kicinski wrote:
> On Thu, 19 Oct 2023 13:01:45 -0300 Jason Gunthorpe wrote:
> > Do you have a lore link?
> 
> No, it was pitched at conferences:
> 
> Last year's LPC: https://www.youtube.com/watch?v=JGR9ZCeiW-E
> This year's netconf / KR, but Saeed didn't have slides:
> https://netdev.bots.linux.dev/netconf/2023/index.html
> 
> Really, you should be asking Saeed this, not me.

You brought it up. I was at that LPC talk, and you made it clear not
to even propose using devlink. Seems like that is what Saeed did to
me.

> > Looking at Saeed's tool capability on his github it is significantly,
> > but not exclusively supporting RDMA (ie drivers/infiniband), with some
> > features for the mlx5 VFIO drivers, mlx5 VDPA and a bunch of lowlevel
> > PCI stuff too.
> > 
> > Calling it a "networking device" in the sense of "it is owned only be
> > netdev" is not accurate.
> 
> Yes, let's now have a pointless augment about when a NIC is a NIC
> and when it's no longer a NIC because it has offloads.

This is not a pointless argument. How mlx5 hardware works in the many
subsystems it works with is NOT your exclusive decision to dictate
just because it has a shared networking port on the back of the card.

Lets focus on a community conensus approach between all the subsystems
please. If you have a better suggestion how to address this
cross-subsystem need then please share it.

> My point is Saeed pitched this to networking maintainers *twice*

I read that as for a devlink version, this is clearly not devlink.

> My point is Saeed pitched this to networking maintainers *twice*
> and then purposefully left us out of the CC list.
> That is absolutely unacceptable IMO, but I'd like to consult with
> others to make sure it's not just me. Please allow me some time
> to do that.

It is standard practice not to CC'd netdev for mlx5 related work
outside the scope of the netdev driver.

Jason
