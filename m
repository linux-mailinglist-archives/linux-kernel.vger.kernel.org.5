Return-Path: <linux-kernel+bounces-93829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E89873549
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEB2282FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD860DE7;
	Wed,  6 Mar 2024 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="ZnUVyUCP"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11021007.outbound.protection.outlook.com [52.101.133.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C9D60912;
	Wed,  6 Mar 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723036; cv=fail; b=XXjo1PjxQhgzYvbwSq+1fZxjEEvoAmQiP79gNIqBfik1+6dVHQhg08GERsYqNh5wZDTlGJBKmmFh01xJQSiGMM8k+M/3rFWe0G+XYQd8xf+robOsdhsY2tqXktTcu2n2d3l7TY8MaMbIKdElOR+nMzm0hbPS7bzGNBY0G8NCJso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723036; c=relaxed/simple;
	bh=VrYCNP/q5bBVBjnYt+3dEOyoKNvO36hciU28yqPjCu0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Sv0YMdc40NDHZMlOjmjJP6K0VlxDYm+E1QXbyH6rDrF2dTD1bkHSGaDt6CyVkoN2lFg8Xrfp2vf0QRz/iaY0dNoHBp+u5N6l3r3NPYCAjmfB96kQNN+BCoLqkG1k0CKdor2ExujDE9P5uMCQINgyIuFqyyxXjy2P0a/UkfYfYsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=ZnUVyUCP; arc=fail smtp.client-ip=52.101.133.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVukZUrfqK916/9LO1IRJZE+SdmC9uDsANr0D6FLpreh6PmlQrW/H48qq/nqpjQUTOo1f7Ze1GcxAh97mogeyKxJPr04/eLP2r4+hLCSwl7l5X+lZBpV58F54cP5InSK5cnL9jlC+/ma2DrTQNhaOxvxndbPbe3O2phmEQabWVZ0B1kHtSmz31V4opYqC1fqwOwKVj93B3qZA35Bw9DJ8h/QodPigy70xxVb/hSgfSDaFVGROMeXvr93raoiVnkMesJhCVVFZKhBShVQpXfYXhUvlYauQekgcwa8jCcizFdu+s47FowTGkI/Fwc27NNdpkm6yKcpzgcQwebXeLW+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mwj8jfibrSnQS0bEraoBPQFyaKwnQ3SKwd86HujtW/k=;
 b=bnZTXeH++uRWa00hTF3S0CoDousSa8Eg5Vg8oYRiXJU3HG5uBrHaRJhScHRAg6yCkbOQFydg6nkivIBb/+7Ju4ONm6GihaNP3aiIq/cQ2sOonEd2hG0vJ8s4hfbG0lY6mx3nn5BOU1ENl9SIwRMW1hvDl18v8rUU74MS9q31B9kS53H12sEm4GoIWCTdyYT+bWp9It0QmoV4aBHA1GpKpse7FYVCqwuhDVHEsBj7u2Ls2vLyUj8TJRoU8Y8IrG6jbYue5JngTpyAnXNSX9WWKUmFK0JmwqD4SC5RgVK7gMtdBIg95Kks6VuerXXGNprqdGa+/l2K0a62E70n4mjJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mwj8jfibrSnQS0bEraoBPQFyaKwnQ3SKwd86HujtW/k=;
 b=ZnUVyUCPfjQdlnuDFtD8D7JCEeI8FoF8PgGIRBIPG0i3X01Um+Fi3ZHzhyN+4Dd22NL/iHWBLeGzAoTp37D7IpCkPKDxLfMrgr9YdvNpkus/kW2q8p8KmQrZsep1wUbl7h5uuj386YgK/mf0/Tjpnl0hKHmc924K2xxfjxzgN24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com (2603:1096:820:dc::11)
 by SEZPR02MB5911.apcprd02.prod.outlook.com (2603:1096:101:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 11:03:49 +0000
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75]) by KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75%7]) with mapi id 15.20.7316.023; Wed, 6 Mar 2024
 11:03:49 +0000
From: bolan wang <bolan.wang@fibocom.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org,
	larsm17@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bolan wang <bolan.wang@fibocom.com>
Subject: [PATCH v4] USB: serial: option: add Fibocom FM135-GL variants
Date: Wed,  6 Mar 2024 19:03:39 +0800
Message-Id: <20240306110339.1353496-1-bolan.wang@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 KL1PR02MB6283.apcprd02.prod.outlook.com (2603:1096:820:dc::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6283:EE_|SEZPR02MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e8282f-d7ab-4b5c-25e0-08dc3dcd19b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YhumPqYLVb6IWd08DmxuU04apwib8PnZA3XG/UdspmKG9y9c15xKa/aPQB1mW7JtfEgLh8Q7gKSrnKyhSiYIuBwhjuiQrYijFDj+0o81JgSE2N1IhyCGAtyzHLtDuXsuX3W5l54jJ4tgbLDl6qlO4MFYjAu9Jaglh/+PghbC2x3hLMw8gY5IbHDcbSk51bAeS2EX4CJe3+Jt5gtKQc01zwm06GIhPEf4BOYaQFvnoYYUMkVhw7ozJ0pBfJD8NMJlAReWKCRvb8FusIAI6INCjJuS+jiIujLJG9i1HO2UM3oX3XKI8ARmh2JlpsOk3M1hmJqKGY+G2TmMbVJ3VogaOhndUhN+2rx+ltz/+ZgHyMVxYClrchoOFHN+abMP1r9J4SuHF4ZNJzD8m0LfBJv6dZ4lbk/sxFuPFcoyKjhB62QDuZOArNtN6Jylv1FRAoiJOqOm3aZ70T3wsIOCyXMXsWEHfCq/jdF/V/Gkd5FLbicPTgHJjkPruC4WtSqIDQNDEnojlGCNHWPt9qdwEwKMnly3CuSNRAACF2Gs24GPHbaKRgLe5nsnLixvgGfL8dWg/wKRejQRQYvZmgw8gmwCMS6vlNtD5peoooBeu2jiJMfZ6VJP8efdB/iPkxR+kFK+uiHjWYYzMEsTE5IgrQ5vxe7QqztofyeRR0A097E0DyaS7zbar74W5EXQydK33be+INQHdkGF94TeryVzLChk0drr7jC6ivoV8uJSKnxgQ8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB6283.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?emcNpmWU4H9JaQjx/wmgyIb2hJd1xxzgrKSJmAG2lcNon38mTlv2ynGlmbwY?=
 =?us-ascii?Q?vRYBJ6j01Uily1os3N7IrBGOOMWWxFWdVMSzMYXN0emm+sKNRRkLPs1AgWTd?=
 =?us-ascii?Q?rNMoTlEYIqjF+qbtGV6jdm9CQ5uUlIwZ1y+OomKiXFiuYggng1N6Zh5Gxz0X?=
 =?us-ascii?Q?TxkVxW7k47LyC+PLy5398H4GxL/5R7sBRTa28agNF2apgF6GLTRXZmbO8++W?=
 =?us-ascii?Q?20WVM9YXv4n/C1TBqVqL/9Qa5BQqCsTPRll2TzSl53IJsA5ABXXRQPdXTU7S?=
 =?us-ascii?Q?gYKrQ4+x5YXO+YwzP3JtbWXkK8Ek2zmedu+Yl1VCQU+FE3hYu42Oq0iCao/X?=
 =?us-ascii?Q?l5Xt4OM2OkgKAetpell+IUGR9mX9LFDCXD8EiPoITgHwi5f2JY+sTr4V3eri?=
 =?us-ascii?Q?yrutUPt7hywdRhdc8Mfw2wqX30d68/6S1gRuihR/hDkh7MQqOZDcA/61ElwJ?=
 =?us-ascii?Q?k32H0Za8DQTXE3gouOMJsi1h2SvueWW6/ym1C09IlXrM5fvKM6ERNMsGYdUE?=
 =?us-ascii?Q?8x5ix9OA9L3VYabuEZQ8hADFOblSJg5cLqEg9Q3xTteCXQNgAb0b0npqHkrd?=
 =?us-ascii?Q?75oAvSaJvuVyfWZTBt0rpovqV2SY/qXB7dh9MHW6tTw5oplEiwIMeJpsYiUe?=
 =?us-ascii?Q?4tPXjmbKbGbn996uBIPJTuRBlPju/bfLj2c6yc0BGC8A2XkR5/KJUjiyGDSA?=
 =?us-ascii?Q?XAcbkPG5DdSCghpnJVKootBTVJWK0FEfvPdbJhg0IGzJOpbU5Mc5TaRFQ2Fw?=
 =?us-ascii?Q?K/mjGAYAhHw3rb8YIMQbC11afDhgE/wBZq2KObl+wHi5cZ4BVFc7OMtLpbJM?=
 =?us-ascii?Q?5/Gbj22RhYuL/ah7eAnV8REnCs/NeBYKm0crli2K38n5a3lQIblc8u7bra+6?=
 =?us-ascii?Q?AkcrWql786tjIZHhm2fd3P5JjYNea1E/rKUTlHuP/uI9frkWJEHj3ptNMjdM?=
 =?us-ascii?Q?TlxxbX9niCAvNyutRZGZz6pzSQsKDnMciiJUbxRVCooDxePeuj/oMlTC0Uy2?=
 =?us-ascii?Q?+37exRNHSsGeQ3AXyCnf08i219B4kUfuMcOhDb9iTc6E9g3PMghIEG72Tx1v?=
 =?us-ascii?Q?wTLScUq4EjOG7ziozGJe2BhKAuyhTwqlM6CiRztPmWDz3xKWtLFVZdFPoM2H?=
 =?us-ascii?Q?DJtm7g/B7MNpvOSTpMXL9467aZY2AIAVhlBCZJkQwUa/m/IS7uhJDQ36TOHI?=
 =?us-ascii?Q?D9QNvXPEve6I1+tOW/XdUC/hd3VAjnbqdXlQ6qRwnNk4hIvTfB/BQgRF1sFm?=
 =?us-ascii?Q?GpFixPr0CirZXRGiGr9wM2JETlhbuUh/BJhJikfYnx/U4eRc3V2/dzUyteuz?=
 =?us-ascii?Q?Mwjueut3NqwcAoHq/catNYsz1g3xbIQYitnsC7t/hDNiED0oaVlNWG4y1QVR?=
 =?us-ascii?Q?SCkTtxIoq+usLG/0DB5aRLymkG6Nor+A8EqCWtHLdF5e4lXCVEpcPpdi5Kf3?=
 =?us-ascii?Q?4SVeT69zc9x4Bu9UmdQAdzdEYPRPJ5usoDNyY5UNdjpEAjvaqxL1WggHKBzR?=
 =?us-ascii?Q?Q6UjnY0t7ePBvrftHvGue2K34eq1MId+7+BwIyF6EBvtRKdGHNwSz9OQnN6r?=
 =?us-ascii?Q?eH6gmrt6H03anMoeEH2Ty0QW8wWewx6bmOHqOuxHqbt23vI6U+cmLe4As5gT?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e8282f-d7ab-4b5c-25e0-08dc3dcd19b1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6283.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 11:03:49.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zdx/ioV/bldPR/sHhSxHAnNIZmB+5uYq0LTSv++9pMZ6GyKnij1LKMJSN53E7PddB7EDC7JxOyC7bL7bjByzZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5911

Update the USB serial option driver support for the Fibocom
FM135-GL LTE modules.
- VID:PID 2cb7:0115, FM135-GL for laptop debug M.2 cards(with MBIM
interface for /Linux/Chrome OS)

0x0115: mbim, diag, at, pipe

Here are the outputs of usb-devices:
T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#= 16 Spd=480 MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2cb7 ProdID=0115 Rev=05.15
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom Module
S:  SerialNumber=12345678
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

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


