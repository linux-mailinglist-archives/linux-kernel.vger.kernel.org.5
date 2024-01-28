Return-Path: <linux-kernel+bounces-41581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FFD83F4E5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978E81C21033
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD641EB23;
	Sun, 28 Jan 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YA9PzAVo"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2046.outbound.protection.outlook.com [40.92.98.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E41EB20;
	Sun, 28 Jan 2024 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706436111; cv=fail; b=j4RR8p5Z+qtZTE3Mi+PcRTRDamLWIfmEtKQcMOOD8piAwz0WdAVO/Pp0vD1IWAPH5E7AHMmM2q+lKFd+5MVrmh0qfP4UyAUOIegls7N/9iybDyfydsTy9aYnrMh5tfvHlzdZyp1z/vnW/0onHdR5VzC7Jpj8WOvY1mCcnX/kSe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706436111; c=relaxed/simple;
	bh=z3spAF+PQxFsCVAuZhwakqLgcOnzooFDaSmpIJZkshY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fQkovd4wIE6p/USAoREcRCHPCIMUl09upggGNRsrJHpx+Wu0V7/Ei0y6F0RTS6W0kpvcU84oQe+z/zSmQHUgZkdMrHDlhbXZWFwCHjqcUiCN8ov6vaKig4mXf7ePXYuV7fYnGZTffQhvhTV1Ao/JyTT2w20FHEWX6ngxNBzTJn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YA9PzAVo; arc=fail smtp.client-ip=40.92.98.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA4A5gw9KrbYzFPY2fZ1APtMHgLHOwZiaOOVz1wwtgERK380uZ5oe/beRVUchpBcGq5R1Wraaz3WaYqdL9xlbqC+026ZdMy0QIzcTDza75xwolp4onjeNoI7fBN1B/vA983ku3FwTAx+oX2GplmqySLvp5vH1t2jS9PccUNWU4C3ToAtmiksJKiMsDoFqex9UXIWgZnSb6BngofI36gyPxiq6VKWMegFZPMZjLgPE3EipUXu/0Hs8ptlE+ITWNlLdOeG7B2ixfCgpPaYNhgQGlTP04C0Wrln0PdK8TZjLnprfx2eBwVdnhkG9Yj876KTmu/gHylqLEDiYIw/uilfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZFAQo0sjdfT4cFGp47r/H1laJc5Y9DoGtagaYl7+PY=;
 b=QrCfQxLWd/FNV3ZD4Tvgw3doOyclKsOnO4jq3g6lUmaHMhodS1dUsx5WFKcrAZYV6wKS+B2eoo08PyVcIqD8tWi4xk5rU8FocC8ap6+8eKoFU18+eUm3hlZGfMsbWGdqffybV0VVM4DO9anwRRi+J+OU00eokCncK8Z599UDNdvi/gsIiyJLSrM/nRm2Evd6hLGQFxLfNTV9wd667J3vVk0csITEodFD0jppE5MZ/zRdp+iSp29cGMgpJ4Orb/wCu8d331OhrnqqG4wOX3DmgBZrgL+XlgkCXSbtycsXi+NrZEo2YT/n67XNQXzyW+i9u3KNXbccwJR7cdLpNtQvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZFAQo0sjdfT4cFGp47r/H1laJc5Y9DoGtagaYl7+PY=;
 b=YA9PzAVooU7QPREOX3iIHZzY7lv/HwbWUYdHmPNEsfuSX5r9kE9CPwNL48fBYEiT/EV0ePiFjZ7S2ehx93+kV0viAtqKicW9072taGSVXRfGh6Z6VdM+HlM/Ox8NRVghQtHSqdHBvutrEGO4tEvp8gwdqTS2wJ5AInZvK4FfXo43dT73eXdr8P2OuCRPp5V1+zsB6R61cni/rXbisNaKxU3Y8uQjKSVYsjIs5IJlJb15IXpGJnCLIdiIMxuVF8lds7HcDQGGga8Qfkd6NhqEWPsaHZEvfBslvywA4Z290yyJDlVTudNblDSe6f++9sTDqHBarnvB+TCF/YDkACkaqg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB3752.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:387::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 10:01:46 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6801:95d7:c963:398a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6801:95d7:c963:398a%5]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 10:01:46 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1] mmc: sdhci: fix max req size based on spec
Date: Sun, 28 Jan 2024 18:01:24 +0800
Message-ID:
 <TY3P286MB2611D07641D842BD373FD3A8987F2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ftzQvtm0wb4hPkNP5+V41qQ2tWgoaZWU]
X-ClientProxiedBy: PS2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::34) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20240128100124.26580-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB3752:EE_
X-MS-Office365-Filtering-Correlation-Id: 3572f333-31b3-4f5a-cb58-08dc1fe82263
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TXOAxgVI9WtIsHYikXCaCLJdCUgBnRz6+QumULzUxOyX5DOmlmpEVguBgOISQxIxL/He2UZELLKQIHDNqc5lRfjFC8A9UjV08V1g9B1TZxOilyehW6ZECxcT/MtbLKxgk7aCZchS3Ofo2fIDsZWoaB/ULuPwzG/7K/K4dfJTnvjttjM5TI4y6gEJ0grIiRl5EC3LO+PmJdBaBPxjI4cEc/GLLpVhglzefO/QvJTX0JS4JoVh34SbLLYuKO8vuYbs629KsZ5t2SNakt0HTV38rYv4afEdmfsOlRM4wcMip9LwJiMfWjG+6WS4SRdnGIiFC44WsChe3HBTiPM8vn9ohYaxAGJ7dYHYt2FGMPKAPF2a5nqZ6JnV9KeQYIb4GLLEHXRMaeJu5FacJGlfFYTDpA34JU8LXyeaqOWwbGhZJrgEfhakC20/cuZ6VbP4mYAOKpKF0/L2W2VZ6jZpBVhnJCcVHgM6K3Q0Lnf67CfXJvSfSM8yjZOFM8oQ0b3dK7bVxyI607ePggjVOFUJzFYqBuDyyfFmfcWVe6d481nYxxf1RCBQBUN3d5Bh2kmSAU7FPOwq4FrjKN+PIt8FcwKyzLhC10p+FnPlC6iwyhgb0xlm09jNMqh6pctjiiUi5xaU5TMcg7gScBKd2s7T/8p4fKuaAD/0xpMPKBxUAbbRqgpvyvHvKzCUL7llZAVu7DaZAoFQOhO/ghnB2BQtRhxVVy03nwE1fJFI0zIk7TvD16N9xcEDxbqKebehrPaZKCpsCmsVwgexwubYz959A5Y9X36txEkJ/Ds2cA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ia2eAEmheZyBh5Y+9sj+4gLswNx+014c8nJVX1oBFHeSANeiT8LsUhTp6gmVH/Zg40HD7Lwh6GyKqZcH2/ojHbZkKOijNIQt/gxIS9FqB3alqX+2K0sH/TvuOh+kllfaOsvOeRjSMlD1lfJq4KGqF7nRTT0bpOyjOnvBOsNW65+KlHrzrT5FgxgbijlZx+/hHvq9siPmGOlfwn52SKO9XhCMtbiINp/Yyu5SYAGKUUDqXEk/UXdtzpkfPUUkC45DNHxDEVmSq6kMsvye4NbmrZk57QU97hmN6dIcIPjiGDV23itanjNvGjUXdQFGPi5bNGKkRdw1nfnXIQXFPV8MMiCMn82JlLBhegr3VTEqTqH4Jkt2D/n8fcnOI/ffr39wMEobd7hQz3vHGsRs0gOqcl/U0XdsrqYlusudEC8FMq/jR7paahCRAiDC2i2QCn1PkX60CD7Jr+2/sGKW0HTpdU1OQYmN1cPumQJOAqwIwvgTYejZRxR/qrzDjq8oBtWl88S0c/vE7nYBvegTr5IQh7Hid4vFog3niUQ0CHq1wOrZzNm2hWfn5GBpuNnkpDDig17OI+8x3egIUpV83hkI+fvzkHtGe44jrp0DCoxx/6aWuEFjb5rumyi4jt98lSAqJ/AgMYyUHXuj/lLb9AVNBIBZF0eVQ1hm3Wm2kzP/xWY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S7Oy73AwJIw+k9//TGkJfUsApJ9kEmDTLpiZomnZQMW26vNyNmzoIcuZxUvX?=
 =?us-ascii?Q?pyjf2FWEKagp1vX7lVRdlL/otsnqxzC9j3/L3rNvyW5AeGC2H+5FaIBkcHkA?=
 =?us-ascii?Q?aRW/3wKjPgm+GEDzQzZLBdHcJNkGw6wL9E+HU7n35lj3SS0rdUsT2MxDxNMU?=
 =?us-ascii?Q?remO60vTFzUnTrd9CSC9jjiKwWBwT2zETZPDZ8gtbY/e/obqc8IaYuOF7OgW?=
 =?us-ascii?Q?4nwZngkRs+5Jc4NjcsFzO0y+pXac1NPTAYTnPR3NlbZrQCvPp1SfXC8/ri5W?=
 =?us-ascii?Q?JNyUZZznl2PkPiMJOF9tqL7yscQu+OWF3IdmKxCXyuJuAC930AiFyPXn3CPE?=
 =?us-ascii?Q?Lor23+ZJSyzK6i0cs4Y1fphuKA6HEzvu8nItxOLn5ckjCa7MCslG8sBlOQ0w?=
 =?us-ascii?Q?SAppTKit7XfOj4KKTfOho/UVjySgWdaRLkezQJWb665AeD5naN8xxmGFMBIH?=
 =?us-ascii?Q?hjHi89qOflwGedpaoxPHbHStqM8GkwlIGzzczhqhYtzcQm8C9n+gbBe4VF7W?=
 =?us-ascii?Q?mNANyjfyctBObMelTdYAjvNofS1YSbkS5bY5hR6npP3gdPcWK9FLDhYpyafG?=
 =?us-ascii?Q?BRMX5yKCtGm9oxkV+uSVHwIfi530lyaJhfbwM0zvM5ts/5cQ5UNaAxIlc5Gi?=
 =?us-ascii?Q?4RaHGufDUhlotp5mOJ6rVnOxDMWAqYLsMcUich/t+J/psLhigoWdiulMO6fr?=
 =?us-ascii?Q?2eICW4LN/PPW67NIb5Y8a09lqJHugC6te1cCUAYYLzIApyb34O8noOZ1kZHv?=
 =?us-ascii?Q?u7Uz4ZLQzTxDxa4rP0HM5dzYzgQC0sUgbaYUJtNVeBCFtdKfTqqdwoZxRHab?=
 =?us-ascii?Q?IiZeIwGrpfbbkCKX+XD1sJyovfSY2XUDGvuLITFlcRBMg58HgR8muVUmrc4C?=
 =?us-ascii?Q?444B/fidS5EgvVSGsRwYjFjSrQzx5S2ZKLDnFneInaWqFYGapizvEJZ5Mc5c?=
 =?us-ascii?Q?nuEqxVpOtGXY89Eu2p3yrWJ1j/MinetOyDd670z/bblC0fh/vYiVb4z48b9G?=
 =?us-ascii?Q?IZti9QXslwgJNAs2YRVna6XlV85RIIkPXsWWcZsK65HUVHx6wwj2l6F+kmaY?=
 =?us-ascii?Q?pj6aaIFYrylDhna09JUWKkjwMmi2QT4dJKpyyW+FPqCJFOAwZYrb8n/aa7DK?=
 =?us-ascii?Q?QdyiSa/QipOjthM2B1DflQ8TQK63o/bo8TXtBsJ99qc7CmkeZqm3+DEePqs8?=
 =?us-ascii?Q?bqEeZY5ismHswUNl4s/izOYuRv+/IPmJVIocWjSqxJ/6rkpN4g1Y5++Riw0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3572f333-31b3-4f5a-cb58-08dc1fe82263
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 10:01:45.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3752

For almost 2 decades, the max allowed requests were limited to 512KB
because of SDMA's max 512KiB boundary limit.

ADMA2 and ADMA3 do not have such limit and were effectively made so any
kind of block count would not impose interrupt and managing stress to the
host.

By limiting that to 512KiB, it effectively downgrades these DMA modes to
SDMA.

Fix that by actually following the spec:
When ADMA is selected tuning mode is advised. On lesser modes, 4MiB
transfer is selected as max, so re-tuning if timer trigger or if requested
by host interrupt, can be done in time. Otherwise, the only limit is the
variable size of types used. In this implementation, 16MiB is used as
maximum since tests showed that after that point, there are diminishing
returns.

Also 16MiB in worst case scenarios, when card is eMMC and its max speed is
a generous 350MiB/s, will generate interrupts every 45ms on huge data
transfers.

A new `adma_get_req_limit` sdhci host function was also introduced, to let
vendors override imposed limits by the generic implementation if needed.

For example, on local tests with rigorous CPU/GPU burn-in tests and abrupt
cut-offs to generate huge temperature changes (upwards/downwards) to the
card, tested host was fine up to 128MB/s transfers on slow cards that used
SDR104 bus timing without re-tuning.
In that case the 4MiB limit was overridden with a more than safe 8MiB
value.

In all testing cases and boards, that change brought the following:

Depending on bus timing and eMMC/SD specs:
* Max Read throughput increased by 2-20%
* Max Write throughput increased by 50-200%
Depending on CPU frequency and transfer sizes:
* Reduced mmcqd cpu core usage by 4-50%

Above commit message comes from original author whose id is CTCaer, with
SoB email address ctcaer@gmail.com. I tried to contact with the author 1
month ago to ask for sending it to mainline or get the authority to submit
by myself, but I didn't get any reply, so I decided to send this patch by
myself. Original commit is here[1].

The author also has a patch[2] applied after this patch, which overrides
adma size on tegra device from device tree property. But I don't have a
tegra device to actually test that, so it is not sent, and
adma_get_req_limit part is not included in this version of patch.

[1]: https://github.com/CTCaer/switch-l4t-kernel-4.9/commit/fa86ebbd56d30b3b6af26e1d1c3f9c411a47e98e
[2]: https://github.com/CTCaer/switch-l4t-kernel-4.9/commit/385f9335b9a60ce471ac3291f202b1326212be3e

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/mmc/host/sdhci.c | 17 ++++++++++++-----
 drivers/mmc/host/sdhci.h |  4 ++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c79f73459915..f546b675c7b9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1081,7 +1081,7 @@ static void sdhci_initialize_data(struct sdhci_host *host,
 	WARN_ON(host->data);
 
 	/* Sanity checks */
-	BUG_ON(data->blksz * data->blocks > 524288);
+	BUG_ON(data->blksz * data->blocks > host->mmc->max_req_size);
 	BUG_ON(data->blksz > host->mmc->max_blk_size);
 	BUG_ON(data->blocks > 65535);
 
@@ -4690,11 +4690,18 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	/*
 	 * Maximum number of sectors in one transfer. Limited by SDMA boundary
-	 * size (512KiB). Note some tuning modes impose a 4MiB limit, but this
-	 * is less anyway.
+	 * size and by tuning modes on ADMA. On tuning mode 3 16MiB is more than
+	 * enough to cover big data transfers.
 	 */
-	mmc->max_req_size = 524288;
-
+	if (host->flags & SDHCI_USE_ADMA) {
+		if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+			mmc->max_req_size = SZ_4M;
+		else
+			mmc->max_req_size = SZ_16M;
+	} else {
+		/* On PIO/SDMA use SDMA boundary size (512KiB). */
+		mmc->max_req_size = SZ_512K;
+	}
 	/*
 	 * Maximum number of segments. Depends on if the hardware
 	 * can do scatter/gather or not.
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a20864fc0641..98252c427feb 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -346,11 +346,11 @@ struct sdhci_adma2_64_desc {
 #define ADMA2_END		0x2
 
 /*
- * Maximum segments assuming a 512KiB maximum requisition size and a minimum
+ * Maximum segments assuming a 16MiB maximum requisition size and a minimum
  * 4KiB page size. Note this also allows enough for multiple descriptors in
  * case of PAGE_SIZE >= 64KiB.
  */
-#define SDHCI_MAX_SEGS		128
+#define SDHCI_MAX_SEGS		4096
 
 /* Allow for a command request and a data request at the same time */
 #define SDHCI_MAX_MRQS		2
-- 
2.39.2


