Return-Path: <linux-kernel+bounces-153944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E18AD532
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C821F2246E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75505156220;
	Mon, 22 Apr 2024 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kdAJEBDI"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D515573B;
	Mon, 22 Apr 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815431; cv=fail; b=nfIInVazpB7pNgXF5uQEvbhKl1koxjctUi0FHnr79d/rheTvrUy8cnRg+zyZPGHxCzeZEBLEDqWiTE+ECHHCAF0+1aJeEud0xEo+QI631PBjQOBlxrJrF6ajMOnt8zzJNH0OvgLsEWPsqXjEa/EP30zUEwRltJihanagiCugt3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815431; c=relaxed/simple;
	bh=OwTYkXzrFDUZm194y6jPRu+hj6zyMaee5U8q6ZnC/vo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OCvO4iNBeNr08NtCPojVObxmzziDEsokSL826RqF8VmWOH39eX/G5Ww4Dxi4p/Ga8FPj9UWRwtmfAsRbIGKyJP3wTeQu8CMQbtpE/2VBx09cEzvmNRiy2ljjhjFWs0M6lJrJuJxSreFv0VLoj0tdGQRlr4lgyiT8UNhCBANyaQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kdAJEBDI; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2G5Ofej2JWTwwAfWRRRfRibj0DHgJ+zwqQLZyCECvOSn5lWJv7CEAvzqIKRqORAF674WI4Z3uXgJ936W3XtjoGThlX9jQxshR2BpbLLO7vUYags3XmUtBcCVYVyUcBJ1DWRNByg2V073auBB8ambyNTWTbGGCURAhZgtpJb2wAJx3HzdLNvHQqWMwEVwu9dp7w/PJwYB3vwkiypV4wA7GCm0YgNr3XdxyEgV5TwEXi1+Ps1L2/EO3iBPb/M/fU48AbJ1XOQJ+dwnxaAOp6M40IGveCQnHjIEv+4yHmR8B6X+VcwyQ2RPyTBLcOVdXqTg+V3oWh+luruWULn9XVDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA0iYjLjvM8OJdpj6SYo+QqVKIOuYyG/Krg41c7qsO8=;
 b=GwC18PpfBtV9MaDGcsvVWqbtkbBJUVFDPWCLrazqBa3aEQJysciZ+fQhbdju0KG8GKB4bZIAeg4hZPWJ3AEOX6ezxXn9DaIqCcoYXzj/m+3+u8lmrNfEY2J4p0qas4kTFpQWYnEz4NjYq+2cNBd553H7tERvfdGuR27b+2sm3i1IKRWVzGGXUbIh4PBh1m1dXU1iG0x3bKFJYSZ0jeYXMoGUl8S6HTEL8gfBEuOyVAPSlevQccMpag4d4PA23hbdvwlTRRlDCBishlNJ1ikDWuerWsNTKPoJ9rTJF7C3C1saHsz9h+1HBrilMJpJxOIpJ69qemRm6TMvCkAdYTULXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA0iYjLjvM8OJdpj6SYo+QqVKIOuYyG/Krg41c7qsO8=;
 b=kdAJEBDIfhd7qtb2sM6yW+t5pDNzb61XeYydxFu5r7mH+9wclO6YaSbOwTxmDojlTce5NxaqRb+yy+P+VnzxMmZQuaIrAD2edTiTGjcxvQ4YVldrMYLQMBH31Mazr2uFL1e2Gq3KB0K8zhGAcEV3oBbzp5zm5F6u23FGW+F+Jh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9734.eurprd04.prod.outlook.com (2603:10a6:150:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:50:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:50:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 15:50:05 -0400
Subject: [PATCH v3 03/10] arm64: dts: imx8qm-mek: add sai and wm8960
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-dts_8qm_audio-v3-3-680cee731ced@nxp.com>
References: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
In-Reply-To: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=5318;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OwTYkXzrFDUZm194y6jPRu+hj6zyMaee5U8q6ZnC/vo=;
 b=bcNK30PZpm70c+NEoJG+T+qw2oHIRydJnkNwlaWjRR5PagSm69lw/fVG4QVBWrX4hNEDWOa7X
 W3SA7gP8+o6AWzzY5hRsqVeRwMR4fY0IlohMsIUpUxht41Ml3XxkOpR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9734:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a0045c-2441-41b6-4fe7-08dc630571cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkZpYjRpV2ZpQW9MdjZDTEN4SDdkZVg5OHppSWZYaDBReWJmYzJNN1hMUG1F?=
 =?utf-8?B?dlNyYTdTYWRVeVlBRVdVY20rSFQxdjc1RmdnRnh4eDhDUVYwU1hQb2xPYkpV?=
 =?utf-8?B?ZHFUd2FEYVRSa0VzbkNaYnUyK2twNW1HSDAzK2hHNGRqSkNteGNyRUxCOFNu?=
 =?utf-8?B?MjlzUm8zaGxQTS9sbEQ5Mmdrd1F4bkU4WEJoWGtFdmV2RStsaHkxNzhYSzJ5?=
 =?utf-8?B?d3JPalBvK1VvQXhHbjM0bTdvYlpxRWhpaG5YdUQ3R2FZNkM2U3JRVE5rbjJa?=
 =?utf-8?B?MmVoTWZQSExhTmg0S3hya1lneHVnSnN1NlFJVGpmSkYydkxGN1hpQVQwSHU4?=
 =?utf-8?B?U0pkUDkwSThIQm4yOFRXOHkrVVU0UzF4WGduSm81dlJnajFKWkdzZmp5ek96?=
 =?utf-8?B?dE5mS3Q0c0ZtcTc2NUhTUlBNOFFIYTNEQ2VydUsyZTFPQmJnRHA3cjNzNUJC?=
 =?utf-8?B?NlNvWGhTdk5VTEQxU0FHNTV0ZWFwNmN3MGVSQW0wNG5xdnAxdmtpaU4wWTFu?=
 =?utf-8?B?WFdaTHVtSkwvcW1zSnVwUDhuZVJDcHJhM011N093S1B5UmJUSTg1R1FYUGZC?=
 =?utf-8?B?WTkrQXo4QVd0Q1Y2N1IwWjk0ZHRRaGh4NHBtdkpBeHNWMmFZSkJYQzRENDNV?=
 =?utf-8?B?czRFd2IxK3B6RVBOeng2Y0tnck4zdkxMcUlaQUtjNVJxN01lbnNDa0VFQVdG?=
 =?utf-8?B?Yms1Y2dIR3pCNTBpZVJpWlNCeWlheW91RHZnYmdXZ1hWbXdnTHFQNE01RjA5?=
 =?utf-8?B?NW0yOHhLQmh1SFpEalArbGFaZnNzckp5aFFWZ0dTVjlWaTJocnVUOE5yR1RU?=
 =?utf-8?B?a0szaTBXbk45L0w2TEdrNnBlZUVJNE1IUmduTzRQcGEvdWFIZUNlMEFHWE5l?=
 =?utf-8?B?K0JVQVR6Y2tNemE1YURJUmY5NWV6UGdUSFJ4MGpMN0tQQTl2RGxoRUlRU2VZ?=
 =?utf-8?B?M211Umkxa1JWaUNQeVBrZE81c0RyZkoyNlF3Qk42MC9UN2NudVk0T1NXWnd3?=
 =?utf-8?B?M0ZyMUdLWk9uVE1makdrZDg2aXlwNE14M29uZEx3Ymd1cWlSNmRvWEhzOHJi?=
 =?utf-8?B?Zkt2N0tHU3pWRFAvNmpFQit2OE94S2JaTTkwTmtud3ExalIvZ3AyNG95U0l2?=
 =?utf-8?B?MzIyYVJkTCs5ejBxUVJHMEJPMGlvZ043cGh1b3ZKdmdSTnNJUmI2eWt4dmxX?=
 =?utf-8?B?bXdkZTJjaFp3eGxCM1ZkU3VZVVlIeFVIQUF1VXNEdmtmWndoYnNqaGwzcDN2?=
 =?utf-8?B?Zmh2c3dYVXRIcTlBN3AxUDdsOEx4UjdsYTNPR3BUb3Y2UithNk5rTGJmMFR1?=
 =?utf-8?B?NGc1NkRiWGY0Ui9XQXFEaC9BVGNGeWRMN3gvbXNLMHpLYnl5cThoZ1VtV2Fj?=
 =?utf-8?B?Sno1dk1SOHBIaDFjK1VCQzNxM0VJQkNDUEVSSEtKWmVvTEY0UDBDRGNmVzVL?=
 =?utf-8?B?ZFpZK2p4eWFGYlpzTFgzQThxclFBRUJWbmxUelA1eCtzZE1yRHhzc0trVjdj?=
 =?utf-8?B?MENsenlGaEs2NnFvcFR0NzlaMmo1U2tuOW1KZXB3Zys2VWV4cEw4UlVkdy9X?=
 =?utf-8?B?WVR1TjNjaVFXdk15NTFOMURLNHJYLzRUQ2FhMHFweC81dnVxcVZiUlR6WDlJ?=
 =?utf-8?B?U1dOSTY1eC9PMk82VVlqWXFIRXpzeEtlK25KQ0NGRnhOVkdEZFFDdXJBcjk2?=
 =?utf-8?B?aVRmZm1RR1NWNk85Y0d3Q3BnR01OUWpacU5rMlJpT0VlSTZnZEtkVG5wM1VQ?=
 =?utf-8?B?VFR0THdOUHdBb29jV0Y2Z3RsZGpQaFJ5OGV5c2N2UStZd0xOT3A5M1Zacnpm?=
 =?utf-8?B?dVBKbHZYR1d5ZzFiQUFBZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3RCYy81TGIrazRKL1VWUnFNWkN4VzRuRk9NQkYzN2x4bVVCU29yV0VxY1I3?=
 =?utf-8?B?S21CYThLY0tJMDlLOWhUUm44NkliRCtFOVlsVXpWaWcwaHc2M3psR0RIampK?=
 =?utf-8?B?NkM0cXlvV0tUVDVvMVJYRzRDRzRIV3VyMFBpZlFDb2MwVmFGWHVnUVd0L0dC?=
 =?utf-8?B?TUE0cGgyNzByV2RFcjUzZTNDUHJITjB0aVJQY0pxOFYyYStkRk92WFhBSGpa?=
 =?utf-8?B?aWcySFh5dmNjRW9CYVNpVG1zbUJNek9uMGJCN29aQzlSTTlTRTBVeDNTTTRR?=
 =?utf-8?B?TWpWUjN3azdZbkZIb2JwZTlLTlYwNkhmUUVDSVVEak1NdGR6b0NXSnNsb24y?=
 =?utf-8?B?YkpGcVVZbkFCdGc1QU5TY1A4VHFqdnBiSThPYlFzZTJaYStvcjFwYlJFSzJN?=
 =?utf-8?B?RG43TnlEd3Ixb2FiL0p5MGpIOVNnY1ZOWkIzWHV4OEprcVdiTFBmUkVSTU9u?=
 =?utf-8?B?M0dqUld2MnQ3dHlQaHV6YmlpaXowRVBDci92eWJ2dnUrTnJhMmV5QTRPZnI1?=
 =?utf-8?B?REpaNHlUZmk2N1dBOG5QZ2lTbGhFOHJsOW52UllHYjRTdWR4RzJkS3VNVGh3?=
 =?utf-8?B?dzdNcks0aUtyL3pNb0JoeVc0dWsvZ3Ardm92VmNEdDNmOVI4UG1aVXpXMjBM?=
 =?utf-8?B?Q0xXbTBaQWZab3A0bXpobHh1TVBxdC9MUEdrRFNuSWNyR3hOcExWdE41bThk?=
 =?utf-8?B?elA0ZmFTTDhXT1YyN0M2YjJ1RDY0Z0s1cS90cDhWdWVqQWU4RFVqWmxRMUgw?=
 =?utf-8?B?RUdVMFNMUHBBSjd0Q0pUQlhlSzlpTVVZYWl0YWFCbU9oeEp0a2NSTjBjT1di?=
 =?utf-8?B?QXhNU0V3bnd3SEZ6bGlWTUtrSE9DNndDZytUVkRzMW5YRWZpblVpWjFES0gy?=
 =?utf-8?B?WE91MTRvbkY4V09EM24rdERMVytqaFluSTYraUZXNU9MdzRDU0lmclZQWGsv?=
 =?utf-8?B?NXcvN2FlTGZ2L0VKUURYemI3VGFhYVF1OWxmUmw4Q29jdUJ3d0h5c2xKb2RO?=
 =?utf-8?B?Z3JJR2FJVzRGc0lpc3V2YWl2QVNvNGpTRFZ0R2tFendaS1pXd09kOGZnZTZM?=
 =?utf-8?B?d2xHbEljNzFOUFlHVGphVVNaWmRWY0JxL2RmbkNWR3FSa2U0NlhaT1ZBanRO?=
 =?utf-8?B?NWR3QThhRDNRUDNSdlBsdGNURUtjQ1BVYThOalVGV2QwQzdvTzZHd3FXVlRM?=
 =?utf-8?B?ZmNwZ2Z4VnErRHhlKzRHbTExb0RWQmdHYmdIOEtSdXlOUGJwbVB3WFN1Skg2?=
 =?utf-8?B?ZEd2Mkx6YkJNdVcvVVVCSnF3NkkreTRjaThLU0ZYcnhJT245ald3ZUVoRzRD?=
 =?utf-8?B?VFlZSTVzTDhJL2Q1Sm9BYVI2U3BzUldIaXVuMDB0SURlTlFwRVZoeTh5d2hD?=
 =?utf-8?B?dkE5dmY2YWRMWS9QZ3N1NnlGS0NnakFjNUlRbUY3SUlONUhrckZQRFN2cGw1?=
 =?utf-8?B?eHk3L1FuUUZ1eUNTeEY5OXh2SUdQMXRud3ZPMXJXYjhGTDVacjduU1pEUDFZ?=
 =?utf-8?B?UXhUZlVBQkNCN3NzQ21MRTJvc0o4RGgvRHlsd0JPNjFrdHIwNXI5b3ZtMEE1?=
 =?utf-8?B?Qm1kNmd0MFJXUnFLS0lTWEJsN2tXSE9wVkV0RTNGRGhJQXhtTnlpTXFDY1Bm?=
 =?utf-8?B?VWNpck43RGFTckh5QTFhekpvUDNYUG5BcmtuSFQrYWtDM3hDWkRNWWxORitG?=
 =?utf-8?B?YkZCZDhoeHlRRjR1YzFWV1RXY0hmeW82NUZUVCtwa1A4OFZPTTBLeHNPdVcv?=
 =?utf-8?B?QzB4OXBjbTlzamQ2aXliUGM0ZFA1SEFpT051M3hYQVBOZzNOTDFVeWRBNjhq?=
 =?utf-8?B?VHpSNittRVdPRmY4L1IveGlDK2JtaVN1SEtVendMMTR4OVoxWldLMWJYelAr?=
 =?utf-8?B?amp6Q0lWc1JGL2U2S01TS0g2WXprKzlablhhMDc3NjRhdC82a29GVDhzQnZ0?=
 =?utf-8?B?SDd1T1ZaMmlFVklNRTFlY0hpejdsQVFkcENjQ1Z5aWdlQUZpSzFXZGo4N0ts?=
 =?utf-8?B?K0Rxb3JFb0Y4V3FtVFRkMzFxOEpzWWgwU0FtSzUxSlZxeVhMN3A1TVpNdVND?=
 =?utf-8?B?Q3FGN0xtQmVzS25nL3BLMzFoeW1XWUdrWWNKTDJMcDB5Z0lzbGJqR2Q1TlhC?=
 =?utf-8?Q?P2o7RW047UnrQRZnpp28akaij?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a0045c-2441-41b6-4fe7-08dc630571cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:21.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyYRXYQx9hcYoowG9YthJUC378HgRwPtM6JnKv9sd4tl87FfRVnuQtFFY4wju2tM2PbwMbz5gSUHiyrPN+xNKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734

Add sai[0,1,6,7], wm8960 and asrc0 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 139 +++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 5c6b39c6933fc..5c7df6171a9a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -46,6 +46,46 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
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
+	sound-wm8960 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960>;
+		hp-det-gpio = <&lsio_gpio0 31 GPIO_ACTIVE_HIGH>;
+		audio-routing =	"Headphone Jack", "HP_L",
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
@@ -65,6 +105,77 @@ &i2c1 {
 	scl-gpios = <&lsio_gpio0 14 GPIO_ACTIVE_HIGH>;
 	sda-gpios = <&lsio_gpio0 15 GPIO_ACTIVE_HIGH>;
 	status = "okay";
+
+	wm8960: audio-codec@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "mclk";
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12288000>, <12288000>;
+		wlf,shared-lrclk;
+		wlf,hp-cfg = <2 2 3>;
+		wlf,gpio-cfg = <1 3>;
+	};
+};
+
+&asrc0 {
+	fsl,asrc-rate = <48000>;
+	status = "okay";
+};
+
+&amix {
+	status = "okay";
+};
+
+&sai0 {
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai0_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai1_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai6 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI6_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai6_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
+&sai7 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI7_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai7_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
 };
 
 &lpuart0 {
@@ -161,6 +272,16 @@ &usdhc2 {
 };
 
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			IMX8QM_MCLK_OUT0_AUD_ACM_MCLK_OUT0			0x0600004c
+			IMX8QM_SCU_GPIO0_03_LSIO_GPIO0_IO31			0x0600004c
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			IMX8QM_GPT0_CLK_DMA_I2C1_SCL 0x0600004c
@@ -256,6 +377,24 @@ IMX8QM_M41_GPIO0_01_DMA_UART3_TX			0x06000020
 		>;
 	};
 
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8QM_SPI0_CS1_AUD_SAI0_TXC				0x0600004c
+			IMX8QM_SPI2_CS1_AUD_SAI0_TXFS				0x0600004c
+			IMX8QM_SAI1_RXFS_AUD_SAI0_RXD				0x0600004c
+			IMX8QM_SAI1_RXC_AUD_SAI0_TXD				0x0600006c
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX8QM_SAI1_RXD_AUD_SAI1_RXD				0x06000040
+			IMX8QM_SAI1_TXFS_AUD_SAI1_TXFS				0x06000040
+			IMX8QM_SAI1_TXD_AUD_SAI1_TXD				0x06000060
+			IMX8QM_SAI1_TXC_AUD_SAI1_TXC				0x06000040
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041

-- 
2.34.1


