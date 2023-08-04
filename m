Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E717770C6D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 01:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHDXco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 19:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHDXcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:32:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253AC4EDD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgcszRTpaF3vk9JCBYmrbidhoSTYmd073Z6S558abgGF9m/oGthJf8MJUjm0KNm2OxOQVgpdRgnXlPcJLZ07+OOH5H5Gcr9hO6oIKL/9Dq2mai6TWuO8Urp1XV/zB2f7pj5iWh1qNodDfqp5CjdCDYRY3U5cT9qzPPMpKzXiOpfiCPUzAL4HKy+OF+AAc99eN21YKGT92PPFFPPC/bgmJeNAIIRu4u87FlEQdhDW72Qv+jRLxClX7mQz8C3NOtrQWz5p9e9+OjD5eJ6OAnZ8PCEH563rmV4E5+mOy9eT1jCVMhhoXYH6PbLY2qUU6taRPifpMTogezTm3gjH0ZV/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9X0IzKS8wcJjc2Nckme22jvRab6J6z8HBS5tvrJxr0=;
 b=PYZAU2ltmX/LKx9udhmkSdUqRVZy86mieEYATPt+06lsadEyoEelQmjmYsHLuGh8a/dkgIZasfCnGWtN4WUGztsd6ldYkIOAmhU5j4+CbauNNfYOWfFGSPd+W0B7RFXJfD6ZV5n8u/XCUhEPZdz+rLwyKQAiQrnrcPrqmu/TPRBUjfWNfFntOy90W4kHpQLmBfDMOwoD7lwrO1XxGAskD3Q4uMhGpsIzAgfHrE0zHmDSsbl4jsO3PSSEzTHPVM8SpVsFAFC8yrybFlxdbvExFOQbnWyY7prLqr+mP4CvYRAJwtNsB/TMN4IceSllIOLzYShdCnyRgBAndhEvn2PWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9X0IzKS8wcJjc2Nckme22jvRab6J6z8HBS5tvrJxr0=;
 b=HD7qcZmOC5/osW8GEo9uNcCAFbacWq8UyEHhHi7gWTRSoc6rvc+Rim12TECB0TOKaO2oZ9+ONA+EuOdokrZ8JPRU6ZIBLvY9CUhfWZKLGTli3s5OaqgCtD6R72OdndyVcry1yc3XPw/DWfxikvw400pe9dpq7t/hO/d++a9KGDtGe0EYKlhtd+OWg61tA71nDGwNiT+8F3K6hPVmWmA9ihC0fy6qGzot/fZe/Xij/n8+FDbyKyW85vJL6EpdQzqLUpVmoEOtSuUpIfjZLZ1IH4BS2l9z24SU78mK08wQGL2lr3OCARhO32JcJ8ftCS08AbfSfXcZwakJFw4q35+0qA==
Received: from SA9PR03CA0016.namprd03.prod.outlook.com (2603:10b6:806:20::21)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 23:32:38 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::ac) by SA9PR03CA0016.outlook.office365.com
 (2603:10b6:806:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 23:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 23:32:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 16:32:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 4 Aug 2023
 16:32:29 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 16:32:28 -0700
Date:   Fri, 4 Aug 2023 16:32:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd
 table
Message-ID: <ZM2Ki7MDsNLkBEQ9@Asurada-Nvidia>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803003234.v4.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e059c2-4bcf-4b99-2e22-08db95431693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VB0AzTjxnqJ1CYSax4jyC01O06KfC4Grzbpl3ese+sOAj8A+OisUwMri68OGrzNMRsOc1xk5rq8LrozTs3HJm63+uZvGcaIZhNp7hVFnu3AXxdYfcDC9V7p8WcrsPGVWzUQxXUCknOXeMFNy8GCDFaPENZ136+qrPVMY81naaRucMnFYhToVj5TaTDv4RtUFsdOA6V/YAZxh2ekXSjzTbQgMylwEtbNNKldtfcIzZ6h9QBgIKpCiqhjY6Q1pqIcOYoWEz8umcJBvZ+dUEfuyoL0Mu0Cw/JHSjx4AIso2KQzSN86/ZqfgWJJVufH9PQLh/s/pCGwTCMqd2iHMzBn5nB7vVO5/MSwfyrLs+kpVp7t8ORQzBhhAELRPjpHlKuRuzpa1kPC8pnSGC8BY1ODRbcRqAmBH1nzI+ZbPRSsAXCEcnEDX6YT7jj0d2DkBgbK4vYhmny2HfMFmF3EJ4SxRw+Jb/0BOVXQgh2tleCY8zAaXyF55kIj5zVdj4fHSPC14zTTBk0mkmrjBQKDDurImMbsyGkteJeCBHoaVwi+UTKvOdSiuUX38Jkt8z4Z4+02REv9t+f5Z+uRD3u/4QJ279tNL8AB5e5YlmfOilyzJK8r78DwMp6M41zC28zWzbsAcdh+iJT+VCy9C8c/HeTfmqoNpuYVEmiumaQyjbnajCso4JFMURS0AQcGNk45ovIdIZVHGGi21tQtLRJeLySbXiUe6Y9rE0I6awVRgx/aLjOQW8l+hxvqlK/knWbykYRgi
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(1800799003)(82310400008)(186006)(36840700001)(46966006)(40470700004)(41300700001)(6916009)(4326008)(70586007)(2906002)(8936002)(8676002)(356005)(33716001)(5660300002)(478600001)(54906003)(316002)(70206006)(82740400003)(86362001)(40460700003)(9686003)(7636003)(26005)(36860700001)(40480700001)(55016003)(47076005)(83380400001)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 23:32:37.5742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e059c2-4bcf-4b99-2e22-08db95431693
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:32:32AM +0800, Michael Shavit wrote:
 
> This controls whether CD entries will have the stall bit set when
> writing entries into the table.

It'd be nicer to spare a few more lines here -- something like
this yet feel free to rephrase:

The stall bit of a CD entry should follow the master->stall_enabled and
has an inverse relationship with the STE.S1STALLD bit.

Also, a domain should be able to share between two masters, even if they
have different stall_enabled configurations, in which case, two masters
should have two sets of CD tables, i.e. having two different CD entries
for the same domain holding a CD.

So, move the "stall_enabled" out of domain to cd_table. It then controls
whether CD entries will have the stall bit set when writing entries into
the table.

> Signed-off-by: Michael Shavit <mshavit@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

With that,
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

And btw, you should probably put your Signed-off-by at the end
the commit log, i.e. behind "Reviewed-by", meaning you created/
updated the commit, and then signed it off.

Nicolin
