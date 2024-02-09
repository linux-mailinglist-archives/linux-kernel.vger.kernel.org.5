Return-Path: <linux-kernel+bounces-59877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6023F84FCD2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE66C1F276E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE4684A50;
	Fri,  9 Feb 2024 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ctFUt6r"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5383126F09;
	Fri,  9 Feb 2024 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506855; cv=fail; b=nDYTMkjKbf6yO5dxbz6d0SWRnEqG1wvPw7A/XkEtwvySxdfs56K1NrsoOcsdf9yJ23JFBL0pxADUur9yHuouCRJgwo7VLeEJhgOlFGBmz6FRD/vKlPrRQzz/3lMd6HFupa3zSNPpVkohEoBQNM14RbXoaqciofScQ+IlouszFSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506855; c=relaxed/simple;
	bh=GP8RjQUzWsTHHTke4Ulq1CtElF7zYObKI6JHgSf4bik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7sR1DpyCkw/hZ6swOlrKyQ4R5IBWm1lpIgkjW6dBaqrB6ItJuj/T07C5wbxRyXSrAdkSL7Xb+eibpw666cRrG8LXamkPXkjjKJlNbbbUAI/Md4oC13nUZnDA1lhg2UQngRAJB9GUytimYYw18OrmkqXxdmK5zAAdY1e66LvgHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ctFUt6r; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM9ODBz4xKQIFqZuwHhu1DMgcgHmnuxAHCBd0S7r8pHeMd0UTKFz2A+L5ryl+MIzNl3gbqGb/Z+hVPrZULWAncCpPbupw58j+fXTMgMrCC0NWL+oTlryzdjZ2tJjPuFpJbLGWy92osa1OZrutZmbHvm1qoT3V1uAeK5jVzEUjIXw98N/BwIeBJvSC39RocincDUCvyGlJpwWtTMzng7VZmjTQsJrwtKNTPwGSGH282duLC3ukyZeNW0WQENcxcQgc28mdFd7reo0oH6WZmloGmVfHtMwW1LmUf7Dq69x4K0l5o+dOVFzA/KXIZ0089GHnLPa3iqKIJgy5NyNANqqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZKlitmFJxu3x8KY8YchJkGX1dGvT5hOJ5xvyUd6zCE=;
 b=fjZU3aTzZH1ZI/1g20dyHV0CEm0gZYT0Nlovjh3/sUfkEri4xlhEXvq3cHFPECBmzdGRhTIecB3wNWm01yHW4pmZJmEIrZMD3Fdc+u6ktECkl2lOP0J4LYaNO9fRS2LzzvVwDPrpEJE8SaOImHJwMyXod4LnJJzX6kIeODfaPWP1gQKQgPajxZmHW6WK6CfHLSm4QjCoutcuAaoCuyeZT07sEHjREr2DgYnetAe+GQNNVkh5EbY3sID+gY53xrLzI4vR/Tx0WfiJVHUPOYROUMgvZSlkKJpfo/rDB5ItemufEsb+zndhyta4rkW/5G+rzC0o9GZtz2Pi5WvTn1X4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZKlitmFJxu3x8KY8YchJkGX1dGvT5hOJ5xvyUd6zCE=;
 b=1ctFUt6rBnMsGZT0O3g5HHXzpL9iJLpYC9qIcUhTxcYwSYkeLeCGZflMn6TXfu0PCwrAgpv42hIIke7FjtuMBTm+LFFEYcA8ZgtyF2yHsqfLRWwUWgVC3p8W1Ik1FF0CAuGrJn+03fbBucgsZbGj9TFlFj3mTAwjMGYnWSxDk/A=
Received: from DS7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:8:54::21) by
 DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.14; Fri, 9 Feb 2024 19:27:31 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::53) by DS7PR06CA0051.outlook.office365.com
 (2603:10b6:8:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39 via Frontend
 Transport; Fri, 9 Feb 2024 19:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 19:27:31 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 13:27:27 -0600
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
Subject: [PATCH v3 3/3] lib/firmware_table: Provide buffer length argument to cdat_table_parse()
Date: Fri, 9 Feb 2024 20:26:47 +0100
Message-ID: <20240209192647.163042-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 9558c154-14e2-4b5a-9574-08dc29a528e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u+eEQ14q9D69IA50hEefnpzyks5bpZvXcEiJIHETSHS77GUfrAVSOHWOfwsY9Z/jItTYAknUHWsjP55X4Ssq3FyJPSIsFkWFUNw/Vpgt5m9RAYQ2ltMFXnISSoWeXBLKcOaOk2EpcpJlUDS36SW1sYqZazboNK7NYWb1fUaT+71HmzrisjE+Hoew4+fuknWllODHWPMV+IuB0GG2xOLu7rQr8re2U3YV39advxIBnCcReDCmd6fx5hczEglhhvMraZeVE5X2pvJkY+JE5/WnNFubVYsWHJlzTcwKxoISeeV+xN6wujVCBSCDIOLY+KYzr4eQWXmzDTSdXRAbQRa7qzwArAo4jqf6AlZjO38FjysjAu3qxgkOTdy9LdFi5XBZ80Vx/EhM5S/odkMiUo+azXbdE5u3uQXKQ+NAsSdY1Dgfby/u4b9xHe0w9dpFk9TvFtNW5P0bj5S84fFsbDhQOALQQ4hdb1IVuSH5Ezz2N+esVc6eByoG3il7OgVIOHZNz7CAsKJVkoDvsuzAb8GE1u/OBcwhjVHP80Uo0yZk0kigSvn9b6NkRhcMZqdToBQyTtrMpVsmdMO1NfaZtbIF45o2PQefpPYm2Il+zYkdB4verrELHqiOKX7fbrM9FsOHnqUL0FZSD/8RSrk7tjfr3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(81166007)(356005)(82740400003)(41300700001)(2616005)(2906002)(26005)(16526019)(1076003)(6666004)(110136005)(478600001)(70206006)(316002)(54906003)(70586007)(83380400001)(336012)(426003)(7416002)(36756003)(921011)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:27:31.1726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9558c154-14e2-4b5a-9574-08dc29a528e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231

There exists card implementations with a CDAT table using a fix
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

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/tables.c    |  2 +-
 drivers/cxl/core/cdat.c  |  6 +++---
 include/linux/fw_table.h |  4 +++-
 lib/fw_table.c           | 15 ++++++++++-----
 4 files changed, 17 insertions(+), 10 deletions(-)

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


