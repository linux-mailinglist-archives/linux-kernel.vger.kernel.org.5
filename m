Return-Path: <linux-kernel+bounces-19456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A2A826D2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4061F22940
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5C62575B;
	Mon,  8 Jan 2024 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aUgv7FUE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54722EF1;
	Mon,  8 Jan 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxYdpRT0BUXPY5Xr7UhskROxwJE5+leVYEM92JZd7zUF8Bb4ue1B0PDtGtsyrrwjtY5coVV4Xt6cKeOHmWNK9EEVwQPPlGyz6N0eg7nwiFu7cTJpVRuFrtQRN/6hxgOg/chrnicISxaKEwkO1Zl1lq2/pPFKmly9DzY5w3eAIJvdeNyQ962fwOSe/wDh+B8dzAWx9650xmbHeumvx2wzrirGZB6KHD1Dxv+lKd2b2PmSnH5Sel7lBXRrS9W/VxMyvgFhvM6NoN0dra4rgZQCoSfzFF61qV+m2nR4ZhpSF/fGSYWbV0DmrfB5iAdKuww7rgeAZ8x8gelvHWm/LKU4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9GJUTx4FVwx/+DkcJ4CAYVAFGXTw4AsaHw//qzGr0M=;
 b=SqEPrOUeSKRYBQyOr8FoCPmrINIDiheJbe+mX5po4te+Q5YTdHXdqcdvyhGI3DAKGZESiLBWkQvroovytq/LaO7gAcZnksWgVdJ+0iAaVebbmMiycKq9oGbiYXnd6N4TdUXoq9Gwk34tBwn1n4WpyMuXb9qOWQC3jRs9dduROqsn9QHs8j0oCbOrnYGIg2hbIkyrmEekJ1KNoX4zhkS4sbGSzTLVPmValiJHmMSIttj5cpwbLJsDW/SSlLV4Lx5UfBena/Wuzzmm67HPRbf0B/FmowE7m61lBd5tb4a2t2r7tHuUhm3FtEY/RzcgolD3XCNZxiFJyle8GeYCdbW77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9GJUTx4FVwx/+DkcJ4CAYVAFGXTw4AsaHw//qzGr0M=;
 b=aUgv7FUEvccwIJLZOwXmB93Lug4m68QCnUh+bCuJk2lzz6jIWwdgYpgFr0C33FOko0R7dl2LHd6t4Uhll2k2vVAm4yRRmtYpJmwDib6MV53sGLCVwBW0MSopIiz4bRBic6OuLOZmIVQrs6Les7vKnHjZbQR8n5SDSkcVo26SJp0=
Received: from PR0P264CA0086.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::26)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 11:49:14 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10a6:100:18:cafe::62) by PR0P264CA0086.outlook.office365.com
 (2603:10a6:100:18::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 11:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 11:49:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 05:49:10 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH v2 1/3] cxl/pci: Rename DOE mailbox handle to doe_mb
Date: Mon, 8 Jan 2024 12:48:31 +0100
Message-ID: <20240108114833.241710-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108114833.241710-1-rrichter@amd.com>
References: <20240108114833.241710-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: c0640794-43b2-4e22-e657-08dc103fd5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FwIcroLWKO01xnsbCHlY9VUDxR7RU55qfSN0edlToGUg0TtxUw50EnT9pF5yAKweZYG2Gj315dtQanJv5CsfIW4z+HbZXzv7KHWT2CYH6zrpSTDip2upTtGfTerrShxp5fyRUY4/789S1vMN0hs6jFhe4MXpseXJ1QdvtPlkhM1RPRnUdZBVCvzixkUpIJuFembWVaO9TiLT35lyF7vT3LOy8xIRi6I3bQQXvkfni+RcpKjxKAep82GHCZm/2Y0VV2HJKL/AVCNT3TVgvwi3RrV7g5SoebfwrwzvpGE/RUpEtaf2poAtGAXKZ/knk+UB5Hsj89ThfaAAAQfC/CAElm9f01fhgPU8CY+WtmJZBoxNKv772Q1vZLTktX8pc/wciqgGXwQwGJZ+xStSF5PkYAOrJpzKrY6qJmHPaauvNvnil0keXkiM0AnEVlZBZmGNtFZI0xUkP+FI6xvrsAnOK4lccT0Quono1aGe/1orNzAx51JZySkUTuvLmUXYZ3PETqzac3P0/Stoq/UCB9GWvBDsCbOalZDtdjlzetzL5zoC0nBrjBdJV1j3vNoD7t31dt246F6oLGt+qqMkLBo1g9BZy7zyZKAEoyLDvoHWDEiJYVXz/TY+R++2YKfzOM4N/TxYM5nXWvnUvKWtuzjixgpr7dAl7TCPyra1CfMbEPutmNQc6Btp9dwKfC3kIi8/vHGdaGPPfCg4LQtE+bSwodnzDbFnwrH/xpnUwIf7hEU+VQKvvnVQ3L3Galk01qbacnCeutNIHxXJ2zsB8tWywg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(7416002)(15650500001)(5660300002)(82740400003)(81166007)(41300700001)(356005)(336012)(16526019)(36860700001)(316002)(54906003)(110136005)(426003)(36756003)(8676002)(47076005)(8936002)(2616005)(40460700003)(70206006)(70586007)(40480700001)(26005)(1076003)(478600001)(83380400001)(6666004)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:49:13.7355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0640794-43b2-4e22-e657-08dc103fd5ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

Trivial variable rename for the DOE mailbox handle from cdat_doe to
doe_mb. The variable name cdat_doe is too ambiguous, use doe_mb that
is commonly used for the mailbox.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6c9c8d92f8f7..89bab00bb291 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -518,14 +518,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
 	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
 
 static int cxl_cdat_get_length(struct device *dev,
-			       struct pci_doe_mb *cdat_doe,
+			       struct pci_doe_mb *doe_mb,
 			       size_t *length)
 {
 	__le32 request = CDAT_DOE_REQ(0);
 	__le32 response[2];
 	int rc;
 
-	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
+	rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
 		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
 		     &request, sizeof(request),
 		     &response, sizeof(response));
@@ -543,7 +543,7 @@ static int cxl_cdat_get_length(struct device *dev,
 }
 
 static int cxl_cdat_read_table(struct device *dev,
-			       struct pci_doe_mb *cdat_doe,
+			       struct pci_doe_mb *doe_mb,
 			       void *cdat_table, size_t *cdat_length)
 {
 	size_t length = *cdat_length + sizeof(__le32);
@@ -557,7 +557,7 @@ static int cxl_cdat_read_table(struct device *dev,
 		size_t entry_dw;
 		int rc;
 
-		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
+		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
 			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
 			     &request, sizeof(request),
 			     data, length);
@@ -617,7 +617,7 @@ void read_cdat_data(struct cxl_port *port)
 {
 	struct device *uport = port->uport_dev;
 	struct device *dev = &port->dev;
-	struct pci_doe_mb *cdat_doe;
+	struct pci_doe_mb *doe_mb;
 	struct pci_dev *pdev = NULL;
 	struct cxl_memdev *cxlmd;
 	size_t cdat_length;
@@ -638,16 +638,16 @@ void read_cdat_data(struct cxl_port *port)
 	if (!pdev)
 		return;
 
-	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
-					CXL_DOE_PROTOCOL_TABLE_ACCESS);
-	if (!cdat_doe) {
+	doe_mb = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
+	if (!doe_mb) {
 		dev_dbg(dev, "No CDAT mailbox\n");
 		return;
 	}
 
 	port->cdat_available = true;
 
-	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
+	if (cxl_cdat_get_length(dev, doe_mb, &cdat_length)) {
 		dev_dbg(dev, "No CDAT length\n");
 		return;
 	}
@@ -656,7 +656,7 @@ void read_cdat_data(struct cxl_port *port)
 	if (!cdat_buf)
 		return;
 
-	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
+	rc = cxl_cdat_read_table(dev, doe_mb, cdat_buf, &cdat_length);
 	if (rc)
 		goto err;
 
-- 
2.39.2


