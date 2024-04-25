Return-Path: <linux-kernel+bounces-158812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07578B2531
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78572284266
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A477A14D296;
	Thu, 25 Apr 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DnVa/ljd"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89A14C5B0;
	Thu, 25 Apr 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059311; cv=fail; b=kKHbPTJgHIXhvi5tUkbBmVGoYEmzffbUwi904zDnfcm6YqsM5i/w1XNkZKPuka2lyymqcrXgalG9wmpDCurkXVGs5U+6j1NBc5pj/IkXyVTYGkVKckYkaRIF/9Mc4xhJp+BjA5w8hZHx+8ekIpCkrpKDWTRdifYrCUBWXCBblh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059311; c=relaxed/simple;
	bh=YWMgnuIfz3tnDo2KuQvNHE1Yhr1DOCTez3M5bC7GSzw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s7YyTaULJqqZcUowuRVDPbYqX+PVpgXBaRo4WP7t5a3JZCHG/SIudX2OFq4hSndT1hpSq9b/xuc1Rm9ScV160wUhQB1WJy9xbT9VXEhlDtXhRBlU+weNvlKj+0yaVuNp5uc2p71s7UK8huw8ujlpGAHT83TKOk1VFDTr9mmeKMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DnVa/ljd; arc=fail smtp.client-ip=40.107.105.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EesQ6sa9cW2TW75lgmvo06EUye7gtVcfyJ4tClf1+nk/Gm2I/OA2kt6L42geCyItRnsp5XclOuLLtGlpu1gDVxAodV08OREF2l0F7S5x4VCJIRhijI7qzKY3aUNqa824z1clK1Pq7Lpzp6IOMI1ytbKsNw4mJZ2AzISP5+SdFJ6O1yywcPhYnGMZI9r93kNrlJUFtKxdvXG4x/LX+nlEjy1Y84Wi8QZalLBTJbcYJ9r7iYQ3/QoRghwV0Jm6+I87XxsuJdTmGwgyyoCmSdMXAgOHpoNlkZ0+hY8edDcTNYUTz2FmhBAJN5g/jRoa2czgAsO4AjIavnpOF9gE1EkR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQQxfS602RKxbfcsR7MgUR/OX9gf2dyeFL2XO/sp4LA=;
 b=QxVU/xaOrbOZYQ2sJM9Qj2+3/L58i+XL4JclbQV11A2KmJJUldm5zlW+dOfUqGHouFtTdX3rD0ljYMite6F7XpdrnCbnMRmHmRQTKAg7ywBl6pORpRaCuAT35u5l0QZCX5IwbkawQd1UPWOxuJlg7U8TZJ026GbCd0LAXObF8c1CBIEnf4x+UqsDUnW8LQGi8XkoROh7VJcEprcJcaOSTcJgmD8u+OkX2Md2Qh8g0khFVCFyJPeRtqlh5v4Kc3+hZJtlB4lr39SF0B804Z0YOogjI4LigBMy0zVF3N5rDe2FIxLIMfwtWvueZUQJgd+VOQFadWIfdVRro8i/tTAEKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQQxfS602RKxbfcsR7MgUR/OX9gf2dyeFL2XO/sp4LA=;
 b=DnVa/ljdjQgCdGnoNAYAzoWTew1Xt4UpvHk/0Qf3ReuRIQ4hwmXCB2/F9RtZmvgIGoVbqfqlcTD+/7FRRcGTNbPkhiBwjRVTleU+YlqlKduMYwuFJZ7sw979kQcBYvrnS65AvCZUNn5ZcY0z54jhtOasGAeTcTqjNm5Ax7rf6gU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 15:35:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 15:35:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 11:34:43 -0400
Subject: [PATCH v5 3/3] arm64: dts: imx8dxl-evk: add audio nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-b4-dts_dxl_audio-v5-3-46397f23ce35@nxp.com>
References: <20240425-b4-dts_dxl_audio-v5-0-46397f23ce35@nxp.com>
In-Reply-To: <20240425-b4-dts_dxl_audio-v5-0-46397f23ce35@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714059292; l=7827;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YWMgnuIfz3tnDo2KuQvNHE1Yhr1DOCTez3M5bC7GSzw=;
 b=FyyvWtwWHU2qaiDt/0shu3q0/uHpjABaCiCKPXJx4C8EKuyStZ4miMUrpQowS6scVnyRRAmC0
 UbGWjYk+dpBCPBwIY1adOFbEwhZ6W3qqFcgWIze8CISAYHp+JvJRcSG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4fb000-ecd0-4f1a-464e-08dc653d480f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajYzQ2lrR2w3Vkoyc0U4L01aMHRVOU4vbytIemd5Z0xiS0dvcmFlR1lHcC9J?=
 =?utf-8?B?Y2d0MC9vam9VWHZsRy81OXFjeEpXMWRjcjE1emczeWxnQy9FYWdmNDd4VG9P?=
 =?utf-8?B?NllLbk43bWxJVERFYVQ4b1lGejhJcEtNRjhtVHlKWFFJMUoxVTVzdE0wTUo1?=
 =?utf-8?B?WXovc0VxMjRGS0ZQUm5UTEs5UFRrVjVsVXM1aGJzdjNsYlBIaGh0c05SeTB3?=
 =?utf-8?B?T3Jjem9FaEFBcXVuT0dBbWd0VStHUTlLYzAzcmVERkRLM2g5VkZhMlc0ekdk?=
 =?utf-8?B?WWwrbFgvUjJiNk5CMTU0Qkt2dDRLK1RHYkdwaFZ6eGM3cGtwUzBXZ0lUNUtl?=
 =?utf-8?B?TmMwQlFsT1ZQemlCMEdjei9LOWEwbTVKTkRxUWJUckZmV3pjZjVReHNiZVBD?=
 =?utf-8?B?aDM5QVByQSttZzBSYVFtUG83L2x5RTdPY1lBT0djSmlZQzV4c0pzcVlMUjZ0?=
 =?utf-8?B?WDIwSmkycVJZdTR0ZDMzM2NpblJ0K0hvR050ak80ak1JS2ZWKy9TWC9ubUlt?=
 =?utf-8?B?dFZTMlNaa1dBT2MvRk9MK1I2bzJCZ3dvbGpyZ1kwOHk2OG04eWdRUlFteDBV?=
 =?utf-8?B?ekRXaU8yYmw5dE92a3RPSFk4eGZvTVpFamtBeXhKUWJ1eGFrVTJNZU4xS1c5?=
 =?utf-8?B?SDAwSHlhNXlQbkhBR0Y5VGxkYVU1M040eFdlaHNCQllvWE4rcHdYNS9WQm1M?=
 =?utf-8?B?di9FTnMwUm9EQis1a0tEQm9iN3A3dnJBNmRmK2RBYkFtZUxkMi9TcVdxZTdS?=
 =?utf-8?B?WGY3TTdJdE1UcTlqcDRVN0puMWI2ZElMUzYraFVXbVRCRE4rVWxjM0QwZmhj?=
 =?utf-8?B?Q3k0VmpQbC9KbDdIRlBBaUdHbFJYV0JKRlFEdWlyaTBRSnBsMEN1WGRYcDUr?=
 =?utf-8?B?WTk5L0hRMDR0UkNmYXpZZ2N6ZnlXWjRvdXIyeEFhVXZwUUswaFNPbTZCQ3o3?=
 =?utf-8?B?T3FaellwU2RVSDBxZllZYjA0NWdiOUdYREUwZElVNytCUGx2VEZ2VDJyZFBY?=
 =?utf-8?B?R1UxY055b1FvWTJuR1kzY0FCbTZTWjNadWkwaU9vUXlTRFJmZ2Q1cit0YnRh?=
 =?utf-8?B?SVI2N1lIMHJjTWdOWjhuV1ZNOEFmODFSMHo0eXhhdTU2QWprMEgycFRKRktE?=
 =?utf-8?B?NmtnVmFIS1RvOGw0R096Y1ZTb2R3Z3l1eG8ydndEUDBqSy85OTRCNmJEU2d6?=
 =?utf-8?B?Q0VBdThseXpoMXVWVzlJY0tSR1h0NUVmK3dlQjIxUnl1Q1dnU2crZHNYeDNr?=
 =?utf-8?B?Y3c3eE92V0ZnS0NZbmtFVU1hRXRCbTVKQ3JmVGR4TSt1UzNidjR6K2N3TGpv?=
 =?utf-8?B?ZmQ4eS94UEFrZzRwZWE5czZHdVlOMXdITVgxb0FkK1pkU2xZUUtrSlJOQTFB?=
 =?utf-8?B?TXVPWU1jU05Cc2pTOC9uT2prWENRbHVYOXRvc2p0WVdNaGNPOTZSd2c0cllH?=
 =?utf-8?B?Z0VHMW5DLzVqN0hzQ3lxeDg3RXhoa1BqZ1hVTEo0QlZGTS8yMHNvRkMvNzJu?=
 =?utf-8?B?d0xSNmZzdm1NOFBzeXViWDd5VnlhYlZKZ2FXOFBISXRrVjFzTXBVaE8wVWp3?=
 =?utf-8?B?VFB3bGp4M0Y5RzdUUHV5dC9hdVlSNEhSeUU2ZnRNbGFBUlJhdGszZjhZdHNI?=
 =?utf-8?B?aWgwMUpkMHNsZEtIU2ZHR2hpaXRNdjFXR3I3T2tCT01jcldjMXJOSHBReWVB?=
 =?utf-8?B?b1A3ZVRWSEFPTmtoanF2eSsvZ0VmMzZwZnlCc0FFcnlKSDdaNEJoTGpzRGFt?=
 =?utf-8?B?MjJXRnBkc2FhNTlCR3FMRlpjdmIraVFUS0lvc1dYbHhwVWpBcHdldG5IMVZR?=
 =?utf-8?B?a3hJQXpLNHdrcitCdlJxdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTNQNXdkbkNUdm01YkRPano3Uzl3eTRaWXVYOGNHb2UrSFhxdDc0OXVZRVJF?=
 =?utf-8?B?WE1LRWl0bEpQYkR1QVE5dGVCd3JuN0tZTkc0RVYreGxjQ2dmNGhwZWlhMnlQ?=
 =?utf-8?B?TFBxbUdKQnBpVGpnT0szUFcxTU9mRzVZME9LOGlVaUhqdlJFbVMzcWlEVjhJ?=
 =?utf-8?B?RlBvSUZ2cVhZbWpVMkdBZkxRMUMyTis1QXFuNlZzV2J1c01tamJQb005TzRU?=
 =?utf-8?B?UEp0YXczakhQempUbVEwc2t0Sm9UdCtZQ21VOXUweExDUFhwUm9uNk1WeG0z?=
 =?utf-8?B?UVpacjBGVEQwaU1lcjlsSm5XNHVVaHpoNGhwRDNCK3FZVU9CQ2c1ZGFzYW9O?=
 =?utf-8?B?eG1SV3dsVTFCdHVwVldiSU9NTjhib1o2UC9MWDduOGl3OU9qZG44Y1ZHaElk?=
 =?utf-8?B?SU4zUTYvcmVnWjBDTml4SS84NjRkSXVIb3dRcTNZMU1RWVZrUExGUHhPczJR?=
 =?utf-8?B?WEZCU0RwS0poSGxyT0F2Uy93bUp1ODlCYW9DV002bzgyZnFjdTRpZ2gwYk8x?=
 =?utf-8?B?cHI1ZEYwa2d6YzJEN1prbUthMGNVS25obDcyZ3U5NnFIK0tNdlptaHptK3lM?=
 =?utf-8?B?QWFld2g5dVpCQ2dxSmRYMVovbW5qTjJZazF4cjBubzBlQ2JPaXhtZE8wNlUv?=
 =?utf-8?B?NlRkb01teVFFdTZpalVUeXJ5Zm1GTEpxSDdLMkNxQ3Z0di9NTDEyMVZFZ1lX?=
 =?utf-8?B?b3k2WnNzc3dIZXA0aEhyWjFJV1E0VjhKcmlZaFRTVUVxMWdDb2hJUDlnR1Rp?=
 =?utf-8?B?bTRDZWpkZkQwY2xnZnRYR0hpendZaWRoYlFSVmdqYjVUZ0xDMUFUYTNjU2Yv?=
 =?utf-8?B?ZDlhVnRROFlPYjFid0I1SldXVE9xc290RktlNDI2NGxDVjNOLzd3bHNuS0dL?=
 =?utf-8?B?VnFRT29OT3IyUjRiMnhxZkpXZzFIVjJldlBpS25EaDFaSitIcVdGbm5MeUJl?=
 =?utf-8?B?a0V5MU5sS3JzcW1sV25vY2JOb01NM25POWtObUt0TGk4Uit0N2VkK2lHY3Az?=
 =?utf-8?B?OEx3MlFpZ2NIaFRxSjNOYVZweG8zbnhBSStqMzJMSEVMSXNESjdGdUx4UVBN?=
 =?utf-8?B?MmMyb2srR2VQS0xJRU9VWDZXaUR5V0lNRURrSy9BSGRobjNxVW05NFM4YnR6?=
 =?utf-8?B?VW92VmFlWFY4Zmc4N09IT0lDemI4RmtXZVpaZzd5S2hac3cxWU1Pd0N2MVdn?=
 =?utf-8?B?RkxUd3hLaUhIcnYrZStjV1UyNm9VelV2dkVpY3krSUp6Rkd5VlhESVlnd3dR?=
 =?utf-8?B?WVEyWCtoeEdiSXkyZUZpbndqMm9EbWRTclhCSGRNZ1Q0ZGJYdmNvY3R0bU40?=
 =?utf-8?B?Y29wcXB2ZzVKc0lIZEFianhVODk1R2lyZjR2MDRWL1ZQekhrYVdlZkMxd3VS?=
 =?utf-8?B?OGFrbC8yRWpjckdVUSs1MWwvV29uamIrcWJFeTVsbDQyQlZQa3NaTzJnN1Fw?=
 =?utf-8?B?ZEdBbjFhdTZ0OUFBR0JtRXNZQ1dGOWdCeGViK0I3ZzhpV0owQXg5MFc3ZC9t?=
 =?utf-8?B?S2ZhZlp4WXYwQVZ4N3VpMkhCVlBEQ2RWTGZPMDgrK0FEc0tad2tnR3ZtTHFR?=
 =?utf-8?B?UkJrS0tXcGF0UCtsamJmYnVtK3A2TitNK3JxNFdTVXBMVnBrRHcrb2l6Zitz?=
 =?utf-8?B?RlZXZVVzQVN6OUVBQ3VYZ21INUl1czhQSGh0ZzBFVW1mcXRNWlBISlBJMTBp?=
 =?utf-8?B?aldHa0xJMWp6MHZ1SzdtazRvekNxOEZYM3prV0NJRm8rTDJpbkpiTWdETStL?=
 =?utf-8?B?a1lZME1JajY4LzNjVHBkVEJKSkR3cDFVaW1Tcjh6cDlwQUZWRDNkclBWUlNz?=
 =?utf-8?B?STdNNFdBcHZYaFN6M2xGOThFY09jcGtrVUplSk5WS2NjS0R3T2hEVW5vb2l3?=
 =?utf-8?B?LzJKWjMwTjdhSjQrVWhtaTNDRHVRcCthTjJPMFJuLzRvR3AyL1Nyb0lpbDdU?=
 =?utf-8?B?a1ljbWxyQ2VDQ0lyT1J0ZVk4MEpGSXgyU2pUT0lJRUU0cTcwem8yeEJ2MFEz?=
 =?utf-8?B?cUNMeTRLV1M2Z2NpTEN5VU95c3loZUhiekkwbmF4YmFIR2dXdTRlL2ZOaUNH?=
 =?utf-8?B?Qyt0dXFSZ29mS05pRUJQMW51TGhWdUUzeWl6NE1RWm95Qi8rVDN4VWlKdGRx?=
 =?utf-8?Q?Q+RU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4fb000-ecd0-4f1a-464e-08dc653d480f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:35:05.7603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLSWz7KxM7XqN2QIv3bRVTH2P9swnyprRpsxsZXCecT6ev9o3cuQGI8T4Hahascx80ydz5QlVQEN/wwtTqEJDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9654

Add audio nodes for imx8dxl-evk boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 229 ++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 2123d431e0613..312a3032a061e 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -125,6 +125,76 @@ mii_select: regulator-4 {
 		enable-active-high;
 		regulator-always-on;
 	};
+
+	bt_sco_codec: audio-codec-bt {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <1>;
+	};
+
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai0>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
+
+	sound-wm8960-1 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960_1>;
+		audio-asrc = <&asrc0>;
+		audio-routing = "Headphone Jack", "HP_L",
+				"Headphone Jack", "HP_R",
+				"Ext Spk", "SPK_LP",
+				"Ext Spk", "SPK_LN",
+				"Ext Spk", "SPK_RP",
+				"Ext Spk", "SPK_RN",
+				"LINPUT1", "Mic Jack",
+				"Mic Jack", "MICB";
+	};
+
+	sound-wm8960-2 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio-2";
+		audio-cpu = <&sai2>;
+		audio-codec = <&wm8960_2>;
+		audio-routing = "Headphone Jack", "HP_L",
+				"Headphone Jack", "HP_R",
+				"Ext Spk", "SPK_LP",
+				"Ext Spk", "SPK_LN",
+				"Ext Spk", "SPK_RP",
+				"Ext Spk", "SPK_RN",
+				"LINPUT1", "Mic Jack",
+				"Mic Jack", "MICB";
+	};
+
+	sound-wm8960-3 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio-3";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8960_3>;
+		audio-routing = "Headphone Jack", "HP_L",
+				"Headphone Jack", "HP_R",
+				"Ext Spk", "SPK_LP",
+				"Ext Spk", "SPK_LN",
+				"Ext Spk", "SPK_RP",
+				"Ext Spk", "SPK_RN",
+				"LINPUT1", "Mic Jack",
+				"Mic Jack", "MICB";
+	};
 };
 
 &adc0 {
@@ -132,6 +202,11 @@ &adc0 {
 	status = "okay";
 };
 
+&asrc0 {
+	fsl,asrc-rate = <48000>;
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
@@ -259,6 +334,78 @@ max7322: gpio@68 {
 			};
 		};
 
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+
+			wm8960_1: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			wm8960_2: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			wm8960_3: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
 		i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -362,6 +509,53 @@ &lsio_gpio5 {
 	status = "okay";
 };
 
+&sai0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai0_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai2 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai2_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
+&sai3 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai3_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
 &thermal_zones {
 	pmic-thermal {
 		polling-delay-passive = <250>;
@@ -595,6 +789,41 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
 		>;
 	};
 
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8DXL_SPI0_CS0_ADMA_SAI0_RXD		0x06000060
+			IMX8DXL_SPI0_CS1_ADMA_SAI0_RXC		0x06000040
+			IMX8DXL_SPI0_SCK_ADMA_SAI0_TXC		0x06000060
+			IMX8DXL_SPI0_SDI_ADMA_SAI0_TXD		0x06000060
+			IMX8DXL_SPI0_SDO_ADMA_SAI0_TXFS		0x06000040
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX8DXL_FLEXCAN0_RX_ADMA_SAI1_TXC	0x06000040
+			IMX8DXL_FLEXCAN0_TX_ADMA_SAI1_TXFS	0x06000040
+			IMX8DXL_FLEXCAN1_RX_ADMA_SAI1_TXD	0x06000060
+			IMX8DXL_FLEXCAN1_TX_ADMA_SAI1_RXD	0x06000060
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			IMX8DXL_SNVS_TAMPER_OUT3_ADMA_SAI2_RXC	0x06000040
+			IMX8DXL_SNVS_TAMPER_IN0_ADMA_SAI2_RXFS	0x06000040
+			IMX8DXL_SNVS_TAMPER_OUT4_ADMA_SAI2_RXD	0x06000060
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			IMX8DXL_SNVS_TAMPER_IN1_ADMA_SAI3_RXC	0x06000040
+			IMX8DXL_SNVS_TAMPER_IN3_ADMA_SAI3_RXFS	0x06000040
+			IMX8DXL_SNVS_TAMPER_IN2_ADMA_SAI3_RXD	0x06000060
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041

-- 
2.34.1


