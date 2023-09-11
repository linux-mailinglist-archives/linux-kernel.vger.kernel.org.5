Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646A879B009
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbjIKW0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbjIKKFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:05:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2149E69
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXW0lS/4L7NDmIAuOQeIiK49c2spV9NPWO7A9puxvWKldp8O/XS5eBJAqdabL2dTVgNsopXFQJkgosKiTMkvjAM+wo23k5JK7S6fR36darckSpIFvXAwTQTgtTZCWGYlxhEckZuSlIiGi7OgBc2mv2/IVaMjAtqwrIvUbdlM61fVkes6p5qcwaZ+GGjciy7jVjCcrHH4E2YkN1po2Qc4e6rbpDFmRXG0759ENKohQ6wwO1YF0N8ZAf3CSyS4QyxJKfuODFJ4+QcWHrdOpJh+phgG20Wu0oV7jBnrvpIaIYWtYXpB9sRTJwTTYgoSHak4l1EqT+LqwB3WvCTdxPqR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRtNism9eieq55WiXAgXLdUcKsXmXh8icFK+EOB15YY=;
 b=TG4arZIclyHDMFCNYu3orSkn/wlnrC+vZ66k9y7emnnLvayKDD92fiA81r1ZFYbUWm+TMIi4UdjSfG4rKNum+O4aFmJ/KqJKEVYT0eTa52FxPZmsXb08VRENjzDpxMkLJwN57ltifGNnjFYPR8N3rhMAjT94AyofGv0h8Y3VeC8xW1Hzax4eXI5w9av5JczANI+kFgPvZJreYkFGbXILYUZ4VcWh+yPdPbg+PhFm6CodPf491UeZ05AKttvYuui79nIXWAv7oZ8C0K7nFQYc3wuQ9ygwi2XaxkHUoFDCFeFhjG5oWmsBPAuYu8ctZYO+FLt159VSR5E0eGELj5OpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRtNism9eieq55WiXAgXLdUcKsXmXh8icFK+EOB15YY=;
 b=UDLQ3H9zdYktwPzPpKhtfrKmT8sN2HuIDTEV/A/VbmMBiWtXD57OCwyo6IBrFW9k+RX8CT7feXnAJcmG2lYugMHCDJ0Dg3bZKHJ3rb2cHxYgcQpx5ACFzecVzSwh74Ew582cnwbnvkLqlPXy0l3azAL0kMvlQKXHRLVhspf6e3w=
Received: from CY5PR15CA0049.namprd15.prod.outlook.com (2603:10b6:930:1b::17)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 10:05:17 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::96) by CY5PR15CA0049.outlook.office365.com
 (2603:10b6:930:1b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.41 via Frontend
 Transport; Mon, 11 Sep 2023 10:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 10:05:17 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 05:05:12 -0500
From:   Jiqian Chen <Jiqian.Chen@amd.com>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        <virtio-comment@lists.oasis-open.org>,
        <virtio-dev@lists.oasis-open.org>
CC:     <qemu-devel@nongnu.org>, <linux-kernel@vger.kernel.org>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        "Christian Koenig" <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>,
        Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RESEND VIRTIO GPU PATCH v3 1/1] virtio-gpu: Add new feature flag VIRTIO_GPU_F_FREEZE_S3
Date:   Mon, 11 Sep 2023 18:04:30 +0800
Message-ID: <20230911100430.1408168-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911100430.1408168-1-Jiqian.Chen@amd.com>
References: <20230911100430.1408168-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3d4206-778a-432c-50a8-08dbb2ae9986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5dsaDV8AYpfBAvoP/plHZZTCQqGHUb1NlXcMvkOGuxw+kzLuaM2qzO5B5Qw6fjB17q44sTh8vPWjEPds89g6WS8I1IpCwTd8LjZ8OP6BmpA0Azc8EhVjBg1sJBcfTL54PPzfJTuk2/pDVsV/LZhmgELj14V9MdID+L/Q26NtvjA6rvPzvJcE0nfJ1JtvtlLONZ7UnmMDf8abwqijSRwjM4NsjnvbcPFqYBNJEpWkwtIO5dgGKsCg4xM/XCwQsb6U3cJ5ah4ZZSyIOoZaK4t+wi1Ivpo3hEEDRxxV9JKOeXKUxzRjQG8b4VaC6PnxAFnSP1gOcDzxUxpPXH2OLg2415K0vqqz2t1fIwqNTl/7fafpWeufEmbYvNcMAwjt9FTupquYGVeSFZkR6TdqXUbWEzzzIhi/z9kPNcyxnfAW1A8fDfJ4OI+JXV1PDPqS7hOWkcN0JdK84Z3i+A17zTk3phk6Fx6Uvt5eiY8P+ZwKQe2+KxJYegJPcGWkovXH2uhA8pRphI3xcX5xEJst2j13PhQ8ENXGtsVqhSXHfAIOWShaAPD78IoyDXPNzKA47BrJfre3P+ScE5h9dRuNX+mo463IgmRbedtJBZEng3wlgDk613KwBnp3XCsDTvdKe/lHQOv8gU6SX5zvkCJs3qYyZPKkRZgZz5HeGpWHj2tec0SkmBEeY0Tzck40zyX55IEAzD1/hEOVBfawqGH98tdNEzyFnYwZ0x10jYi5SJzWfdmUvBsfQ6axlBdb3hLOECqqz41sqYCZvbTktLP+WLdWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(41300700001)(40480700001)(36756003)(4326008)(8676002)(8936002)(40460700003)(5660300002)(26005)(16526019)(1076003)(70586007)(70206006)(110136005)(54906003)(316002)(86362001)(356005)(82740400003)(81166007)(36860700001)(47076005)(2906002)(426003)(336012)(478600001)(2616005)(83380400001)(7696005)(6666004)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:05:17.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3d4206-778a-432c-50a8-08dbb2ae9986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we suspend/resume guest on Xen, the display can't come back.
This is because when guest suspended, it called into Qemu. Then
Qemu destroyed all resources which is used for display. So that
guest's display can't come back to the time when it was suspended.

To solve above problem, I added a new mechanism that when guest is
suspending, it will notify Qemu, and then Qemu will not destroy
resourcesi which are created by using commands
VIRTIO_GPU_CMD_RESOURCE_CREATE_*.

Due to that mechanism needs cooperation between guest and host,
I need to add a new feature flag, so that guest and host can
negotiate whenever freeze_S3 is supported or not.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 device-types/gpu/description.tex | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/device-types/gpu/description.tex b/device-types/gpu/description.tex
index 4435248..1a137e7 100644
--- a/device-types/gpu/description.tex
+++ b/device-types/gpu/description.tex
@@ -37,6 +37,8 @@ \subsection{Feature bits}\label{sec:Device Types / GPU Device / Feature bits}
   resources is supported.
 \item[VIRTIO_GPU_F_CONTEXT_INIT (4)] multiple context types and
   synchronization timelines supported.  Requires VIRTIO_GPU_F_VIRGL.
+\item[VIRTIO_GPU_F_FREEZE_S3 (5)] freezing virtio-gpu and keeping resources
+  alive is supported.
 \end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / GPU Device / Device configuration layout}
@@ -228,6 +230,9 @@ \subsubsection{Device Operation: Request header}\label{sec:Device Types / GPU De
         VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
         VIRTIO_GPU_CMD_MOVE_CURSOR,
 
+        /* freeze mode */
+        VIRTIO_GPU_CMD_SET_FREEZE_MODE = 0x0400,
+
         /* success responses */
         VIRTIO_GPU_RESP_OK_NODATA = 0x1100,
         VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
@@ -838,6 +843,43 @@ \subsubsection{Device Operation: cursorq}\label{sec:Device Types / GPU Device /
 
 \end{description}
 
+\subsubsection{Device Operation: freeze_mode}\label{sec:Device Types / GPU Device / Device Operation / Device Operation: freeze_mode}
+
+\begin{lstlisting}
+typedef enum {
+  VIRTIO_GPU_FREEZE_MODE_UNFREEZE = 0,
+  VIRTIO_GPU_FREEZE_MODE_FREEZE_S3 = 3,
+} virtio_gpu_freeze_mode_t;
+
+struct virtio_gpu_set_freeze_mode {
+  struct virtio_gpu_ctrl_hdr hdr;
+  virtio_gpu_freeze_mode_t freeze_mode;
+};
+\end{lstlisting}
+
+\begin{description}
+
+\item[VIRTIO_GPU_CMD_SET_FREEZE_MODE]
+Notify freeze mode through controlq.
+Request data is \field{struct virtio_gpu_set_freeze_mode}.
+Response type is VIRTIO_GPU_RESP_OK_NODATA.
+
+This is added for S3 function in guest with virtio-gpu. When guest does
+S3, let it notify QEMU that virtio-gpu is in what freeze mode in
+\field{freeze_mode}. VIRTIO_GPU_FREEZE_MODE_FREEZE_S3 means guest is
+doing S3 and virtio-gpu will be freezed, VIRTIO_GPU_FREEZE_MODE_UNFREEZE
+means virtio-gpu can be used as usual. When virtio-gpu is freezed, QEMU
+will not destroy resources which are created by using commands
+VIRTIO_GPU_CMD_RESOURCE_CREATE_*, so that guest can use those resources
+to resume display.
+
+Note: this change is not enough to solve the problems of S4 function.
+QEMU may lose resources after hibernation. It needs more research and
+development. If S4 is supported in the future, it may need another
+feature flag here.
+
+\end{description}
+
 \subsection{VGA Compatibility}\label{sec:Device Types / GPU Device / VGA Compatibility}
 
 Applies to Virtio Over PCI only.  The GPU device can come with and
-- 
2.34.1

