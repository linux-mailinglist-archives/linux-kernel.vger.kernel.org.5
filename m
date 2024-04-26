Return-Path: <linux-kernel+bounces-159627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0118B3142
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C671F225F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9513BC18;
	Fri, 26 Apr 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b="yPi5L/T/"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11012016.outbound.protection.outlook.com [52.101.154.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E113BC2A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116120; cv=fail; b=ZmGw2uHz8/RsaN6Ygnk27jMKYYbestqDhxA5XXtqnTj/U6GEXDNlMwGQONsHg3nzS9W5ZxuQ5kJtlmMSLfExeipbynAAroCD2LownzK0We/Fcf4aQKNVf6uWmQSpz2D/KLpUjm2oC5uvnSM8iBTE5vtZzeREbV1JftcQRJcMCX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116120; c=relaxed/simple;
	bh=v8NRntdPrQkGjIk4W045fgDdzV8FgnlKSePdtYwDrdo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BXS4CnxJX1oLf/zXoOugGDbER/LA5lo3i3Y1GgCgGbMhzqxh9VeTY4Kc6OxsxpM8oZi8i7TmBwdcudw/vrYdZhECemC4ZGkZAKu56H+HI5bVojL+rs5z0O8s9e6wkF/lADYj5noGfvvXYC8pvWD5l7SCrZzEkNj1C0e+4t6IUQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com; spf=pass smtp.mailfrom=skyhighmemory.com; dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b=yPi5L/T/; arc=fail smtp.client-ip=52.101.154.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skyhighmemory.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcdSxzTZJjqtcqAUzywWzbl7qoPxUXoyh0JC9AyfKEFkE46dcnjb/Rzi//eNFUiZoXDTHC3DQfpTf2OmhL+tATlVnFupregd1ovhucfEoLZzD2GMU+w82IIX3V1s6pYWltJtjnKVXSgZNpjOmili0oFhlvQ+w7NKlzuntFFwBs2Vj0ONWiMRKuFiECRL2/ocGuGQY/FGhfV4WqM3N/hieldp4GGwK1DhtudK4tHItqScQzYVJfnZ/dMtp760Mw9zeQQW7KKtXYsz7sFa2HZu7fddueEVWMShkuiLNZ5Ad1afdws3AmR2XKPKJ1eab+Qu9P9TVShAtB+/wADKgqrnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okf8DxaIA3O/p7dC3EIzTKI6pZeEQ5cJ62Mwr8YVaSw=;
 b=K6Qm9eWaOi6QoBocMCCxFul3tSa7kDcu7exqnwjBSlIH/aSiKi1FLZFl+vlBfp71Q8tx0w4PgMPTCYYCra5uT3NqyQPJrJCHW1VDHVXWgCnmxExX83x5KAQ+XdkjX/gdjVin8Jq7VemSFE5sz+mWd/SZ5E7cNjTdTgYyQn3Li2wDUYKZc82kvMkYNa6r/EpfUMaiKHgo05XfyDDhonjBVZobnBtemZ/xEE/vs4dmiY/f6g50j47ME+YudZ9R4HMJuY4ShL7TUA4q+ThXOC1aot6R+yXle4fxx1WrVMPvzonGcf8HXr96yTPqqZ9OhVKIJuK3slDEb6CZF5q5Y/fmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skyhighmemory.com; dmarc=pass action=none
 header.from=skyhighmemory.com; dkim=pass header.d=skyhighmemory.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=skyhighmemory.onmicrosoft.com; s=selector1-skyhighmemory-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okf8DxaIA3O/p7dC3EIzTKI6pZeEQ5cJ62Mwr8YVaSw=;
 b=yPi5L/T/Xv1Q/7kUS6Otjmw10IRuajkGjPShUSQ+lU7FQyN++oqSn4G7o+2X5Bgzknw/yKldQsMpoW9bZ7HSmwW5quW9GlCLf+j4Nq+hsrkdqo7YRWB1PT3pzvnbv/3T2oJ9t/ZcVxhcnsKBIG9FHEryr0gD8uwKh9TRGMhsbIKe1Kl/Qhsv0ETkGANdLN4qAuO7zmfyxYtvw1MhZgqtvIuQO51fvKkILTL0ZC2/ynfIbNa0BswxriXLe9knh/TeDWaymTYx8abuw9fJRYBaUQ0uZBbqAou3TnSYS8UUGCBDlQhksYnUIXStByN7VsV2fRAY4YlrpVQVKSA0YWmpjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skyhighmemory.com;
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11b::5)
 by PU4P216MB2247.KORP216.PROD.OUTLOOK.COM (2603:1096:301:12c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25; Fri, 26 Apr
 2024 07:21:54 +0000
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::b40e:6aa9:78cd:c4c]) by SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::b40e:6aa9:78cd:c4c%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 07:21:54 +0000
From: KR Kim <kr.kim@skyhighmemory.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: kr.kim@skyhighmemory.com,
	mika.westerberg@linux.intel.com,
	michael@walle.cc,
	tudor.ambarus@linaro.org,
	acelan.kao@canonical.com,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	moh.sardi@skyhighmemory.com,
	zhi.feng@skyhighmemory.com,
	changsub.shim@skyhighmemory.com
Subject: [PATCH] SPI Nand patch code of SkyHigh Memory
Date: Fri, 26 Apr 2024 16:20:33 +0900
Message-Id: <20240426072033.331212-1-kr.kim@skyhighmemory.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:100:2d::32) To SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:11b::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE2P216MB2102:EE_|PU4P216MB2247:EE_
X-MS-Office365-Filtering-Correlation-Id: cc17ef1e-1a5d-4937-dcb3-08dc65c18c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3E9poI+jBHqQzCpJYC+tFPh86k0N5p3CfCxuVVEidvsaJibXBqfIG6hsn4KA?=
 =?us-ascii?Q?/mzdqvDUjsq3JgUT0fPCkT05CJCsNbBC6g6YnpapwKtEuCM0Sozx6GM3vAmt?=
 =?us-ascii?Q?ssg060j4AR246QspNafepGHS4Q55wR2ZLJEHpMF4oQsRPu66AQ6n146HDYQc?=
 =?us-ascii?Q?c00wNCaxm2myBX3CPkK6VigJ5S0ykg29nmLpHenywnEwVrkwj7soGob6c9Lt?=
 =?us-ascii?Q?+hSQTqgoYlE6kbYKiRURxjqXECeGCfQNIg74IzC0BATRx++7N7g8+AvyHG+J?=
 =?us-ascii?Q?KnZso2Dp6V6cseyzZ+dJ9PAer26XI+GG+eWxTdMFz/ArjoZZSTaIBouCfk2E?=
 =?us-ascii?Q?peGKq6qxDLihTryIJCvVbcxP14s4JEQBbg+KwLWsMt3TpNCSOLivwFCvrueV?=
 =?us-ascii?Q?8u2rAHhgBsldOtb7/AE0Sc2cxa1YRjjWoJOgnFJF9cnhl7/wPyqHzmNsZMKc?=
 =?us-ascii?Q?DtNHcF08Duz5CLbo+nbZVV4eEa2TmTNDb9fayOChvOjJy0PSPBkJhfWLS8BF?=
 =?us-ascii?Q?SG7ss20PGsSJw8aJagOTgRi46Qmm8LEVBfEWMB30/4oeL9KzTp6y823o4oni?=
 =?us-ascii?Q?Ehh+2Xd9JJHUCikzsNWvCrAL8IDAnoqRCJXhlkbMH+LWAuhvbLQ+NTIWCIMM?=
 =?us-ascii?Q?HX90HgLXbkqKvalj1xy9UoIBjoFshdwRyEi3h7ecwPbeL69dRqdhQ2oQhlFf?=
 =?us-ascii?Q?BXJzO0LJt1RbLsHrn0a3ldCwmRXVHbkP3C8rIl6pCXzubJ3U5OX8FAEPvP8K?=
 =?us-ascii?Q?XkCCBNuBVLNuVoxf9p5QLiZb7mulZ0gT5rlhjqLpXUJtanDNwmuXzICI1Qrk?=
 =?us-ascii?Q?PZ18bfhe5JUdbNvLosnin7jBSbyAjpbukcSZtrfj1j7p4jX0o6Jc+xcm+2I8?=
 =?us-ascii?Q?MS2aLZhR4OMTH551IfH1lyE32DRCNOlcOC+IGt8iJKe/Tfbl51TfNRNpWCSa?=
 =?us-ascii?Q?cun+iurN7Ya+NxOgOgMypo85ctzH3nwolZ8wa2tIfg1WkyZl/6/eJnPzk0qF?=
 =?us-ascii?Q?2BgaOckuQjeYn2e5wwJqGR9SOPn3/f3si2nPqqeku8k/d3DqwzvD4FHetOYf?=
 =?us-ascii?Q?uQYllsKytlgH5lUSoG3imsNUP0o1Db906Y8xcN4RZE3U9ZheRijYGBlf/QZ3?=
 =?us-ascii?Q?aoSGZ7N9D3ZYYIZXC4O+kI1bW1JjO9FpYVLxhruRIqp9so1ju9PSfW0zDXp5?=
 =?us-ascii?Q?x/d77wezsB1IAhvOkPUQddR2RZEx9PcVeLM7f75sXt89n2QQnzrl/PE/T+eo?=
 =?us-ascii?Q?QJNztRAeF9M8Tdk8HWfqW0bwr/XCjk+ecpfRClmxHy2UQqgNvQw8OP8lIhR9?=
 =?us-ascii?Q?yggWXTequKH62UHzvC7T6xoPrs4sWrpvpuyTZs2isvuArQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE2P216MB2102.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zmqNj4PsdSjdaQGuUGFuZzXYk13C8T+1a4UmAXV6oglu9ua5cwCDvm7Q2IPk?=
 =?us-ascii?Q?X7A0Z8eVRaRTjzorI9FNCEJED61FhjIIE2PYFNVL5TwCC3NR2rtxC1j1eyoz?=
 =?us-ascii?Q?FLylDY8/0OziQqAslGRYF9EfnsxJK3KKp5/71Cxi40zz8Cfms7P2fEMn+k+6?=
 =?us-ascii?Q?LV/DQTxf6F6ICTQ85fwTA19fKya7O21eSCQS0VUqT6THOSzsBKrpZDxpf8Ju?=
 =?us-ascii?Q?tRg8sBnf5aBjOFADR7Q8Pwmn+yQyN6AQDzHYjHpoy/QP7qeg2DQhMaC3LfkJ?=
 =?us-ascii?Q?tT+SL+eyO/NtyGvioFoJzRzPW4tkoNNnU5OdhgkWxtEwWNxUn3hX/ft+xVjW?=
 =?us-ascii?Q?pBLXAnlKTrXCjOJoGOwVbxv9Mb6t0yZImBIhfzhvnh+DSmtrDIm32vgNB3Sh?=
 =?us-ascii?Q?FMOicyKDiZRZeHZM24xouFkpiOu0j+OhlFCQMKaTkIOFp6WfMVrgRR8Q3p0a?=
 =?us-ascii?Q?CbqKFylxmNpboL+cUqDmUxk/6CbqKfnX5tRlnxrETL7je+no0zcDu83v9TDu?=
 =?us-ascii?Q?Duy7XKVOC9u7GW70q1gFSy8x5iA5aNAPM4hDOO5qDsxWEd8mlfgKuRgAXDmW?=
 =?us-ascii?Q?oT+8xW53L3PD8+QBdave8zHd17y9r6+aY4IuGbcbN0T5+rwpGdbGCo1Utz34?=
 =?us-ascii?Q?tPyUjXJYjkIu+EO8E6bnK8e9zvpLtkGdL1tr+fmDdraR5RkgPZ2dHj5t8Mch?=
 =?us-ascii?Q?7vpSC24TkL1kHRnH9Tma83WCx8KgktD4PKhDGoB0TOOgiCbHh6gvr0F3AC91?=
 =?us-ascii?Q?zSC84iggytrKlwI/q/O7JMGZG3kHjBaJzbOvWRmWz6QDk7hRgfkeozav1fgf?=
 =?us-ascii?Q?w3FFNyzD83J7mXsccFeLuWzjyTKQ1+MgkiktVPbD4woNnPaxzNxsF8Ufh3Qa?=
 =?us-ascii?Q?Bb6pDZCKboV19VkfcloYAgj/cciUdyBs/+fJgt0SsX9S9kGbQZ5KKSlw2rnL?=
 =?us-ascii?Q?aV+GZBM8tkLEwU2EGJ63YP2WtxXPJGxOXGtdAKZGk0kvzcgwR8DRbLy4wtEn?=
 =?us-ascii?Q?q3rOKJY7pRaW951tkJaKQV9aEWhLXSNyy1cQbdQvD/Jx0UoOQXr1vsMw+82L?=
 =?us-ascii?Q?qMZ5Q8ZmVLhemVKpwDH0xoRPP1i1tgdrzXNVYZpp0bLI4yGCi3JZ1r5aFUzg?=
 =?us-ascii?Q?QOKBQMf/hYCi48CYAlbERUh0thH1SHjuNsXXpGzKPAtajnQUBSNgfJNeMUXQ?=
 =?us-ascii?Q?sYj2pFDZh+bBXbjJRhySbqaEXdyyg0/BW0uE5iRImCU8mhhIdYgGqzcaRZJe?=
 =?us-ascii?Q?QGprNxs4UjAMdCfUgxoBiMTWwNQIh7dcGOA63Vd3YQze2ReuVGjAHxEhTHrm?=
 =?us-ascii?Q?BR64eMbGx4dcmlkuudo6Qh1krbE2xTNlFM/ZwXeUPiQijGUcG9Y8NtirVtEg?=
 =?us-ascii?Q?FJdTMjIM0CvFwk/1Tok7EMem7mlxZqQegnIjnL0arZaUQVH1H+CNaSWgfpBl?=
 =?us-ascii?Q?msNKHKz4zYuGMB/VKmntk3BcZ/QlE0OZ5sJo+2OWC894TrlgwFxte7i/uy5X?=
 =?us-ascii?Q?8aran3J6IEHavVWY1VVEF4GR8NS4IYsnPNfPiOkGBT6YnGUf2Ej1+p3ovRUQ?=
 =?us-ascii?Q?c57OaBXlTJ6jRkSjEQmnyw8Ez2Yzj0wAZHG/76D2mWPIDdUhKGMmGcJY6w3h?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: skyhighmemory.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc17ef1e-1a5d-4937-dcb3-08dc65c18c6e
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 07:21:53.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 39b82b34-0966-49dc-81a7-5bcab7ea53c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PW6ZafSgdMl81SQlBamW4q40ZkjXTpeTgGYsqiDtvgZ5de9Gr+L/UILnlVC9R/bbU/2bwkjsko4Qh/sZXhpImsu6pDU797aOuqt/3JicEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2247

The following list shows the additional features that are required to support Skyhighmemory S35ML0xG3 SPI Nand:

    [Always ECC On]
       Always keep the ECC On during Bad Block Marking and Bad Block Checking
       1. The on-die ECC feature is totally transparent to the host. The ECC parity bits used for this feature do not occupy the NAND spare areas.
       2. The host is free to have its own ECC engine by using the spare areas that have standard size. 
       3. We provide this patch to enable users who have limited ECC capabilities on the host side to use the NAND flash. This patch has been tested thoroughly on Linux. 

    [Change ECC Status information]
       This patch changes the ECC status information as follows to maintain compatibility.
	00 (normal)                               
	01(1-2 errors corrected)          
	10(3-6 errors corrected)          
	11(uncorrectable)
---
 drivers/mtd/nand/spi/Makefile  |   2 +-
 drivers/mtd/nand/spi/core.c    |  14 +++-
 drivers/mtd/nand/spi/skyhigh.c | 145 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |   3 +
 4 files changed, 162 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 drivers/mtd/nand/spi/Makefile
 mode change 100644 => 100755 drivers/mtd/nand/spi/core.c
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c
 mode change 100644 => 100755 include/linux/mtd/spinand.h

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
old mode 100644
new mode 100755
index 19cc77288ebb..1e61ab21893a
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
-spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
+spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
old mode 100644
new mode 100755
index e0b6715e5dfe..d09b2bd05284
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -196,6 +196,17 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
 static int spinand_ecc_enable(struct spinand_device *spinand,
 			      bool enable)
 {
+	/* 
+	 * SkyHigh Memory : always ECC on 
+	 * The on-die ECC feature is totally transparent to the host. 
+	 * The ECC parity bits used for this feature do not occupy the NAND spare areas.
+	 * The host is free to have its own ECC engine by using the spare areas that have standard size. 
+	 * We provide this patch to enable users who have limited ECC capabilities on the host side to use the NAND flash. 
+	 * This patch has been tested thoroughly on Linux. 
+	 */
+	if (spinand->flags & SPINAND_ON_DIE_ECC_MANDATORY)
+		return 0;
+
 	return spinand_upd_cfg(spinand, CFG_ECC_ENABLE,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
@@ -561,7 +572,7 @@ static int spinand_reset_op(struct spinand_device *spinand)
 			    NULL);
 }
 
-static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
+int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 {
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
@@ -945,6 +956,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
+	&skyhigh_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
 	&xtx_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
new file mode 100644
index 000000000000..f001357b4d85
--- /dev/null
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 SkyHigh Memory Limited
+ *
+ * Author: Takahiro Kuwano <takahiro.kuwano@infineon.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_SKYHIGH		0x01
+
+#define SKYHIGH_STATUS_ECC_1TO2_BITFLIPS	(1 << 4)
+#define SKYHIGH_STATUS_ECC_3TO6_BITFLIPS	(2 << 4)
+#define SKYHIGH_STATUS_ECC_UNCOR_ERROR  	(3 << 4)
+
+#define SKYHIGH_CONFIG_PROTECT_EN	BIT(1)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int skyhigh_spinand_ooblayout_ecc(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* SkyHigh's ecc parity is stored in the internal hidden area */
+	region->length = 0;
+	region->offset = mtd->oobsize;
+
+	return 0;
+}
+
+static int skyhigh_spinand_ooblayout_free(struct mtd_info *mtd, int section,
+					  struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->length = mtd->oobsize - 2;
+	region->offset = 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops skyhigh_spinand_ooblayout = {
+	.ecc = skyhigh_spinand_ooblayout_ecc,
+	.free = skyhigh_spinand_ooblayout_free,
+};
+
+static int skyhigh_spinand_ecc_get_status(struct spinand_device *spinand,
+				  u8 status)
+{
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case SKYHIGH_STATUS_ECC_1TO2_BITFLIPS:
+		return 2;
+
+ 	case SKYHIGH_STATUS_ECC_3TO6_BITFLIPS:
+		return 6; 
+
+ 	case SKYHIGH_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct spinand_info skyhigh_spinand_table[] = {
+	SPINAND_INFO("S35ML01G301",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_ON_DIE_ECC_MANDATORY,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+		     		     skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML01G300",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_ON_DIE_ECC_MANDATORY,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+		     		     skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML02G300",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_ON_DIE_ECC_MANDATORY,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+		     		     skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML04G300",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 2, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_ON_DIE_ECC_MANDATORY,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+		     		     skyhigh_spinand_ecc_get_status)),
+};
+
+static int skyhigh_spinand_init(struct spinand_device *spinand)
+{
+	return spinand_lock_block(spinand, SKYHIGH_CONFIG_PROTECT_EN);
+}
+
+static const struct spinand_manufacturer_ops skyhigh_spinand_manuf_ops = {
+	.init = skyhigh_spinand_init,
+ };
+
+const struct spinand_manufacturer skyhigh_spinand_manufacturer = {
+	.id = SPINAND_MFR_SKYHIGH,
+	.name = "SkyHigh",
+	.chips = skyhigh_spinand_table,
+	.nchips = ARRAY_SIZE(skyhigh_spinand_table),
+	.ops = &skyhigh_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
old mode 100644
new mode 100755
index 5c19ead60499..2856eff28bea
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -268,6 +268,7 @@ extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
+extern const struct spinand_manufacturer skyhigh_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
 extern const struct spinand_manufacturer xtx_spinand_manufacturer;
@@ -312,6 +313,7 @@ struct spinand_ecc_info {
 
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_ON_DIE_ECC_MANDATORY	BIT(2)	/* SHM */
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
@@ -518,5 +520,6 @@ int spinand_match_and_init(struct spinand_device *spinand,
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
+int spinand_lock_block(struct spinand_device *spinand, u8 lock);	/* SHM */
 
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.34.1


