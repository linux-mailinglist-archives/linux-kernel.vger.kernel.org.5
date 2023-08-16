Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5474677EDF6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347228AbjHPXrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347283AbjHPXqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:46:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556672D75
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgvY6ERJeHmKImcS7/2Ccx4Gyi4eRbmFDCJj53C3k0049w2eCTtAQAjy6WmD6RIjSMVZL/LXIZGMSEv6H1KCWvKdcDgTDWzM5Za9b6iPvx2KoTmYq9eTuLD8sM26VSOblxaYxBYyVB5TAHGuOkD+Pj1ReiHy7JBBR1dufVolxJO03BNysPf92eAMQ72xiFENDBs8EUvaQuxtSCJ8hFTK0PVDpvDSOHFaw22BULYccN7yuUEWAQojhhUejBt9wOAC9FM7FpvAGj7yVg3AZvzIIJuCemUboCqqA1JYDNsj5HpfJd5oKFi1+OcqKHe8Z2vmFEIKV+5b6pwFXVsRUe9cYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEKP429hq+8FzgU9lsAFj8zD6+Dd5iViWZIACf+j8Ho=;
 b=XyjRdMW2acosRYmxYo7rdMgjf461H2e/MTxUfTbJ0i7oDKhTzXfnwvKVqqm9QAEfyTDz0ENAdiDVubB8H7C1ji7YpHbLvikeRdLGdS3slG/5vMqphEQc1oG3J32sVroQeMkeX7iaHk0yZxrhSL/G9RzWMHM28CoBappNYbU3n0tcH13xLclIO0Akwn356HCAXgIWOzcuQf1BJKkzjhgss6JNcTdikqWZ45CMJm/ByTDS+gVkA1gFC/U75LDLjhjWwGU6T0dGT19Va/efyjrfzKtIixuca2WHr4+ufxZl9YdzKydObrFxdhhyUhQQdmFkw7+HTpwnitZ30li5QnPDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEKP429hq+8FzgU9lsAFj8zD6+Dd5iViWZIACf+j8Ho=;
 b=NhHzqBUwghPtbHUV2DU+t2IgIK7wB5zISN7N+esarTSuqPPsFkvcJaxcQ1Ae4b90k6RJeLGvq/XJJH8hLeJsZfme0yYCd3Zh/gsKlvN+ZAqBV/59nVE0xPWYBW/KOKJRvyBz1zrBphdydEAeLLcjJY3N39sbY9J1MYXCMyfnsi3gNqQWCy6vkhApeWd3yrXBVaebTfi3uzZxngnPkSU1Pq0XvjV1ifEf9PlUlUtPiSIGLyETCbeJE+lP50eHAVEB2MAysxdTdU6fAcNs49yASBSzZtLSfnxIR5my/pSwPNHjyKoX5D+JbHkTgV6vkafrLvE9lOXwVz17zCPOKXM2fQ==
Received: from BYAPR07CA0090.namprd07.prod.outlook.com (2603:10b6:a03:12b::31)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 23:46:38 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::e0) by BYAPR07CA0090.outlook.office365.com
 (2603:10b6:a03:12b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 23:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 23:46:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 16:46:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 16 Aug 2023 16:46:27 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 16:46:27 -0700
Date:   Wed, 16 Aug 2023 16:46:25 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
        <will@kernel.org>, <jean-philippe@linaro.org>, <jgg@nvidia.com>
Subject: Re: [PATCH v6 08/10] iommu/arm-smmu-v3: Update comment about STE
 liveness
Message-ID: <ZN1f0ckpSh7Tfiu8@Asurada-Nvidia>
References: <20230816131925.2521220-1-mshavit@google.com>
 <20230816211849.v6.8.I7a8beb615e2520ad395d96df94b9ab9708ee0d9c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816211849.v6.8.I7a8beb615e2520ad395d96df94b9ab9708ee0d9c@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 3237afb3-4853-4140-ce11-08db9eb308b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTS1bn15tNhsLWRDtGsYhlTRaq2+vpDs5hblRMsqnjtxSuEAtih1NsiyJphrU7rPoO8vrEZrNqMDCj1k4XGAlrq5FCFTMFCmWOftF8pTH1Od5f2p4dyAT485jsp3gUsQBe1RNZoCnFOcScIDmYYw8iWtPzlYyJN3N0XCCJNKahCboAPlafmpQTMBtSvsKRqge2VGo3bFSKXMMIgFwolvtPDbJawaiSec63KELBsqlEzrBUtrPBqD0+JwbNFh6kMDzkn4Pus6nDx5PtQJwxM9YqptxTMFEcavce/E3XC2FacRLG5te+6vXZLCshfDbDRX/bFf12qvHaItOrXExGU3L68v65d2wKn6/TjfjFxoG07eCYc3957PtUIG5JuDugmHC7mbj3VyoIJo+z3+ymIw5AjdXdC6DHt3ua5r5XH3rza4YwNXqffvDeNBmAXYadfBMeXR4jHJq7DDy5//iYzBbmzf8xRMjfPJ+baMYno70sIzLL5OfuDjT+ST5FOOS4I7ImXH/jr7SBsHbjdOOILe+Vr8aQhF6JsbT0lda4aS5bZRlBxoeZ6nKsKLZ8ZfLyzLB6541NaaYwZTA5ercg5g7GVJM+sMLGbkwpHnzQplvNRBxjJaWAdYf9/zgowMy4i89L4ydT8+H1rM9J3OhXleKRWPQ6wrOi4pjzEDu/hNtoqIGLYmn+9foqbsKPLVXZ0U+FoKCmJI55aMPQdO9+O2BIrS/8Ozy9BcoV//XiELAyM4/+pNH6z8rrVpbLUJ2CEn
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(7636003)(54906003)(356005)(82740400003)(6916009)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(4326008)(8936002)(33716001)(2906002)(40460700003)(15650500001)(4744005)(83380400001)(26005)(55016003)(40480700001)(426003)(336012)(478600001)(86362001)(9686003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 23:46:38.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3237afb3-4853-4140-ce11-08db9eb308b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:18:48PM +0800, Michael Shavit wrote:
 
> Update the comment to reflect the fact that the STE is not always
> installed. arm_smmu_domain_finalise_s1 intentionnaly calls
> arm_smmu_write_ctx_desc while the STE is not installed.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
