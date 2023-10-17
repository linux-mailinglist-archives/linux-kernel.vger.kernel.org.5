Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE43A7CB862
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjJQCTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjJQCTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:19:50 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9443BA1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7GINgiJJfMFZKcygTeKjHiU4McrJwdKbXtWAzOm/zQSN4yTWKVHMUnf39Cr86rjERuHph0EjUcgXs8Si75G+4WxgG6YY3yZuujLlr/kr5Ttxdrx1dehOiu3p2PDvMRgyOR71lB/QdeCBjBbYik4W8mUH0yUdrdmkWOD1CX1EAYkv228MI29n3Hw3lJmxHrAaiI59akzus9VPawivadxlpqaAoWJL5TZ390URKo5ZqSroh3AmVVc2a3tCWCJCVA6KYDOoNN6xpPpKSSRBWobLoAfu2dsWJ9XGo4STwz0a5KM4cj3PwDg7q0rXd99MQ+MXhJVmLRnrxMp2JlUlxvt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkHvvLesV53Me6YV4XX4p5bImzF2kLyCCaseulxO44w=;
 b=fmFf2ciEpHMgFdfMbjh3LC84cRBx7+7RXGeNN9DD1pXeAc52Lv7cudhwob9ugd8yL1p+5dAdaXm7p+DjxFzuyGJBVGjA63ZLWSISx7PL0AEoU8fIw+uiWDxcREKxqzJyAI7uL/OGD5usO8H35f4BXtlKD1CuidPCTsUTMcQAwPa/yTQ217djQdk1BVzqESrDLNzRXL+IdwJfl3zpZJV2mQF/g6uHVwEJ5Z7vh1qIolZTNbF1VAgfspP9K+mKHqaqgBGdkOJzK6/ybBIfBy3SirxW6ZlO4iMCIrX15RdlKMTxkKTBYiLwhMRPtRszSdU7iLQNI2Bc/mGJUqUKjm5OWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkHvvLesV53Me6YV4XX4p5bImzF2kLyCCaseulxO44w=;
 b=cIIR3uNU/8hBbavhnDce4U2VZlsJ77ia6H0PBxOxUYGCiT8rOiMIk9q4jb71A1lkPznarNXrDrUO+9N3K6Y+pw7WDZCbR9OEn9nnROoRZytxc9UMMOai1a1AgaZ/c6cGORfobm40c0M/rx+7+L3I1FwfnJ8OU62hLcJZUWWBchHYvyviAGq4vuB15vsCVmiYqOMf362cAVysKLJnuRMONCBmbNALk7mk3kwZD+N37IEfvoIFKNCnCYIig+ki6gSljC0k2eFcuW+9k5WA+6Whr4WQdZmA8Oi2tTQZxAWhJ4OaOoeZzJvrEE4a9blb7N5E2TsSW5DbsRRrBJLZgcQs1w==
Received: from SA0PR11CA0020.namprd11.prod.outlook.com (2603:10b6:806:d3::25)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Tue, 17 Oct
 2023 02:19:46 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::be) by SA0PR11CA0020.outlook.office365.com
 (2603:10b6:806:d3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 02:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 02:19:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 19:19:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 19:19:29 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 19:19:28 -0700
Date:   Mon, 16 Oct 2023 19:19:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Tina Zhang <tina.zhang@intel.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v8 0/5] Share sva domains with all devices bound to a mm
Message-ID: <ZS3vLxikjXj7gDlI@Asurada-Nvidia>
References: <20231017004802.109618-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231017004802.109618-1-tina.zhang@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: f01edf8f-c736-4f12-f99f-08dbceb7884e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMNs94b09rJ7eroUyoihMRAdP8d5KMjYXZDl4I3SN4qVoQtACklEWLWBjYRZ4Y8OfpMsDqJymiQ73ct+KigQhQlbfEH7xTfaUAvhEabBwdWC/pE2qyTFULTQKLQVr4oIFI+EtNADWMSBdQ2jLdaCGn6yoq9Ydh8OgHTOyBGoxTlJujc5GLolnmwPNueS9Gd3Gk8TyZQ7AU2WrTHUT6DLh9ToC70DRJ7TkMf7wuXW5VOHejkEAVKqK8BmNmjM+QLdM+MPfhmYp6iCyR7eafro38Y6w9Jg/v0rg+4JlX6ILj6642cGOAyiKvkGZeo9A30D5ue13FDUqJNggqGJiZEsWbybZZy5L1sESyW8Fr4Fu44s7FJ+w9J21VphRQvMgsP3RgeUuTUYRB1wAnZAPCNK43GqKAXc+lC5bNT8glQ1856CenOiXOKz2fBt5wHIuDEddAzZxgRWcFp2jtiPP/uzES363F0cmJcJytneQsiAkuy17tiBbgCDcVKAVOcwdoP2WuvqN1vpS3qUleExU2/U2n5uzp5NR935/SfmpsrbSDTlki1ZVcRk4AVFAqauFyDGj2zQ5/27HxXUD1ictfW6y1EslpDO4SXbiSb9zhHrr49sSZMgw0OyUD2OGc1wE8DMgfj3AkJmK7u4o1Rs4IE2d8ebzCGjbM/GRbOZwn305mk2RTSE+UGf8Oy/wuMf9cludsoB/Hq72jIyXEk7N16EY23Q5o9ZhR0pk7p0Dtd8WmPa0LYncJDTP1FFHlg5T8rdBIA3AP0TUIxGeJE0wUYL7+koFEndjQG8ZQXRYoxcMWw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(9686003)(5660300002)(8936002)(4326008)(8676002)(47076005)(966005)(478600001)(26005)(336012)(426003)(54906003)(70206006)(36860700001)(6916009)(40480700001)(41300700001)(55016003)(316002)(40460700003)(7636003)(356005)(82740400003)(7416002)(86362001)(4744005)(70586007)(33716001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 02:19:46.2708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01edf8f-c736-4f12-f99f-08dbceb7884e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:47:57AM +0800, Tina Zhang wrote:

> v8:
>  - CC more people
>  - CC iommu@lists.linux.dev mailing list.
>    When sending version 7, some issue happened in my CC list and that caused
>    version 7 wasn't sent to iommu@lists.linux.dev.
>  - Rebase to v6.6-rc6 and make a few format changes.

Tried Sanity with SMMUv3, though there is a merge conflict
against Michael's SMMU series:
https://lore.kernel.org/linux-iommu/169712689838.645382.14628592932614139960.b4-ty@kernel.org/

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
