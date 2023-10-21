Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B877D1D9E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjJUOw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjJUOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:52:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC591D7C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC8nGSgsNeAnZMhVn6MVuZ+tSil2xet8Mc8yyZHnQyDQ5hhpAAF6BnEysuwIgc2C/SLiS1uVaTM+iQCWQroTKJbMtGMs9hETPFnhkaQkntgBwmvatB8dszWVB4IOoD82sVAcIPVoHYj+Bl6HCFDqucya+8D98wbTUmoewaMoFDWH/06N9zHt1avLMw3uXfM2GyD/Tps0ECB9eIA1WsmL1p2hI5xIBm+noMvsfFS07TK8/PFSj6Q67lgDV0Jq9nXIpW/h9P7dsAASY/AiVDc2Pa7Jte6U9nbGu1QaMzECiXPnL36ud1Qc9NJ1Yx+7MYXy8N9UjFu34V3jLsHHrTDF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h/y0H64UH3ieCAT4vktmaqn7AZKS+4IvoIzH5wPbb4=;
 b=K5XOb1mpqBekxGTcTta+bbGVnbXXG6jdL44A3SE/o27P0KmyRG6kVW3kqLffKpy2m6/Rblpflfu2bV1OTWJwvqiXFJyvlHhSTCdZhBo0JxSjLoyYWSVrCOQ+rHHWk21d6xTyzgk48uae4qRSE41oPBrf30nmIlXl6+95IOGdzr76d8FUgww0PWbLG2wJCuwhoFSGKZcLYrFa09Evr+t56mXGSem3rr/Jvc8J4v15OZXBHKN6rRUZqM0iLQASaNW5Ne6ec/3ov67rXZP9Yy0gMTjJ+2WGudJH7qr41y5QFNKY4jOBwQ6mbCbbI8eXdFU+2cFLwxt0PMoiSAnHukZroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h/y0H64UH3ieCAT4vktmaqn7AZKS+4IvoIzH5wPbb4=;
 b=t8VOTDZZnUBNzhq7Q6tN4e+WqrimpLZNV3bJL6QS/WaEDxyYUlp+Gi4Z+viN1uZaZi3Vcuy4dAJS1DT/uqRk+kQPbNRmHh49BnFuxmD5GXK+I0soFrSqBxIy0Ouro/gRDZiMFsR8s8qauCiticETtrUyfmIFubRA7n6pUCQyyNk=
Received: from DM6PR13CA0064.namprd13.prod.outlook.com (2603:10b6:5:134::41)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sat, 21 Oct
 2023 14:52:05 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:134:cafe::16) by DM6PR13CA0064.outlook.office365.com
 (2603:10b6:5:134::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Sat, 21 Oct 2023 14:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Sat, 21 Oct 2023 14:52:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:52:04 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 21 Oct 2023 09:51:59 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <venkataprasad.potturu@amd.com>, <arungopal.kondaveeti@amd.com>,
        <mastan.katragadda@amd.com>, <juan.martinez@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/13] ASoC: amd: acp: add code for scanning acp pdm controller
Date:   Sat, 21 Oct 2023 20:20:47 +0530
Message-ID: <20231021145110.478744-6-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a7c156-7fd0-4526-2407-08dbd2454b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5e49GLamlP4bbvIaYfbISnprH3Y7ZaSTsYAoAd1cDK5DLX85Ncdi2x3/0ObHZeus+Ko+kHOb14VIN4p+/diMHSunNtlK37X2zbJiY/L9JW9HOpN768ckeCShIjUqQ1fGv8i4GS8acfbdNgREogwXVnAIgRxmC+2lq/4Ew8eYPVWfYfODJ/i2iVbDk77vBIHdeKzuiCG3VTKoVmvPzrtceXK4B0Z19ckxmHZy3dt0oA73WUf/ISc+XLAzF0j55WyBB4S1Xxhq1AG5GGXSFfJOIyWpzmjlk9U2twVWROgZx2YmtJ53vZ4d3/u8AZwmoWeYITd8f7h/qxw9xzcbMdgJemBSDX4ricBDjZmxYJuMU2NpNsbDHP8Phkg5IqbEbVTmIohGwEb5OSNjcYm9uqcD4lgs4CNwB2N12Qbt3Ij9c6FmISqIoxxt7m7Ex/VZauVRLrBM0Wbggj6paGdknjyP8o1ps/2299GvRugO22q8bQFJ0wq2mYzbuU3T8I0XA2FaE7vIXHDK5N/6MJUWu6M79vRuAq1Xbes5Jmn4rvc2hxGVC4YGWPfYxBa7a3Sqz3I/s3jixX6CCrMVCGSm53eF1D0yfeRzN/5GUxIZHYvCZ/6VXtJBGpqtvyVNMZ1XhqN+KXUoWdzRvTuDZbxFFTC33uBdmIXNtN+eDf0lWN5QHAU3Z3HXIYAPhl5lN97GBDntYAettt/Y+AqQALU2JcUZfSLUslsoWGFFDD7pdOlnnyQWR9C2tYEMV0famcTwdssUqCI1MLsqO55XD/Eru4RIrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(47076005)(336012)(1076003)(426003)(26005)(2616005)(7696005)(6666004)(356005)(86362001)(36756003)(82740400003)(81166007)(40460700003)(41300700001)(4326008)(8936002)(8676002)(478600001)(5660300002)(40480700001)(2906002)(70206006)(54906003)(110136005)(70586007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 14:52:05.5480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a7c156-7fd0-4526-2407-08dbd2454b05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common code for scanning acp pdm controller and create
platform device for the same.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-legacy-common.c | 52 +++++++++++++++++++++++++++
 sound/soc/amd/acp/acp-pci.c           | 11 +++++-
 sound/soc/amd/acp/amd.h               | 22 ++++++++++++
 sound/soc/amd/acp/chip_offset_byte.h  |  1 +
 sound/soc/amd/mach-config.h           |  1 +
 5 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index e16ef94e6336..af85a153a770 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -16,6 +16,10 @@
 #include <linux/pci.h>
 #include <linux/export.h>
 
+#define ACP_RENOIR_PDM_ADDR	0x02
+#define ACP_REMBRANDT_PDM_ADDR	0x03
+#define ACP63_PDM_ADDR		0x02
+
 void acp_enable_interrupts(struct acp_dev_data *adata)
 {
 	struct acp_resource *rsrc = adata->rsrc;
@@ -348,4 +352,52 @@ int smn_read(struct pci_dev *dev, u32 smn_addr)
 }
 EXPORT_SYMBOL_NS_GPL(smn_read, SND_SOC_ACP_COMMON);
 
+int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip)
+{
+	struct acpi_device *pdm_dev;
+	const union acpi_object *obj;
+	u32 pdm_addr, val;
+
+	val = readl(chip->base + ACP_PIN_CONFIG);
+	switch (val) {
+	case ACP_CONFIG_4:
+	case ACP_CONFIG_5:
+	case ACP_CONFIG_6:
+	case ACP_CONFIG_7:
+	case ACP_CONFIG_8:
+	case ACP_CONFIG_10:
+	case ACP_CONFIG_11:
+	case ACP_CONFIG_12:
+	case ACP_CONFIG_13:
+	case ACP_CONFIG_14:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (chip->acp_rev) {
+	case ACP3X_DEV:
+		pdm_addr = ACP_RENOIR_PDM_ADDR;
+		break;
+	case ACP6X_DEV:
+		pdm_addr = ACP_REMBRANDT_PDM_ADDR;
+		break;
+	case ACP63_DEV:
+		pdm_addr = ACP63_PDM_ADDR;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pdm_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), pdm_addr, 0);
+	if (pdm_dev) {
+		if (!acpi_dev_get_property(pdm_dev, "acp-audio-device-type",
+					   ACPI_TYPE_INTEGER, &obj) &&
+					   obj->integer.value == pdm_addr)
+			return 0;
+	}
+	return -ENODEV;
+}
+EXPORT_SYMBOL_NS_GPL(check_acp_pdm, SND_SOC_ACP_COMMON);
+
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index d7fc4a0e9245..bbf079d47dc4 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -55,7 +55,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 	int ret;
 
 	flag = snd_amd_acp_find_config(pci);
-	if (flag != FLAG_AMD_LEGACY)
+	if (flag != FLAG_AMD_LEGACY && flag != FLAG_AMD_LEGACY_ONLY_DMIC)
 		return -ENODEV;
 
 	chip = devm_kzalloc(&pci->dev, sizeof(*chip), GFP_KERNEL);
@@ -129,6 +129,13 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		}
 	}
 
+	if (flag == FLAG_AMD_LEGACY_ONLY_DMIC) {
+		ret = check_acp_pdm(pci, chip);
+		if (ret < 0)
+			goto skip_pdev_creation;
+	}
+
+	chip->flag = flag;
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 
 	pdevinfo.name = chip->name;
@@ -145,6 +152,8 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		ret = PTR_ERR(pdev);
 		goto unregister_dmic_dev;
 	}
+
+skip_pdev_creation:
 	chip->chip_pdev = pdev;
 	dev_set_drvdata(&pci->dev, chip);
 	pm_runtime_set_autosuspend_delay(&pci->dev, 2000);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 87d1e1f7d6b6..2ffe1effc6b5 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -133,6 +133,7 @@ struct acp_chip_info {
 	unsigned int acp_rev;	/* ACP Revision id */
 	void __iomem *base;	/* ACP memory PCI base */
 	struct platform_device *chip_pdev;
+	unsigned int flag;	/* Distinguish b/w Legacy or Only PDM */
 };
 
 struct acp_stream {
@@ -188,6 +189,25 @@ struct acp_dev_data {
 	u32 xfer_rx_resolution[3];
 };
 
+enum acp_config {
+	ACP_CONFIG_0 = 0,
+	ACP_CONFIG_1,
+	ACP_CONFIG_2,
+	ACP_CONFIG_3,
+	ACP_CONFIG_4,
+	ACP_CONFIG_5,
+	ACP_CONFIG_6,
+	ACP_CONFIG_7,
+	ACP_CONFIG_8,
+	ACP_CONFIG_9,
+	ACP_CONFIG_10,
+	ACP_CONFIG_11,
+	ACP_CONFIG_12,
+	ACP_CONFIG_13,
+	ACP_CONFIG_14,
+	ACP_CONFIG_15,
+};
+
 extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
 extern const struct snd_soc_dai_ops acp_dmic_dai_ops;
 
@@ -214,6 +234,8 @@ void restore_acp_pdm_params(struct snd_pcm_substream *substream,
 int restore_acp_i2s_params(struct snd_pcm_substream *substream,
 			   struct acp_dev_data *adata, struct acp_stream *stream);
 
+int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip);
+
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
 	u64 byte_count = 0, low = 0, high = 0;
diff --git a/sound/soc/amd/acp/chip_offset_byte.h b/sound/soc/amd/acp/chip_offset_byte.h
index ce3948e0679c..cfd6c4d07594 100644
--- a/sound/soc/amd/acp/chip_offset_byte.h
+++ b/sound/soc/amd/acp/chip_offset_byte.h
@@ -19,6 +19,7 @@
 #define ACP_PGFSM_STATUS                        0x1420
 #define ACP_SOFT_RESET                          0x1000
 #define ACP_CONTROL                             0x1004
+#define ACP_PIN_CONFIG				0x1440
 
 #define ACP_EXTERNAL_INTR_REG_ADDR(adata, offset, ctrl) \
 	(adata->acp_base + adata->rsrc->irq_reg_offset + offset + (ctrl * 0x04))
diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
index d392e6d6e6e1..e6b520459164 100644
--- a/sound/soc/amd/mach-config.h
+++ b/sound/soc/amd/mach-config.h
@@ -15,6 +15,7 @@
 #define FLAG_AMD_SOF			BIT(1)
 #define FLAG_AMD_SOF_ONLY_DMIC		BIT(2)
 #define FLAG_AMD_LEGACY			BIT(3)
+#define FLAG_AMD_LEGACY_ONLY_DMIC	BIT(4)
 
 #define ACP_PCI_DEV_ID			0x15E2
 
-- 
2.25.1

