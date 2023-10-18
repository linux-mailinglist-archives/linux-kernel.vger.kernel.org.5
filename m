Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBED17CD8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjJRKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJRKAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:00:40 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CAEFD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDl7kcq+fDdBfWt/XwQDeRXfOuIh4cXo7ieKUKTLdw2piLqxqWb9B1DkMRq3kIh4rhjJfx9ePwpRDLPoKLrxOudtjLlutO2pFwb8wGaU95uVIMCa9wSeyMB7IerVVarI+6YuNTsAGIIs60ZP1CVBtOY0HVwRIHLCLs7jOcmeKthNT8sWdspwxxwHd8OJ+Ra9f9ZuFsY5ycT6l62lZNjhXCVIoP1EG7Vr920blCCBHYclV3hAD7Jjkpl4yRsxMYwLr1UN1OFGWHJzS6ox5drofUo3SK/hy8Ci0vH+nf9xVgDrLSYBfB4dbpbcT6Do2DjlYC8EyET+ZTZOT/9nzYMnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LTyRav9HjFpObqjqh3+HGCTY5H5jmLpGQfFLKJbqas=;
 b=JbuVJM4kPASwfaVZQjOXfjwEuURj0C8ucBHzMn2u4U+YvhKTLda91TKA7yockKocf5KudOIQUEjC+M0O7WNJdtWCue7IzNvW5w2jQ6X9dLiLO9pPwn3+PzXGzSY3JwSRpmXbggHeblTqkd9eA8X6xpRIyJ9Qmh7rGUOL4HGPYrSeSBIck/ej1MeeMnJ/Mbu2gVT+iO2sepiVosmiCz2FVYB+CFc4OMrS5XRVup/FYVh6WB59wd+mJXiqIvtg/F/Kg/v/CzNAKK2iHLFgSTNs+pJoLwb77bNELkcJ1kWVIEcgvLk/ZCDsGzWV6jqBFF8/J3rOMQM/+JbSr0a+TZHAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LTyRav9HjFpObqjqh3+HGCTY5H5jmLpGQfFLKJbqas=;
 b=EOaHn9MptzAnKvpbjeGIkVcfkWVotEKB8C3rXN2UyW+0oVU4+//r2hAQGf4ueY0WlW7zywJr2Rk/8VrMvAw22sweqjydywVuWrMRcHzWap1yWWHb5UfYdfmt8cSygK8pmYgoilNGdySW9X3zpKsvuAT6UJdZcFtqWcuBF01w+A41Tx7+TIEuH3R8naEcviQYodkIeodMctDH6p3oDGLA72zYKLM3ljugx1p++BPLX8Z2tfQbZyyg+ld/7MVXXCHAGqCZuGUQpNlJ/QUz826THeCdaChXcd0wjjNxZ6jG8aLV6ovelmXBo5AZWsYn5rHky2aizWmnZXwy/qJlsX4S4w==
Received: from BLAPR03CA0101.namprd03.prod.outlook.com (2603:10b6:208:32a::16)
 by CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 10:00:37 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::f3) by BLAPR03CA0101.outlook.office365.com
 (2603:10b6:208:32a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 10:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 18 Oct 2023 10:00:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 03:00:18 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 03:00:18 -0700
Date:   Wed, 18 Oct 2023 13:00:14 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231018100014.GG5392@unreal>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018084908.GF5392@unreal>
 <2023101814-thirsting-culture-1a4c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023101814-thirsting-culture-1a4c@gregkh>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH0PR12MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d8e2be-3a65-4c9b-0a60-08dbcfc1139f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvW/v++NNFBgjQOdXuXetfnbLAIA3xQAbHtut0PZ2cJmGCKGXpsQeOk70pTXxIPBXykfGkA1mJOAPyEa+l+9lX6rJnsWDIw7VIC/plfzzXxGLuNuLFyZB+1OvGHBDco8ORj4RZvGqKop8wW1sdnz0KxrByorETDtfgeEyBacdBOJv9NfUca1mhhvhcJoWdQFWpRanuULJgoUjWh0sq9bhzEJVTntofX5l0AxI7zP+nEAuXMnyB3w5tDbeYTpVaa8DiNUElD0BcXXGaVANa7n1dE5ZNCIXv/kVBTgPxbMm73pO4Lo3pcM/ahcdAHjV63ryoMl/3G3Cz4bTAVxAsfMQuoLzAnwkrDJOlDwnGoMKBZnoS6X23JOzUPc5diw8WnSxSJQhtnX0Nd2qSjtUsvR535Qd4z+qN8YFHAmoosqyFl4ykAaXg9LYFzzI9h/RpS88+u9hwXcVokpNy2bNo9LRzmRF+360YvE7yZa4p7/nHWdlnnv5c+M41mCBhmnR5jK/Co5lGwCpWFh0ZnXViHfmx1fzOTKzkI+Bgp6irf5pR0kboCtjheo5px/ucpv9vAwNmxomVAUfulxvVWFCFph6Wx9Ytcyr5XiLwo1N+KFSocSGAcjbV7EkhrvEysYGNvtT8/MXV31ldzXbAiOoPH0DAiDqZQHgvaJWN4NVQ3cL8/vknNQxy9PuSkWecL21JsxOy0VYy+JmihCfe991fHp+l6hyFUMXDXNFtn1zuHNMc9isftBB78q+0RvQxYJmkGGNfCNzqlQUYZmn9rpvrZ/LQ1aDLC4cDXwUFw/59k1N2ak0/FMg62AaynIdtL96fF8T2diMDrF5q4Lj3eQFEo0V0uJVzOVXFacXxKZfRb+A9rC+fkDf/xNRCOwKizAuzyU
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7916004)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(33656002)(40460700003)(70206006)(54906003)(316002)(6916009)(70586007)(86362001)(82740400003)(7636003)(356005)(36860700001)(426003)(336012)(26005)(107886003)(1076003)(16526019)(9686003)(6666004)(2906002)(478600001)(41300700001)(966005)(33716001)(47076005)(4326008)(8676002)(5660300002)(8936002)(42413004)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 10:00:36.5853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d8e2be-3a65-4c9b-0a60-08dbcfc1139f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:55:35AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 18, 2023 at 11:49:08AM +0300, Leon Romanovsky wrote:
> > On Wed, Oct 18, 2023 at 10:30:00AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 18, 2023 at 01:19:38AM -0700, Saeed Mahameed wrote:
> > > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > 
> > > For dual-licensed code, I need a LOT of documentation as to why this
> > > must be dual-licensed, AND a signed-off-by from your corporate lawyer
> > > agreeing to it so they convey an understanding of just how complex and
> > > messy this will get over time and what you are agreeing to do here.
> > 
> > This is how we (NBU, Networking Business Unit in Nvidia, former Mellanox)
> > are instructed to submit all our code by default. This license is aligned
> > with our networking, vdpa and RDMA code.
> 
> Please don't do this without a really really good reason.  Especially
> for a "misc" driver that is so linux-dependant here.  

Like I said, it is our default license. Saeed will change this code to be GPL-only.

> The "Linux-OpenIB" license is old, obsolete, and problematic and should not be added to any
> new files in the kernel tree, outside of the island of
> drivers/infiniband/ as you all insist on that crazyness there.
> 
> Heck, it's even documented that you shouldn't be adding that license to
> any new files, why ignore that?

I don't remember being asked about it, not in this patch
https://lore.kernel.org/all/20180425203703.568152337@linutronix.de/
and not in this later patch which changed LICENSES/other/ to be
LICENSES/deprecated/
https://lore.kernel.org/all/20190430105130.24500-4-hch@lst.de/

So it is nice that someone decided to deprecate it without notifying users
about such change. It will be better to put Linux-OpenIB to LICENSES/dual/
folder instead.

Our lawyers are perfectly fine with Linux-OpenIB license.

Thanks

> 
> thanks,
> 
> greg k-h
