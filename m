Return-Path: <linux-kernel+bounces-42692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C29840519
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EB31F221F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D8D612E9;
	Mon, 29 Jan 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Qj8UHHh/"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112460EE5;
	Mon, 29 Jan 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531831; cv=fail; b=DqqWDZt3V5ACILeckiHlHNKnTY7/gfaAUSHrdOSriiWC9WbrCOA7enmcA8srUm3BKzW2HdZJgJK5Zw75jnV90yAzViWxIDbX095mS4mhhmm3nlFuNxiKtyw+3ZNLBDTuhrG4zPhEfJ89D+aBpnySEgyQaHGik3KMLb6iTPrfI4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531831; c=relaxed/simple;
	bh=+13vYZeoIcjLwfjY2XzTx8o5Gm0M7lMWUm265Ha8iGM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cpABkAI9Oq/sfTsi0O5fmfKnZ+TEXtnmEZhWGYs0dYuQ6Fjk5hKhyQQwrnfCd9Quw/lhgErPDlPK0WQzeyoYFTCIbfMk5CM3WgG/CyhV7vzeXDs18bcs2wesSUcXvnQjUA1Ah3byQLTJcUGKquYMtlnKaSLAwOzbcQR1d5kKjHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Qj8UHHh/; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnGMUb1yqHpI/FRiCaMD9uutOM0a7PRU/XutzGeTmZakVHJ9h141ZJaFapUW8RtyYcaN4h3iN8TwQRabCYiIwzpgiHEkQItv1QLVj+Ir7Bbv/D4anE38DwhFgZ+zg6SeyTESUrolkU6XCVc0oR7+fozkwtdKnL42dsA3vrygR+WF8a8sWO8tUbxLj4ima7ty+Ik9W/pYLoD0ndAZY0k8aVpJdhVrSGqa6ZFbHZWfxjncM5n+tKtT7xWwBxwBsc4zCGVKTM9PeHuViY2PRVIKbwTskAIsqVVwRIV0CrlJrW5OxZpfc5W1rJQqk0SsXB5ksQZXUK1dD8tmOlU02uiJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUhrAlia65ftKCeSaayFNDRnUYsq7ddijTTENeq6F/c=;
 b=DTaBndP0X4irj5YcMn3Jdz46LokFARwowKfqazdD3F0hMxOIR684rexrzhNlnAtRKP8K9GceXaLCjYur9hgSn87IfOdQqSiunoLffcXSSqA2GcY41gQJXeSxra8VLfK8c4YM2jKf6LAsOG1zvyagHw5w5Hrj0rnUpusAUc9jZXO68Bkn49JFUtXRR1jp2hRf0usD23UrhqBEL65COJgq+rl2EwUN5l3glMBi/biJ8nbLLTmM/sAwqwMJSPMVjWRJlDDLzafwINP5dNOTVEwbcVaeSZAjMDeymTgVAO62hUvaN8uMTVbgIdFjceFpPEkEVCGfDzAAPXbSvcxsYAyR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUhrAlia65ftKCeSaayFNDRnUYsq7ddijTTENeq6F/c=;
 b=Qj8UHHh//eAUcw8YILhAaLb/BCGnuhoZltKxbsDwfHKL6jKZwSms/B0N8W0HYrOjiwamzzfRyVRNaJGJYpMRt0Agh3weIsDcIE65aqf1TsiBfTo4p+W9GGBlsHvAPLEs1hQgkf3SQUvfiObqtgaDToXBHajFw/iOm8N7P3Ztt1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:37:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 12:37:03 +0000
Message-ID: <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>
Date: Mon, 29 Jan 2024 20:36:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Rob Herring <robh@kernel.org>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
In-Reply-To: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5f4252-e711-42a5-c697-08dc20c6fefe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iEUMT1aGda6xh7CNiC8MyDdmSIQfd25S93RFFpvo6Augn2SQMyilIOQM6/tYv1p0GsePORxYy8dUY0L9j3kxds9Odiz2eSvt5H9KuE4jQwiLFdzpYNSEHxNojpPACCCjBfi7g0uHJVX2f3nwl7yghREQfMY2amZPRS5xhfqtw1nlR/malzoMBjCvXlR0fOaBSifSwT01B6ZjvfWECnoxtodQZZJvpSEdMN0BJ45K63DX0n1dx/lc0CYi5BkVPW6bh+EYiAg2kRKK4i3WqUBO8CIfY/hqSXt3/+S0DOO512N4c6JI8dMXMWbDIidTtpeZ2aid5LfS5jMGw0+n8+Z8QSiP4AWEj4ov5D4A3jYpxGboOZD8Xd/Cp3CjJDlqQwi2Gz30vE7FkavKrZ2Bo6F47nfJeAMovD0eMVyYwqlQRo3+YxZmITCexZSdleJ6bXQ48kHAdxMOjT3b5tVDKKeNfziondrXZLqCOt5H05LAH+9UAQU9d1TxGRIHMlyNRelI85tPV00ZW1aVj1SUsUqsxKsN7q6b+wgNWo7Zdm+zWAkR+PT7hOjb38Z1ggL2bEqJOKsr9pmd/jdIe4ZrsA1KzjJ2aTajY0zF9J0CieA6eKc8XGy6YrOsVGSntPGUbZbgCnVGQV0mNIq6Sp242bpOSRu/jTxtm5qSrb6i7QQ7q6UtoZV0Xn0pYdyfI/j62XG/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(84970400001)(83380400001)(26005)(6512007)(6506007)(6666004)(86362001)(31696002)(921011)(5660300002)(66556008)(7416002)(44832011)(8676002)(8936002)(41300700001)(4326008)(2616005)(2906002)(38100700002)(66476007)(66946007)(110136005)(316002)(966005)(6486002)(54906003)(4001150100001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkdzT0ovUVp3emJ1TmdiVXZIeFd4U3RMcnNSdVNoTHFGRCtIU1FKTW94SDhV?=
 =?utf-8?B?ZFJ4ZmgvODJxU2ZLZUFMWFNlcmEwOWtCdHRCSVhVWE1ndG52cmVoeDFQcjR2?=
 =?utf-8?B?M0xjeExuMlNBYWNjcDA1ZC82NW1XOE1SOHRFTzVyeW13MG5ickZxSTNpa0NX?=
 =?utf-8?B?TUxXek9kQWUzVmdRVzUxYXY1OGE3dVVUNWIxS3R0NDlIRWZiTzFyRmxRektj?=
 =?utf-8?B?c0NoaXlkQUF0OHplNk9zdWNZTWhTbGJUZHpGZUYzL1NqbG0xV1VRYmhOcFpF?=
 =?utf-8?B?Z3B4NlZERzhBWmx4enJkQytFNEg4NnBYZFo0VGxLZjNXdUxhbHdZWnNHUGlm?=
 =?utf-8?B?Mno2RkdkVFk2N29DOTllQkl4ZTVmWTYwT0ZjamcybVZKdFlBM2pHN1UzVVJT?=
 =?utf-8?B?OEwvM3FsZ1dVVjB2cmtsdkZpb1E5eFVzcldiQ0MyNmpaVlFuZ0tvSC9URm5o?=
 =?utf-8?B?U0lKc2VaOGlPaGhxeXJxdXVwK1dzUHlYTUt3ZTVKanZEdzZlb3pIS3pBSXJG?=
 =?utf-8?B?WTRjYzQ2UlVBSGVlemdCbGsyL0RyNEpSY3hvVDRRV3k5YmFpd3B1SVJheitl?=
 =?utf-8?B?SVZselg2Q3FQTFlwUjdxV0xpelpSVGxHbkZzWm5uQkhySzh0c0tYYjlNUWJS?=
 =?utf-8?B?Kzhla1RUcENNNXpZRkovVklQYXdncGtCS05HSmRoUm1mb1Q4cnJ5cEhjbmxW?=
 =?utf-8?B?R09lSXpqZzVLb0R6WElaT3JxWHBtUGtMeHFCMGhmaEtBOVJJRmNWTlRBQkZZ?=
 =?utf-8?B?RU1xY0pyREE1VUJndmpTNXczenJhRE1SSE42VW1KUTIyT0hpZnp4bDI5ZGx6?=
 =?utf-8?B?blNRczhUVHNrRkYxa2hkbGE4eUFaczJ6elA1VWY5QjdoR0hVMDhmaWRDbTJE?=
 =?utf-8?B?MzRFSUNKeEpZeWFUS0o0eDhMYnFURi96SjBHd1AvTE02cGJqaCthd0NLbVhx?=
 =?utf-8?B?NCtLcFlJS09BK1BzTHluYXVKNklzK0NmeDRyRjF5NHNjMVE0ZGFHM2k2N3I5?=
 =?utf-8?B?TzNWRks4Y000MkdreDFOdlVoZG1aM2xESzNIWlg3dDZtcjVUVjFVeXA3RENl?=
 =?utf-8?B?bm4vTGMvUEZOQUszZFBFK1FwZEo4NmlWRkhtU1Fud0xKVWVtSUp0K1ZQa0Nw?=
 =?utf-8?B?OTFWbjNzNWFkYmRiQkRsL2U3N1gvTlh2ckxQN3luYUtXVEN5ZExOVC96S09K?=
 =?utf-8?B?RlM0dXV0cHV3U1V6KzFCNUNDZWp2THlGT2MwWWVkUGJacVBQTkQyTkJFakZF?=
 =?utf-8?B?dXB1UVNoZGhtcDk4dEd4c1BreHo5YVBCdDA2VU50SXVVUUVQUmxzWUhJYy9l?=
 =?utf-8?B?cFduVEVZSGZrazMvVlZZYU5iVmxoZUlqbjVuOWNqaXdNNmpsTGN0SWdPS3B1?=
 =?utf-8?B?WjhTS3UxTU8wV20xbks0Q3dhcFNWRVgvSTNwaGFUeldvQ1NVM3EvcWpXV0ht?=
 =?utf-8?B?RlJWUGxJcDNKS0RtU2pIdm9PQWdmbjM4UnpRMUJDTmYwZlpLV2JOZjZ2SjNJ?=
 =?utf-8?B?UmxQMWNOdGxKVkEwc0poLzFSM2JGeCtQazVWNVJsT3FFTTBqbEZINmh4THRr?=
 =?utf-8?B?bWdKY1lXRVlHQzZQeTFtMjl4WS92cy90MXlIYUV6V0cvbWpZNTUxQmhBSU8x?=
 =?utf-8?B?b0FaSVg5R1lIcnY2YS9GRjk1eml1U0w5WkN3d0dKTmhWU0QzN3lDa1k2aHg4?=
 =?utf-8?B?VG5ibWFaeG83S1NOZHBTZ0QyME05RkNjWmwzazRZU3lZYjFjVlhDWWtKZmQ3?=
 =?utf-8?B?ckkrR3NNOTFBdjduRzUxbWlSdGpNcGFjd2xtb3JQc3JVTXFQZzMvRWRuNGtG?=
 =?utf-8?B?WnFna0k0TDF6ZFFWdTV6U2FZRlBrTDVia1l1dTc4QnNaa052bnJJV1p0QzJr?=
 =?utf-8?B?Y1BTZFEvMVJNV0pjMGVOdURvMHllSkEwSUlmVFBQMm9JSHFoRFBiU3FKMGJq?=
 =?utf-8?B?Qlowb2xXNGtpTmJjQUFab0FOWmZBM2NQblRneUJUT3RZcmRQQ2FscDFSWnNQ?=
 =?utf-8?B?bzNWNFd1NEJkTzFCaFQveGdUbWYwYk1hM2RMc2pUM09Ec2dFdFdtSzd1Q1Nx?=
 =?utf-8?B?WGVsa2s1RDJabDFkc1pUQXdzRkFZcnpvSldEVExKMWVqOGR3TFBWM0NkaDdD?=
 =?utf-8?Q?O9p0AVLpbV1VpM1teMwcQ6Xei?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5f4252-e711-42a5-c697-08dc20c6fefe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:37:03.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZ2K7s6PkxN/S6cHBzOa3g1aeTshOcYHwr/KQUUoX7ES11irKJssEXhG7cX7jxFetjqWwDunbPq2MPseeT1TBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

Hi Sudeep, Cristian

Would you pick up patch 1-4?
And for i.MX95 OEM extenstion, do you have any suggestions?
I have two points:
1. use vendor compatible. This would also benefit when supporting vendor 
protocol.
2. Introduce a property saying supporting-generic-pinconf

How do you think?

Thanks,
Peng.

在 1/21/2024 6:21 PM, Peng Fan (OSS) 写道:
> This patchset is a rework from Oleksii's RFC v5 patchset
> https://lore.kernel.org/all/cover.1698353854.git.oleksii_moisieiev@epam.com/
> 
> This patchset introduces some changes based on RFC v5:
> - introduce helper get_max_msg_size
> - support compatible string
> - iterate the id_table
> - Support multiple configs in one command
> - Added i.MX support
> - Patch 5 firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
>    is almost same as RFCv5 expect multiple configs support.
> - Patch 4 the dt-bindings includes compatible string to support i.MX
> - Rebased on 2023-12-15 linux-next/master
> 
> If any comments from RFC v5 are missed, I am sorry in advance.
> 
> This PINCTRL Protocol is following Version 3.2 SCMI Spec Beta release.
> 
> On ARM-based systems, a separate Cortex-M based System Control Processor
> (SCP) provides control on pins, as well as with power, clocks, reset
> controllers. So implement the driver to support such cases.
> 
> The i.MX95 Example as below:
> 
> Configuration:
> The scmi-pinctrl driver can be configured using DT bindings.
> For example:
> / {
> 	sram0: sram@445b1000 {
> 		compatible = "mmio-sram";
> 		reg = <0x0 0x445b1000 0x0 0x400>;
> 
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges = <0x0 0x0 0x445b1000 0x400>;
> 
> 		scmi_buf0: scmi-sram-section@0 {
> 			compatible = "arm,scmi-shmem";
> 			reg = <0x0 0x80>;
> 		};
> 
> 		scmi_buf1: scmi-sram-section@80 {
> 			compatible = "arm,scmi-shmem";
> 			reg = <0x80 0x80>;
> 		};
> 	};
> 
> 	firmware {
> 		scmi {
> 			compatible = "arm,scmi";
> 			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
> 			shmem = <&scmi_buf0>, <&scmi_buf1>;
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			scmi_iomuxc: protocol@19 {
> 				compatible = "fsl,imx95-scmi-pinctrl";
> 				reg = <0x19>;
> 			};
> 		};
> 	};
> };
> 
> &scmi_iomuxc {
> 	pinctrl_tpm3: tpm3grp {
> 		fsl,pins = <
> 			IMX95_PAD_GPIO_IO12__TPM3_CH2		0x51e
> 		>;
> 	};
> };
> 
> This patchset has been tested on i.MX95-19x19-EVK board.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v3:
> - Add R-b for dt-binding patch
> - Use 80 chars per line to align with other scmi drivers
> - Add pinctrl_scmi_alloc_configs pinctrl_scmi_free_configs to replace
>    driver global config_value and config_type array to avoid in parrell
>    access issue. When num_configs is larger than 4, use alloc, else use
>    stack.
> - Drop the separate MAITAINERS entry for firmware scmi pinctrl
> - Use enum type, not u8 when referring the scmi or generic pin conf type
> - Drop scmi_pinctrl_config_get_all which is not used at all for now.
> - Update copyright year to 2024
> - Move the enum scmi_pinctrl_conf_type above pinctrl_proto_ops for consistency
> - Link to v2: https://lore.kernel.org/r/20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com
> 
> Changes in v2:
>   Added comments, and added R-b for Patch 1
>   Moved the compatile string and i.MX patch to the end, marked NOT APPLY
>   Patchset based on lore.kernel.org/all/20231221151129.325749-1-cristian.marussi@arm.com/
>   Addressed the binding doc issue, dropped i.MX content.
>   For the firmware pinctrl scmi driver, addressed the comments from Cristian
>   For the pinctrl scmi driver, addressed comments from Cristian
> 
>   For the i.MX95 OEM stuff, I not have good idea, expect using compatbile
>   string. Maybe the firmware public an protocol attribute to indicate it is
>   VENDOR stuff or NXP use a new protocol id, not 0x19. But I think
>   current pinctrl-scmi.c not able to support OEM config, should we extend
>   it with some method? Anyway if patch 1-4 is good enough, they could
>   be picked up first.
> 
>   Since I am only able to test the patch on i.MX95 which not support
>   geneirc pinconf, only OEM configs are tested in my side.
> 
> ---
> Oleksii Moisieiev (1):
>        firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
> 
> Peng Fan (5):
>        firmware: arm_scmi: introduce helper get_max_msg_size
>        dt-bindings: firmware: arm,scmi: support pinctrl protocol
>        pinctrl: Implementation of the generic scmi-pinctrl driver
>        [NOT APPLY]firmware: scmi: support compatible string
>        [NOT APPLY] pinctrl: scmi: implement pinctrl_scmi_imx_dt_node_to_map
> 
>   .../devicetree/bindings/firmware/arm,scmi.yaml     |  50 ++
>   MAINTAINERS                                        |   1 +
>   drivers/firmware/arm_scmi/Makefile                 |   1 +
>   drivers/firmware/arm_scmi/bus.c                    |  39 +-
>   drivers/firmware/arm_scmi/common.h                 |   2 +-
>   drivers/firmware/arm_scmi/driver.c                 |  32 +-
>   drivers/firmware/arm_scmi/pinctrl.c                | 908 +++++++++++++++++++++
>   drivers/firmware/arm_scmi/protocols.h              |   3 +
>   drivers/pinctrl/Kconfig                            |  11 +
>   drivers/pinctrl/Makefile                           |   1 +
>   drivers/pinctrl/pinctrl-scmi-imx.c                 | 117 +++
>   drivers/pinctrl/pinctrl-scmi.c                     | 609 ++++++++++++++
>   drivers/pinctrl/pinctrl-scmi.h                     |  12 +
>   include/linux/scmi_protocol.h                      |  77 ++
>   14 files changed, 1849 insertions(+), 14 deletions(-)
> ---
> base-commit: 5389a88b06eb19c3fb08200cc1519406e299b7b0
> change-id: 20231215-pinctrl-scmi-4c5b0374f4c6
> 
> Best regards,

