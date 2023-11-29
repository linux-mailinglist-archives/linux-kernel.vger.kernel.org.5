Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2097B7FD01E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjK2HvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjK2HvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:51:15 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E8D1BD6;
        Tue, 28 Nov 2023 23:51:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhbX7C5koeEkfv+z40GyqYBGCEbhfHujet/583mHMxt0zGDd0hB8M+pr8gHi2SGhxZNWdcYnawJvPUWN7XxNsBwVoRiksKkRSRo/MM5R+akGD2bNDTdJz0rIj0OocCh5i3LywBv2DXz9el1QSK+kbXFMObbDcznV5ETuBur7V90E9YOygzzVx5PtVWDvv9SRmsLFMJZwBi5huaO3jJ1ogxioKZWpAk4kSFMSsTahSkFfpNO2JiJk6nQeLDEVKNKNpOEM6m3MHj48TK3cjwg7wktKE7iewGirqODl8ehalidej5chhENwhTIkiNwjveqkoSBqJeCRXSoboI71sRsTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7dPfPGUOf4GFI/I2HAHKhem3VSYYeXvsJsUw2f9/TY=;
 b=f/4huXoHLKqwAnQxHQbdBw27EedFq6j07SXh85re3cG0v/XGUGTrws7xxfdiLmhKy896inNYyre7Yob2uXlChDEUG+1AVxc+SXgStMmQglJtmuekpqbltEz+Edd+AgIPaXS0w7V6g1+bbM9fbDcJJr2GJ1nZUD+RzG1kPehGs2RxRuKG8M56Z5LBftqm23kqW5YTAlmIBq5Tl2ZCVuwkqmzg2qTyne8y2+/JvCN5iPwiuinrxw5bHeSfbasQ9P/1eJREaqm1nBChsHxlMZKOEjSqTxwjQ102f9iAh3dugT8onQNlUUWly7zjQjC8lvLu8MxGQ/uhnpVASa+0d7X+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7dPfPGUOf4GFI/I2HAHKhem3VSYYeXvsJsUw2f9/TY=;
 b=LkUgksyiwdYW6YVQtGZ+3rj0EKYiSLDmg/M/ms7jgsBdVIf/8NxPRbfQRm2kYyIwDRyYj55sgPBrVcYAnhw+g9qwwG7hrTz05BQBmxtupSHCy43w54Gb2ad6Qts0J4iUwnHavIgsyBOQa4Tvog6kDIDg/B1veI4OtRnlpN/lRl0=
Received: from CY5P221CA0072.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::41) by
 CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Wed, 29 Nov 2023 07:51:04 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::54) by CY5P221CA0072.outlook.office365.com
 (2603:10b6:930:4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 07:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:51:04 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:51:01 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
        Sathya Priya Kumar <sathyapriya.k@amd.com>
Subject: [PATCH 4/4] RAS/fmp: Add Documentation on Persistence of FRU memory poisons
Date:   Wed, 29 Nov 2023 07:50:34 +0000
Message-ID: <20231129075034.2159223-5-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129075034.2159223-1-muralimk@amd.com>
References: <20231129075034.2159223-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH2PR12MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: bb89dab6-a657-4935-7c2a-08dbf0aff027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+5eEdv14DmD6YQlCbl47fNS+NESrHk8Ok0wOxS7E48YR4L3EQTPVpigT+ZF+oiXmxV21Gy8qhJt44qYH22Mu6ICJ+N69ZrUJy4j+Cytxc6DUr4vQsltiSc9POVcNDtNatwpVCL/C/wAtJSdIkoiuOxn+BTXI0qwUCbOHyf+bqhc2/RtpeCwZoO/WiKKcSYAuspL8mdpdi/5EeBDrbxcZ59H/HEstMxj3+NhCEC+XdxMNmHs99/6m8tyYVfFStUT9ymNlMPKfpaRJbwnw5nnFHrvpYYfTEaZ0fq1XN0Cs6UCCYbpG8MZNCNpVsXdSn2M9DCZi7gGZygWInWzBdCCqxAyDh2cZWmO259ubPc24K1+2uhj2lVITLP/4uLI5IQuyEcf7IkrebkZeA/0gB708EcOQpPBYTsoDQ7hGPVOU/fpMMYVYKQuNlzAH6xsfQKu3nMxEGoPUE2OWD5yg0isJdt3DJ9ZZHyOn7hOdnq5pXQM/CKMvPS/i5TRf6mjvyQBfC1P+upEWxXQQNKKEiNOA/q7GYNcvbc5OUlkTBUkf8RFe9yF4ywRCG1lK1Fjuhv8dnFoFXl0u5gN/xdS8Oh7mupav9AzGGVuHYUeFiA19JmSTG34TCsTt4Au7dxyQrEOW5iXUGroypxtZTYqhd/YMbHLvyel6guFpZzIxf4yBBpzpcwsmWqWV+St+TDcwd6kI1s5iVALgIqhYmM/0eTrw7j9XbrzpqGuslGhDk/OsvAiemY+9Jvg2d8cFpUItOx1QtRg/gIKpgmHl7qokIg4cM1B/WTCigXDDndKQLsVUeRP8wvVsrOmUiE8xru0zYj9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(16526019)(40460700003)(2616005)(1076003)(8936002)(6666004)(336012)(7696005)(4326008)(82740400003)(426003)(6916009)(478600001)(8676002)(5660300002)(70586007)(316002)(70206006)(54906003)(36860700001)(83380400001)(26005)(47076005)(356005)(81166007)(36756003)(2906002)(40480700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:51:04.1182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb89dab6-a657-4935-7c2a-08dbf0aff027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

On Data center servers with On chip HBM3 memory, FRU identification
needs a mechanism to identify the bad page information by persisting
them in non volatile storage across reboots and read them during boot
helps to check the number of pages poisoned.

Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Co-developed-by: Sathya Priya Kumar <sathyapriya.k@amd.com>
Signed-off-by: Sathya Priya Kumar <sathyapriya.k@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 Documentation/RAS/ras.rst | 122 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/Documentation/RAS/ras.rst b/Documentation/RAS/ras.rst
index 2556b397cd27..2f86bf02655a 100644
--- a/Documentation/RAS/ras.rst
+++ b/Documentation/RAS/ras.rst
@@ -24,3 +24,125 @@ Also, the user can pass particular family and model to decode the error
 string::
 
         $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca --family <CPU Family> --model <CPU Model> --bank <BANK_NUM>
+
+=============================================================
+Persist FRU(Field Replaceable Unit) Memory Poison
+=============================================================
+
+Large scale Data center servers such as MI300A has on-chip stacked Memory
+High Bandwidth Memory v3 (HBM).
+ - Example: MI300A has 8 stacks of HBM/die, a total of 128Gb per socket.
+Host Operating system is responsible for memory management, allocating HBM3 pages.
+
+Many memory errors tend to be consistent or intermittent and may reoccur. Upon
+reaching a certain threshold of these errors, the specific memory area is deemed
+faulty and should be replaced. In the case of on-die High Bandwidth Memory (HBM),
+any returns due to these issues will likely be directed to the socket vendor.
+
+Define a criteria to identify the Field Replicable Unit(FRU) by evaluating the
+count of "poisoned" pages within the socket and log these poisoned pages persistently
+in a non-volatile storage. This process assists in retaining information about
+defective memory page within the socket for potential replacement.
+
+Linux supports retiring pages by marking the page HW_POISON. However, it doesn't
+persist these marked pages across reboots.
+To address this, a potential solution is to persist bad page details in non-volatile
+storage(ERST). This prevents the reuse of compromised memory region, ensuring they
+are not utilized again.
+
+ERST to persist Bad page information
+====================================
+
+ERST (Error Record Serialization Table) defined by ACPI/APEI provides a mechanism for
+storing and retrieve hardware error Information to and from a persistent memory.
+
+Platform FW(BIOS) with ERST support, reserves ERST tables usually 64KB in non-volatile
+storage. Configure Linux to select ERST as backend for Pstore (read/write from NV storage).
+
+Upon Specific MCE errors Linux would call pstore with CPER format per FRU, platform FW
+would store it in NV storage. and on next boot, Linux would query bad page information
+from ERST and retire the pages again.
+
+FRU memory poison Common Platform Error Record (CPER) definition
+================================================================
+
+One CPER per FRU (Protected Processor Inventory Number (PPIN)).
+1 CPER record per MI300A socket (4 X MI300As system) with the 4 CPERs in a system and
+Each FRU containing poison list offset of the given PPIN.
+
+The FRU poison CPER record size is (BIOS ERST memory) / (Number of FRUs).
+Each erst_write() or erst_read() will write/read this entire structure as one record.
+
+Number of poison entries that can be reached is based on the calculation below
+"(size - sizeof(struct cper_poison_record)) / sizeof(struct cper_fru_poison_data)"
+
+FRU Poison CPER definition for storing error record as below
+
+	struct cper_poison_record {
+		struct cper_record_header hdr;
+		struct cper_section_descriptor sec_hdr;
+		struct cper_sec_fru_mem_poisons fmpl;
+	} __packed;
+
+use 'struct cper_record_header' and 'struct cper_section_descriptor' as defined
+in 'include/linux/cper.h'
+
+ * Section body follows the description of a “non-standard section body” and is defined below.
+
+ * per FRU poison section data
+	struct cper_sec_fru_mem_poisons {
+		char signature[4];
+		u64 checksum;
+		u32 model_id_type;
+		u32 model_id;
+		u32 fru_id_type;
+		u64 fru_id;
+		u32 poison_count;
+		u64 p_list_off;  //offset for contiguous memory to poison data structure
+	};
+
+ * FRU Poison data structure
+	struct cper_fru_poison_data {
+		u32 hw_id_type;
+		u32 addr_type;
+		u64 hw_id;
+		u64 addr;
+	};
+
+
+Implementation Notes on FRU Identification:
+==========================================
+
+ * HBM suppose to have total of 8 DRAM rows.
+ * When MCE error occurs, offline all the pages in that range in a particular row(8 columns in a row).
+   If all the 8 rows become bad, then entire socket has to be replaced.
+ * Perist the error information mentioned in "struct cper_fru_poison_data" to ERST storage.
+
+ * Don’t delete the FMP records once they are saved in persistence store. Keep them in ERST
+   forever until all the poison_data entries become full.
+ * Once the entries full, then do not save the error information in ERST.
+
+At OS boot:
+==========
+ * One CPER per FRU (Protected Processor Inventory Number (PPIN)) has been created.
+	* Size of each CPER will not exceed (1/4)th the available space.
+ * The node controller should make sure there is a CPER for each PPIN in the node. If this is a
+   new processor never seen before, then create a CPER with N=0.
+ * Read the CPERs through the Error Record Serialization Table (ERST).
+ * If OS matches a PPIN to a socket and identifes mce address, it will re-create the SPA for all
+   pages on the HBM row of the poisoned DA, retire all pages mapped to that row.
+ * If a CPER is found for a PPIN that isn’t in the node, OS will print a warning.
+	* If OS tries to persist more errors than fit in the CPER, will refuse to update the CPER
+          and print a message.
+ * OS creates sysfs file for each FRU_ID with a list of DRAM address, MCA_IPID which are retired.
+ $ ls /sys/devices/system/edac/mc/mc0/fmpl
+	* Example: mc0 for socket 0 and mc3 for socket 3.
+ * To read the CPER Record information at any time when the system is up follow below
+	$ cat /sys/devices/system/edac/mc/mc<socket_index>/fmpl
+	$ dmesg
+
+At Mission mode:
+===============
+ * Notifier is registered to handle the FRU memory poison errors.
+ * When the error is injected on particular PPIN, and If OS matches a system PPIN to a socket
+   with MCE PPIN, append the poison data until it reaches maximum number of poison entries.
-- 
2.25.1

