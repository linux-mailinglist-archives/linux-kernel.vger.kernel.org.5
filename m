Return-Path: <linux-kernel+bounces-104127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A87287C975
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB93C281ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C268E14A8E;
	Fri, 15 Mar 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ARnSYz4z"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2169.outbound.protection.outlook.com [40.92.63.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E615134D1;
	Fri, 15 Mar 2024 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710488897; cv=fail; b=iHYdRHkyRP8SOn7l6woJGGYRchhwTx7VnKZ1gasXoXYFFqZV6HrbuH4E72+rnmLxQpprkUOSSic2SiyBaYZAhll0eV0Uf5787Sp5ANZPyXMc5LaTQ5KBZXptvrCiInqA3RuuPguXOjTMi+x6bOPNSfvPw/jX61nfUvylRrzaNoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710488897; c=relaxed/simple;
	bh=21gtga73XTE3tIWZEXDRGJAjO8dassp5toqzMac4TVA=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=dvlN81Bn5jSn4AZHECnJ9N7eJ9EDAYFmbMMc5kvIw+4K4/if9qD+OAVyiVbCTScv9Z6yjz9bmNOmBfMJU9LmDVMw6YcGdwkGSNxP+11O6WO/O+95Lyb0gLw+sDXZu7NKDdPsxFW198dcelxC8PAAx0GGqCnY9myp4fMseUQCywQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ARnSYz4z; arc=fail smtp.client-ip=40.92.63.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9oki90uxh9lSOnX8OJCV39TSz4zp5ZQK8Gl0qSjYPNJs+SkswwlL8/sD5DljR7uczrIuUen6GxJ7iwd0pDLEhhJKmjnln4xzrxjCeAXotOnV62josFpOioPswf/pPPsTtnReSM49watXrB2mZ2Q1n/67s+42fod1TaUExToRy4C0Lx4EI7SvXZ5YUOlhaOkPMvcTyhboSbsqBc9X/0XU8YL5hpnDbK18lc+0hWBALRFWzGwi5cMt2GjC13TKoc3ZEcO8/owY6xIkE/OPlWBJh/CnceXg/ooSeaOn9I4opMpQDd9+1MpICIQooDaENbcxhPix2KydXfkQ81mw8x1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X10VR7tABaYyHz6GMgO93RJn/SryIIITBBiSNZLTPs=;
 b=RJNKZuSQ9OjSGXTXBje+XXMfQjr4G8gn8TYeUUZWrB/IRP6aXwx9BSp7EuOe7MPhIpE1bvBZbcHVT8x1gp03lYrr2YHDz0/9tlE5tVXEmEs58+ThM6bfUpymWR4WW+n/5Xl81od8D5BCf9ZrwTUjYgNISW6XLEoPGQAjsmL1RaiCt79QO7RbgGJrAbV7kDonAdUu1QwpKL3yljRvYHV/xgiBSptCX1Dpi4I1Mt/4ygIe2dhNEFyYOVaA5kNDXIUzBKQlwVbc2bDBYg4uEQKwZ1bhSn00fqeOCTEIP2wwjpJJkrnHMyRvICXosl2xRJn0f4iP0ItCvMXel7FE3qUV3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X10VR7tABaYyHz6GMgO93RJn/SryIIITBBiSNZLTPs=;
 b=ARnSYz4zUomqOT1hy2GbPvVbIGsCbSyicD5vIbQoh6ORjmQ9gT+H4AtAHaXF20pLJn2JG3AJZfRlOd7N336GBRIwT7e6mjPbiyFVtAsF6qTnnt64VMDN3uyKvVwJGOGda6hr5DTeKI7SHVy1d5S7v2W1FT6V8XFQUGt0Rp2/qL4lwvXMMjjFZPybWnfFdEw55IVFj39tm1h+VKNLoLy4WpJ15rq0UJ9Oe1fL0OCropI3mEtjIB5OPwXXcrHFl4/857YfBX2KB2xTgmtWABwxLIv+CHhj/WhZH7CTMj2fe8xfEsb0msRfQxfl7zvtqvNaQTe8uuGHeDar1lD5HEWGyQ==
Received: from SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:b7::16) by
 SY4P282MB1355.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:a3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.19; Fri, 15 Mar 2024 07:48:09 +0000
Received: from SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM
 ([fe80::2e5e:c43:aa0e:168c]) by SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM
 ([fe80::2e5e:c43:aa0e:168c%4]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 07:48:09 +0000
Date: Fri, 15 Mar 2024 18:48:08 +1100
From: Ian W MORRISON <ianwmorrison@live.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] Bluetooth: Add support for MediaTek MT7922 device
Message-ID:
 <SYYP282MB119734BDF1275B7453AE84C7AB282@SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN: [h8j9ANtOkhC75XUZDCSWsEovTYXsEP+a7wCDvKzYJow=]
X-ClientProxiedBy: SY2PR01CA0018.ausprd01.prod.outlook.com
 (2603:10c6:1:14::30) To SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b7::16)
X-Microsoft-Original-Message-ID: <20240315074808.GA11445@Desknuc.>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB1197:EE_|SY4P282MB1355:EE_
X-MS-Office365-Filtering-Correlation-Id: 448a7e9f-762c-404b-8b67-08dc44c44233
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BsLoufGKsxV2+7STLEwp8KT8OuvOwnjrxrfgljauYRlfz2mblTgIusbIKxrctaSDcW5ttxMb6rulyt4kpjWbePPlc2PpXcWisG+XACPYMvjCcoatvQIi5mekE6LOnQpnd3o/zpFinhY/moycR1hdycn2aa2ZWrazAvA5SHB5iNt8crDozYNZlIYIGGFmNQuuLEJKR0gasJo8GJ9rJP8tp9awl9/Lco878RRQPI6gUxvtuvpzHRLPf/rsHvlWfQo7nSbtotbUv7ob41/Pr+sRgKk4DfF9W1iYyAQYPXXskc50f/rG3hAcaz442SMu0mMRlk7mkqjgFSKU9cwg16mH4fXt/rx+Rwmc9A9R26H0Q+3XZ77pGPitm8PuATw6T3MKtSu2AS0VajWBVQWoN/20Psg6Eph8kX1U+oGalDgkLrJplxfvU3qclUTDFCBNsUI2ELqMsP43AdLT5yaVpayVZJLPfCdNCZ99Q0GPYqBNTHm48jaLKbsTpTOwp1EsEcUGZPueqDtwwSzAps0xdD+AahE/YVusrAcy4FY5fczSguyBQ3oPrlZRzXlnnn8DcTLn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+aIBdDYi+aNAzYwCVZQpQBXYjAhFx2gM3LlZhPWJV1ZPTShN9tpBzE5LV+4Y?=
 =?us-ascii?Q?zMFtTeRpwYLdP+Qg2oJCK3KMjv6pOayuBxUOqi0yEwY58bYbHuZ/Oj+KndpK?=
 =?us-ascii?Q?2aaBJOmJ14afTzgDcDrTeePrB3uyAzkGGjp672hDkzKG5EZxFKIhkZ3CPUwK?=
 =?us-ascii?Q?F6yfoJNxXmcSQxhbdaxAr9eeAQMI7K7j5iR2K+F0DPpYEcgugWvJ8f8E2441?=
 =?us-ascii?Q?LhaJUafWf71foxbe9IoVKpVV4AHvgzVQHPe2ztYkUlHPEYReWEsJwENL5Oe5?=
 =?us-ascii?Q?4Zydj/+L4m7LMPPTI4+k8nF93kLa1wnBmLdmZp+y1kO0J4dTSBSFmcVRWIf/?=
 =?us-ascii?Q?YlN0Z87KDf5AySDSHQ6Syo+rAISIpljfUZNdiavNCjLayMD6mC6KkE6W1Rs6?=
 =?us-ascii?Q?vI7dvpk1BkOnPf26KydyQ0qHK8HV1xxnRTRvsHVQGDUXxOhWZls9WKpmgFZ6?=
 =?us-ascii?Q?56ABBKi1EG12OeaDgBb46k9tBquJoMAguzXQTrRbawoP709goAt/k/kql2Ly?=
 =?us-ascii?Q?uOnbFuWW6oh0V4Jw/mi/NWwSTZPkcUey2uhp6VUPQEifF6Xjhho01m7Tl0f9?=
 =?us-ascii?Q?mRt6Zowk28BOHekXUc8Ezt4dtp5jLJbG1J5s2bR9YCv24Twz7KzB+VCYiKUv?=
 =?us-ascii?Q?0XgQ549NiBpXaP2KLM/MKyowyfxikuCVJeuQHicOP6DNgzXZXmsCZ0jdb8Al?=
 =?us-ascii?Q?IuG5DYbtK5H9YxnYoHomOTw9XGukCxT6oJIZUvsBOyAQQ2tJCJcRaidM3tEK?=
 =?us-ascii?Q?f94H4ihfiXSlw+cACwiTj7DVIA7/Yxz75okqQunOfc4t3+XVgK9QJ5OIPvJ6?=
 =?us-ascii?Q?FW7K8r1lA99PnJZiv0v7l0gnea1dX4AcSmyI/YimEe+UPaNbVq3NprRXDBPr?=
 =?us-ascii?Q?UvUIJ4CUh23SKFR5Si0B8J9vKjRZog/Ff8MDQSz9Ed2EiYaAKL0ZrUU9Kj/j?=
 =?us-ascii?Q?V/rRF+/KpIDjve88ocKPshKtk1hlRQiI7PQqeMd5hpEXx63KXsZXgKl9NDnP?=
 =?us-ascii?Q?xyLlZcI5G336EvMuAaVrResBKaXSrJI4vCJXzDVtEqlIpaxm1FHdd7O23ZLv?=
 =?us-ascii?Q?obzvjvW4hTS4uL9H8giAFCAHBNx3AIhQTn7e5j+uBsCoYrDCIxHfUnnt2upt?=
 =?us-ascii?Q?TPfFUbiR7u6aRuHUO6wUyTTQZNOTX4B3EwzE+tIsDsuLSP01D2XF1/L2Z6Z8?=
 =?us-ascii?Q?n4+cFg3IGBxChGJ3+29RVnqbbCpzbAeh/tDQVRmjDcER4NDpanQXsBXJ2Q8l?=
 =?us-ascii?Q?3q75Q56OFr30VbqcWrr4?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 448a7e9f-762c-404b-8b67-08dc44c44233
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:48:09.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1355

This patch adds support for the MediaTek MT7922 Bluetooth device.

The information in /sys/kernel/debug/usb/devices about the MT7922
is as follows:

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3585 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: Ian W MORRISON <ianwmorrison@live.com>
---
V1 -> V2: Added "Bluetooth: " prefix to the subject
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 06e915b57283..c391e612b83b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -617,6 +617,11 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
 
+	/* MediaTek MT7922 Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+
 	/* MediaTek MT7922A Bluetooth devices */
 	{ USB_DEVICE(0x0489, 0xe0d8), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
-- 
2.25.1


