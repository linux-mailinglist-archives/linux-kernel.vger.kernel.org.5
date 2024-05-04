Return-Path: <linux-kernel+bounces-168460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE558BB8DA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E97B227C6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D205A92E;
	Sat,  4 May 2024 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LhAPvhcP"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C941865;
	Sat,  4 May 2024 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783273; cv=fail; b=qpyoet+gUH+W6tc2j5HsnFqDXae81Y8pDkOVtIcp1+I9M0dzNp8WiOeQRBtMuCy6+wlvd97unckCR8npXV05CqNLGVtjvieK9k2bTA/OPGX3heGNvrNygVayMF62tWW3oAXoIaRd3OqijwFJO/yisGPPghi/5d6DqbUv1Broks8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783273; c=relaxed/simple;
	bh=rcCtVWuFJLRqXg+s+ZbKpx/twvYOuewRyu/zZTOc/H8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IVTHjwXC5TyHG5rf/n8JYNqQyIT8DGPdLjsB8svP5NZhUgOxxNjPtwiL1XZzf23VWzjGNKracnIaNwKqP5PnVr5UG0XZleylD6Bz1zoWAaM83+Z6OhzUGkFjF2GQb5u0iyofICbkDKiDTBb0Xyewflzk1ZZzaUjx7BMrj2xxNO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LhAPvhcP; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYJXEvNMH7SQGqxvt6QDR0NkkyqZR3IGcC5xskJxIrKRRvrjJYHK/KGC4jsYO9pM2NzHhGtOx08x50m35B0UAeoKClzu8+thzLfaDmXz//waBtZlg+Ba4J9y4yjXTD2nJ+Fk1Sj88lb8QVJViBZdfAoaZIuM6PeTCx2EfhKUodZTC19sNm8YgI5m4cnmJ/aDz3r9h9S3Lt9THwL+NUuheEuC5wD5rt7cza8i7a4upQrR6QF9FGmQsDM5iceNbQLKIpe74GzZ1mYJ0aArmww5DpZoAqWiIocptREpPLAHyFz1Z6giMkK5XQ4bRNmsx8+Ab+JbGiABrEYo2UoCIMPlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUBHObqX7+uXERJEHkjNWet6mkZy6+My8u8xzR/PX/E=;
 b=nyrXLazplHUj+yJY03LDVDNDKGJlUv5SrLkX3tZ2AXVGNyfl/w6MSDOo8AkTflY68sIx388fK2G8vWvdg4yM4rf9KgyQTF5F6u9KtdynRgW7ALN6oJuk9m/a7xE6w9w6Qo+BuFv7/42wovl5xU7Fw5tyTuMpZur44mWmwbvO+2Bf3cYCpAzApA8EDlZdfHa0APV7uGwfZ6Ipd9GNXhsn6FQyOZHN+sTTo+uincYuDzD2SKrNwU7IPnNArDqv+7gf3GvISQrt8zVnz2VHJa5fFXGVQPIPgZj4KztiwsrcXPqUs+9IL9ekqc5AoVlAQRHxT5q/7vprNkr8ghSC/RHh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUBHObqX7+uXERJEHkjNWet6mkZy6+My8u8xzR/PX/E=;
 b=LhAPvhcPvpq1h2TemYfpLaoC69lDJ1R3Q1DxgX8OoaL7nKkBB4d93H67/5NEPjYCLLccBqW1mq4QfPe4jZGebfYIULyxcXNOPsfPk7p0p9CWkO84F0mWNcXNHCRCnj/8+UemLxb8wTJdvj6AX+itn3JxhELpfRxckaXkj+0T0X8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:48:54 +0800
Subject: [PATCH 01/18] clk: imx: composite-8m: Enable gate clk with
 mcore_booted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-1-f7915489d58d@nxp.com>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
In-Reply-To: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=3100;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=iITI+dk+sPkjkDWQwUetdnNFKtogLu9x+44sHjDOVUI=;
 b=fkSTsJHoRmvS36n4JKMR8N2wmEhRjewWymbpgLM/PXzcG7mlf0GshZKeSpwDWPopG+52na0ri
 5nrrvS0cHR5Br/6BePM4dNt8xDGjresoSl72zQDPa5z8trdkrkn2e2S
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5dbd63-c734-4328-a905-08dc6bd2e314
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1o4dzRCa0JDd1hkTEtYaEx3b1BxcnNib0FYazdjZmtLTkQzMjlFVWJidDQ4?=
 =?utf-8?B?N3RkcGpnNGV0U1ZoNjFpbkdBREM4ZVorRE5zdUJUQlhvQzc5RzVzaWgwTWtw?=
 =?utf-8?B?cU5wK2xNKzE0RE9MWWFuK1haMDNJd2t3U1dIaHJyck85citUVG4zaEtibDNn?=
 =?utf-8?B?Y1FUbXJHUWNrRmR4SnI5Z2szT1Y0MEFkV2J5OUcyekk1eEE4NHQweWtPSFVV?=
 =?utf-8?B?bi9VTzAxYXU3N2hpYktzNzhjS2pYMWpQWXRrN0JHc2grZlNmazBTRnVhOEhW?=
 =?utf-8?B?RWxCZmRFekxlQkxrcVduMWxYZlNqcUVicC9FWE5pUVVhS2d4NmFGVGxjR1cy?=
 =?utf-8?B?Tk8vSllHaGdXN1ZJZzNsYmVIWUJFdHdzMmliQWxBUXlHMUVGQzhsSVN0UjFq?=
 =?utf-8?B?UE5lcEYreEZPNnBBSnJIMVB4N1BDeFFWaVd0MmlIbm9OZGhhcjNGN1Fvdngy?=
 =?utf-8?B?bWUzeHExSWNJdDJxTmlkQUVIa1JJR0ZRVGEvSU00dUZsdzBJSTluOS9YTEU5?=
 =?utf-8?B?alVQQTNHNXFqWVRZekE5a29UWFdXWmVkWXBtSFJ5S1RmT2JxT05pUndiZXk3?=
 =?utf-8?B?VGsvTzNqNlpiekN3QjZYSTZvYlRkc0pPUy90M094cytZditkZVFyTEg0WXpu?=
 =?utf-8?B?ZUd4ZGlodUFpYTdzeFFHSjJ4NUJSUG9EM0RyMXJNOTJGMkJZcU52TDgyb3di?=
 =?utf-8?B?Y1JpZjYzdXZsaEJ3ejBuWkpwMkNxTzU0RnFBRC9qenR5bXNXMUxocTNyclZ1?=
 =?utf-8?B?M0JOTGtlanlNM29ocTdwdll6dUVydzhzeng2K1lIUjNKM29oekZHc0lTZjIy?=
 =?utf-8?B?akdyanJPK1lSN1Z4NGdXVjVMTHkzNlVXeDM5VXY4ZDY2U0VKclc5REt2eVVt?=
 =?utf-8?B?WXZKQnlBQ2UvWmoybGV2WDhvcDlKZ05tc2hMaXBlbVV1WmlGeFFZY1N6ZXlL?=
 =?utf-8?B?VmphWjJTZHhqdnczV1M1Y2J5N3VPSHBOQlNUVEZzeTJhN21leW1oVWxvQmJ1?=
 =?utf-8?B?YzNaaDNTMFlkUUlaaHdEeUQ2eC9KTFJaYmpXWFAzZ0wzRW0wdjF1QklsSFRo?=
 =?utf-8?B?a3BkS2VTSnBrVmtxQlZpeXhnd2ZrZzRGZnFtQTY5dTNtbHB6RytVZHFQMWI0?=
 =?utf-8?B?c2NsZjNxQTNPa3BQOFZDZThDUHgzVmduZE9FRlh4dVh1bS8rTG1waXpRcW9L?=
 =?utf-8?B?c0FNZVUveUF0VEMwQW5naTZhY1hFaWozdXFIaFd6K1VZV3FwdWYwTFlBeHQ3?=
 =?utf-8?B?Qlp5eTBTdGtrMGlMaWJ1UXhWWkNjVVhhcmd3Z2s4UUhtcUVlZnJXS2FwRG1K?=
 =?utf-8?B?UjdkUzNTcGJ4V2pqOUpqckQwNGhQUnJETjl3T3RFL0tJZDhYNmJoMWtFSzNM?=
 =?utf-8?B?MmNBbVdKS0tRb2hocVB5V05mYWEwY1pzcm9NdWFXbDliNVE1T2xqUktLamFM?=
 =?utf-8?B?a3dOUDUyN1dXVnZrTGxvdFE4WlBVaFBOd0VYcDkwaWFzVjA4bWdYN3RINWw4?=
 =?utf-8?B?YmFNZ0tBMG9YbHhRSDJZNllRbVVwZDlvQnV0VTI3OXBObnZ3aWt0M1dmUDVn?=
 =?utf-8?B?djE1Zjdjclk5S2RaUkIwaVVTOU93TzBqQUF4RmNHNGl1TzludlVZUHAva3lS?=
 =?utf-8?B?a0R2bXA1dlFEV1ViMmxnQ3JOZDdteVUxaWJoWXFrNWxES0R2MG5ER1FMWS8z?=
 =?utf-8?B?cXlDeVZ2M09UQUU2ZGxVVExiVUMxYjBtM3gybmI0TGtHdmwxL2dIaGh2YWtk?=
 =?utf-8?B?VHhVNlFOL1VCeWlSMitDZ3QvU21lV1I4SHRNZEw2NTY2OXpHaEc5UFVldnpI?=
 =?utf-8?Q?sm6FzlbIXvj+H+sdMLkR6ODceupn0aw4YgGzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEswMWV6K0hJNytjcTN2NnJSL0lCMTAxckRGaWhuS1lMS1JsVXBXd1RwUFpu?=
 =?utf-8?B?Rk1MVjRpNENEdmcwa1dSaC84UisvQUJJMjdBZ0JreFBkamt1djkrYmxNUTVl?=
 =?utf-8?B?Z1pRb0p6YW9meUc4QlZxSnJuRkFkZy9TaDc4M2pjMHp6eHM1cGRNUGJUK1l6?=
 =?utf-8?B?T1krcGIxeXk3Nmw0ZEU2MFRHZTMyOTVjNHdzM1lydDJBMDcwcjFSaTVsK01w?=
 =?utf-8?B?VHIrUTVRblVLYjZKZHZWNWR0OHdUZHp6Ujc5WmJZREdLKytTK3FNY29TNU5Z?=
 =?utf-8?B?ZWdxM3ZSOVArT3NHM1lLanFpVys3eUljRVQ3eGk5MC9VN3RKVjFPcUh4UkZV?=
 =?utf-8?B?RGFRWXppZTZMZDdjOVZTVjZPM3dOT1ZPYzZHY2VGdVhYMTN5dkxweDRmaWNJ?=
 =?utf-8?B?SDVWbXNRRkEwdURaTUVkY0lLZ2FyRklzaW9NdFlWaWoyZ0JMcmFCUm9QYWN4?=
 =?utf-8?B?bjZDWDRRd1FEeUV5Z1lmU1lnY2crNG9veXhOQnQrbjhQTEZlWEF5NS9PUndk?=
 =?utf-8?B?Q3ZjUC9wV3l0VkQ2dWpsL09Uak4yV2E2THpGRnM0M2lUZ25lZWRVVFdGZ20w?=
 =?utf-8?B?bVRJZDRGNlE3MXpWOVpEV2ZBQW9BK00wU25sK2VjQlVVcE43cU5vQzZyVDVO?=
 =?utf-8?B?RjVFRXV4azArY2tva2lVeDNXeVRVZ3hjNFVUdXlpbE9uOTZXOUcrRXFQTkNY?=
 =?utf-8?B?VEZxNG1kc1g5ZHAySjFMdm5JelVGeUZ5RHFnSjN6SytUQ1JuY1Y3ejBrQm9l?=
 =?utf-8?B?RXlzQlR2NlFmMFA2TmdlOUhlZEpQZW9HbVVJWkh4S29XcjcxamdDREllU253?=
 =?utf-8?B?TmFHS01TWnZRc2dYTXdITVFuejhjTm5VZmNzM1FnR3k3YnJoc2JjckZBa2tu?=
 =?utf-8?B?SzhDOURyOXdIOCt0enZyOEZla2YvRVYxbWUrVWNjVGo0YXU1VEFrZmJ5Mm9i?=
 =?utf-8?B?Z2g1M0QrNnErMWpFOFJ1YmpkNUFwOXljNVF1WDlvK2ZjMS9ZMXpnSDJvaTVF?=
 =?utf-8?B?b1BERkhiQXVlc2dQUVBYOEZxR1Vpb3laZklGS1ZqcFZDQUR0Q0FaWjA3b0xL?=
 =?utf-8?B?d3d2UUFDeVhNN011Uk5DUm9vYWxIRTM1ZmxTYXBFK3J2a2U4RkdQblhrTzEx?=
 =?utf-8?B?QUpMZE04azZEOVU5emsvS3NqbkhZcSt1aVVFS0c4Y3RxZ21tVnhJV2RYK3Uz?=
 =?utf-8?B?WC8wT2p4dUxHOUdrTFNycFI0OHVpa0UzR3YyenB5VzNUQ2lTZGsxUE9NVkdn?=
 =?utf-8?B?SjF6dUEzd2dGWmowY3lrcW4yZldna09FTXdQaE9NbFl2R2pNQWZFaEZtKzEy?=
 =?utf-8?B?b1JEYUNIM0dPWVBnWFJxRC9NWmkwdGVtejFySG9mb3pYeXFIZzNZOXZ1T3B5?=
 =?utf-8?B?N3E2dE4xS2t4ZTZGd0dhUnhhbGU5bG1EbWtMNk1qN3h3SzNaRWFMK3h5Uk5m?=
 =?utf-8?B?bnUydUQ3azV3UFRUZnpiZUpnblVubE84M0d2dE9HOTlqWDNhaWd4dHRlTTNw?=
 =?utf-8?B?cmhRUXZnM0hOTStGOE5wNG9mMW5nSHVnWXpBV2ZBTzkwT2dKaGR5QXhMdm1Y?=
 =?utf-8?B?cmhsSUFRYVFubTI3WC9JS3g3dDJvcHJybFVIY25jQnoxSTQvTys4NnA2SGVK?=
 =?utf-8?B?ZzhnbVlVK3A2UmhQVUlHbkU4cXRWekhWSVZoL0tLOTJpNnVkdEswK2c0L25i?=
 =?utf-8?B?b3RvOWNqUFFSMk1zVndGNDBNSDNRQXBtd2I4UXFOempGaFI5ZTlaZGttME10?=
 =?utf-8?B?elkzOStrbHZtckVwR3RPK1NEVlhOZ01jTkYyOHBUNzV5K2RGUm1QK1NIYlNW?=
 =?utf-8?B?amlKcWJuRGxDSjJJb25xSExTVytTdTZmSEhGMThaREt4dzRuVUNGOEhuVGF0?=
 =?utf-8?B?V0lNVzZYZHdxemdHQmUxR29tem5aVkVJTWlBSzVqaE9pRFFVK0ZZdCtWOUNw?=
 =?utf-8?B?VGhxanlRTU5GZlpHaE9nNWdtVTN0TXNxV3l6MUJkL1l0dzlQVjdDb0J1OWla?=
 =?utf-8?B?bG0rdTI3TnRDbUxuT3JhWVBCc2FMYnc3TnBLTm9kejVBOCtyUkFXdnEvbjNN?=
 =?utf-8?B?d0h5Z0JyQXp4R2t1cHZrdlF4SWhsVGpTVk5oTDVIclFZZXd2NTViTVcxVmhr?=
 =?utf-8?Q?zZb71tzxVcwd6WDAhulI9ky6a?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5dbd63-c734-4328-a905-08dc6bd2e314
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:07.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CSe35Dopixa7e/iwt6n4cKl+rtZwbBirxi2n4WCfFXYuZHjR//RTFlYT7pZyIQX36YKYZd1NsDq7srhIlZAHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Peng Fan <peng.fan@nxp.com>

Bootloader might disable some CCM ROOT Slices. So if mcore_booted set with
display CCM ROOT disabled by Bootloader, kernel display BLK CTRL driver
imx8m_blk_ctrl_driver_init may hang the system because the BUS clk is
disabled.

Add back gate ops, but with disable doing nothing, then the CCM ROOT
will be enabled when used.

Fixes: 489bbee0c983 ("clk: imx: composite-8m: Enable gate clk with mcore_booted")
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 53 ++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 8cc07d056a83..f187582ba491 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -204,6 +204,34 @@ static const struct clk_ops imx8m_clk_composite_mux_ops = {
 	.determine_rate = imx8m_clk_composite_mux_determine_rate,
 };
 
+static int imx8m_clk_composite_gate_enable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	val = readl(gate->reg);
+	val |= BIT(gate->bit_idx);
+	writel(val, gate->reg);
+
+	spin_unlock_irqrestore(gate->lock, flags);
+
+	return 0;
+}
+
+static void imx8m_clk_composite_gate_disable(struct clk_hw *hw)
+{
+	/* composite clk requires the disable hook */
+}
+
+static const struct clk_ops imx8m_clk_composite_gate_ops = {
+	.enable = imx8m_clk_composite_gate_enable,
+	.disable = imx8m_clk_composite_gate_disable,
+	.is_enabled = clk_gate_is_enabled,
+};
+
 struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
@@ -217,6 +245,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	struct clk_mux *mux;
 	const struct clk_ops *divider_ops;
 	const struct clk_ops *mux_ops;
+	const struct clk_ops *gate_ops;
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -257,20 +286,22 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
 
 	/* skip registering the gate ops if M4 is enabled */
-	if (!mcore_booted) {
-		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
-		if (!gate)
-			goto free_div;
-
-		gate_hw = &gate->hw;
-		gate->reg = reg;
-		gate->bit_idx = PCG_CGC_SHIFT;
-		gate->lock = &imx_ccm_lock;
-	}
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto free_div;
+
+	gate_hw = &gate->hw;
+	gate->reg = reg;
+	gate->bit_idx = PCG_CGC_SHIFT;
+	gate->lock = &imx_ccm_lock;
+	if (!mcore_booted)
+		gate_ops = &clk_gate_ops;
+	else
+		gate_ops = &imx8m_clk_composite_gate_ops;
 
 	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 			mux_hw, mux_ops, div_hw,
-			divider_ops, gate_hw, &clk_gate_ops, flags);
+			divider_ops, gate_hw, gate_ops, flags);
 	if (IS_ERR(hw))
 		goto free_gate;
 

-- 
2.37.1


