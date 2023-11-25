Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3A07F8990
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 10:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjKYJWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 04:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjKYJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 04:22:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380FC1BE6;
        Sat, 25 Nov 2023 01:22:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpqEK4oAcGpgSQGlXT/lZt29SZE3SP2Py/iSRUT4yZWBeXxE7y2H2WM16QVgcCNCLm/i+ubC0No/huHACC0TssHp+/S9GbElekUAfJSgdoz6WQsUf7U1RnGomgBOQIRi3+XF2eTuMF/8v8fazjWqDxPmmhTMQmbCZ2c3mh1aDVHcStYOqq1Hl2W0/hagfmPZ87BGoJBj7XBK9ZfLKRKK4C079I+zsgY9C2wmM/KG8lCaQsKhsPK9yHv72kwXJCv8ZIezSf03vloif/8o4tqAnqsu31F0HqhJApfD3bTxvpP/jREWmv4uFv4Gkc0WyWKxjapu0wCbSy760QKpeh79Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xZ3ze/HKzOT7bWHVpfCim7Eopquwx+9NO+fv3ag09k=;
 b=PcjCffFFbRB42ZeNc66NnilgrzuTqa0x9S1oypgX5tGTzkH4Tkwd+Hqkrhlw3oUy6YJgvfKMZWr65MAtbBE+uPk31h4amCeVHHmcsR8kxktTGISm3r2+EViOvkDkEjE5T4GgTisjjTTL9VJ26RG79a8M9WAzNh59TaEhgFjECm+InKDjxqbpLKk+/XfvQOWIpGESckOFoVPHU4msbjbB4yD1Zk1UEIipje5vu0B64T7uPoRzkmSnxB/mL7QDzio+arYH8qDz3pZskzQQiWvQjtvLSIgoo2H+CPoznm2M9kMCUgOENjlMurOhZFgt+mItSy2A34Jxqjx6mCPW6HqFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xZ3ze/HKzOT7bWHVpfCim7Eopquwx+9NO+fv3ag09k=;
 b=paBGCrov4hiBkQVbioJbtKDM1j/Fk/JtyjgfuLTeB16KqM34AJFFfOgVdbs9Ea16kpwOWpFxwBRCgCQAL+ZPk5nG5vXOSghFGDX3t5DDxCryNd3jkei8qqKSmllIuvEpZGl5bfunT/CdARJL4eFo56gpLztR/lQkqbxJJQXjiEI=
Received: from DM6PR01CA0008.prod.exchangelabs.com (2603:10b6:5:296::13) by
 BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.24; Sat, 25 Nov
 2023 09:22:12 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::8e) by DM6PR01CA0008.outlook.office365.com
 (2603:10b6:5:296::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.24 via Frontend
 Transport; Sat, 25 Nov 2023 09:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Sat, 25 Nov 2023 09:22:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 25 Nov
 2023 03:22:05 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sat, 25 Nov 2023 03:21:59 -0600
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <sbinding@opensource.cirrus.com>, <lee@kernel.org>,
        <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <rf@opensource.cirrus.com>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <michal.simek@amd.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <git@amd.com>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v11 03/10] spi: Add multi-cs memories support in SPI core
Date:   Sat, 25 Nov 2023 14:51:30 +0530
Message-ID: <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|BL1PR12MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: fb05fe72-e656-47f7-cf90-08dbed980199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bs86rZLAAHhrGAcjth5cerKMBKcrrYUwgg/fT0pRB4DUZfwSS/vU8XN6pigNtBWOF5za1Dbl9SMpDRYLJ08tM3zOdJUqbOgrcQpEOaL+utVxMYgAs3JRP5GPkrAXfdOv75BhM545i8YARZEe6PoMH+CUk2g0aJ5Tka4QnU3rakWV/q1Dr/IqzDd25TOLpBZb5a59cGHI+3Hm/3pUlTIbITjtX2oOZUU/N/XW/ZSD+mu0w33m2DdQJpIzR8+HDqTmiSdqBVHbHEnLe4G+x0hvwjwRI18HEQA4u2Q0dPouY64vsY/ZnMX6LOgmHk/93Op3ahypEX+RglM9KIIqquqrOsOSt7QpTYRGbAQiZbuzlO3Rym7wRl02fMtyF6MrdI5zC1mU3kaZoM5jljLO39D/lsi+Pe/w+BSrayDhTGCU5HiMy6KCqNrG4fI8SKVf3rhAkrcygTTMFZb+krVa/X8pxz1KpSZj3lFdcFJpEvr7YTYBXsAhwDP7hguDBS9/d+NZdOKrn8Al0BoJEYhCceJoP6NT8blk/vIWo3i620heAZg76Q3G+InOP7qt9Cf5WkmmeIdoeTvATBQsmPiPATquwkY/Xwmk6g+156XdnqBFLFDkLCQ3KSvNqvw/I3ZrGc3/bkm43cOdUZHYuJh6MXqea7w+FjQqlJsFeexoBBlsh5yHjOgBPSe2/BVs0ta6Eryi85mtqwf0pd427mChsKfTyYq2zH7TMC0iNZ+MHKciSMiG4cZKut5BxNIFqF1/n4XqFshSI/Ywj2jIfnhpnRKGJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(40470700004)(46966006)(36840700001)(356005)(83380400001)(426003)(336012)(82740400003)(26005)(2616005)(8936002)(8676002)(4326008)(86362001)(40480700001)(1076003)(36860700001)(47076005)(81166007)(966005)(478600001)(40460700003)(6666004)(54906003)(70586007)(70206006)(316002)(110136005)(921008)(36756003)(41300700001)(2906002)(30864003)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 09:22:11.8226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb05fe72-e656-47f7-cf90-08dbed980199
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD-Xilinx GQSPI controller has two advanced mode that allows the
controller to consider two flashes as one single device.

One of these two mode is the parallel mode in which each byte of data is
stored in both devices, the even bits in the lower flash & the odd bits in
the upper flash. The byte split is automatically handled by the QSPI
controller.

The other mode is the stacked mode in which both the flashes share the
same SPI bus but each of the device contain half of the data. In this mode,
the controller does not follow CS requests but instead internally wires the
two CS levels with the value of the most significant address bit.

For supporting both these modes SPI core need to be updated for providing
multiple CS for a single SPI device.

For adding multi CS support the SPI device need to be aware of all the CS
values. So, the "chip_select" member in the spi_device structure is now an
array that holds all the CS values.

spi_device structure now has a "cs_index_mask" member. This acts as an
index to the chip_select array. If nth bit of spi->cs_index_mask is set
then the driver would assert spi->chip_select[n].

In parallel mode all the chip selects are asserted/de-asserted
simultaneously and each byte of data is stored in both devices, the even
bits in one, the odd bits in the other. The split is automatically handled
by the GQSPI controller. The GQSPI controller supports a maximum of two
flashes connected in parallel mode. A SPI_CONTROLLER_MULTI_CS flag bit is
added in the spi controller flags, through ctlr->flags the spi core
will make sure that the controller is capable of handling multiple chip
selects at once.

For supporting multiple CS via GPIO the cs_gpiod member of the spi_device
structure is now an array that holds the gpio descriptor for each
chipselect.

CS GPIO is not tested on our hardware, but it has been tested by @Stefan
https://lore.kernel.org/all/005001da1efc$619ad5a0$24d080e0$@opensource.cirrus.com/

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Tested-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/spi/spi.c       | 259 +++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h |  51 ++++++--
 2 files changed, 258 insertions(+), 52 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8ead7acb99f3..45b6898cf0ee 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -612,10 +612,21 @@ static int spi_dev_check(struct device *dev, void *data)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct spi_device *new_spi = data;
-
-	if (spi->controller == new_spi->controller &&
-	    spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi, 0))
-		return -EBUSY;
+	int idx, nw_idx;
+	u8 cs, cs_nw;
+
+	if (spi->controller == new_spi->controller) {
+		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+			cs = spi_get_chipselect(spi, idx);
+			for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
+				cs_nw = spi_get_chipselect(new_spi, nw_idx);
+				if (cs != 0xFF && cs_nw != 0xFF && cs == cs_nw) {
+					dev_err(dev, "chipselect %d already in use\n", cs_nw);
+					return -EBUSY;
+				}
+			}
+		}
+	}
 	return 0;
 }
 
@@ -629,13 +640,32 @@ static int __spi_add_device(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
-	int status;
+	int status, idx, nw_idx;
+	u8 cs, nw_cs;
+
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		/* Chipselects are numbered 0..max; validate. */
+		cs = spi_get_chipselect(spi, idx);
+		if (cs != 0xFF && cs >= ctlr->num_chipselect) {
+			dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, idx),
+				ctlr->num_chipselect);
+			return -EINVAL;
+		}
+	}
 
-	/* Chipselects are numbered 0..max; validate. */
-	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
-		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
-			ctlr->num_chipselect);
-		return -EINVAL;
+	/*
+	 * Make sure that multiple logical CS doesn't map to the same physical CS.
+	 * For example, spi->chip_select[0] != spi->chip_select[1] and so on.
+	 */
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		cs = spi_get_chipselect(spi, idx);
+		for (nw_idx = idx + 1; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
+			nw_cs = spi_get_chipselect(spi, nw_idx);
+			if (cs != 0xFF && nw_cs != 0xFF && cs == nw_cs) {
+				dev_err(dev, "chipselect %d already in use\n", nw_cs);
+				return -EBUSY;
+			}
+		}
 	}
 
 	/* Set the bus ID string */
@@ -647,11 +677,8 @@ static int __spi_add_device(struct spi_device *spi)
 	 * its configuration.
 	 */
 	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
-	if (status) {
-		dev_err(dev, "chipselect %d already in use\n",
-				spi_get_chipselect(spi, 0));
+	if (status)
 		return status;
-	}
 
 	/* Controller may unregister concurrently */
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) &&
@@ -659,8 +686,15 @@ static int __spi_add_device(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	if (ctlr->cs_gpiods)
-		spi_set_csgpiod(spi, 0, ctlr->cs_gpiods[spi_get_chipselect(spi, 0)]);
+	if (ctlr->cs_gpiods) {
+		u8 cs;
+
+		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+			cs = spi_get_chipselect(spi, idx);
+			if (cs != 0xFF)
+				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
+		}
+	}
 
 	/*
 	 * Drivers may modify this initial i/o setup, but will
@@ -701,6 +735,9 @@ int spi_add_device(struct spi_device *spi)
 	struct spi_controller *ctlr = spi->controller;
 	int status;
 
+	/* Set the bus ID string */
+	spi_dev_set_name(spi);
+
 	mutex_lock(&ctlr->add_lock);
 	status = __spi_add_device(spi);
 	mutex_unlock(&ctlr->add_lock);
@@ -727,6 +764,7 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 {
 	struct spi_device	*proxy;
 	int			status;
+	u8                      idx;
 
 	/*
 	 * NOTE:  caller did any chip->bus_num checks necessary.
@@ -742,6 +780,18 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 
 	WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
 
+	/*
+	 * Zero(0) is a valid physical CS value and can be located at any
+	 * logical CS in the spi->chip_select[]. If all the physical CS
+	 * are initialized to 0 then It would be difficult to differentiate
+	 * between a valid physical CS 0 & an unused logical CS whose physical
+	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
+	 * Now all the unused logical CS will have 0xFF physical CS value & can be
+	 * ignore while performing physical CS validity checks.
+	 */
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+		spi_set_chipselect(proxy, idx, 0xFF);
+
 	spi_set_chipselect(proxy, 0, chip->chip_select);
 	proxy->max_speed_hz = chip->max_speed_hz;
 	proxy->mode = chip->mode;
@@ -750,6 +800,15 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 	proxy->dev.platform_data = (void *) chip->platform_data;
 	proxy->controller_data = chip->controller_data;
 	proxy->controller_state = NULL;
+	/*
+	 * spi->chip_select[i] gives the corresponding physical CS for logical CS i
+	 * logical CS number is represented by setting the ith bit in spi->cs_index_mask
+	 * So, for example, if spi->cs_index_mask = 0x01 then logical CS number is 0 and
+	 * spi->chip_select[0] will give the physical CS.
+	 * By default spi->chip_select[0] will hold the physical CS number so, set
+	 * spi->cs_index_mask as 0x01.
+	 */
+	proxy->cs_index_mask = 0x01;
 
 	if (chip->swnode) {
 		status = device_add_software_node(&proxy->dev, chip->swnode);
@@ -942,32 +1001,51 @@ static void spi_res_release(struct spi_controller *ctlr, struct spi_message *mes
 }
 
 /*-------------------------------------------------------------------------*/
+static inline bool spi_is_last_cs(struct spi_device *spi)
+{
+	u8 idx;
+	bool last = false;
+
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		if ((spi->cs_index_mask >> idx) & 0x01) {
+			if (spi->controller->last_cs[idx] == spi_get_chipselect(spi, idx))
+				last = true;
+		}
+	}
+	return last;
+}
+
 
 static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 {
 	bool activate = enable;
+	u8 idx;
 
 	/*
 	 * Avoid calling into the driver (or doing delays) if the chip select
 	 * isn't actually changing from the last time this was called.
 	 */
-	if (!force && ((enable && spi->controller->last_cs == spi_get_chipselect(spi, 0)) ||
-		       (!enable && spi->controller->last_cs != spi_get_chipselect(spi, 0))) &&
+	if (!force && ((enable && spi->controller->last_cs_index_mask == spi->cs_index_mask &&
+			spi_is_last_cs(spi)) ||
+		       (!enable && spi->controller->last_cs_index_mask == spi->cs_index_mask &&
+			!spi_is_last_cs(spi))) &&
 	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
 		return;
 
 	trace_spi_set_cs(spi, activate);
 
-	spi->controller->last_cs = enable ? spi_get_chipselect(spi, 0) : -1;
+	spi->controller->last_cs_index_mask = spi->cs_index_mask;
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+		spi->controller->last_cs[idx] = enable ? spi_get_chipselect(spi, 0) : -1;
 	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 
-	if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) && !activate)
-		spi_delay_exec(&spi->cs_hold, NULL);
-
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
-	if (spi_get_csgpiod(spi, 0)) {
+	if (spi_is_csgpiod(spi)) {
+		if (!spi->controller->set_cs_timing && !activate)
+			spi_delay_exec(&spi->cs_hold, NULL);
+
 		if (!(spi->mode & SPI_NO_CS)) {
 			/*
 			 * Historically ACPI has no means of the GPIO polarity and
@@ -979,26 +1057,38 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 			 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
 			 * into account.
 			 */
-			if (has_acpi_companion(&spi->dev))
-				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
-			else
-				/* Polarity handled by GPIO library */
-				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
+			for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+				if (((spi->cs_index_mask >> idx) & 0x01) &&
+				    spi_get_csgpiod(spi, idx)) {
+					if (has_acpi_companion(&spi->dev))
+						gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
+									 !enable);
+					else
+						/* Polarity handled by GPIO library */
+						gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
+									 activate);
+
+					if (activate)
+						spi_delay_exec(&spi->cs_setup, NULL);
+					else
+						spi_delay_exec(&spi->cs_inactive, NULL);
+				}
+			}
 		}
 		/* Some SPI masters need both GPIO CS & slave_select */
 		if ((spi->controller->flags & SPI_CONTROLLER_GPIO_SS) &&
 		    spi->controller->set_cs)
 			spi->controller->set_cs(spi, !enable);
+
+		if (!spi->controller->set_cs_timing) {
+			if (activate)
+				spi_delay_exec(&spi->cs_setup, NULL);
+			else
+				spi_delay_exec(&spi->cs_inactive, NULL);
+		}
 	} else if (spi->controller->set_cs) {
 		spi->controller->set_cs(spi, !enable);
 	}
-
-	if (spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) {
-		if (activate)
-			spi_delay_exec(&spi->cs_setup, NULL);
-		else
-			spi_delay_exec(&spi->cs_inactive, NULL);
-	}
 }
 
 #ifdef CONFIG_HAS_DMA
@@ -2222,8 +2312,8 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
-	u32 value;
-	int rc;
+	u32 value, cs[SPI_CS_CNT_MAX];
+	int rc, idx;
 
 	/* Mode (clock phase/polarity/etc.) */
 	if (of_property_read_bool(nc, "spi-cpha"))
@@ -2295,14 +2385,53 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		return 0;
 	}
 
+	if (ctlr->num_chipselect > SPI_CS_CNT_MAX) {
+		dev_err(&ctlr->dev, "No. of CS is more than max. no. of supported CS\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Zero(0) is a valid physical CS value and can be located at any
+	 * logical CS in the spi->chip_select[]. If all the physical CS
+	 * are initialized to 0 then It would be difficult to differentiate
+	 * between a valid physical CS 0 & an unused logical CS whose physical
+	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
+	 * Now all the unused logical CS will have 0xFF physical CS value & can be
+	 * ignore while performing physical CS validity checks.
+	 */
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+		spi_set_chipselect(spi, idx, 0xFF);
+
 	/* Device address */
-	rc = of_property_read_u32(nc, "reg", &value);
-	if (rc) {
+	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
+						 SPI_CS_CNT_MAX);
+	if (rc < 0) {
 		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
 			nc, rc);
 		return rc;
 	}
-	spi_set_chipselect(spi, 0, value);
+	if (rc > ctlr->num_chipselect) {
+		dev_err(&ctlr->dev, "%pOF has number of CS > ctlr->num_chipselect (%d)\n",
+			nc, rc);
+		return rc;
+	}
+	if ((of_property_read_bool(nc, "parallel-memories")) &&
+	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
+		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
+		return -EINVAL;
+	}
+	for (idx = 0; idx < rc; idx++)
+		spi_set_chipselect(spi, idx, cs[idx]);
+
+	/*
+	 * spi->chip_select[i] gives the corresponding physical CS for logical CS i
+	 * logical CS number is represented by setting the ith bit in spi->cs_index_mask
+	 * So, for example, if spi->cs_index_mask = 0x01 then logical CS number is 0 and
+	 * spi->chip_select[0] will give the physical CS.
+	 * By default spi->chip_select[0] will hold the physical CS number so, set
+	 * spi->cs_index_mask as 0x01.
+	 */
+	spi->cs_index_mask = 0x01;
 
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
@@ -2408,6 +2537,7 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	struct spi_controller *ctlr = spi->controller;
 	struct spi_device *ancillary;
 	int rc = 0;
+	u8 idx;
 
 	/* Alloc an spi_device */
 	ancillary = spi_alloc_device(ctlr);
@@ -2418,12 +2548,33 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 
 	strscpy(ancillary->modalias, "dummy", sizeof(ancillary->modalias));
 
+	/*
+	 * Zero(0) is a valid physical CS value and can be located at any
+	 * logical CS in the spi->chip_select[]. If all the physical CS
+	 * are initialized to 0 then It would be difficult to differentiate
+	 * between a valid physical CS 0 & an unused logical CS whose physical
+	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
+	 * Now all the unused logical CS will have 0xFF physical CS value & can be
+	 * ignore while performing physical CS validity checks.
+	 */
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+		spi_set_chipselect(ancillary, idx, 0xFF);
+
 	/* Use provided chip-select for ancillary device */
 	spi_set_chipselect(ancillary, 0, chip_select);
 
 	/* Take over SPI mode/speed from SPI main device */
 	ancillary->max_speed_hz = spi->max_speed_hz;
 	ancillary->mode = spi->mode;
+	/*
+	 * spi->chip_select[i] gives the corresponding physical CS for logical CS i
+	 * logical CS number is represented by setting the ith bit in spi->cs_index_mask
+	 * So, for example, if spi->cs_index_mask = 0x01 then logical CS number is 0 and
+	 * spi->chip_select[0] will give the physical CS.
+	 * By default spi->chip_select[0] will hold the physical CS number so, set
+	 * spi->cs_index_mask as 0x01.
+	 */
+	ancillary->cs_index_mask = 0x01;
 
 	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
 
@@ -2626,6 +2777,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	struct acpi_spi_lookup lookup = {};
 	struct spi_device *spi;
 	int ret;
+	u8 idx;
 
 	if (!ctlr && index == -1)
 		return ERR_PTR(-EINVAL);
@@ -2661,12 +2813,33 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	/*
+	 * Zero(0) is a valid physical CS value and can be located at any
+	 * logical CS in the spi->chip_select[]. If all the physical CS
+	 * are initialized to 0 then It would be difficult to differentiate
+	 * between a valid physical CS 0 & an unused logical CS whose physical
+	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
+	 * Now all the unused logical CS will have 0xFF physical CS value & can be
+	 * ignore while performing physical CS validity checks.
+	 */
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+		spi_set_chipselect(spi, idx, 0xFF);
+
 	ACPI_COMPANION_SET(&spi->dev, adev);
 	spi->max_speed_hz	= lookup.max_speed_hz;
 	spi->mode		|= lookup.mode;
 	spi->irq		= lookup.irq;
 	spi->bits_per_word	= lookup.bits_per_word;
 	spi_set_chipselect(spi, 0, lookup.chip_select);
+	/*
+	 * spi->chip_select[i] gives the corresponding physical CS for logical CS i
+	 * logical CS number is represented by setting the ith bit in spi->cs_index_mask
+	 * So, for example, if spi->cs_index_mask = 0x01 then logical CS number is 0 and
+	 * spi->chip_select[0] will give the physical CS.
+	 * By default spi->chip_select[0] will hold the physical CS number so, set
+	 * spi->cs_index_mask as 0x01.
+	 */
+	spi->cs_index_mask	= 0x01;
 
 	return spi;
 }
@@ -3100,6 +3273,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	struct boardinfo	*bi;
 	int			first_dynamic;
 	int			status;
+	int			idx;
 
 	if (!dev)
 		return -ENODEV;
@@ -3164,7 +3338,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 	}
 
 	/* Setting last_cs to -1 means no chip selected */
-	ctlr->last_cs = -1;
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+		ctlr->last_cs[idx] = -1;
 
 	status = device_add(&ctlr->dev);
 	if (status < 0)
@@ -3889,7 +4064,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 * cs_change is set for each transfer.
 	 */
 	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
-					  spi_get_csgpiod(spi, 0))) {
+					  spi_is_csgpiod(spi))) {
 		size_t maxsize = BITS_TO_BYTES(spi->bits_per_word);
 		int ret;
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7b4baff63c5c..871d3a6d879b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -20,6 +20,9 @@
 
 #include <uapi/linux/spi/spi.h>
 
+/* Max no. of CS supported per spi device */
+#define SPI_CS_CNT_MAX 4
+
 struct dma_chan;
 struct software_node;
 struct ptp_system_timestamp;
@@ -132,7 +135,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
- * @chip_select: Chipselect, distinguishing chips handled by @controller.
+ * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
+ *	the corresponding physical CS for logical CS i.
  * @mode: The spi mode defines how data is clocked out and in.
  *	This may be changed by the device's driver.
  *	The "active low" default for chipselect mode can be overridden
@@ -157,8 +161,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  *	the device will bind to the named driver and only the named driver.
  *	Do not set directly, because core frees it; use driver_set_override() to
  *	set or clear it.
- * @cs_gpiod: GPIO descriptor of the chipselect line (optional, NULL when
- *	not using a GPIO line)
+ * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
+ *	(optional, NULL when not using a GPIO line)
  * @word_delay: delay to be inserted between consecutive
  *	words of a transfer
  * @cs_setup: delay to be introduced by the controller after CS is asserted
@@ -167,6 +171,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
  *	two delays will be added up.
  * @pcpu_statistics: statistics for the spi_device
+ * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  *
  * A @spi_device is used to interchange data between an SPI slave
  * (usually a discrete chip) and CPU memory.
@@ -182,7 +187,7 @@ struct spi_device {
 	struct spi_controller	*controller;
 	struct spi_controller	*master;	/* Compatibility layer */
 	u32			max_speed_hz;
-	u8			chip_select;
+	u8			chip_select[SPI_CS_CNT_MAX];
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
@@ -213,7 +218,7 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
-	struct gpio_desc	*cs_gpiod;	/* Chip select GPIO descriptor */
+	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select gpio desc */
 	struct spi_delay	word_delay; /* Inter-word delay */
 	/* CS delays */
 	struct spi_delay	cs_setup;
@@ -223,6 +228,13 @@ struct spi_device {
 	/* The statistics */
 	struct spi_statistics __percpu	*pcpu_statistics;
 
+	/* Bit mask of the chipselect(s) that the driver need to use from
+	 * the chipselect array.When the controller is capable to handle
+	 * multiple chip selects & memories are connected in parallel
+	 * then more than one bit need to be set in cs_index_mask.
+	 */
+	u32			cs_index_mask : SPI_CS_CNT_MAX;
+
 	/*
 	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -279,22 +291,33 @@ static inline void *spi_get_drvdata(const struct spi_device *spi)
 
 static inline u8 spi_get_chipselect(const struct spi_device *spi, u8 idx)
 {
-	return spi->chip_select;
+	return spi->chip_select[idx];
 }
 
 static inline void spi_set_chipselect(struct spi_device *spi, u8 idx, u8 chipselect)
 {
-	spi->chip_select = chipselect;
+	spi->chip_select[idx] = chipselect;
 }
 
 static inline struct gpio_desc *spi_get_csgpiod(const struct spi_device *spi, u8 idx)
 {
-	return spi->cs_gpiod;
+	return spi->cs_gpiod[idx];
 }
 
 static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx, struct gpio_desc *csgpiod)
 {
-	spi->cs_gpiod = csgpiod;
+	spi->cs_gpiod[idx] = csgpiod;
+}
+
+static inline bool spi_is_csgpiod(struct spi_device *spi)
+{
+	u8 idx;
+
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		if (spi_get_csgpiod(spi, idx))
+			return true;
+	}
+	return false;
 }
 
 /**
@@ -399,6 +422,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for exclusion of multiple callers
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
+ * @multi_cs_cap: indicates that the SPI Controller can assert/de-assert
+ *	more than one chip select at once.
  * @setup: updates the device mode and clocking records used by a
  *	device's SPI controller; protocol code may call this.  This
  *	must fail if an unrecognized or unsupported mode is requested.
@@ -567,6 +592,11 @@ struct spi_controller {
 #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx */
 #define SPI_CONTROLLER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
 #define SPI_CONTROLLER_SUSPENDED	BIT(6)	/* Currently suspended */
+	/*
+	 * The spi-controller has multi chip select capability and can
+	 * assert/de-assert more than one chip select at once.
+	 */
+#define SPI_CONTROLLER_MULTI_CS		BIT(7)
 
 	/* Flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
@@ -677,7 +707,8 @@ struct spi_controller {
 	bool				rt;
 	bool				auto_runtime_pm;
 	bool				cur_msg_mapped;
-	char				last_cs;
+	char				last_cs[SPI_CS_CNT_MAX];
+	char				last_cs_index_mask;
 	bool				last_cs_mode_high;
 	bool                            fallback;
 	struct completion               xfer_completion;
-- 
2.17.1

