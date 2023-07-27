Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03369764508
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjG0EpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjG0EpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:45:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6A3270F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iz2+UVJk/jDg7QZp6R2XdfVPSXlQpb70eJjXTwsQjaNoo/FCVPoYm1NIXreND2AxW5uOR8tW+oPlKT+cFlNKfQ9FD78le/1EDHeBAMNodN/5VdpQmkAYfNvoibBRT/kXHL8HM/47BQ8nI5DDCKxdBd94yHqWJUiCiqbZlnFPWO3+/Z4LY2SCy3iPZl9JaxhMJLh0QZ9r+0e9sobFPFbZFnBAStdjHir8t3CaKoetuTQHflWB+tu2Tg8ip+/AqVddKZUroShk+4XZ4yjvLRVE0TuB3v4B7+IjfQEMx3CGO9cp6N9cinNHLK8WK5FQqifH5V9TIRJReb40fBud4wXzEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjPY/704sApNKCbBkQPg9XyATjO+1Ufn3TYrAdzIZy8=;
 b=ev8OM0ywY0x5HkooET42wi2+L0Oa/jDajtprQtsCo6rnFC+kYwuWB1CcfEb/67fBcCEn6mO/Wmri/4LSWIThvdGQs+p+tMlg0mtjjyFQspg0tpx8SsaSVCNpm+6NMzyx9nbTObRr/SbycBlSBRQKNJMlpIb6edqSiTzhq64LbN4Zd3WrIeFnr/hc2DfJxdyPS26fpdRl5YPAY02BZKIh3mDb1+ZgCYfGHD9f0zakX7LlnRaDY/WlGZ6W9v5rt5/Srzkc3sdrCwuFUEPzoCI/U+6THDdreiDhRXftpIA9DuplzeaIwgWupBb/qvIXjpY7//DlqwwyOY6cSDVbIBDYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjPY/704sApNKCbBkQPg9XyATjO+1Ufn3TYrAdzIZy8=;
 b=nnP24J1GAkVmUkHK8AOSr1Uslm8+RrfvkFQUe8wAZRzzWAA5GyCVVybqJpaPZW0jg3ECIxTuLuCn5JY783Lzaat9WUif/PXLKo20kRecq4O7fi0qJozTRycVSHkPR0Ov25bCsYRJicmRnDqmag5sWLP+sED9wJk4Pu0PJs8sYCkJCGa7A9JGFLcV1D2/qciz+a0YgfcDP0mnrIdQ5E86E0VG6FzgTgQb+e2IUxqvFxb4XIFxIVjSL9jOkzkXnbnA8nBOHUg0dBHbrtfPds1wxSq/MXYYV7B4UrChhhRdsthT+WRETwUaXfPrrBR1WzJ8NEIF2M6uKAnMLAKENxQ0ug==
Received: from BN1PR10CA0030.namprd10.prod.outlook.com (2603:10b6:408:e0::35)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 04:45:14 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::bc) by BN1PR10CA0030.outlook.office365.com
 (2603:10b6:408:e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 04:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 04:45:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Jul 2023
 21:45:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 26 Jul
 2023 21:45:02 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 26 Jul 2023 21:45:01 -0700
Date:   Wed, 26 Jul 2023 21:44:59 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
Message-ID: <ZMH2S93UCF5jGfvl@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-8-mshavit@google.com>
 <ZK9cyDaFkAKc1SvJ@Asurada-Nvidia>
 <CAKHBV27FbpJHoPC5_8mCYHmhEbCaCE7st_-qzPv0uQYSH3RC9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKHBV27FbpJHoPC5_8mCYHmhEbCaCE7st_-qzPv0uQYSH3RC9g@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|DM4PR12MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 709cb4e8-a1f5-4306-1830-08db8e5c44b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dghVnJ3EyzEdxr5QLC0XCRzx/jhf8Yd1Om/a+cE07hpKyztJVlsZ857DiMyNGl/gIrtJKbXG2hmd5btcYdfEIqB0YYtnoKkfAimNB6sRgugCHyYhrjUrDJL1nIr9Sl46TMd/H7QCQrhIR2r9Vwifh0+1Y7rgPuWmZfq8t+4DCkSqXQV/fnLYLrLoxyuKHWoK2F9NgOrZlYPT+96vcTM5scnX+T6QlKW0eBXJNy1rbXKZw+jMuJSQcXVj0LfHscCsLnPohEBRNicycUPDqyHTp6MPv93mpiYVq2kn375yDo7XAMb7oAmqkMq9N2OuKk8rNU9O4WcT14TtwbBI6jMl4LR+p9BmcsSTdmXf32PfopxvY1erCjHt79rwkN+GfJG84r6ce2s0kFL3sbJHOsW6U5u5DMKSy21R4uF1Pi5DVUhZdZPPr3hg9C4FzagFIPOW+HyxUKJBaCKD7bOUJNgq+kYx+cqMWZhVffnLdiqz3HfH0MQi4HR/vV58fYFwRvY8bTxvfdHsAX5WVjltyjWgIylgrMalVJjFCjR0ADmc3gpACvPTvQjLAOGKL89pxPcSLvB+PqaNQg7jOSdpurrYSss4fMrUFZPQfRoKjJNYh5kppUuNXxeqQRDebhW9oeI/yVQv1v74/9BHkT3xfQIki2UIIxFcQT+dUbWEyWb/U+RrgTSXdzpm4RSn6u7m7DTSDkapsiW5kTwK9nvZAFbXME1YUqT8r0FNOE+WuX89mwwHVDR3SOY8On0rI57lUwY2
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(426003)(186003)(26005)(40480700001)(55016003)(36860700001)(336012)(40460700003)(47076005)(7636003)(82740400003)(356005)(86362001)(478600001)(54906003)(33716001)(316002)(4326008)(41300700001)(2906002)(4744005)(70206006)(8936002)(8676002)(70586007)(6916009)(5660300002)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 04:45:14.1774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709cb4e8-a1f5-4306-1830-08db8e5c44b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:48:23PM +0800, Michael Shavit wrote:
> 
> > And since we have a group of subdomains that are simply indexed
> > by ssids, perhaps we can add an xarray to store a subdomain ptr
> > along with an ssid, replacing the list?
> 
> Hmmmm, I think the only place where we search through the list for a
> specific SSID is during remove_dev_pasid. We mostly use the list to
> iterate over  all the masters/ssids that this domain is attached to.
> I'm not sure if moving to an xarray to optimize the remove_dev_pasid
> call is worth it (at the cost of iterations which IIUC would become N
> log(N))

OK. That's fine.

Can we have a smaller rework series first? Let's have all data
structures defined. And then we can add features on top of it.

Thanks
Nicolin
