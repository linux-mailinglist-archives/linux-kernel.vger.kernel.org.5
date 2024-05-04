Return-Path: <linux-kernel+bounces-168463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D58BB8DF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021D0285FCF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99FA920;
	Sat,  4 May 2024 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KzuYL9/K"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB1811C92;
	Sat,  4 May 2024 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783288; cv=fail; b=qOH9J1n6TjaTO1E2vRIZh2WmjdE1Qo5/7DB7LEcMrtvQWQMidwdS3+uAJ4gIvCiG1+pdh42QAstw9+l4r07WdUP6QLkZNf6UYxox9O7vUcQa3MH8RbaG2iC6g+gZALOWtgYUhU1g1+3VdCrBVTtpZOcI7L+8OPJhiMVCGEj66Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783288; c=relaxed/simple;
	bh=3/ebBXKy2EoNIVdw7nEZvhT7omyA06RAqLLNddA8Y0E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b16/cLQ+Kxyph5SGT1SdcE6PP2uKhIngLjQMgQ13XQkHKsNVkeaIqNQy4VBRQ3pPGzwx9HJephdSBOmpRZJbjSawrEA5oV8xyPu+dsQGFyvC89uo/BdHOfRzr9Gn4S0R0W5Ge/+oBfI+2LiVegzRZ0tRumergPuBRMsEKJjThzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KzuYL9/K; arc=fail smtp.client-ip=40.107.105.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+rqCrS8Hyd7TH4m0u4V0b37wl/n0AxHFRY65ko6CoXIG/WplV91G3vrJZg7iriWAb4fmCvKtM4sqkjDphwTi3H2tc3YadE7hTT45JItYWDCcaWuVuyvmNdtUPcQUB7WcUbdRq7NnmxOokeG9+vFOvFtziuzHhZXN/8AKEZ1Hq7aSBsptAhB+NWlpBSyDxJcxjDYyLEGS2msg6kPhe+obGeq8z4Hyg/JM7022qc1q7eN3n6k9NC+mPq/s9lr7D9Lf4PcKLqwMfL+QNRGAWCN+Enia7kZFdMT2yP689VFxJuzBEdVei0mU2VlpOjIazSPOAgIedexIhqjV0NmlIX2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuO7Ij7e1bLmWdg4m5AsnXdVhWvgoEiSvYg9UuypLak=;
 b=U9E5F5su/Zqvuki44gpEBTsSgQ6vXPRLf/BxsbPzG9ZRUtMGC62uaDy8yed7SruV1d/1JMs06d4uKjQqD9sBTbXiLHzaD129+yNXd7pAK99bKIdn9fhAI2YZ4LyYcKH/zojRisbSnNFeB4rhF3JS6oWx3VvWH7vhln3W9URMEhx3gfiHYAbt+dILY9Jm9quvtHh12vL32MAZ978T5pMVeqBX/WlCVQ7s1rtxqfbRK1WJXRme8bJEG0yl67vVhWNn4rQWdfyXelpu3wBA3+iqPBxQjuykPeTQz00PRAlIYtI29+1mbje6iQ15H5T72lp1GGpM9SJ++BbkP4UCsQf7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuO7Ij7e1bLmWdg4m5AsnXdVhWvgoEiSvYg9UuypLak=;
 b=KzuYL9/KXQBhL37KJnAL5cHJGCUmphtaKOIZxXT4EuI61mS407Njty6SDMff615yzZFK2KbwzHifQg9o8FSydzVOc3o+KJWsLei/gvWDlr0KUsL0OwjyypS7QDM953HCjCq2Ye1kXpeSwtOwVZ0Xw1h3JfT+LNXF7wwrMuP2nEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:48:57 +0800
Subject: [PATCH 04/18] clk: imx: fracn-gppll: fix fractional part of PLL
 getting lost
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-4-f7915489d58d@nxp.com>
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
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Pengfei Li <pengfei.li_1@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1031;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=YbtICGkfjNb9cX1EM8cRO+LQzM8n6WyxoMB7kWtrQtY=;
 b=jrvhcFI5A0TDVLYiN93pgFRnHBfEzaAtZottJqh9N0mJZSMZZbq6jKsIjspzFpIijQ8VNvsEK
 9dyqy2dHRWFBYRw3SuV7F77UIb90YppE2mLaJMt0tu5PmT+pHxFE5OM
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
X-MS-Office365-Filtering-Correlation-Id: 2f9278a4-1356-4a5a-8146-08dc6bd2ecd6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTlHeGpuVWRlMlRRY2w1UTRrS21FMXQ0clN3dnluckJ1SnNhalVpSzVjNTd5?=
 =?utf-8?B?bUZESGU3SGlCenk5aVh2cmd1NzM0bnNGci80bjE5bG4ycWNNUjA3cC9kNHJn?=
 =?utf-8?B?VWpXY1NLMTg2TWd6ZzQ0eVVLemN0eEJsUW9DYXhFRjgrTndEYzdFZU5zZFl2?=
 =?utf-8?B?OEtCSUVxbWExU0YwOE5FYlUxVFRYM3VrV01PSmJZM3lCeEppWXJNa0owOEJ5?=
 =?utf-8?B?TkowY1ZkNFIyaFZTSENwcUlsUW1DT0hlWWUxRU04MEpwZC9NNnN0dXJYV1lN?=
 =?utf-8?B?T3MweXdJQUs2bWZLZ0dlMG9kRGk0U3lBaXdURnM2K1hFczVHMmJvSkc2b2J4?=
 =?utf-8?B?U294dzZkUHB0Y2NJV1JhQlg0R0xEdHAvVDJGcTZkenNXTCtBeklnWEdjcWZk?=
 =?utf-8?B?M2VxUmxkYXpnN3lyWjV5cUU2RFRPV1o0amZVT2tGK3hCa003TVJPZGQxb013?=
 =?utf-8?B?ak9zdFJHaTBOdXNwZWNJNEZ4Y3c5Ymd0VjVvSXo2VjZJRzAxS2hYZFovV0xB?=
 =?utf-8?B?WkRTWkhWUXgvWWovd1EwTUx2WDVqWThPdmp4YXBPUzc0TVFmT2liZFVFeDVr?=
 =?utf-8?B?UEJXc29VTWhncTljUWxRdEhXYS83TDVKZlZZUmExZzdvRTI0NmJFQS91Z2xa?=
 =?utf-8?B?MzlQVnRnbVBxWHI1WVI3K1U1VHJ1Rm9Beit3eW1CMStTOFN6Y0lDd1hIdFFX?=
 =?utf-8?B?Q1FNK1kwS21QNkpjcnlCbWFQc2pWMU9YSjZrQ1VpdXJ2TVFWMzJpM3JiWXBw?=
 =?utf-8?B?dnBwZTBWcHFWTHVQcm1OL0hwQ0o0Y3laODdMdkJvalJWaDJsWElOaWl6R096?=
 =?utf-8?B?M25pc2hTVnZlUUFJSEk1MHZ0SmlKQk9McllFTUU5eDFFempZcFFsN3ZENHEx?=
 =?utf-8?B?Q2lhTHlZZ2VhTklkenBJb2ZlVFFndFNGVEdZMDNiR1NnLzhNK2pkSWFnajNL?=
 =?utf-8?B?R3VhU204c2NRWlZTcnZYT1MzclNJMTUybmpxVTJDNzZWNUZiZzVyWkl3bEsx?=
 =?utf-8?B?WC9jRWNnTkRXUWNGMVpKQkxTZ1lIN1NTQXQ2SkJGeElzaXprZVY5M1dXLzJ0?=
 =?utf-8?B?SDk5YzRIRkkxa3FwdnRtei92cEtEMXBwVWh4S2dEL2ZhMElDbzgyMkkwdU9t?=
 =?utf-8?B?cmhueDgyNzZiY3hobEpsUFU2amtpaENkRThTbUlWOUJIZVptTHpQR0UyZzJj?=
 =?utf-8?B?VWg4ZWRKUXBWaE5PRHlNQzRWTmxVdWp2cjJYYXloYXp4ajJNdUk1VVpXQ01s?=
 =?utf-8?B?anBMUUJzOFA4WXhybzJOU1Q4UzF3VVc2Q0pWeEZyL3FJY3JRKzVlU3V3NzZS?=
 =?utf-8?B?YkswbXpNYnRJRFpJRm5qTCtRVjByNzNiNE5hWTdWUUZ0TjdidllicU9tZ1hn?=
 =?utf-8?B?OU9Db1ZSZHV5QWxrUW4yaUxJdndPY1ZZSEV5Y292ZUhXaHM1RlowQW9FUjFN?=
 =?utf-8?B?UlVvY2ZTWFdnWG5vajh1b1N4VXhXVktkZXU2THRNWWNpMkFEb3c4ZEdjMFdU?=
 =?utf-8?B?Wi80eStnaExsUmF6RnRXcTVYM1p1WWdzVjZUbVd2Z1RuLzRSQmo0dS9BNlJI?=
 =?utf-8?B?bC9KZEhrZ0gvQjAyZnZ2d2UxMDY3YTYzRFREY2dMcVI2RUhsblNDY2x5dlJQ?=
 =?utf-8?B?K0E3R21UVWM4T1BtRzhQRzI0blhyTklJL2lacUxSbG1NeGdtWC9lSXY0VzJO?=
 =?utf-8?B?V3RNbTZvUG5CSkFNeEQxS05nV29KcmhDR3U3Nk83bDNpOEpEOForUHNkaGFT?=
 =?utf-8?B?YUNyMzJOZVNuTGlabDB5S0g2M0FFMmxVUjQ1eVE3QS8xUWNQQW0wY3BXV1hI?=
 =?utf-8?Q?UFcbtdcHp2UNhwXj/s5yGek0P6m9eygQEZ9ik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjZDNFhnN2pxbUQwdloydktkRzhCckVVZm5CNmVQWHB6emMweGpKV2hKZ2N1?=
 =?utf-8?B?VDk5Y0o0azRpV0MvRWRVelZRNkdXcm5GQVk5cU50Q0V2T25xb2ovbWNPRzZT?=
 =?utf-8?B?aUdZVkxSNXZ2OWEyM2luRXlHMVZoR1VzcGhnU3ZZRmZDaWN5YmhEOXlrNlJh?=
 =?utf-8?B?bkcrSU9wZEFmZk13bnQzSVBqS0EzeDdVT25hbUdkL0Jjc0ljK3lBSUFhOTRx?=
 =?utf-8?B?RkxMVEJadjdXZkd1WU11QTBGOGhXR3hMa1hlWmo5aWxuUzVzZzVubG15dE03?=
 =?utf-8?B?c3hhbkVRNER6WjVzY0I5OGhTT3dLSVU3WXFlb21qdmxncGNUYVJIUGJrdUdI?=
 =?utf-8?B?MzBhczRSTjN6YTNzbGw0NUJrbGtjVzcxSGFpQlI0R1BZanNtNUlXOGVYZVMr?=
 =?utf-8?B?RldNeXVPNWY3WFlqME1rOHlXeWdwcnRrU29kOVhnNjZxbzdpVkdVdWFaa2pE?=
 =?utf-8?B?Wkc3VEZFYTlSSGhycGJEamhVdE1zeGQ4NGZ1amIvQlQ1VHZZMnVPWnRnNnpV?=
 =?utf-8?B?SWUwQ2hWMWM5Vk43WlN4SHM5dk5Bd0ltWEpqRVBmbE4vbktaeGJHbU5EL09x?=
 =?utf-8?B?NDUzV3VJOXNKanlrb21tb0Mwa3VYN0FmaDYxVC9SVVFBRHk0eituVXV2RDZY?=
 =?utf-8?B?aThDbG1Hbm9lQzBNZUZLOEZPbElKcFVQeU5hUHJQWkwrdm5ZTElzUDVQNjAr?=
 =?utf-8?B?ZEpBbVFXc3VTWXRTalE1Yk9OM0kvOXdQeEkrQXoyRC9XMzBYbkRmc2NwMXFF?=
 =?utf-8?B?YkxHZUN3ZFVhSmpNMlp3eTVBclRpNWc5OHhDV0JXbWQ2Qm5ZRDJpWUVQM1I3?=
 =?utf-8?B?eUI2UTFLN0g5UnlQVzM4QjRBU2JpcWhtNm83cjlyZVYyYXFRVC9odVE0dllr?=
 =?utf-8?B?N0d6ZVR2TWpLVHNBdGRwTG1LZVFyL1lmVVVlVFVleVZmSExQSXgrV05HUERm?=
 =?utf-8?B?czMyZm5aS0hLeXZvQVU5eUE2VU9BVUdxSFA2SW9hMXBXZTVENkxtZ01KZWJT?=
 =?utf-8?B?VjBnZFRwcDNoWkhnbjdGRW9tZXRMV2c2UXdNMm1obHpRVGNya095aXl5Tmx2?=
 =?utf-8?B?a1oyYXlGQzlFT05nSjNwajNiTDUyVFRJNEhpUytuNGl6OStTUjF3MUJHZ0Uz?=
 =?utf-8?B?cGM2TUdXVGNxMmkxWjJSZGZROGpwY3RLb3daaFUxYTlEMWZWUGxxQnZjRWtt?=
 =?utf-8?B?bkd5SFBxMXhyc2g0Qkg4V0drUEdvSkorYUxkUVNxeUpydEZrRm1QS09GZG5M?=
 =?utf-8?B?UXF6emcxZDZKTmp1OUdqUHVlZEYyeHBxYlZzQ0RKMDVsbkFUMEtiUEVndHRI?=
 =?utf-8?B?TDRPUkdqVTA2Ui9xTDFYSnVZV211OTJlMllrTVhBUU5tVy9oU2JieTVhT0h4?=
 =?utf-8?B?YVFsN1NpR1VEcmZuUWt1YlhCQXlKQVNaZmVlUDFPQ254NnFoQnBXaUJSL0Rw?=
 =?utf-8?B?czA1VkVKYTBtQ21QalVYY0hwRG8xYVlRLytLbzZjeWZiQWt5TkZ2QldBUVdS?=
 =?utf-8?B?WENSeHRWcDdBb1BhSE1LYkxCZ2hQZVFyMmg1Q0hSSEVOUTdjZEdHNktsTEow?=
 =?utf-8?B?UnFCeWwyTVMyeTlCSTBFTVpWUlBPOWp6STNzZDVDekVuaXZoQWk5SlkvMXRn?=
 =?utf-8?B?R096STlsSFJFdFpVaGZXZ2tKNGduWEU0bHVVTWFpbWYza2FUbEVlTWxvY2ZG?=
 =?utf-8?B?a0tqclNtanhhSTJpM0ZpNFZ5cFUrbHFaK1ltNmtkbkNZUWlRRUF3ZkxQNVBN?=
 =?utf-8?B?R2h2a2NUcEFJeFJVMHN3Y29YenRTVk9PVVUxaFFmZXV1d2MycXAwU0o5a2Jt?=
 =?utf-8?B?MS9HYnFHYWUxZjJiRU9yeUREMy9STU82NXFEY0JraGw0SHloZE5JTVRvbURm?=
 =?utf-8?B?SyttTVFZRmVtTUVVUzVpa3JvN1lOOHZNanc1dGtFVlpGWUhqeEoreklVb0lp?=
 =?utf-8?B?N1Q4bENLcEdpUnhkV1pYbU9OWUxaekdTbm9HWExhbkE1Ny9vQy9QNzN3aWlp?=
 =?utf-8?B?dG9jaFZOTE91cTdxbEdUU29MMnRQTzBHUEFPVlBOYlR4OW5vbUgxeVBlZTFD?=
 =?utf-8?B?ZmJjVnpEWFF5cEJRSm5ZakM5NE95R1JqSUNQaXBKU00zdGg2YlJzSW5Pd3dk?=
 =?utf-8?Q?5bGd8d7yxo8ARzg2YLDHQq5Et?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9278a4-1356-4a5a-8146-08dc6bd2ecd6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:24.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw/6m/C2uAUBhJ9QVYPYLvd96EgI9w3xw71VL9HviQ09AGG19yW5KgTSyeFhdMtzCygQNSjc2WsPydgN7s4uTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Pengfei Li <pengfei.li_1@nxp.com>

Fractional part of PLL gets lost after re-enabling the PLL. the
MFN can NOT be automatically loaded when doing frac PLL enable/disable,
So when re-enable PLL, configure mfn explicitly.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 44462ab50e51..1becba2b62d0 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -291,6 +291,10 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 	if (val & POWERUP_MASK)
 		return 0;
 
+	if (pll->flags & CLK_FRACN_GPPLL_FRACN)
+		writel_relaxed(readl_relaxed(pll->base + PLL_NUMERATOR),
+			       pll->base + PLL_NUMERATOR);
+
 	val |= CLKMUX_BYPASS;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 

-- 
2.37.1


