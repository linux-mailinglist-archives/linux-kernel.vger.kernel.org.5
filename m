Return-Path: <linux-kernel+bounces-142510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8B8A2C98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904051F248C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5CB40C15;
	Fri, 12 Apr 2024 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SZ/V1cWb"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2062.outbound.protection.outlook.com [40.107.241.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D74A29;
	Fri, 12 Apr 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918362; cv=fail; b=OXPyL041/a+7iuI+LLP+eC10Kh1QFV5M8vQiohZkHzyyTbI32RdIapfje1nNXPZ2igdnO5Pdj1Z60AHh7aTRgOrVLMgnTkXgyw7M+B8mk064qdBb0ZqOq4W5qILaJuXEzPsBuRC6exzEVnu6w+jTnKO5RVW/7EjTCrY85hgitCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918362; c=relaxed/simple;
	bh=6yyXhWvNixHa2zUsDLll+uJ47f/KwcBvyL8EziSlrLo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=HVZNZt4hO3nhvBYe6C+X8bxlCYGhB0LvHqVBZ3bcBYkFyslSppnKj2brsBXBOhmF8Sp+/p/Bp/XXS4RQAJEg/vOnXrxiWwY/hDEmHAgMoHeDME1cSBQZ3QvzgzAc0vfCW+m+Zs7ZOs1n+cA7NJn9JWZChxwpldZ5gBaqneXwejI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SZ/V1cWb; arc=fail smtp.client-ip=40.107.241.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPw1IuSEG+tdVqhPA89vU8C22gV0sdhvnnTO3zA4QCmmJCUDpv4wMrsF/Lmo2FA0iL8i4VgYhVW7j3UhGaeLOpQIcxtTO60PAmLs6Xty7gAo+MtmJ3Kkf0bjL3my3qJv1zCRoi80HTTwkSEnIC5TpGOBApW0gatW5OUpuFSuefOLLIzhxs64PzA8gkRldW/agWY0g6W50+dsvlivIF2MfDlRWCLkqq7TixIRw069LFgfdBxM5AWMCs9GRRNgwCDnYxZuljtYTSh0qDhqO7NBTtrxX+eozOx96kglDD1cN9RqcpmEOVna+2ouE6nMtR81Lu+xSZib92PngiGS++Ciyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGcWfAe1DmMqICbKuntNjhNkpxKonnPoCvBw6vbQPDM=;
 b=Ki6mXsQTC8Ub8QeJlAPG8axDSOgTxza4Pbxsp4ycjYy9V5rvKNsu545OO/XZurdvAyoONLsHP6uMvkqs5tJIvL/p+pME0Z33mh626Y0UBh7YR03ZYGkzcULbDI2WsfUm7iCX0HNXxvEa0nseUV7o9sSVIW2bmJVAMH5fWIMF9rtdFhj9E0SavP3nxcRBOLbzY1q0f9moemhETMd1D/wfx91jT1vaDz3b97IZqgTKxjcSjwzJa6d8bX7Qy+XB/i/q6ppybYXGLKechCepMKDz3PQV8px1dYYOWuIsurcKkpzW3x2Nyywi3MdVvCYXQIpfOjWp6ZAxTWgXHMOY8JFUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGcWfAe1DmMqICbKuntNjhNkpxKonnPoCvBw6vbQPDM=;
 b=SZ/V1cWbOod5vw1Yts8iAG6XS1AhMp8QmnkcyoDo5g2o5lR557sy7WPA2IMmbG3wbT454vLGcf33SARMD0JUKWz8NrsfLRArR37+7ZUCD47bdHFqkCle4N3JdYklCZeuH4TEBcJgeRHYiYA4uvuCEUdI0vpqV6gBkCvT5RZc21c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by VI2PR04MB10147.eurprd04.prod.outlook.com (2603:10a6:800:21e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 10:39:16 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 10:39:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/6] firmware: support i.MX95 SCMI BBM/MISC Extenstion
Date: Fri, 12 Apr 2024 18:47:06 +0800
Message-Id: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACoRGWYC/32NQQ6DIBBFr2Jm3WnoFIx05T0aFwpYZwEaaAyN4
 e6lHqDJ37yf/PcPSC6yS/BoDohu58RrqHC/NGCWMbwcsq0MJEgKKRSyz1rhNHn0nAzuhJNy2pI
 crZEEdbdFN3M+nc+h8sLpvcbPebHTr/1nqxGoZ6NvXdup1lAf8nY1q4ehlPIFRlfj6bAAAAA=
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712918849; l=4715;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6yyXhWvNixHa2zUsDLll+uJ47f/KwcBvyL8EziSlrLo=;
 b=McT066kEwNvv3XG3N8fIod2jOjL+/W2S49YEAJ4ExwDPp205lyG1yEXebc52e/JKivd/tcMkX
 JmnvgtS2fsPCyj7ta3gEb6/TZi83ZL3ispGEtjgucLgc1E8Gv+29Afh
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|VI2PR04MB10147:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe552f2-cefd-4c3b-2443-08dc5adcccd9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GXv8Sqi7xlYP8ri4V6D9ySveG9FFTNwMvXnJQPY3Outq3Tlh1w0l+hWr5fGuUlZ+JZw2yz05bZ0izE1QutAhYbXj5K2f3hV+7WKXlCYGt7qCASo2DAH9GDjlnNsksm/q+SiYGLy5DIijFsYzBqtz8p8mcXSyJ9xybfevUZmjxbpIVaOstVNS5oqsZjZuxhYnr0bH/gHEb5PsHPvu+uMAM+DeovhwUwkqBKsN3X/t38S9pjjvCd1ZW7geNdknPnV1KZDwDRZxaw4NmWONkihkw3l/A07OkyhMoAIlfIl46pQc8OAgVcwkEcBfeHXxSXxxMj7MYffL1wKo636M6qG1qQ+RphdLXFiljPQh60xlFkrXwA9c8jNiJm9A7qyVkmSuDD3+DwaLEdwDbNxD+gDmAHA1dp8lUE4Nn5tFSBlDWTKe7i1mM+l/niHEmxXtmo896dgtFtXtKaO0GcBS29i1AgBzncQd1YszzhwXuQD+yqTB39ynK/6l/O0Gvb4e3cisaWnZ0fgVQf+CawkKjq3gov1N7/OH0PSA8PsGhYy5tKFz6aEk90b1rsLnM56wDwpPZPKIDm0P17xpkjqLxFXgHrSq1m7bdbMqY/lf7JAiBpIk/tWWRFtbyyhK6IjWeEII8jdo22g8fyGdCoebVuRGnUFZFhE5Oxx37hssmK2VDFzff/EgdGnYzHmU9hXKW07HnuOzo3qi9fyHADEVOnwMcAeF5t2eBsxE8NoIVFE7oVAT1KK9U4CscEuVYTyv4lBL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L01vM1lvNmo2OWNYbExQclFSdWVLWVlpQXlhbG1vamxsR1pMYXRsdVcyb2dH?=
 =?utf-8?B?bTFFWjZTZmZBZWhXc0FDYWxScXR1Ly9xV3RXV3F1dU9kc24vMndNYUY3eStj?=
 =?utf-8?B?VTRMM0kxSUxlczIrN3ZkR3ZEejA1MldhWUlVTFJJdWg5WmE4MGQ3S3RqMjh0?=
 =?utf-8?B?WS8rc0RleVdvYTRYNUZhTWlTZFlKL083TjNjSXl4TnZ2enBxUkJKWEZ0ZVhm?=
 =?utf-8?B?ZXJQam9hREVwN2tpL1JwT1A2WUsvNnVYMVJmSjBHSE5iWlo2bStMS2tOYkY0?=
 =?utf-8?B?cGN5QjMzcE5TQU9pWmVSQVRRVVY5V21NVm9Kdy9pS1c1Q0JPaTFaMVc2d3ND?=
 =?utf-8?B?ZmdMSWpLTXZSTm9CMy9hdnNIUVdpY1ZqZCs2YnNuQXhBdzRzZzNLS2xaVDJt?=
 =?utf-8?B?RmFyazhwOXpXQWllT0Y0aWpFT241bFFSMVhwWFlYWlZZMm5lRkhNRmlkOEhK?=
 =?utf-8?B?aFpzL3ZKbllKdWUvRDlzdlBQMUhpam0xcVlxN2xjc09qOGVzWEJlODhkMEdy?=
 =?utf-8?B?M1lqNmptcE43aXJFNXRKYk1wWFdYQnVoYWJPQUZMeE1GYUlZVys4UHkrVHpS?=
 =?utf-8?B?OHNhZ0JGV3ArYVVPVnRGRXdMTmhFNWlLTkI5WTZsS3EyVlFxczBSVVRsbGdj?=
 =?utf-8?B?QlB5TC84TDdDMFV4UzR0czBRbW51MXhVYzROeDVWdWtMTTFzenRJRkk1V0JJ?=
 =?utf-8?B?RDBqZ25oL3RtdW5RblFTeFJEVnBzUlVQN25mZG5rV3lTV2piMVhyRmFuTW5E?=
 =?utf-8?B?NXpGUjZZYjRTcEZla3MzMVBDUWhRTXhQWTV3elhTL3JtdmVEdXlKd1IraW5u?=
 =?utf-8?B?dm1yQVVTV29YaUtWQkVXdlRtcGF0b25wVG5MaU1qa3NycTRiaW1oeW5weitU?=
 =?utf-8?B?SHhFeUdvbTdrclRKNWhoa1pzRXZGNmwxdTZIb05VekZlNXB4WWJUdGxwZUxR?=
 =?utf-8?B?V09CeGFPWWNvSTMyYk5UQlRPZEJ3dTk1TjNpQ0gyN2dpc0RqcE1yVWlaMGNW?=
 =?utf-8?B?L1ZHbFkyYUwwU2RnRFJvRWszUW5kN0p0OVhsZVhJMGVlMThxWGRlQVBPNkJP?=
 =?utf-8?B?RWJxd1hjelpiSTBoL2k1Qk85bkpGajYwckVpb3o3NTZEZ0Rsbytia3Rtekd5?=
 =?utf-8?B?RHQ2SUlGa1Vabkp0SC8zY2lDTHU4cU16dG45YnRnczZLMXpvbnNFZ2h6ckVm?=
 =?utf-8?B?WTVpTEVLZmQ3ZVRFYnpmSFFnOVUxMWNLWlMxRlppM2F2QmZZbDN3Qy9RVGhR?=
 =?utf-8?B?QVVzeUZoUlJ2NXhCMElacWJQcWZrLzZvVnQwUXlIRGZHVlgrZ1M5NnV5aWFC?=
 =?utf-8?B?NkcrS1R6ZGx5SjVjekhuMnJSczdjOE5CWTJWeSt0dG56cE1tZDBTMHExcFgx?=
 =?utf-8?B?RzV2MTRoZVloUUhtdGxYQjdubGZ3QW1wTzAwWVN5Ull3VHhmRkE5RDIralVZ?=
 =?utf-8?B?QVdqRmdUYzdNN1N0Z1lscXpkcVkrd01wWmtyYXFMY05kMWdVSGM1L1FseitU?=
 =?utf-8?B?dGVGbFpQZlVtVi9XS3ZRVTB3KytqMjZZVHpKSmxraVhGQ3RodEdkM0s5bENQ?=
 =?utf-8?B?TEhUb1dZc2RDT3JrNWp4S2pubGtHdTNDQTVwN3k5V3JMUCtNYkNOMmZoajFL?=
 =?utf-8?B?LzFzYjMxWjBUUjdFdk1OcDV6QXZrK0NkTFVsTkdWa1BzOFk2ZGM0MWJDN1dF?=
 =?utf-8?B?b1p2OXN0a2U4TmozNUJ3M0VFeVlLRjByTW8yNkdKZFpJL2hsd1pYUHBHOFdC?=
 =?utf-8?B?all4Zk5xYXpmb2V1RjFDWEJRMkJkbk11Yk5ZcXRmRE9rUTVuMWk3L3pERTQ1?=
 =?utf-8?B?aEdPV3djZXY0VEY1NHdwbTNNNmVkWi9QbXA1cEJxb2RCRGJGdUw3TW45V1ho?=
 =?utf-8?B?S2ZGNC91eUdhc2d3MTJIZW5ySHJ2cWFYL3JzdW1ZTmg3ajFoN2JWTm5KOGlt?=
 =?utf-8?B?Znh2U2RJQTF1Tks0cFdqTUpGandnVmNoaC91MUFNWmwycmNaSmFCSzFxR1VE?=
 =?utf-8?B?UGhvNjV1c3RUelFIeWl6YXhFc1dxOW1EVnA2alVjT2FqWGR1SzlpU2pMVGdh?=
 =?utf-8?B?ZzdkVVJqdWRUTVlrVk16MFR5ZkVBUDVmaUEwbjVuZ1pnalJhNkR1amVGZmZm?=
 =?utf-8?Q?uwqt1UQ89BnAcjbQftf9HP7mB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe552f2-cefd-4c3b-2443-08dc5adcccd9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:39:15.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jd2cBiIqK3b5WVeRGvo2tXdkkXS+HYrLSK6VxAZRqy1jshJSbsMu/7yr2SN9JW84di4e7c05bTHOAxecDXx9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10147

i.MX95 System Manager Firmware source: https://github.com/nxp-imx/imx-sm
To generate html from the repo: make html 

i.MX95 System Manager Firmware support vendor extension protocol:
- Battery Backed Module(BBM) Protocol
  This protocol is intended provide access to the battery-backed module.
  This contains persistent storage (GPR), an RTC, and the ON/OFF button.
  The protocol can also provide access to similar functions implemented via
  external board components. The BBM protocol provides functions to:

  - Describe the protocol version.
  - Discover implementation attributes.
  - Read/write GPR
  - Discover the RTCs available in the system.
  - Read/write the RTC time in seconds and ticks
  - Set an alarm (per LM) in seconds
  - Get notifications on RTC update, alarm, or rollover.
  - Get notification on ON/OFF button activity.

- MISC Protocol for misc settings
  This includes controls that are misc settings/actions that must be exposed
  from the SM to agents. They are device specific and are usually define to
  access bit fields in various mix block control modules, IOMUX_GPR, and other
  GPR/CSR owned by the SM.
  This protocol supports the following functions:

  - Describe the protocol version.
  - Discover implementation attributes.
  - Set/Get a control.
  - Initiate an action on a control.
  - Obtain platform (i.e. SM) build information.
  - Obtain ROM passover data.
  - Read boot/shutdown/reset information for the LM or the system.

This patchset is to support the two protocols and users that use the
protocols. The upper protocol infomation is also included in patch 1

Signed-off-by: Peng Fan <peng.fan@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org

Changes in v3:
- Update cover letter and patch commit log to include more information.
- Add documentation for BBM and MISC protocols under
  Documentation/firmware-guide/nxp. Not sure if this is a good place.
- Fix the bindings, hope I have addressed the issues.
  Drop imx,scmi.yaml.
  Add nxp,imx95-scmi.yaml for NXP vendor protocol properties.
  Add constraints, add nxp prefix for NXP vendor properties.
  Use anyOf in arm,scmi.yaml to ref vendor yaml.
- Use cpu_to_le32 per Cristian
- Link to v2: https://lore.kernel.org/r/20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com

Changes in v2:
- Sorry for late update since v1.
- Add a new patch 1
- Address imx,scmi.yaml issues
- Address comments for imx-sm-bbm.c and imx-sm-misc.c
- I not add vendor id since related patches not landed in linux-next.
- Link to v1: https://lore.kernel.org/r/20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com

---
Peng Fan (6):
      Documentation: firmware-guide: add NXP i.MX95 SCMI documentation
      dt-bindings: firmware: add i.MX95 SCMI Extension protocol
      firmware: arm_scmi: add initial support for i.MX BBM protocol
      firmware: arm_scmi: add initial support for i.MX MISC protocol
      firmware: imx: support BBM module
      firmware: imx: add i.MX95 MISC driver

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  21 +
 .../bindings/firmware/nxp,imx95-scmi.yaml          |  36 +
 Documentation/firmware-guide/index.rst             |  10 +
 Documentation/firmware-guide/nxp/imx95-scmi.rst    | 877 +++++++++++++++++++++
 Documentation/firmware-guide/nxp/index.rst         |  10 +
 drivers/firmware/arm_scmi/Kconfig                  |  20 +
 drivers/firmware/arm_scmi/Makefile                 |   2 +
 drivers/firmware/arm_scmi/imx-sm-bbm.c             | 378 +++++++++
 drivers/firmware/arm_scmi/imx-sm-misc.c            | 305 +++++++
 drivers/firmware/imx/Makefile                      |   2 +
 drivers/firmware/imx/sm-bbm.c                      | 317 ++++++++
 drivers/firmware/imx/sm-misc.c                     |  92 +++
 include/linux/firmware/imx/sm.h                    |  33 +
 include/linux/scmi_imx_protocol.h                  |  62 ++
 14 files changed, 2165 insertions(+)
---
base-commit: 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39
change-id: 20240405-imx95-bbm-misc-v2-b5e9d24adc42

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


