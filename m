Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DC577FBE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353603AbjHQQVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbjHQQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:21:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236DC198E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ5jKqMl0kYwkrxYy72LW6gB0OjYqDUbbVw0J2qBpduyGYSimvXIEGrTIuPorp5SMuWlRvPy7pOA0jVpWM9n/1brHmJfug7Yar6BBXZQCC7lK0bnPTposYFdT2Gqa7Y4Uk/9ytoooA6QR20EeiiYmhQptove6/wmTeE+DR+58uiu55K7TeqPmRdK8A+etnec9wwIRFj780w0OBPmd+wdaC9tpcjdenQS8tpJ9EZX1qe5zotGQ6ZIbkD017VkZCE6nZNc6Ce6c95TPSJ2Wi3K5zeEaJjjGJKK/HCELmP8G+ap8HjrITadizb+3TF7vj/XfBGXba6LB4oU3x1QHlQnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmQqgyWurG+SrUt5LwoJlQQ5Cq4MlBa3kzl+yj/bhHs=;
 b=YprK80OdK7VfoMP1Z6Hs+/JaK2AzGxcTvJtzgoD/XihDNTCKU5N1ZFHHLPR0vUxoV33uXlLBBvfpFjR00+2Fs4lrgOSnlePccZDm7a6MX3AZwLG9wmLxGo1gpOshwvajve8CKPH+IaKTJrRQJU5vfWgY+uZ4UIybTERFazb8OWlaV+Z6C63uALD4lchYYHnff7gCZ5zNyNiJ6LE4vKQ3GkEcz4jwY/AndzG0UWV+21UqkbT1OyW0X2solNfFwPzI4k4To7mNDEbWDi+S39fGea7ID3gV5By8DISyy1QICQfRNjCBJESToVAnSwDKGPKz79ZT7F9BJaNKB8LS7qcC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmQqgyWurG+SrUt5LwoJlQQ5Cq4MlBa3kzl+yj/bhHs=;
 b=RZAFWRF7zDgVXLUIseA4B/lMCVX5Wse3qfVC5bmq8g34bqxnE4OAuXhw/bHpPzajuMjZ3x8Bf9Bm/WsppGexCCWDs+Me3AgeSIkbpNUw28AQcXdH3+IaFS9Nz69+cXP8MGnlbHU+h4UXW51ytEvBneVRBpOsFtvxHLY4zhGSKuWduVI98EXRIfNhDtwBz2xikIJSTsPi7so3giJqJ/cHdKd9VZT1YV1dS4zvblHmncimwCFy+/MA5WojVzTUcGa8nd2ECbljujnQU3KvGMYbTwNXP6kFMO0SV1Je2PWU6X1fhjteqboKkJ/bkGBrli6w50SUSlNnwwEG+ckpZGtx7Q==
Received: from DS7PR05CA0104.namprd05.prod.outlook.com (2603:10b6:8:56::16) by
 PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 16:21:20 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::bf) by DS7PR05CA0104.outlook.office365.com
 (2603:10b6:8:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.6 via Frontend
 Transport; Thu, 17 Aug 2023 16:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 16:21:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 09:21:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 09:21:09 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 09:21:08 -0700
Date:   Thu, 17 Aug 2023 09:21:07 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Will Deacon <will@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Simplify stage selection logic
Message-ID: <ZN5I88rsUHb693H/@Asurada-Nvidia>
References: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH7PR12MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8210e2-6945-49fd-371d-08db9f3dfdc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7LOV9Er1a5zJnTDJB8XQhtycDTDEXQpLcxK5iG9gi2lJt9bUZ+KN3ILF6w1AinnShUBgG1eEqxs7EOomGJwhmisxg90I4zeNhPU/A9SsBqa2ETvMkI692mwiRKQryEvu6HD1vvjGpXHaQCZDKatL6wnXGldn9ecyaCkPl9+dldH4sEnJCKyxyRTIVTr6y0cNqPkElRAq4Cu5fyH/+g1dLpuFSfme1PvhgrjEQgFQP1B1/5CqY08Go3ndeYVPTD86Wl7ulkdwVYV9fT+r6Y2iAm+ejCGRR3PbzD0W2zEFVbwNJRsOs/3VJxX1OMNQR/Xqbrls+eI3EUXUM2xPhKCHsrN1SnanBKqxufLHiMmp22+KE0XHJwEZRTolkDO1IEbpOMKNGSiKgYRmoshQ4c5I34w7n2IE1wGHmr3+AECQ/pajNPnAMeMGMjT/vWx/w8yT/kNPeP1JwVJCKxxa6+Qbu0Rem7HjYpMJq7Hyfr2nQto/a/3culprG+3whOXZVyneiQNyNhQXlokUxS0lbW+39wMrFBNpnP1rw2wYWKOIaQWaoakq1MY7uhJ8Z+RokK5t2nf0yaw1BggLdTvV6UlFhb2Ai8UZk5nZb6xA6Ga2nhuTjqTVE2M5CYIpzQaejJcd0YDHJY4sye77u91rwtdnbYNHr10EzYgiBAbIqvpQJiwZPvGEuCVvD0PyrRcQeLlr3wntKiNRMkR0NaDoyasG861Uuc4scwMdjX8qdVNzPbf3X+Hp+1f0NNPKp+kz7uV
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(4744005)(26005)(86362001)(7416002)(40480700001)(336012)(478600001)(426003)(9686003)(55016003)(5660300002)(36860700001)(41300700001)(82740400003)(356005)(7636003)(54906003)(316002)(70586007)(70206006)(6916009)(4326008)(8676002)(8936002)(33716001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 16:21:20.0614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8210e2-6945-49fd-371d-08db9f3dfdc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:03:30AM +0800, Michael Shavit wrote:

> It is invalid for an arm-smmu-v3 to have neither FEAT_TRANS_S1 nor
> FEAT_TRANS_S2 bits set, and this is even checked in the probe.
> 
> Only set ARM_SMMU_DOMAIN_S2 if FEAT_TRANS_S1 isn't supported, otherwise set
> ARM_SMMU_DOMAIN_S1. This is clearer as the existing code implies that
> something more sophisticated is going on with the stage selection logic.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
