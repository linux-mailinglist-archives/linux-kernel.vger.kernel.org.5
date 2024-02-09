Return-Path: <linux-kernel+bounces-59875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F684FCCF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D3C1F22944
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639BA85C65;
	Fri,  9 Feb 2024 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3H3T4erx"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC384A3F;
	Fri,  9 Feb 2024 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506850; cv=fail; b=pdQroh0mK20Qn+D6tZfB0kNY4wl+bWmwVmuLBWGG75G25P8d0ktPoyPmXGEZpQJR021/E7acL+zun+2QueEFxIQ5Hua7x/T+F0lcbeKtQd+Yl2BF+HzLcBjk5B+YnYiQNAkbFnVa7UJTdDd+IWEovRwIPtroWF+eAd0h0fM3nPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506850; c=relaxed/simple;
	bh=vabspuEL3glJpUj2wBXXyg7L15V0VH8ASThtEw3OFJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwIByJhnKb0wpGPu98Ts9l2M1qq8MnQ8KlR4gmuL7ikmawjBwj4LOtwlr59IJmEDHeMDmM4W+bbXFAfse8PLrBdw1s367oZ+kIVO70VcoKybRcC9puM1y5KJPKvrI1wVp4jIsQXvGbfF4CMZb7aRbiQD2orx58wDZM5gk0IbwHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3H3T4erx; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcYK9nQLEy3l3+tNztQ2eERSYpeo7X4eboS2n/HX/nysRixXPNe0wIaOCQHdxl1frMjCtmUlyo8LbIwOWZGlGyJjel0gkfb/Pq+3QY7NzJO5/uM/xFez0qVGzbDuiGmxEOtqiNzHPEQQozEuSrt0yP/pGYs54+X+L8iUEeA0MWOH3+kfifHlvOMdvYOKkc51Tnuw2xSNAQQoQZVFXcEgepRqYrrs4Y5RxGW1GB7jWJIwkUU5emIpxnxsypq4YxP3QqoU5J+K3/D7nUtdAJ48iWrzsuMwpy4B/8ZM0qo0A+ACepxwzL2TPEUGJdM4mUQ4ZbO1E4ayZh71zaY/YJzzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjkT7qwFJH4bO2K9x9TLA863WqJzFzspzmSbN3NBWAQ=;
 b=i5ouMzknoduAKwUhpc3wXp1C+gr+dQUpWmomVGSvRKQB1Bdnr56vZjUDHKvpftRfj4ELQlgnpufDU/QZru2mbd/JEUvWohdIwwjaJw8cAlGB6Z7pjxhvW50funP+oL2W7YiKd2qTeks9mmyN1UkT4AuMrGG/rZcXbHJrUZTVi+SRkUxmQW6TDhfwrrxS4z3ynDxtoI3TEjUC4sGPzI21SeR0lXylhKr8tKJMDHBH8EXky7OJHNeY6dq2zGJg4OzY/GGFsO9kwE60+WoFuDt74bcExbJHhLlNPIJ0r7E16M+1bugLE2pmneu5tIvF+I6WYuF8XbfPlCsGUxiQ/Xg7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjkT7qwFJH4bO2K9x9TLA863WqJzFzspzmSbN3NBWAQ=;
 b=3H3T4erxexE4zT6+VtiRMW0kJ/5ZcutMX3ihjuHFbl9LLtGA9/7UfQzmwZlU+HFpoGI4JyxT9lPg0+csnLqw1mjNYe6NtKO1eUKLaJZLAxCNgsjd64M3LaFYNF+m0ivmdjYeith9GY8cPd+y4oNCipLF+8J+acjbuEx08dRu9rk=
Received: from DS7PR06CA0007.namprd06.prod.outlook.com (2603:10b6:8:2a::25) by
 IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Fri, 9 Feb
 2024 19:27:22 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::e) by DS7PR06CA0007.outlook.office365.com
 (2603:10b6:8:2a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 19:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 19:27:22 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 13:27:19 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH v3 1/3] cxl/pci: Rename DOE mailbox handle to doe_mb
Date: Fri, 9 Feb 2024 20:26:45 +0100
Message-ID: <20240209192647.163042-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209192647.163042-1-rrichter@amd.com>
References: <20240209192647.163042-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: e5948eff-d4d4-448b-9aa3-08dc29a523b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ucC7/DbgcKis3OFteRT0/m2kE7adC3vZX0IAOLAgSGd+IRLUrU+6tiM5wi1dwAM2HNIGMu/kFtaXvZ6/O4S9llgoD85pUeBWv73DB/Fe8BF4sbd/mDJD6UILgAR7AbA4knuB0iUAyg8hU1Hhv/nvULi/lcZvx7RgR3BjiWge1cI2fnZ/5eLpLYAlxq1EPZrWPduJs7x/bhqYw92P2xGQF4pdiRFnJq9HGLhBcLLguaTHVYzOQ95NIWZWblxPRxMY/t4F8ufZupu2O0uFPg6QIXq9X27EXB/rVrs16pAy2nlVRUIfWx65ZLHQHmhqeX4SmjkjIuAvDiF1x2l/+EY1O7e5TxNQFCYJKYMhpFB6ZCysYVJMs2qNhcA82+7AWR3282MSmA8x6Jf/ycpzysU/R2Pd8b3/6gqJ/iM2cdYBHDhxbjFmsYQHuaYYua2C0ojbhSeIQAd86UBP57IKbqNIXBqq2HyBFiBCl3E6Rr2DSjPUaOB2R4TqazdcYCtHJxZ/BlcIkGRQC3aDZhTV7bU+ti3stL1XORToVW0X7JxH2R/TkYs4u3Rt7e8GlVNQMTnbr+3jsMF8LSLXiCV/uL7OT3w7sRCIxVnvsrRadSkCOGA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(478600001)(83380400001)(1076003)(16526019)(2616005)(41300700001)(26005)(336012)(426003)(15650500001)(2906002)(5660300002)(7416002)(54906003)(110136005)(6666004)(70206006)(70586007)(316002)(4326008)(8936002)(8676002)(36756003)(356005)(82740400003)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:27:22.4630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5948eff-d4d4-448b-9aa3-08dc29a523b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

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


