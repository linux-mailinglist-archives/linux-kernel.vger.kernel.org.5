Return-Path: <linux-kernel+bounces-93638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6718732AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D8DB2A285
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182265DF31;
	Wed,  6 Mar 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="Mmnza4s/"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11021007.outbound.protection.outlook.com [52.101.133.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA45DF21;
	Wed,  6 Mar 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717750; cv=fail; b=ZTgm4ngZ+hsF8D+n1B8Zpz2m0Iq9E6QRAJY82+5K3Jfs0482UuQFKynaOkqqEzkZGY5dSjsB0BO73G0Q7mvqcdK+qsNOH40sUtbQL9WKa7hAa1+hKkccfeg9CLQ86fXzkDr1kAVO9ffbSm7AJ7BLS1s64XBoFaLKbOpHPjxusu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717750; c=relaxed/simple;
	bh=7oLHKbm0r4TEDUCEZ8CZBoZ1ZzBTXlG2aBlV0cUdKos=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YpvIEtgD+UeXENeHFsMfPJp1iqNzgdJUZNK547A1HrBXE3dG/An+TnhencshkAjakZhNG4SKpWk4Qh89zLnAIfSi72IGVb2vw1U4RpXdZ1SsqnTJekU3EsXAvsFQXYAJf0Kl2/SMH1lnTnnpJHpdu+lP8tgktjJjulDKsdqmmt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=Mmnza4s/; arc=fail smtp.client-ip=52.101.133.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks49sJ4OgnRGDpO9R7BCaDv7FJWUARl++HaZSmCKl19zr2F0zrkDAkEZiJvnN/ZHYC8hNdse6asOX6SrW+YXflLAcjQY/ufwmGm+WZwFIx8cQIq1ccCLx19McZctAnHKRl9XVP937tkT/nikButZVE6so1HpgL4+21PhhWHBkgFdLhrLa3JvR3Mfoh9IUPAvxu7RmlUmyXwYNQGZjAlpxfEvGRxqiMMfaupWqUBpoLF4TGL/ylko0aqkVwouzswXdFYpOfioMw6+InqrrYLxi7GlR3JHX4u28Wi1X+JhFSoYlR/HkyLxQ2yA8vKY6c3lNClcIh0B9/51mYDTLOmITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaslRnZQ3Jkyq5jyTIxiZsAU8f4jz+uwRHMhy7E6Kys=;
 b=DjrLiUVQ31rAF1ZKo3e/N6/j5VWtuvNsxmMzQOVufGtELDCuB0awzM2h4mO56jQaw23MnUXKznQ5nEVJHVRguAqypqN8FqjW0s1ojtFeHoz4zNbUJ3wtGiN9h0Lu6fnhvHxKYiUfl3Dt8UrytIPNSat/1bdV6JdYsLUYzRTFkI5NNODWRR7jtpzdTJ5EjIDv/GIKhF2hlcO88eWlXcFVdfO2TP8RQF+TEur8M8DAD3sBLBoDNeDxwt1/wXsQbVkcnG83nujvCZTaNPD1LNbXKYH1+Qp3oLc+NwsYspOQZ6z003VpBLd+gX3HJ3FiSQNed3qiBrS5Dh4TCDUbzJuh/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaslRnZQ3Jkyq5jyTIxiZsAU8f4jz+uwRHMhy7E6Kys=;
 b=Mmnza4s/gtQO/ntj9aMeBDktT05kcNrbj5xBgYpX7MudBEkOlYd5kJ+ZL+TkVIyGKm/7Hj5b5deD9S87E3DqTYYieDAbb3YBph2cYhXIXDAHLAmfZGYk7VpL8AlqmVbG4LRvxjANMDcgnM34HmuNcxG9Xg5WYCnbQvtgWx5q+C4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com (2603:1096:820:dc::11)
 by KL1PR02MB6378.apcprd02.prod.outlook.com (2603:1096:820:e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 09:35:43 +0000
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75]) by KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75%7]) with mapi id 15.20.7316.023; Wed, 6 Mar 2024
 09:35:43 +0000
From: bolan wang <bolan.wang@fibocom.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org,
	larsm17@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bolan wang <bolan.wang@fibocom.com>
Subject: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Date: Wed,  6 Mar 2024 17:35:33 +0800
Message-Id: <20240306093533.1313241-1-bolan.wang@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0138.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::18) To KL1PR02MB6283.apcprd02.prod.outlook.com
 (2603:1096:820:dc::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6283:EE_|KL1PR02MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 108789f9-5e0d-4c18-e8c7-08dc3dc0cb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U9fbCFPf5zXWpBGfS8vFz+IESH6yPxY300PeaO1FGVTtJrw/s1IOXp4Yse8vOrJBUwrZN6414qS4M6KVcRuZbpXQQ563Crw2PSH5GgB7ptZjtkdnkAPt+vbzdh8R5XwLxZLv8bfFSYARbL2nqBsqtlTIE4j/R9TGPS899savNrBb861bOQ5IJtKBsobggkBNAgEpQKtO7EqJuos2DiooyaEQoCB2/U6DGfBGQBIz7ZCVDAc6LBUssdULwzmKcyRwvRGl7I4aO65/rk29mu950q5CEuciQ8yZi2GsxLiTOXCAgms9yaGza3zhfID9+77K1CeqUm/dcAbBbmFPFddYoiul7efbS9C4YqNyMpn64aUct/IMqkoZv+uE1xlkXgDcBfxFm0ke5SiOyewupNC5iOMocFK4wVUOEhXVDB0ksWyePvhhXiW3j7OxyWAEH4pSKMcbNvbSXoGSZ/K8GL7ERwy2xyGkSgLJOKKik6Ad6+lZgeF2Az2/R89cDkarPa77oLt3Oz3vUs3xYd9TEDqHHx7aMyPJ0NjAELJ4aBV6+mG3NJo23bB9sk/KvOb2ChsIPn7aBkUmZBekNqoD7COY8P0LfgftbzgSJXglVQfaFuc62cscrJ7FAq+V+Q8VxAOyFtm6ecwwnsky0/h5oAfxv7tA2albkoK8Kj7jpiC3NkflmS/c4VFdLw0LhO3mjdMEdqt1siMQb/9isdjAXrwxlCwkb46ACaQ+02rO3QHwefc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB6283.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/BTzlAmz258XjM5pPtHVeNGfnGrpbFjMXodgsMBsGOR5IYOUABN/qFL4XdX?=
 =?us-ascii?Q?5DXiWTMupdJffePjctCBl3oymHTLWGKWblod+kD6XepndJx217DFlYjBk89z?=
 =?us-ascii?Q?AxIvzeIlN9GKl+1iW9cGLmkCeNf5C8yQ17L8xEfMNk6p0QewR3Fp6JnXc1pg?=
 =?us-ascii?Q?YqUFExfxo77fG6q+Mj4Xiu8m+i3QztbvchIRGoKtRKmHXud2Q3UB3z5h0PPT?=
 =?us-ascii?Q?sGsko/N6kslhHoPtVtJw+nct0qUxoim90z9xCeZ395sC5is5B5uXTBcLl917?=
 =?us-ascii?Q?haRcPRoJ9ylERjN/Ztp52RPYVPvtazTfWdpsqqS/jDZ0V7ddMtT9/+RahsGQ?=
 =?us-ascii?Q?NyBcoOWiltjfCHtLkvAcQ8BeOsKGudaMU2A5uLbGiYkW7CN+IzEbMLm8Dtk5?=
 =?us-ascii?Q?n1xRH+tuLhPgSwXob/EC4o4eksyvfzt/1KwjHkGq6IALC15YIYzaINRgaW59?=
 =?us-ascii?Q?Hk9Lqba6/Kp8FzR9lDHBy3MIhXEnh98+9FZAUw7nlJm1nMROpBOJbIFKvjxH?=
 =?us-ascii?Q?cAxPeuobtVzP3oUq/dwFT0mqjqU8d2X++r82qB0ymrTOXT5WVJnQtM/k8YhA?=
 =?us-ascii?Q?gyOTtE+AsXsL5MxFB3IX+6QMMrQXj1lujdzhdu3orO1Ut+pqmUIewi9R5GcU?=
 =?us-ascii?Q?V4UvkJpcROVmvxIGxaJ5OoTvZsyFLP3PFdftvZL6THF4HhlYAEgBwilZPXms?=
 =?us-ascii?Q?vfYBM1zaJd3hkaSS1dhXR/HAmGFVdVZlNozDTO6U35F2NrZw3MQ3MvhY5MDI?=
 =?us-ascii?Q?B99dOineVEnSqoYOhbG+3XGuKqg/pFuujog5H4lWOplL8rAkTYq+mg2XqG6W?=
 =?us-ascii?Q?HXeoPxqdJwU/vEYT7NWRe/NGWoLqwZiVLzCcFlxVZ0zwdKmRuYvcM4QDaSRK?=
 =?us-ascii?Q?oDyisQnGqM3bKpxtgdy3ZVb9XA1f5cz5tdDZ9Z6FaDS1dZ8CMxuiTQavNqIe?=
 =?us-ascii?Q?AtkN2Mvh5L6vuHLZBbJrmt31PEL6YMQfUjAQWgAm7ZtYPBb1vzb5N2PLBRrS?=
 =?us-ascii?Q?THPFsyFfkn+rUhCl4x2yJ5LR/Ax9a7ikEgyxszOsHXRAdxofAJPBO75Alg+Q?=
 =?us-ascii?Q?4T6tWmCxJ+HHBxPuNe1OrXpu8jkPXonTMUkl21sFWLmfxlY+X+O4j/5Cj9QA?=
 =?us-ascii?Q?h/KKPBlStG9m2vy/X86rW3btJGFbVwfU+jJZNO3E0zVHlNW5C6IrF8RNxg2P?=
 =?us-ascii?Q?tRGP1Ga6VlNES+bR/jRwY1q4NBS8Wd1zLoSp9+L8Tx9BGjcZvUTnMj8EIcvH?=
 =?us-ascii?Q?h3aGA9kt53sZvjjMm6qLxrAM2XI6u+jOe0Ws8Z0NKuwhVnTcBiNEaT4+uANC?=
 =?us-ascii?Q?itYLTi+HrHo4RcjlopBEbFvTD370gNy5OF4OMP0Izdq4NA1+84AbrfnAhWWM?=
 =?us-ascii?Q?N98AeHm5XKu29O1LMlDgbTaB0gKjwjCiaF9TdHiPxoYbRwfY3hkz/4sZ9hAM?=
 =?us-ascii?Q?z4PrJHJ4atIiml3MP23JLSZo6QzfM/IjCMuPrazUwNUmIcwyvbqmhNiMDRe1?=
 =?us-ascii?Q?25gbZ1MdrtrTmrjYTzd9r25ueUYvb4fqmeVvwZD86l04nP5v74gmLI0B7DKR?=
 =?us-ascii?Q?colocviUb9VqzUqNtEAMogh3UhEZYGeqzt/HSTxmwndQQILF8Lepp/Q1ggic?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108789f9-5e0d-4c18-e8c7-08dc3dc0cb36
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6283.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:35:43.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRHR2WACUqQbfTovFc3h+85r4zUi1AzJnQmQNdAZBm31XONSTPkc0K206Df0iu9tH8dzX1/hxDmxKwFKzKK4Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6378

Update the USB serial option driver support for the Fibocom
FM135-GL LTE modules.
- VID:PID 2cb7:0115, FM135-GL for laptop debug M.2 cards(with MBIM
interface for /Linux/Chrome OS)

0x0115: mbim, diag, at, pipe

Signed-off-by: bolan wang <bolan.wang@fibocom.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 2ae124c49d44..c7ea7e5ec875 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2267,6 +2267,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0115, 0xff),			/* Fibocom FM135 (laptop MBIM) */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
-- 
2.34.1


