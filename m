Return-Path: <linux-kernel+bounces-46116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C797843AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712801C20A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15576906;
	Wed, 31 Jan 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="vPAT51IM"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A56F066;
	Wed, 31 Jan 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692363; cv=fail; b=nx8XySJrLCzjvq3fikul1Sv/A989E4pt8wwBWH3eewVQUR0P+7glsSquD76E83fycnykAK/Lc99WtAMW9IhBAYHO5jqYsg7ipFiWJHbwerDjFypNCXmQkFdY15zxMdrrgj7oWJEgp9rzDjJxtP21T+riL6Nbcf6W19uvzEU6QTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692363; c=relaxed/simple;
	bh=Vcn/272q9Fsc9S/AGX9VO+P7Q37CJ6Cgjv4A4VGblF4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qay9pETtl75oN6JxC3Tb0+ZqCduVDQO4sD71b3qwWMdWDVDhPtbCuouwZBcnsF/1WjlrW4HhavmG97u4Az3iR53mskeiGkop9Wj6WDk44u/HENXUfC6KoNguHmXdl6ggNs5gXyORJvjqzpuf0zgxaybT5d8XuKXZA9z2VeaRKJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=vPAT51IM; arc=fail smtp.client-ip=40.107.255.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLVQl4o5WtyvYyvwEu67kJDuefAR2IJAmBDb8ePgz5Tuf+anm8AcSCVyTOu2wwNXWXpDklxbDn18FwkH/MvCOpDTXPsZcL4yM93D1CbRV+Ia06ECSMypUhF/99b/IHFh7roUlH9SpLAkXa0LolBUjGcUjdTpt5POAz/ukIOojZLRfcWFQyZ0M2dNP21nedYVN+TDCX6C03ptCaeIaXT/i4ire1enoeS+9zix2IAoADXTvXq+LlZWaAyFofeWkvz6zgs2PPfKY41N4/OzZtLgxx4no2kU545ug8/qRRXz5NXYlEmxkY6MZVhUS/8YJ3pslXhCrqAO2mfSqragCxPyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qbfzc8NLSnzxJeWKqi8t6fFb2t0G3jJRCH0/9Z0XhUM=;
 b=dTOURN6eUe9IO2PZWWXGw2bVJUieccMl7LCaqrdBe+MPR4S7swSb5PaoBmM3GUlLJmBmSCbE0pU/AstwrtJdDrDzyrbo6BAeQztflnhQOpfiZPg4/s6hWMdafA1Zzok96F5owICtV6A1qyZYl5YEJV+nw12+05ivYri2zPTTsS0VvY98z0d0ws+Cj9mcMRkBwFgFqs9Ilk9uwKiLoGsQHfUR1q2wy9+wpt0iI6YZfgRjyzePWf2ohmZ7px0rtA8UjqeAmeXVVA7ot0ZNSXz/rAj8Gx9l8F0dOUjfDzwi4Vj0El2Est60ls7XaJT5C/jq1pIkWMfmitHxmL2LWttT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qbfzc8NLSnzxJeWKqi8t6fFb2t0G3jJRCH0/9Z0XhUM=;
 b=vPAT51IMEjtadLwtP7Wkzw8U0sd7jwk0+KiXSHsYfEmS21WyrLCCuzpVSLd8J8/pKiz3eQ+/v1oQSm14EYd3QDzK33CQbb83JXUqXysXCm2e4SDG2X+3xldzbwtW5lRMluA08ZiKL7wHcHxrGTNwCxx/gpm55viy8zrGEGbZkVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com (2603:1096:400:71::13)
 by KL1PR02MB5137.apcprd02.prod.outlook.com (2603:1096:820:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Wed, 31 Jan
 2024 09:12:36 +0000
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::dcd4:944:72ae:1f3d]) by TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::dcd4:944:72ae:1f3d%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 09:12:36 +0000
From: Puliang Lu <puliang.lu@fibocom.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Puliang Lu <puliang.lu@fibocom.com>
Subject: [PATCH] USB: serial: option: add Fibocom FM101-GL variant
Date: Wed, 31 Jan 2024 17:12:24 +0800
Message-Id: <20240131091224.30064-1-puliang.lu@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To TYZPR02MB5088.apcprd02.prod.outlook.com
 (2603:1096:400:71::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5088:EE_|KL1PR02MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 7804d68d-0f9d-4ca6-f0e7-08dc223cc400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e+QMhHMM/h3nOxhT41AdgcXC0QRd5Nq2Re0NARN6iriKBZPHRYYINgX2BOLieh3xCVvaUj3z7DJC5wTmr9NiInouhxejCD5LonHl4xE1xO7N1S6s6oFkK6BRtHxkms5+3msqeRGG8+xzC0nXgHZEPs+ggifJoO0st3D6qt6lxV1gLl/Vm1UDvMrscj+wO0HAo1R63uXEilQflVkE/d8OsrfL8twDPpKEfN6RSQyY1wbpTy5D0z76xtirV99PlcbOAVoyWYJtWBTOnnGDgHECLJW/c0Ri804aeQ7yO8cZxjiUNQwtGIMuNpgHEYTbCgx6hSec7TfepnM7NguDAGlveeNIqxwQHhBBwxQYugHbftxYyJkCFL08tSRYAU8KgRLkY5KMpY6zV1H/PpzYzLy3WHkFnp+VlyXeTKtXTof21FR6yE+WG+MzFyoZAlT2r0eB6d/3EhWPZaN1tM40o2AQ6BuezcUcKEhiS1nyHulzvNTsnAoSSrJ6dqfWYAKXA6oiJotzyJEchsqjnPk/wsXpcgDPS0hFKxBJDwTj25TEVKc50WInARXY80Ex7qGhSXq8BjNAapgYMT5n3ZWUx8kUfksEC6Q9DRy8LixF8VvIv+/MhhoMWbyjOfz/ZXxzYpEE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5088.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(86362001)(36756003)(38350700005)(41300700001)(26005)(107886003)(1076003)(38100700002)(6512007)(2616005)(6506007)(52116002)(6486002)(2906002)(478600001)(316002)(66946007)(66556008)(66476007)(8936002)(4326008)(8676002)(44832011)(5660300002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iMdEqilOvTPZIXImN7s1cx+aTjtJ75YY+xqaen+cHhdso8E7PkG/dlgKZyCI?=
 =?us-ascii?Q?KUC0Edx7vug4IxJFREBVUhxOq6f2urgJ9RrpMdpl0G7YhqNln161cqRCLfEj?=
 =?us-ascii?Q?zBKrz6PoWuHosEwHG54SidxSVFFyqsnQhrJPsxEox0waJ8UhqBQC3ngaMTnM?=
 =?us-ascii?Q?LWMJkBcqUd28zE0qTQqbuF7JruDM/ITReuuazQ5g+u7c6g1u1QvVgmybn904?=
 =?us-ascii?Q?yMrBNc3GYfYIPr3leyqgOtc/ZxEf/sRJr0/EOeeL21tds5Ke+qxb7ksRCfKP?=
 =?us-ascii?Q?T1MVv0aMHRsGYroG3MYzic4uOCLWjUlLrhvK1G5Tr4SFEbyqI6ztcztPJQyz?=
 =?us-ascii?Q?UU8o/RFWdGxoMSrIti3VjlTkINBtp85ADybh6B3Uzlyn922KnawdvMewCjfv?=
 =?us-ascii?Q?lzqOib1V5lRzjce6RVh5K11YDbIVthXkmdZ/Bw6yY0/U6DCbXxbWPVbZd68s?=
 =?us-ascii?Q?TxU/Qalhk7h3al30UNpP94FwKWis6QEg7KrTEDoF4XB/Xj/icHMGbuSCKUg2?=
 =?us-ascii?Q?7v0OXb4qZvDniBpxu17o5vtY1mJZpMrdzTOY3hXCXphCve9jWkwp8LJmOmIk?=
 =?us-ascii?Q?LwUEJtNPzg917f9Nq2xYJnMWVXB3AlFsV+UL9LRQZlRaeSPOc7+3ziYNZVAW?=
 =?us-ascii?Q?FkYmXfJ28pLzHtpBZzvYx2M6kdYsvAA9GI40sRZdiDHpSghJuLloGKKwHge5?=
 =?us-ascii?Q?S9ePm1LzMajKoUl02iFRkIfjngJT4w2vsF1nsYgR1VzNrqmnBGy6/iExywXc?=
 =?us-ascii?Q?UK0YqCijHiRgYQ8avEYOnzT/Adsg2McaMxRj7+11SKuy8jKFqNDKhkI6Aa5f?=
 =?us-ascii?Q?Seji0zVeQoy988wJWcgxCnMwz098QaDk4AWXmLbGADbRnwnb317OlpX8uLqH?=
 =?us-ascii?Q?k/NhFAq/of470YyszLaB41+ed5jVc8Mq6p1jII3ADZL0tNuEt1gWyHysWiOg?=
 =?us-ascii?Q?SqGlB6FRNPmmIrdOLRkpx+WbC/nMYTuT1ebW6MC2P+qggL1RDLkXwPTDRn7W?=
 =?us-ascii?Q?Qll2vLkVfTEVrGOBaf21iPpsWsz2+AvFO8/ffOdEal7nM5nl4mj+xb9oVYpX?=
 =?us-ascii?Q?e9dlVOUb2sI7vcnbKHHVM3Z/TsofTRxaIvFmWpequXKm4CxE1NwqQ2uwcEBq?=
 =?us-ascii?Q?D/5QWR8niUo+Ob1DSfRF6fG8gwQQW546S6EKGpB2AHnmyfSMxQVPyyCkP4oU?=
 =?us-ascii?Q?PfJdNMH1ue69S3ThDlYpAd6TrDNS67G9uzEiVdvqiA8uZ1FmeBB2ca5a16Mi?=
 =?us-ascii?Q?/dB3Wxobf9lZz4SBrlDwyvyA+RKUC4iVsA4nnNG8E7ejnXoHLC9SXAjbbRoq?=
 =?us-ascii?Q?XpxqIKRd/e0e4zGXGAXjeP8FLhIhciB+7IshmVDCsGsRigj//uFa/YDYUz4B?=
 =?us-ascii?Q?Xatv/oUguJ8ky+l/NdyLLb2xd8xTMYCgs9bf3md6GfSlawM54l2asGXTJXaP?=
 =?us-ascii?Q?vBN9LBILkzEICl/A4mKBQG+Hr116GV16dN/VLUt39hLP+Vk60qd0AFq5e1YE?=
 =?us-ascii?Q?FooqWEGPMowLl4YF8na/4I1fygajVLz7LANLRw8+FC1hdXUkS3EYtWkY4uJQ?=
 =?us-ascii?Q?MX6CAwAQt4EdN/UhtjmDFxtPsry+UReGA5uTgbrhZEn/9QCcj5Wt/FOF225z?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7804d68d-0f9d-4ca6-f0e7-08dc223cc400
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5088.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:12:36.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R17MMX+9bghq858tf5PlPP8ieooFiFXGiGvzFjoQelnWP+Qreknu4xkNXYo49/7K31RPretb+SllGsCEhnwlxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB5137

Update the USB serial option driver support for the Fibocom
FM101-GL
LTE modules as there are actually several different variants.
- VID:PID 2cb7:01a3, FM101-GL are laptop M.2 cards (with
MBIM interfaces for /Linux/Chrome OS)

0x01a3:mbim,gnss

Here are the outputs of usb-devices:

T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=01a3 Rev=05.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=5ccd5cd4
C:  #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=896mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms

Signed-off-by: Puliang Lu <puliang.lu@fibocom.com>
---
 drivers/usb/serial/option.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 72390dbf0769..2ae124c49d44 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2269,6 +2269,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
-- 
2.34.1


