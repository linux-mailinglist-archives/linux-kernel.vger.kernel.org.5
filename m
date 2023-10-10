Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E747C0249
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjJJRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjJJRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:10:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385E93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alFYKXHqOYWJF+hJxpUG3eUY2zg1fHtcLbxwgw0oFCI69WPHGDQOABFGCIVpdCYdKs4JWEkShdvR7xQt9j/XEwOd/FR4rQenrGurqIRg3JlwgF98HDDkaKLhd4yohahJD7iVZxfdqV+1SuabO9SnppImkh+e50IWz2dOI244a4ui6keTBvz4nm6wzy045DLtn8y0F7mAyGhHkLaIbL36aCKRQmhA8XNBLgGgGty8ToapeajYBt01bJR+VjosQXg1XE4GWvhIl03kXqOozXEKYXGyOIUpP3jpckX6o9ikOuQXn3fwlpdDuE53UBahMufbsZM/5ekWMR60Pb22TSDWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmA80Kq8Jep8a2wzpVByxBU8cjuId1FR8aluBbrKJLo=;
 b=kxWZ+NJoQLTtWuGmCnUsuaSvztZF25Bn/rYUG+cibDq+dKrkYP1pZV3x/tbRAwbY6BhUA8bkKV/HxCgaeCxB9P5R6+nHn8b/1bOCczz0/TtGD3rD6c0x5dwEFtM5G3CbP7oa2b70yyBcIH1P1MtPjYPkGlDcvoXeF8kDBf5hd61/WloXGAJvzzjsu3MMHPFVlXXK7wOuNay7m2uDTuPFFxT+D4fLCWxwDxVkZusdSmU8LqRYZM9qTzLT8e/T12za+Vlzrhdig2ude14DehWuozKt/3xBxkdXLqVEyGC0tMhuceReBN84a3o4sE8tPlpyRuYIrD7X+rRvL4zKe2FxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmA80Kq8Jep8a2wzpVByxBU8cjuId1FR8aluBbrKJLo=;
 b=sLoTLry3iIp+stEkhJQd8h3LNE/8EePHZ5ogO1mHYToUm5kzIKGl3lWjSW9Ed1MYM9tifymwgGbxjQ64AgRC02GcZMOzjCYz7bzw3QBevuuxapkbe8jvge1d94QcYIxDFZdy6De7eN+0w/sVagBz5eNPjC9Iu5JZPEksoM4l0d0=
Received: from MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::11)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 17:10:37 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::92) by MW4P220CA0006.outlook.office365.com
 (2603:10b6:303:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 17:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.6 via Frontend Transport; Tue, 10 Oct 2023 17:10:37 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 12:10:36 -0500
From:   David Kaplan <david.kaplan@amd.com>
To:     <x86@kernel.org>, <luto@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Ensure default return thunk isn't used at runtime
Date:   Tue, 10 Oct 2023 12:10:17 -0500
Message-ID: <20231010171020.462211-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb040e9-169c-445f-f677-08dbc9b3d2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zeSR2jAhpfFAQdQs6pztdVWuFFj2hJ/ohqGQsOn8Me6Z0SrM3jWOKEB0TfBrlmqoZkmgddIrHKo30k5MD8zJo0TBhMclwK5+pY5ywpTscNt9FNrYhN0+VmN3neb6OoqErM1a3LL6oIExXLzzWIB4X+bibxyRLJNLyiABrnfMcIJ3O+yksBPYZeQzJeZqkDfVarFdxD87vl9pJTVUCQ1XfOLw3Um8/t4Pjzej7X8E6V7FFJQjhK8bgDHpJeHt/jN2KoX8JDOJpvQqxZwzCVl3s2F/oYTdKbUffSV4qMfSVyxucsHg5yU8lo18+ER9s8tDDrMi1hfm7Y4KPvp5LDnE1rNLAYsJK2sMEBAk4bAwYYei3JtQ5ddnDgOhYRDiwgGPoMbthR8UngQTBw15zEB/zGhIYtAFF8fzT4+sf1EPtTe9cr07jz2/7R2UVeRA+Lt9oG21nJ0tptSuJ8k8g36IuH8hPrWz8iv5UU2i2C02K1RuYVoZ4BcGbByKO2yKuH6GCtA//K0FcacVAMIU1NavBcJH1/8L2Mc754IHoplUOPwOTDaEhESA3ASfY1ZneRSdvKw/KD+WXR8LnQEssalSAW0yLM2nY9s7GBZipDYKbQswfiCDCSKhjmAllNIenvQTpf5jT+Xtk/HqSeQrxuhm6i2jJujV4lreDdy12PsfIybr26q6XBwPj0ZH+ogF9YC6USJSktbm7eCn4wHgp++14KE3NZYWkCDOv5Mx1TaCGS8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(316002)(70206006)(110136005)(44832011)(5660300002)(41300700001)(8676002)(8936002)(4326008)(70586007)(40460700003)(36860700001)(7696005)(1076003)(2616005)(86362001)(83380400001)(81166007)(40480700001)(2906002)(356005)(82740400003)(6666004)(36756003)(426003)(336012)(16526019)(26005)(478600001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 17:10:37.3271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb040e9-169c-445f-f677-08dbc9b3d2c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several CPU side-channel mitigations require the use of a special return thunk.
The necessary return thunk is installed at runtime via apply_returns(), after
which point the default return thunk (__x86_return_thunk) should never be used.

Patch 3 enforces this by modifying __x86_return_thunk to be a ud2 after
alternatives are applied.  

Patch 1 reverts a recent commit which resulted in retpoline sequences not being
annotated as containing returns, which was leaving them using the default return
thunk.

Patch 2 fixes an issue where functions in vdso32-setup were using the default
return thunk because objtool was not being run on them in some cases.

David Kaplan (3):
  Revert "x86/retpoline: Remove .text..__x86.return_thunk section"
  x86/vdso: Run objtool on vdso32-setup
  x86/retpoline: Ensure default return thunk isn't used at runtime

 arch/x86/entry/vdso/Makefile  |  3 ++-
 arch/x86/kernel/vmlinux.lds.S |  3 +++
 arch/x86/lib/retpoline.S      | 10 +++++++---
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.25.1

