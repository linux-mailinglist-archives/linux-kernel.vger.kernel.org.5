Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9072677622B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjHIOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjHIOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:15:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD121FCC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQyb2kZsL5kTz0BsRWxuYrEcwuyRIbiQO7h2U8DeGf4zDcJMKNPhKawsaEv88oKYxpGO2nehHTYLJ72o7yiiyPWFQ7r/W+/tv6VbfvdN59s1EfTMt8jWB43UT1Ezp8M3taTmJR347sMKd7jCSxlIFQOK2AzfAZ6Bpd6WideAFGyxKWwKy11cNxBd24Hnr6l5/B+RrgGVlQJ/LD5tGPhsB5DBU8wcLPYEdZwu7Eg1syFPV6rEBSAfUBAwBCGTXgWAMAjZr8Os4Os6kPY7qhF3o01YRLE8yEXhwSjNncKfmlsHkgW7DV6avgYeWthve0MmPdUS/yr8oJpGZ8KggHzq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o/WIemvx6z7dehgwkVYCoB59HoOrhQdpnmkd7BdiHI=;
 b=fF3gycRK8mOdEuKK8Ytj3+YVLnWO0iFhYFv6U/fKYYJrIWGBVmHDwjH18dQ0Y/e23KfRMpCJDCExjbJXhrzEl1zyZ0RoHvKA6cBAGfI3ft02jlQoNFmVShsrhZB4GQA2IQSAPhOsWY6eUux2wzfUPfzgTL/2rnQabkPGLolAckoatwWmROxsIwKqm2gYaqGbB/1bplGU5/wXsKYHomgI0wwjjDlxW1wKs2ElGsq0QGSGlbaZZQfg4j5Dg2/8Mmv2a2G0FGJaMYqSXHAIqPf/n7HvXoQ4N7vbS7WoeBHhYuUmvuyhsDJOpLZ/TRYIV4w66nF1YMazsxdJBaYU+/kX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o/WIemvx6z7dehgwkVYCoB59HoOrhQdpnmkd7BdiHI=;
 b=tQzqtVLbGKhv2nuAMF3C7bXjQcWBlKXNcvU5AU2xXOS1KbjaIU202Z5z7OZ/UyZ/Jpq7ml3A2C6e0zj7f4bb6cE7XRHzpDaFRdV4atgjTX6KB7NkF3alfeMDdDf9l0oPQr86VbWc/dh1DSJ1v7l8I9FPtXNAthxuOC0CbaZmoIYKs6cJ4xz9Wf/qkVgdbKoVcevARs7wIkGU8paeIV9Hr+lpdpHwqbPZKtDf5dMIQbg5p+pU+6UF6V1eielpdONLbm3aTeM8JRyGOm+fG92E9H7+YAXbsqdZ4h/VnBvcdhew7Y4HQtt28xZoWHQCTag9DjS0OodW/2xFjSfWZO7SRw==
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 14:15:28 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::76) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 14:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 14:15:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 07:15:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 9 Aug 2023 07:15:16 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 9 Aug 2023 07:15:16 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <markgross@kernel.org>, <vadimp@nvidia.com>, <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 0/2] mlxbf-bootctl: Support access to the large icm size and setting the BlueField boot state.
Date:   Wed, 9 Aug 2023 10:15:11 -0400
Message-ID: <20230809141513.9058-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ba91e4-0ba6-483f-323c-08db98e314d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: es85VfRzBFQiRDJSL8vaqkioxYiGCtftlowBq7WKBzpF4HWRRlDgiIk79ICc2av4s8GbFvr+zXbbcHZjsDEPNFl6fl8fagLWjR9crmqdF5ygLzO9LCXu2ibAE2eP3PoGS7EGK7QO6Z4Tbmv3yHWOIyBgvN+Hj3KEmP4z2m4AEr7ZHM6GkS//BGR8LzMaX/H3n7/0Lhbqn0R0IkpA3dqbV7Mqj+bBDja8vg9T6MrDHe02Ii68QfcUNVXHG5VgSIG8bVFbeuzAUsb5cst6pl7bTe+xAcLbYVXjZREDr20Y6OBxmP/mJXJs4xyzdFc8fb5DFHhNEhj/i97fWYmHfJibwjydmzf++BMjzv9RhEyZQ9tkAIKscVZ2/B24tpECYamoqvXxLCHru3GHsFfsTyTzfESOOK/h2OGWN4nTrNrfLb66VQeyhOdBBfQWa8B4AWPMJt/rNKxzOD5mAJC2KNUcETJKotHNQPhHJccMD6MGXvLyIkAPn39mc1TiDnI/4TmCoGJj7WULP1v/FX3C7J0Ayu2vfwnTEx7YDrRjT/y7ojNEdPCev211Vyn06HVNce1ScUvz74xfzVOMCQrrjykhG8B3K8JnRUB58V5jmd1EmQ6rR6BY9GmqVwYqYsGv/5iogdk7HFrQlA5AgbvtwzbcOS6HGKON9L827m9XVHAGxK92tY8x1i421EL0SuxJQUZ6kN6RsbKuXot2RxZ3HVw9Z/wizUVahlwxbi3RfbDYrGDRyC7msEFH+jorRHt4yTvB
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(82310400008)(186006)(1800799006)(36840700001)(46966006)(40470700004)(36756003)(478600001)(6666004)(70586007)(70206006)(107886003)(26005)(1076003)(110136005)(336012)(7696005)(4326008)(4744005)(8936002)(2906002)(41300700001)(316002)(5660300002)(356005)(7636003)(82740400003)(86362001)(8676002)(47076005)(36860700001)(426003)(2616005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:15:27.6724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ba91e4-0ba6-483f-323c-08db98e314d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
 drivers/platform/mellanox/mlxbf-bootctl.h | 14 +++++
 2 files changed, 81 insertions(+)

-- 
2.30.1

