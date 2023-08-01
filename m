Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D2776BF18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHAVT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHAVT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:19:27 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C57C3;
        Tue,  1 Aug 2023 14:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLN0DLrb1onYuhjcyhHi0SamU8SBni4/JPJd+xIFJoiG/orHMUc47kjAvI7ecinW8MHTowwDAmVgXu2jS0BiKuhUvk3CuFIeRs5rdm9U1MgL0HnhFwn3LUE50Sgw/NKoZceWZ2H8ExJUzL4jD84lkGLOLGxe0vbyo2yKf9FgW6602gwyb87fjJTp5NZTnRYXO0FklkiYH9QeptaKGqF5HHZcFWu7bjm5Jg60iGMVqEqRQmRcJXb6GRuhpSoh/WGknbQ3kZdXLFjx6g1OUVGg1pJA7jPpSXhYSjJApDBsfQ/r6BHNaA1waCADkh5t9ZMobbilzpl5StJL1hTX+D7e4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaWDRNrAWfsW0CokocC8UKEun48PjeJTGeNdqamljbQ=;
 b=iQgKSn111XcVPQ5xUyLM+4rbGWJgghTzYALxEIEcZr/yhd6HFQ3YlkTgRK1lj5BveL/8BTegJqXS6KUDhz4AqxgnxwSwfqJTfTYm+c3DI0awjvcLCdSe8o5ApSJszWRvM24Yp6V/QCg4SdEsbBRpFlybJYSJUhgFawBwGhm1S8+uy7ggDXPPyD6Awuz2StZrEJLuC36Qm3yq4Hrg0rTh2UTokiZfpZIzlRP1y6NPjGwLA8a+Uhc2CwTeolJVXPaPsmelLXrv35FGmnG3rGlBvK4NtnhwO5vGSEnPP4utGmr1P7Jhj0fJQIv9xZdWLkzbiwmA47pRI1vQ6lBy3dRL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaWDRNrAWfsW0CokocC8UKEun48PjeJTGeNdqamljbQ=;
 b=gKD7YkkGsNmlUI+FxyEaGcRg6/8/Mn0afeb6cUVW0UPJegdTcUGMTk+sU1Slp7/AkNvIpEymPJeEdt+zQ9q+EtbUv277PyJWOgLNtsO9Q2xrv9YrYBEAzrsK+7o61r/Oy2ynoaGn2zHgwva19jEL+LiBVtqKkBpevJm9Ka19GZw=
Received: from DM6PR08CA0037.namprd08.prod.outlook.com (2603:10b6:5:1e0::11)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 21:19:23 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::13) by DM6PR08CA0037.outlook.office365.com
 (2603:10b6:5:1e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 21:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.44 via Frontend Transport; Tue, 1 Aug 2023 21:19:22 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 16:19:08 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <jarkko@kernel.org>, <peterhuewe@gmx.de>
CC:     <jgg@ziepe.ca>, <linux@dominikbrodowski.net>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>, <daniil.stas@posteo.net>,
        <bitlord0xff@gmail.com>
Subject: [PATCH] tpm: Disable RNG for all AMD fTPMs
Date:   Tue, 1 Aug 2023 16:18:37 -0500
Message-ID: <20230801211837.30226-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: d9502ab9-5c9c-44ef-61ae-08db92d4fa06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50s+Jo62fxgjxIzTy37SmhSvqhhbr/tzyGfPX1jZ46isjoFLsU1k+p/G0ANoiCyoyEi6LBcpsu7uwTl3iW4TOIIo88F4fMb6HipO5IUQjTrSAzQM7BNLTE52gzBh9usEjjSXpXxmg4AZEF2qW5UXAlc93BtUdjVuPy/JevPjmFgFtL/TxTwJhthXwNzUrTptVHYwts76c8SH4jsvIGntAUgCsiQB87xw2XgxDPUSCZl88g3kbFncL9QG722TwYRYagiQ5UgY236JPBqz8vlIFWuph7mYpYUoocMgX32RaLM4RrkdROSziK9pX6aM1/dEy/pCX4sV34Bl0v++wgE3wynwfMu6HBKW6L5VfJd+RhaH75LcFVS+745/RNEPDHHs4mKMGHq+EsTb2eaucOKzm8StsCPTim00w5oZzaE8SKE/GahiVcCUXuTk5+pEbvElfAnNCny+AgfWRoxHaprh9S0ZlTGmuwnBRS1HtAZbrX03g/rYtS0mNYoLjH2vVRAtNzMxx5s8PmBl6k5NiMhg68EAYL3CGIsxTWBbdIn+K1WTrGvItbJwWNTyu+dPWWRSqPPyXGIhSozqxE0a9/TNXLt2aMTRuaNSBa+udxN438AOf9ave6VZIgMUNZuHfg4F2eu6t/h5Q2hrvzewuJD0mv06eacsTOSlE+I7ox4qelp+WZ0G1g0K7B9x7mIgUpG/+r0ZhRXUiMo5/49NvwXz684zddiXYTra7FwK7qVyZ3gupxJZo+1S2/EdklwA9dL6/2Eanp45uDpgQckJZfMlyX90w+ExknkUtVJTSmHwzghf3pfNry0aDxTHI25GQWuyVDA5ne8yMRioCw2KgHC67g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(86362001)(316002)(8936002)(8676002)(5660300002)(4326008)(41300700001)(356005)(54906003)(7416002)(70206006)(70586007)(110136005)(82740400003)(81166007)(478600001)(2906002)(6666004)(47076005)(36756003)(36860700001)(966005)(44832011)(7696005)(336012)(26005)(1076003)(83380400001)(426003)(186003)(16526019)(2616005)(40480700001)(40460700003)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 21:19:22.7720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9502ab9-5c9c-44ef-61ae-08db92d4fa06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPM RNG functionality is not necessary for entropy when the CPU
already supports the RDRAND instruction. The TPM RNG functionality
was previously disabled on a subset of AMD fTPM series, but reports
continue to show problems on some systems causing stutter root caused
to TPM RNG functionality.

Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
that claim to have fixed or not. To accomplish this, move the detection
into part of the TPM CRB registration and add a flag indicating that
the TPM should opt-out of registration to hwrng.

Cc: stable@vger.kernel.org # 6.1.y+
Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
Reported-by: daniil.stas@posteo.net
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
Reported-by: bitlord0xff@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/char/tpm/tpm-chip.c | 80 +++++++------------------------------
 drivers/char/tpm/tpm_crb.c  | 23 +++++++++++
 include/linux/tpm.h         |  7 ++++
 3 files changed, 44 insertions(+), 66 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index cf5499e51999b..3154a5ef2611f 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -89,6 +89,14 @@ static void tpm_clk_disable(struct tpm_chip *chip)
 		chip->ops->clk_enable(chip, false);
 }
 
+static int tpm_check_flags(struct tpm_chip *chip)
+{
+	if (!chip->ops->check_flags)
+		return 0;
+
+	return chip->ops->check_flags(chip);
+}
+
 /**
  * tpm_chip_start() - power on the TPM
  * @chip:	a TPM chip to use
@@ -510,70 +518,6 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
 	return 0;
 }
 
-/*
- * Some AMD fTPM versions may cause stutter
- * https://www.amd.com/en/support/kb/faq/pa-410
- *
- * Fixes are available in two series of fTPM firmware:
- * 6.x.y.z series: 6.0.18.6 +
- * 3.x.y.z series: 3.57.y.5 +
- */
-#ifdef CONFIG_X86
-static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
-{
-	u32 val1, val2;
-	u64 version;
-	int ret;
-
-	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
-		return false;
-
-	ret = tpm_request_locality(chip);
-	if (ret)
-		return false;
-
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val1, NULL);
-	if (ret)
-		goto release;
-	if (val1 != 0x414D4400U /* AMD */) {
-		ret = -ENODEV;
-		goto release;
-	}
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_1, &val1, NULL);
-	if (ret)
-		goto release;
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_2, &val2, NULL);
-
-release:
-	tpm_relinquish_locality(chip);
-
-	if (ret)
-		return false;
-
-	version = ((u64)val1 << 32) | val2;
-	if ((version >> 48) == 6) {
-		if (version >= 0x0006000000180006ULL)
-			return false;
-	} else if ((version >> 48) == 3) {
-		if (version >= 0x0003005700000005ULL)
-			return false;
-	} else {
-		return false;
-	}
-
-	dev_warn(&chip->dev,
-		 "AMD fTPM version 0x%llx causes system stutter; hwrng disabled\n",
-		 version);
-
-	return true;
-}
-#else
-static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
-{
-	return false;
-}
-#endif /* CONFIG_X86 */
-
 static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
@@ -588,7 +532,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
 	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
-	    tpm_amd_is_rng_defective(chip))
+	    tpm_is_rng_disabled(chip))
 		return 0;
 
 	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
@@ -670,6 +614,10 @@ int tpm_chip_register(struct tpm_chip *chip)
 	if (rc)
 		return rc;
 
+	rc = tpm_check_flags(chip);
+	if (rc)
+		return rc;
+
 	tpm_sysfs_add_device(chip);
 
 	tpm_bios_log_setup(chip);
@@ -719,7 +667,7 @@ void tpm_chip_unregister(struct tpm_chip *chip)
 {
 	tpm_del_legacy_sysfs(chip);
 	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
-	    !tpm_amd_is_rng_defective(chip))
+	    !tpm_is_rng_disabled(chip))
 		hwrng_unregister(&chip->hwrng);
 	tpm_bios_log_teardown(chip);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 1a5d09b185134..5614b68ef1905 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -463,6 +463,28 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
 	return (cancel & CRB_CANCEL_INVOKE) == CRB_CANCEL_INVOKE;
 }
 
+static int crb_check_flags(struct tpm_chip *chip)
+{
+	u32 val;
+	int ret;
+
+	ret = crb_request_locality(chip, 0);
+	if (ret)
+		return ret;
+
+	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
+	if (ret)
+		goto release;
+
+	if (val == 0x414D4400U /* AMD */)
+		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
+
+release:
+	crb_relinquish_locality(chip, 0);
+
+	return ret;
+}
+
 static const struct tpm_class_ops tpm_crb = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = crb_status,
@@ -476,6 +498,7 @@ static const struct tpm_class_ops tpm_crb = {
 	.relinquish_locality = crb_relinquish_locality,
 	.req_complete_mask = CRB_DRV_STS_COMPLETE,
 	.req_complete_val = CRB_DRV_STS_COMPLETE,
+	.check_flags = crb_check_flags,
 };
 
 static int crb_check_resource(struct acpi_resource *ares, void *data)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6a1e8f1572551..aeb84944b0ca4 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -82,6 +82,7 @@ struct tpm_class_ops {
 	int (*request_locality)(struct tpm_chip *chip, int loc);
 	int (*relinquish_locality)(struct tpm_chip *chip, int loc);
 	void (*clk_enable)(struct tpm_chip *chip, bool value);
+	int (*check_flags)(struct tpm_chip *chip);
 };
 
 #define TPM_NUM_EVENT_LOG_FILES		3
@@ -283,6 +284,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
 	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
+	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -417,6 +419,11 @@ static inline u32 tpm2_rc_value(u32 rc)
 	return (rc & BIT(7)) ? rc & 0xff : rc;
 }
 
+static inline bool tpm_is_rng_disabled(struct tpm_chip *chip)
+{
+	return chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED;
+}
+
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
-- 
2.34.1

