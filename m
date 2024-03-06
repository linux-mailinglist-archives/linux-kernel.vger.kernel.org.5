Return-Path: <linux-kernel+bounces-93490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD78873090
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798491F22514
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3475D49C;
	Wed,  6 Mar 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="jK1I7oyJ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F035C057;
	Wed,  6 Mar 2024 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713237; cv=fail; b=pfIe9A9zGIO6zkIq8Ut42k032pyx7tpp39UmeOkktiwVUvGxxawF/ZpB/9oXArgGjMAeG63Ngscphjv9STCT0+7KmXVy5BE1Pl5MoD5ndbMuTkvfqr55z1vn1whWnIQk/sC8dWhCXUinAf/iiZWo3NN+YUKL4TTz7uyEfKenzy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713237; c=relaxed/simple;
	bh=9Kkx3qVbRiYmSqz52+xEJPs7nSjmiT/xkXEaviRQGcc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NE1UKy/Pxl3oz448Egf8cbcgX7PdmKVMBnaQgGQTlTXh7IOdCXvpxTO2mYkX5pICHY1v5NnmLwzOgLAYcJBdqwbC4IrmVhK2mQlfqSOlS2TVa+hBe1jPsSNfaZEEwQQb1ROyj8IKGoYq8ozI4gGGt6ICl+LCF44B4enGNjcDlzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=jK1I7oyJ; arc=fail smtp.client-ip=40.107.255.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSvqNDrUPr2Uck9Bpbrr+SftiPTkc/FJEalGIVdQtu7FrlsLesPYthAhzSFunM/u5w4rTgUQtANhLo85aZPTusqulNZJYwLnmZ9jYgpK0rPek1/enuSqfgPXZxU5QiLFX0bGF1UiIjMobo5UHYDA6GhKgD0iM71cM9e8AbrG0v+BoL3SmvW+pxXB+ODrHhMCPsUOMGm/9AK5kvh6VONe0+4umVudSt74btATP0KiTEqVfw04YOSQy6eO4Wq+2s+6nFBdSqec+PWGdd6uQ1CtfTOKiSL4+TuNQONNQVFlfBjUjZTbWiizCBfos1hRtI3OWkamZ7zU+0A45sYs+mx5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8mddwrWO4BNP6S4N7P+V5yo2k6JNMEpf4xQGZsmkN0=;
 b=hgJJWE/kFWOXsYtkLrZiad6UqqaZocCvM5bTFE0W9x0RPLYY2bYw79Xs3kh/QpurIFbxzE1MSbJMJ/XhbisPYiFE2oeBzj2v68Mr+aXKHMgIJAK796Fjqs4+3tMfv/XZNUcsNKPZ+cHbUk7MXmOFBQxjZJPeoVAHmJREJiO+xMRS37z2OMczZNqfcGfS/fgspeBAX2CXGqiFchdJrHkvyC/9WLToJQPT0qiJMBeVNAsO2ijAAbzp5drGVdJodvajnS6ZWRjSG8YYYYabLwbk7WWSNzP4ArbZhgcsWRQK8MjXqQwd4TEkCwZXg1PIXteOKUFtiIpCxHMJYIA8kv2i2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8mddwrWO4BNP6S4N7P+V5yo2k6JNMEpf4xQGZsmkN0=;
 b=jK1I7oyJM/yOnxFu5/79a/DEGF4vrmAidfIw4RQD8iYQS4H9k798sNwMg5rj9KGjr65mQxdqHmMCCiw+CYW4WMnoqKq9wBBGF+6U1ABH82X5MdSl6mChwLElw91X6qv0LHDVH4VjAMxKqrOD1vYdDfQ/jWTU6HSWb2o3oaYcww8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com (2603:1096:820:dc::11)
 by OSQPR02MB7742.apcprd02.prod.outlook.com (2603:1096:604:281::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 08:20:28 +0000
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75]) by KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75%7]) with mapi id 15.20.7316.023; Wed, 6 Mar 2024
 08:20:28 +0000
From: bolan wang <bolan.wang@fibocom.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org,
	larsm17@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bolan wang <bolan.wang@fibocom.com>
Subject: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Date: Wed,  6 Mar 2024 16:20:16 +0800
Message-Id: <20240306082016.1279110-1-bolan.wang@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To KL1PR02MB6283.apcprd02.prod.outlook.com
 (2603:1096:820:dc::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6283:EE_|OSQPR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: eb76e3a5-dfb0-4b9a-d39e-08dc3db647ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pP9POuIeU4nb9uv1v9nAnewkpKABZ8zIlXbMih3DrxKqfp6gmgYx1HF3/QoFai85FvPt1dpEVzra5AjO7hTQsI6HPKTS4la/1k2BMVIABD4OJgv5w2Fflk6Vp1ht1N09dqFEcu/gM0hUw7oPb515BAe7vFkqUYWSh3CJV99QYELjrbSv2430N/nmvWJDcpc2GZLkDrPDfoFrfcXj2NXKnkG+ff17YLIxveBSyb3c3NzPyRuquTZfQXmVnIooopqiwG6hTMYoEL5N6q2cxU4IrclTDSIn+Dm1ywRTpIOnen21JNZ2x+KKjt/sp+bmp0pMtt/kqEZuzO5hte/6rbq2Od4JNM3t9IZL6KOu76jQfBFU6yeecccjzAKBkg8xanjPi3n76kBBbXShCnRRc6WS85at2lm3QcwKEGen8evdlPIFVPdC15oKoagSrCNB27QBDeJ6NIi4Fkucp52IZqxpMjZvEWpRkdNc2w1NDkWbfqy/WTylLLmDkq+0hXAxvlgYbrm2Gchemt361pvwhbtTCnJ8cbSSoaV9NY5jpJbHcQ9xBsrW7FTECeLgf2DMbsiOiHHbB5zantw3Qf5hgCv2UcxV+ER2ZB9Dfa4lJZ8nlhMmVlWmL7EWlEnK6QY+1TRfCaTcabmZCNoL1Cl8dM8fn4PhLUxFeYxrYf0dAoyMvW8Bxa5tRkHmEKEXmDDqUhC+amyDdy6EGyAUi3Zm6+uSkA90zOXT/2eFh6GM/2NNKuM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB6283.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RRjMaS3M+zxlw5VShpkVuXmcoVYL0SYrI2fwFO8LXYs5FSFZ71ny7GBuXVTT?=
 =?us-ascii?Q?V09veoHXqFDl498SdOpfJW7vKWIaBkL0CsYJ9U+KFNtZm3q0LY2YyNl7PuT3?=
 =?us-ascii?Q?G86paaGAjQ/00bWF/qXgNYNGA9B9eELCtq1HZ3mjQ39jKCmEmZWRz59PdA1B?=
 =?us-ascii?Q?z+yXTQloREBKLU5Jt8/dJXfxg+4JKB03rlglq02hTuRaActe+9n6a7TAw0Cd?=
 =?us-ascii?Q?bFCBHqVFKMwCzMne0RqqOR8fuIimiAQpDO+IXeGObi3nHu4jeBfIxYq/DJmy?=
 =?us-ascii?Q?3zx5pZUUTgHdKpcEuEZqRp5smMIxawK/Ba4+XW813xPXF+jXNyyaLm4Lb/1w?=
 =?us-ascii?Q?JC5O2uySZdN4V0eQMG2qIOXI03DTN+OrweP8MYXWoEntODYbVjsz+9fJ2yJH?=
 =?us-ascii?Q?prLT/A9+tY/SvERY+A0QGohj3rcPnaB74LOsvNqdT0fwmTs7bq9CT45ZYaR5?=
 =?us-ascii?Q?6YVpHHWF0cih1rvt1tE2b9nuQ50RmCAAXPsgYiYVH3bVdojCvLhyiO5/MXdb?=
 =?us-ascii?Q?vUe2TPzmtTGn0irLDBUTbVIPcBp8qLw1U87PXys3GqkLzkhtOQt+ARjb+KXc?=
 =?us-ascii?Q?ItDTAHlxD/+FTnhi6WlR50bYT1QAvRI3/GTOaZ1ooZENYOA34sYXjKYjf5EH?=
 =?us-ascii?Q?zVnWeDfI8ofdCKjX9q8Ny87YFyMr7QmtQ4hYOgwb9E7LZG4P1lPjCCuH1VnD?=
 =?us-ascii?Q?YY7xTjTKkBbqF5UWTXdJYYKjdwhZ3UwtvFPZyhpSa3wPSsm8cf9Ecm0LnYQJ?=
 =?us-ascii?Q?p8qBQ1fu5JhhEnwsNi7LDdcJLhl37YJeP7f/ZvLeTgxjyr4R+dICc429gV8K?=
 =?us-ascii?Q?RDU5bKVDXFCnIMEiq9qofhkvG71WsnD20KjIz6px3OObdkiDLI/ByGXzdnTJ?=
 =?us-ascii?Q?vavqhjDOmQpEWTE1ytl2nGYl8yJ6EzuwMmJmNbdhmCw/sRvBu23goOyD75iC?=
 =?us-ascii?Q?sSKXjVYXrWhVgzLLM29dXB6mTNpaRKcH4Dha3Z9IzNA6KpNeLk26gdLCSDYE?=
 =?us-ascii?Q?gDR9WXWhk6yuhkYVaRfd3/CszD/cPNXcfU8qjjGMnLS+QJFqA1to6gxbQHCB?=
 =?us-ascii?Q?azs7Aaw+iLmsQWzd7hvu3kxNtcfbSM7j20vGIW2JQGflHOQDgENWYmmvcylv?=
 =?us-ascii?Q?y1kgsMJsrt1h/SGA6cbZJEPvpfrGA2nSPXafiFyBcBB3PdEaT2TFBAnvPHiK?=
 =?us-ascii?Q?lecZJ+92bwQ7LxLfk1k/6pA7boK1rpa1lmZWx3JErlluojsOCcMLodGJjvtb?=
 =?us-ascii?Q?1mc5q5dMOZ6j9JSw5BBm5lp8LMPJ7dUyiD/PiTueocPVbDoO27ykJl4oowrM?=
 =?us-ascii?Q?ODp+TZ6MILEVhSPzyg0mdbM6CzsJsHpdIc/hV6ZX9ywU37OVeh6zg9G3M72r?=
 =?us-ascii?Q?UTd7JqdrI2ovahSVfSKMoH/pjSh/DNAwNE7qQo6YYLOd4npNcKHCrY5PawvG?=
 =?us-ascii?Q?xv5JhD4Z4qInDqqEWRYtw6Vcnsu9yk4Z7w+lvgSysCw2EbL8nsd3t8t8Auuj?=
 =?us-ascii?Q?fN/sWz+9Xk4TdS3u5Q6Y0okdr68W2RANBmasQb9+aCY2RvQm+bUFIFmVuDAn?=
 =?us-ascii?Q?uAooNt440adPu77rdTaZTRbb5r9yI+eUVgKNux0F?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb76e3a5-dfb0-4b9a-d39e-08dc3db647ef
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6283.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 08:20:28.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ICpmB97Eoqifh5JYEOHoABNpSKlCUGw1fieZ7aiCAw917v84WEnjEyEyJPDo1VBmjPb0ENDTceJqqzmtLdZEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7742

Update the USB serial option driver support for the Fibocom
FM135-GL LTE modules.
- VID:PID 2cb7:0115, FM135-GL for laptop debug M.2 cards(with MBIM
interface for /Linux/Chrome OS)

0x0115: mbim, diag, at, pipe

Signed-off-by: bolan wang <bolan.wang@fibocom.com>
---
 drivers/usb/serial/option.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 2ae124c49d44..ac637ba27313 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2267,6 +2267,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0115, 0xff) },			/* Fibocom FM135 (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
-- 
2.34.1


