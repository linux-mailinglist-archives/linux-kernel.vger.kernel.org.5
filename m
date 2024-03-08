Return-Path: <linux-kernel+bounces-96620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964DC875F01
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEB128452E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88E450A7C;
	Fri,  8 Mar 2024 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="S90HZcpO"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2060.outbound.protection.outlook.com [40.92.98.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84D4F605
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884965; cv=fail; b=ciG5K5paU0f5lEggFZK4EocZrIZKQgNF62hCK5Su8vWqgKpQ8HLwCWwGeCj99DG8zIx7dbKw3C/dAcpSsCY13BLNohUyrKr+jFoA4emUP9jxGn+2ML5t4ghUyoRixlLvN9/1qqBT0GAh1KEFz+WIGJfJPihgKZhXPjozYOh/+60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884965; c=relaxed/simple;
	bh=KIp/eh5p6BeqAqx4zI6SJTrvB2fmrNScoQUr3NS6YGA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MFxlP0Nz+SHbMdd00xrCzXqi+BGQc7vFoiM6SFbQaMIchQlHlakWzPpYjBOWeVKrm95DotSJNtUR0R1iasWqpXGbzbA5qbq+8F86p1P4NUva9KptaCgzMHCvi+2OJ24Uq2FoOEbPpmyhWLRskyNesQLk7DJAlpjzZ44NeargocM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=S90HZcpO; arc=fail smtp.client-ip=40.92.98.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxVPDGIJNonIVXjopY8+OmoSA4mbBOOh7qyD7H90NU3/uE0sxXDEavCpb04i5hZ4l6D3jg9w8N9LyPw3tqU5nuWIGu9wepq9/Ns5i22CNsKezRv42/rikLoBj7Bwi+CBUyeWEzE8Wx11p7j88WV9iR09zyDQGtbDgUQD21iaj7kedBF6/LO44wM11XIjrzw89YInuz/L7KUKDSsDP1BLVlq/o7DoiX1F4whfJqAG0CN8/Vg1Zz3EPCw2hyaZ3XWsIxaaVSAkeyxds3aY2Ees1bh58Tp15t3fHYSbjVKnO5sluogiQ/8tLLH+CAT4lYX0fHA6ocBUK7+gkLgiVZvGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCPAEg9e4lQhl73cFWJZbDoML78BlBtAcYuX6ljTGcw=;
 b=HtyJTt4kJ3k4wQfScaGPqkqMSFypMy/xN0hxIJ5+HHjquRt67M3vyAELgoyffLyMvO9+TMvkZy9Yrq26KjmLpf4T7kOrMUmoKlJSMl6RhC7ER8+YWORs09n2JgsrhfGXn291xNOXUu0FyjoxSczq3Rzcpzbx1pw/lTDSWey0zmBz5vRcnQdBVbg+ktUWo3u5gIztrS1Kfp2Y5vosEED1rWfbbIYusJkKedrZtAKmCUeLKZvWLg/0VPFl8rm9wDaEJmaGpXNeVFPifJiP9BjYPbM78B9tgPeOBK6RoCgty1pyAFIevXHC1fthQTQW0fjA7VGq8o6e7rHTdQnn6GFyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCPAEg9e4lQhl73cFWJZbDoML78BlBtAcYuX6ljTGcw=;
 b=S90HZcpOWTkBiJG65H4Op5Ebv5AP8CdDTHsUTXDerFSeYk1wQywjJ2jyuopV+LgAAzI2HIu3kPTILgkVoGUxdK7xmn2fbPGEfte7D+B/Dovr69C9qWVa44dWhB4kNpzVHnE+p4y/DD0ovr3EDxd+rthbw8iXRtZ3i22Qh+fkcNFXMV0T6k15nm7dfxBYTG6Qujb0X3DjKw6xpbpPSn44Elt9o5hFvsvlBb45NVDxNVornUeCz97zkHDqN4nBpbVRIb0dy356PYq5sY8pmTzkfXn0HRJScUlXeVkXZgwFmDHikSVeXCgCAPdSERFFdFn1MXmI4yJz8PT7nX6BZGsc/g==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TYCP286MB3620.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 08:02:41 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1be7:85f5:be18:8aa9]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1be7:85f5:be18:8aa9%4]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:02:41 +0000
From: Peng Liu <pngliu@hotmail.com>
To:
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	rick.p.edgecombe@intel.com,
	daniel.sneddon@linux.intel.com,
	dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Peng Liu <pngliu@hotmail.com>
Subject: [PATCH] x86/apic: Delete useless BUG_ON in validate_apic_and_package_id()
Date: Fri,  8 Mar 2024 16:01:52 +0800
Message-ID:
 <TYCP286MB21461411BA788E6681AF448FC6272@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ID9NXhvfP1lo4hTawpinWvJkNT/PovUz]
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20240308080152.207936-1-pngliu@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|TYCP286MB3620:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7618ea-4372-42f5-7a1e-08dc3f46208b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ueLbEBsZkKyjQB39fCrN0e0kz8+kv7u3wFlDBGXrnwvKDxuYB8CKImozb/+KGHYIJusPJxI3behRgR2V/Qo8JUjCT6+HpmJja/MVUDZzp7/SkdVj6DlgZijnlS6W9lRJWUYFwGtZqV5+onBXUNKYdxzZkhYc8Q9dl/Va66r79LIoGCDSe7uY68Zf32DHjHR3q7Xc9OK/c/QP8lvtQXTAqPXm1n5h7HwKZuyvDBIGY2umo4emnjcjI0SJ3N4Z6Qw7i27TnP+WgugII9zbJVTC5oQqtIQbqgLpn4uGruWrGAGd/zCAUryt4uDU/THnQUKSZTEcXm8/7Onx2pH37n5O5H/JY6X1X7FQrkjRIk8KrAUAZtml+GFOigNVf8OZRN4FUyA9Fgg0nodvIYNE047IZX/DdUak2fImsMUmJEF4OT2sKFGzndYGGC0KdYMR35MTbI7U0UTkkgZbhRVK452tIDjHF+DH1MfUuRl/As1RC8uPT2jSK1kYxJaOb4mbHNqTFxJWzEzQ0AsIF5XRU5O/uDoGUT6rdFar+xcr/ccPuztnvXDW4eKDKIAGMBDCDP5Iy+vqJFJEj9Oq+tiuA11+CcAAmqTh4ZdBdUULG364riTnU1gSB8lzSRA5gWFmsSD2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GalhBSBOlP+8ZB5VO2ZePjOSv41DLA+qxgWGi66/YClAfJhECEQZ1uIBsWXU?=
 =?us-ascii?Q?AmZAuhAJc/yjdEYXPkXn9z2nK4Y5vEQ88eutFwuvx8AkhrXQwL+hn7tUkcfo?=
 =?us-ascii?Q?9CYs/otpisTyos2kUTZAhW6VO6vg9GKz1d2iQrjjDkzB+8wbfQp+xKXTiMBx?=
 =?us-ascii?Q?ynNnLyZzrCWWKZwsQ+qzZ4BJoSz70GVGIu/H9954GqxKNKDhjmWflJ45dUFf?=
 =?us-ascii?Q?nnVlHlkPuQLW1SAcAXbu6yoxPdbRJs9FIHoq29eR+zNXY62miuMpFrjOg+We?=
 =?us-ascii?Q?oF8SCRRpGsCvqGNZdMspjA3ZBsUSVXrZuCDHy2dFWFZ4nzRAzGO20bD4/t/0?=
 =?us-ascii?Q?ExfzGctHwjc4BpzdyHMBW2C9tO/fjW4Bb+3fmTGbITOJzPg6wkDlFFWruK27?=
 =?us-ascii?Q?/fb5WOG12TbQJNPFI6mKUGvzfgpF5OgqT215RF2AIHHMGwO9tiA9O27DAvmS?=
 =?us-ascii?Q?Ubb6Or22BZE8pqI8RWD2AR1Q52qb/2IKn6HsdEj/eNSmgOILyalYvJyfV+yJ?=
 =?us-ascii?Q?nEaNqGD0GZs77SWznZ1/4VpK2E7ZUJUA+ZhHHp5h6JM/L7nBjKHyXA/3sEPE?=
 =?us-ascii?Q?cDRRNrTmsrh4kdQ96sGyR2Rwtbgmp83UK4uyz031vq4sc7lAQyH7WUMPuP26?=
 =?us-ascii?Q?x4Vt5d03nbKgmPvnA4+Ed7hB7GvdAz4eWiPDGXPM1QGQZjLmVujWeXeBXhzy?=
 =?us-ascii?Q?0f9bNBUkI3z0slCod1IfHcOf45JbBSESk3dXm6I9OwaWvXMkHYKi/9DKjKsm?=
 =?us-ascii?Q?StSJisqlyjW4wQ7DjBFSG+uSiQDZ/0SJGyBF4r1lipa9NRyEV6CM/fYAMRIz?=
 =?us-ascii?Q?vFu2exR7cC5cCrOmI9tC7nxRYhIE/edoqD379/TnpSc8paqZiawMjEt2DGrU?=
 =?us-ascii?Q?TnCzxO+soDz7uP62Ycc/DWU8MxwhqpG6w+hbOPdUyyQ2/xD9/6uDfbgkRYzL?=
 =?us-ascii?Q?COxP09t0DZYhl2mm7KUQh8CnOxTpy+81Sb0F38gDLQMajCPiU4kkIjhTGb8S?=
 =?us-ascii?Q?Z5MXcnkEJ7yOAKlTzXjjBn78AQaxH6nPoZVoNmCrLOlj2aDF9E1l+s3PNVGd?=
 =?us-ascii?Q?NgLoZouMpqF/3eeEIDtIzBdZ9YXu5AlVIWGIj9TW/kZAvyvaxT4KPMeYKvYD?=
 =?us-ascii?Q?Kxh+VxbbhQ767L8X+jwTT98ZPVp3Bq7Kg3DUjNgDJy2VoP1WQ1PxKp/EVEgn?=
 =?us-ascii?Q?OHf8+Cm2wa9Mo3po/wGCTZ/uJU4m+HjTOcBv8fiXd+5+3xfduODPGTX0i9E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7618ea-4372-42f5-7a1e-08dc3f46208b
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:02:41.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3620

Both topology_update_package_map() and topology_update_die_map() have a fixed
return value 0. That is, they never fail. So the BUG_ON() checks on them are
useless and better be deleted.

Signed-off-by: Peng Liu <pngliu@hotmail.com>
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fbc4e60d027c..44b08de3971c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1796,8 +1796,8 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
 		       cpu, apicid, c->topo.initial_apicid);
 	}
-	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
-	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
+	topology_update_package_map(c->topo.pkg_id, cpu);
+	topology_update_die_map(c->topo.die_id, cpu);
 #else
 	c->topo.logical_pkg_id = 0;
 #endif
-- 
2.34.1


