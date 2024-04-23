Return-Path: <linux-kernel+bounces-155149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5848AE5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC16B2151F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605384A57;
	Tue, 23 Apr 2024 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ofrnl56u"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751DE576;
	Tue, 23 Apr 2024 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874866; cv=fail; b=g1RcenNW/Y2mz6TFuRiDnHJwwF1kLKNfvN0UTWEcLQwkLghWMdnhFm6xzxQU37TNa+wwMIXMt/Kefm+8uRy8kWihMaUUAAMkNwYkUY6ZK6RlZPLzhTrxH5oPFeSbRjXi0x9ltR5MlxqueCwnwgaWhVbNcPS3a31JyQBOZ+7C5bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874866; c=relaxed/simple;
	bh=WbTGPiidGSX8ejyU269k8mNZk1cJc+zqi/vA2ZZgPGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bJy8i+in9K3KENpy0k8I4DZRL06ltwOZfNka58xg5h5wP29DA8bn8ZhJdHMwXjnmWUdFUjYBzkQJKAO5VlfkqSz2os4mdRMFc+X6gAQUgKKiJO9W2d2yY3S3f8bQLPso4VSbMsH35dpyGn5uiCId2tmeUQMauyjCkjXjamRAr3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ofrnl56u; arc=fail smtp.client-ip=40.107.6.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1YIiqxE43H0K19Y3xOud/hR6RIUCZFNYff+nJhGb9FDA9+/fgXxvNsDoLLwTEjStWlnY/NqClsyeKyWR7MCYiFSvmU6dv90axXuI8elthSLijaUaf3ecxG+5+X9Fsi+sSbORQZmDofkPpoerb8TxH7Ninog8yXQfxVX2yDn/toK10yum+JOCPlUgQyJqfSNG8FQ8NwPlL6DrzpELVMdF0HzKUfUCixYUiF1NcdHSfixUoAmbE5qv2I2eZC8gpmT0wzLWU3fnb/V9WWZvk179wX4jGZyvWCy1lQ4SUiyohZg/zml0plSq5kyMIvaTN3k/PDopUPooJysKVyIHkiixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbTGPiidGSX8ejyU269k8mNZk1cJc+zqi/vA2ZZgPGc=;
 b=SBkhMcp1WCiNwWx++ITraJdHYBlM5SiF8QbemDutG/8mfSwNWUTG5kPJT12P+Rq2/Ip2vjum8ii6IecxCESHq6lY//zsqqdBvs0fo1nwJ6r2UzNyJEnpAFYJXwRcG6Gmx9rTnoJ25Xqihw4qSspXvDb3w8lkMKn8q4xvxWG0KXanOGJr27RaqutLE8RZrneYnJQ3vw/w4cQvmnrn5CcgqOC+d5UMtcXS1M581GxTtZFb7hf1QYLOPQJNC3xRIAoXir10QN0MHvW9mQyZVwVBe/Id0HnSPOfCZjpI5MLGYjzbb2WlkjFEI0ecQ4ui7nH/gmqJdRWmtbH2ONYjfC5LPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbTGPiidGSX8ejyU269k8mNZk1cJc+zqi/vA2ZZgPGc=;
 b=Ofrnl56uWXvcPaTPQqOi6m2wAfvfDxLTIqrXtPitDlqS2FMHQzUtS5hkYoShkmPdAUiArpIQAqCITWLc8ICnVNZvdxr6Eftr9sUMULFlObKlHEMKyGyoYl0gxJ5AJjEBjBJCO/rbpRHdSPqOv5j8r9B5Fk4axKgwDKXXQ50X29g=
Received: from AS1PR04MB9502.eurprd04.prod.outlook.com (2603:10a6:20b:4d0::13)
 by DBBPR04MB8025.eurprd04.prod.outlook.com (2603:10a6:10:1e4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 12:21:00 +0000
Received: from AS1PR04MB9502.eurprd04.prod.outlook.com
 ([fe80::5baa:4ab2:7d15:d15f]) by AS1PR04MB9502.eurprd04.prod.outlook.com
 ([fe80::5baa:4ab2:7d15:d15f%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 12:20:57 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: "brgl@bgdev.pl" <brgl@bgdev.pl>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
Thread-Topic: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
Thread-Index: AQHalSX3LJYhygbqkUe2wC+6G48jP7F1u+eAgAAHv6A=
Date: Tue, 23 Apr 2024 12:20:57 +0000
Message-ID:
 <AS1PR04MB9502BE89834E7F9DA3E8D70B90112@AS1PR04MB9502.eurprd04.prod.outlook.com>
References: <20240423022814.3951048-1-haibo.chen@nxp.com>
 <CACRpkdaRxoEZT1_KyJ3QMDgBcciw1XUXKr=cEiPxbcwSnpmyiA@mail.gmail.com>
In-Reply-To:
 <CACRpkdaRxoEZT1_KyJ3QMDgBcciw1XUXKr=cEiPxbcwSnpmyiA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9502:EE_|DBBPR04MB8025:EE_
x-ms-office365-filtering-correlation-id: 6153fc99-2fd1-4872-5799-08dc638fd47b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0FCWjZBL2Fnc1RUc0xZQno5ejBJVTlJMXhQUWhIZWNLK0FZTkNRZWpaaXZv?=
 =?utf-8?B?ZUVWODBPRDJtUWlJOWROTS9VcGdVcC9EU2NYSy9PMlJMbWxKZkVVTTg1Q0dt?=
 =?utf-8?B?UVlteVJTVk9VL1lMWGU0b0xZOU9kL2sySXdrZGFGQXpvc0p6eUhwdTBBSmZJ?=
 =?utf-8?B?SDlaaGgrenhLdVVzWFNEaDBOaEdHNjJrL3BuajdBajdWbEhvRTZFUkRsY3hG?=
 =?utf-8?B?blgrbzUxVXFqcjZrOXFCblJGcVgzbWVvQUx6d3ZuejFQbFc3aURyakRJc0tP?=
 =?utf-8?B?WUdOK3FvaFp5YjgrK0pQOWRxQy9WbStaTVY3Ymh5M2FnOWc4SkxrNzFYSEFS?=
 =?utf-8?B?MGVUTVpNWUU3bnJoVEREUFdROXFxb3FwWE1SMVdLTjgrY0VvV3lxeHBqUTlr?=
 =?utf-8?B?aDJWZkdmMWdMWFJFemxBWTBXQTJTeE1MblMrTER6MHFrR0NhUTBBRm5hV283?=
 =?utf-8?B?Q01XSkVLTDlObm12OXhNRnorcTZzZjA4VzlSLzVMeHlaQXE0SXhaNGlJc0d5?=
 =?utf-8?B?bHNhV0pSS0NNU25WbTJCdWw2cnJLQ1RyeFpsbFp0bFZrSldPNDc0T3dxd3hj?=
 =?utf-8?B?a0RRbFNCWHZLT2tqWmJzVUpvWlVPcUNFMGtKWDNUMzhsTE9VaUdTZ1NUL3Qx?=
 =?utf-8?B?eXJQa3plNXlVejVOL1Zoa0J5OHRFbzZYWllsM1ZJYU5uc2gwZjdwQlZ6UGhT?=
 =?utf-8?B?cGE0S2xJU1RlTTN2OFdhcHUrZmg0NnNrZTdzSWZJbk8zN0RtUjhXNSt0U3Zv?=
 =?utf-8?B?V1VDWHVkaVJNRW9wbUhxZjRja2V4K0trVjBMdjVGRllyekhLQlg1a2ZJUHNr?=
 =?utf-8?B?UUV2dkZDNUVvcGpNWGI3bjZqVytkZEZuVUptNkRwSTBZVzYwN3JMaUQwNlAv?=
 =?utf-8?B?RE5YK3lYRFA4dGFiNEdJb3I5QUF0M0tnTlA2aFVJOFVEVzlUaUZtRllUZmUv?=
 =?utf-8?B?R2VxQndSenlkMEdZUVBacHM0SVFGUFN4eEMyZlZRc2JCL3UzV0tQOUZIZFNn?=
 =?utf-8?B?bytWTGNFY0RBdnQrQVUwQm9nRkpra0dwU1hnSnlBaVBROWhVYnovNUJBMVdE?=
 =?utf-8?B?VUc4QlhWYXRxVkljWjBaNVViVHNNYm4vRmtTQUx0VitCMjFiZWNpK3N4eFlT?=
 =?utf-8?B?Qm1CaDFzcnpOdDRuYm5saGw2bzY5QnVPUDV4SFJla2l4NVRMTndENzl4WC83?=
 =?utf-8?B?YXVYVDRjYlpUcS8rc0s5K3I0T3RyVGROMEpJV3ZNbkpscFk3ZENGcGlEL0F5?=
 =?utf-8?B?QmF4K0s4VndmK3l1ZitVeFE2RTh2N0RGNWNIWERRTllYTGlqZFdlaTl6YXE0?=
 =?utf-8?B?YWNLL0FEV3VmUHdGbmRzSDVpVVh0ek9JS0h1bkcxMkQ2RHJnSjZTVDV3Zmk0?=
 =?utf-8?B?WjcxSXpobVgxRk9ZTXRuRnhXT09BRkVGcjMxQktBZ1Q2Q2NOaVcvY0U3UG1Z?=
 =?utf-8?B?YjZJSll4S0dzL2kzbERTWENDdGJFM0h6QzBTMDNsY3YyT0xsdHVtQVNXTzRI?=
 =?utf-8?B?bXBQaFZhMldZZzR5R2MyT0h6MkFGN1VjUUZ3QytqYVV3eGxMVUw0bnpEb1Rr?=
 =?utf-8?B?TWVvMTZJZzBmRHh5eFhCQ2MwS05VcVNRVWErN3NleFNwWDVPaG85MVJuSUNq?=
 =?utf-8?B?LzB5Nmg0UW45WVlwRnZVZlFiYUN3M0Q2Rk5mUitRbzFNcHRqVTBUNHJtZmVN?=
 =?utf-8?B?c2dEWGJIcGZVSTZPWE03TFJvYmYvK29qUjJPVFowbGRrMHg0N0RqZHlKUkJU?=
 =?utf-8?B?bnVvUkx1QTJ6S000NWo4UFR1enBrS3FNVWdMY0NPU241MmVCbWsxRmpPczF1?=
 =?utf-8?B?MHkzVnVaa1Jmb2U2QkNEQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3B0LzNUWjhDcFRjLyttZTUyTnlBNG1KcDdEbnNYVzF2dEt0Y1ZNeXNqSS84?=
 =?utf-8?B?QmQremFpUEoxMVVJS3J4enJjdFZZUTVQVUw5ejRTS05HR2hJeHl4RHlaWHN2?=
 =?utf-8?B?ZVVyQVpYZEdRbW1LMlRlcU1laDZoMDJHNG5Na0hqOXVEWXluRXhkdkdKb05O?=
 =?utf-8?B?Snl5TWFpV1hJYkNNcG1oTHZzTG9OdzlQOEc3eWZWbU5TclpydHFkTklIUUFj?=
 =?utf-8?B?ZHNLZC8ycDBQcEpwcEhrdXNSL3VoK0Q3NlFvSUZEWktKOHdUMDZhUnM5QkN6?=
 =?utf-8?B?MTJmaWtzNThobS9LTmRYanpEc1czQ0NuclVPVGh4WVJwdnFEb25qVlZaa3M3?=
 =?utf-8?B?UG5OY1pQdm42YXVsS1BsallDd1NPSXcwd1pGWGp0d3ZwaHA2K0U0V21MSkZB?=
 =?utf-8?B?RTdrQUFoUW1GYVVNNDVjSXp4UjZINGtUTVBvaEFnYTFxQ1NvMEpSektLNUlY?=
 =?utf-8?B?U1RXR1Iyam1XTXNuaHBmQ2pLSzdaL01GNTBQeGFQZ1o0YmRJNHhtMEdiSnNv?=
 =?utf-8?B?ckFZdnJENG1GdkxYM0RTcytKNlcrOHFSeFhockJ3K0E3WGc5M1FEa0NIQWJR?=
 =?utf-8?B?amRFeFRHdExWWXJrbXJMU2ZZa0k4M0prK0E3VWh2TTFFR1BJWU5MTkNRRjVT?=
 =?utf-8?B?ZFdiVTNSMXhPdzhFcThTUzRMdEQvRktYMWl5Tmg0bG91WWY0Y0RLUElLNDFC?=
 =?utf-8?B?N1NES2JDWUpQVmFYaUFrZ1dOV2tjdGM0UGpnY2kzMytHZHJBMWxxSlRzS1dK?=
 =?utf-8?B?ckFwbTFSUmM1bVJOS05uajZEcEdwVzlic1ZTdFI2MXVhVTZUcTFBQkVQZThU?=
 =?utf-8?B?b1ArTTZlYXVGM01vZ2J0UXp5TVhtZHNtNnFod2habk9Xcmg2dEZVUWtEOFFN?=
 =?utf-8?B?RDZnQ1EwSVU3MHNRTHczdU5lVDN0ZmxoTjVqdlFzRnI4MnpCYlp3QVFtTFJq?=
 =?utf-8?B?WVZ2NG1QeUtKa2orRkF5M3plK1VyYnJNSGtDeitsQ3drSjRDcjE5ZUpCVUhZ?=
 =?utf-8?B?WnZUQ1ZZMGZnTk95akFsMTZkbUJqSlllMG5GT2s1UUNSdWUycDhJNDllSzVr?=
 =?utf-8?B?cUFUT2lpbU9renZlTUgyanBrd2djRmdkUnhES3NidXNndEU2dHNtSDBJbFlU?=
 =?utf-8?B?OFdvL29Hek84elArNzArMlpaWnNMS3V4SHg5ZFRHckgxdGlqcHlmTlZwaXFQ?=
 =?utf-8?B?bThXVlpBK1hDSEMxOFFMSXZldHVWVTBXQXpocjQxaTZTL2twV1Nkb1U0NlFi?=
 =?utf-8?B?SUh0SWxiSUV1VC9HMVNubVVuaXdrL2ZTQThVUU53RzZieDNIcnoxbCtoNkIy?=
 =?utf-8?B?KzJ0YWxaVTNodnN2d3k4bEFGVkVtNjhSc3p6c3JrSjJXUlpReHNpNHlIQkpF?=
 =?utf-8?B?b0tOKy80VVBZQzdRdXNPTytrYThoVURQK09PVDRDd3k0QW1odmVkd3V1RjRD?=
 =?utf-8?B?dzd3RWdlQ3ZZOVJUOTJpZmtEakpqV1VNYmZCN2xwMENUeDFheWZxNGJvd0lF?=
 =?utf-8?B?SGxucjNhRm9KTkYwV0JWRFV2dmhWNkMzMk9KTTV3RmRoeFg4cmVXQjJPZnRx?=
 =?utf-8?B?b0N5cGFwUmdhd3JQT0lZajgzSURPS0FmMFk0a3VMUnd1VHo3T3BBQU41d2Jz?=
 =?utf-8?B?OWU0S2N1bmZ2TG5NRFd2YnpGclhSWjNHV2J4OThJUkNRNmZ0RkVQa2E0V2VP?=
 =?utf-8?B?VmxyY2cwb2xyWkNyRWNEOHdzSC85NlhxMjhKUUwvMmhLUVIwM0dMZGd6RjVW?=
 =?utf-8?B?akJGZk9PcGZlcUg5elNoMHZ0a3MwL09KYlhORjgrVm9ybXVqSVdCOVVFTVZC?=
 =?utf-8?B?NzhNV3VmUEJiMGxrNTNRQ0dEUEZzc3pWbDZPSHo3K1BZa0x5blJyd3BueUFG?=
 =?utf-8?B?dWZGcHNCSGtBYTlHOUt5TXE2UDBSN2JwN25LWjJ5SExQVlZ0YXpVQk83am04?=
 =?utf-8?B?RDgvZytmR3BycGZJUzVNSHRmZ2JnMGpIRGx4bVlkQlQ0N1M3bzVUc2lyaTlZ?=
 =?utf-8?B?aW1VUTdSN2ROZVB2bmV3a0VIR3RkSllXTzloTCtvMzJJb09adk0xbEJvMmM4?=
 =?utf-8?B?RmZTdWJyZFMxc0pQYi8zZ015eXh3WmdoOGk4NHM0UVJFM1FTOXBiUkVyeEpB?=
 =?utf-8?Q?oodM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6153fc99-2fd1-4872-5799-08dc638fd47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 12:20:57.5717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IqWDiml9OsrkVsQJ48EyZVyDJokS42tW/KMdX/BcylJKRR1k2Oef736wPnMHNqXqw+tZxTf7fc61JyTsbrBomg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8025

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjTlubQ05pyIMjPml6UgMTk6NDENCj4g
VG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IGJyZ2xAYmdkZXYucGw7
IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGdwaW86IHZm
NjEwOiBhbHdheXMgc2V0IEdQSU8gdG8gaW5wdXQgbW9kZSB3aGVuIHVzZWQgYXMNCj4gaW50ZXJy
dXB0IHNvdXJjZQ0KPiANCj4gT24gVHVlLCBBcHIgMjMsIDIwMjQgYXQgNDoyOOKAr0FNIDxoYWli
by5jaGVuQG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBIYWlibyBDaGVuIDxoYWliby5j
aGVuQG54cC5jb20+DQo+ID4NCj4gPiBUaG91Z2ggdGhlIGRlZmF1bHQgcGluIGNvbmZpZ3VyYXRp
b24gaXMgSU5QVVQsIGJ1dCBpZiB0aGUgcHJpb3Igc3RhZ2UNCj4gPiBkb2VzIGNvbmZpZ3VyZSB0
aGUgcGlucyBhcyBPVVRQVVQsIHRoZW4gTGludXggd2lsbCBub3QgcmVjb25maWd1cmUgdGhlDQo+
ID4gcGluIGFzIElOUFVULg0KPiA+DQo+ID4gZS5nLiBXaGVuIHVzZSBvbmUgcGluIGFzIGludGVy
cnVwdCBzb3VyY2UsIGFuZCBzZXQgYXMgbG93IGxldmVsDQo+ID4gdHJpZ2dlciwgaWYgcHJpb3Ig
c3RhZ2UgYWxyZWFkeSBzZXQgdGhpcyBwaW4gYXMgT1VUUFVUIGxvdywgdGhlbiB3aWxsDQo+ID4g
bWVldCBpbnRlcnJ1cHQgc3Rvcm0uDQo+ID4NCj4gPiBTbyBhbHdheXMgc2V0IEdQSU8gdG8gaW5w
dXQgbW9kZSB3aGVuIHVzZWQgYXMgaW50ZXJydXB0IHNvdXJjZSB0byBmaXgNCj4gPiBhYm92ZSBj
YXNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwaW8vZ3Bpby12ZjYxMC5jIHwgMiArLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwaW8vZ3Bpby12ZjYxMC5jIGIvZHJpdmVycy9ncGlvL2dw
aW8tdmY2MTAuYw0KPiA+IGluZGV4IDA3ZTVlNjMyM2U4Ni4uMzA1YjBiY2RlZTZmIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
aW8vZ3Bpby12ZjYxMC5jDQo+ID4gQEAgLTIxNCw3ICsyMTQsNyBAQCBzdGF0aWMgaW50IHZmNjEw
X2dwaW9faXJxX3NldF90eXBlKHN0cnVjdCBpcnFfZGF0YSAqZCwNCj4gdTMyIHR5cGUpDQo+ID4g
ICAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICAgIGlycV9zZXRfaGFuZGxlcl9sb2NrZWQo
ZCwgaGFuZGxlX2VkZ2VfaXJxKTsNCj4gPg0KPiA+IC0gICAgICAgcmV0dXJuIDA7DQo+ID4gKyAg
ICAgICByZXR1cm4gcG9ydC0+Z2MuZGlyZWN0aW9uX2lucHV0KCZwb3J0LT5nYywgZC0+aHdpcnEp
Ow0KPiANCj4gSnVzdCBjYWxsIHZmNjEwX2dwaW9fZGlyZWN0aW9uX2lucHV0KCkgaW5zdGVhZCBv
ZiBpbmRpcmVjdGluZyB0aHJvdWdoDQo+IGdjLT5kaXJlY3Rpb25faW5wdXQoKSwgbm8gbmVlZCB0
byBqdW1wIHRocm91Z2ggdGhlIHZ0YWJsZSBhbmQgYXMNCj4gQmFydG9zeiBzYXlzOiBpdCBqdXN0
IG1ha2VzIHRoYXQgc3RydWN0IHZ1bG5lcmFibGUuDQoNClRoYW5rcyBmb3IgeW91ciBxdWljayBy
ZXZpZXcsIEkgd2lsbCBkbyB0aGF0IGluIFYyLg0KDQo+IA0KPiBTZWNvbmQ6DQo+IA0KPiBJbiB0
aGlzIHBhdGNoIGFsc28gaW1wbGVtZW50IGdjLT5nZXRfZGlyZWN0aW9uKCkgd2hpY2ggaXMgY3Vy
cmVudGx5DQo+IHVuaW1wbGVtZW50ZWQuIElmIHlvdSBhcmUgZ29pbmcgdG8gY2hhbmdlIHRoZSBk
aXJlY3Rpb24gb2YgYSBHUElPIHJhbmRvbWx5IGF0DQo+IHJ1bnRpbWUgdGhlbiB0aGUgZnJhbWV3
b3JrIHJlYWxseSBsaWtlcyB0byBoYXZlIGEgY2hhbmNlIHRvIGtub3cgdGhlIGN1cnJlbnQNCj4g
ZGlyZWN0aW9uIGZvciBvYnZpb3VzIHJlYXNvbnMuDQoNClllcywgd2lsbCBpbXBsZW1lbnQgZ2Mt
PmdldF9kaXJlY3Rpb24oKSwgaWYgd2UgZGlkIHRoaXMgYmVmb3JlLCB0aGVuIGZvciB0aGlzIGNh
c2Ugd2UgbWVldCwgZnJhbWV3b3JrIHdpbGwgcHJpbnQgb3V0IGVycm9yIGxvZywgc2F2ZSBtdWNo
IGRlYnVnIHRpbWUuIA0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4gDQo+IA0KPiBZb3VycywN
Cj4gTGludXMgV2FsbGVpag0K

