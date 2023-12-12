Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEFC80F736
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377283AbjLLTwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjLLTwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:52:38 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0499A;
        Tue, 12 Dec 2023 11:52:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5xiE15KaVNFxFZpZCjujYoZzCG1ry0qnPogZtoa+8x7p4z6D1/eAxQx6bZqT7BN7/MyoPTiEhaehAVJYeUJVxXZNL20jfi5GCI+ngzXOR7vaGDxDavIMT5Vs9XAQwg6v0Hx90Yz4lCHCTkYN5KMaLfhMP/3Yz1hC8XO5YTQ30wlx78v+rGazQ1cKg8RNvuiyLU2onwzIPfqlohKjgS2JDRiP6THskbe84pQbDOeF9tF3j3bgUo4e2BcjVbf5KHnIKRkBWlvc1n11/hqditRM2EvpBKvmKyF2uXhrA4/D0VibXNrf5f2v7zPke/vx/CqT6q/p6v1gzoQzjPk1mWO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH6smzI3hCnN8mWrsO4XJnIOJOZ2LDA9JV9OJw9RPjo=;
 b=OkRpsM4ogwI3URLi5LgyQx7hr266bgW0Jm0jRZy+VmKqUHfc1zhPrFkxGE2jcovEdgjJ/t6xPOZOFSu2rRpxsjE2qHH7/CQpelG7G3PHLnbKfdShsK0LKuNxHFzLqT/ymX7SIWrY47PiYrxRpgNde6xcFj/P2+5c3meQfGxP87fHg0ub6i+UkccSYIvHS3E93Dpsau3WL5R/tOEnNriA4tdUmVRgV+gEIqe6k2nRxlLBAjDXDoA/4PLqyBh2N9xONyKBffEdUwbNDfOFYnb/MgR8Hi8sJ5yLiSCnRxshMIni+3BBTKwDZZNSFCA276Cek2lJx6jnqJSVK006md4XZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH6smzI3hCnN8mWrsO4XJnIOJOZ2LDA9JV9OJw9RPjo=;
 b=ZdywBJ1h5rII4Smb4UHI6V5b842VhPWZMwNgjyoH0+NVKPAo2eCd8U4Vmp0BMiFVWnO1EISDg1Pe5c4JmGKFdk5GqaCwQRtolUvkdQdhhvgbK0RFuaPvJzPRSrtiVyeXAcN2lf+liaJM2ecHg3omuKfaR3RajPtS0BBRhCnlPeo=
Received: from MW2PR16CA0029.namprd16.prod.outlook.com (2603:10b6:907::42) by
 CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.33; Tue, 12 Dec 2023 19:52:41 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::51) by MW2PR16CA0029.outlook.office365.com
 (2603:10b6:907::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 19:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 19:52:40 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 13:52:39 -0600
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
        <avadnaik@amd.com>
Subject: [PATCH 1/1] parse_phat: Add support for ACPI PHAT Table parsing
Date:   Tue, 12 Dec 2023 13:52:19 -0600
Message-ID: <20231212195219.2348858-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212195219.2348858-1-avadhut.naik@amd.com>
References: <20231212195219.2348858-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfbcaa4-d15e-4e0b-58bc-08dbfb4be65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlQPHbU+rDhmIWdbE/y0m3wNz/tuRKCdDibRiTWfx/DHX0H+YUCHwxNiIznhyEaKh1Lr++y/1+9l60CwpfbA+JXG9n75sBhPfcvLvH5DXzxzmJUlHJU9oe/lDD4gZIVpS4k31sgtlfFkgZ5YzOxV+RsGLrbP04NNTPFPczsdc93+CF1SJtGjvbjvW0QETrU44PCsW9kgNATJoq6sFf11bYjq1k9zVpyApwthUxkhDBTnDkLqFG0v4wG5tGQkYdfKmqOLmNZemFFME/NAjci4uviD5SEfGM/2frNrnZK/kXXHlWIVqOcvkzG2BEBaLRF2I+kEWTeou/JaOEfs0d5EzaBCy79fBy5E8lFtNY6t1p3LDU6xwWUlRkt+XeRu+H65j+qytVorgVrMJR5rVbmURLUSGxQATX5v1v+NCn6C2OsFJhgeShfEzfYH+8Q2h//WB927tJyp3dwkArXJNqioCqjDm59n1BDEUfFotMcmqqbaMshFn7lceDD1iWhFm2gJXDdGs7Xu7oZFLqHyjVg3AxUEpAW+IfZdtn03So4Lrl1cv+S7h+M/X5jstLHiYswKdEMuh5h2JqNG4SqG6e3jAtcjQqInozJPaNa2pMhAwEKdUmqMALC0jEEE/3brJZW4vTBc07iYJAErjJpACFCCLWRrqLP9BkVGJSmWeE2ADzhwhPAZXVq+4X1T8+hvOboXchs9eB2RAWC6U1ynpEtMHd8iACcrlhXVoCh1C+O2124Bsu8LVgjShtnDE0CkQd2PBilTyVJ8PCe22hkpUNKP1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(40470700004)(36840700001)(7696005)(83380400001)(8936002)(450100002)(6666004)(4326008)(2616005)(16526019)(30864003)(36756003)(5660300002)(1076003)(44832011)(26005)(36860700001)(47076005)(336012)(356005)(2906002)(81166007)(41300700001)(82740400003)(426003)(86362001)(70586007)(70206006)(54906003)(110136005)(40480700001)(40460700003)(8676002)(316002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:52:40.7294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfbcaa4-d15e-4e0b-58bc-08dbfb4be65a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI Platform Health Assessment Table (PHAT) enables a platform to expose
an extensible set of platform health-related telemetry. The telemetry is
exposed through Firmware Version and Firmware Health Data Records which
provide version data and health-related information of their associated
components respectively.

Additionally, the platform also provides Reset Reason Health Record
in the table highlighting the cause of the last system reset in case
of expected and unexpected events. Vendor-specific data capturing the
underlying state of the system during reset can also be optionally
provided through the record.[1]

Introduce support for parsing, decoding, and logging the PHAT table, if
supported by the system. By default, the table will be logged to stdout.
The same, however, can be changed through the "-o" command line parameter.
Additionally, the tool also provides a hexdump of the entire table, if
needed, through the "-x" parameter.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 Makefile     |  12 ++
 parse_phat.c | 516 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 528 insertions(+)
 create mode 100644 Makefile
 create mode 100644 parse_phat.c

diff --git a/Makefile b/Makefile
new file mode 100644
index 000000000000..4a8fcbc3ea61
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,12 @@
+$(CC) = gcc
+
+all: phat
+
+phat: parse_phat.o
+	$(CC) -Werror -o phat parse_phat.o
+
+parse_phat.o: parse_phat.c
+	$(CC) -c parse_phat.c
+
+clean:
+	rm -rf *.o $(objects) phat
diff --git a/parse_phat.c b/parse_phat.c
new file mode 100644
index 000000000000..4833d92f9acc
--- /dev/null
+++ b/parse_phat.c
@@ -0,0 +1,516 @@
+/*
+ * Tool for Parsing the ACPI PHAT Table.
+ *
+ * Author: Avadhut Naik <Avadhut.Naik@amd.com>
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <argp.h>
+
+#define TOOL_DESCRIPTION "Parse the ACPI PHAT Table."
+#define TOOL_NAME "phat_parser"
+#define ARGS_DOC "<options>"
+
+#define NAMESEG_SIZE		4
+#define OEM_ID_SIZE			6
+#define OEM_TABLE_ID_SIZE	8
+
+#define PHAT_TABLE			"/sys/firmware/acpi/tables/PHAT"
+#define ARRAY_SIZE(x)		(sizeof(x) / sizeof(*(x)))
+#define BIT(nr)				(1UL << (nr))
+
+const char *argp_program_bug_address = "Avadhut Naik <Avadhut.Naik@amd.com>";
+static const char *prefix = "ACPI PHAT: ";
+
+/* Standard ACPI Table Header */
+struct acpi_table_header {
+	char signature[NAMESEG_SIZE];
+	uint32_t length;
+	uint8_t revision;
+	uint8_t checksum;
+	char oem_id[OEM_ID_SIZE];
+	char oem_table_id[OEM_TABLE_ID_SIZE];
+	uint32_t oem_revision;
+	char asl_compiler_id[NAMESEG_SIZE];
+	uint32_t asl_compiler_revision;
+} __attribute((packed));
+
+struct acpi_table_phat {
+	struct acpi_table_header header;
+} __attribute((packed));
+
+/* Common header for PHAT subtables */
+struct acpi_phat_header {
+	uint16_t type;
+	uint16_t length;
+	uint8_t revision;
+} __attribute((packed));
+
+/* Values for Type field above */
+#define ACPI_PHAT_TYPE_FW_VERSION_DATA	0
+#define ACPI_PHAT_TYPE_FW_HEALTH_DATA	1
+#define ACPI_PHAT_TYPE_RESERVED			2   /* 0x02-0xFFFF are reserved */
+
+struct acpi_phat_version_data {
+	struct acpi_phat_header header;
+	uint8_t reserved[3];
+	uint32_t element_count;
+} __attribute((packed));
+
+struct acpi_phat_version_element {
+	uint8_t guid[16];
+	uint64_t version_value;
+	uint32_t producer_id;
+} __attribute((packed));
+
+struct acpi_phat_health_data {
+	struct acpi_phat_header header;
+	uint8_t reserved[2];
+	uint8_t health;
+	uint8_t device_guid[16];
+	uint32_t device_specific_offset; /* Zero if no Device-specific data */
+} __attribute((packed));
+
+/* Values for Health field above */
+#define ACPI_PHAT_ERRORS_FOUND          0
+#define ACPI_PHAT_NO_ERRORS             1
+#define ACPI_PHAT_UNKNOWN_ERRORS        2
+#define ACPI_PHAT_ADVISORY              3
+
+/* Reset Reason Health Record Structure */
+struct acpi_phat_reset_reason {
+	uint8_t supported_reset_sources;
+	uint8_t reset_source;
+	uint8_t reset_sub_source;
+	uint8_t reset_reason;
+	uint16_t vendor_count;
+} __attribute((packed));
+
+/* Reset Reason Health Record GUID */
+static const uint8_t reset_guid[] = {
+	0xe2, 0x4c, 0x01, 0x7a, 0x63, 0xf2, 0x77, 0x4b,
+	0xb8, 0x8a, 0xe6, 0x33, 0x6b, 0x78, 0x2c, 0x14
+};
+
+static struct { uint8_t mask; const char *str; } const reset_sources[] = {
+	{BIT(0), "Unknown source"},
+	{BIT(1), "Hardware Source"},
+	{BIT(2), "Firmware Source"},
+	{BIT(3), "Software initiated reset"},
+	{BIT(4), "Supervisor initiated reset"},
+};
+
+static struct { uint8_t val; const char *str; } const reset_reasons[] = {
+	{0, "UNKNOWN"},
+	{1, "COLD BOOT"},
+	{2, "COLD RESET"},
+	{3, "WARM RESET"},
+	{4, "UPDATE"},
+	{32, "UNEXPECTED RESET"},
+	{33, "FAULT"},
+	{34, "TIMEOUT"},
+	{35, "THERMAL"},
+	{36, "POWER LOSS"},
+	{37, "POWER BUTTON"},
+};
+
+/* Reset Reason Health Record Vendor Data Entry */
+struct acpi_phat_vendor_reset_data {
+	uint8_t vendor_id[16];
+	uint16_t length;
+	uint16_t revision;
+} __attribute((packed));
+
+struct file_descs {
+	int fd;
+	int offset;
+	FILE *fp;
+};
+
+struct arguments {
+	int hex_dump;
+	int op_redir;
+	char *op_file;
+};
+
+static error_t parse_args(int key, char *arg, struct argp_state *state)
+{
+	struct arguments *args = state->input;
+
+	switch (key) {
+	case 'x':
+		args->hex_dump++;
+		break;
+	case 'o':
+		args->op_redir++;
+		args->op_file = arg;
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+	return 0;
+}
+
+void open_descs(struct file_descs *desc)
+{
+	desc->fd = open(PHAT_TABLE, O_RDONLY);
+
+	if (desc->fd == -1) {
+		printf("Failed to open PHAT Table file. Exiting.\n");
+		exit(0);
+	}
+
+	desc->fp = stdout;
+}
+
+void close_descs(struct file_descs *desc)
+{
+	close(desc->fd);
+	fclose(desc->fp);
+}
+
+unsigned char *get_guid(uint8_t *guid_t)
+{
+	const unsigned char seq[] = {3, 2, 1, 0, 5, 4, 7, 6, 8, 9, 10, 11, 12, 13, 14, 15};
+	unsigned char *guid;
+	int bytes;
+	int len;
+	int pos;
+	int idx;
+
+	len = sizeof(seq) * 3;
+	guid = (unsigned char *)calloc(1, len);
+
+	for (idx = 0, pos = 0; idx < 16; idx++) {
+		if (idx == 4 || idx == 6 || idx == 8 || idx == 10) {
+			bytes = snprintf(guid + pos, len - pos, "-");
+			pos += bytes;
+		}
+
+		bytes = snprintf(guid + pos, len - pos, "%2.2x",
+				 guid_t[seq[idx]]);
+		pos += bytes;
+	}
+
+	return guid;
+}
+
+unsigned char *get_hex(const void *buf, size_t buf_len,
+		       int rowsize, bool inc_len, bool ascii)
+{
+	const unsigned char *ptr;
+	unsigned char *str;
+	int alloc_len;
+	int bytes;
+	int r_len;
+	int b_len;
+	int pos;
+	int idx;
+
+	ptr = buf;
+	alloc_len = 4 * buf_len;
+	str = (unsigned char *)calloc(1, alloc_len);
+
+	for (idx = 0, pos = 0, b_len = 0, r_len = 0; idx < buf_len; idx++) {
+		if (r_len == rowsize) {
+			r_len =  0;
+			str[pos++] = '\n';
+		}
+
+		if (r_len == 0 && inc_len) {
+			bytes = snprintf(str + pos, alloc_len - pos, "%4.4x: ", b_len);
+			b_len += rowsize;
+			pos += bytes;
+		}
+
+		bytes = snprintf(str + pos, alloc_len - pos, "%2.2x ",
+				 ptr[idx]);
+		pos += bytes;
+		r_len++;
+	}
+
+	if (ascii) {
+		str[pos++] = '\t';
+		for (idx = 0; idx < buf_len; idx++)
+			str[pos++] = toascii(ptr[idx]);
+	}
+
+	return str;
+}
+
+void phat_version_data_parse(const char *pfx, struct file_descs *desc,
+			     struct acpi_phat_version_data *v_record)
+{
+	struct acpi_phat_version_element element;
+	unsigned char *guid;
+	unsigned char *str;
+	uint32_t offset;
+	char newpfx[64];
+	int idx;
+
+	if (!v_record->element_count) {
+		fprintf(desc->fp, "%sNo PHAT Version Elements found.\n", prefix);
+		return;
+	}
+
+	fprintf(desc->fp, "%sPHAT Version Element:\n", pfx);
+	offset = desc->offset + sizeof(*v_record);
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+
+	for (idx = 0; idx < v_record->element_count; idx++) {
+		offset += idx * sizeof(element);
+		pread(desc->fd, &element, sizeof(element), offset);
+		guid = get_guid(element.guid);
+		fprintf(desc->fp, "%sComponent ID: %s\n", newpfx, guid);
+		fprintf(desc->fp, "%sVersion: 0x%lx\n", newpfx,
+			element.version_value);
+		str = get_hex(&element.producer_id, sizeof(element.producer_id),
+			      16, false, true);
+		fprintf(desc->fp, "%sProducer ID: %s\n", newpfx, str);
+		free(guid);
+		free(str);
+	}
+}
+
+void phat_vendor_data_parse(const char *pfx, struct file_descs *desc,
+			    struct acpi_phat_reset_reason *rr)
+{
+	struct acpi_phat_vendor_reset_data vdata;
+	unsigned char *guid;
+	unsigned char *str;
+	uint32_t vdata_len;
+	uint32_t offset;
+	char newpfx[64];
+	void *data;
+	int idx;
+
+	fprintf(desc->fp, "%sReset Reason Vendor Data:\n", pfx);
+
+	offset = desc->offset + sizeof(*rr);
+	desc->offset = offset;
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+
+	for (idx = 0; idx < rr->vendor_count; idx++) {
+		pread(desc->fd, &vdata, sizeof(vdata), offset);
+		guid = get_guid(vdata.vendor_id);
+		fprintf(desc->fp, "%sVendor Data ID: %s\n", newpfx, guid);
+		fprintf(desc->fp, "%sRevision: 0x%x\n", newpfx, vdata.revision);
+
+		offset += sizeof(vdata);
+		vdata_len = vdata.length - sizeof(vdata);
+		data = calloc(1, vdata_len);
+		pread(desc->fd, data, vdata_len, offset);
+		str = get_hex(data, vdata_len, 16, false, false);
+		fprintf(desc->fp, "%sData: %s\n", newpfx, str);
+
+		offset = desc->offset + vdata.length;
+		desc->offset = offset;
+		free(guid);
+		free(data);
+		free(str);
+	}
+}
+
+void phat_reset_reason_parse(const char *pfx, struct file_descs *desc,
+			     struct acpi_phat_health_data *record)
+{
+	struct acpi_phat_reset_reason rr;
+	uint32_t offset;
+	char newpfx[64];
+	int idx;
+
+	offset = desc->offset + record->device_specific_offset;
+	desc->offset = offset;
+	pread(desc->fd, &rr, sizeof(rr), offset);
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+	fprintf(desc->fp, "%sReset Reason Health Record:\n", pfx);
+
+	for (idx = 0; idx < ARRAY_SIZE(reset_sources); idx++) {
+		if (!rr.reset_source) {
+			fprintf(desc->fp, "%sUnknown Reset Source.\n", newpfx);
+			break;
+		}
+		if (rr.reset_source && reset_sources[idx].mask) {
+			fprintf(desc->fp, "%sReset Source: 0x%x\t%s\n", newpfx,
+				reset_sources[idx].mask, reset_sources[idx].str);
+
+			if (idx == 0x3 && rr.reset_sub_source)
+				fprintf(desc->fp, "%sReset Sub-Source: %s\n", newpfx,
+					rr.reset_sub_source == 0x1 ?
+					"Operating System" : "Hypervisor");
+			break;
+		}
+	}
+
+	for (idx = 0; idx < ARRAY_SIZE(reset_reasons); idx++) {
+		if (rr.reset_reason == reset_reasons[idx].val) {
+			fprintf(desc->fp, "%sReset Reason: 0x%x\t%s\n", newpfx,
+				reset_reasons[idx].val, reset_reasons[idx].str);
+			break;
+		}
+	}
+
+	if (!rr.vendor_count)
+		return;
+
+	phat_vendor_data_parse(newpfx, desc, &rr);
+}
+
+void phat_health_data_parse(const char *pfx, struct file_descs *desc,
+			    struct acpi_phat_health_data *record)
+{
+	unsigned char *guid;
+	unsigned char *str;
+	uint32_t data_len;
+	uint32_t offset;
+	char newpfx[64];
+	void *data;
+
+	fprintf(desc->fp, "%sHealth Records:\n", pfx);
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+	guid = get_guid(record->device_guid);
+	fprintf(desc->fp, "%sDevice Signature: %s\n", newpfx, guid);
+
+	switch (record->health) {
+	case ACPI_PHAT_ERRORS_FOUND:
+		fprintf(desc->fp, "%sAmHealthy: Errors found\n", newpfx);
+		break;
+	case ACPI_PHAT_NO_ERRORS:
+		fprintf(desc->fp, "%sAmHealthy: No errors found.\n", newpfx);
+		break;
+	case ACPI_PHAT_UNKNOWN_ERRORS:
+		fprintf(desc->fp, "%sAmHealthy: Unknown.\n", newpfx);
+		break;
+	case ACPI_PHAT_ADVISORY:
+		fprintf(desc->fp, "%sAmHealthy: Advisory – additional device-specific data exposed.\n",
+			newpfx);
+		break;
+	default:
+		break;
+	}
+
+	if (!record->device_specific_offset)
+		return;
+
+	if (!memcmp(record->device_guid, reset_guid, 16)) {
+		phat_reset_reason_parse(newpfx, desc, record);
+		return;
+	}
+
+	data_len = record->header.length - sizeof(*record);
+	data = calloc(1, data_len);
+	offset = desc->offset + record->device_specific_offset;
+	pread(desc->fd, data, data_len, offset);
+	snprintf(newpfx, sizeof(newpfx), "%s  ", pfx);
+	str = get_hex(data, data_len, 16, false, false);
+	fprintf(desc->fp, "%sDevice Data: %s\n", newpfx, str);
+	free(guid);
+	free(data);
+	free(str);
+}
+
+void parse_phat_table(struct file_descs *desc,
+		      struct acpi_table_phat *phat_tab)
+{
+	struct acpi_phat_version_data v_record;
+	struct acpi_phat_health_data h_record;
+	uint32_t offset = sizeof(*phat_tab);
+	struct acpi_phat_header header;
+	char pfx[64];
+
+	memset(&v_record, 0, sizeof(v_record));
+	memset(&h_record, 0, sizeof(h_record));
+	snprintf(pfx, sizeof(pfx), "%s ", prefix);
+
+	while (offset < phat_tab->header.length) {
+		pread(desc->fd, &header, sizeof(header), offset);
+		switch (header.type) {
+		case ACPI_PHAT_TYPE_FW_VERSION_DATA:
+			pread(desc->fd, &v_record, sizeof(v_record), offset);
+			desc->offset = offset;
+			phat_version_data_parse(pfx, desc, &v_record);
+			break;
+		case ACPI_PHAT_TYPE_FW_HEALTH_DATA:
+			pread(desc->fd, &h_record, sizeof(h_record), offset);
+			desc->offset = offset;
+			phat_health_data_parse(pfx, desc, &h_record);
+			break;
+		default:
+			break;
+		}
+		offset += header.length;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct acpi_table_phat phat_tab;
+	struct file_descs desc;
+	struct arguments args;
+	unsigned char *phat;
+	unsigned char *str;
+	int idx = -1;
+
+	if (getuid() != 0) {
+		printf("Please run the tool as root. Exiting.\n");
+		return 1;
+	}
+
+	memset(&args, 0, sizeof(args));
+	memset(&desc, 0, sizeof(desc));
+	memset(&phat_tab, 0, sizeof(phat_tab));
+
+	const struct argp_option options[] = {
+		{"hex", 'x', 0, 0, "Hex Dump of the table", 0},
+		{"output", 'o', "FILE", 0,
+		 "Output to FILE instead of standard output", 0},
+		{0, 0, 0, 0, 0, 0},
+	};
+
+	const struct argp argp = {
+		.options = options,
+		.parser = parse_args,
+		.doc = TOOL_DESCRIPTION,
+		.args_doc = ARGS_DOC,
+	};
+
+	argp_parse(&argp, argc, argv, 0, &idx, &args);
+
+	if (idx < 0) {
+		argp_help(&argp, stderr, ARGP_HELP_STD_HELP, TOOL_NAME);
+		return -1;
+	}
+
+	open_descs(&desc);
+
+	if (args.op_redir)
+		desc.fp = fopen(args.op_file, "w+");
+
+	pread(desc.fd, &phat_tab, sizeof(phat_tab), 0);
+
+	if (args.hex_dump) {
+		phat = (unsigned char *)calloc(1, phat_tab.header.length);
+		pread(desc.fd, phat, phat_tab.header.length, 0);
+		str = get_hex(phat, phat_tab.header.length, 16, true, false);
+		fprintf(desc.fp, "%sRaw Table Data: Length: %d (0x%x)\n\n", prefix,
+			phat_tab.header.length, phat_tab.header.length);
+		fprintf(desc.fp, "%s\n\n", str);
+		free(str);
+		free(phat);
+	}
+
+	fprintf(desc.fp, "%sPlatform Telemetry Records\n", prefix);
+
+	parse_phat_table(&desc, &phat_tab);
+
+	close_descs(&desc);
+	return 0;
+}
-- 
2.34.1

