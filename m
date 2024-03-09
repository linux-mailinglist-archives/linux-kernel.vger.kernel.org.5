Return-Path: <linux-kernel+bounces-97843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB3887705C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EB8B20F46
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E5538397;
	Sat,  9 Mar 2024 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lAEI3SJD"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2073.outbound.protection.outlook.com [40.92.99.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B44C90;
	Sat,  9 Mar 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709979888; cv=fail; b=cOP1ebV4dcX3SX0/SAtltErnFqZqhAQti5E8KvIva40gKpgwfqsSRb0+ZRO4VgWSxNuiqzTKf1V66jMu9nQ65d1yFkHphev9douoQUVMPQuJXtL8MYQO3mOtm1a9Vdz9qbG0pvs8ETtGDdvGutt34oBYy6dFbT7cZ20vD6d7pAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709979888; c=relaxed/simple;
	bh=O0RQAFbKHonigJv17Mi5J4NfG89cllJQofZW5X8XKXA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D8QkRPfF0/TX5YVglH6v5ZTtXdZR6/ZM+M65nXhD4rKnsTkbJD9+vp1+3NSTxVTSJRyOP738Jyu9/1b5mIXPZ5AxNzsBoMwXOT9phQS7FPnXw3HG2GXQhxHMguQgIohfNDY+JLBSx6MrRznt/5Mc/+iPxN1s7RrJD/+pwLU49JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lAEI3SJD; arc=fail smtp.client-ip=40.92.99.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3d5GZtpDbLY9yj3VsC7Hc6U+pwugwjTVhabtVyZ7kgoJhV+DXpOBukmTkvdAc6hCRQa2jR1E68ovfpOgyooTSK9xyks8lD5u7PUgXDFAcEVzgBJZs7H20v4yBDz4Tr0je57iWq6nld/W/2XoR6Il9hh4aaJsphzffEj5PrlTQoJIZRU80FZuadmJYhi/fAGBaQMMfJhfBn8wdzQmPmvVEM81H3Pnyle7Fzyy8bnbF0xaiIqY7i54nue4+9c5VvoaY4VGE6PiLmIOGT+vbo1jDtiHOl9k+UTJrtY1hI1UlVMo/UkhbMO5q1kladCe6/5yRyud47IpQDJjSmr8WTh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNhCd+CMIb3+/agr2Y29GjSyjRtgQslucuFWFClCjNQ=;
 b=mgUIiMVyJO9ryB47wAlmRina2hjJ9RVnEXLBzJRNen1OZfB8p4KLFr/xwHaOqqQxqckHglzvLvApKCMAF7u5jog5QQyo3tYP3mG50xnDJB37z+RePsbWDE+qw5uWr3n6X78TsbO1bfLf9Jwo7vCowoTRHu8MPhKp/Pig0a4hPjGRnpJ2lqEZkkAys9PQzz0zI8eqMEbFkqMUJ3J8GCQpUpQActs6z7PyNFzyTYFtBOxRsQaMWQ3xATkuCfmQXXRWiA3meBoO79IUSLTCZaJhMZUfaBzaBChWmd6lKSl8BFeynklx4DuKDQGxzER0vpoKXzNo66m3qZ7mJ0tqbQMI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNhCd+CMIb3+/agr2Y29GjSyjRtgQslucuFWFClCjNQ=;
 b=lAEI3SJDJCatQmydfzrx/seNqWri6XdG1KBrczo5r1LiMspBjWDesO2i9RedYeFI0xZe8+EiyRiKRAJLWmD5FJOxzlUZzCoKOa1V0e4X0Qhb7NURdK7SCdOgTLK4RUpJYv8qJjAQVj5uN4j6HhGfSf/eUQDblWTEz5b6aVMhHX80M6e1PKpFJO87sbkNYrdClh0YGnomO7YX5Y3yTVjXIgNSp2EAZ0Edhce9XTZit+dcwjqVlySbsJGz3X++bjjP11LREdB0kkkTYscK845PRUSQcn3NwBfcXrXOLNRdl3TQTpWhjS8/ogm3ihpe/CfRgI2pwMJ4qLjuSUf3IAPyHg==
Received: from TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b6::10)
 by OS3P286MB1879.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.32; Sat, 9 Mar
 2024 10:24:43 +0000
Received: from TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e959:a431:1b57:faf6]) by TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e959:a431:1b57:faf6%7]) with mapi id 15.20.7362.031; Sat, 9 Mar 2024
 10:24:43 +0000
From: Dawei Li <set_pte_at@outlook.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] openrisc: Use asm-generic's version of fix_to_virt() & virt_to_fix()
Date: Sat,  9 Mar 2024 18:24:07 +0800
Message-ID:
 <TY3P286MB35670C95140EEC4DD181AEE4CA262@TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [iI73yfNiUJuEzeCTMstO/fBx9TWNLoSO]
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b6::10)
X-Microsoft-Original-Message-ID:
 <20240309102407.403962-1-set_pte_at@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB3567:EE_|OS3P286MB1879:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ed8ed3-5d6b-446a-5012-08dc40232284
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YkZVZ+duttPNG3arx27rHDpGYl4uNXklkkZB8+lr038OVzS1EQS5ZJhoLjk+SZ2hDRlWm7kFKqXo9WHUCmslXuhyJfy9+LouIpvbxXuUFUwCVos6xT/HgosT0RanmcCibV7E4mk387wRzvnfEez4uB3gW5v91RiV2d2P0CJn2lLKU7ay9gqQgG2NB2nZNFkDqzXiQ1upJfjP8e549hmJl/BMWbzwEwD7k/HL+rxl8C6kPD5rvKjhjQTNsuIVnjQZHhps7LwHTsmrTGZwt8FOvOnHbdNUZJS/RrUf9I0Yh6pv3U1CX3zBBj+ZgG+DgGJKaTn8vIORaENB222QWX7kcnH36Pb6EvXPozxyR2jLORKZT1pCcI7JNQf/tLDLDWG3iDwdTel/3tuj1lwzeSFNnRTuitnRGhyvfJxSrebLbsWprSu9pHGWtU75DM3JdPAW8OjfFX0lRhhWyBs5YzfBsn2YxYHGI/oRlCiC+qJ2V6ysSm1+mou7PAy8/h+vemC9h8gEcpjXr8qYpxwci/ylHDxkzEMUgV5WW/s/oZyrwFVcOWFmdHKERa/jnFkGTeRPJ/M0wV0xDzyzqeoicckgR84DKPftRzGnURNCGtH6CTWT2HQxC07t0j1OjmkLJHkg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t8iiS5erEejrwhrtJEmRjwBDI7Va5ZH8o6FSXoyiWlTezWktVKjJZmRyVZuu?=
 =?us-ascii?Q?guMAf0s4+X7JVEF4X6fd9sFyhc8UT0fdMONA5aALwuHjkzpbP00iFA8ILUY5?=
 =?us-ascii?Q?zjQpmr3WoTz4PklseR1Gq+orvDR5vNyJP1wLBHs2jT7M2nDvsx/jcr5ilEX1?=
 =?us-ascii?Q?YDueWpCeJGNR2VgDkqKXgspcwky7sXG5QgwX162RFFAU7jIPxFk8IbsS8CEW?=
 =?us-ascii?Q?2SQH3fO/498/YkLb7JRKWnuSqBUWBlUuhOhkCrhAB+VmgdSLXiUZy0SmAp+u?=
 =?us-ascii?Q?qhxrO/b232SSjXUGgBSO2SBW5zIfhr0jjk5wC0q5OxLUqxfPC6BxLJZQPW+s?=
 =?us-ascii?Q?ITIdvEeSUryeZ/U/L9wqFBEWRgk0SMIgtZflxy9uHHhSPuMU5J/ukPm+7VzS?=
 =?us-ascii?Q?4WWyvIFetW4NkCosGDwZYwZ9KQk8IxIiLrAmVlKcxjt6iVK3AkdSNoigoNbo?=
 =?us-ascii?Q?GZ+ii3FiaHwLCGPxewNfhco/IVVhzvvLtE9pHRqpCtmm6y3dPPtbfR8Tv1z9?=
 =?us-ascii?Q?vb9bE+5YpkDylZtkq1V+7S1i1bzn/Uqn+HIgsoK+RqSP/2sSRJ1FzzmgLzd7?=
 =?us-ascii?Q?HnkcKzyBTJ8eIQSE7Xt89ZFuqh876K22sO8yPM7+qsM/HTlNzGHfwtOtbYbZ?=
 =?us-ascii?Q?FFEI6T/Tamg36q4+RVpx6h1jYdyzVEazXHjfkPO9q/HpOIM6JmD0nFjJO0lE?=
 =?us-ascii?Q?BtLm711ItUW5wwbJ+d9DLl9ewtcJ43e3DKORrZeXO2cHOr0t+yFquDmCqukT?=
 =?us-ascii?Q?sQSLVE+AP6ZLN5lUa+3yaV7b+2CM8GENqTgrRzggqmdLfxIoQZbibr1jbZQ2?=
 =?us-ascii?Q?juMIDmIFJRCdMedcBh93sPTDmCDaUINsVkyQ1XKRW4syMX+sqQb5qTyAmrvz?=
 =?us-ascii?Q?UqsStSSbZJZqpCHqbfGyh1S81QBJtoeRnSN8fY3FZitdm+tuc1HTTZiBQB3f?=
 =?us-ascii?Q?layKZLNg0mr1sR5+GIczry6TdfaTZD3JwVuEseewsjC4QaDfDeUvn2YwUS+r?=
 =?us-ascii?Q?4pRiMwR1wYqjYoojbgWmqcSz05dMe5LKLXh21SalK1WmYLvMIoH27APFVAFF?=
 =?us-ascii?Q?Y+aRUXd39t5wkhBo4quglZTgoF3f9ag3fTmarCGouL918wm1c764ZBu7R25C?=
 =?us-ascii?Q?mdCDBtl5yOzBRlR6sq9BX+Esw1bvklZm39gBP4m32xMuSnlnUWgEzpHukvnK?=
 =?us-ascii?Q?T9XB3w3K3d3LVGY/rg2Ebrp4ZBRoh8s8cAxPDDaB4HUSLUUu0T0M6pUwdas?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ed8ed3-5d6b-446a-5012-08dc40232284
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 10:24:43.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1879

Openrisc's implementation of fix_to_virt() & virt_to_fix() share same
functionality with ones of asm generic.

Plus, generic version of fix_to_virt() can trap invalid index at compile
time.

Thus, Replace the arch-specific implementations with asm generic's ones.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 arch/openrisc/include/asm/fixmap.h | 31 +-----------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/arch/openrisc/include/asm/fixmap.h b/arch/openrisc/include/asm/fixmap.h
index ad78e50b7ba3..ecdb98a5839f 100644
--- a/arch/openrisc/include/asm/fixmap.h
+++ b/arch/openrisc/include/asm/fixmap.h
@@ -50,35 +50,6 @@ enum fixed_addresses {
 /* FIXADDR_BOTTOM might be a better name here... */
 #define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
 
-#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
-
-/*
- * 'index to address' translation. If anyone tries to use the idx
- * directly without tranlation, we catch the bug with a NULL-deference
- * kernel oops. Illegal ranges of incoming indices are caught too.
- */
-static __always_inline unsigned long fix_to_virt(const unsigned int idx)
-{
-	/*
-	 * this branch gets completely eliminated after inlining,
-	 * except when someone tries to use fixaddr indices in an
-	 * illegal way. (such as mixing up address types or using
-	 * out-of-range indices).
-	 *
-	 * If it doesn't get removed, the linker will complain
-	 * loudly with a reasonably clear error message..
-	 */
-	if (idx >= __end_of_fixed_addresses)
-		BUG();
-
-	return __fix_to_virt(idx);
-}
-
-static inline unsigned long virt_to_fix(const unsigned long vaddr)
-{
-	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
-	return __virt_to_fix(vaddr);
-}
+#include <asm-generic/fixmap.h>
 
 #endif
-- 
2.25.1


