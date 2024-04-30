Return-Path: <linux-kernel+bounces-163573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6498B6D47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0DF1C226E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AF8127B69;
	Tue, 30 Apr 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aX0wFDLK"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677B3FBAC;
	Tue, 30 Apr 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466940; cv=fail; b=MTWjVZD0M9axv7fom5gZ3k5Xr/bQ+dzsxO1cve+S779hMX+Nd6JGzhCXwuhXFI58GVIq/h5HQNW7K9AY4zAcmvNVotcZF2vzXY8xvdOmuzcitm/haOfttKn4fMKiq0nkAgNx4VaCpMIxv2mIsuS7iZ0fEpnJTBGSEz1oTrg14jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466940; c=relaxed/simple;
	bh=mKXQPLXmTtTRM7gnw5QvI6A2+Zn4FH9h4KL6EPoS9Qk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dv+Z9al7hAGannweF9SiyoCSv0p4el5SdeM04onB4Rod81/Z+0Pk/I0mifXlvcSKmI+qx4KAVBov55zuCscdYzidR9OFwtHHWTi/UKkSCJHQaBdnWkwTQhZROfX9eZQKrP0Dd9L8oD+6bL2MhZjjF11SO4VsaM7VXnE4yYMlXZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aX0wFDLK; arc=fail smtp.client-ip=40.107.14.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivVtI1D4O4b3cjAkVONklbJeDah29FCqfccuAAtRxUQYNPPTdFomJW2Z6sbhhC0mI+fAt7aspAsoyHKfgGWKjgAIKgaCHzjGgHrKrf1nXswvqEi9HjawWTKXR8uUmCtjC+a9vOgzBzp9qDUpqQfwUFlWqQjXoJ2aRHksbiD8jRbDwLfFD7UXLRxgFv7tXd//KpfRTparL/p8jnf6XtUv2KHp3mNjMZfqtv1u4bRWS1z/G+9hkO1CK1E5/RdIHsTivxbyvJsC9flmLbPZ1OP0KN+yxh6iS4BUTFYl1QTYeH5MsHD0sEVFDj4uTq6kuUSqjKHBVk0Oa+0EpQ00GhDv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef3EnwQ2DyGwL93wujkl8/p5ekiIzDl1UDPMcVr6q7s=;
 b=GhVD6PhKU9gkXA1f7Kwwlu1X2ealJk00QJGYfCF7ZrQRWSIJsTu/JSX0SZPLIQ4xAsalxOD6vqjsGL/tNQmbvANExxFexPo/Ut7imqZFkrBMCTAWekDceYq1vGhdUrGc5+R4/BNu/sxQlAw5l55qsClAO4Vtw2CAKyPd9sTaXMD/WFBTYnxzUJjezl1XmPMG4V/j+TrtQK1WLzxK+BxpVUMlmepIo5hZ2FtqMrh2XJQBIK79eOeqw7IVAdtQu+2BIaB7/FXn4UNJOzOgGGHCrv+lEbP0C5GxUXKMN07YHzrAzXkg7OoVfbCbGCImiU2A5P00NsLLGTBLTMQe+a+hjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef3EnwQ2DyGwL93wujkl8/p5ekiIzDl1UDPMcVr6q7s=;
 b=aX0wFDLKxvp5NxmwMFUT+xnb2T1bo6aTEk8TtV3x6ej3ORdSuIYH1oPTUcvAnFsqIBSxogwvK98pSJ+0ZHRNQbYaN0y2UesGMXgJ5azXeEU/LdNzEW050x9A4fTg0KtKZgo9cmWobaYUfnhgyOHyCftMlMD4rGHHIGDYtKr0MFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AS8PR04MB7942.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 08:48:54 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca%6]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 08:48:54 +0000
Message-ID: <84aa4bfb-d3fa-4721-98a2-dad0cc753434@oss.nxp.com>
Date: Tue, 30 Apr 2024 16:55:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] media: amphion: Remove lock in s_ctrl callback
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240425065011.105915-1-ming.qian@nxp.com>
 <20240425065011.105915-3-ming.qian@nxp.com>
 <8c39b3c3-8146-4418-8835-6dbfe38a85ec@collabora.com>
 <be54f273-7bba-4db0-bc52-5ddbb3982d84@oss.nxp.com>
 <0c0e2d02-b719-4f8b-afca-c839bb77f287@collabora.com>
Content-Language: en-US
From: ming qian <ming.qian@oss.nxp.com>
In-Reply-To: <0c0e2d02-b719-4f8b-afca-c839bb77f287@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::17) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AS8PR04MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: c23d68e2-51bd-442f-9773-08dc68f25d9a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YSt1bGJxbXdpcTdwbEZzbTJHL2xGWGdmeFo2MEZHZWNHb2pqZTlyUUphYnBn?=
 =?utf-8?B?cDVPVnVGYU5GNENvZ3NKR0hyNzlIaXBMVGtFMytqMGh5Z2pkWlNSakE5V21H?=
 =?utf-8?B?dGZTRk1iM3hKZGkzS2w4UXIyS1o0MldWb2xMRFpBWkI1RnhjNGlYb1h3UXdE?=
 =?utf-8?B?MFVmUmVHNzZpY2VsRGplSUxRUVNINFBHaUppYjF5S2p5VVBBWlAyenNsQTZQ?=
 =?utf-8?B?a012azNJakZLUXJ0T2xhTmNWbXlvRHB5UmpaU2RYczFta0oyVEk4OXVjU0NH?=
 =?utf-8?B?ZnhDaGMxR3lPVjRybGM0ZGRXdVpTc3BUZFh6ZWdMKzFvcVQ5S3c4MXZNTTJY?=
 =?utf-8?B?NU40RmdsK2VxVjNWNFBlbTJzOElqRlJSOVI5OXlhWHk1ZkFpTlArMUFyaWJR?=
 =?utf-8?B?UVA4L1dlWVROZmUxVDc4dlNMYXRERGpDamEvWnNESDhrOGlBQ0dQYVorTVVq?=
 =?utf-8?B?dWNFLzA5N2FQYURnbXZUaVNTeTFsWWtlNUZ3U0tHcEJuSFFjWU9ZV0FURWF6?=
 =?utf-8?B?bE9lN3kwVVRnWG5aZDU4QVVBdnVWOVMwdjErUVZjQzlHZ2RDQWZIMmQ4WTAy?=
 =?utf-8?B?RGpHbGxzWnlHQWVZOGZBWHIzb3psSDFkdGxVYVdMVGp6Mm1DOXduQ1pqNTBP?=
 =?utf-8?B?dVBDbEtyam5oR1dWOCtKWjZidjhFNkRZbE43RjVXYWgrOXFiSWVqMWZZcG1X?=
 =?utf-8?B?QW9ZV1lWWnhFYythU0psdnRpcFZjNXVqRTBRd3B6QTNSUUFuQTI0T1BkdnZa?=
 =?utf-8?B?UFJwN2QzMVRONXRMNkFjTGZUK2V4ckdnMTl6UitSL0ZaMGtNMzczejBGbHMy?=
 =?utf-8?B?UFpNVUZkbXNkdVVLWVVHQVBHZk1MT0U0S1gvOXg4NyttdVBGeW1HRTU0dTdV?=
 =?utf-8?B?RkNERCtMNmR2MDFzY09BRnl0R1R2REdlaGV3bnQ4WURobkkrRHVpNThZMGpU?=
 =?utf-8?B?eXZ4cGNvTTZhNitwb2xESHlyK1QvUVY4UkpxUHgrYzlTcy9LNmd3aEU0TDBh?=
 =?utf-8?B?NVFMZHFRZVJRbzBsZ1gzWTc5SlNxQ3NwRDE4MlFITmxwMDZhd2RYZWtXN0tt?=
 =?utf-8?B?TWNMejRNMzdINnE1T1cyRndpaXBpLzlrOWdsZHJTZkUrNExmUzNXRmRBcVRa?=
 =?utf-8?B?T3I0SHRhZG9PanprSkV2R0w0cnVab0lSaUJvSVBRR09ySHFFTEVWQWhVVDVp?=
 =?utf-8?B?SnM3QU1JUDlBZmk0aWtxckJaeUY5WlZwWGZUVmN3dEtUdG1hUzgyMzBONWdL?=
 =?utf-8?B?RHBScnhCc29Hc2pmUEhRak13QTNsb0xZZVEyTkoweEs5bjNJdUFyTkdMcW1q?=
 =?utf-8?B?enQ0U3VMR0JBMTNKUHhUVnM1R29iNEVzSDNnYzNib3U2NkNWL1BEMnJFWnFE?=
 =?utf-8?B?c1lVTjJCZXNKLzUybVNPWWFnYzVLNysxc1dic2tpeDRMWk1SazFvL2QwcmRZ?=
 =?utf-8?B?MUJ4TDhPVjBYS2ExVkp0aStvYmptbHl2SE92V24xK3dpM21pdjJaSFliSXM4?=
 =?utf-8?B?a2ZRQ24rVmZPSUx4elNjeVhxbVhQVmZwbkViUzNjczlOTzZQMnNMdEU0cmlz?=
 =?utf-8?B?MzhTcStOR0xRSVNlOExCN2xUYW1iWHBpcmJWTGpwZjZ5NHg5SnZPZUFrQWJq?=
 =?utf-8?B?K3ZxdkFRMjdxdUpCNTBRWC81MUVKOEdsUkVHQk1GMFlJL2pGVEhYd0UzREpa?=
 =?utf-8?B?YUpDeDIybDB4MnJ3cldXWkpYeENpTytqUjZQUEFRZ1RuT2FlY2xwQkl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWJKYVdKMlExU3dRSklaTFRKSCtnbXhKejArei9KWDA1bFdVUVlwODFDMDYw?=
 =?utf-8?B?YVFoaXlkNzVteUx0VVJmcmdsNUxUOGdyZ1h3UTNvdnVQeDRwTWx2Rng1dTNm?=
 =?utf-8?B?aHdDZ2VmMFZuZmZpMHlFa1lvY0F4bnp5djNTY1o3Z1MxWExQOExFQWIreVBW?=
 =?utf-8?B?RE95ZTJYa3VVd1IzZ042NWptQ0Y0aEVhcitESCt0WEhaU2NZMkJHVy8ybnl3?=
 =?utf-8?B?cDBoVUlOVjU0dG9xdTAyV09KM0NJMktTQnFVL2Z5bGU4NHlaSFBvVjFPbm1L?=
 =?utf-8?B?VHF0dFB1VUN0ekU5aThrbHF2ci9QM0JCQWdxMk4rd0RjLzIzTVVLS2thU1hQ?=
 =?utf-8?B?U0V6VTNNa3grYXpqZldlTVQ4ZkFjbmt2Zllla2NYQjg2cSt1V01tY3Y1ckMr?=
 =?utf-8?B?VkJYaEVVbytEKytoSk9iMXB4blhHbXpqa0Yyc2N5dEVtejV0OW1rMlJkTDZK?=
 =?utf-8?B?RU90eTZXZHdCd1QzWjIvZW1jMFJrNE1WZzNhd054eGQ0UlFHK2ZIMnJ3OWZK?=
 =?utf-8?B?ZWFmZHE2T2l1TnFuOEg3NGdpZm53aVNMVUZpTVcrQlVRcEpIOXhOTG9xSnR1?=
 =?utf-8?B?bXlMUVV2U1dYRUJQWVJXWDNoN2dQajNCdHRPVmQ4WHFaUmhQZ0tJQzdkbDAx?=
 =?utf-8?B?cUZGNkVLZk9jaGM0TVVMand4bUt0dnp4K3VoQk1FUUJqcGRYb2JDeFNYeVp4?=
 =?utf-8?B?eDBVM1c2U2RvRFM0c2pyUjdocERHWWhsWFRtOVhHNzJnS1BsbTkxeG45Mm1o?=
 =?utf-8?B?Zmo0bkhkWHhMSUJDZVNWZVNib0h5SFo5MnFRWkpIMVdHMmdsRUNxeEdnd1ZF?=
 =?utf-8?B?QkExS1dXc01ha3FScjlQREZjTmpMVFZIc2pPTGVkVEN3K0xqcTJjQ3JqZEc0?=
 =?utf-8?B?Z1ZEUWRlUjJOQU5VQ2NUQm15ZUZOZnFlM3o2TWYvdzg0cDNGRDg1M3U0VzBF?=
 =?utf-8?B?dUFNT0QrQ29DM2liL2pZYTBudCtGMDQwVU5qZFpHdFZUWFhRN3hGUHN4bVlr?=
 =?utf-8?B?TlNaMTdaZjllQzBxYmJjWlAveDJYWFFtK3JjTHUwNTVRL0oyNTRSUWJMRmdD?=
 =?utf-8?B?WDl4TW1YTW9VaXR0dnF5Q05xSWR3K1VQbDk0cEZvR0Nvd3RBeWtIOWNpbDEy?=
 =?utf-8?B?Wm0xcjBsOW5OeERZdGYvVWoxb0pBS2U2K3d6MlcybWJsbzQ2cTFGU3lEdXo5?=
 =?utf-8?B?dHZmSThpdE5ORWsvTzdsTVVqN1cvRUdjSlljVlAxSW1Bd3dINHRpeUJwOHpP?=
 =?utf-8?B?YkwrZG9xS1ZoK0FOZ2NobEdlVGkycEZHNnVPREhsZVQ3UGpJRFRGdzN3aW1L?=
 =?utf-8?B?ektDU0FBci93bW5wN1R4MzhmSU9nbnhiVlQ5Si81WFRJcUxnNEh4MW9MMTUv?=
 =?utf-8?B?dndJOG1acWZtUmlpTkhWN2VyVlpYYXIrLzk4SzNPODczQnB1MDNJYjQ4RXhC?=
 =?utf-8?B?Q05jMXFVNkIybjFnUEtMYVN3MjBRWkVLVEZqSDBwYkF2bC8wK2FqdHVNb0tx?=
 =?utf-8?B?NWQ5ZG03OTdQdUdtZEtkRTUzODUwenVVMDA4ZWVXZ1dDanhxUTYxL2hTOGcy?=
 =?utf-8?B?YU9jMStlTmtJeDZaYm1TVjRoVjN1Mkc2SkFjemZvSWhrK0c3NE5pMU5RNFNH?=
 =?utf-8?B?OHNxQ0NoQmE4OEhqQ3JUZldKdEkwbTQzeXFPMVI2NjIxWUw0ckZaaTVTbXd0?=
 =?utf-8?B?L3UzU1M2M0w2NmxYNnpmNklGOW5yRlNhZ1BOQW0xdzBvdm9IYlp3MWdjTDZO?=
 =?utf-8?B?U0lDcVA5MGpTck9IaFlMU3kvdTRXbmN5WnNrS2N6U0hvUEthcDhzQ3M5NndC?=
 =?utf-8?B?Zm0zK092Q0FKczFxWG9DS2FNUVdFNTZaOEN3NzduVUNFV1ZvdXQyUFdRUUJs?=
 =?utf-8?B?K2VtWHpBczNERE9yZlNqRi9CelhCdHlpMENoZUxEeGZzWURCV01Kc2NDN0cy?=
 =?utf-8?B?RHhMTHIwSnBZczZlR2RDNjV3blJaV3dYK1k5RkFtdFUrL0swZkRkOXBQeVVF?=
 =?utf-8?B?aWxQNlRTMDFCUEdnL3c0WUVPWkQ2NjFXLytodGg0UzI1K05PUHNsZUp4WGlt?=
 =?utf-8?B?eTJhT2J0aTA2U3p1cHZhd3h3UEErVjFtOHN3ZkVBLys2NkkzbEQ5Q0lMaDFL?=
 =?utf-8?Q?qmdc2C61HVoiZWWQAhTqJkmcF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23d68e2-51bd-442f-9773-08dc68f25d9a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:48:54.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEhh4blZLrSvUT5kBISuIwfgi5n2ZXtK62bOvjkE5+hmFGYNpzNQvWwpmlvqZfMo93YHIZ872gXkbCTmE/ncDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7942


Hi Andrzej,

> Hi Ming,
> 
> W dniu 30.04.2024 o 04:32, ming qian pisze:
>> Hi Andrzej,
>>
>>> Hi Ming Qian,
>>>
>>> W dniu 25.04.2024 o 08:50, Ming Qian pisze:
>>>> There is no need to add lock in s_ctrl callback, it has been
>>>> synchronized by the ctrl_handler's lock, otherwise it may led to
>>>> deadlock if driver call v4l2_ctrl_s_ctrl().
>>>>
>>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>>> ---
>>>>   drivers/media/platform/amphion/vdec.c | 2 --
>>>>   drivers/media/platform/amphion/venc.c | 2 --
>>>>   2 files changed, 4 deletions(-)
>>>>
>>>> diff --git a/drivers/media/platform/amphion/vdec.c 
>>>> b/drivers/media/platform/amphion/vdec.c
>>>> index a57f9f4f3b87..6a38a0fa0e2d 100644
>>>> --- a/drivers/media/platform/amphion/vdec.c
>>>> +++ b/drivers/media/platform/amphion/vdec.c
>>>> @@ -195,7 +195,6 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>>       struct vdec_t *vdec = inst->priv;
>>>>       int ret = 0;
>>>> -    vpu_inst_lock(inst);
>>>
>>> I assume that PATCH v2 2/3 might cause the said deadlock to happen?
>>> If so, maybe it would make more sense to make the current patch preceed
>>>   PATCH v2 2/3? Otherwise the kernel at PATCH v2 2/3 introduces a 
>>> potential
>>> deadlock.
>>>
>>> Regards,
>>>
>>> Andrzej
>>>
>>
>> I actually discovered this problem when I was preparing the v2 2/3 patch.
>>
>> But in the v2 2/3 patch, it tried to add a read-only ctrl, then I just
>> unset the s_ctrl callback for the new added ctrl, the potential deadlock
>> is caused by call the s_ctrl back in a locked environment, so after unset
>> the s_ctrl callback, the 2/3 patch won't trigger the deadlock even if
>> this patch is missing.
>>
>> In order to avoid encountering similar problems in the future, that
>> driver may set or get some ctrl, I added this patch.
> 
> Do I understand you correctly that patch 2/3 is written in such a way that
> it does not introduce a deadlock, and you add patch 3/3 only to prevent 
> future
> problems? If so, it seems to me that patch 3/3 could/should be separate 
> from
> this series, as it does not quite match "Add average qp control".
> 
> Regards,
> 
> Andrzej
> 

You're right, when I prepare the 2/3 patch, I add the new ctrl just like
the previous ctrl, but I got a deadlock. then I tried to fix a deadlock
in 2/3 patch first, and make this patch again to avoid similar errors.

I put this patch to this series, as I think this better explains why I
made this change.

Regards,
Ming

>>
>> Best regards,
>> Ming
>>
>>>>       switch (ctrl->id) {
>>>>       case V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE:
>>>>           vdec->params.display_delay_enable = ctrl->val;
>>>> @@ -207,7 +206,6 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>>           ret = -EINVAL;
>>>>           break;
>>>>       }
>>>> -    vpu_inst_unlock(inst);
>>>>       return ret;
>>>>   }
>>>> diff --git a/drivers/media/platform/amphion/venc.c 
>>>> b/drivers/media/platform/amphion/venc.c
>>>> index cdfaba9d107b..351b4edc8742 100644
>>>> --- a/drivers/media/platform/amphion/venc.c
>>>> +++ b/drivers/media/platform/amphion/venc.c
>>>> @@ -518,7 +518,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>>       struct venc_t *venc = inst->priv;
>>>>       int ret = 0;
>>>> -    vpu_inst_lock(inst);
>>>>       switch (ctrl->id) {
>>>>       case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
>>>>           venc->params.profile = ctrl->val;
>>>> @@ -579,7 +578,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>>           ret = -EINVAL;
>>>>           break;
>>>>       }
>>>> -    vpu_inst_unlock(inst);
>>>>       return ret;
>>>>   }
>>>
> 

