Return-Path: <linux-kernel+bounces-151682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090318AB1FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7724F1F23C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6826130E31;
	Fri, 19 Apr 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="iUUlN76O"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2095.outbound.protection.outlook.com [40.107.104.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB976130494;
	Fri, 19 Apr 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540933; cv=fail; b=S+XGvQP0EzCawBVR/ZCAN1Ld8MSUcK5AF3R1XJQ+FZujF5oT3/h+QfJTV0flkeugER3urSY5C6zsVNIhxnQtk7faWF1AHI98X2LMLj5KisN4+GF5xpIWSmcC7AdRiJ4g0fzDXDeTaBRRwswxmvogcG42VF0ZmfGnliUtoHINBwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540933; c=relaxed/simple;
	bh=4qOEVo/WCBLin0OpN77ESpYNsGu75TdiO3EY2x/Bbas=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jdz3waK4FAqZ5fOjQ6o4rkP/+Gmgb9LCQw6N/hyPMDfboerPZvUWee/8qDu0rY5m/jCLMzmSQVrkZa0QHt8hAEJk7sMrkW/qy80lpZ79DQQJa3j21K63tF/rsOf6nSmvV8YEmglCM1PqCFRvKy8bN3wgiL7DPa3Jsu3U/WAYc6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=iUUlN76O; arc=fail smtp.client-ip=40.107.104.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU4/Oa3JIhrUs/ZDC0zAybBacpu7EQXyp+c8v+X6bL2vsZTSsxE9oOqhSC+4KfMi9hFPL/ZQGwJjbANoCAmB8acRw+dB7PlSBHbRwtnDfe52puGdW8+nZn1q2mHJkeZmj4TKPtasn5e8xjvtkSTnoyLot1pR2DbM7xh6eD3aQVdXr5k6BeusuS4q/1AW46e7a0zZSZZHapjdCL90P5H0qKWPem+PQZH5/WoSMW+Ao0deZAX7SWeYNnhue+uUnjpAc1KzA80PBq1mE+6lfKdPP8IkdjEO9lGptGbby9Ggop7fzJaxDVE3M9QN9Ji8Qvy5ISDhO1PO5uDPPWqLWrYViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48jtsrGhSb43p1yDkWQYR0PZtJP8BSR2tlAJiufzEuY=;
 b=hG/GMYD3MD1gCwZMgkTuVS+L8Yhd7V9DRmLE8Y5BjDQjYKc3Vhwtjnzi8rwenZT+bxTHISeGRKxclrBgqBmbwjVP3KIjE3LcegHRV0sCw5uApeQFbcUjp/Lr9ZO6n1PxQTueom0i8er9MOqcMq4ShET4gd1nNVhOiIQihtxEKkFjjnG880gx1YMS6rhq0toG1tFb3oUrAMEz/CI+j17jS/13irTycGdBhCIlsBb4oWAOP/eMBTzmlh6/3uFisdSD1bEfHdtYulHwKJ3o2t4gYJqr0kZhqpXka1LKKZS2m9sRSR0hHTu8XWdMMS1yiV9fkLyaYOyhrRtEZspZ4Fnfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48jtsrGhSb43p1yDkWQYR0PZtJP8BSR2tlAJiufzEuY=;
 b=iUUlN76OWVLnOt0ENJFlfOAoippwhfWaXDL7Q4M7Pc45TuVJClKNFZfvYWaoReW6ZFdIi1+NEPklxzI3ctuKMFp30b1Z5RB3yDN6PsCs2BmqubzqCQIz/ZsU0OPxUzDplMFRTEV7XPp0sAM2uvnMU0H1YCwQ9H/KbXZykT9PMOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 15:35:26 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 15:35:26 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 19 Apr 2024 17:35:18 +0200
Subject: [PATCH net-next 2/2] net: phy: adin: add support for setting led-,
 link-status-pin polarity
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-adin-pin-polarity-v1-2-eaae8708db8d@solid-run.com>
References: <20240419-adin-pin-polarity-v1-0-eaae8708db8d@solid-run.com>
In-Reply-To: <20240419-adin-pin-polarity-v1-0-eaae8708db8d@solid-run.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 43097cc6-d8da-4df8-5001-08dc608655c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWpIZTk2TWZmMzh5WlcyVjRLNHdNMFdlMEhsT2Z1aDI2RENuSmdLQzh1WlZ6?=
 =?utf-8?B?N3dxMGlEaFc3dUVSTHNEYmhGZGFwTlBxeFYzejRtUUQxTHBDZkF5aEVVWitF?=
 =?utf-8?B?R3cyU3ZDcFdzeERyY2p3M3pOellHVG5ZUDZDZHptbXdBQzB1ZWtTMXByMmRG?=
 =?utf-8?B?TzVKU0FaMWpsYXNSMFpRMkJTUC9SVWMrUndkMFpIWUpXSFRvMGw5WEhGbkk4?=
 =?utf-8?B?UjVOK0dDTTU2VFN6QUhnZnRJaUwwdWNaYXdtNENrNUxEQXFnZ2VjbzlDbWhI?=
 =?utf-8?B?WHFUTmUrZ2s4Ulc3Z3U3bjdXWUJQbWlTWjJsY3VVTEx4c3hwZy8wMk9rcnZR?=
 =?utf-8?B?MU9vcGlLVWJadEovMFZFQTl2aCtna1h2Zk1tYzFvSEtMai9RM0RZb1lNLzEz?=
 =?utf-8?B?T0s1REY1VkZ1cXZNUWRTanVYNDFmR0QwbFpxaWc4VGF6MVBNMEZNenU0bGZw?=
 =?utf-8?B?eDFsN3d4MFFOaG5GU1prNC9LRE5KV1gyaU84cFNpc3JraFZ6UVVRSHp5ZVdi?=
 =?utf-8?B?TjJMSmkrNDA5T3BxczRqK0xWc3FQUEZtbWZrcjlzL29KV1FObzRoRnNsZXJK?=
 =?utf-8?B?aC9SWGFZNnVja2c3Z0x5VzFzaHBEZk83R1AwSFJYQXU4Z3huTlV1RTkyWE5N?=
 =?utf-8?B?a1NScVZtTHJ4c3Z6ZTBCMmQ0UEV0UHltc21rTGcyQlpnNTltMGZUTHlTb0h3?=
 =?utf-8?B?ZjVHbmdsUm9NT3FnWUQ0NTNOei8zUTc2OGtuWkhzU3RMRGdtRHNwTGFnSW5U?=
 =?utf-8?B?ampySnMySUoydVRkeU0xMG8veW9QQjdLVGtPbXE5OWFBNkl0b1JmTXNUZXkw?=
 =?utf-8?B?ZWtxSCtnekdraWdKaDAyZ0dFQlJ2Q2NhWGNkNnpVOUdIYkNUV1JzbzQyNmRZ?=
 =?utf-8?B?cjN6QTJoc0FlVEQrSHJ2QkxrS3lOYWQ3UTI4OG10UW1FN0h3eVpYQzhESGRC?=
 =?utf-8?B?alh5bURnVEVnRHlSTDAvZ2VRU2Vwbk5DZ25waGRIOCtBb1FUazVLVUJ3Kytx?=
 =?utf-8?B?TmtYcjNEWVJiMEpPNEtJeGFyMEdEdjB0d1A1RjZLUTRveWpjY3lLWS9TMisw?=
 =?utf-8?B?TEM0QVEyVm96bVZMSkk3aUU5b1VIN1JqL25QdnhIcEUwcTdlelNUbkR6UEhz?=
 =?utf-8?B?alVUMytjSVNxaWQzamhXMnJzUldxTU03aC9TRnZpWUZvd2pEK2hJVUQ2bWtw?=
 =?utf-8?B?ay9iSXEwdWU0Ynl1Y1p0VTNub1BqNXA5YU1RbGZ2OG9lejlnZU50V3RUb2RR?=
 =?utf-8?B?bjVzR3VrZDV5eWsyc1U0UE9GYkFDc1JxemFKbWFWN1VZRnE3Z2pCdHk4Z2lm?=
 =?utf-8?B?ck5uMVU5eld3ckQrY09YdEJBL0ZZV0VOelUydFMxb2ZTMTVqaXZlUW9ONmIz?=
 =?utf-8?B?YmpmSEwrZlRONnBLWFY1dWkya2VJelpwRThrOG8xc1NvVUpWVmQvTytmMFp5?=
 =?utf-8?B?SHVmMkpobWZnRittVS9sM3lxMW9tZ3FRZVE3ZnFUUVBSNXpvMXhvbm12K1p0?=
 =?utf-8?B?aW13OTk4bG51VXdycVIyZEhlNkQvcmJPYXN1UmVkTzAyWmZBMUkvanRGWndV?=
 =?utf-8?B?S3lXS0NNQkRMVng4K1FLYmR0d0xzZng5Y2pYNmFKZHlFbGw2QVQxOTJUaUZN?=
 =?utf-8?B?TktPdlZXTDhFOU5aSWJubndNVVJiVVhvMnBCSmhFOVROanNTSHpIRnhmcTdZ?=
 =?utf-8?B?c2RmbE85VEtGVzJaUVlRaWdEL25ldm1yM3F5U1RTQ0Faam43bVlhSCtySGMy?=
 =?utf-8?B?WE5jdnk1anhJd1ZOd2pKM2FPZ09pVWZmQlZyVXJRTC93WnZsMkJJcDNHR2hP?=
 =?utf-8?Q?+s2Kd7P/0dbv0NrlBJOsJyO16CAd9yZNDuPbc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NllxOU00WnRiNDVHL0JMcGE1eDY0c3VJSWJXc2J1a1lRdFVRaVowZnMzdVBv?=
 =?utf-8?B?N2ZkdjZ6UDJ3QzUzUTB6cnpZUElxR1hGemV1N3B1aGVBbVB3eE4ycEdseXN0?=
 =?utf-8?B?bU1tdzM1Z2pLbkQvaFhDQVJEM2VMN2E5N29STHNscWpjS2RmaXBobjEyMGw4?=
 =?utf-8?B?WXJpU2duWjJYb014MlFFRC9HMGlublhvemtoYmJEeGlCOEZnT2ZjdjF2dS8z?=
 =?utf-8?B?Qk9MQ2ZaRFc0QkxZbmNtV2xpa3VlekxyZVRDYko5bG03UzNvejdUQXN3TSt5?=
 =?utf-8?B?a2I4cTRoblZZSVF5ZDdKU2lpQzl5QWI5T0dNVHMyRE1vOWNYUGhVeHZKbk1U?=
 =?utf-8?B?MVZsa1RDU1llTjhRdzdFVkcvZ2pqL1hReTU1bHlpeWczUVhieW9oN2tYeWd6?=
 =?utf-8?B?cTNFcVdua0J1U2s1T0pOSjlUdVYxdXl1Q1lYVXVmci9EanpjZUFSdGY5YTV5?=
 =?utf-8?B?anFRNitiRzFDT3Iwd0NTL25iYlYxTlkrdmkxQ21yL09qaHl3cnRsTDNoRCtF?=
 =?utf-8?B?R3cvZk9DcWdtQ1NzWlIvS1VYU25XendXSEFBdWhEZVpiMmdCcHVsb01IbVQy?=
 =?utf-8?B?UW5YMzBFcXZHNVJpOHF5a2VuU3R4cXV4YTczSGtzUTdySnZod3I4L2J0bU1s?=
 =?utf-8?B?UGdvek8rdmltc2NPanpidXg3eWxyRWZBdnJMbkowei9wM2wzMU8rUXdSa2I4?=
 =?utf-8?B?TzFQM1ZFVXNja0laditlL1JWTG9yalBXa3JZWEZsd0xjK3VnME56cXZwUXh0?=
 =?utf-8?B?UDRyVU9nNDl4ZHVUMG5VNU85d0I2QWlOVElzWjNZRUtzRlJ2YnZ3OENxSXRs?=
 =?utf-8?B?bmRRN3ZCVjRSTXNPelFySThUNmhmNVZXdFc5cEhYU0I1REJqQ1pLR28yZnh6?=
 =?utf-8?B?NVcxSHZacXUydTA1Zjk5N3ROeG9GbFMzYXJPZlFaTytYREhvNENYWjY0d3Rr?=
 =?utf-8?B?MFlkWUFsWldkWlpGSm11cjFlMVVmQzlLWXBKWnFYUlJySkZFWXh6SmFwdzJB?=
 =?utf-8?B?Vk1EYVhGSVc0U3VLL0RXb3I4d0FaSWNxSEdsWFd6N2tpL2pwYm85eENKdlFz?=
 =?utf-8?B?TXZjMHlDSUR6cG5jT0txdXBuYXp0Q0Z4c3Zidis0UjgwaUtUNU01OWdpK0Qx?=
 =?utf-8?B?dkw4S1JacWYzYkI1ZDl4NVNBNEZ6VGk5bm5nckxDNElqNHJjVmZxWmRoRlh3?=
 =?utf-8?B?NnUzWDFhV21xQzZUMWNjM1d2b1R6MnJFUjNKV3hvbDhreWJkOHNlOFhNZkVt?=
 =?utf-8?B?QjZvRkF5c0dGa3lMRFRSZlAwaC9sbjRwUE5xcFJXdjVCNm5FNkZnMlRhRnpy?=
 =?utf-8?B?c004NkpIOFIwZ3BGQmNYZWZFanM1eGlTU3BwTmJjRjJQZmticHdpMHNwZ001?=
 =?utf-8?B?U21hNk5rcUJYWFZGZEI2Y21oUU1MTXkzWXRKTXpvcEdMMmwzMmR0d3RmR2F4?=
 =?utf-8?B?d1Bsa0V0dG9hY0dDcDhBQ1JvWFR4Q25kcjRwV3pNb3Z6QjZEWEswQ0praWtP?=
 =?utf-8?B?QnE3VEMzM1hjSjFQNWxXUGtqSTd1OHBMaWtBenZHdW82N1ltYWFQU1lTSlJT?=
 =?utf-8?B?V3N2U3gvV1poZ09mS05kZ0hJWkRxWkNSenZubWZ5aTZIdmwzTzREbHlCclk0?=
 =?utf-8?B?R3RpZ2JVN20xb0hGU2kyNHlFdDlteXMrdU45ZEJLcDFMYk50TVlicit0N0ZX?=
 =?utf-8?B?cGMxbnp4SnFEVHhGNnBxQWc5N2FDREdSTWNFTm5RMFhqOGJhQWpXTVVUYmU0?=
 =?utf-8?B?OFFIdXlRN0VFVnFjdm9TTFZQaURqZWx2cWRtcDRkMXJpeTdzb1dqZ2s2Q1FO?=
 =?utf-8?B?Nmxad3BuN01CRWF5Q2VJcU5PQ1B0VzRKLzlFMmhvR29NdzN0WitTQjVUb1pI?=
 =?utf-8?B?OXRmbXAvWGlER3p3d1JQSGRCbGhITjVVOExOYUV3UThKSnRYa3JPaU5lbEpl?=
 =?utf-8?B?aENaMmE1ZVhmZUE4dWNzUTN2QnVlTHlpSFlTemVveGM4SXk3czlrOHhvaEl1?=
 =?utf-8?B?NUxkRm53S2ZTL2wzb0ZXaUhCNEluYVpLOTJVR0NYRzZzY2pTZnp1Z3VMUVd5?=
 =?utf-8?B?OHpSeGdjbHVsOHM4VHJkOGJhNFpJSDFTV215UzFRVUgyU1ZoMERJVmpkeG1t?=
 =?utf-8?Q?wa9r/tNxuQjFF4twyMXBRijay?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43097cc6-d8da-4df8-5001-08dc608655c2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:35:26.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOiZNjiG+KHEdiuMIDIYlnCMlganAZO1TD4cqtdBXv5sjaOb3zSHwO3BrgFkJ8E3Su/VjMNFhko3xUn9Mj0kGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250

ADIN1300 supports software control over pin polarity for both LED_0 and
LINK_ST pins.

Configure the polarity during probe based on device-tree properties.

Led polarity is only set if specified in device-tree, otherwise the phy
can choose either active-low or active-high based on external line
voltage. Link-status polarity is set to active-high as default if not
specified, which is always the reset-default.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/phy/adin.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index 2e1a46e121d9..53159dea6381 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -114,6 +114,9 @@
 
 #define ADIN1300_CDIAG_FLT_DIST(x)		(0xba21 + (x))
 
+#define ADIN1300_LED_A_INV_EN_REG		0xbc01
+#define   ADIN1300_LED_A_INV_EN			BIT(0)
+
 #define ADIN1300_GE_SOFT_RESET_REG		0xff0c
 #define   ADIN1300_GE_SOFT_RESET		BIT(0)
 
@@ -158,6 +161,9 @@
 #define ADIN1300_RMII_20_BITS			0x0004
 #define ADIN1300_RMII_24_BITS			0x0005
 
+#define ADIN1300_GE_LNK_STAT_INV_EN_REG		0xff3c
+#define   ADIN1300_GE_LNK_STAT_INV_EN		BIT(0)
+
 /**
  * struct adin_cfg_reg_map - map a config value to aregister value
  * @cfg:	value in device configuration
@@ -522,6 +528,49 @@ static int adin_config_clk_out(struct phy_device *phydev)
 			      ADIN1300_GE_CLK_CFG_MASK, sel);
 }
 
+static int adin_config_pin_polarity(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+	u32 val;
+
+	/* set led polarity, if property present */
+	if (device_property_present(dev, "adi,led-polarity")) {
+		ret = device_property_read_u32(dev, "adi,led-polarity", &val);
+		if (ret)  {
+			return ret;
+		} else if (val > 1) {
+			phydev_err(phydev, "invalid adi,led-polarity\n");
+			return -EINVAL;
+		}
+
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+				     ADIN1300_LED_A_INV_EN_REG,
+				     ADIN1300_LED_A_INV_EN, val);
+		if (ret)
+			return ret;
+	}
+
+	/* set link-status polarity, default to active-high (0) */
+	if (device_property_present(dev, "adi,link-st-polarity")) {
+		ret = device_property_read_u32(dev, "adi,link-st-polarity", &val);
+		if (ret) {
+			return ret;
+		} else if (val > 1) {
+			phydev_err(phydev, "invalid adi,link-st-polarity\n");
+			return -EINVAL;
+		}
+	} else {
+		val = 0;
+	}
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			     ADIN1300_GE_LNK_STAT_INV_EN_REG,
+			     ADIN1300_GE_LNK_STAT_INV_EN, val);
+
+	return ret;
+}
+
 static int adin_config_init(struct phy_device *phydev)
 {
 	int rc;
@@ -548,6 +597,10 @@ static int adin_config_init(struct phy_device *phydev)
 	if (rc < 0)
 		return rc;
 
+	rc = adin_config_pin_polarity(phydev);
+	if (rc < 0)
+		return rc;
+
 	phydev_dbg(phydev, "PHY is using mode '%s'\n",
 		   phy_modes(phydev->interface));
 

-- 
2.35.3


