Return-Path: <linux-kernel+bounces-102780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9950787B734
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66161C21A09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3B8F55;
	Thu, 14 Mar 2024 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RUxTg4Ni"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94D8BE5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710392691; cv=fail; b=mkV7LFpvtGcBrxaCheaVuUzZ7OQVIuNyMIVJYh1ev98GusgsPJwmvGmgZb/Kmhs4FJxWP8QGo/faSHONXBwMcONH4bjJTfgbM9BGTggUUDSf+AeIZp9uvo2DNLSym6hWQj3MGBuHDU+lBk40LbydWWXyUrZ2X2c+ryG44yTBiwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710392691; c=relaxed/simple;
	bh=ng9etKI8q/t8GNdQ4s0P2BQUkG7Jyy1clp653DVFu0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WUWv1vVp4Aaiou6b7lrWECVG7Tru65nELFM/Zlb2KC2TP86hIpCu3W0kP1rat7Sl1BR37BAMM7e/PGGlFMQwmVSNnQWAO2qGgPFBKI9KYIjLnYchvoqellme81VX+08755Y4jAKrXkUmfP0UBZUgKPGKim/ipaeufGDC0SNeAMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RUxTg4Ni; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtbFjhF9WLcxwmeTTnY2jhlG7ghF310zWUjUxDKuaFAkBtFMba6G8PliY7OscJMuXwy7dhvavmw5LfVncFtLKaz6qEBirAxYcNt8/ypwasbm82czS6XlRpHS6g5dmiP14veZQFzNe+z4+x36+v3GOcS1ns0UgIthoyySdHX6AkguZQPfes7mOt9TViMtbOJ72EdohR0Ytd+pEhJH1W6QNqNxLrOp5f9kLUx4DHc90AWJt6kYRcdq9XSAa93E8YjMsoaZ1/cc5uWsn4PZE4VssC1VLqT+tbRibh0Li+H5Tb1Dtz/f0jjoN8CPnt/GAIMQrkciHpScO8s5THK8igIynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAixHDUWueRI8CQPpL3MJhRveAd1200DYyEEQueONmU=;
 b=lFDCfudVGcd/riNPRsgprIaNxndxoWC/XNeY+ru7gDbtUVll+H4M4DTnwdxT1aYXIQDiR2Hc+kTf5k1gC3tl0ZjM2dnAwxWVfKzd2OWozOhmfzYKyMaxN45JCMNr/aBELgKgODTww2IGvoYO9vWhXIg6lZXzx1sz0N7pD2PkfzJDgMc9Y9EJ2zVSnHytpB9NAhh8WTXbv2jIWaak5+N6jLPJDj91WLNiOkiHDJa6hHPuxgS8THzdd4bwfUizQvkYMtK38OGr+u61Zf7MJmT5pHbP98safo8PWUzBYKEF4XUKR6ltfu2GxDEa6Ojw1HwCb3YbZyrQld2PNHCjGoRFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAixHDUWueRI8CQPpL3MJhRveAd1200DYyEEQueONmU=;
 b=RUxTg4NivlRD8qCAPwg1hi39/mA2+SKeLKdkY8L+zc1YV9dl3Jiys+WI6PnK0wBqQTVCbpzl9323pQJVNXSkBe1QV5WU0yuVcvMVvX67clSOV46d+Hamei5mtgGTI6XriqjS6fiv2h8HJUM2F4RDqYubb4z6JPPt7ma8gBFYMkk=
Received: from MW4PR03CA0081.namprd03.prod.outlook.com (2603:10b6:303:b6::26)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 05:04:46 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::a6) by MW4PR03CA0081.outlook.office365.com
 (2603:10b6:303:b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Thu, 14 Mar 2024 05:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 05:04:45 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 00:04:40 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	"Mario Limonciello" <mario.limonciello@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH] x86/cpu/topology: Add support for the AMD 0x80000026 leaf
Date: Thu, 14 Mar 2024 10:34:32 +0530
Message-ID: <20240314050432.1710-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|PH7PR12MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eac80d7-2a49-4752-642a-08dc43e44421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TEfR6itmGGK06Ol4/vsSN9X1ixFeGsJ5vkDmh663oSozSC3IsjPdZQfr79VX0kqRhHTyDGLraMrMPn6t0d7vF6WJ5oeYQaCDgU7GDPbxfNcgXeJIxPp/ScuywlzynK6zl4m9Fyno0UbmufLmx/4A1wErGbNTaRUFB8FHDyUWv/2ro5bWQKUzGyctOcGw+mwFgayNVJ+V686DSo6jjBACRFFfKtJrp56kNviYGI2pEScgxHoC7qIhrwpFX0jVz+n0AOMQY9a4nYMcQ1a/jcYAEVvtTY4Frb2S88eUtQb0MfNuUiAMDhqNpEUCzJfBEjY9Gj0VupLPK9m4WoFxU9III6D3D/S2gGC3824aZK2XDSWJeptRuysiM7SUoiLYX9LpQiAEnHJauEd7kaiLp298Nec7l/213rqrRp3LGcVd3dxg4kXS3tP8oeLLIFVb8rb/gpOlhstrcP3eSNv46VQ3jEqysKhQVw3uabUNJja/fC9gtmtqhcBVHO5S1ui8J00klsNR6webVmpRmblJrlDFOHn1knj4eunxYs5BurowMBPcEiwvJI9sBidURiQ362qWDHn6g7NE8X+/vACj7gU5uUZnPhaDjwdkkzBu5MfEXuPhv+fMY27rM1wjaBHOPcJy8A+5NvXvZ2h/WKQvUBBCOVjD2vk0rbv6owGM2NGYUjvlVEyMP1XkndO+77/aMc+yqDoacd8eI0tW10+LFHZkRg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 05:04:45.2067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eac80d7-2a49-4752-642a-08dc43e44421
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154

From: Thomas Gleixner <tglx@linutronix.de>

On AMD processors that support extended CPUID leaf 0x80000026, use the
extended leaf to parse the topology information. In case of a failure,
fall back to parsing the information from CPUID leaf 0xb.

CPUID leaf 0x80000026 exposes the "CCX" and "CCD (Die)" information on
AMD Processors which have been mapped to TOPO_TILE_DOMAIN and
TOPO_DIE_DOMAIN respectively. Since this information was previously not
available via CPUID leaf 0xb or 0x8000001e, the "die_id",
"logical_die_id", "max_die_per_pkg", "die_cpus", and "die_cpus_list"
will differ with this addition on AMD Processors that support extended
CPUID leaf 0x80000026 and contain more than one "CCD (Die)" on the
package. Following are the changes in the values reported by
"/sys/kernel/debug/x86/topo/cpus/16" after applying this patch on a 4th
Generation AMD EPYC System (1 x 128C/256T):

  (CPU16 is the first CPU of the second CCD on the package)

		   tip:x86/apic      tip:x86/apic
				     + this patch

  online:              1                  1
  initial_apicid:      80                 80
  apicid:              80                 80
  pkg_id:              0                  0
  die_id:              0                  4       *
  cu_id:               255                255
  core_id:             64                 64
  logical_pkg_id:      0                  0
  logical_die_id:      0                  4       *
  llc_id:              8                  8
  l2c_id:              65535              65535
  amd_node_id:         0                  0
  amd_nodes_per_pkg:   1                  1
  num_threads:         256                256
  num_cores:           128                128
  max_dies_per_pkg:    1                  8       *
  max_threads_per_core:2                  2

[ prateek: commit log, updated comment in topoext_amd.c, changed has_0xb
  to has_topoext, rebased the changes on tip:x86/apic, tested the
  changes on 4th Gen AMD EPYC system ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
  This patch cleanly applies on top of tip:x86/apic at tag
  "x86-apic-2024-03-10" as well as on Linus' tree at commit 480e035fc4c7
  ("Merge tag 'drm-next-2024-03-13' of
   https://gitlab.freedesktop.org/drm/kernel")
---
 arch/x86/kernel/cpu/topology_amd.c | 19 +++++++++++--------
 arch/x86/kernel/cpu/topology_ext.c | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 1a8b3ad493af..6bc44ab32dc4 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -48,7 +48,7 @@ static void store_node(struct topo_scan *tscan, unsigned int nr_nodes, u16 node_
 	tscan->amd_node_id = node_id;
 }
 
-static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
+static bool parse_8000_001e(struct topo_scan *tscan, bool has_topoext)
 {
 	struct {
 		// eax
@@ -78,7 +78,7 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
 	 * topology_set_dom() would propagate and overwrite the already
 	 * propagated CORE level.
 	 */
-	if (!has_0xb) {
+	if (!has_topoext) {
 		unsigned int nthreads = leaf.core_nthreads + 1;
 
 		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
@@ -137,21 +137,24 @@ static void legacy_set_llc(struct topo_scan *tscan)
 
 static void parse_topology_amd(struct topo_scan *tscan)
 {
-	bool has_0xb = false;
+	bool has_topoext = false;
 
 	/*
 	 * If the extended topology leaf 0x8000_001e is available
-	 * try to get SMT and CORE shift from leaf 0xb first, then
-	 * try to get the CORE shift from leaf 0x8000_0008.
+	 * try to get SMT, CORE, TILE, and DIE shifts from extended
+	 * CPUID leaf 0x8000_0026 on supported processors first. If
+	 * extended CPUID leaf 0x8000_0026 is not supported, try to
+	 * get SMT and CORE shift from leaf 0xb first, then try to
+	 * get the CORE shift from leaf 0x8000_0008.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
-		has_0xb = cpu_parse_topology_ext(tscan);
+		has_topoext = cpu_parse_topology_ext(tscan);
 
-	if (!has_0xb && !parse_8000_0008(tscan))
+	if (!has_topoext && !parse_8000_0008(tscan))
 		return;
 
 	/* Prefer leaf 0x8000001e if available */
-	if (parse_8000_001e(tscan, has_0xb))
+	if (parse_8000_001e(tscan, has_topoext))
 		return;
 
 	/* Try the NODEID MSR */
diff --git a/arch/x86/kernel/cpu/topology_ext.c b/arch/x86/kernel/cpu/topology_ext.c
index e477228cd5b2..467b0326bf1a 100644
--- a/arch/x86/kernel/cpu/topology_ext.c
+++ b/arch/x86/kernel/cpu/topology_ext.c
@@ -13,7 +13,10 @@ enum topo_types {
 	CORE_TYPE		= 2,
 	MAX_TYPE_0B		= 3,
 	MODULE_TYPE		= 3,
+	AMD_CCD_TYPE		= 3,
 	TILE_TYPE		= 4,
+	AMD_SOCKET_TYPE		= 4,
+	MAX_TYPE_80000026	= 5,
 	DIE_TYPE		= 5,
 	DIEGRP_TYPE		= 6,
 	MAX_TYPE_1F		= 7,
@@ -32,6 +35,13 @@ static const unsigned int topo_domain_map_0b_1f[MAX_TYPE_1F] = {
 	[DIEGRP_TYPE]	= TOPO_DIEGRP_DOMAIN,
 };
 
+static const unsigned int topo_domain_map_80000026[MAX_TYPE_80000026] = {
+	[SMT_TYPE]		= TOPO_SMT_DOMAIN,
+	[CORE_TYPE]		= TOPO_CORE_DOMAIN,
+	[AMD_CCD_TYPE]		= TOPO_TILE_DOMAIN,
+	[AMD_SOCKET_TYPE]	= TOPO_DIE_DOMAIN,
+};
+
 static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf,
 				unsigned int *last_dom)
 {
@@ -56,6 +66,7 @@ static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf,
 	switch (leaf) {
 	case 0x0b: maxtype = MAX_TYPE_0B; map = topo_domain_map_0b_1f; break;
 	case 0x1f: maxtype = MAX_TYPE_1F; map = topo_domain_map_0b_1f; break;
+	case 0x80000026: maxtype = MAX_TYPE_80000026; map = topo_domain_map_80000026; break;
 	default: return false;
 	}
 
@@ -125,6 +136,10 @@ bool cpu_parse_topology_ext(struct topo_scan *tscan)
 	if (tscan->c->cpuid_level >= 0x1f && parse_topology_leaf(tscan, 0x1f))
 		return true;
 
+	/* AMD: Try leaf 0x80000026 first. */
+	if (tscan->c->extended_cpuid_level >= 0x80000026 && parse_topology_leaf(tscan, 0x80000026))
+		return true;
+
 	/* Intel/AMD: Fall back to leaf 0xB if available */
 	return tscan->c->cpuid_level >= 0x0b && parse_topology_leaf(tscan, 0x0b);
 }
-- 
2.34.1


