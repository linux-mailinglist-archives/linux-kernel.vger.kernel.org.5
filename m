Return-Path: <linux-kernel+bounces-168467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A3F8BB8E7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A1D1C22AE8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D0510A0A;
	Sat,  4 May 2024 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DfHmatmb"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2F182D2;
	Sat,  4 May 2024 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783312; cv=fail; b=NsyXpqoKO8GW3moiB+JbxzijlgFrym8Uy/g4GS0cAQL6AKjFShu2QKBLFelvubfBYKgkcr78aMqof0pA0RqPPi7eHA7jfPdzePBMBhSLSAlhk2CzZVqDFWFvHHFcPfxJPLHMHA7JKmz29bGnx1oP/bZPjO6usSQCNSqFLPWr/Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783312; c=relaxed/simple;
	bh=tLECtkkW+6QyL3PUhJSggvizcBd75BZSDPmIpKuwP5A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fP4UZBzEYnhg8RlIAb7raKqgItxQAJJOfEun/EkKU0tk+VjtlCwVWqGGd5fSwep8QK6GFGGov+akTPoU7Ndrih4suaPvMaLzeOmDdggjNNKsFtuLSfwMoKsBEG9z894ZJVijzFXtDYyIubAVUqQWyh0iSCuL/sncCmRx9zKWXjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DfHmatmb; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW8pUuRpggT5lWnNz6lbJB3o+3falTynVm3rQVZiSdwUSLvvlaYbhYXIbOMrLeRdoJcPvt5i9jxo1pl5l/TOEC5cr3C5vUQCCBs7W6xqoA9I3vvzKUqkoa7RL7Bxd7FOmj2rVlgrPoJVNTuy0O5hqWx3vknXnl9N0JD736LoFHbc3jUU+kjPeLhP9e3njGZNTaaEkRSf7GTDbJ+6vlnRyvMf1n0ae/5CscrXq45t3l4kck7h3/z+ayrCET+sLPxYXNXgzFNZwf0/ajK5x3YhSkCw5vjlFxP+o5atSRinBTu/+HmFW6hqg08+0t51yomxI9wxKa+Ls8IpXYWflq8WLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OzPJY6MhrKeRBwMJ4c5Jo8TCBagIjPC/f80OtesPVw=;
 b=aYUkEPnumF7JxEkZGZFFI82vcSSh5/+7xo2f5cy2Nzx+4o5eoKdRFiA+mafQwk5WidCZh1jOddDjflSfkovCABQa4hpLGfT17Ysov7LqYfLCjhDnsImo/CZQ8rtGaDDPmMUK084FJSGDuFwS40s6KjtG/dBhl9iw5RfuPKsuYtqyKpE+zc2muRXleDg353bt6m6hQGBhLh82JNdFdMaOzfZFlQAea1IacfdNIF8IxgcwaLvs4vQj2kfv/bFhozaSNY0G07MvnHAHzeOa9IFa5wQq8eyzXshIVdlaxrqfci53JOsruXdswJAqz6dl3RFKzinsP7w9rjTPVTGuKccq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OzPJY6MhrKeRBwMJ4c5Jo8TCBagIjPC/f80OtesPVw=;
 b=DfHmatmbQepZANyrzQCyvP+CLDpqIXdeQgedaZyHqZRl7JjV7WS3OoVVMCpC5+cD5AloSsTHi6T0AyGKk3IvRzTL5L8wwVuj9wxibX+Rm/xDM3kMQ0MWlIRonZwzOO0Ndv6g+m4jLJqWqEebnJ26NINkHepsxg/qmVnkGKEUkV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:01 +0800
Subject: [PATCH 08/18] clk: imx: imx8mp-audiomix: remove sdma root clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-8-f7915489d58d@nxp.com>
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
 Shengjiu Wang <shengjiu.wang@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1096;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Vumz2WhUTnYw3jXu6uujQOaYqm9Iyxa5sjcrHowRiQU=;
 b=Bki30aQJD3H5s8X8NOe1wqAOXxF0N4CbJPsoqRYMsECz7I6lTLFqg4wyWHDrn4ahF+Ue12WYH
 gueKnqzJccVCpJJATjuS+Z3n1ooxAJUeNkMtwtOBrCW9ZBbiz/Uujcj
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
X-MS-Office365-Filtering-Correlation-Id: b631d9de-f169-4727-d11d-08dc6bd2fa62
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1dnYU5ZdUtYZitNWVhxWmVSNE5yelRZQlJCcXlEeE4yZmEyd1Q0TmhPakdT?=
 =?utf-8?B?aHQ2MHAvTXpQNlNJeGFlaGtDdkZuSHhzWjZWMmdUb2FNd3dFR05ZNkpJNmEv?=
 =?utf-8?B?R3Y1M2g2NHVJV1RWak9Uc1Jta3JteUhIV1gzd3FkU0dDaEpTTmhxYW1TUEhX?=
 =?utf-8?B?TmRyNVl5RWtoQmNHM1hnQXZoNURCNkZyUHJ6OW9nSXF5ek9Ca0l0Q2VDblZt?=
 =?utf-8?B?Z255d3dabkwrNmxGdDlYTVdxSW5vYTZ2SVprWEMxWWZ2S1I5TkV6UXY1aVZk?=
 =?utf-8?B?UFhJcnVuNDBqUjNLYW5sRFVNZlV3b21EY0lnbFFwWmdvcFhDc0JscjNaRVd5?=
 =?utf-8?B?ejI0TGxuOTRmR2ZNRThFVDlCVU5kUGg2YXdtQmpqeWxhcEJTR0s3TXNwT2t2?=
 =?utf-8?B?UGF5VVpiemd0a0crSUMyeFZMM1pLVkx3eTdkZmcybkJOd1hSTDlJbXcxa2Uy?=
 =?utf-8?B?aXRlbmpMdGQzSUt5a2lzWU9iQmtYemVoZkE3TjM2OW5rcHFBbzg3RzZyRXJD?=
 =?utf-8?B?cW9OcEpuOXZ3clNrMy9rTk5vRGRqbitOUmxKRkh5MWQ3dVRpc2VXN05MNjFR?=
 =?utf-8?B?OGQ4TUZkRWxLMHRCdDhqTWhFa1NjSHpYU0doWlNDTDlFQmdmRUI3U3A1SFVI?=
 =?utf-8?B?LzRpck04bGhrcXhlUERXQnNKdVhzK2RkMU5ZSlVkaVh6a3lvUjNaUXJCSTNT?=
 =?utf-8?B?TU5rKzNkTEFCcmpFendpcTA1dGUrWXJ5bW52c2NzUjg2RkZmSTJRNUdBTDMy?=
 =?utf-8?B?S2FGb2luY0xvbTNDMUthTkk4dnNxY2RnRDl0bjJtVnkyN1pCcjVJYUx0Mk1p?=
 =?utf-8?B?Z2pvS0FxU2FVT1Ztb2tYRVc4MUh5SWM0eTlQRHY1RExmNHQzaGNiZTRTTUdQ?=
 =?utf-8?B?SWdkaDRFUU15VHo3ZHc3WkpHSnRnV1l1c2xMWVU3VkszMS9qZkdFK2tydmJt?=
 =?utf-8?B?UEtzQUJiTGlSMmpUeHhvOTlhaCtSdkN3VEkzZFgyc1VyREQ5M0ttM3JveHNs?=
 =?utf-8?B?T0NJdmNGOEx1NTVQTnEwa00vaHNHaGpiOHlpZmtsandxT2JhSHlPVmtEZnlR?=
 =?utf-8?B?WlI4VkVnZTlZMVN3Zy9IOFVUTHg4enRTMkpRMDMwTmNjTWJDNnJLU1RzRnhC?=
 =?utf-8?B?Q3ZHMXZIUTVRRmxYdGFtTkM3R1N4SkhyUU1DY3ZJS0lSQW1PSlNvVVExTzRY?=
 =?utf-8?B?R0RKY2EvaHdlbW5GVTFRbTF2enIzN3JBWVAwZEZUcENMcC9VY1AwYU51NlVp?=
 =?utf-8?B?cVU4T1BKVS92cGtYZjQvYWxwNGZvVGNxSnBnTFhBOGRHL25ESjAxWGwxc2cv?=
 =?utf-8?B?R0k3Ulg1NS9iYnhnaEhSR3dqR0VDTVU4U1ZGTDhMdmZXN0lGRkt4REJGMzVs?=
 =?utf-8?B?enJGdFFTSU9DVjFHMXUzS1dPTGtaYmhPMHFudm1ZUG1LSFFVcitLZ0xCc0tD?=
 =?utf-8?B?NVEyN2VsZENkMWFjd0h3aG51dU81dHBUQkdXYjMxZkdCRkxXTWgrMVNmN0tY?=
 =?utf-8?B?b2ZJcmlpYXFOOE5jblQyUVBNQmRpeVNSZkV0eS9tK1lxblZic0VSUDRpQStG?=
 =?utf-8?B?NmJ3RnltNENFK1d3bFBFcGtyd2RqdE00bzNDQ2RpdUhTU0ZFT0F4WUhJY3dU?=
 =?utf-8?B?ZXNGYkFXZzBQSHpkU3owL3piQ1pXY1VNRk03bVhRQmhTUmJ4bmthVW51TVZH?=
 =?utf-8?B?cmdjSXphWUVVY1Nxalh2MysrbjRXeHlIYTY5R1dHZVF5UTRob0x4NGJJcnJG?=
 =?utf-8?B?RXJjUm82ZEpjZU9XWjBwSTZwM3piQmtFQkswb0xMeGJjM2twV2YwUCthMWMr?=
 =?utf-8?Q?A7SdBBIFdDfXwuevALKw13+GJWHPwBLz2Z0c4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXlSYkpQUFZnWWZPckprK3NnZngwM25IMFgxK2IzQW9lajZ5QTdwbDhYTnV1?=
 =?utf-8?B?Z0VrdG1md3d6dkdERjVDWStFMUZRd1BmcTJ5d1FMcUNPTVZWRTlhMUtiSjd6?=
 =?utf-8?B?K2dCbUsxcS9uN0E5RC9UcjZ2RzdHeWg0Sk0xUC8xL0t6eUtwY2JaZHcrdnhY?=
 =?utf-8?B?M2hlSWV1RTVQRG5lSllUcXBFSnQ2SG1Wd0R3bjRqMXl2RlpZU21NTWxFaGN4?=
 =?utf-8?B?bHFrMUdqa0ltbldYN3pNRGJaWTVGdHdyNFd3VUpPOHlkZk9Bb3MvK3pUUm9a?=
 =?utf-8?B?cG5uSzVQM3Fxc0NxTlFwZ0hqVHl2R1pTMjNFRUVFK3JHaFhkV2FrMnVIWTJE?=
 =?utf-8?B?RHc0cGg5VElhc3l5NzJXQlIyTTlJZmlKNlBWNzJOM3dTQmJGSVlEUERNV3gx?=
 =?utf-8?B?KzAzR3FLSXVnRElZZjdXWnRGeDNUYzVsak5KdDhFNUN1UVJUMHI5V3lOaXY5?=
 =?utf-8?B?ZGVySkVIdDVNM2VEZ3VDL0N0cm01Z2JWRW5NeUdHYUdubm1tcXMydmtNRHYw?=
 =?utf-8?B?K1lPeXFmMG1LamJVZjVYTTRCNVc4UWdXdnRSYkljS3pTUy9waXc0OUFPZkRo?=
 =?utf-8?B?UDl6TmRiNUcrMDZNVm1yUGFPenlKQlBDRzIxUXVLaktzdXAyNEpCZDNzRm02?=
 =?utf-8?B?eU13WWFCaUp6U1drQnB5VmU1M3J3dXN3RmxpQzRtaE50TnRweWM4VmhETFdJ?=
 =?utf-8?B?RStqZDJWbzE4b08wNEZPM0xRVUptQ21JbHFsS1NpSU5OWnJIUmltTG04TTQ4?=
 =?utf-8?B?TDVDNGt4RXArU2Y0TzFibHBmSjl1QzJiWG1UWHNwRGVPajdYRlcxZnoxOEJy?=
 =?utf-8?B?VTlIYXhaUkpvT0g1b080dlBPb2ZJN1c1YjZjR2I0U0NyS1hnN1ZGMWJuTit3?=
 =?utf-8?B?Q0R3KzJxbDFtYzBsZHdpQzlCSzE1cXRTODJ3OUZQaC9JdWFyeVhYbGdHWTBL?=
 =?utf-8?B?QkZqMy80eUk3Z0UvdnpGVHljdGowOEtKVDVEOURxSyt2Wk1qZ3dXaGxFUFdZ?=
 =?utf-8?B?T0xtdnVBY0Z3dmY0WFBUS2VFdFdoYkhnTzhPQ29xRHk3TFhIVVkrbFdzVHk1?=
 =?utf-8?B?ZHNWQmRlWkZHTk03NXl6VUlveE1vd0djeURpcHFNVThvTjF0a0d3TjRpTzZr?=
 =?utf-8?B?a2dnYVd0ZmFKYm1NdmRQa3NOVDB0UWt1YmRrZkVqQ3cweUFzL04wQjNkMjlW?=
 =?utf-8?B?WnNvbnhkY3NjdDU2L3d6V3pmNG40S0RuYzlQblVFUGhqelZwTWpkNjNZOXlC?=
 =?utf-8?B?N0ZkOUNyWFNqMjQvUkM5dzFVSDJzTzF3d1FHYnoxMFpnamlKR0k3M2hwTkxI?=
 =?utf-8?B?SE5HSVRhSG9DcXV4bkJNWkpsZlpaNzdOajJLaDI5YkVlbnNkOHExRUZsUk91?=
 =?utf-8?B?YXRiWS9TNkVGejI2MERoblYxZjVqTzdGQXNJR2M0cWdzY1QzWmVzTDliVVZ2?=
 =?utf-8?B?QXNLL0tpME1wcDRhUmtMb203ZmNyVDd1aFZ1cXk1aEhaVTA1MWNpeUpReTli?=
 =?utf-8?B?ajl3MkFHK3JLT1ZWWmR4ZEhPUXJGTXhCaXV0WkY4eDk3dGluTC9qKzJySWdO?=
 =?utf-8?B?QlFOS0llbHhuMVZVZ09tY0IwTHoySDUrWTBkNmM4RnB6Y1Ywa0UxdlI3ZlVu?=
 =?utf-8?B?YzE0S2FXUnUzVjN5b3pEVFpCRDV5WXJJWktMMjRHcEZZL1BLUGJjdktqanFF?=
 =?utf-8?B?bmNndU1jRVA5RWR0TmdUNXUyaWF6S2toQm1DakFaNGFmMXF0RGdxRFppSnlj?=
 =?utf-8?B?aUlQMjRQV1hOcjlYelFCL3lrSUErTXVITTE4QTJSdk5vSWlsbXhKVmtjcmE0?=
 =?utf-8?B?YmEwOXlNcW9JRCs4d0l2RExBbmVKZGppTVB6ZmhNK2Nva05GeGZHeXNzbERP?=
 =?utf-8?B?by9qL3hTTG13b1N4elNqS01kRFlwOWlhcEgybytZOG4yZ2JuK2RUckExK2Qr?=
 =?utf-8?B?WWJyYnpNaHpCVEpyVUd1bW5BejVOdDl1OHF6RHBJUEJJeFlQZ1pyZGNIU1Rq?=
 =?utf-8?B?Rzl0MmcwM1g3SXdERTdSVmRxVEQwUjhaY3JnYkZiZlYxTGVURjZPZlUvZ20w?=
 =?utf-8?B?d0gyMk1uMTRxNFdiYTBBbDF1Z0xpRTF3KzFHMTB1dUZqejk3SEpXbnZZZVB4?=
 =?utf-8?Q?hth4y/RQIbemHgkp4qrGwscdZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b631d9de-f169-4727-d11d-08dc6bd2fa62
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:46.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsUdn+hZVzAKzjjslqizJq6faPB5yzcz67POYQaQe6GR8CxbrXAXV/UN2B3BJ5Zk6D322JM6u/W05Pyhc8Prmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Peng Fan <peng.fan@nxp.com>

There is an issue:
SDMA3 can't work without setting AUDIOMIX_CLKEN0[SDMA2] (bit-26) to 1

The workaround is:
As the reset state of AUDIOMIX_CLKEN0[SDMA2] is enabled,
we just need to keep it on as reset state, don't touch it
in kernel, then every thing is same as before, if we register
the clock in clk-audiomix, then kernel will try to disable
it in idle.

Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index b381d6f784c8..88d8ba975b5a 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -172,7 +172,6 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
 	CLK_GATE("ocrama", OCRAMA_IPG),
 	CLK_GATE("aud2htx", AUD2HTX_IPG),
 	CLK_GATE("earc_phy", EARC_PHY),
-	CLK_GATE("sdma2", SDMA2_ROOT),
 	CLK_GATE("sdma3", SDMA3_ROOT),
 	CLK_GATE("spba2", SPBA2_ROOT),
 	CLK_GATE("dsp", DSP_ROOT),

-- 
2.37.1


