Return-Path: <linux-kernel+bounces-68931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C180385820D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24505B245E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845FE130E3A;
	Fri, 16 Feb 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2wlDKT0W"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D83130E35;
	Fri, 16 Feb 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099173; cv=fail; b=i3ccNHk3uTrP+VFgm1lgxS6JCpVTzRyi8K1wjsiBsGyfEtwFh4HqJduaHHwf35CFtWEzO+B3Cjkvkk4GpWkGguOKxB49z1AAl0YebyZimXynXqbHzZtUgIdiaZyTmPFsQsrXAO/uO/KriXTw87MCTz8/iOzXuJWmN5eRncYi3fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099173; c=relaxed/simple;
	bh=xT8NlFVtOGFcr79QF3zrrDavvwpKSOU3P5vVmCACa0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlDyrSA8kAZTHRsr9fgmJBBPXMivtd6SB5X/uFUeS+UKmqTf4fnSOfiFyZPaBuql4bmL0T7XUZE1qhHGgwBsREj3ihbcVsQ7iWJQ789pO3eD2YD5IUkJOjzyb6ovOoiUIV4uFSmkQawdBv8X0wOzkXE601drtjuEsp8snu7wp7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2wlDKT0W; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5YHX7qVK0hYLmS6QeYhwetABhLtIODUG1/wZxwAsZihL6p/jqu71hUUgI2qcoohAB/JXEFBvOPZBzBYtMsD69ZmqEGJdq1Qpt7dDqZ0opx6SKrKvwiCQW+cz5Y1n6+FkCl5S1U8neLcbQu+F1fUwWQIEgjhu+ShuVYYkyvYbNoks9szGhSBQxN46/KSV4IjZjPd0zGvYDKwPsmf9rBWP9H2bR3S0ti09BpiAUVDbbRTpbSOW5DhqaiCkl/po/nroNXIY4yRRlQRI6Zqt1cJ+6dRm0R71olmlSNkO2e2+XifYGMHiNqrDX/N+K2tp6KVEb8bgqIcob/sVUt0/lig9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMA5ww+Vthzpaafo/2MpAeQwyh9GXBcUrwCXzLoyik0=;
 b=De5eDxM9q4ana0e1v7ISiWJf6ate0Ni4Y9jMEEJymGdCHpKRDBlLckZgU8/K9TtYXjxlX3RwFQTaJrjKpAJv0rXstj2A4xTZ9RCeJR8gPt1jlAYYQA+zt2cITE1hDZkyTGaAmjsTAF1IgBsZUY5C/A1Gih/LHdkpvWVf/DldVnKYVGouSESeXn9MpAudNsY3/4/TQZfKc9911VxxhPSTf+Y//M2BwrQa9URppjLIfXFM256KQ6LsqylqKwk7Y0SpWM3mk9WgrsqfV2j4Vzz+ZHfL9Xw+L3djJ4iCiQOL1Rah+jaa+oyaoY2KYuacJxTTwUEQDF+9e1f11QWx/jb30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMA5ww+Vthzpaafo/2MpAeQwyh9GXBcUrwCXzLoyik0=;
 b=2wlDKT0W7HEKuADNTtJ5Pm6zs/Ew8D7qpQwVlXRGho0IzZZK8M8C6IGR88vXhmZy/qGkxde1ZeSBRIfiLslaw/19Hlg2i+jpGuSCeUIvTOxREbA55A96oDkwjxTnM41Uw/tGANqD/WkmIvALogh8f26+JBKUcDRhmvwEeCyC/qo=
Received: from DM6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:5:1c0::38)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 15:59:28 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::80) by DM6PR12CA0025.outlook.office365.com
 (2603:10b6:5:1c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 15:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:59:27 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:59:24 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Len Brown
	<lenb@kernel.org>, Robert Richter <rrichter@amd.com>,
	<linux-acpi@vger.kernel.org>
Subject: [PATCH v4 3/3] lib/firmware_table: Provide buffer length argument to cdat_table_parse()
Date: Fri, 16 Feb 2024 16:58:44 +0100
Message-ID: <20240216155844.406996-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 970c60b1-5c60-4b0e-bc1b-08dc2f0840fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oukcXJ7rE765rDhO/io7mOLTRB5N7f1J2JRQKoTDZfSdSn1PxIXCZWKkqQJTgSiVzRsdqdeCAVY3udxckZHtlDxeykBHmLP1w02VXCfUdvbmbuoXsi9YBne1D6TfYqO6D5IEt4XfO76j4Lh6pdkicWHjibD+gNZaeebb6FC8ZVsBcFOklYDgi54V6D3DN8IAa5/aID4AS1C6ilwcLaGXSFHj6nHPq9/pZIzXm3L5UPaKs9sUJBlLCfDv7YbDIihflj4WmlIsjL7JbrnEuYOeoNBRovhddLqFCvXYzXkLOuwa1amiSJ5I0UJ8KD2goVlUBTFATGFehkUIgSyfWzjEqn7ko2HHzuOCPWZ1ugz5ZhxYiyD3MqKleUi2W0oAHCJy7bXqUuShpqP42Qk1ijzFjuEuNs5WnWcWowP++AO4onH+sZ9EtgSfsSEL3kUcrYg7ptewenlgozp2cK6vpDdl/NjLaPMLR0HNTMwXluYXz51kwVlAH5qMt8QZj2KByNO/M17CYQHfoSa9hxahRcWZXB1i3ayAU0PzgmWuJnA6779QrycxvrkKHSgFzrldg6anyYqwG0pZtKt63j7bhLu88ysKxt5CIVNZlO6aLaeGbQ7thjcHP9NTOJ0rg7L98lfhuYSFD9LmuK8IZpkhLaI0msmqfYyPcxfLL2FVz1A2NMo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36860700004)(46966006)(40470700004)(356005)(81166007)(36756003)(82740400003)(83380400001)(8676002)(5660300002)(2906002)(7416002)(70586007)(70206006)(316002)(8936002)(6666004)(110136005)(4326008)(41300700001)(921011)(336012)(478600001)(426003)(54906003)(2616005)(1076003)(16526019)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:59:27.5691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 970c60b1-5c60-4b0e-bc1b-08dc2f0840fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709

There exist card implementations with a CDAT table using a fixed size
buffer, but with entries filled in that do not fill the whole table
length size. Then, the last entry in the CDAT table may not mark the
end of the CDAT table buffer specified by the length field in the CDAT
header. It can be shorter with trailing unused (zero'ed) data. The
actual table length is determined while reading all CDAT entries of
the table with DOE.

If the table is greater than expected (containing zero'ed trailing
data), the CDAT parser fails with:

 [   48.691717] Malformed DSMAS table length: (24:0)
 [   48.702084] [CDAT:0x00] Invalid zero length
 [   48.711460] cxl_port endpoint1: Failed to parse CDAT: -22

In addition, a check of the table buffer length is missing to prevent
an out-of-bound access then parsing the CDAT table.

Hardening code against device returning borked table. Fix that by
providing an optional buffer length argument to
acpi_parse_entries_array() that can be used by cdat_table_parse() to
propagate the buffer size down to its users to check the buffer
length. This also prevents a possible out-of-bound access mentioned.

Add a check to warn about a malformed CDAT table length.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/tables.c    |  2 +-
 drivers/cxl/core/cdat.c  |  6 +++---
 drivers/cxl/core/pci.c   |  8 +++++++-
 include/linux/fw_table.h |  4 +++-
 lib/fw_table.c           | 15 ++++++++++-----
 5 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b07f7d091d13..b976e5fc3fbc 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -253,7 +253,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 
 	count = acpi_parse_entries_array(id, table_size,
 					 (union fw_table_header *)table_header,
-					 proc, proc_num, max_entries);
+					 0, proc, proc_num, max_entries);
 
 	acpi_put_table(table_header);
 	return count;
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 6fe11546889f..012d8f2a7945 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -149,13 +149,13 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
 	int rc;
 
 	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
-			      dsmas_xa, port->cdat.table);
+			      dsmas_xa, port->cdat.table, port->cdat.length);
 	rc = cdat_table_parse_output(rc);
 	if (rc)
 		return rc;
 
 	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
-			      dsmas_xa, port->cdat.table);
+			      dsmas_xa, port->cdat.table, port->cdat.length);
 	return cdat_table_parse_output(rc);
 }
 
@@ -511,7 +511,7 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
 		return;
 
 	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
-			      port, port->cdat.table);
+			      port, port->cdat.table, port->cdat.length);
 	rc = cdat_table_parse_output(rc);
 	if (rc)
 		dev_dbg(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 763c39456228..a0e7ed5ae25f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -623,7 +623,7 @@ void read_cdat_data(struct cxl_port *port)
 	struct pci_dev *pdev = NULL;
 	struct cxl_memdev *cxlmd;
 	struct cdat_doe_rsp *buf;
-	size_t length;
+	size_t table_length, length;
 	int rc;
 
 	if (is_cxl_memdev(uport)) {
@@ -662,10 +662,16 @@ void read_cdat_data(struct cxl_port *port)
 	if (!buf)
 		goto err;
 
+	table_length = length;
+
 	rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
 	if (rc)
 		goto err;
 
+	if (table_length != length)
+		dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
+			table_length, length);
+
 	if (cdat_checksum(buf->data, length))
 		goto err;
 
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
index 95421860397a..3ff4c277296f 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -40,12 +40,14 @@ union acpi_subtable_headers {
 
 int acpi_parse_entries_array(char *id, unsigned long table_size,
 			     union fw_table_header *table_header,
+			     unsigned long max_length,
 			     struct acpi_subtable_proc *proc,
 			     int proc_num, unsigned int max_entries);
 
 int cdat_table_parse(enum acpi_cdat_type type,
 		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
-		     struct acpi_table_cdat *table_header);
+		     struct acpi_table_cdat *table_header,
+		     unsigned long length);
 
 /* CXL is the only non-ACPI consumer of the FIRMWARE_TABLE library */
 #if IS_ENABLED(CONFIG_ACPI) && !IS_ENABLED(CONFIG_CXL_BUS)
diff --git a/lib/fw_table.c b/lib/fw_table.c
index c3569d2ba503..16291814450e 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -127,6 +127,7 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
  *
  * @id: table id (for debugging purposes)
  * @table_size: size of the root table
+ * @max_length: maximum size of the table (ignore if 0)
  * @table_header: where does the table start?
  * @proc: array of acpi_subtable_proc struct containing entry id
  *        and associated handler with it
@@ -148,18 +149,21 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
 int __init_or_fwtbl_lib
 acpi_parse_entries_array(char *id, unsigned long table_size,
 			 union fw_table_header *table_header,
+			 unsigned long max_length,
 			 struct acpi_subtable_proc *proc,
 			 int proc_num, unsigned int max_entries)
 {
-	unsigned long table_end, subtable_len, entry_len;
+	unsigned long table_len, table_end, subtable_len, entry_len;
 	struct acpi_subtable_entry entry;
 	enum acpi_subtable_type type;
 	int count = 0;
 	int i;
 
 	type = acpi_get_subtable_type(id);
-	table_end = (unsigned long)table_header +
-		    acpi_table_get_length(type, table_header);
+	table_len = acpi_table_get_length(type, table_header);
+	if (max_length && max_length < table_len)
+		table_len = max_length;
+	table_end = (unsigned long)table_header + table_len;
 
 	/* Parse all entries looking for a match. */
 
@@ -208,7 +212,8 @@ int __init_or_fwtbl_lib
 cdat_table_parse(enum acpi_cdat_type type,
 		 acpi_tbl_entry_handler_arg handler_arg,
 		 void *arg,
-		 struct acpi_table_cdat *table_header)
+		 struct acpi_table_cdat *table_header,
+		 unsigned long length)
 {
 	struct acpi_subtable_proc proc = {
 		.id		= type,
@@ -222,6 +227,6 @@ cdat_table_parse(enum acpi_cdat_type type,
 	return acpi_parse_entries_array(ACPI_SIG_CDAT,
 					sizeof(struct acpi_table_cdat),
 					(union fw_table_header *)table_header,
-					&proc, 1, 0);
+					length, &proc, 1, 0);
 }
 EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);
-- 
2.39.2


