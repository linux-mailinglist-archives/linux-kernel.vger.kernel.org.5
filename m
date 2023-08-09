Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9718A77650D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjHIQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHIQaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:30:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9415D1724
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WInzNzYes+FRpR4f0TOEmVSyuWaiqGiWRSATbBrRoYkYjHB/kGXMQQ5pIzg1E0hNMoIpJ5zQGQx5CEjZ/PTO2h6l6HLxdXi/rob3qyrSlPS3uZWZ+3pcJzL+lPMNol7Tr2eIRPfI0WuHBJQahmAd6uLmDNK40tyly+hg2GA+M20yXADW9U5IPblVbT0NnwWldIdSv2MYd+hk/qvhtvlu/fDPfI6nS2tD3AbYJqmNFdusNjwxaqOLc6LJaMeteBJsa/P+OsdtX40I63XbvvGSdFvqDvB1UXTflLMW+ErLx2M98lvRVy7qfObCZuhxqC4IKnE0S9o5HY45BjXANdhoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8w1SO1vgcu31aHtSnqlfFd0Pi/9HQkaqsZ7UbTl6Ag=;
 b=Xsf4gGr84FxKudAJ6pikUJKKRIanBnMrLvqBtkxuOd37DJJ6jq0IByJiWt7O4+IzDTtm7PGcW8qr1CY3Cls55yuo59cmIAzZvOh86KlroGUfZXvbG/C5qdw/Bpq1jq50U4nPi2RX5N3TDU38mMUhsyJNGOLuC04DpfyojkIRO/s+x7uzFFxVWT2VUNZgEntjR2MC+p7rom8TdOrl+aaDt2Hc/K0QazVNpF+dEGbrHa869zOsPECsHhujIUXi5hjdfrOx2EWhbYaA4rxThjDqDTrtfAEkxFzdbAYb2OAzntG2sBMRrLgVPtIpRvjfdh0o34lBn6v9cecNrsLdrlFxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8w1SO1vgcu31aHtSnqlfFd0Pi/9HQkaqsZ7UbTl6Ag=;
 b=JT2zC31pHMB4LDRpviEF7QYxFUn/2+Bw82x+tvJNeNyaK6Evn5xeLI158aNFomHSNj+14/ymya6g4F1klo8KhCjmICauuuIythwCU181mGA5r5qK1cWWyEAi2KjswIxAo6gaQFr+k7bDOz6G/JePjH86qB3YGwb6fCk7Ie0QmuE5uL45uHDsLxLyFdNHaexQ6dMqNzD58bYvApxYW6ETqCbdj4hp8ZD6Si5cuTR+t69E/axGSbKm4tdRqjOoiGLywXXFCsoSm8+ShSc1+xlw7I0mkIs68LNk0FMt2gVrZcqPe7j6ZHUHmCyvCXCPdNkrFcQgkb3wmP2lxLdh6QDYOg==
Received: from SA1P222CA0149.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::26)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 16:29:14 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::e8) by SA1P222CA0149.outlook.office365.com
 (2603:10b6:806:3c2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 16:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 16:29:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 09:29:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 9 Aug 2023
 09:29:00 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 9 Aug
 2023 09:29:00 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <markgross@kernel.org>, <vadimp@nvidia.com>, <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v2 0/2] mlxbf-bootctl: Support access to the large icm size and setting the BlueField boot state.
Date:   Wed, 9 Aug 2023 12:28:55 -0400
Message-ID: <20230809162857.21243-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 5baa4a56-8441-4b1b-5ee4-08db98f5c4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCiGmQRPSnm18POdDH8OZ/pu1GAJNymzfY5MC3aqE1rR+bNiwr3tNSg/PxMdVDxHYx8llgRUiMZXuZhE/2hf6gkKDDJ52RUaeUaeXG9sSbdANDtEkwwXEZwJDXOSengyy79hsO+a3i31RWpkZKWr6YmS7weHF9UZ2p5bVES4wDBFWaBlS8vcCEn8B9zNAvJ932VIVcon2vsgvNB0FJhpvGXj2sAqfe7vXbE461Wk4d6GxlNQTH3zmCiKgV1soZ67Vj8ZmUBquRUuK7rZQSoMiH/IFj60Cp+gSHZ/fI/BXJ/AfNSPaH0IKIgf9Hr+wwoe690XIloRh9JceTmFL1MrFubAhiwmi2xj594O5cD7c7JmYQuv4WbCQGk8hekaH+oK454tCYwqFoOS/lck73+oZJhQd0+saFROUCix4PbiG4yYRwMyHaJhWHVlS3chCCEiZGkGnmZsamRJkxEXhx6R7R9YbE5if+O2TZpgoLaLZNd7hVFsJnLfgjxOk4/0ZAWq9UdsoJqx20nsQloDoNgiwoCn4vRxW1yHKu5bYP4r1o++sfWgj/sn+4NPhbDp6g1dtkifXg0Bf5lJBk42rjU3zf4jZt5J4V6yWyMCO4wgf/5Q8ikVsDsDP8v0WNodICMmFA0jMG7uyAj7+FDUYdrnbYvoOQfcjU8T2Y/H/HXfFHy6h+KinPhUALAZULmRy3z9sDx7CaHn3YUacj3F8iR/BdbS0xjvoeTF0XsitxyCdQOkUENq0EQema+rxGaGodps
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(82310400008)(186006)(1800799006)(451199021)(36840700001)(40470700004)(46966006)(26005)(1076003)(36756003)(107886003)(2616005)(7696005)(336012)(6666004)(7636003)(478600001)(356005)(82740400003)(110136005)(70586007)(70206006)(4326008)(41300700001)(426003)(316002)(8676002)(8936002)(5660300002)(40460700003)(4744005)(2906002)(36860700001)(47076005)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 16:29:14.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baa4a56-8441-4b1b-5ee4-08db98f5c4fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support 2 new features for the mlxbf-bootctl driver:
1) Enable reading and writing the size of the memory region
   dedicated to the large ICM carveout.
2) Enable setting the BlueField ARM boot state to "os up".
   The SMC call involved will handle updating the state in
   BlueField registers.

Asmaa Mnebhi (2):
  mlxbf-bootctl: Support the large icmc write/read
  mlxbf-bootctl: Support setting the ARM boot state to "OS up"

 drivers/platform/mellanox/mlxbf-bootctl.c | 67 +++++++++++++++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h | 19 +++++++
 2 files changed, 86 insertions(+)

-- 
2.30.1

