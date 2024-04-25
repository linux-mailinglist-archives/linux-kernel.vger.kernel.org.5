Return-Path: <linux-kernel+bounces-158810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3518B252D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB327283277
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32E14BFA5;
	Thu, 25 Apr 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jo3L/YtI"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459E14B081;
	Thu, 25 Apr 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059303; cv=fail; b=eFdZCL84aUylNUKzVUGS4pbWzDMZ+N6lefb1dTGUJX+vY1KrU5pF5goypxrMU1YOGd9KSGy7M1JmgpcDBJyNlLvGl58ewWBymk+fb4UEOh/Gj5MEDhQj6omZtB8NxFg/38mqHa0PmTLe/mhwMVL4CshALnQaZDEmTAEdyTkmfno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059303; c=relaxed/simple;
	bh=N0RdEHUZsI1zzW6nCuPZ4hZFLMrkfmr6Old8d5fO7aM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JLUEks/odvnyQCeG1AikIVtIsSoEAciVbvIflqdNbSinky6e+U/sJa9vx8j9eu/+HoRSolyt1Od9oNxkCtMGsHyd46IJkZYmUTuxSMimpQIbqe/+8Cc27RDYpOz+4CnZ7hayGzGMkdqpHweAH71vRlrwQhUOHUrqoRfl/fLm4gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jo3L/YtI; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLdY8Tc3XJJwb66s3thHHKDZV4sgPlW8dDEsfy/3zzZHVKBz3kIFThDcyGM6oVyGiaM6q5WFudbC7osmjxw2kz+eYQnw17kpTFnEHSfC2Sndmw+4nkA2iuzjpITWBdTItMSXNxCGQxd/xH/5WL/PY/DqTJIRc3UgXP4SI/emJI2HxemxKaKEO42geojTZDrSxk6cKf539nTcpWecUBN0Sm2JjfzhmK0XWnnYzmuWR9fssKgTtOxCggKfMewFujFFbqwoUIx9dkb7fCFKhLQp4eLzt+oWUkW+5Ot4Jlrx+HklkuT8T7pVoO2zeL5StZ5xnfPGgtLPUL3pkOt6lKboiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7rGWxaI5aeMHq6ZQYbO3rxp1eHNz45A7eYB681GZT0=;
 b=AqlHw0nBDHXS5pGV95Ss0IBXNam6EjrrjpfD0pv8wXETOwKpbDzmH45AXfCtkVllK7sINkebphoMF4kOHEFW872+xIxxBoCaMVSlTXj4xhQtVhJgY2W5VDRcXzc1F0UxTHmfjA5xi6orG0a+EexVzEPl2KC0R/PXYKysFY1OSMOsZVht2IPCwGVyvx/2Vx2uXXhT7Ua96wADSSmKgPd/LZpwq9x98TBPiVAnqqgPXXumRc5JW97DG/ymMxoL1jBYa1N24JNhYCTOTxsVnUhMZs3hLAG1cdGZeieMHYAG/FpVmcJd4HAcFTLM4kHzDIrdjhyfiBwMPjsUuDEdBSGxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7rGWxaI5aeMHq6ZQYbO3rxp1eHNz45A7eYB681GZT0=;
 b=jo3L/YtIaAWRlAKBtYDpJSXpfwsPuTt7TdWHdiIb/G3YNG2W+v4XtpmmiuKh0Mer6ao7K/kJVm3+DEudZ5MTiJoVvkTfuPKtC+uvjbMF7LvdSOzemrthPAa7Q3DbvT/ydHz2gpC/LOFwddkckjCmZ/9TLvDt/BX8YcL5OUTubp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 15:34:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 15:34:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 11:34:41 -0400
Subject: [PATCH v5 1/3] arm64: dts: imx8dxl-ss-adma: delete unused node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-b4-dts_dxl_audio-v5-1-46397f23ce35@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714059292; l=949;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N0RdEHUZsI1zzW6nCuPZ4hZFLMrkfmr6Old8d5fO7aM=;
 b=T5AcfxOJ5InSZLwVuoo7z9woSEQiWJTuoM/oY8ndrXDkdeje2KOakusvu5TIs2RQ5sB+DNZ6+
 82LixcNshEEAVmPP4Ldd+h2h576kJ075iXI+6uH8+fd/dJQEsRKSpyC
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e6cff1-5d1b-49b5-49ca-08dc653d4417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1RYNWw0eVZ3YkRzOEtHemdLOFcvZVFTYUJyWmNKS0RlV0UwSkNKVk10OXVp?=
 =?utf-8?B?Wi92bFE0cnNCdTNJTmNqYjVBRUhnQXRsaFdCRndnL3YwYkcwNGZIR1ZxZ2JP?=
 =?utf-8?B?TzFpcGx6SzcyRnlrdU1YM3hCelJqUEVEVTYxUHA3OW1IdHg0ajhaVHVqMHd4?=
 =?utf-8?B?VFhSNWw1cnBLS2xySnJ2K2Y0ZEtnYWFqblNRZ0JBTXlmTnRHQXhUVEY3ZlBq?=
 =?utf-8?B?blh5eDk1ZS9CR0YwMUEyNTE4YjNIQTJwSkFpQUYxYWIyTlg4U2RLc3lkN3NJ?=
 =?utf-8?B?VG1iRHdFdW1iaVYvUWpFdG9xRjMwUFpTSG82U1hXamlTdGw4UVM1YUJ2V0Fl?=
 =?utf-8?B?dTZycVJIVzk4bnQyampoeUh1dm5idzFqb1lEczRyR2pWV3hJTEt6ZTJjN1Za?=
 =?utf-8?B?VWFMQ1p5Nzc5OFNQWTAxZFp2QlpBYTlpaFFoQmhsdWxFYjhJZnY0RnBnUzNE?=
 =?utf-8?B?YnNZODM2b2tiMWtwdURtUmkxMGJyZGhlV0ljQTdpZTlLTFVEOW1hejhnSjVh?=
 =?utf-8?B?bEdkOEpWY1A0bGRCaFJkcnlvbTk5dHBWZ2pBVGozRjZWYS9aZkRBN044THdr?=
 =?utf-8?B?S2dXcy8yMHRZK1pPQmpZZTlibnpZZncyWHdaT1pISXFrMHdNSHVRS0syaHFw?=
 =?utf-8?B?QkZMQ0Z1UWdVZTQwWkxOTys0QVN3Wkc2RjNtY05MQnp3ZnVKdjFVMFN0UXpZ?=
 =?utf-8?B?R0prMjdlaGhUQk5TS1J2c1RKQUc5Qk5VWlRPdEd3M0t4SjBoeHJaV3RmWDhr?=
 =?utf-8?B?ZU40MFF2T1RQTFd5TU1UUGw2MnltZkxTN0R0Y3oyTHpCNjUwNTlrRmRnZWhK?=
 =?utf-8?B?YkRqY09DUGJyUmdFR2xNZW5SZW1hQWRQRUlqOG1IWG90eU1YNzFJSFVIWDRW?=
 =?utf-8?B?SG1XWjQrUFhoVmsxSEhvaS9BS2NReHdOc1llSFRVR1hUcVZic2YvbFMwQ0V2?=
 =?utf-8?B?QkErbm5UcmFCN08wenI0T0RKdkNZSThwOVh0MzNOS1RsTzJ6YXhtQWNScm1N?=
 =?utf-8?B?WHhtVjMrWFhjbFdzTWc5YWhrZ2x1bHZtaHBlaDlVblo3NitLSVZiU3FrdXdE?=
 =?utf-8?B?NTZ5aHBFLzR2QndxUGRsV0VlRUZDVGMwZVBYZURnZWJrU0tFKzRIczQ2cExW?=
 =?utf-8?B?L0luMWxzaGFWZ2NSZjBneHhsbEVpN1ZhU1ZlS3BSZ3lnbE5pbzF2MU8wWTE5?=
 =?utf-8?B?eWFOZ1lBNTFNUkZ3SHlJVlFnZWRrMFdBUTZvY040VDh1K3NvWU15blpnSzlP?=
 =?utf-8?B?QzcwV1BoNzFOeFdmbzlTMlNKRk1pbGhPRmMxMEZIcnVrVTQ1S1doSGdMcXly?=
 =?utf-8?B?c0FsbkZjQlpXTEl5NDMrdVBIaGk2YlNkYm5uNGF0NVFZVFZocmVVbnlWN240?=
 =?utf-8?B?WEV2WndESjZCcVpLSDRzbFduZmRMTCsvb3ZVWjNPNFBJaVBMSGhmdEJGVU55?=
 =?utf-8?B?anRSZ1F4RzVwQWFxcE5QZDlDeVpPSlVRRmpQMlY3MUdRa0t6N2hmWTZnL1U3?=
 =?utf-8?B?SFdxN2VyWEpsWVM1NHhtYkY0SVE2MXVJYWZrTmNsN2VHMVhqRDBiQlpxblNl?=
 =?utf-8?B?Ui84cTlIWjR3bm9SazhKRFN5cXBTWkp4YzBaUE0vNkFYQ1Jtbmd2eUROTmtT?=
 =?utf-8?B?MC9zMUlTQzNvQjV4TXFPUGc3eUtlNDJrcFg2MkR6M0t4aUttM2VsbUgzZjFy?=
 =?utf-8?B?MVk2c0o1dHRyOGJKMEtUTmlqVWMwMHVRL003aC9RK01DOURPMXFqU0pRUmFa?=
 =?utf-8?B?Zmp0WUZkamJWUVFwRjV6REV4dDdZdmJzMlMvSVh5L1paaGxDZTN0TFBPNXhB?=
 =?utf-8?B?RE5nVkY0QjgwQUIydHM1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmQ0NXFnMjVMaUF3bWQ3QTIxUkxSSDVwRXViOWUrWVFmVHkxanAxRXNQd2hW?=
 =?utf-8?B?czRCZGRON0E0anBac0dLUE9tWkhNS2VCVklxR2I5dTVBSWlIdVZHd3piRk9M?=
 =?utf-8?B?WlZSWkxjcDJnTVg2a2ZKME9rL20raWkza3dvOFdIZzNKVVllWWVNT0hVcnRH?=
 =?utf-8?B?akZQYktpY1RxSG9KckdkeEp3UktNTnByVXhoTTFHa3VDNGt3UG5VT1lzM1U1?=
 =?utf-8?B?NVJZTFhKVXlYb1hzNEllTmIvYXMzZlRQTm9hR3d6WTJaY3EyeXhLeEd3N2dV?=
 =?utf-8?B?TmgrZGlneDd6dEF6UWxmdkEycGRnVkZyeHV6U3hwZHdwY0t6Rkp0SEVBaDNH?=
 =?utf-8?B?MmhJUGU1MW5LcUhWQTFGRTkwNGpoeWtzQi84RWthdXRmdnIva1hVTEtRMFpU?=
 =?utf-8?B?VEk3THErUGFBRmpENHltbU5WS3hTQlRoS0tDVkp5UGpMaFoxd3N1bUg0SmpT?=
 =?utf-8?B?R252RjIrdGY5aHhXdzdkK3diVnptdURLWlhqVTZmWU1TeksxWkVUWDdHUWI2?=
 =?utf-8?B?Yll5ODV2VG4zOUVBQmo0bmJEemZUZUpOSmNkQXprNjVwOU0xeHZ1RWxIUjZs?=
 =?utf-8?B?MXJjYjlpVllQQXZaTjJxeGRGUTEvdkJOUEZNT3FJYlhyZjROOTJ4NlJxWlVh?=
 =?utf-8?B?US9MMFJUbVJzSlJpbmIzcWxqRGVYLzFUWHlrQ0d6WFFoQkRlcGZZMHR0NFE2?=
 =?utf-8?B?cnYxaXllSC9PWnUzUlhEeVRsb045a2h6c2g0Z3RsazJDY1FiZXRsazdXRkJD?=
 =?utf-8?B?UEpXaEpyQjNhSnFsRFdRM2l3eWdzMWE3VktUN1A5NlNFUDdGRjVKKzUxeUZZ?=
 =?utf-8?B?a01CT0pCVkxUVVhkQXNjL2pzMUlFMHIvR0JFUTQ2L1dQYW9EdWRxNzFvT21j?=
 =?utf-8?B?cENhRm5KRUpHNjFGZzJCV1dkN2o1R0JnQUpvcWk4UDJOcFR6VmlmaHBYTGF6?=
 =?utf-8?B?b2s4TUdCNHdWaFp4UkNmYlBNOFFXdnVqbjVtd1dsdE5BdG1PZnh1ZUp3aTFF?=
 =?utf-8?B?ZWNpRGd6cjdDWWthbnlqZzVTZm9IR3JaWWE3L3RKc2tzL1dudWVKVU1oUVBl?=
 =?utf-8?B?VGZPb2w0clVoZm5UazVodTV1blJUUjZnVE1qS0RQRnAwaFhKN044RUJyTDVw?=
 =?utf-8?B?d3VpR0NUZmsvN1pITWVzK29DQVlvanVkcEx6TnhRRit6cDJLa0RLMVBySmdX?=
 =?utf-8?B?RDhNdUtBNEI4MjI0NXk4UzU0akpJTE1FV21QclZlVEY2VW9UWEFEK0d4Smo1?=
 =?utf-8?B?dzNjVWloUjdpbWdDQVA2c3ZzUmlYcEZxcWFoUWV4QmJjVUZiU0NCTkV3bU13?=
 =?utf-8?B?cTdmcC9tMjFXT21PN20yd2pDdUtkdDgyY3F3NkNyVGRaZUNvblU5bUN2YlVq?=
 =?utf-8?B?a0w0ZnJLM0NCTEVtcUFDNDVpb3h2Y0pscFhpMTJuc1dHcXFyNmdnUHhNZGhn?=
 =?utf-8?B?SXo2NWNDSjk1TVpxQmJXeWJXZTU2M2tvM2w1QmhLOUxEOERvbmRQc29qbXlm?=
 =?utf-8?B?SWRFby90dWJScVppN2ptYjZTWUx0TUkzeEZFUWRzdXlXaldFOXMrN2NiS1Nq?=
 =?utf-8?B?aWpMR1dyZkhhcWpiUWZKcUhDWTBKdk1HZGFteEM0eUlETjMxK0FUUU5xZzNR?=
 =?utf-8?B?anU0byt4WC9QZHBDMDNsSlZGQkdZZ1JqKytvVzdmVmZGd2hnZGNoU2lQOVFj?=
 =?utf-8?B?NXNocEJFOTJKdFNjK3BUVW54UjB4dmFoRWxQajlPcUFYMUFTVGJLT0t3aGV5?=
 =?utf-8?B?RDZhb2p3VmZxdmxacUZZY0tyeXlsQmZSNGtucjErdERYQ3FGM1h3ZGVPaTcv?=
 =?utf-8?B?NEJEd2tBcjNIN1FuZ2IwcVBMT2p4cSs0cm5FSTRrNVFmZnBKN3dpWjBGYldi?=
 =?utf-8?B?aTllUFBBMVozK0daK0EzQkNnUkt5QlBNRHB3YU83aWNIUEI4d3JHcEgxSGtB?=
 =?utf-8?B?UjBhV3NQZXlpZUgxVVZqbFFzU1E4dmplK0NXS2ZxUXg5UnUzNXZlUlBCVjVX?=
 =?utf-8?B?dTRveHpyTU9xQTZ3akNsSDM0ZE9GY0t6TlRkcmpEWVc2Tnp5ZWdVYVp3eWNa?=
 =?utf-8?B?WmI5ODlSWWp0NFVOMzZIb2N2Ti9kRWRWa1NrYlo4YjExcW9YdHoyTzNyODk3?=
 =?utf-8?Q?Lhuk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e6cff1-5d1b-49b5-49ca-08dc653d4417
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:34:59.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpriBMHqyb6aUxFfHUSdVE4cFrvCxt28yV2rEQwgNh5ZEvz0SNPsJX0lOdfGIsumugRLlcVbMg8n2/CVJd5Dow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020

Delete unused node in adma subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 5d012c95222f5..f5dcdd9405928 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -3,6 +3,20 @@
  * Copyright 2019~2020, 2022 NXP
  */
 
+/delete-node/ &asrc1;
+/delete-node/ &asrc1_lpcg;
+/delete-node/ &adc1;
+/delete-node/ &adc1_lpcg;
+/delete-node/ &amix;
+/delete-node/ &amix_lpcg;
+/delete-node/ &edma1;
+/delete-node/ &esai0;
+/delete-node/ &esai0_lpcg;
+/delete-node/ &sai4;
+/delete-node/ &sai4_lpcg;
+/delete-node/ &sai5;
+/delete-node/ &sai5_lpcg;
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };

-- 
2.34.1


