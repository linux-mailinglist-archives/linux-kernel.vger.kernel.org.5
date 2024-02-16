Return-Path: <linux-kernel+bounces-68930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB035858208
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3854B1F23923
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A18C130AF6;
	Fri, 16 Feb 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pTznbEsU"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9012FF90;
	Fri, 16 Feb 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099166; cv=fail; b=DWYdNBQaMEGQekS42PkxeHNO0kkFh9xOnF7n8YbGsjWxQ7qXR6wLS0SAsXj+cjH8bvAbVF3CKFIFg+DeQdhHBYYuq2+k1U+Yrx7PEJll+HarlEHCYgBP5Bsd0HAYwAwAhJOF9ItOFTimjNSz+8eNZqalutIOhn4hoRkE2N/8eAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099166; c=relaxed/simple;
	bh=CLPqcEuSEwe/JMc8QMTIYbsYEHbqDZIOOg505KWB3MU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZfZbctoRmAImfAPsfB3SmtJb96Fhig5a6AZ8Gmg5JNF8wnVEcAGyZPKo4DjIV0m7elol5zFhU/iSneGStmp+cKq6VyQDBJsZO0lIJcE3MxykTdkd8LXoNmr/vgub9JTTbC7hbtIJsJOWqVhbiRyv9tWYEQPVZVPcZmIXOiSAsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pTznbEsU; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M87pRpV0B8QMcs2PvSVj/fPE0mjpU27vl7alQPz4+XNcjxQv7Dw9cROd4nzz8XUP1OCB3B3tNQm05nTScOByGcNh8+QSO4p2hBjCNV6VC9mpDFXonKIRNGwcwq0d54iBKkzhaIoEJ+dyBFi5W+viaUllzqfsvz9kbTifJ08M6F0MhLe0F+6RqtmJ/sTPSgS9UN0j3LQTlV4xU7b2gqp5yYFa0ghk6Zbxts0QRqPT9s9GHXX9EKbCPdRxRn1Wzq3yieERNHnPiWSXQEDYZiVNWForbggtChHSP6iClxpdxSd/3xJTp52gAqtse84IpbSZB3JF2Mjqbngoeo6Y5yZWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfkqwAv3FL0K7sD92UB4NyE/TsQVmg6YJzWfKKQ+sgk=;
 b=Ew4lRHvibpbWlxe7D22ffCwb7Ywn44NvYBU41ab3uAILH5pLHNFfpMfI2rE6rdkEfl30qU5H7apJL0snt8Kw+3wCdkV0z/fjTSiKR3lPIl+iFMoKOOlAjonKHegj8ucnQQU4sG/Z38bF9WZFd0IQGr/DPZ52LUmzi3ET/I99fCh2HzOAT4mMUOhaCVndP5Pa8lHSm5uR+hrZdTsWiu6r0fXIC+uMja4h8VV9JG/72Q2/ii4QtTDwZ0VnVOOcj+Uozzgx86fxAEMDH0ZDB1f9lWsTYnciDmYmYS/fP+akmHb3rVHN6XExg8S1unG20VqgW3Mlm4OTNVj1r7+cSWrvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfkqwAv3FL0K7sD92UB4NyE/TsQVmg6YJzWfKKQ+sgk=;
 b=pTznbEsUaYNLrJCuN0c5Mw1LwZqwYgmjOL/gI89KHOoHygBE5kjDVD89KoS6RW43txMoDvYZaELzHAXiMYgbtHJsMUSmrZ6mNeIsvJha62PcC+GlXmTD0JarrG8y5V2mSR4U2HtCa3P1DcRaKZ74yVRQdFBRTDbqeBTqh55kr2o=
Received: from SN6PR08CA0006.namprd08.prod.outlook.com (2603:10b6:805:66::19)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 15:59:22 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::9d) by SN6PR08CA0006.outlook.office365.com
 (2603:10b6:805:66::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Fri, 16 Feb 2024 15:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:59:22 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:59:18 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Richter
	<rrichter@amd.com>, Lukas Wunner <lukas@wunner.de>, Fan Ni
	<nifan.cxl@gmail.com>
Subject: [PATCH v4 2/3] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Date: Fri, 16 Feb 2024 16:58:43 +0100
Message-ID: <20240216155844.406996-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: a88d9eee-c16c-4cf7-cebe-08dc2f083deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fANoFWGsyZgi9H0XfeuJDAGmAan0QhUVQ4j61TvMlHF7K4kPl6EbJ/ASpGPjS/a/vDu3qRx4lMnBpZOycs1jyvISTzTqnps+vfgGqWvgRMrRDo+r/vSPubbXzQk7T6YQj0ygykWkMhTClZuWqxVobL0tZFzxu6HS1cfioP55NVbXD5SMA6QO95Q6O88Fb4hIhgveV9n8QvcnU5gWdeTDV8wZd88zOyIJUuw5REJ5Ae1hiVrZoYUU4ryyPAxB1S7trVeELvs2SeVXVokblI70s46ewJSYaV2xDaVHLLTRJpPm1/qKSihIa5HNKn0XdWjm4LxJgt74l5JAW0/R6j1jSUAcMY5Ne29ipGR1IWf79XE17FDB3L+rThPENVtWTZQC7I8iTHK2AjKLie5uXDmteWYj4jlOYqh3CVFENoVcFFPZp+Q0GK4q/QdEt2vkRRAX84e0bWCSB0O+Q2Euh+Mvt0H+qn+UyzL+o16/iCaf6/QzT5hnhppaEKNEysvkJkPnCzDFsukb4RjM4V3RI/1IGbV9KbTF0OkJ11lXxb0ZwJuRpJ4CL0A8YaaJMKcwIkBszueGGRYxJuxs/gV3wEISk/l0xlTsLbTG7u57Cm2XPE9Kiravozn45uT2yZn6sejYR+VxKHfbkp/GOmxHcZterA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(186009)(36860700004)(1800799012)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(81166007)(356005)(36756003)(82740400003)(8676002)(8936002)(70586007)(70206006)(83380400001)(336012)(2906002)(426003)(16526019)(26005)(1076003)(4326008)(41300700001)(2616005)(316002)(6666004)(54906003)(110136005)(7416002)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:59:22.4094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a88d9eee-c16c-4cf7-cebe-08dc2f083deb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

Reading the CDAT table using DOE requires a Table Access Response
Header in addition to the CDAT entry. In current implementation this
has caused offsets with sizeof(__le32) to the actual buffers. This led
to hardly readable code and even bugs. E.g., see fix of devm_kfree()
in read_cdat_data():

 c65efe3685f5 cxl/cdat: Free correct buffer on checksum error

Rework code to avoid calculations with sizeof(__le32). Introduce
struct cdat_doe_rsp for this which contains the Table Access Response
Header and a variable payload size for various data structures
afterwards to access the CDAT table and its CDAT Data Structures
without recalculating buffer offsets.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 77 ++++++++++++++++++++++--------------------
 drivers/cxl/cxlpci.h   | 24 +++++++++++++
 2 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 39366ce94985..763c39456228 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -544,55 +544,57 @@ static int cxl_cdat_get_length(struct device *dev,
 
 static int cxl_cdat_read_table(struct device *dev,
 			       struct pci_doe_mb *doe_mb,
-			       void *cdat_table, size_t *cdat_length)
+			       struct cdat_doe_rsp *rsp, size_t *length)
 {
-	size_t length = *cdat_length + sizeof(__le32);
-	__le32 *data = cdat_table;
-	int entry_handle = 0;
+	size_t received, remaining = *length;
+	unsigned int entry_handle = 0;
+	union cdat_data *data;
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
-		if ((entry_handle == 0 &&
-		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
-		    (entry_handle > 0 &&
-		     (rc < sizeof(__le32) + sizeof(*entry) ||
-		      rc != sizeof(__le32) + le16_to_cpu(entry->length))))
+		if (rc < sizeof(*rsp))
 			return -EIO;
 
+		data = (union cdat_data *)rsp->data;
+		received = rc - sizeof(*rsp);
+
+		if (entry_handle == 0) {
+			if (received != sizeof(data->header))
+				return -EIO;
+		} else {
+			if (received < sizeof(data->entry) ||
+			    received != le16_to_cpu(data->entry.length))
+				return -EIO;
+		}
+
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
@@ -620,8 +622,8 @@ void read_cdat_data(struct cxl_port *port)
 	struct pci_doe_mb *doe_mb;
 	struct pci_dev *pdev = NULL;
 	struct cxl_memdev *cxlmd;
-	size_t cdat_length;
-	void *cdat_table, *cdat_buf;
+	struct cdat_doe_rsp *buf;
+	size_t length;
 	int rc;
 
 	if (is_cxl_memdev(uport)) {
@@ -647,30 +649,33 @@ void read_cdat_data(struct cxl_port *port)
 
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
+	if (cdat_checksum(buf->data, length))
 		goto err;
 
-	port->cdat.table = cdat_table;
-	port->cdat.length = cdat_length;
-	return;
+	port->cdat.table = buf->data;
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
index 711b05d9a370..93992a1c8eec 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -71,6 +71,15 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_TYPES
 };
 
+/*
+ * Table Access DOE, CDAT Read Entry Response
+ *
+ * Spec refs:
+ *
+ * CXL 3.1 8.1.11, Table 8-14: Read Entry Response
+ * CDAT Specification 1.03: 2 CDAT Data Structures
+ */
+
 struct cdat_header {
 	__le32 length;
 	u8 revision;
@@ -85,6 +94,21 @@ struct cdat_entry_header {
 	__le16 length;
 } __packed;
 
+/*
+ * The DOE CDAT read response contains a CDAT read entry (either the
+ * CDAT header or a structure).
+ */
+union cdat_data {
+	struct cdat_header header;
+	struct cdat_entry_header entry;
+} __packed;
+
+/* There is an additional CDAT response header of 4 bytes. */
+struct cdat_doe_rsp {
+	__le32 doe_header;
+	u8 data[];
+} __packed;
+
 /*
  * CXL v3.0 6.2.3 Table 6-4
  * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
-- 
2.39.2


