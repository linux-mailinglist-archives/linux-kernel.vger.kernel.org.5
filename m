Return-Path: <linux-kernel+bounces-68929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B63E858207
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5551C213E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183F433D3;
	Fri, 16 Feb 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lp+1pY08"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF412FB3E;
	Fri, 16 Feb 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099163; cv=fail; b=ZDS9rjMUz0HSzntjForhK/04sITOJO2EXO8GPJrVj6rbpv72h/AuTqfJ9JdOw49lahG2pm2RHyBVOWoN9TWEHUq31zomtsENtdSLTVh0pE9NI3J86FxgkoDND+1UtMSl0hSErfubJVaAL78BQ6IxoFReyr4UJnf9odrdQu16yMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099163; c=relaxed/simple;
	bh=vabspuEL3glJpUj2wBXXyg7L15V0VH8ASThtEw3OFJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azu2AotTTO4wyFAye0gSIqk4Skq/Pbqt7FJUah9lNIuzh4+T539LCf7rge+gW7vMZ0+pjl8gO8+N4hfZ0Qwayp/0emq3SHDQcpGqCDm8qnj/ObwRCpR18B6JzdyvyvPEPDWwEFaX+/QP0syhuBTuH3HXrH38gqiXE8pFynQafsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lp+1pY08; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1gkHbqKP0cB+uNc68jrQxB0DbpECDwSAlEf4+92NN93hvnsMhV/UpQ8SzH3D5qvIBu1Q9U/vi+aJSc/VUdZ+B7XdIElBXoVMeyQeTv3iH1j4WI7gkaKmIDVRu7iYrJzo+93sp4QTlyNWJ2z6XWD3Ep4yOHU9Ct943gjT/SzmP8gmOHvQOiy+NmjAKX1NcsZnYLPYdPTYt9iqqmh9syS4GvG0KYaXlmjrWFcSD66sHV+89q04S7CoT7NIZsVYxfC8ZmS1iL4AjjX4FpfPIrelvwHWbS0CkDtEJ3a9X2krmsrZT1zu1fL0jlAmFvzkh2/WAUVDazSWfFe1BErqrL32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjkT7qwFJH4bO2K9x9TLA863WqJzFzspzmSbN3NBWAQ=;
 b=KuKO9GLq4cpHORNf20wkVM810W2fydQFh9B1cjoLRgjfnHDYz9BhPs+hIZrnVRCcZdr9sL+PsbtySBe6tBudSY0UJGsa90ES6pvYb/7IutYz9pqKtNGOg07NvSoBQRTFBDgXMsactOLb/vqAyvpuCN8rYfMBGnv4RQXS7vPrNyk4V4UxTiWypEKxgfke6P0zMmV3iM5l/bdXsYOcXS5tCZbU/aI5cmy8RRHlXW8hGRfJmsqL4PMRcFh2HLpYvSFWqau5u9XT9J16TAVQlu7Zizo0cugSwFuLgCOwWGiN0ffKoA6QJdRoAPwbhopEZlZvuftHafkdEEtqYlDs6ynlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjkT7qwFJH4bO2K9x9TLA863WqJzFzspzmSbN3NBWAQ=;
 b=Lp+1pY08GQlmKd+JTUVYF8X84rYoGE6OL29bjitpOrarkpZdrQTwfpSaJyibE4e4IvQjCws4BlJ6wbuIVN8VIKsHld7CZF0+gn+Y7j4C4So7o7wYj4A5h1bu5aQEDJYKPlZeSuF8UIBH7RvKpt/OGMMEgP10KOkFnsOtVS2aM3w=
Received: from SN1PR12CA0095.namprd12.prod.outlook.com (2603:10b6:802:21::30)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 15:59:18 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::cb) by SN1PR12CA0095.outlook.office365.com
 (2603:10b6:802:21::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.43 via Frontend
 Transport; Fri, 16 Feb 2024 15:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:59:17 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:59:14 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH v4 1/3] cxl/pci: Rename DOE mailbox handle to doe_mb
Date: Fri, 16 Feb 2024 16:58:42 +0100
Message-ID: <20240216155844.406996-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216155844.406996-1-rrichter@amd.com>
References: <20240216155844.406996-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e18427-f216-46e4-e7a2-08dc2f083b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nijZ9rJgzdWRzKY7XHRXTsxfeOrH6jPTXaJyb36GGS7H4KdgibEtkZI7RCwsMHJS3WC3EHppfSCMZp3AP9n3wR4JMn00+O6rx7rtkZYnu4+ySSorBbYUNLXRn/t+oik3Km0K7E25AWzPAwPH6g9mW8M2aLfIUTOfMuxCMzYPywMw1YZUR63bbE2LnlE83V5GwXJz67/yGxic8Pm9JvMVPLP0O1M5hDPC/en9/r6G+5qIwo+dAnjno0fsJKkFv+bS8Yvv+hIx+JqjSNBXpCuTEKfeDQ9jqLPMIqvTl2ytCa4H3rw/02bXf22rDgVU5bKyAzIG3gBndasr6bOsU64p+A6ZneBubpFV1tprCCxkSHYOZ1GpUczrHaF4cjyqY9ZNzuHp0xJroTfvPjHHPTtfzBpqlk8UsaUzRfqEjjmTPGCjqdQJossKO/7jvQpBb+8J3A8qlX0aP/jkxvv14bwZRfhwTRpBiqtVbec4dnhzR8IQpqGilKSF610AIyAxW61scnfQd4xAEwow7QWrZkF1WGyjBT0xj3sX77KMPMrOXY1eBpDaPGeG4cP75+015bsF1DJ9oPghB3+bgh/KqgI9cH16DsBuEbcL/KewVUBgO4J1i0iTUYfEqfFs7N1fxvJ8QmJxO+U/Sq4khGPShiqn7r+EAi1kcfrrO11w/1hxKGQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(36860700004)(64100799003)(1800799012)(46966006)(40470700004)(1076003)(426003)(336012)(16526019)(26005)(2616005)(83380400001)(316002)(54906003)(110136005)(81166007)(8936002)(70206006)(70586007)(4326008)(8676002)(6666004)(478600001)(36756003)(82740400003)(356005)(41300700001)(15650500001)(7416002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:59:17.8175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e18427-f216-46e4-e7a2-08dc2f083b33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823

Trivial variable rename for the DOE mailbox handle from cdat_doe to
doe_mb. The variable name cdat_doe is too ambiguous, use doe_mb that
is commonly used for the mailbox.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 480489f5644e..39366ce94985 100644
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


