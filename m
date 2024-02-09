Return-Path: <linux-kernel+bounces-59876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB14F84FCD1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B511F23B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D53F1272BE;
	Fri,  9 Feb 2024 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bUaTabHH"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DA86ADC;
	Fri,  9 Feb 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506855; cv=fail; b=QqBlmmgXKQxwcFlZ30SOJyHu7sUypmfntMb1CgAUTI8rU8Q+lWBA8+pcNdzcN2MdRx5qRCyADyciFVUoFxEdWeyPmoVi3IACNKWGdZB1yir+V7rmLUAI+pObXHgRHzK97VvnctMMpMFBZbs4tKvtEfqDjjFMVwP8Pb6IbkIGw+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506855; c=relaxed/simple;
	bh=g3PlLjwlvgVPxPHyEiqlQ3V+2mYMs427XPhVcsOLynQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcQQaQolSwR+Kd3Tm8HtdRNsW3oxgtL41/NEfwP9uOBJfhlkC4Ww026wMsLhMFz2ZhAXn4LJjNuzmWBE6pZ5blh8rGP2V/uV/tmNMEdA5j5LzxBjX3AwKcmsyLzx5PsW0tJ62M86bvADhAwWqbPlB6sVw1zAq3O9gtfYPEPOA0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bUaTabHH; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hafmg5hS/0Z/l25001IcMnwImTRKYArNvJoR/ScJryX29dXLpDYoKpqwxAWXIf9tpUKQIZiLn6NbXg9OhmOrFlJq2O4syJmOiUwY51MFDhQVQImdLRS5qeptGS0s7NLxPy9Z/TgKr5LUGOA+nZkplyHr/BgCi8pKErkQu4fr9hDbVS4W4z6mpPPErUraRBpqt5kdRjwW5Afg8WN6te/UU/wkA1bT0I/LU8u0BL3PloxyYg3hjeM1nkV4pht88boCJX28+NHyELxAbnRevSx2+d2MetdQyAK9WmrAdtRmwS0mfIHaqpxXSpHiC4G3vb9WM5G+KyFuPPS6P3Zp99R9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNaMYHc41eH0xAhGobej7PUl1gfpW7F9Rwg+SwHpHGE=;
 b=DuR3/TylZfMEmiWkVwXYSJK8BO+fgEYQmE6sCSeW/o14mJhWTOcGFcLgiC1Esmvgu+nmX42E1gMyAHOjZPwlvn9es7SwoNrfxmynyrDUwrgY+VUqBNcMtxNhqACPOr7PO7aT+vhW0d+gj4xyUGuATn8/qy/S8q1HOgO3QuoeVaUAoCZHVQ8yQmHTwoGGwdLY5ssD9MxfN2AlwHhmM+a+YQDKwvHjyK5wuKL3jRuL5+lPJelIQBskTrLAshz1tbjkR6j1ap0TlkJ2gmBwTA7SVD4JScNDwiDPwKB/8RnklV+cZJ1vkokppGL3C8C/hLJSi35Vjzk4aQjlM9pth817ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNaMYHc41eH0xAhGobej7PUl1gfpW7F9Rwg+SwHpHGE=;
 b=bUaTabHHZ8/dDao8SiX+lI7Jm1U1qTx9zmm27XHsEZH90G8+si6PLPz4UjSe3P5NM6OOIK3CWqDOjOWQrZwQ1XAyGfyh/n7wFzcYZVhv70Y/UxoDoymEgaQKEQm5iHTksLiQbIrd7WPtcU0E1PWIgFww8P3jeMUkj3+w05IvMiQ=
Received: from DM6PR18CA0021.namprd18.prod.outlook.com (2603:10b6:5:15b::34)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 9 Feb
 2024 19:27:27 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::a9) by DM6PR18CA0021.outlook.office365.com
 (2603:10b6:5:15b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27 via Frontend
 Transport; Fri, 9 Feb 2024 19:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 19:27:26 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 13:27:23 -0600
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
Subject: [PATCH v3 2/3] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Date: Fri, 9 Feb 2024 20:26:46 +0100
Message-ID: <20240209192647.163042-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f7a0b3-eb50-4072-8210-08dc29a52638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c1HxLqROKOGhHWhHfT9NUlgH+9rhLz+hHXuvkDJrxrTpPLaIQq6cbutc3D8+y69jhTsEArTCKo9i1cYUHj9O9NWgek0bTxVAl8E5OTcOsNZKmyiIV128fFSFd7Brw7aeZUWF8r5Zg1t1t441NMkqmsW/etMIWT0QSbDgWZSpperZi0bWWE7rp36sbKpsffTiATRYK35/sSS+haCe4AVyH/OHcypm8N29jzJes4uQiZr+CuLKf+HsmP+zo0wjHxjljjJSSDL3JKXDmNtgliz2w6Ronb647NXdnoXJvvb3fwp3og+3elUYsDUUJtKKlWJ6M4PKoDmIT+6/pOkuL5o7ClHWP7Y/x+sB7J04I6qNs9ii85q3AUfbXabyCVeyFIYzUZ+OBiJq76IgSEyV2UTukAZYlaqcE4iAVoA86bnsdzFRQbE84fJfG7kLfwutpyYiXEcYkjIUtcYLmfIOuaI9RUrB0RrPGmTUTj7I4blKjgDCSJn5X6wNdc3npNv/sNuWyOl9DZW44ex3yy0rSUDMpkCQJq/vHViUV8OAlyFNujvWcdweYDIKpwaeHTrujfNW4NVpyGdKY2q3ZZxfAOQSyl2FxLVSi+gURgFvnWAn048=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(4326008)(2906002)(54906003)(82740400003)(316002)(356005)(70206006)(36756003)(110136005)(7416002)(8676002)(8936002)(81166007)(5660300002)(70586007)(26005)(426003)(16526019)(336012)(1076003)(83380400001)(2616005)(478600001)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:27:26.6566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f7a0b3-eb50-4072-8210-08dc29a52638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

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
 drivers/cxl/core/pci.c | 75 ++++++++++++++++++++++--------------------
 drivers/cxl/cxlpci.h   | 20 +++++++++++
 2 files changed, 59 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 39366ce94985..569354a5536f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -544,55 +544,55 @@ static int cxl_cdat_get_length(struct device *dev,
 
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
+			return -EIO;
+
+		data = (void *)rsp->data;
+		received = rc - sizeof(*rsp);
+
+		if ((!entry_handle &&
+		     received != sizeof(data->header)) ||
+		    (entry_handle &&
+		     (received < sizeof(data->entry) ||
+		      received != le16_to_cpu(data->entry.length))))
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
@@ -620,8 +620,8 @@ void read_cdat_data(struct cxl_port *port)
 	struct pci_doe_mb *doe_mb;
 	struct pci_dev *pdev = NULL;
 	struct cxl_memdev *cxlmd;
-	size_t cdat_length;
-	void *cdat_table, *cdat_buf;
+	struct cdat_doe_rsp *buf;
+	size_t length;
 	int rc;
 
 	if (is_cxl_memdev(uport)) {
@@ -647,30 +647,33 @@ void read_cdat_data(struct cxl_port *port)
 
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
index 711b05d9a370..152bd453c623 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -85,6 +85,26 @@ struct cdat_entry_header {
 	__le16 length;
 } __packed;
 
+union cdat_data {
+	struct cdat_header header;
+	struct cdat_entry_header entry;
+} __packed;
+
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
+	u8 data[];
+} __packed;
+
 /*
  * CXL v3.0 6.2.3 Table 6-4
  * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
-- 
2.39.2


