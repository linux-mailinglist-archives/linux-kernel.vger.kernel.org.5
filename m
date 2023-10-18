Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244227CEA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjJRVeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJRVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:34:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037DA11B;
        Wed, 18 Oct 2023 14:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CO7Cd458ePqILyaUzuzbU83vWLyP2bDdpXdMGwQ5S4oZrTc5/1RV+M7v1OjZNeaIh/twA3LENWdbPDzlcE4EvM1pujVXooqg3b7zuCg3JMDwGQUrovJblInRUve/bpTL3ORbP4XAVq9UeuMyxpNkneGqeONeb20jdYkNWE3GO3pgeR2XnVz48DtNN3B7uhz801yqhAno2WjRv1q5QWHYsnN4gO5XBK4f4cCivzRBcQO6t/PrmIcYGwmJS/z4XGheux0BqVvEWqGRmipdnFZ0ji0roID62GEHUczfTyn0A8peX2l+pMQOKZiB12KmJKcRPhFNnvHThynnydahxoi5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15FnRDc3ZmMyWfsK3hpWKfrmEMr1Znkqnk739gnmMpA=;
 b=QNFg6XKbpmkogDFMiPGuWdaVd7phUGmDHW/MatcLqMiw1oHK6L/8OciHtCgOYZN1Aj7lN7o8ftSMjOwe7xe4S28qUNtyLK4dSIea0ynNdMqIE92H3pgEYcZxDIh/TKva7on0Sn3MmUw5RrQFb4y21AWwtEM9K7z5izcYDkxBpXBH+iu3174ppg7Rk9cZkcX2LpK5g3ayITSfRMOYk/7dy/kLOoPgrpOyyYr7AYs8rtFnSmg4lSW8iS6fg9yWgOfoRl7EbmYKR00GDkEWZaNqx6sxs0MwegmmN/zhK0qdCdvjKY4ACz57EUkNComa8PzrsG+aQ6DZF06luGRTP7YVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15FnRDc3ZmMyWfsK3hpWKfrmEMr1Znkqnk739gnmMpA=;
 b=uE26jDGMa2RsIOGGidnaTYsje9UNdDF41gB0F3RQNEZwrzVg70IOYfKbZfkBBNMwfCbq2lXo5I/V0bRXr3Y9K6X3lAVbVborNiRUi+g11v+tVf6gWIyokMEZ1utG5gvGAOxFCKUKkbnAPZMqa9gkTLiOJ2cxxQlfdV4O6JGLRpQ=
Received: from BLAPR03CA0142.namprd03.prod.outlook.com (2603:10b6:208:32e::27)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 21:33:53 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32e:cafe::4) by BLAPR03CA0142.outlook.office365.com
 (2603:10b6:208:32e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 21:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 18 Oct 2023 21:33:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 16:33:51 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 18 Oct 2023 16:33:46 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <michal.simek@amd.com>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <amitrkcian2002@gmail.com>, <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v9 3/8] mtd: spi-nor: Add APIs to set/get nor->params
Date:   Thu, 19 Oct 2023 03:03:23 +0530
Message-ID: <20231018213328.40131-4-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
References: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: bd25c58a-d88c-4239-4ece-08dbd021ed23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bw0MIBwb0Md8MYK80FvR1oKn2vlxfOEsCFaVu6U1cUk/M32OCFLcVUUJgCM+ky3OvzdbtMn3zabxWUM3LnEWYSUOKu7ZgXyJCBaXhkXGkkqQnnGM5sNgCTh6kSuo77HTj022VL0D9H8F0HWvBg3F6uYNC5Hdguoiocrk61y8ikRnxU8BhRqzocLz9DHlBn+lMNcRPKhJSkZ6FRP/AUwEgNhDv6mvSE2FB0s65K8OLXOCURj6d/aucVxyE1kq1ha5SN4oBRlj4oIbsge+3svvtiDyq3ko/2PcAlmDf7aNeSYfJZWDFpFc3KHibhadpI7Y/1kCYB6MLuVujnmTItyHCZsMXe18NewiQA7DDe/Fc/bSFdjAvZXwO6TLgCzT5RhDeURWKKz1yqJVlnO1dyAR4w11bmheLLbsaAmDAShjJMOFJI08aHeZf4sO9QizQaIq7YiLqLqjD3JK2QC35cr6XZI+Q+4HkYq/s6A3wmUwaRMnaM3223jg3gFqVs3KVkG+1dVItyOxMEjabdE9BwJka72aWnGW6T6tVPnXBYFmnihGeXENiahSKtj+on2PNk88YrI96f2mAAfd0oITrwha10ClMJI2uuQprvQnlcq7DEp6esp/Bz4d0jzUfUWDlRaVWh9WlCVMiUdMNMNkVyLPx5A51xd8AG+gUYc2gyGDkYpFWHNIuY/FOlsW5sTwaUPcAkeWdjeloVoLjiZm3W0D64JZ7orHYY79x7A2op7SiXmrij2zSjbvxUz6dH7SnSe3pdPlo0nTIrOeK11uyky8o51fW5s99La1R9HtnE9fIAw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(478600001)(40460700003)(70586007)(70206006)(54906003)(110136005)(26005)(36756003)(336012)(40480700001)(356005)(2616005)(81166007)(1076003)(82740400003)(426003)(83380400001)(86362001)(47076005)(36860700001)(7416002)(2906002)(30864003)(41300700001)(6666004)(316002)(5660300002)(8936002)(8676002)(4326008)(36900700001)(559001)(579004)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:33:53.3600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd25c58a-d88c-4239-4ece-08dbd021ed23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supporting multi-cs in spi-nor would require the *params member of
struct spi_nor to be an array. To make the transition smoother introduced
spi_nor_get_params() & spi_nor_set_params() APIs to get & set nor->params,
added a new local variable (struct spi_nor_flash_parameter *params) to hold
the return value of the spi_nor_get_params() function call and replaced all
nor->params references with the "params".
While adding multi-cs support in further patches the *params member of the
spi_nor structure would be converted to arrays & the "idx" parameter of
the APIs would be used as array index i.e., nor->params[idx].

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/atmel.c      |  17 ++--
 drivers/mtd/spi-nor/core.c       | 133 ++++++++++++++++++++-----------
 drivers/mtd/spi-nor/debugfs.c    |   4 +-
 drivers/mtd/spi-nor/gigadevice.c |   4 +-
 drivers/mtd/spi-nor/issi.c       |  11 ++-
 drivers/mtd/spi-nor/macronix.c   |  10 ++-
 drivers/mtd/spi-nor/micron-st.c  |  30 ++++---
 drivers/mtd/spi-nor/otp.c        |  29 ++++---
 drivers/mtd/spi-nor/sfdp.c       |  33 ++++----
 drivers/mtd/spi-nor/spansion.c   |  57 +++++++------
 drivers/mtd/spi-nor/sst.c        |   7 +-
 drivers/mtd/spi-nor/swp.c        |  22 +++--
 drivers/mtd/spi-nor/winbond.c    |   2 +-
 drivers/mtd/spi-nor/xilinx.c     |  18 +++--
 include/linux/mtd/spi-nor.h      |  10 +++
 15 files changed, 253 insertions(+), 134 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 58968c1e7d2f..644d8c3a81bb 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -23,10 +23,11 @@ static int at25fs_nor_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 static int at25fs_nor_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
 	/* We only support unlocking the whole flash array */
-	if (ofs || len != nor->params->size)
+	if (ofs || len != params->size)
 		return -EINVAL;
 
 	/* Write 0x00 to the status register to disable write protection */
@@ -50,7 +51,9 @@ static const struct spi_nor_locking_ops at25fs_nor_locking_ops = {
 
 static int at25fs_nor_late_init(struct spi_nor *nor)
 {
-	nor->params->locking_ops = &at25fs_nor_locking_ops;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	params->locking_ops = &at25fs_nor_locking_ops;
 
 	return 0;
 }
@@ -71,11 +74,12 @@ static const struct spi_nor_fixups at25fs_nor_fixups = {
 static int atmel_nor_set_global_protection(struct spi_nor *nor, loff_t ofs,
 					   uint64_t len, bool is_protect)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 	u8 sr;
 
 	/* We only support locking the whole flash array */
-	if (ofs || len != nor->params->size)
+	if (ofs || len != params->size)
 		return -EINVAL;
 
 	ret = spi_nor_read_sr(nor, nor->bouncebuf);
@@ -133,9 +137,10 @@ static int atmel_nor_global_unprotect(struct spi_nor *nor, loff_t ofs,
 static int atmel_nor_is_global_protected(struct spi_nor *nor, loff_t ofs,
 					 uint64_t len)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
-	if (ofs >= nor->params->size || (ofs + len) > nor->params->size)
+	if (ofs >= params->size || (ofs + len) > params->size)
 		return -EINVAL;
 
 	ret = spi_nor_read_sr(nor, nor->bouncebuf);
@@ -153,7 +158,9 @@ static const struct spi_nor_locking_ops atmel_nor_global_protection_ops = {
 
 static int atmel_nor_global_protection_late_init(struct spi_nor *nor)
 {
-	nor->params->locking_ops = &atmel_nor_global_protection_ops;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	params->locking_ops = &atmel_nor_global_protection_ops;
 
 	return 0;
 }
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..539c7b69f7b5 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -448,14 +448,15 @@ int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
  */
 int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
 	if (nor->spimem) {
 		struct spi_mem_op op = SPI_NOR_RDSR_OP(sr);
 
 		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
-			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
-			op.dummy.nbytes = nor->params->rdsr_dummy;
+			op.addr.nbytes = params->rdsr_addr_nbytes;
+			op.dummy.nbytes = params->rdsr_dummy;
 			/*
 			 * We don't want to read only one byte in DTR mode. So,
 			 * read 2 and then discard the second byte.
@@ -688,14 +689,15 @@ static void spi_nor_unlock_rdst(struct spi_nor *nor)
 static int spi_nor_ready(struct spi_nor *nor)
 {
 	int ret;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 
 	ret = spi_nor_lock_rdst(nor);
 	if (ret)
 		return 0;
 
 	/* Flashes might override the standard routine. */
-	if (nor->params->ready)
-		ret = nor->params->ready(nor);
+	if (params->ready)
+		ret = params->ready(nor);
 	else
 		ret = spi_nor_sr_ready(nor);
 
@@ -861,6 +863,7 @@ static int spi_nor_write_sr1_and_check(struct spi_nor *nor, u8 sr1)
  */
 static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 	u8 *sr_cr = nor->bouncebuf;
 	u8 cr_written;
@@ -872,7 +875,7 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
 			return ret;
 	} else if (spi_nor_get_protocol_width(nor->read_proto) == 4 &&
 		   spi_nor_get_protocol_width(nor->write_proto) == 4 &&
-		   nor->params->quad_enable) {
+		   params->quad_enable) {
 		/*
 		 * If the Status Register 2 Read command (35h) is not
 		 * supported, we should at least be sure we don't
@@ -1150,17 +1153,21 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
 
 static bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
 {
-	return !!nor->params->erase_map.uniform_erase_type;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	return !!params->erase_map.uniform_erase_type;
 }
 
 static void spi_nor_set_4byte_opcodes(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
 	nor->read_opcode = spi_nor_convert_3to4_read(nor->read_opcode);
 	nor->program_opcode = spi_nor_convert_3to4_program(nor->program_opcode);
 	nor->erase_opcode = spi_nor_convert_3to4_erase(nor->erase_opcode);
 
 	if (!spi_nor_has_uniform_erase(nor)) {
-		struct spi_nor_erase_map *map = &nor->params->erase_map;
+		struct spi_nor_erase_map *map = &params->erase_map;
 		struct spi_nor_erase_type *erase;
 		int i;
 
@@ -1302,6 +1309,7 @@ void spi_nor_unlock_and_unprep(struct spi_nor *nor)
 /* Internal locking helpers for program and erase operations */
 static bool spi_nor_rww_start_pe(struct spi_nor *nor, loff_t start, size_t len)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_nor_rww *rww = &nor->rww;
 	unsigned int used_banks = 0;
 	bool started = false;
@@ -1313,7 +1321,7 @@ static bool spi_nor_rww_start_pe(struct spi_nor *nor, loff_t start, size_t len)
 	if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
 		goto busy;
 
-	spi_nor_offset_to_banks(nor->params->bank_size, start, len, &first, &last);
+	spi_nor_offset_to_banks(params->bank_size, start, len, &first, &last);
 	for (bank = first; bank <= last; bank++) {
 		if (rww->used_banks & BIT(bank))
 			goto busy;
@@ -1332,13 +1340,14 @@ static bool spi_nor_rww_start_pe(struct spi_nor *nor, loff_t start, size_t len)
 
 static void spi_nor_rww_end_pe(struct spi_nor *nor, loff_t start, size_t len)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_nor_rww *rww = &nor->rww;
 	u8 first, last;
 	int bank;
 
 	mutex_lock(&nor->lock);
 
-	spi_nor_offset_to_banks(nor->params->bank_size, start, len, &first, &last);
+	spi_nor_offset_to_banks(params->bank_size, start, len, &first, &last);
 	for (bank = first; bank <= last; bank++)
 		rww->used_banks &= ~BIT(bank);
 
@@ -1379,6 +1388,7 @@ static void spi_nor_unlock_and_unprep_pe(struct spi_nor *nor, loff_t start, size
 /* Internal locking helpers for read operations */
 static bool spi_nor_rww_start_rd(struct spi_nor *nor, loff_t start, size_t len)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_nor_rww *rww = &nor->rww;
 	unsigned int used_banks = 0;
 	bool started = false;
@@ -1390,7 +1400,7 @@ static bool spi_nor_rww_start_rd(struct spi_nor *nor, loff_t start, size_t len)
 	if (rww->ongoing_io || rww->ongoing_rd)
 		goto busy;
 
-	spi_nor_offset_to_banks(nor->params->bank_size, start, len, &first, &last);
+	spi_nor_offset_to_banks(params->bank_size, start, len, &first, &last);
 	for (bank = first; bank <= last; bank++) {
 		if (rww->used_banks & BIT(bank))
 			goto busy;
@@ -1410,13 +1420,14 @@ static bool spi_nor_rww_start_rd(struct spi_nor *nor, loff_t start, size_t len)
 
 static void spi_nor_rww_end_rd(struct spi_nor *nor, loff_t start, size_t len)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_nor_rww *rww = &nor->rww;
 	u8 first, last;
 	int bank;
 
 	mutex_lock(&nor->lock);
 
-	spi_nor_offset_to_banks(nor->params->bank_size, start, len, &first, &last);
+	spi_nor_offset_to_banks(params->bank_size, start, len, &first, &last);
 	for (bank = first; bank <= last; bank++)
 		nor->rww.used_banks &= ~BIT(bank);
 
@@ -1457,10 +1468,12 @@ static void spi_nor_unlock_and_unprep_rd(struct spi_nor *nor, loff_t start, size
 
 static u32 spi_nor_convert_addr(struct spi_nor *nor, loff_t addr)
 {
-	if (!nor->params->convert_addr)
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	if (!params->convert_addr)
 		return addr;
 
-	return nor->params->convert_addr(nor, addr);
+	return params->convert_addr(nor, addr);
 }
 
 /*
@@ -1680,7 +1693,8 @@ static int spi_nor_init_erase_cmd_list(struct spi_nor *nor,
 				       struct list_head *erase_list,
 				       u64 addr, u32 len)
 {
-	const struct spi_nor_erase_map *map = &nor->params->erase_map;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	const struct spi_nor_erase_map *map = &params->erase_map;
 	const struct spi_nor_erase_type *erase, *prev_erase = NULL;
 	struct spi_nor_erase_region *region;
 	struct spi_nor_erase_command *cmd = NULL;
@@ -2133,9 +2147,10 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	size_t *retlen, const u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	struct spi_nor_flash_parameter *params;
 	size_t page_offset, page_remain, i;
 	ssize_t ret;
-	u32 page_size = nor->params->page_size;
+	u32 page_size;
 
 	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
 
@@ -2143,6 +2158,9 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (ret)
 		return ret;
 
+	params = spi_nor_get_params(nor, 0);
+	page_size = params->page_size;
+
 	for (i = 0; i < len; ) {
 		ssize_t written;
 		loff_t addr = to + i;
@@ -2298,6 +2316,8 @@ int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
 static int spi_nor_spimem_check_op(struct spi_nor *nor,
 				   struct spi_mem_op *op)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
 	/*
 	 * First test with 4 address bytes. The opcode itself might
 	 * be a 3B addressing opcode but we don't care, because
@@ -2306,7 +2326,7 @@ static int spi_nor_spimem_check_op(struct spi_nor *nor,
 	 */
 	op->addr.nbytes = 4;
 	if (!spi_mem_supports_op(nor->spimem, op)) {
-		if (nor->params->size > SZ_16M)
+		if (params->size > SZ_16M)
 			return -EOPNOTSUPP;
 
 		/* If flash size <= 16MB, 3 address bytes are sufficient */
@@ -2370,7 +2390,7 @@ static int spi_nor_spimem_check_pp(struct spi_nor *nor,
 static void
 spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	unsigned int cap;
 
 	/* X-X-X modes are not supported yet, mask them all. */
@@ -2471,6 +2491,7 @@ static int spi_nor_select_read(struct spi_nor *nor,
 			       u32 shared_hwcaps)
 {
 	int cmd, best_match = fls(shared_hwcaps & SNOR_HWCAPS_READ_MASK) - 1;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	const struct spi_nor_read_command *read;
 
 	if (best_match < 0)
@@ -2480,7 +2501,7 @@ static int spi_nor_select_read(struct spi_nor *nor,
 	if (cmd < 0)
 		return -EINVAL;
 
-	read = &nor->params->reads[cmd];
+	read = &params->reads[cmd];
 	nor->read_opcode = read->opcode;
 	nor->read_proto = read->proto;
 
@@ -2501,6 +2522,7 @@ static int spi_nor_select_read(struct spi_nor *nor,
 static int spi_nor_select_pp(struct spi_nor *nor,
 			     u32 shared_hwcaps)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int cmd, best_match = fls(shared_hwcaps & SNOR_HWCAPS_PP_MASK) - 1;
 	const struct spi_nor_pp_command *pp;
 
@@ -2511,7 +2533,7 @@ static int spi_nor_select_pp(struct spi_nor *nor,
 	if (cmd < 0)
 		return -EINVAL;
 
-	pp = &nor->params->page_programs[cmd];
+	pp = &params->page_programs[cmd];
 	nor->program_opcode = pp->opcode;
 	nor->write_proto = pp->proto;
 	return 0;
@@ -2580,7 +2602,8 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
 
 static int spi_nor_select_erase(struct spi_nor *nor)
 {
-	struct spi_nor_erase_map *map = &nor->params->erase_map;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	struct spi_nor_erase_map *map = &params->erase_map;
 	const struct spi_nor_erase_type *erase = NULL;
 	struct mtd_info *mtd = &nor->mtd;
 	u32 wanted_size = nor->info->sector_size;
@@ -2629,7 +2652,7 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 static int spi_nor_default_setup(struct spi_nor *nor,
 				 const struct spi_nor_hwcaps *hwcaps)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	u32 ignored_mask, shared_mask;
 	int err;
 
@@ -2689,8 +2712,10 @@ static int spi_nor_default_setup(struct spi_nor *nor,
 
 static int spi_nor_set_addr_nbytes(struct spi_nor *nor)
 {
-	if (nor->params->addr_nbytes) {
-		nor->addr_nbytes = nor->params->addr_nbytes;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	if (params->addr_nbytes) {
+		nor->addr_nbytes = params->addr_nbytes;
 	} else if (nor->read_proto == SNOR_PROTO_8_8_8_DTR) {
 		/*
 		 * In 8D-8D-8D mode, one byte takes half a cycle to transfer. So
@@ -2711,7 +2736,7 @@ static int spi_nor_set_addr_nbytes(struct spi_nor *nor)
 		nor->addr_nbytes = 3;
 	}
 
-	if (nor->addr_nbytes == 3 && nor->params->size > 0x1000000) {
+	if (nor->addr_nbytes == 3 && params->size > 0x1000000) {
 		/* enable 4-byte addressing if the device exceeds 16MiB */
 		nor->addr_nbytes = 4;
 	}
@@ -2733,10 +2758,11 @@ static int spi_nor_set_addr_nbytes(struct spi_nor *nor)
 static int spi_nor_setup(struct spi_nor *nor,
 			 const struct spi_nor_hwcaps *hwcaps)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
-	if (nor->params->setup)
-		ret = nor->params->setup(nor, hwcaps);
+	if (params->setup)
+		ret = params->setup(nor, hwcaps);
 	else
 		ret = spi_nor_default_setup(nor, hwcaps);
 	if (ret)
@@ -2771,7 +2797,7 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
  */
 static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_nor_erase_map *map = &params->erase_map;
 	const u8 no_sfdp_flags = nor->info->no_sfdp_flags;
 	u8 i, erase_mask;
@@ -2903,7 +2929,7 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
  */
 static int spi_nor_late_init_params(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
 	if (nor->manufacturer && nor->manufacturer->fixups &&
@@ -2930,7 +2956,7 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
 	 * NOR protection support. When locking_ops are not provided, we pick
 	 * the default ones.
 	 */
-	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
+	if (nor->flags & SNOR_F_HAS_LOCK && !params->locking_ops)
 		spi_nor_init_default_locking_ops(nor);
 
 	if (nor->info->n_banks > 1)
@@ -2949,12 +2975,13 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
  */
 static void spi_nor_sfdp_init_params_deprecated(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_nor_flash_parameter sfdp_params;
 
-	memcpy(&sfdp_params, nor->params, sizeof(sfdp_params));
+	memcpy(&sfdp_params, params, sizeof(sfdp_params));
 
 	if (spi_nor_parse_sfdp(nor)) {
-		memcpy(nor->params, &sfdp_params, sizeof(*nor->params));
+		memcpy(params, &sfdp_params, sizeof(*params));
 		nor->flags &= ~SNOR_F_4B_OPCODES;
 	}
 }
@@ -2989,7 +3016,7 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
  */
 static void spi_nor_init_default_params(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	const struct flash_info *info = nor->info;
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
@@ -3075,12 +3102,15 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
  */
 static int spi_nor_init_params(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
-	nor->params = devm_kzalloc(nor->dev, sizeof(*nor->params), GFP_KERNEL);
-	if (!nor->params)
+	params = devm_kzalloc(nor->dev, sizeof(*params), GFP_KERNEL);
+	if (!params)
 		return -ENOMEM;
 
+	spi_nor_set_params(nor, 0, params);
+
 	spi_nor_init_default_params(nor);
 
 	if (nor->info->parse_sfdp) {
@@ -3106,9 +3136,10 @@ static int spi_nor_init_params(struct spi_nor *nor)
  */
 static int spi_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
-	if (!nor->params->set_octal_dtr)
+	if (!params->set_octal_dtr)
 		return 0;
 
 	if (!(nor->read_proto == SNOR_PROTO_8_8_8_DTR &&
@@ -3118,7 +3149,7 @@ static int spi_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 	if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
 		return 0;
 
-	ret = nor->params->set_octal_dtr(nor, enable);
+	ret = params->set_octal_dtr(nor, enable);
 	if (ret)
 		return ret;
 
@@ -3138,14 +3169,16 @@ static int spi_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
  */
 static int spi_nor_quad_enable(struct spi_nor *nor)
 {
-	if (!nor->params->quad_enable)
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	if (!params->quad_enable)
 		return 0;
 
 	if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
 	      spi_nor_get_protocol_width(nor->write_proto) == 4))
 		return 0;
 
-	return nor->params->quad_enable(nor);
+	return params->quad_enable(nor);
 }
 
 /**
@@ -3157,7 +3190,7 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
  */
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
 	ret = params->set_4byte_addr_mode(nor, enable);
@@ -3410,6 +3443,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 
 static void spi_nor_set_mtd_info(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct mtd_info *mtd = &nor->mtd;
 	struct device *dev = nor->dev;
 
@@ -3428,9 +3462,9 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 		mtd->flags |= MTD_NO_ERASE;
 	else
 		mtd->_erase = spi_nor_erase;
-	mtd->writesize = nor->params->writesize;
-	mtd->writebufsize = nor->params->page_size;
-	mtd->size = nor->params->size;
+	mtd->writesize = params->writesize;
+	mtd->writebufsize = params->page_size;
+	mtd->size = params->size;
 	mtd->_read = spi_nor_read;
 	/* Might be already set by some SST flashes. */
 	if (!mtd->_write)
@@ -3484,7 +3518,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	 * We need the bounce buffer early to read/write registers when going
 	 * through the spi-mem layer (buffers have to be DMA-able).
 	 * For spi-mem drivers, we'll reallocate a new buffer if
-	 * nor->params->page_size turns out to be greater than PAGE_SIZE (which
+	 * params->page_size turns out to be greater than PAGE_SIZE (which
 	 * shouldn't happen before long since NOR pages are usually less
 	 * than 1KB) after spi_nor_scan() returns.
 	 */
@@ -3558,13 +3592,14 @@ EXPORT_SYMBOL_GPL(spi_nor_scan);
 
 static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_mem_dirmap_info info = {
 		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
 				      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
 				      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
 				      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
 		.offset = 0,
-		.length = nor->params->size,
+		.length = params->size,
 	};
 	struct spi_mem_op *op = &info.op_tmpl;
 
@@ -3589,13 +3624,14 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 
 static int spi_nor_create_write_dirmap(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_mem_dirmap_info info = {
 		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 0),
 				      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
 				      SPI_MEM_OP_NO_DUMMY,
 				      SPI_MEM_OP_DATA_OUT(0, NULL, 0)),
 		.offset = 0,
-		.length = nor->params->size,
+		.length = params->size,
 	};
 	struct spi_mem_op *op = &info.op_tmpl;
 
@@ -3618,6 +3654,7 @@ static int spi_nor_create_write_dirmap(struct spi_nor *nor)
 
 static int spi_nor_probe(struct spi_mem *spimem)
 {
+	struct spi_nor_flash_parameter *params;
 	struct spi_device *spi = spimem->spi;
 	struct flash_platform_data *data = dev_get_platdata(&spi->dev);
 	struct spi_nor *nor;
@@ -3664,13 +3701,15 @@ static int spi_nor_probe(struct spi_mem *spimem)
 
 	spi_nor_debugfs_register(nor);
 
+	params = spi_nor_get_params(nor, 0);
+
 	/*
 	 * None of the existing parts have > 512B pages, but let's play safe
 	 * and add this logic so that if anyone ever adds support for such
 	 * a NOR we don't end up with buffer overflows.
 	 */
-	if (nor->params->page_size > PAGE_SIZE) {
-		nor->bouncebuf_size = nor->params->page_size;
+	if (params->page_size > PAGE_SIZE) {
+		nor->bouncebuf_size = params->page_size;
 		devm_kfree(nor->dev, nor->bouncebuf);
 		nor->bouncebuf = devm_kmalloc(nor->dev,
 					      nor->bouncebuf_size,
diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index 6e163cb5b478..72a901b88ea9 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -76,7 +76,7 @@ static void spi_nor_print_flags(struct seq_file *s, unsigned long flags,
 static int spi_nor_params_show(struct seq_file *s, void *data)
 {
 	struct spi_nor *nor = s->private;
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_nor_erase_map *erase_map = &params->erase_map;
 	struct spi_nor_erase_region *region;
 	const struct flash_info *info = nor->info;
@@ -184,7 +184,7 @@ static void spi_nor_print_pp_cmd(struct seq_file *s,
 static int spi_nor_capabilities_show(struct seq_file *s, void *data)
 {
 	struct spi_nor *nor = s->private;
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	u32 hwcaps = params->hwcaps.mask;
 	int i, cmd;
 
diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index d57ddaf1525b..643f131d3916 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -13,6 +13,8 @@ gd25q256_post_bfpt(struct spi_nor *nor,
 		   const struct sfdp_parameter_header *bfpt_header,
 		   const struct sfdp_bfpt *bfpt)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
 	/*
 	 * GD25Q256C supports the first version of JESD216 which does not define
 	 * the Quad Enable methods. Overwrite the default Quad Enable method.
@@ -24,7 +26,7 @@ gd25q256_post_bfpt(struct spi_nor *nor,
 	 */
 	if (bfpt_header->major == SFDP_JESD216_MAJOR &&
 	    bfpt_header->minor == SFDP_JESD216_MINOR)
-		nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
+		params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 
 	return 0;
 }
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index accdf7aa2bfd..29a8beb17669 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -13,6 +13,8 @@ is25lp256_post_bfpt_fixups(struct spi_nor *nor,
 			   const struct sfdp_parameter_header *bfpt_header,
 			   const struct sfdp_bfpt *bfpt)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
 	/*
 	 * IS25LP256 supports 4B opcodes, but the BFPT advertises
 	 * BFPT_DWORD1_ADDRESS_BYTES_3_ONLY.
@@ -20,7 +22,7 @@ is25lp256_post_bfpt_fixups(struct spi_nor *nor,
 	 */
 	if ((bfpt->dwords[SFDP_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) ==
 		BFPT_DWORD1_ADDRESS_BYTES_3_ONLY)
-		nor->params->addr_nbytes = 4;
+		params->addr_nbytes = 4;
 
 	return 0;
 }
@@ -31,7 +33,8 @@ static const struct spi_nor_fixups is25lp256_fixups = {
 
 static int pm25lv_nor_late_init(struct spi_nor *nor)
 {
-	struct spi_nor_erase_map *map = &nor->params->erase_map;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	struct spi_nor_erase_map *map = &params->erase_map;
 	int i;
 
 	/* The PM25LV series has a different 4k sector erase opcode */
@@ -93,7 +96,9 @@ static const struct flash_info issi_nor_parts[] = {
 
 static void issi_nor_default_init(struct spi_nor *nor)
 {
-	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 }
 
 static const struct spi_nor_fixups issi_fixups = {
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index eb149e517c1f..995599eb5fa0 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -107,13 +107,17 @@ static const struct flash_info macronix_nor_parts[] = {
 
 static void macronix_nor_default_init(struct spi_nor *nor)
 {
-	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 }
 
 static int macronix_nor_late_init(struct spi_nor *nor)
 {
-	if (!nor->params->set_4byte_addr_mode)
-		nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	if (!params->set_4byte_addr_mode)
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
 
 	return 0;
 }
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 6ad080c52ab5..baece51322ee 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -49,10 +49,11 @@
 
 static int micron_st_nor_octal_dtr_en(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
 	int ret;
-	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
+	u8 addr_mode_nbytes = params->addr_mode_nbytes;
 
 	/* Use 20 dummy cycles for memory array reads. */
 	*buf = 20;
@@ -128,27 +129,31 @@ static int micron_st_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 
 static void mt35xu512aba_default_init(struct spi_nor *nor)
 {
-	nor->params->set_octal_dtr = micron_st_nor_set_octal_dtr;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	params->set_octal_dtr = micron_st_nor_set_octal_dtr;
 }
 
 static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
 	/* Set the Fast Read settings. */
-	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
-	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
+	params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
 				  0, 20, SPINOR_OP_MT_DTR_RD,
 				  SNOR_PROTO_8_8_8_DTR);
 
 	nor->cmd_ext_type = SPI_NOR_EXT_REPEAT;
-	nor->params->rdsr_dummy = 8;
-	nor->params->rdsr_addr_nbytes = 0;
+	params->rdsr_dummy = 8;
+	params->rdsr_addr_nbytes = 0;
 
 	/*
 	 * The BFPT quad enable field is set to a reserved value so the quad
 	 * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
 	 * disable it.
 	 */
-	nor->params->quad_enable = NULL;
+	params->quad_enable = NULL;
 
 	return 0;
 }
@@ -314,14 +319,15 @@ static const struct flash_info st_nor_parts[] = {
  */
 static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
 	if (nor->spimem) {
 		struct spi_mem_op op = MICRON_ST_RDFSR_OP(fsr);
 
 		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
-			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
-			op.dummy.nbytes = nor->params->rdsr_dummy;
+			op.addr.nbytes = params->rdsr_addr_nbytes;
+			op.dummy.nbytes = params->rdsr_dummy;
 			/*
 			 * We don't want to read only one byte in DTR mode. So,
 			 * read 2 and then discard the second byte.
@@ -424,14 +430,16 @@ static int micron_st_nor_ready(struct spi_nor *nor)
 
 static void micron_st_nor_default_init(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
 	nor->flags |= SNOR_F_HAS_LOCK;
 	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
-	nor->params->quad_enable = NULL;
+	params->quad_enable = NULL;
 }
 
 static int micron_st_nor_late_init(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 
 	if (nor->info->mfr_flags & USE_FSR)
 		params->ready = micron_st_nor_ready;
diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 23fe75ddc9cf..16a9a0375aeb 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -19,7 +19,9 @@
  */
 static inline unsigned int spi_nor_otp_region_len(struct spi_nor *nor)
 {
-	return nor->params->otp.org->len;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	return params->otp.org->len;
 }
 
 /**
@@ -30,7 +32,9 @@ static inline unsigned int spi_nor_otp_region_len(struct spi_nor *nor)
  */
 static inline unsigned int spi_nor_otp_n_regions(struct spi_nor *nor)
 {
-	return nor->params->otp.org->n_regions;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	return params->otp.org->n_regions;
 }
 
 /**
@@ -241,7 +245,8 @@ int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region)
 
 static loff_t spi_nor_otp_region_start(const struct spi_nor *nor, unsigned int region)
 {
-	const struct spi_nor_otp_organization *org = nor->params->otp.org;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	const struct spi_nor_otp_organization *org = params->otp.org;
 
 	return org->base + region * org->offset;
 }
@@ -266,7 +271,8 @@ static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
 				size_t *retlen, struct otp_info *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	const struct spi_nor_otp_ops *ops = params->otp.ops;
 	unsigned int n_regions = spi_nor_otp_n_regions(nor);
 	unsigned int i;
 	int ret, locked;
@@ -303,7 +309,8 @@ static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
 static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor, loff_t ofs,
 					   size_t len)
 {
-	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	const struct spi_nor_otp_ops *ops = params->otp.ops;
 	unsigned int region;
 	int locked;
 
@@ -328,7 +335,8 @@ static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
 				      const u8 *buf, bool is_write)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	const struct spi_nor_otp_ops *ops = params->otp.ops;
 	const size_t rlen = spi_nor_otp_region_len(nor);
 	loff_t rstart, rofs;
 	unsigned int region;
@@ -414,7 +422,8 @@ static int spi_nor_mtd_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
 static int spi_nor_mtd_otp_erase(struct mtd_info *mtd, loff_t from, size_t len)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	const struct spi_nor_otp_ops *ops = params->otp.ops;
 	const size_t rlen = spi_nor_otp_region_len(nor);
 	unsigned int region;
 	loff_t rstart;
@@ -467,7 +476,8 @@ static int spi_nor_mtd_otp_erase(struct mtd_info *mtd, loff_t from, size_t len)
 static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	const struct spi_nor_otp_ops *ops = params->otp.ops;
 	const size_t rlen = spi_nor_otp_region_len(nor);
 	unsigned int region;
 	int ret;
@@ -501,9 +511,10 @@ static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
 
 void spi_nor_set_mtd_otp_ops(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct mtd_info *mtd = &nor->mtd;
 
-	if (!nor->params->otp.ops)
+	if (!params->otp.ops)
 		return;
 
 	if (WARN_ON(!is_power_of_2(spi_nor_otp_region_len(nor))))
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index b3b11dfed789..f7137c100569 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -436,7 +436,7 @@ static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
 static int spi_nor_parse_bfpt(struct spi_nor *nor,
 			      const struct sfdp_parameter_header *bfpt_header)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_nor_erase_map *map = &params->erase_map;
 	struct spi_nor_erase_type *erase_type = map->erase_type;
 	struct sfdp_bfpt bfpt;
@@ -661,6 +661,8 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
  */
 static u8 spi_nor_smpt_addr_nbytes(const struct spi_nor *nor, const u32 settings)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
 	switch (settings & SMPT_CMD_ADDRESS_LEN_MASK) {
 	case SMPT_CMD_ADDRESS_LEN_0:
 		return 0;
@@ -670,7 +672,7 @@ static u8 spi_nor_smpt_addr_nbytes(const struct spi_nor *nor, const u32 settings
 		return 4;
 	case SMPT_CMD_ADDRESS_LEN_USE_CURRENT:
 	default:
-		return nor->params->addr_mode_nbytes;
+		return params->addr_mode_nbytes;
 	}
 }
 
@@ -822,7 +824,8 @@ spi_nor_region_check_overlay(struct spi_nor_erase_region *region,
 static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
 					      const u32 *smpt)
 {
-	struct spi_nor_erase_map *map = &nor->params->erase_map;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	struct spi_nor_erase_map *map = &params->erase_map;
 	struct spi_nor_erase_type *erase = map->erase_type;
 	struct spi_nor_erase_region *region;
 	u64 offset;
@@ -910,6 +913,7 @@ static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
 static int spi_nor_parse_smpt(struct spi_nor *nor,
 			      const struct sfdp_parameter_header *smpt_header)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	const u32 *sector_map;
 	u32 *smpt;
 	size_t len;
@@ -940,7 +944,7 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
 	if (ret)
 		goto out;
 
-	spi_nor_regions_sort_erase_types(&nor->params->erase_map);
+	spi_nor_regions_sort_erase_types(&params->erase_map);
 	/* fall through */
 out:
 	kfree(smpt);
@@ -980,7 +984,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		{ 0u /* not used */,		BIT(11) },
 		{ 0u /* not used */,		BIT(12) },
 	};
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_nor_pp_command *params_pp = params->page_programs;
 	struct spi_nor_erase_map *map = &params->erase_map;
 	struct spi_nor_erase_type *erase_type = map->erase_type;
@@ -1143,6 +1147,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 static int spi_nor_parse_profile1(struct spi_nor *nor,
 				  const struct sfdp_parameter_header *profile1_header)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	u32 *dwords, addr;
 	size_t len;
 	int ret;
@@ -1165,14 +1170,14 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 
 	 /* Set the Read Status Register dummy cycles and dummy address bytes. */
 	if (dwords[SFDP_DWORD(1)] & PROFILE1_DWORD1_RDSR_DUMMY)
-		nor->params->rdsr_dummy = 8;
+		params->rdsr_dummy = 8;
 	else
-		nor->params->rdsr_dummy = 4;
+		params->rdsr_dummy = 4;
 
 	if (dwords[SFDP_DWORD(1)] & PROFILE1_DWORD1_RDSR_ADDR_BYTES)
-		nor->params->rdsr_addr_nbytes = 4;
+		params->rdsr_addr_nbytes = 4;
 	else
-		nor->params->rdsr_addr_nbytes = 0;
+		params->rdsr_addr_nbytes = 0;
 
 	/*
 	 * We don't know what speed the controller is running at. Find the
@@ -1201,8 +1206,8 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 	dummy = round_up(dummy, 2);
 
 	/* Update the fast read settings. */
-	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
-	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
+	params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
 				  0, dummy, opcode,
 				  SNOR_PROTO_8_8_8_DTR);
 
@@ -1210,7 +1215,7 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 	 * Page Program is "Required Command" in the xSPI Profile 1.0. Update
 	 * the params->hwcaps.mask here.
 	 */
-	nor->params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
+	params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
 
 out:
 	kfree(dwords);
@@ -1231,7 +1236,7 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 static int spi_nor_parse_sccr(struct spi_nor *nor,
 			      const struct sfdp_parameter_header *sccr_header)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	u32 *dwords, addr;
 	size_t len;
 	int ret;
@@ -1282,7 +1287,7 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
 static int spi_nor_parse_sccr_mc(struct spi_nor *nor,
 				 const struct sfdp_parameter_header *sccr_mc_header)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	u32 *dwords, addr;
 	u8 i, n_dice;
 	size_t len;
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 709822fced86..53217e3b4ec3 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -78,7 +78,8 @@ struct spansion_nor_params {
  */
 static void spansion_nor_clear_sr(struct spi_nor *nor)
 {
-	const struct spansion_nor_params *priv_params = nor->params->priv;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	const struct spansion_nor_params *priv_params = params->priv;
 	int ret;
 
 	if (nor->spimem) {
@@ -98,7 +99,7 @@ static void spansion_nor_clear_sr(struct spi_nor *nor)
 
 static int cypress_nor_sr_ready_and_clear_reg(struct spi_nor *nor, u64 addr)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_mem_op op =
 		CYPRESS_NOR_RD_ANY_REG_OP(params->addr_mode_nbytes, addr,
 					  0, nor->bouncebuf);
@@ -140,7 +141,7 @@ static int cypress_nor_sr_ready_and_clear_reg(struct spi_nor *nor, u64 addr)
  */
 static int cypress_nor_sr_ready_and_clear(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	u64 addr;
 	int ret;
 	u8 i;
@@ -159,10 +160,11 @@ static int cypress_nor_sr_ready_and_clear(struct spi_nor *nor)
 
 static int cypress_nor_set_memlat(struct spi_nor *nor, u64 addr)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
 	int ret;
-	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
+	u8 addr_mode_nbytes = params->addr_mode_nbytes;
 
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes, addr, 0, buf);
@@ -189,13 +191,14 @@ static int cypress_nor_set_memlat(struct spi_nor *nor, u64 addr)
 
 static int cypress_nor_set_octal_dtr_bits(struct spi_nor *nor, u64 addr)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
 
 	/* Set the octal and DTR enable bits. */
 	buf[0] = SPINOR_REG_CYPRESS_CFR5_OCT_DTR_EN;
 	op = (struct spi_mem_op)
-		CYPRESS_NOR_WR_ANY_REG_OP(nor->params->addr_mode_nbytes,
+		CYPRESS_NOR_WR_ANY_REG_OP(params->addr_mode_nbytes,
 					  addr, 1, buf);
 
 	return spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
@@ -203,7 +206,7 @@ static int cypress_nor_set_octal_dtr_bits(struct spi_nor *nor, u64 addr)
 
 static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 {
-	const struct spi_nor_flash_parameter *params = nor->params;
+	const struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	u8 *buf = nor->bouncebuf;
 	u64 addr;
 	int i, ret;
@@ -253,7 +256,7 @@ static int cypress_nor_set_single_spi_bits(struct spi_nor *nor, u64 addr)
 
 static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 {
-	const struct spi_nor_flash_parameter *params = nor->params;
+	const struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	u8 *buf = nor->bouncebuf;
 	u64 addr;
 	int i, ret;
@@ -280,8 +283,9 @@ static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 
 static int cypress_nor_quad_enable_volatile_reg(struct spi_nor *nor, u64 addr)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_mem_op op;
-	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
+	u8 addr_mode_nbytes = params->addr_mode_nbytes;
 	u8 cfr1v_written;
 	int ret;
 
@@ -339,7 +343,7 @@ static int cypress_nor_quad_enable_volatile_reg(struct spi_nor *nor, u64 addr)
  */
 static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	u64 addr;
 	u8 i;
 	int ret;
@@ -418,6 +422,7 @@ static int cypress_nor_determine_addr_mode_by_sr1(struct spi_nor *nor,
  */
 static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_mem_op op;
 	u8 addr_mode;
 	int ret;
@@ -459,8 +464,8 @@ static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
 			return spi_nor_set_4byte_addr_mode(nor, true);
 	}
 
-	nor->params->addr_nbytes = addr_mode;
-	nor->params->addr_mode_nbytes = addr_mode;
+	params->addr_nbytes = addr_mode;
+	params->addr_mode_nbytes = addr_mode;
 
 	return 0;
 }
@@ -477,10 +482,10 @@ static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
  */
 static int cypress_nor_get_page_size(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_mem_op op =
-		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
+		CYPRESS_NOR_RD_ANY_REG_OP(params->addr_mode_nbytes,
 					  0, 0, nor->bouncebuf);
-	struct spi_nor_flash_parameter *params = nor->params;
 	int ret;
 	u8 i;
 
@@ -507,12 +512,14 @@ static int cypress_nor_get_page_size(struct spi_nor *nor)
 
 static void cypress_nor_ecc_init(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
 	/*
 	 * Programming is supported only in 16-byte ECC data unit granularity.
 	 * Byte-programming, bit-walking, or multiple program operations to the
 	 * same ECC data unit without an erase are not allowed.
 	 */
-	nor->params->writesize = 16;
+	params->writesize = 16;
 	nor->flags |= SNOR_F_ECC;
 }
 
@@ -521,6 +528,7 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 			  const struct sfdp_parameter_header *bfpt_header,
 			  const struct sfdp_bfpt *bfpt)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_mem_op op;
 	int ret;
 
@@ -530,7 +538,7 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 
 	/* Read Architecture Configuration Register (ARCFN) */
 	op = (struct spi_mem_op)
-		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
+		CYPRESS_NOR_RD_ANY_REG_OP(params->addr_mode_nbytes,
 					  SPINOR_REG_CYPRESS_ARCFN, 1,
 					  nor->bouncebuf);
 	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
@@ -546,7 +554,7 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 
 static int s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 
 	/*
 	 * S25FS256T does not define the SCCR map, but we would like to use the
@@ -588,20 +596,21 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 			const struct sfdp_bfpt *bfpt)
 {
 	int ret;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 
 	ret = cypress_nor_set_addr_mode_nbytes(nor);
 	if (ret)
 		return ret;
 
 	/* Replace Quad Enable with volatile version */
-	nor->params->quad_enable = cypress_nor_quad_enable_volatile;
+	params->quad_enable = cypress_nor_quad_enable_volatile;
 
 	return 0;
 }
 
 static int s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spi_nor_erase_type *erase_type = params->erase_map.erase_type;
 	unsigned int i;
 
@@ -637,7 +646,7 @@ static int s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 
 static int s25hx_t_late_init(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 
 	/* Fast Read 4B requires mode cycles */
 	params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
@@ -671,7 +680,7 @@ static int cypress_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 
 static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 
 	if (!params->n_dice || !params->vreg_offset) {
 		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
@@ -720,7 +729,7 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 
 static int s28hx_t_late_init(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 
 	params->set_octal_dtr = cypress_nor_set_octal_dtr;
 	params->ready = cypress_nor_sr_ready_and_clear;
@@ -740,13 +749,15 @@ s25fs_s_nor_post_bfpt_fixups(struct spi_nor *nor,
 			     const struct sfdp_parameter_header *bfpt_header,
 			     const struct sfdp_bfpt *bfpt)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
 	/*
 	 * The S25FS-S chip family reports 512-byte pages in BFPT but
 	 * in reality the write buffer still wraps at the safe default
 	 * of 256 bytes.  Overwrite the page size advertised by BFPT
 	 * to get the writes working.
 	 */
-	nor->params->page_size = 256;
+	params->page_size = 256;
 
 	return 0;
 }
@@ -948,7 +959,7 @@ static int spansion_nor_sr_ready_and_clear(struct spi_nor *nor)
 
 static int spansion_nor_late_init(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct spansion_nor_params *priv_params;
 	u8 mfr_flags = nor->info->mfr_flags;
 
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 197d2c1101ed..397aa7d5bc9e 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -20,10 +20,11 @@ static int sst26vf_nor_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 static int sst26vf_nor_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
 	/* We only support unlocking the entire flash array. */
-	if (ofs != 0 || len != nor->params->size)
+	if (ofs != 0 || len != params->size)
 		return -EINVAL;
 
 	ret = spi_nor_read_cr(nor, nor->bouncebuf);
@@ -51,7 +52,9 @@ static const struct spi_nor_locking_ops sst26vf_nor_locking_ops = {
 
 static int sst26vf_nor_late_init(struct spi_nor *nor)
 {
-	nor->params->locking_ops = &sst26vf_nor_locking_ops;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	params->locking_ops = &sst26vf_nor_locking_ops;
 
 	return 0;
 }
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 5ab9d5324860..632c704ad955 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -345,11 +345,14 @@ static const struct spi_nor_locking_ops spi_nor_sr_locking_ops = {
 
 void spi_nor_init_default_locking_ops(struct spi_nor *nor)
 {
-	nor->params->locking_ops = &spi_nor_sr_locking_ops;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	params->locking_ops = &spi_nor_sr_locking_ops;
 }
 
 static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
+	struct spi_nor_flash_parameter *params;
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	int ret;
 
@@ -357,7 +360,8 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	if (ret)
 		return ret;
 
-	ret = nor->params->locking_ops->lock(nor, ofs, len);
+	params = spi_nor_get_params(nor, 0);
+	ret = params->locking_ops->lock(nor, ofs, len);
 
 	spi_nor_unlock_and_unprep(nor);
 	return ret;
@@ -365,6 +369,7 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 
 static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
+	struct spi_nor_flash_parameter *params;
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	int ret;
 
@@ -372,7 +377,8 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	if (ret)
 		return ret;
 
-	ret = nor->params->locking_ops->unlock(nor, ofs, len);
+	params = spi_nor_get_params(nor, 0);
+	ret = params->locking_ops->unlock(nor, ofs, len);
 
 	spi_nor_unlock_and_unprep(nor);
 	return ret;
@@ -380,6 +386,7 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 
 static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
+	struct spi_nor_flash_parameter *params;
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	int ret;
 
@@ -387,7 +394,8 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	if (ret)
 		return ret;
 
-	ret = nor->params->locking_ops->is_locked(nor, ofs, len);
+	params = spi_nor_get_params(nor, 0);
+	ret = params->locking_ops->is_locked(nor, ofs, len);
 
 	spi_nor_unlock_and_unprep(nor);
 	return ret;
@@ -407,6 +415,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
  */
 void spi_nor_try_unlock_all(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	int ret;
 
 	if (!(nor->flags & SNOR_F_HAS_LOCK))
@@ -414,16 +423,17 @@ void spi_nor_try_unlock_all(struct spi_nor *nor)
 
 	dev_dbg(nor->dev, "Unprotecting entire flash array\n");
 
-	ret = spi_nor_unlock(&nor->mtd, 0, nor->params->size);
+	ret = spi_nor_unlock(&nor->mtd, 0, params->size);
 	if (ret)
 		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
 }
 
 void spi_nor_set_mtd_locking_ops(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct mtd_info *mtd = &nor->mtd;
 
-	if (!nor->params->locking_ops)
+	if (!params->locking_ops)
 		return;
 
 	mtd->_lock = spi_nor_lock;
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index cd99c9a1c568..fb94291f7879 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -219,7 +219,7 @@ static const struct spi_nor_otp_ops winbond_nor_otp_ops = {
 
 static int winbond_nor_late_init(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 
 	if (params->otp.org->n_regions)
 		params->otp.ops = &winbond_nor_otp_ops;
diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index 00d53eae5ee8..8c27a3fdfd56 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -56,7 +56,8 @@ static const struct flash_info xilinx_nor_parts[] = {
  */
 static u32 s3an_nor_convert_addr(struct spi_nor *nor, u32 addr)
 {
-	u32 page_size = nor->params->page_size;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	u32 page_size = params->page_size;
 	u32 offset, page;
 
 	offset = addr % page_size;
@@ -116,6 +117,7 @@ static int xilinx_nor_sr_ready(struct spi_nor *nor)
 static int xilinx_nor_setup(struct spi_nor *nor,
 			    const struct spi_nor_hwcaps *hwcaps)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	u32 page_size;
 	int ret;
 
@@ -141,14 +143,14 @@ static int xilinx_nor_setup(struct spi_nor *nor,
 	 */
 	if (nor->bouncebuf[0] & XSR_PAGESIZE) {
 		/* Flash in Power of 2 mode */
-		page_size = (nor->params->page_size == 264) ? 256 : 512;
-		nor->params->page_size = page_size;
+		page_size = (params->page_size == 264) ? 256 : 512;
+		params->page_size = page_size;
 		nor->mtd.writebufsize = page_size;
-		nor->params->size = 8 * page_size * nor->info->n_sectors;
+		params->size = 8 * page_size * nor->info->n_sectors;
 		nor->mtd.erasesize = 8 * page_size;
 	} else {
 		/* Flash in Default addressing mode */
-		nor->params->convert_addr = s3an_nor_convert_addr;
+		params->convert_addr = s3an_nor_convert_addr;
 		nor->mtd.erasesize = nor->info->sector_size;
 	}
 
@@ -157,8 +159,10 @@ static int xilinx_nor_setup(struct spi_nor *nor,
 
 static int xilinx_nor_late_init(struct spi_nor *nor)
 {
-	nor->params->setup = xilinx_nor_setup;
-	nor->params->ready = xilinx_nor_sr_ready;
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	params->setup = xilinx_nor_setup;
+	params->ready = xilinx_nor_sr_ready;
 
 	return 0;
 }
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index cdcfe0fd2e7d..59909e7d6f53 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -433,6 +433,16 @@ static inline struct device_node *spi_nor_get_flash_node(struct spi_nor *nor)
 	return mtd_get_of_node(&nor->mtd);
 }
 
+static inline struct spi_nor_flash_parameter *spi_nor_get_params(const struct spi_nor *nor, u8 idx)
+{
+	return nor->params;
+}
+
+static inline void spi_nor_set_params(struct spi_nor *nor, u8 idx,
+				      struct spi_nor_flash_parameter *params)
+{
+	nor->params = params;
+}
 /**
  * spi_nor_scan() - scan the SPI NOR
  * @nor:	the spi_nor structure
-- 
2.17.1

