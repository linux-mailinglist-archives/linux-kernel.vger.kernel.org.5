Return-Path: <linux-kernel+bounces-19457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38E826D2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C37283632
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459629410;
	Mon,  8 Jan 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xj6wrCd8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2FC28E25;
	Mon,  8 Jan 2024 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiBlSrrOFuYrESjzTqgJWL4N1aeWQktzKxuOaRRj1C7cppJR/G4vab26tE9qUMqJ9kYLCJBrmLA1m179g5LziPu94sWQm+uZkyzkbsLWX8UZ0IJc3/ofdG97/pJi7sDfRK7GgBI5r6RXjV1mdYPP7jkd0N4yoYGrSBiVMaS8mxp2AwbA5jFVjpxPrC8Ei9MgwooU6XGtPl0NXQXXsuBxvB7Bi4YYgQHYu96WLvGqwlrDnr3c+weYk2NUh+HKhYkA9wBanFDtIBuU5J6f8Q8HKkJW9QQCalVuoda5QNKzBX4LuvI/xhqEJbPlPimGdDE6RX+slTZYF1XLQ11qTTtvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvbJ71b9pImc8Q7qiX3rlBKTfITFZmtuDok4Y6axR6g=;
 b=iV8HNHxhoc8MvM6obWTtDlytb/2sx8562XwTa9YI0LKmpbiglkhflcY9Pn78o1dgG9UzTOjN3qMaaPaszrbNim5ntpmh9u5G7fV6SBFIGw/sHrDgy/c1SM+MLCgviN5OzlWvTyA6YXYtWlKA3iY7f1zOHCdpNKEUh/wYqHUUmPOcwxLEt8CIPTTJl5/uDrGaN3Sq5kism1Bpaa5J/5hsaa+ab6WaIqo+uMxV0cu+KiXOAjaYfs7/urcDRV0FUuiObHeznGGg/kWaI40XiWGo7UDJ6O4Bu8E7lkP83ei5OQlU9FkHwjWOKvGjeUi1MSoLQMsMWauyeJD9RCeRC/eihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvbJ71b9pImc8Q7qiX3rlBKTfITFZmtuDok4Y6axR6g=;
 b=xj6wrCd8RMVpCLbtWHlzEeeb9dz0PW3keFjd388P/SuknUnkIodV1bBAAZIrJET3dZbrRVLaghAjLnrxXJWXyLOHkbb08s3qMve+krMT3/ToeasEw6OPEIY54DkEmQyte9EA2K5sGTyiJI53cQeOMjk0PsC+ZGKtvZDLM2IDzKA=
Received: from PR0P264CA0094.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::34)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 11:49:19 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10a6:100:18:cafe::eb) by PR0P264CA0094.outlook.office365.com
 (2603:10a6:100:18::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 11:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 11:49:17 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 05:49:14 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Richter
	<rrichter@amd.com>, Lukas Wunner <lukas@wunner.de>, Fan Ni
	<nifan.cxl@gmail.com>
Subject: [PATCH v2 2/3] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Date: Mon, 8 Jan 2024 12:48:32 +0100
Message-ID: <20240108114833.241710-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 077a0f8a-2958-45a4-f464-08dc103fd821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ENrKDDTE72upM/kQ6x41H+PB7rJnSO3p0MObSmH4eDGyfqadAHkKS/AS7gd5zoJof0OsSJoIJl5xbOox53PjWyge1NMUDMQzRdcgd/2vWCEMwPU39kQdjB2oVgpV1Sq9ALY5bCz4yIFwyqoc3LWtVk6fTU4/fmqoKHwbfOtCPGGXkw+XSnYNw32ne2X57ya8TRhcoFnL7U2+kW+zNtWLW4xPtI46gJQvoPwOVm19bXimjhhsxx3eIJFep3/4pPdVjw/s8mEfmEiEuF8kJc1tl9BB2WY59ZR83odJunFC/jYWUS3Z1+6Vr8Q1bu6yYcSQIKILVzfxv/Ebppw2WC7JIxHDc9pIduBtFVXAp7oIWSMyaRQlFavD//E3V+L5oS0gsy9iaEgqzpk7VMAOxoBAI630OXlhVUHtyYhz2QqwhL3HoK5bQ5yYdqt8nQ8jp15VC1oXPc8bBorzDvW+/tqg1+4oTlM7XpG6wAbxgVme0+xZ1GpoUoTdj7PPz8arqzIlkSElz8XvGHPYZHdTumhi9Z9+1L9UrYOWrnRhp7etnIy89p39DsTS6gdXxkhcTo3PuUmYFIdqcEZJrwcwBRRgGjaWDAvY+QJlouqeUH11IiId+BYY3h0HrCzZMVevMMjK0RGZaePENFLfLArsSsEHr1wtKqnqx+qPV2iimIJo2C8Sz3iVx+rJ6YHygcXRPRdm4SojAiJy8BlK4LFn0pXFw0BNtjH/vzkbXiCDeDW8LdL+NDtEr3qo/tUtZQogH9udXz3qqSKPJGks5utvjeuj/5TOQ01PL0NE4Q8CEBUXGV8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(4326008)(82740400003)(5660300002)(2906002)(7416002)(478600001)(47076005)(6666004)(83380400001)(426003)(2616005)(26005)(16526019)(336012)(1076003)(36756003)(54906003)(36860700001)(70586007)(70206006)(110136005)(316002)(8676002)(8936002)(81166007)(356005)(41300700001)(40480700001)(40460700003)(26583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:49:17.4230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 077a0f8a-2958-45a4-f464-08dc103fd821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346

Reading the CDAT table using DOE requires a Table Access Response
Header in addition to the CDAT entry. In current implementation this
has caused offsets with sizeof(__le32) to the actual buffers. This led
to hardly readable code and even bugs (see fix of devm_kfree() in
read_cdat_data()).

Rework code to avoid calculations with sizeof(__le32). Introduce
struct cdat_doe for this which contains the Table Access Response
Header and a variable payload size for various data structures
afterwards to access the CDAT table and its CDAT Data Structures
without recalculating buffer offsets.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 67 +++++++++++++++++++++---------------------
 drivers/cxl/cxlpci.h   | 19 ++++++++++++
 2 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 89bab00bb291..75d8fa228879 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -544,55 +544,53 @@ static int cxl_cdat_get_length(struct device *dev,
 
 static int cxl_cdat_read_table(struct device *dev,
 			       struct pci_doe_mb *doe_mb,
-			       void *cdat_table, size_t *cdat_length)
+			       struct cdat_doe_rsp *rsp, size_t *length)
 {
-	size_t length = *cdat_length + sizeof(__le32);
-	__le32 *data = cdat_table;
+	size_t received, remaining = *length;
 	int entry_handle = 0;
 	__le32 saved_dw = 0;
 
 	do {
 		__le32 request = CDAT_DOE_REQ(entry_handle);
-		struct cdat_entry_header *entry;
-		size_t entry_dw;
 		int rc;
 
 		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
 			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
 			     &request, sizeof(request),
-			     data, length);
+			     rsp, sizeof(*rsp) + remaining);
 		if (rc < 0) {
 			dev_err(dev, "DOE failed: %d", rc);
 			return rc;
 		}
 
-		/* 1 DW Table Access Response Header + CDAT entry */
-		entry = (struct cdat_entry_header *)(data + 1);
+		if (rc < sizeof(*rsp))
+			return -EIO;
+
+		received = rc - sizeof(*rsp);
+
 		if ((entry_handle == 0 &&
-		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
+		     received != sizeof(rsp->header[0])) ||
 		    (entry_handle > 0 &&
-		     (rc < sizeof(__le32) + sizeof(*entry) ||
-		      rc != sizeof(__le32) + le16_to_cpu(entry->length))))
+		     (received < sizeof(rsp->entry[0]) ||
+		      received != le16_to_cpu(rsp->entry->length))))
 			return -EIO;
 
 		/* Get the CXL table access header entry handle */
 		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
-					 le32_to_cpu(data[0]));
-		entry_dw = rc / sizeof(__le32);
-		/* Skip Header */
-		entry_dw -= 1;
+					 le32_to_cpu(rsp->doe_header));
+
 		/*
 		 * Table Access Response Header overwrote the last DW of
 		 * previous entry, so restore that DW
 		 */
-		*data = saved_dw;
-		length -= entry_dw * sizeof(__le32);
-		data += entry_dw;
-		saved_dw = *data;
+		rsp->doe_header = saved_dw;
+		remaining -= received;
+		rsp = (void *)rsp + received;
+		saved_dw = rsp->doe_header;
 	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
 
 	/* Length in CDAT header may exceed concatenation of CDAT entries */
-	*cdat_length -= length - sizeof(__le32);
+	*length -= remaining;
 
 	return 0;
 }
@@ -620,8 +618,8 @@ void read_cdat_data(struct cxl_port *port)
 	struct pci_doe_mb *doe_mb;
 	struct pci_dev *pdev = NULL;
 	struct cxl_memdev *cxlmd;
-	size_t cdat_length;
-	void *cdat_table, *cdat_buf;
+	struct cdat_doe_rsp *buf;
+	size_t length;
 	int rc;
 
 	if (is_cxl_memdev(uport)) {
@@ -647,30 +645,33 @@ void read_cdat_data(struct cxl_port *port)
 
 	port->cdat_available = true;
 
-	if (cxl_cdat_get_length(dev, doe_mb, &cdat_length)) {
+	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
 		dev_dbg(dev, "No CDAT length\n");
 		return;
 	}
 
-	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
-	if (!cdat_buf)
-		return;
+	/*
+	 * The begin of the CDAT buffer needs space for additional 4
+	 * bytes for the DOE header. Table data starts afterwards.
+	 */
+	buf = devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);
+	if (!buf)
+		goto err;
 
-	rc = cxl_cdat_read_table(dev, doe_mb, cdat_buf, &cdat_length);
+	rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
 	if (rc)
 		goto err;
 
-	cdat_table = cdat_buf + sizeof(__le32);
-	if (cdat_checksum(cdat_table, cdat_length))
+	if (cdat_checksum(buf->table, length))
 		goto err;
 
-	port->cdat.table = cdat_table;
-	port->cdat.length = cdat_length;
-	return;
+	port->cdat.table = buf->table;
+	port->cdat.length = length;
 
+	return;
 err:
 	/* Don't leave table data allocated on error */
-	devm_kfree(dev, cdat_buf);
+	devm_kfree(dev, buf);
 	dev_err(dev, "Failed to read/validate CDAT.\n");
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 711b05d9a370..b40c571b2ab2 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -85,6 +85,25 @@ struct cdat_entry_header {
 	__le16 length;
 } __packed;
 
+/*
+ * Response contains the CDAT only response header of the DOE. The
+ * response payload is a CDAT structure (either CDAT header or entry),
+ * it may also mark the beginning of the CDAT table.
+ *
+ * Spec refs:
+ *
+ * CXL 3.1 Table 8-14: Read Entry Response
+ * CDAT Specification 1.03: 2 CDAT Data Structures
+ */
+struct cdat_doe_rsp {
+	__le32 doe_header;
+	union {
+		DECLARE_FLEX_ARRAY(u8, table);
+		DECLARE_FLEX_ARRAY(struct cdat_header, header);
+		DECLARE_FLEX_ARRAY(struct cdat_entry_header, entry);
+	};
+} __packed;
+
 /*
  * CXL v3.0 6.2.3 Table 6-4
  * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
-- 
2.39.2


