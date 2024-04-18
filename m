Return-Path: <linux-kernel+bounces-149612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4A28A9377
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB0B1C20CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3C121103;
	Thu, 18 Apr 2024 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kvCwUMDb"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19011002.outbound.protection.outlook.com [52.103.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A802D057;
	Thu, 18 Apr 2024 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422764; cv=fail; b=rJLG/ab9fMoRd72MPsfV2K0i0KWWqLDTtgMJybAcQetcLBAZwqUODkEU63K87fChSSlqNlu04oHSL9TqOtfdKzRjD7eHwmar4yfXk2I5n1qeoNmWK0Dibo3zcH+KhJLDnew7RCrDcq/bsNKwT6BNLIQ+gnh1IixquBUeuN0PWas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422764; c=relaxed/simple;
	bh=vYxOV0wOMa+vYj3ZwetKI0ywFYi7hhRLEUXGISHaEhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CFIx1JteMwe+n4ki8dWWlr8kdqp5JtAfP+EDtll+XpSbEsebyOvdLvLB1Sg5lsjkvxGWhDes11J02Ovev9pZNXnCWgDBlc3HjP5GbWIm1SzMMJeBtsDaSY0acOFUdwesjmhPQ+Mk6im6xVPyBIC9Rb94lX84FXqGOYFiNaS9ti4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kvCwUMDb; arc=fail smtp.client-ip=52.103.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4VFCnjYfPnxw2NXRJm6suxlN7SqQJTKm8yo3Q1fpmBxtn7C4JAXdx1mFL5CZHUilyiFXBLhDqxfg7K/UhYjjCqx3X+CHsRk8REItBnKedPhJFztzAFNBWR3wJMJCXrxwGDRm9tp6IXifvg1crXNWZ0fyxZ2kf+LXksHUgJryclhoSAAbdV/zf/z1V3s+CvU0jjWRfYW9O+bN13vv1JFQSunZSkhVGQF4anUJcltrxNs0eiFwXvCQmD/48kD8av1DRII2mR56hayjWzX64kPc6X6w8VxxpuKH+3XHOerMwOOORP1li/HSkDyBLgfJxY2Og3MNQgxldBfYfCltUNpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b0BKBkpWpEgLf46H2ZiN45feDj7+6AF1xyN8VgC9aE=;
 b=O5wRg+zlASyahJTbsg3Cntklhtua0ixQofsq+IQY/bvU4TS5Y4gW6/GB7+072UqxcyxJ9+K8JoQwDs8wIYLQMysw51ugrVPpm3c23OuN+EH1rBUTEFvsYwcqrvEUFlgBFOwhfSAfUtoj0ygDUK9ULvGfdSRuveMIGGCx3Fy07jbeFY7m4+dm8qhlaojeKGZDK1VOo4K3iUIdRQ8PEw2DP6CjKI3o+zxieyRhOpgDWJI1mVzUmu1GG/AG0a3afEnO+9DmJLIj4vctfwyWGz0cqA2HaluJeplLXJ1sK8zu7QhPyf+fn1eqk/bdibX1ecG8GwNGkOYflVj55Fpmm6hG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b0BKBkpWpEgLf46H2ZiN45feDj7+6AF1xyN8VgC9aE=;
 b=kvCwUMDb2BLuHN0/8Ad/8xxtg993nd20w6xDpEyWhSamNqvy5R/bGBAC7IxEmItzcuVr3okW/rbd32lXnebbLtdzmINSlR32UPchOSwdHKjRbT81zQSCfQTRZVT66O5uoSNI/lZcqWH+QNnt3W6TFwxFaPZeComXHLlzMwWuYuDxJjueN9HKrpSm8eYcGktd/I6lJkugGqHuE9wda6ZzCJdMvG+XJHI37unsXcrRdU6K/P3Q8Od+ybjbaeU2XWGyTNV/IWO2BfafWTmwGnIYByBXmCsiy8z7/ddh8WlGRC3oUnVU4J1CBMvnVGsVyt2MLfS+68PcMnd8igjkUT/Z2g==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by OS3P286MB3372.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Thu, 18 Apr
 2024 06:45:59 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7452.050; Thu, 18 Apr 2024
 06:45:59 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com
Cc: patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ArcticLampyrid <ArcticLampyrid@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Thu, 18 Apr 2024 14:45:50 +0800
Message-ID:
 <TYCP286MB25358BF2246DE04CE8D12BE8C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZxYRBvbSVhl+wEq0q1DtED/LvmHEBklH5J6v/+JTyJEnOJg8azg0zg==]
X-ClientProxiedBy: PS2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:300:5c::24) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240418064550.13866-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|OS3P286MB3372:EE_
X-MS-Office365-Filtering-Correlation-Id: 338ba514-d49e-4a02-a9b1-08dc5f7334f6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L9SyoPRB9unc5TJqm9Rmj0TaUVBweSgVF1b2OCP0Q8wzsQnSmqfeo0T2XhZXFy0UnDz+kf3UhdaIcSrYQ8z9xoOZ9PJV16ArYvtHIRCPLIgGkyIGd9VZmKi3kQJnTAxE8WtkOHr8KCkTcGHpnvUMg/dEdDteQ+VyAyroV6J4ul3StHE4qPO0XQ2N7v1zw/ntgOICAomMIQs2s4tlPtxNS/Cbx2CHyNCRqzrB9zK94OhmJMyQlf0PilMx3hZgKKQFXx/0UGgUE30bzcEdZd6MjlHTeL5ZfVbOAOiZ5nsPUE5n/MTq+pCebdDMMnHAJtn5MeajNx6kvLzuqFcU1ZBC+KUfu+1WDckF1DkA0hF2OhXGsszbhrr0Av1LF+Px7cEc/EmZhqkUb8lLPQrvWi9rITACT20rO4HX5+FkoJbowkSV2fmT/blBQA51HlgRvYz9e1FfWyZH9vXPE+LfOhBrGScj64rNu5Dqv52Kd21iItU0WUGlXb/ztA7O3P0vf0b/EKBdtBUMQNQkjgcmm6Sz6NBFB/peiz/UUgYGVsAU3+86yb8yXDKzR+dikDKr+7ArsPLG9G5WoFp125ZNajF3A+di0sUvdoA3aIfwMStODq8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6eY9srxP6gkHvqQmkapRtAhdUTjTzeEobmn8jczhwONKDIG48IFf0+ON9ct5?=
 =?us-ascii?Q?X5/N/XuXVVtanY4gq9Lud7it06yBHkwOYpUPow+K46wUZL/MODQTUyY+y/Vd?=
 =?us-ascii?Q?uXc1RJkkP/yYxx8poDZCxG8ogHzJU2rawpWwqQHWsIohC0xeSwX3iKeA+9ES?=
 =?us-ascii?Q?hZgOIp5Nv6oRicVNnS+9PGljOKekxiynp8Gv9UzsKbdgvscGUz8yqou8ni6v?=
 =?us-ascii?Q?W6ltRhGfOZExTttd8bSZcSOcq8BMA56YFPbur+szBfVjDVetPrzUZBa0k2ra?=
 =?us-ascii?Q?76zhSouIQvf2nDbrhbl1QIiv72XCZwPJUxQtsHusCEJTQ8zZNqwnRkgIin9A?=
 =?us-ascii?Q?sjpOINgEzJI9Uc6bo/jmSoSsVAK3tGA/mVEQPR/6eSWSpXgSGjkN7aLURCU/?=
 =?us-ascii?Q?aj4rLuIyKnEoS91oo1CP7qqnAEjhJZqN2T/rBtLj9p2Vcfls/TwF/F05fmOj?=
 =?us-ascii?Q?n1cPCEd16DEaSxLTHizB+orH21fM2DTtmDnno/25Z9WpYlzc/hzefjUzw+AD?=
 =?us-ascii?Q?PlqwPRnvGyHWMBAFIB42Kroi9ptypy2Z7870yEs5QGcFpUxOw/LfETip7Ttw?=
 =?us-ascii?Q?O29e2e+6GTFemBVrNHXntiO58533KialZfUelHVhVqZrAl0uwAZrwk0h+PHP?=
 =?us-ascii?Q?CncDXzSJbjE3pUMPcI0TgponpsuZPXJ7/Du+KvjX9iE5nlhMOWfRhSx64hFv?=
 =?us-ascii?Q?xiis+rYH1dVTshZ+cnSHenwHUsIbhzfZMtNMrgXDjGb3eF26mW/JBvUNVhRv?=
 =?us-ascii?Q?BF9rQ1feV1X30w9bAACYNv0bfTr0KAzEhX0fmxe6XSlnnvomHIHT9TJRLsra?=
 =?us-ascii?Q?bDMcajroFHMVqtuSsZHDmUbOVqKZ9/lLy35V87tRiPGYw72cWQk5uhrsgA1O?=
 =?us-ascii?Q?sbM3AlewCvyAV9leO1SRdbubzDsxsbQFCumiFoW8c9Cwgvhaz5c3kaDuU16L?=
 =?us-ascii?Q?Zx3AzTRrlbTcjtwErGO+rxIOFM69tLpwPPSSLpQPLkgJ93QRvHjofqbP9LsK?=
 =?us-ascii?Q?khtq46jtBjThQb+rdrHTwwZDJ7bB8+z9DWQSEobnSeD5+AHDI9dWnyxUiNEE?=
 =?us-ascii?Q?UpXg4wd8wpK0v8wjGJbnxTpu3G39/LphRPbfeDHKy1fPS/nyCUS4jr3cBEBk?=
 =?us-ascii?Q?4AbmyVKFSTX5Qe8FvzbfwD6kDUWGDYoxzVb7lNKHf52FdzAt9J1elmM7rOyo?=
 =?us-ascii?Q?rL4E76SpgNdyQEVAR7W3949PpL5ddWqJnsL3LGuSNNC2F2+BctEYIHbx2lUD?=
 =?us-ascii?Q?CqS5LuSn9AEjHHM/OcOU7tADlX2doGDINgJ1EFTUqg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338ba514-d49e-4a02-a9b1-08dc5f7334f6
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 06:45:59.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3372

This fixes the sound not working from internal speakers on
Lenovo Legion Y9000X 2022 IAH7 models.

Signed-off-by: ArcticLampyrid <ArcticLampyrid@outlook.com>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 8fb688e41414..60ad2344488b 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -109,6 +109,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
@@ -500,6 +501,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
 	{ "CSC3551", "10433A60", generic_dsd_config },
+	{ "CSC3551", "17AA386E", generic_dsd_config },
 	{ "CSC3551", "17AA386F", generic_dsd_config },
 	{ "CSC3551", "17AA3877", generic_dsd_config },
 	{ "CSC3551", "17AA3878", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cdcb28aa9d7b..ac729187f6a7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10382,6 +10382,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x386e, "Legion Y9000X 2022 IAH7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion 7i 16IAX7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3877, "Lenovo Legion 7 Slim 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.44.0


