Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADAE7CD6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjJRIt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjJRIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:49:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6006FB6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQbZVvZfH75HMPWI6W/idbLKFc6dJ/oqJVsG610H3r0SLp0X+iLXtJznW4O576lee7/W3NtiY5Bx49RMj153UfPYhWzvPrSIyrMK/aYozaFPDSAXLXRuhnGZ4Wnahd0bWZG9V/1wUbNhe9W5qsPh1Xu/z+ufCzH4Az/ydQm6NkGt4VVlU7RCw9xrY1Z4jTP+J0Q/5SiClT2CSrK3ZYC4pO6afPWBJJaXGmiJtWpF/2BPIJwg2sXnN/6V7eHSvqnGhWcpfkMsaUc9yxqMyrBMTaDeRi/RbsFwglIE2NpVBBkIvbtXLn0UYKtF9DnJ6POPPSgzcY4FY4ybTU3AV1L41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcunZ2YlLsrH7uM8o+c0kHo2l2pqMCr0ho7H+pr4RwU=;
 b=G81D7OXB5oeDTGHP1n6MvnlHqLXxi3uiQYyTzjkU8cCTefD1QS8L+zHkIniR0CPX4z1amtNXue2csUmEbfNVmqryoTin/IAp0vqOIa41XfE3vTlBeki2R/C45rFKRDE26A3y03EOb4F3sz0tCrzTcyVmpRSsVVlndsvbZIcdl2CkhKBGEIX5+oe/maR4qIilwzilnyCd9n3rSyUtace6y0MLBSbGq/6Gp8zKwO0TWbkVH3GJOZpxzr+TVoHQfLS52nZppTKZvz8tuzH9+Zh25zkdRRuzO5z/ClNWSX7sA1RruDAyh6Fy7JS0gOKAAP0WW8OXlMQYNfKjkx2/rkR46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcunZ2YlLsrH7uM8o+c0kHo2l2pqMCr0ho7H+pr4RwU=;
 b=DikAF9Z2UbtoStJ8K+DAox2reflJDg8/1qLFyZq67E0GNbhZGA32vE3lMBw/T205yhT7wXmeTvkKQiaBgxDD3dMJfoT/b6T4dRXEgWP2At9sG7sYLswLaKQ4WdhSqi/0nGPuz2DF0T7s3V02eV3DNKDE26iN/nyRsOSjJs25e+aO1c/ZD9CUOgJdJwI2hO5kn/KOsDR7mNzykWDVTMClQB1KnV6c6Gz9jn7ag5ibViD6ymRYUbgW4IcdH9/EZiDHQfsOmPPPbfUuEXioALLmccZtd/E5UqlZh0XDWXzM0PBLwQ41o9osaCxDU3QZLNt355KhPxF8oDoE+EdmUG0r4A==
Received: from DM6PR04CA0024.namprd04.prod.outlook.com (2603:10b6:5:334::29)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 08:49:23 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::96) by DM6PR04CA0024.outlook.office365.com
 (2603:10b6:5:334::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Wed, 18 Oct 2023 08:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.22 via Frontend Transport; Wed, 18 Oct 2023 08:49:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 01:49:12 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 01:49:11 -0700
Date:   Wed, 18 Oct 2023 11:49:08 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231018084908.GF5392@unreal>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023101835-trapdoor-unicycle-788a@gregkh>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd4294d-9997-4a27-ee3f-08dbcfb72087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdjwL6UapWgjCC8KXL+/bEvl761yngxArcLnCxIvCey0raancZuwyZWeszKe2NFe2QFioZIUNnlFrI/xe2RXBfcTMjczsMwnlh6kbXh2fJv8UDAta7kTA6j7RD6MIyNt4xLVS05li1gXg+gsdM6/nPr54hHbmOFZUyWQ2X2RDRa4ZoM3PuKwDFM0xGgyEDVN30KbP5wuIz1P77borUVFPyKHFA7o9+xjsW+DpV29kY8k+TWebS2uR8KlWjTlk4C7cSlmGYjWsq1lh/f+qAoqTsOh33EW58woMlQgp2DGQfbTg8J2INXMRUOqtticshDz/wbtXkGNN9TxBi72tp06jErQmnCjM3zL9NuJ0y7kDF1gnmcjexPLpkmPTGNl89vQRUz3KQembDfkolFOgjuxXK9AO0kDJMZ7hDC5LGOomrUuLwo9aWwuLWoudDrGaBKdJKq7bo5jAdp3nb8vfdmU4IsxGNf01uGo0tDFQftrsu+0oSbocZZL1NtGKPhDaIe781rcXChR/3est3u6BVFcQkW4TgAZ88EBOli2nFXbLbGX/7hBwnnmOwa/DalMraGtW3SJn5aGUR1m9WAwYMgQm1kYuov0rirM3atv0UGUhJYU1WjSpRwHsfr5Z+v19R00TG3r7OPMuP+7d110HaP4pH0jElY2pY19k18cobxVMaoMxWFJzjPErwibnOcYYEvFKC17Uq0HWFJ/HDF/hMUtQQYa6FPzDXBiSXDzkucdUDeY6+dSVkTQRDPRIltTiDR8tIE39txGixZUxcBwMnpmuEHoZNoOuPn/4dsIMbjN0uY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(4744005)(2906002)(70586007)(6666004)(316002)(47076005)(36860700001)(7636003)(86362001)(6916009)(70206006)(356005)(54906003)(82740400003)(9686003)(478600001)(33716001)(426003)(1076003)(336012)(26005)(16526019)(8936002)(5660300002)(107886003)(41300700001)(40480700001)(33656002)(4326008)(8676002)(42413004)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:49:23.3238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd4294d-9997-4a27-ee3f-08dbcfb72087
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:30:00AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 18, 2023 at 01:19:38AM -0700, Saeed Mahameed wrote:
> > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> 
> For dual-licensed code, I need a LOT of documentation as to why this
> must be dual-licensed, AND a signed-off-by from your corporate lawyer
> agreeing to it so they convey an understanding of just how complex and
> messy this will get over time and what you are agreeing to do here.

This is how we (NBU, Networking Business Unit in Nvidia, former Mellanox)
are instructed to submit all our code by default. This license is aligned
with our networking, vdpa and RDMA code.

So yes, our legal understands pros and cons of dual-license code.

Thanks

> 
> thanks,
> 
> greg k-h
