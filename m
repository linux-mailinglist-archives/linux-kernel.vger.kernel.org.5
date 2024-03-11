Return-Path: <linux-kernel+bounces-98534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07812877B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6126CB2106B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1407B111AA;
	Mon, 11 Mar 2024 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="ahcXdoea"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAC11C8B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145130; cv=fail; b=vA5q7mNiDVUeBYZWMVMifVvJ7JABATW9thTjNYxLRs+3ai3HEhfsckQt9cVqdIrf2GHXzcMMFknV4snYFsgMRmbv24LK3Tnh27Xi2BUhuH1s/KKr6oPCpGLwjsJYa4W9AZWGICxeSzZeNf98FqPQegwLF8AiGIVhFTdlU/1sw5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145130; c=relaxed/simple;
	bh=Rmm8qCfoa34U2593MSCkjA/ubjAGqxjybRFdHqQIf1s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R2t6e93hIM7glwDeeDCQ8IMHA26UnbyFwbu5FSloWrJZM2pmRcvC/D5qN7A5af+rm6SvysjAyybjs8JLxvaQwypzOGIs70YjGkPmqkXvSnkwRWNsEgXy2nhPRFas6nxYaFgJ8ZSO0an8vRRymwCtS9wzJJck4WjQm2H8MvdVtOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=ahcXdoea; arc=fail smtp.client-ip=40.107.215.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ryi0j4a7F4QczkprDmu+EoYAFSaPo4eqM30cdwQNc8mOk0moCwJ9pkGUqgxjI8zOdCnr0Fxl9wV6dF3rX6zNOQcYmuf59Qvwt159tj0Vyl+Olbge5JkIXuAtuS2NsCO+EK8KrYLZN6FswIsEWvkunCZDIgsb2UfZi+wEpDRhTOVsx+h5SIupn91qHA5KY970q8f7FXTgZLUIr542scmgzin+PCuRTqhfNx2elUcgGQvldG37IBOhZqkjlT/fpcW53BWUEe46jf5Z/tea0aa4pRkl/qpqDpohNV0yF9TM+Iq/rCJhAr1mMjCzHNcQH0A5OvA+KbamLUpFpt7cpChFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HGf8GtlTFpCb733pWbCsbcSKCWjJcVlz1Q0SZqJ5Ws=;
 b=SLVevZkUlcX/F3hzsLkzSfWHwAJIgMJIrJtNCTS2tilCzdq8h+KrfztGy+2ooCAisV1pvF7UG0F0I+Gz/8iZ3XQc1TeWx1Bl5ukqK1MKfj9FlM60TBWrzXWiGbo/fl+Xo4boXjU/KGRBFnZXvF0UhcwLSDV7gfN3BZ47Ifr1A8X+WpvUj1fkHDJFfjq0CXjs5XDzbjPNknBs4Ui9FjYhZ0oxZIbwk4ks91+2/trvBp7P7eBbks7hvNB8cjsUKtsDGRJTmr4In0zb2+XZqgd3bydq0xhKLdnFEG5+c+xHI8S4hRVOSGJLG0mHPE/1wRbwn2oIdNpCS2zcy1/WoRudwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HGf8GtlTFpCb733pWbCsbcSKCWjJcVlz1Q0SZqJ5Ws=;
 b=ahcXdoeaQd2LyuhhoSkL+aIcBAB2k2TgdWUin5cWkNMMRWtKHA/MO61DpTwq89R/0FtIx0SQvB9DAyw+PPm0AHvlbmY9d7AgJOQwvzwG9Kgq7xIYPS3Tpl9mTgh+axmppyJqAxBmIsgUAvStZ9bly8P48J1EjGzv34vqSKmPLJ0HwGmcim2yEa3MKdXsQFFUJ4BlPTQYw5TsWUJLHoPxeKA5y7pJJqgBONIYjmXjGaf7meAkIIpDelcpiZqTLqrbY8U1ISY5GjKZ7HAGM70oN8Qn76Ebc6xHECM1x1V55Jv0F3+4y5JOq0+fzpqQOMY83s8TdJjF0z7V04H26oiQvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by TYUPR06MB6051.apcprd06.prod.outlook.com
 (2603:1096:400:357::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 08:18:43 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 08:18:43 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: james.morse@arm.com
Cc: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	rohit.mathew@arm.com,
	rex.nie@jaguarmicro.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/resctrl: Uniform data type of component_id/domid/id/cache_id
Date: Mon, 11 Mar 2024 16:18:39 +0800
Message-Id: <20240311081839.937-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|TYUPR06MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: a16f1be5-be50-4426-dacd-08dc41a3dd4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZlTd1RvEhVk3sKvwejAcaHSuucXTmUCZeENPnKbO2v7+EMUBKvnKbh7IcHBnk6DiGQonfGgX0wExm/nq4h/DVW3NZviFF/012PELmZS8afQ8s8N9YcGYXl5P4FkfVTItnIIkOwariyzd4mRdEfNATdqRoNxaQrbDM9BoUTtIDtXQFUIlsvegF1JaQ4wzlBn21tYJ3SX8Z8oa8SHRu9+cwjaCGozQLtov6wOO1R0v9+27LNw/Niqfm6R8giPyP4f7QkulM82k7tyOFrQ4GsN/ThMe8YeioMkAkBSPC1HJxFr1YIuBNeCnKqzwUpopLl95uGN8NL8MCIYJ5BCPGzyk10cV7/DwKG5itQzr9gdEP/OyaZaMha6aXmdtpnVUApkB9x2vViwudc7tbY8pyrtNfwJN8d0N7UWXQ6VAL+tXTxkNT4kEmH7sk+KX7WFPTzhDB34BJqhyT93DOE+nr9BY0rWuxP/0riJ+CBGnN9QExSGBK3LZzt0o2yuNsgqcupuZe80MyD4wGsmaUWg1abnGcMOdvSYjcfJVX8lvqeX8nsDTgL2uuc73FYrQMo+hsfWjzPYVhtCfwJ8edXGfzWMrP4h5bWq1i0PTPrgS3sHFSvuQaSy3NF+bov3WjCa6R1gVgYHlwx30FPplqXOxwbFgTh6QaiaWvugtmaaIosGb9ac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3jCE2onIdoNWLovZoZNzz5sLIqps2Tpm4oEw3PuyT34ddob1AlKAoD1j4x5B?=
 =?us-ascii?Q?n8sQrmi62QHjrhip/s69EER9M25SwdbvZ4s+F+ntnbyT+UxReFSXocjIt9+L?=
 =?us-ascii?Q?JNS+Ii0N3bXToZ+WcPY8BaCSQc3ou9LCLhK4Lw+34nZ3ofhvgvFwcvUpKsNL?=
 =?us-ascii?Q?g1bnOMfLCYvrWE/mqwghUUGkF3wzxAZP/iZYDCc0/do5kRIHot0VL3q4DOht?=
 =?us-ascii?Q?SavQMUTnY2R5/veE+xqoq5HUOoMr6BsM6EPmRUiEP8JHjnHYYmNRyQJSIyOK?=
 =?us-ascii?Q?QG1tmsKoLbObZv8TSW2p9ZRRya+r6sMYddOW9hKyLGIwxfyl6GtJDxspyRum?=
 =?us-ascii?Q?G4n/+FbyeNoZLQ9fWvEBmnDYksWG70mQeaxlmqNnPohJRfyh1hmWwmoMUquW?=
 =?us-ascii?Q?csl0svi8OfbRqXn+dcgd5/8U1BFLvTgZnuJDjWN776t94bK5jdiPtU5CwdCt?=
 =?us-ascii?Q?JqUMC2rGzsBDkD+m5rTO9DH8if5BLejmioamVGsgWKoVWVmu3w6132/05YqV?=
 =?us-ascii?Q?Kht9V2xGRheRu2ubJdwu2pP28t39n1IGQg79ouJSTCi+wAdP/V1Pvtu4TWAC?=
 =?us-ascii?Q?r5M++dyZtZgKpenajCiLnGFS/KNv7pgozV3t5AdNGwxoRv6fZxxlUslkBOPP?=
 =?us-ascii?Q?qOx3W45mVEaTrghDYwBlRJQW5g2MoKCMw51WhJW4c+whY8Ik+Cu5newj76qW?=
 =?us-ascii?Q?a0rdUKbL3p2qpMBkxdGrUNWvfB+07itooCGHQtuFbg01gm4EV66WQT3BTEAf?=
 =?us-ascii?Q?iVC9N34spqtHNzIYnxbQNcnPRbCcQSAdgZe5SR18FoBoMTtk136H4IWWvK/E?=
 =?us-ascii?Q?g0SkE0ANbL/EShn8zG5GcjfTN2PcXj0TSHJlSeQUFr6P3Dcj67Hzx9QkP3MB?=
 =?us-ascii?Q?Q4UIvI0OIhbrzbY51fRUYCQtbMQv4QH7n6Yjp+u49v4Lag6HhaMpj7oDNTns?=
 =?us-ascii?Q?VeXIY3USFnGrenUhUhVlRfTlZAFCP/T0kycr/kjCcngWWJ5SAp+VrvkTME1C?=
 =?us-ascii?Q?FtTw14TLyW5YJXrXkJzakywXARA5H1IVPCKONQlW+AE1E8sVPO16J9WbOSd9?=
 =?us-ascii?Q?De9dElk09WeqRZDIFLsyhqHrGZ+0iSvfunuO57vvhfDxDoHYUbWcAo2sg1kR?=
 =?us-ascii?Q?AIARDzN4AnjmoZfOQRlo+k8ccbSCmZGguYWirr9LgFeufEvTGk/eGL11qtRT?=
 =?us-ascii?Q?A5s/VACYl4ZQXIsl2EfzCZXwI6cluYSLTN/LdDsHL6xN5d7vcrp4Ds/1HXf3?=
 =?us-ascii?Q?6KhYtRlWF9eTUm6GYo/keQqjLLHznsqzHfOniCP7j06xJApZUzZmXuQAPh+G?=
 =?us-ascii?Q?w33mP1z1PcRdgcxx0oNSntkV/Gr+F1ZFAooaPbmrAolKTVv1CXHYhe5lH8IZ?=
 =?us-ascii?Q?opq8A7EIz6QGAHG57LSIOuCfSgiUnKGUdzpcYKyw4KcE0Xz+LjYLcvNpjtNA?=
 =?us-ascii?Q?d02mUxabyAeepdS32FeckDaq0XXK98NHsgM5BYQHFK2SqZrfZx5erSL+1Y++?=
 =?us-ascii?Q?S+vlp83xWRCHCHr/b3TL785HuF9z9ajwsWmqz41DKssY6eANPhhMOdaaKPLP?=
 =?us-ascii?Q?0WxCuhLLXeONSJMJjhZZdWuvFKcf7Bms4lakJA/4?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16f1be5-be50-4426-dacd-08dc41a3dd4a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:18:42.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyOP+FQVLaFw4uHuwbNzN9d/kIfWfdYhZWN6h9GYHwKaTvsrba0MOADWGqlGamQRUUZqvrLwpd79NXag7FlP7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6051

This patch uniform data type of component_id/domid/id/cache_id to
u32 to avoid type confusion. According to ACPI for mpam, cache id
is used as locator for cache MSC. Reference to RD_PPTT_CACHE_ID
definition from edk2-platforms, u32 is enough for cache_id.

	(                                                              \
	  (((PackageId) & 0xF) << 20) | (((ClusterId) & 0xFF) << 12) | \
	  (((CoreId) & 0xFF) << 4) | ((CacheType) & 0xF)               \
	)

refs:
1. ACPI for mpam: https://developer.arm.com/documentation/den0065/latest/
2. RD_PPTT_CACHE_ID from edk2-platforms: https://github.com/tianocore/edk2-platforms/blob/master/Platform/ARM/SgiPkg/Include/SgiAcpiHeader.h#L202

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
 drivers/platform/mpam/mpam_devices.c | 8 ++++----
 include/linux/arm_mpam.h             | 2 +-
 include/linux/resctrl.h              | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
index c2457c36ab12..335ca9e441da 100644
--- a/drivers/platform/mpam/mpam_devices.c
+++ b/drivers/platform/mpam/mpam_devices.c
@@ -205,7 +205,7 @@ int mpam_register_requestor(u16 partid_max, u8 pmg_max)
 EXPORT_SYMBOL(mpam_register_requestor);
 
 static struct mpam_component *
-mpam_component_alloc(struct mpam_class *class, int id, gfp_t gfp)
+mpam_component_alloc(struct mpam_class *class, u32 id, gfp_t gfp)
 {
 	struct mpam_component *comp;
 
@@ -227,7 +227,7 @@ mpam_component_alloc(struct mpam_class *class, int id, gfp_t gfp)
 }
 
 static struct mpam_component *
-mpam_component_get(struct mpam_class *class, int id, bool alloc, gfp_t gfp)
+mpam_component_get(struct mpam_class *class, u32 id, bool alloc, gfp_t gfp)
 {
 	struct mpam_component *comp;
 
@@ -476,7 +476,7 @@ static int mpam_ris_get_affinity(struct mpam_msc *msc, cpumask_t *affinity,
 
 static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
 				  enum mpam_class_types type, u8 class_id,
-				  int component_id, gfp_t gfp)
+				  u32 component_id, gfp_t gfp)
 {
 	int err;
 	struct mpam_msc_ris *ris;
@@ -525,7 +525,7 @@ static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
 }
 
 int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
-		    enum mpam_class_types type, u8 class_id, int component_id)
+		    enum mpam_class_types type, u8 class_id, u32 component_id)
 {
 	int err;
 
diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
index d70e4e726fe6..0a4ac76682b5 100644
--- a/include/linux/arm_mpam.h
+++ b/include/linux/arm_mpam.h
@@ -48,7 +48,7 @@ static inline int acpi_mpam_count_msc(void) { return -EINVAL; }
 int mpam_register_requestor(u16 partid_max, u8 pmg_max);
 
 int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
-		    enum mpam_class_types type, u8 class_id, int component_id);
+		    enum mpam_class_types type, u8 class_id, u32 component_id);
 
 static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
 {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index dd34523469a5..b00a89addf91 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -108,7 +108,7 @@ struct resctrl_staged_config {
  */
 struct rdt_domain {
 	struct list_head		list;
-	int				id;
+	u32						id;
 	struct cpumask			cpu_mask;
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
-- 
2.34.1


