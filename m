Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E632F7515DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 03:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjGMBmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 21:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGMBmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:42:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E93EC1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4ruJSwEeit9+8PSfC5npUZwOjGpT2C12M/NzbCrKuMWkHSBZZKoyWr27XZpSrXLws65bl+wKGAnox8ZT95ghvHZWHRW3EV8hc5Nzwh2ScNcpuhAEVmJHtM3I1oWj9j1CPrirbKWvKs6WzIni7tNz/NmUTFId5qVVZYSWXdvh33Qe6WX5Rpln50xq7grUaLlkqOPs4zFA9Z25STaJf6/O9wZUM/WKfEsT1XZNBZlTKymhcVdQf9wXV3LnZJX9amAXgw/OLQiRTqy85Eg35XGj1DuviN2DML78cfPUy0y2mIVZMiddCcbtlaztu3pCn2YbU50gbNg96f66xT+vj2tUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjGhx5MfI0kggMPec7izd/6wnh07sSIi9gITb9NMcj0=;
 b=CAUW+E8w0+XQ/1p2sJA2M/8Td6tZLXD5nql/6OV7DbHYKK6D7oQURhqOGdFLxxua2eT4gR9O4thSw8QHTiquBqLxkLYZUs7yzo22dw4A4vEkp7UoeVyqN2k8X2duV7Bg3N39xrlLrief7kdP94mJN3XfvhbJ4MuTjYMzFWPH8BHa7e+mT2byKSdFz+PqtTeamO/RV+va/kb7Xv66SUtCuYCKhOeez+aRVGfXYSdp2gv6Mj9cS0DKcWenzd0/Fxky4Plfgud6Qe2mJg9NaI12hPavZe3FK3UPSGBMjXxmhAQmYaH6VSY6O0+UC2ODWyELKuox+9OPjlZYvAEnw6LJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjGhx5MfI0kggMPec7izd/6wnh07sSIi9gITb9NMcj0=;
 b=iD34kgt+6ExErDSaTkj8IoZVJWpFAXYXzTc0TGLzETQVl+KTg/0eNwYS8Dng0CbYnxjV5A/JLo/NSvWHS6W8x1oETcx5npHiRFVKYDntZYq7ZOnWWwBkAcCY86bSFdDNHmRhef1KQ1L15SM36ZsrVEcbzOe7CYsnM3h0zB1y7f0VRX10V8vUqd1pD+XrKSrYqkkYIoJB8YW7rxnvfLCmbZz1kmexnUCnimcrdBZpvazPed4DQa/f/RAZIC4F2gKq9wLF5ylNWKOCedFdHpDD7PAe08bCgOL1s7V6ho5U1/JiQ8JQ1xLb+V+3JymeM9CwIwwO8WcJM3Q/mQSJIEFCDg==
Received: from MW3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:303:2b::31)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 01:42:00 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::a9) by MW3PR05CA0026.outlook.office365.com
 (2603:10b6:303:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 01:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 01:41:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Jul 2023
 18:41:49 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Jul
 2023 18:41:48 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 12 Jul 2023 18:41:47 -0700
Date:   Wed, 12 Jul 2023 18:41:46 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/13] iommu/arm-smmu-v3: Refactor write_strtab_ent
Message-ID: <ZK9WWilcF6GwqHiu@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-4-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230621063825.268890-4-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 89643241-9513-46d1-2b3f-08db834259c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //nNBwe3d7ZvUE/VZ5iUzIS7Ag9chThM/gK7+vl8cNkEjty3b4yT4wlfGMGddHercqznQL6m5jeLIAkCvFOWQnLAQR+TNPlek5D2oknCu58S0kqby8yxhhemEC5g8+eQvLvLryGfdq1TcaWqrAdOqLcg/VAtLcQ/xG+fjFXcNTennU66eFENXM9qcbzGvsrBTrqxz7ixbFG0npHP5n+93TdmvjTy8/U1LK2PQDAUk16luLKSTxX8pSCiVjdO7mpZNxZR1/mC+ONm54q4fnGGyShir8WJgXikAdoSsfX+r0BgOvVTLfbapspedlgr2WbddrhC3tWf6dxt5UqcU4r0JnPqtSIE5Q5qCIIAwS74awj3fU22tznRTAumaZPObDC1VWz2VuyaiSmWeVU7v1roio400Ga1oc4mKyXkR55wHBdrPg4yt4fC7OXJQh0rIU0eQyHOnuWB9iKQhteElAmXCuXMYXAO/CvXZs6aIw/g7QdX400hwextqwcPl2eWVwMRkVcpLdq02WouyRJHRJMaSaO/FnhofXxcnAU5SGFATAojDHUUlo5msZUxMUdio+54mCgLmPgzB4jH2NKgLm2Ko4KHTR3AmyHEU53S9jpEe/aT6TgNlvSapC+XHgif9mZfQrqb01JEkIhPCtw9+9vFvMV4qx66NG1hCzmeRxBtsB5CI//Uwk3wFzHBPQYEZmCDx2eCzgd5G1OiYOpappc6/boYpQMbkBQLZ4TAhivaTCwJwmTYPK8b5tdjiTbnbJ2p
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(54906003)(36860700001)(47076005)(426003)(83380400001)(86362001)(40460700003)(55016003)(40480700001)(2906002)(70206006)(336012)(33716001)(82310400005)(7636003)(70586007)(26005)(9686003)(186003)(316002)(8676002)(8936002)(82740400003)(356005)(5660300002)(41300700001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 01:41:59.9203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89643241-9513-46d1-2b3f-08db834259c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:37:15PM +0800, Michael Shavit wrote:

> Explicity keep track of the s1_cfg and s2_cfg that are attached to a
> master in arm_smmu_master, regardless of whether they are owned by
> arm_smmu_master, arm_smmu_domain or userspace.

An s1_cfg is in a master while an s2_cfg is in a domain. So we
we know where they are. I kinda get that having these two ptrs
could ease the cleanup, especially in arm_smmu_write_strtab_ent.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 053cc14c23969..3c614fbe2b8b9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -689,6 +689,8 @@ struct arm_smmu_master {
>         struct list_head                domain_head;
>         struct arm_smmu_stream          *streams;
>         struct arm_smmu_s1_cfg          owned_s1_cfg;
> +       struct arm_smmu_s1_cfg          *s1_cfg;
> +       struct arm_smmu_s2_cfg          *s2_cfg;

Yet, this looks a bit overcomplicated to me by having an s1_cfg
that points to master->owned_s1_cfg?

I am wondering if it'd be neater to have a new struct for STE,
replacing the owned_s1_cfg, s1_cfg and s2_cfg above. It could
be something like struct arm_smmu_cmdq_ent, which contains all
the STE fields so that in arm_smmu_write_strtab_ent we can just
plainly copy to the dst[]. Also, whenever a device attaches to
a domain having the necessary info needed by the STE, we update
the STE struct owned by the master.

Thanks
Nic
