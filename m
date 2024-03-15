Return-Path: <linux-kernel+bounces-104091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2697C87C8E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A17282819
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BC14F90;
	Fri, 15 Mar 2024 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="SIq9dseZ"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2156.outbound.protection.outlook.com [40.92.63.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6A14A8D;
	Fri, 15 Mar 2024 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.156
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485221; cv=fail; b=mvivbdbQvV38/mjdP2gnkoZZ4bAKfkd22UOgmYfkAzXiAN5icaMRKu6QFUrZZR9mEOCQ3xRt0zh2paF6SWAHQq3xmlneJP+6gB3kq4XpRU9Y1wFowMlVnBAKOpE2ftN7m4x7tMDwketc50MY3tZ+hVyABhWs3VF2FmOknN4rNB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485221; c=relaxed/simple;
	bh=jqcgRWk9IZu5cO9UUIlrrI0Tn5wUrQdQFo7LQe7iK8Q=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=QG6nqDLjzfqViHPhXSK02xsnAv9Vf9COVXyuKgqssqeeFmbg7dsZmRl1c+/0wBAOIqwIA8PLhozlwgv3CzGQJwdrBGbHQPbYh3eHSrq0MA7W4k9ffHcIMB0Jf4FT8Y6KLP2B/AcGHO8Hp03xvvL+Pzur/6WDKhLaAgoNjR9lu08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=SIq9dseZ; arc=fail smtp.client-ip=40.92.63.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jswd6RNov73kHQj3R6ACIrfaf1U0BWrLfGKo984MdIsWu9axVI//YLIzx8dSnI6P6R6tGbd9+jIIjaE/n82qPAjf53ODokD3PsRoRVt4Mi/MRvtA43NnceDEmWX5esYwaMsezVWay8eEW5/quD2R0Te8GsJZ1wfvLAGt/7ctILyKdbW1WflmiRW/H18sI2DN/71k4A8DOcJjDDRIrgoKrWGUvN4FzwXTTT9fPUIV1yFdGP6jh11Gt5kank7LNE40gzXWdbkBucM/if63qqOd2hKnSnzMVR+32OjKzJZdZn/xPBuHrPkyyjojZvoGJ4Q6TbBWcqQTPRnJ/raVVFBtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8CdwzIEJLHiBH+OocdnZTO+rbthnosdCtlGZ1P81s8=;
 b=JODDfY5eHcJ2fMgw6DCEXlU9IkKYqAHPM7JNA8H1xlDnkNCwbho48OK8pWgDL3bW/hbnIz5nggj+uARrn08QGsG3q8UzFw41rFNb5bA5wvXU+T+Yl60GozhVCM6270ZaPF0WfF2YbbIRfgw7D9MCdRpnxGC7BtSEzyKLtplO7t7QHVUYK/fva9QUZzPWH4e0Ci8JKIZc9W1AJTou/SY+j3wLUUDhCtomHuVYZOKlpHklE5Td1/9PqQiHF+JSepaoPAji/9K9rxA+TNajYTPoR8kiQZ6iJr+AVuPdiN1adiuMy3Yw7zjJa2OD6RmmjRX3+7veYiew28ZL1dcSdR8vLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8CdwzIEJLHiBH+OocdnZTO+rbthnosdCtlGZ1P81s8=;
 b=SIq9dseZxWor3u4bLwfkk3zjF7jZEdu0ggnlOoYzNoxOiN/K0IPSBTTdFRvLTdHzrg8t5zc/U/todURgDuQ+hPYOCWPkt6/bWtFN+KM2T09NBPcUCyH/0s6Sb1YJAj3sdrCxuhrJ8W60If36Lvpty/yc8UQH4VAC1JvAsnwGeynSkNrzQTkdYwmd/skpK2JQzyJfuPGm29OVOs0PCBa7lGgELyQ/57VjNpYjBxLpwC0sJF6pB0bZbR6awuYstjWaK74hRjbWahS8e49YAoSWGzvPxR2wIg4/xm+ZfP7We0JoNeFMAR+fcmU+3q2/4YHeg6wyknPRHrM7ADX2S5C3Fg==
Received: from SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:b7::16) by
 ME4P282MB1205.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:92::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.21; Fri, 15 Mar 2024 06:46:55 +0000
Received: from SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM
 ([fe80::2e5e:c43:aa0e:168c]) by SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM
 ([fe80::2e5e:c43:aa0e:168c%4]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 06:46:55 +0000
Date: Fri, 15 Mar 2024 17:46:54 +1100
From: Ian W MORRISON <ianwmorrison@live.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add support for MediaTek MT7922 Bluetooth device
Message-ID:
 <SYYP282MB1197FB116B937D8CB0E57305AB282@SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN: [/XuOPdRIUkKcdlB9GF7aZnI3PhEDJVnGO9tpggYMTik=]
X-ClientProxiedBy: SY6PR01CA0113.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::16) To SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b7::16)
X-Microsoft-Original-Message-ID: <20240315064654.GA11075@Desknuc.>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB1197:EE_|ME4P282MB1205:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c71803b-8a6d-438f-9699-08dc44bbb408
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bGrr7gygiT6f/YBXzD9lQGFMuRXCbVjfeCfJ0qGL2jf8mw856Tb2TJca9bpC9Z2nvoEHxvz1WSBrZz1yysovI0oLfj4TTS7H7qxLWNfB2KwFZZSqM5NK0PUrMqxs8fF4VAg/fN2K2/5zuRxhM2OTq5RVj921qOaEevJuu5E0MtWe+l8IW5tZlj/IVWUX1NGUhiBSA6H/XJQ8/AEU3M2x5DxshBA7d3UoRajU5NaM3gxj+NI4eTnOL2F2+0Z7GHmYRLcZlYi4tqX+tnJZa9o4M61ooaMRHLFHActrxZdzO8b5s+Ch6KSI1uZFqCVwn7vS1aZ8VJCnnrlUOkyIoMJKsTubH/XXyEihabo7I1ZWyrGtyqSy/PGouk0BVR8aouPTTHFTJ3ihu4eXPcOH1z/MK0Fdaul7TymmV915OKYF5A+QEQbOgioWetJUclgV7W+/0R41iyoNAYpAEUfa4vt4xULlFK2CYlSi97tfz27U5jup0oqd2F9YOnB0x0SUH6ggJsYDBE6uWfMuwmLyEYqE70iNwJUYMa3fZvCvmdMAMgJlIHqzAuNlHN+sy7wmX38N
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QDNXzODoHhDVFVA1r4nbIhqt3eOZU6X1nG6qbmDCRlZV45nPDVaiViDKXJMv?=
 =?us-ascii?Q?TdPeRFV5Rqmd35MHwnoDrhzJnvFuRa73uOqtSn/62AsFYsTbQxS6++Ki+Z42?=
 =?us-ascii?Q?hYVQO73h2pao6AC+5tSLW15fgPePAqVs/ras0mJF0QaQVw9LoluOOPYQVrlp?=
 =?us-ascii?Q?HW2U1i0ZuS7ZIh4meVMs4LHLuwuFdkF37KRqlsQx5aZTCs1LTvBlPCqhKpv5?=
 =?us-ascii?Q?lKii9GhkY9J06o0t4JWlVv5u8M/IsXuWtSfg4hMfDQW3mY3fIXy1YFl8Vfzm?=
 =?us-ascii?Q?UWIhSroc3bAgCfwstk4bwp5dKj54qTQ/gH5IXkVZKgvYRWBvlVElor2/il6+?=
 =?us-ascii?Q?vDU73KzZ6xSvqWWPU8eDqat3ioKU0nKOe+B7eAjS/V2DNpb7jAibQ/Cw32zP?=
 =?us-ascii?Q?te2Xn7sm0SoWejOTIWZY1aw2yYPSnHfHuu5sl5f+87OFGfl5S6DBvhC7TEnr?=
 =?us-ascii?Q?I1QFhIM+bR3ogrzONl5NhAbi6ZltBOsRsnGDqzIUPYkNxCtlF2Xla0wVPovK?=
 =?us-ascii?Q?tTwis2HERrHf8XGLwa1fW9aa3W3GFlKqFJenlQ34nl3DNVeh01R91pX/G96g?=
 =?us-ascii?Q?M19rjV0JG7u0j8I8fmI3j/bhEpumqySwhcxG55RXyDtU2cuqQEmN7a2Vhnjw?=
 =?us-ascii?Q?84M4f4iS2ZWNIp1M83ayIQduR1iIO6NBBHiuRIDzyChwFE7D/g4N2DhRYgp0?=
 =?us-ascii?Q?W/Cjg3B1jnuc+0h5TTy1ihrKWR5zBbL+I9ZIGs45T2dQ5lZwxoHD2CUDiMQ7?=
 =?us-ascii?Q?rwsr0QlbCqUHN7awpCeRxrz0d8d/lojY2Fali9dEyktK6XSChGNlmZzbKO8c?=
 =?us-ascii?Q?KjF2aSHI0pFoPus2zDrjjh/bshgPfeLC8JoMFYDBcu38ohjxvjZZjkoikdA4?=
 =?us-ascii?Q?iBveifwlpyGz4Un7GYZlHajfisUA7+Jgy205P4W6zBxfV0fuFHsyFjYSDSdw?=
 =?us-ascii?Q?QpndqwORY0y2zx0I6RD4V3ohqMViEEAVZCEfe6Jg6fvMYcPBwyEvgAwCCluQ?=
 =?us-ascii?Q?cA6nlAukwwgu2z7JySvu2xJx8eo102T0lq/lLuxAxC46/rKUnL6PdW15lN1E?=
 =?us-ascii?Q?mI0x1aSWOuQ51+fDwvIJoU8AKIBxTzW+KFDEzprbI3ARbRCegMEpCniG3oW0?=
 =?us-ascii?Q?R8nOQepGvLBRQfpz0dIa0bK5vubAp8o318hmlfXshZYlZ3gsRGxk0/8fwLm2?=
 =?us-ascii?Q?9azot0YapXt076UkBkFkuVPKW3YIgbHdXfB0Lnjc1msnK5mufGhQ8SW6Q9xB?=
 =?us-ascii?Q?77AKE4uuDzcMoc9KiEYX?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c71803b-8a6d-438f-9699-08dc44bbb408
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 06:46:55.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1205

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


