Return-Path: <linux-kernel+bounces-153945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1101A8AD534
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7962F1F2270A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17F8156660;
	Mon, 22 Apr 2024 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SqN/tcGA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4E155A39;
	Mon, 22 Apr 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815433; cv=fail; b=uaJ6O54WTq7uwkO/znYaQaHrWmboPv8YfEMSWb6kFODKz/Wrud1To4pFzO1GnCyxy+sxem/xG02Q5P3ndunmjLJVZU+Hv7olpOy5fZOMX+uf+SoobVCtT+UuruZ8KaClecTJKNqxwSbNbSZF2hK2URqDbmQ3hgQ7soWmiMCnttU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815433; c=relaxed/simple;
	bh=tBWF0Asy9OzGdJVvC/vxC7/ms1YGwCbPE2oc8x07IEI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oToeO6bIwjNbK0LUdFzLSvYM9Fd3vOY4mHeBktRPJ1DopiAg4mO3aEcJU1XVl7GNEQoFWaejo9hUaSvWoW+cdKUjWMLxvs8iLysKDRlrkX5IULfFz21kemGWx1RiECtV1nQJ/C4GASTz2QLkqCp8QoL/mVRF+L6JrM000DvQ/9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SqN/tcGA; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLehb3kgxWr7ZUXBUkOIm46yoBON6TiDEulOEwjF0T2PLaUfLtqOdw8JXqKrOYdRYljkw8LHA0dpSiAjco6vPRSDTqoAmUiitbg+5LhxNmTirI6X2f42mHFkGA70GcA9GaN2dMgoBgkeV9QOOfXBeqi2i2j6Gvs/ZBpRWLi/umB4JJZI5zFXBtNKwc0kK5Eb07a77nDITpXE1wOgc3hbOLrjTiIyw6AGd7sPhCtNwHT5qnHZ51c8tX2ULaXqZlKXQ8SKcSLHlLEbrR7QBypdLJywNrSUS36D/L0QO78kSoVbcqOHNy0hZF6laPMoTiiJbvmMu5DEM9L4yqLOfJfdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pfVE0FL5EjoFxtfQHO9cTRC/GSrOq8OvMAS142KhT8=;
 b=J63LxxgEwyR5hRKOtO+gWpl0isPWlf7VNdgfhtflo4zYVol0l90LQlCOsU8m7A7v+w0aYwEvWtputffFu1dYScWjyoL474BbJ43lvgBrzji4kU4rin/xrwPNCvh97TxM1txc3jf6po5AxeBtmmaEsEkjcXN/gWf60dZn7hTiyuQuNbw2T0KiGo08xDq/pbI3taXyaKT6giqIG09avC7vUbLOzK9Jf/FR1iTuCOzpXVNbytK5YSddz8BjeF7czSEZu94Y/SB83omyC7OkKMr/Sw3qbAbYwhSDBndnJdeUF2yGHdHL5FvFaJSKY8J4Ia3pdO3hs+UBAz7Llx0PHzTNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pfVE0FL5EjoFxtfQHO9cTRC/GSrOq8OvMAS142KhT8=;
 b=SqN/tcGAiyCU/Cay5UQ/vd6gDK0QvnGk872E2Irgg81OVjvBZJ7In9KtwvpQ/dQIy76lNkD+4Y5HchbmU2H7k2oWcgOx9EVUhNPKEfw1WCfxV74vK/skYOlZiVMtYn98YFJlMQwj/N2NcwCByXmh97WzeZTu/hj5IKJuRa0gJ3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9734.eurprd04.prod.outlook.com (2603:10a6:150:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:50:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:50:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 15:50:06 -0400
Subject: [PATCH v3 04/10] arm64: dts: imx8x: add cm41 subsystem dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-dts_8qm_audio-v3-4-680cee731ced@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=3146;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tBWF0Asy9OzGdJVvC/vxC7/ms1YGwCbPE2oc8x07IEI=;
 b=8mLi9A6VJaaa5NJleH2IR6zhzqt8+LX2oA0pK4VrViPMyIhHVHSNssYkxHXU1FqcM4ceMkf0x
 x9fs6YgNSKYDIUpuqyw79t1e2wsvSJ/dTY9srXS36eGiawb8TdYBPi3
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
X-MS-Office365-Filtering-Correlation-Id: 32937879-f8d7-4b28-fa8c-08dc63057307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkpacE51UWZVOVF2R2RQTVVobkJ2UWFtWjJ3THJmdFk1ZnIxZWNLVWJkT0k4?=
 =?utf-8?B?MzJrNmxpOUs4WFdEbmpjVFZ2QTRTbGJNTnJKVDQxUk81Nm95cU9lQXVYMmxD?=
 =?utf-8?B?V0NDSUZ2Z0kzeXo2cGM1QXo2OWhhZGZodStyZGF1RERjWTl6djBPQ1N5U3lY?=
 =?utf-8?B?WDB0T0xnYmorcXFlNzQySHQ4U2ZGNVcyUHF4MkN2aVJkZGNMQzFob2hRQlBu?=
 =?utf-8?B?dTRDSnJnaG9ldVBsZkM1ZlBEMlg5MlVQckhCRE9EVmxFSEZwSGFnV2V2SGtk?=
 =?utf-8?B?NExHMDU2NW5KelU1Q2tDcTdnbHdxN3RSRE56MWlZMER2NzEyQnRySTVDUHpE?=
 =?utf-8?B?b253MWMrT0dJT3dFbnpuOTlpdXd1Q2hvWEJSMXRSdkxWNHM3NElueE9uZFBo?=
 =?utf-8?B?Vlp2VWFGMXBiSTc0WURpV01DM1pydHlTeGxwVUNhNDlBNnBiUkNZa3dxNUNV?=
 =?utf-8?B?RjkvOTF1dFpmdzZrVURGcDhLTmtOamtqN1dIdVVIRkRNVk5WQmpOYWRvaUth?=
 =?utf-8?B?cElPR0NSNjFCRCt0SHVZWkZyVXJsTC8rV1dQM3FPdGJYMnBNcEg2RlBXQllS?=
 =?utf-8?B?K0VjUkp2NEF3VzhiTktJeUU2MWZ6M1pUbHZ0bzgvNzN1ZU5KeUt3c2JvVDNj?=
 =?utf-8?B?SEsyRlY3dVJWV1dXT2t2UEJFOFFJV2FEdC9aKytNNDlFTjF4NnBVLzJIK0RE?=
 =?utf-8?B?RktWY0FhRU1PQjhmMjVHS0x6Q2ZLUEk4M0lXUlhjVC9ZNFY0bVVoWjJocEF3?=
 =?utf-8?B?UFlVbFlZa1ZiN1c1cXB3TE1idXRaNDA1SlE4c3FZRzZyVTViV28yWDV4QmtG?=
 =?utf-8?B?L2ZOd1BBS3Z2MW5HeUttWGovaFJjMzV2UUNYb3pKRWpVL3I5QWdPNnJZMFBl?=
 =?utf-8?B?a0ViNWxKUEJtOUR4QkRaU0haaUVkbXY4L3BkUkt3QjdXZG9KcXNaV1p5S3dU?=
 =?utf-8?B?Uld2SEg0SGxhbHc4SVRJdXRLc3hpb0cwZ3hGYTdVNzl0NEZpUU5vY01VSWZx?=
 =?utf-8?B?TzQ2eHhTTHdybzBoeTZSWVVhZ1JuS1Fnekd3NUFlakhkUnFWVExidVRuUHpP?=
 =?utf-8?B?RGFZK0dkWXdGdGd3cjd6WVR4QkV4OVhjMVFYTFdUUUIzcTl0bXpBdWNqTkV5?=
 =?utf-8?B?VmtwaTd6RjZkN1NRSzNZRjFOQmFCQmNEWWdwQjYzbGNvcXJRT0pRNWh5eUZq?=
 =?utf-8?B?cEFmV1haUDV1U2NqOFgyWS9xTWVCRUdvOEp5YU82T1FLRU45ZXpndGxoSFdz?=
 =?utf-8?B?TFZwMjJIMGhYK3FDblhxamhWTTMvT0hOcjY0T0tRYkM3azNyQ0JCaUk4NHV6?=
 =?utf-8?B?aEJoVVhKbmJteDJ2N3ZzVnBBZU5iWnpZWGNwMVE2YURXVytaQnJxUTRsQWFT?=
 =?utf-8?B?N1A5eGFHSnU0M2ZmUnpFYnY1b0gydGRoekpzaGhWdmczaFdKWm1TaEJXUVk0?=
 =?utf-8?B?bFIzenlORHBDcHQxUHR3c0Z5eVliMTRFTFE3LzRCb3JVdENLT1RUaGFIalV6?=
 =?utf-8?B?bU5XdDBZaEh6TlpOazlnM1VOcVhyZGQ5MUxxUmxsTnc5cUV0MjdqbFFDcVQ4?=
 =?utf-8?B?T3AvdnpFUnFkVlluMWlSUXpyNHRqSVlPYjErVGtwUm04UEF3NnJDWU9zamFQ?=
 =?utf-8?B?eWYwNXNDMzl4b1JaWENtYkpVKzlIYy9WaWxlaEswd05IVTY1bmtUWU9lVSsz?=
 =?utf-8?B?L2RLWDRFTEQybUI0c3BCNDVINFptU2RoVysrNDAzWThEWmMxQThqd1BVL0JD?=
 =?utf-8?B?MnRIRllHVlVadkFUTDhEVHV6VE9ldXBzaWJKT1RaLytSMlgwRnhJNWswTTE3?=
 =?utf-8?B?WC9rdkE5cDJ2ZzArTWErZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm9UQVZBNXNjclZpVzVZdndxd0hhRmpzdUJnOHNtQUN4MmtSSFJuS2xZSzFs?=
 =?utf-8?B?Zzk2MFNKK3NzUEdiSHJtdmpzWTZtU29lajV6WEM5dkpnRmNUOFpXdFRrcWJY?=
 =?utf-8?B?N1lHSE5oN0VvcnVLQlBmZWlqbkpqTUpTRzFQWjNxYUlNb2taMjZydUtaSC9T?=
 =?utf-8?B?Q0ovQXpEWmttUCtNQjJBRmVjakRXRGdnVlUybkxqOUtjY3ZmOEFIcWwvNTVw?=
 =?utf-8?B?ajBJM0J0S1htc3d6S2k5UHlEbnJDMkh1R2FLNW5aMHo4ODhXNVA3eUM0MFdB?=
 =?utf-8?B?QURtTVFsT25JbFhNbWc1RUFuWit3NzVvYWFOLzhjdDNjMDNsdmxIYkRWS1V4?=
 =?utf-8?B?dStoREEyeXZZL3FqNGFEbzh2dDY1U0lSd2g0MURjMnJLakhHdXFOcFYxRzl2?=
 =?utf-8?B?bGwvSkhJZWg1NXNLc21wQnl4Ulo2Rm5XVmZ6bzZ4N1U3WXZ4K2o1NzJrSHVB?=
 =?utf-8?B?d0JGQmJBN0plUlR5R0JsQjlYUi9oRkdVVk4wOWE4U3QweU5RSlZ3VzR5VHhO?=
 =?utf-8?B?REoyVnlRNkk1VktOQzQyUDNyejJMSHpncFI1bVNDcXJKMzQ4aEYrOFNyYXVR?=
 =?utf-8?B?dTRWdGUzdE1BVlJFNVU0ZFhxc2ZwKzlwbE0yeHFnbUcrWUtWdU9oeUUvZWxw?=
 =?utf-8?B?SGwzQjM0VjdGTnYyd3d1RWpTSEZTZkxDbmJaWUJnbVdUQWdMNk90bUdxUmpn?=
 =?utf-8?B?dW9jSmh5eExZaXIwWXV1akk4UlBYMXc4Z1FVNlJFRDJSZXd1OGxrN1Y2K2Vk?=
 =?utf-8?B?RWNhcVRDY3JJalo4Qm1DOWZFKzM0bUVQZHlnZDlaTGhoYkpNTDd2ZTliaGdH?=
 =?utf-8?B?YkVjOXl5b3k5VUlESjFjM0ZIb1hndG5wT28wczBQSGhtWWRJTEFzaXFHTyt4?=
 =?utf-8?B?SzM2NXhLQWNvN3FGakJUR3RPSlIrRllBZGo3QmlKQTBPMmk0WHRqN0kwWlZv?=
 =?utf-8?B?b3UxR09Zc2IvZEUwL2JraUE4SGl2bk5Gb2hCcVQ1bWE4SzhFUjNuZGJ6b0JR?=
 =?utf-8?B?dlIzZGNuOEpsRGEyUm9nREIyTzY4TWRZcnZqU2U2TjluM1hlSzZOUC9EYVF1?=
 =?utf-8?B?Zi94M0NQZnh2TXJ3UjFyZ0o0TGdibjBOVFJqelE4TitrMTRETUlmS1cwZm8w?=
 =?utf-8?B?cXp4THV2YURudHFwWGdCL1ZvMDYvVHpJeE9SZFpUeHQ2Y0dybnFTU1didzU3?=
 =?utf-8?B?US81OEliYXNNd0c4UHkyeENLR24vRjBaem8ybkpFM1FKSTZwRGZrQlVFMlM1?=
 =?utf-8?B?ajUvK3A1c2dGV3ErMWdrQklmQmo3ei9UNWJEd0kwMTR2M2lUQW9xMUVBTXdM?=
 =?utf-8?B?OHlZbzE1bmtmdjlzSGk3QmVxZFlTazkzV2RqbHpHamd6c0hZb3BITjRPcSs4?=
 =?utf-8?B?R2NNaTlsYUFjUFhyOEZZNFh0Q2JQOU1CTCtlcVZNS3RoVzJmYlBHdkIraEUx?=
 =?utf-8?B?OFpveE9RZ09VUFRMMFUxZEFYNS9RdjRHVTVmbW9ueUVSK015VTdrS2pMVkJ4?=
 =?utf-8?B?STFVSUsvaGZaK3NvNmJEQmp4L3YzaFQ2WFErM1FOclVjRU9iOWpQYVFxSXh3?=
 =?utf-8?B?Ylc2WFpvd0lNSjZLdE00Y0kzY0ltdXg3ajZqSXFWeEhrclFaa3RNdFRxOXdz?=
 =?utf-8?B?STBEV0VvR1FXMXgxTDRQbXdpL1UvS2NnQVpDTW1LQTlrNDJhMGhXampUN2M2?=
 =?utf-8?B?RHRwQk9neG45ZVhmdXFUK0s1Uko4bklmNXBucmZaR0svZVdCY1RIRVZTUXRo?=
 =?utf-8?B?VXZaRlJGVFlHL0tiU3BxKzFRbWtjQmJFeEpPQURYeGhEODFzQUtCNVRlV3Bw?=
 =?utf-8?B?SE1FSmhvSkhoY1REcVM1d2FCSWxHSDRmSU56T3JrUVczRUhmQmJqREt6bFRz?=
 =?utf-8?B?SXAvOEtqMWZrKzcvWVVPMmh0R1BRTWRPeHNvQW9XdWZZRWNtNnlabEhMWVNs?=
 =?utf-8?B?NXN1SEFBL3dRNGU4Wmg1eCtCdFZ0R2NaSTFQWFV1SXo5VGFyWmw4ZXI1dDNh?=
 =?utf-8?B?czQxaWVhMW9yOEtFNzVYL2lmWW93R1BKR3FpM2NYckVtS3RsVld0M1dMc3p2?=
 =?utf-8?B?WGNWd2NkVElEUm5nR0hJVXBYalNNa0hMYmN5SDYvVFYrUFI5SnltM3VuMkxI?=
 =?utf-8?Q?melf5Tc+kkArsGDkE0mqG/d1W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32937879-f8d7-4b28-fa8c-08dc63057307
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:23.6317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+C1eF6bY+k8MqJza22wDe6DDIxs1+g/DTloSIUht4TWTeaLUy0PY+iuYvV3fMpp0HEZfnQSjB3F3QnU8QAOWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734

Add cm41 subsystem dtsi for iMX8X chips.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi | 68 +++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi       |  1 +
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi
new file mode 100644
index 0000000000000..d715f2a6b0378
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <dt-bindings/clock/imx8-lpcg.h>
+
+cm41_ipg_clk: clock-cm41-ipg {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <132000000>;
+	clock-output-names = "cm41_ipg_clk";
+};
+
+cm41_subsys: bus@38000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x38000000 0x0 0x38000000 0x4000000>;
+	interrupt-parent = <&cm41_intmux>;
+
+	cm41_i2c: i2c@3b230000 {
+		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x3b230000 0x1000>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cm41_i2c_lpcg IMX_LPCG_CLK_0>,
+			 <&cm41_i2c_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_M4_1_I2C IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_M4_1_I2C>;
+		status = "disabled";
+	};
+
+	cm41_intmux: intmux@3b400000 {
+		compatible = "fsl,imx-intmux";
+		reg = <0x3b400000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&cm41_ipg_clk>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_M4_1_INTMUX>;
+		status = "disabled";
+	};
+
+	cm41_i2c_lpcg: clock-controller@3b630000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x3b630000 0x1000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_M4_1_I2C IMX_SC_PM_CLK_PER>,
+			 <&cm41_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "cm41_lpcg_i2c_clk",
+				     "cm41_lpcg_i2c_ipg_clk";
+		power-domains = <&pd IMX_SC_R_M4_1_I2C>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index da49d4bad32ee..96a940c6046d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -546,6 +546,7 @@ clk_hdmi_rx_mclk: clock-hdmi-rx-mclk {
 	};
 
 	/* sorted in register address */
+	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"

-- 
2.34.1


