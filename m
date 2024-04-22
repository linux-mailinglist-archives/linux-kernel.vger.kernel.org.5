Return-Path: <linux-kernel+bounces-153948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C64B8AD53B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02F51C208E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE54156C5B;
	Mon, 22 Apr 2024 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MfKDaG7b"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3844156866;
	Mon, 22 Apr 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815437; cv=fail; b=jn3VQLj1K612cotciJTusUbMQ8FbOFqZe0jwZidYVvJf37/hKU9kuSCMDsfjFS3Q1+leBWY/oBa3V3+6c1QKGh7ahIOZ1OEGhgRDDaHoZyvJe2JDQzFs+M57nnOO6mmnZfFnOg7Eu224M9Pvvg96PQ2awUJ1lktTBKzmbnCvLfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815437; c=relaxed/simple;
	bh=dJAbiDUSWBY+fjoWgHPzQLOOO5Qfyb1+YpslVj8SCXk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t9znDi92JWcXJOC7Bcf9Y3dsGlfrNDjFwKtLeCxO05+0XkOOb1LCF8CEWkOnlast7BXNISVcgVzQdkI3f3ieRcUx7JcmHZ9JfJu4/IMf6yqfrEWr3+yVCTfIegUyBZaEpmGwzF4HtABUXlynVow2KDvfhE9ebO0MEjuEbICWQJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MfKDaG7b; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZAQEs07oTVSEhUmvmje7awPgJwLvG+nACUYItwZo0OnuRssZ/PbAZZoPGB6yPANvW0r9xp5hp+WZVuh8QVHUcqMvYiRGuN4OnGDhzaL/DgxU6JnRoKE48K23Obw3QXBgTc4Al0afu+ZaO8plzQV6LSCfPr+1quumo8uazUQik6qMZbXKCz6n6hlC8OknuLYwZ13Yl78vbnxLixO618U51EEhsRYsZ8Whd7+YZAA4hwcaIUdKkDAWyqB0vINOSHomW3NwQu2vfWLtaCJC1yVUuGECuE/73oeTQdTTfeSpG3hh79iwoSFfRwBswmVA169RVxXUSIY1kt+MpoHigSQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifTCt7w8ODFNbdnMIpvs1WO+GTOu+aEeUiJsk86jgAs=;
 b=BEK/zj3ig5iw/egTLg2GBYK0cMHqWOZsbm/ZrhLBBrmYxXUxvCtOadC5XYUeo8oxJG7Jco6JqkVVcU222HIXaeWQdfb5Q6ola1hjORpwl56HBSXCTg6ivCR8uoaRYnrXW87MTlXsNcg0FIDX/OC+nRUELUZBbhFAwnKmqmvjaBiN+jLZ0F1kqIKP9gLt1tyX+mfRKFBxMRgWyvwe3gmkK/KPVdVsi619fUg1R3kbI28goLa5dt9UlfcjSLY4D34kB+UJZIASVGjevFQNScRorsAhEZtXnIXwc+IkbyhSIrBchJlZy4PoDqgd6F2bTZDLaO1CWzX+tU6564vi0kLq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifTCt7w8ODFNbdnMIpvs1WO+GTOu+aEeUiJsk86jgAs=;
 b=MfKDaG7bBAI9UDFheXDIMHKUU3xTDroqS2oInpmyRdGV6y30xxgL9bRn+d0wORPEPhWiYyA7JpSD6NHV9T7LiSaPb1+TqlPBv0+bY/NiOYTAowNCuQZv70k/ZvMiBC1JJiUNq3xsODKSV88AYD+IHk0WEdcRPWoe9cSzJCKeHLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9734.eurprd04.prod.outlook.com (2603:10a6:150:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:50:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:50:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 15:50:08 -0400
Subject: [PATCH v3 06/10] arm64: dts: imx8qm-mek: add cm41_i2c and children
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-dts_8qm_audio-v3-6-680cee731ced@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=1328;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dJAbiDUSWBY+fjoWgHPzQLOOO5Qfyb1+YpslVj8SCXk=;
 b=ahRdjFkcpKeUFw9eWJUvr+WaUsfdcvPMjdBR2xw4p8l4GIuifbNoEK1rPn6xugWHzt48rCiee
 dsHOxkQx2T0BFeDub1ViOG4CdKctoF9lxWIc41monLTz20Tafr/EFDK
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
X-MS-Office365-Filtering-Correlation-Id: 38ee68e1-a5ce-46c7-e32a-08dc6305756d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGwvcmVoRmRvSUdhMlh0dDBVNFFYM01FejlkMG5FWTAxNHdWUlBlYkx1S005?=
 =?utf-8?B?Ujhxd24zalNTdVJFZk9JQUNZYzRDZzBkbkppaW5hdEhSTnVaVUp2NHBtUVZG?=
 =?utf-8?B?YVFnRkJNNU1IU2ttTitQck9MNEMvdmVHZzBGS3djOUN1SVhPWTVDM3JlTEt1?=
 =?utf-8?B?OWlPbXVMZzdQU2lqRlhYNThsc3BDaFlGajhiV3crUHRGR25udExpenZxdXVV?=
 =?utf-8?B?NldYU1NnOVErS1MvL3hsYVUrcGpsRWxlNTBGRk5LanBmdmhUNUxORUR1L0tB?=
 =?utf-8?B?cHVINk10MzhTSjlLRFhaY2pBa0NtMWZtd1JBaVIwWjZmYnFZKzZEYTJrdXNP?=
 =?utf-8?B?MTREUDdRTzZFRGd0MmN4dXNtVkZyOFVhUlF3WHpqUVRkK2NIV1JPeHRUNllr?=
 =?utf-8?B?dWxYY0ZzUTd6Q1FycklaVzlLVytzeDJlOUZxZVg5OUtzYjFQVDByR3VVc0Rq?=
 =?utf-8?B?dHhZLytNd3d4dmtZVXpYSjloSEw4UVRFK2RkdkovaUo3b0hKOXAyNk9xbFhP?=
 =?utf-8?B?Q05XYzBmbW04d0djcEdSSy9wN1ZlNnAzVWR6aHhwNG13N1N0aW9MMTQ3aU1O?=
 =?utf-8?B?azAwcmw3UmZJdllaMlIwOEdMbUZVSkF2NFRPOVdDQzhCRi8rZWZGRWpObTZU?=
 =?utf-8?B?MzJwSkEzYjdIbHpsbXplSTE5OVVNVThFWTBqZGVudi84M2hJSFFlT2JMZEhZ?=
 =?utf-8?B?YjZVUlk4NVJzeStIOFhmVzFycys2M1pOL2VHbzhCb2xZYXpMNmFpMCsxNDBw?=
 =?utf-8?B?L1B0Y2tWOHYra1JUdFFkckpWTHk0dnZqZy9FQUZBM1RpaW1HcUdlOXdST1Ix?=
 =?utf-8?B?cFVZdG5CUU9SNXFqemNYaDdsMWlvNXlnZmhOK3cwZU1oYlJ1aTVkampZaWlZ?=
 =?utf-8?B?bTdvSTdKUlB3RnlnM0dDN2Q4S0h5NENWUlNGT3RpODJKcTVqem5oQWp5dDNv?=
 =?utf-8?B?WlNKSXUrd0hLVEZFUTh2bkIzZm5tVnkrNkJ5K0RsNldCRDRaYlQ2U1gwR1h0?=
 =?utf-8?B?MjlnQnlTTkVmYW0xcGtEWHlha2IvR3BDK0ZIYjRUZVdDU0Z2Z3BSYmtKdUd5?=
 =?utf-8?B?ZzhMcnpqNkNtZUc2Z3lmdjN6V2dZaEVwK1ljSzFKcWx3cEMvM2k3aDIvTERW?=
 =?utf-8?B?NkhETVQ0UUJCMjM0YU1DcmFPUWhOeVlWSFZ4RFdXdWtlYkQ2bno0Z0FkMm9J?=
 =?utf-8?B?d0d1U1FwTWRCZnc3dGx5V2wrZlprTzhLYnppTXl5SlNQMG1LSnNLOENCd2V1?=
 =?utf-8?B?UkMzcHVVZE92S2lXdjVaVFNQZmsyU28yRHlZbzhneE1FSVFzUERjNERlSVc1?=
 =?utf-8?B?Qmp0ZEZoMk5iaUhXekh5ZXBqL1MwUGFwN0RyZWZEa0p1emlDUEtBVm9aTjFE?=
 =?utf-8?B?RGZUeit3MDI3ZjB4V2RuekFtc3BLYkZnR3ZoZ0tqdWJpYnRQUkg5eWVWeEpY?=
 =?utf-8?B?VlVvalRSbG9XcWVnRkxaem1salNJeG9INkVQY0VWZzVhZnYya0lvbHFmeTZq?=
 =?utf-8?B?OFZTWWo0NFZ1d2hiWVZ5ZHhiVURIV2ZDT2N5QTdMY0dOYy9nUWRxdnZ1YWF1?=
 =?utf-8?B?TVY4d1JsVVpvZC90MTh4bXFjUjdtK3pCak0rOEFoY1kxWGtEK0F6b004MVAz?=
 =?utf-8?B?cUMwRmV3ZFhubHRiVnBQZ3pzOGJUeU5mbW9zMjR0a2FZZktTNEIzQlpZRmto?=
 =?utf-8?B?MjZ5K2FHYnVBdjRqNDhseERJSUdDZU5QcGxvYjJCRHlFcU9PM0xUdnkvUVlx?=
 =?utf-8?B?aWJCMWdZeEZvSGFZdDdVcVdxSjFwV2hKRlFZT09zazY5eHY3TFhCUTV5ellX?=
 =?utf-8?B?ZnQ1K2lkaHBxdEdkN1NGZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzZtd2lBcjFIcHNLLzVNYU44bW9vYjVSR0w4MVMyUDAyUSt6SnBSNTlhMlhu?=
 =?utf-8?B?L0ZEZFBHTVdxSCtKTkpPTk9xK0hULzdSQzFsUTFNejhvVnBUS2p1ZFF5Y21T?=
 =?utf-8?B?cVRqTjVMaUJYcjd2bWNmWGVad0pEY3E1WjNDb1R1VVJYWU9SeDV1VGpaN200?=
 =?utf-8?B?TExFamF6WmRoVDZ0OHJrRXBQM3lYZjFJMnRSYXhlQ1M4L2pOcHgvVTNWYmRp?=
 =?utf-8?B?NzE1dEF3QkVMa2dsd3k3RW5jV1BJbWhPcXZ4UWhvK1E4VEtXdEJaWUdrVWZj?=
 =?utf-8?B?bGcvWXhlMUFmaTFmM21hZkFJbUdoOGNaNVVZRTRKdWNmejY2WkFYRlQ1L3U0?=
 =?utf-8?B?U0tIRUVXck5RZURBUFFNVTd0clRWRU1VUjhWV0FrRXcveGppZU1kYk43eFVy?=
 =?utf-8?B?V0ozZElwM1d3c2cwZTZRNkNxTFp1ZmpKWHdSMm5KZmhiV3IraHNVeDgvbmcr?=
 =?utf-8?B?d3FOTnZucGpscWE4RER3TGdZNmZxT0ZmOE9Lay84WHo1OHFWSG1PdS9uWlh6?=
 =?utf-8?B?dTlrdGtZSlBkdkpYTFNCZm9QU1I3Y3d5Z2hPbmR5bExYd2pCU2pSZzc4Q2x1?=
 =?utf-8?B?Y2NEWUxLTWlwSGFSak91UHRqZTlEUXViQU1lU2p1b3VKeTNjTCtSaTR4bUMz?=
 =?utf-8?B?RGg5OHJkajVuaUMxZ2RxZHg5QlBGcXZKTURHUzdwUzlaTjU4MzJzdm9xTGtZ?=
 =?utf-8?B?N1BMRisxZ0hESTcvOE5ERk1UVk1DWnplcUZGQWZkbTVHMXRMcGcrYkZ0UEpK?=
 =?utf-8?B?b2dwVW0ySmpIVXFucFg3SkUxYkV1MlUwN0ZUcVVVcGEyUEhSeEtJeXJ3RXIv?=
 =?utf-8?B?UkZNNWpxc2oveUJSVkg3M2V0WmVMcE4wcEVXZTN0d0hXOVc5UDduSjV6WEZq?=
 =?utf-8?B?MERBZUhYUWswemVPbTBhcTlScHVScXJMenhDWVhKOUlxaStKRnI3ZVJoVkVQ?=
 =?utf-8?B?TU56bWRmeWRsV0J3RTZMYmNHdDk4SXB5RlJMdjJiTUd6TUtlYk9PUnNUNHRT?=
 =?utf-8?B?WjAxZHlYdld3eDl6WmhQd3pRMjZkWWl2U1p3L1p1Z2twWXhkYkVJU3lETUN1?=
 =?utf-8?B?UHRVY2R0S213N1Qrb0VWY1g4cFRzMy83blRlMFFZNHZYZXo0cklxTlRxNVBN?=
 =?utf-8?B?akhkTVptc0wvejdrL1RKY05ibEtUSDZmMU5lakswMkRZTitoQm4xc1lKK3BF?=
 =?utf-8?B?RDN5Q0lsVUNDS1lMeUliUXkwZVQ1c2VmS1V4NC82VmM2Q3FFUG51OTlWZEta?=
 =?utf-8?B?Yi83NEVlK0pKU2ozTmlhVlJKWnRaS2V1bTYrRXdWOVdhZVYrY2ZUeFFva1E3?=
 =?utf-8?B?TVRqeFkyWjhGWmtuMnUzOUVzcWJ3WUsrVzZpaC9WajZteEhSL2dyYXZLT3I3?=
 =?utf-8?B?OE5mZWJabUgzTzZRc2pmUDVTMEJPc1FlY0plVmZRSkxDTEFUcUtPRmZiQTN5?=
 =?utf-8?B?MWtVVk90V1cvMUlWYWJCTkQybXBUWDdJdHp4WHhMS2NPcjNQM1gva29HQUZ5?=
 =?utf-8?B?WmVtRndLZTlOUDRNcUtDY21kcFdNVFErcmpySlJlOXA2WjMxeFA0VGJCZkpu?=
 =?utf-8?B?V3pKY3JSanF2VmI0Ly9SWWdvY0VmOHczWXRHV3NmZ0V2STc5MXMzN2Vudzk2?=
 =?utf-8?B?aUUxSWw0RmU4b05LYkRjK3d2SWJEK3grT3dZUVAvMGllaFo3YXRVc2dEakc5?=
 =?utf-8?B?SDhVUVBJREVicElQTGg3Q1NnaExieFd0M3c0TGFQaXBXdG9oTnJtYkRnbnBw?=
 =?utf-8?B?UlpwN002TTQyVHgzUmVaUmtNQUU5RWd1RWdLYy82bFg2MGNzMzF4bDdGVWND?=
 =?utf-8?B?dlFjRUkzM2lOUyt5d0Y1WU5xNDNZZjJ6VllEMnEyYnBiQld2WEo5VmNTN3R2?=
 =?utf-8?B?VDZUM3dxRm1DVXphK1ZjNnJId1ZqNnlWckdRYWRXTUROVHVvQzBKaTZnNC93?=
 =?utf-8?B?TTFiNTBUVURuLzZIUS9hU3RySjBYR01mYjRlUjYvNWV1TkNqeEtOUEhQMU4z?=
 =?utf-8?B?NHdUdlFESDFDN1UrYzhnbW5GUjZoajM1dkc1Z0ZnTVB3eXlJcG12MEJYODhS?=
 =?utf-8?B?N3FnQUpEdlBXOHpMdFJrRmtZWk40L0RnSXNEc1ZBU1FWMkJEKzZieTFIMHlj?=
 =?utf-8?Q?cQO4pb0BOgv/sZdjtlXV3XR00?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ee68e1-a5ce-46c7-e32a-08dc6305756d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:27.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmTpSE2EexpYOwrFniE2g0mJb1fb8Ky1KBqD3y8SSrJzMeDsaK6C9ttiOREKSAIXdOuFxRHLmPjHYtlAazwalA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734

Add cm41_i2c and devices under it for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index dc1dcc5b25e80..3ab2fab7f7fa3 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -221,6 +221,26 @@ &sai7 {
 	status = "okay";
 };
 
+&cm41_i2c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cm41_i2c>;
+	status = "okay";
+
+	pca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&cm41_intmux {
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -352,6 +372,13 @@ IMX8QM_ADC_IN0_DMA_ADC0_IN0				0xc0000060
 		>;
 	};
 
+	pinctrl_cm41_i2c: cm41i2cgrp {
+		fsl,pins = <
+			IMX8QM_M41_I2C0_SDA_M41_I2C0_SDA			0x0600004c
+			IMX8QM_M41_I2C0_SCL_M41_I2C0_SCL			0x0600004c
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QM_ENET0_MDC_CONN_ENET0_MDC				0x06000020

-- 
2.34.1


