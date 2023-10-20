Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9BB7D1951
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjJTWtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:48:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E72D5A;
        Fri, 20 Oct 2023 15:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5SRAc86Bj3Web64NTAHTicB880ngEE2Bo06QC2EaxPAS32IpRZMdwyb76qCHEESmNpsZx++dPsUZWjBh9K4E79Z+8vewp/vrdq3qD4AI5wUqgJ73hxXnVh2TrZuYbG891nTo3ALmRuvpAziUsh7RNavh9LeNVayr7o1mYsLVfz2CZpUBfbq196mjmMua7PS/+yitoqgYruKOFJY+AJ/Bud0q7zBac+Maux1+G4oNidd32krpdLTtQJtCVYY+r/FNyORZ1qKC71UDZTakFkB4FXY9+XzYwpF+iSmjRB4eXSSWtk/Az3pgEQ5PWlSyC30FzHZP+L7VLuCJuke68kZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8MvZdK+qdZqZIKPUdjQfdkkRmaIgYp+7AcEJW/95dM=;
 b=ZPMFdJTnj7aSv4/2KdnJ+SwkYw+6trmbPutJr5ROb4PIGzjf8CMH6we+SZDvHe/X9iDl964j5iHBrHJSwPLQvkT10JCz/EopxQGujqvAFJEm2k9cFMRXDpaAk1O/sVx7EO4p4+2IzVwMJpgjTO8PZ+mjS8OgfWYPOmke4r6N2+aQyw3FQgkCsPUCqtDJIfxmJdBDZWvdUm1EHlxqvLf4hzmEea225/aP7q2NHSZBhgS/YHJ1uVujdiw3N5XyM1Mzj+qPBj42aEgymieFgLoaf90WKidagyv/QVZV3f75YGAFE0IrH1k3SkboSLKS1fU1yeQIHA/3sV1/SR1sOgatag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8MvZdK+qdZqZIKPUdjQfdkkRmaIgYp+7AcEJW/95dM=;
 b=xnH4mQxqWZbgd+EkxXHwS301tQTONtuHr0+YnAmtQF/+w+1lNVctnA8BwGfqzr/6gN2kUwQzZRI8cLwmVwtbgxuj35iZf73xYCBXX42HIoqzhy4lMK4JchKOlhO/lsRhc13ScUVSrAgXyhRpyFdoJTrvJQbqvNUgL4+ZrMBlWck=
Received: from CH0PR03CA0401.namprd03.prod.outlook.com (2603:10b6:610:11b::35)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 22:48:49 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::b6) by CH0PR03CA0401.outlook.office365.com
 (2603:10b6:610:11b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Fri, 20 Oct 2023 22:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 22:48:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 17:48:48 -0500
Date:   Fri, 20 Oct 2023 17:48:32 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <thomas.lendacky@amd.com>,
        <dhaval.giani@amd.com>, <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update AMD CRYPTOGRAPHIC COPROCESSOR (CCP)
 DRIVER - SEV SUPPORT
Message-ID: <20231020224832.d25md4zv3lw6lble@amd.com>
References: <20231020212234.458371-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231020212234.458371-1-Ashish.Kalra@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aecff5e-d3f0-4c73-4b3a-08dbd1beb9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTfbuXTIREFa103Y1uqkK81+siVSOqsKqdziS3lXa/3UyD7S+NchMf/dyI3639IsIH/C3uaikI10jhobF98szgCFLdp5GqHWOwDN5IGyqLQeEgT6KyS3a0G1KuN15VLPy5Biyx7f61C3hg5XwL+lZUe/LPyM7WHMPTABp48Nug7erekVc/ZLCkM6bd19j7M1I2ONvLy/NI1D3CPfuR0VRzRjW1PnPG1NZ5x0KnXCDJg34sZ+JwK446g/XX1KM/5IEO8Un2ao7kkRMcaizSda2ss4RC+TS5B0wddB97QGKZweRZNOadOKfdbVp+Rla6FikVIBZuVLWVlLmzb9s5/1u0zzJgM7860zAuuUuTwZOQEAHamXTHJMvhOpNcpbzSCYU8YfazjJmSlce2E0D9W2lVgEcEn2rm185wG5iCFRsKkX/SpOZlmeAhb6iOCW8l4iHYDpyzW2hFSGf0BxmBkFrP7bugVhiw5OHFyiZwQTcm8ZW09q+DKteN4gek/aTT+pv1cqGbd1bHMlB6oVWTUNVHRtuYhhjOMwoIKkJN036lOT0S409T5ytosJ2HHfqVfPQdfvAUGooFyZZxA2XjmkHiOK53wD9X4BHTj2KjmdAEPA4ZsJLUF2+m5rDmUVnvyqBivoynh4K0zuQC7AsMUA3Nx4TBE4ndINjCwHzN3fm/yAnTR/N8obcqfbm+OVHm5bwyTMwQaK7iYld+uKRJH1ZXr5wsHLaMVtJTJ5D/CWqBPiT0Si3yI25dYa9raN4RnGKhHUXRe9uLjiW0hUtV7dFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(36756003)(40460700003)(316002)(37006003)(6636002)(450100002)(86362001)(81166007)(70586007)(6666004)(356005)(36860700001)(1076003)(70206006)(336012)(16526019)(83380400001)(426003)(8936002)(2616005)(26005)(47076005)(4744005)(82740400003)(54906003)(2906002)(41300700001)(5660300002)(6862004)(4326008)(8676002)(478600001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:48:49.1212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aecff5e-d3f0-4c73-4b3a-08dbd1beb9aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 09:22:34PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Brijesh is no longer with AMD.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a7bd8bd80e9..a7c64d36911e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -907,7 +907,7 @@ F:	drivers/crypto/ccp/
>  F:	include/linux/ccp.h
>  
>  AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SEV SUPPORT
> -M:	Brijesh Singh <brijesh.singh@amd.com>
> +M:	Ashish Kalra <ashish.kalra@amd.com>
>  M:	Tom Lendacky <thomas.lendacky@amd.com>
>  L:	linux-crypto@vger.kernel.org
>  S:	Supported
> -- 
> 2.25.1
> 
