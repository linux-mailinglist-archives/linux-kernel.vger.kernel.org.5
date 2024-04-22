Return-Path: <linux-kernel+bounces-153947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A918AD539
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D0AB23727
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908DE156962;
	Mon, 22 Apr 2024 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XuayLZir"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B0156246;
	Mon, 22 Apr 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815435; cv=fail; b=KrT794V8G8936vi1RuT8sMAXUleviMl7CdUsilpAHOYjqinjtnYErzR/dPkbKluM0pwfPvGxR4+I8nvfWRXB0I59YozaAIAazhz32TVJ+SphEJ2jDl1EIO1uVAWvzeZQGmhWHYIXNJ0nOOPnRJpQ7gyHdGoApWwPBm5gyFW0MA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815435; c=relaxed/simple;
	bh=5+igaDiKDGZ+fXtMma620Ib20wbhG1sQR9/BOeshvnY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b9SJ+SceHTd00d28ajh0XVj/v8CwL2wnzZmULE+WJ+dop+9ubIr933nv7IVSrUnvDq5cC54if5e1Q15pvK92+88GzQsM68LpKR3P8sWIdnSdma60AEL8sHSEMLN6Zz6smKuCcI+7vGk5TiRbL4Xf3PpVdFutOCynULUyAFL7I/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XuayLZir; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlxBkRrEkrN6VmtifTUiV5IVsKHdfV55VL98ZFn2L7jqs9eF+qrxCTuivM34T4P/A5Gy1vzf7BoZrhxyHkxYR/L0VycvpCDnk8KOk7ZRWJEG5w5SHHhZBLLPYT/Xj3Cb6MHgndrllDxDnlih8VOb6AVMBDF3MSEKcDecQQNO0rgT/9O7qdW58Oe07ksfIRXdYZIv/gl8HJ+qfLhxNTprv14cOodgrJyPmyRpThfG30zqR2j2fuArCuiGmMFb3QAllrYReJU1Wc+TFIW8kH7AaE+A+xs8RjoQf15Sq6344j4Y4g5wsSzVsXa9zNsv2ZELo1TvYhOoUFhanganPOc5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8vu7CvamML2aF2EpGTVuzqF6eWmGbHR252gBaM1LI8=;
 b=EWhwtKQaXpN+Z1ufa8NEYoL2hGPe595uaKEVOtq671Jrfc8XwCgNWaZjwj7PEpWoH1/jY+4Sz6+vm+h685UFffTxDSEYvUeJLZKi331qOZjTeHMl1vrKZlSjN9Hv7UT+gz9nURWYz4xq7IrIpdGotO+iNGePDIkDyS2WXM4X504O0dL8bC07W//zE4YNWialX/hgI7qYsHgy7853aS3cMu7VddGKg9FqCxVCoxCW1nwjIxf8y0jbZBrtNcvDWKaec+VJ6lJED6Y1MDL5Aan6PZuVSdyHgeMXlVtgBu+wOB2RY/mI1R9L6wsucRNIDNIyPrpUPpQJArfUxbwRw9P8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8vu7CvamML2aF2EpGTVuzqF6eWmGbHR252gBaM1LI8=;
 b=XuayLZirdTnNEsPlXsdIAPrHlANFzGDOKU1bl6/M/0eupw2soZv+TKOvy+Q7a60E722mjKajL9aJypwqtHpdDT7Jvl9zbsgMy+YQ6Qwwlf2DC6nfdWLUAN3i8sG0EAP6ONn1tTRDc6d7mI53EhGnCm4CBeqcCF/fhma00h70EhM=
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
 19:50:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 15:50:07 -0400
Subject: [PATCH v3 05/10] arm64: dts: imx8qm-mek: add i2c0 and children
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-dts_8qm_audio-v3-5-680cee731ced@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=1734;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5+igaDiKDGZ+fXtMma620Ib20wbhG1sQR9/BOeshvnY=;
 b=Fub2Cq2p91zBn/nzmRMFGlv9nuGBCwxO+rCavHfCC+8a+9h6spaedSOq2S9MDYNfevivjADik
 DHRvxFWijWiBs2rJSAmJMySSlUlBrtapDlRL5C5+IcB48A3Htx6tclM
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
X-MS-Office365-Filtering-Correlation-Id: 91368cd9-90f2-40c2-7d15-08dc63057439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTdiNDJ0dStWSmM2bGxuSkp4RmlQaFFManBOcC9FN3dheGNPS2pOWGRNVnJu?=
 =?utf-8?B?aFlpWXNqOW4waG9oNTcwUFJoaUdxcHZsK0JjV094Q0MvWVpzNnRjRTZmYnJ0?=
 =?utf-8?B?V1dObksvbjJ4dGZWamN1VVQ2SFc4UFBPWmw0VmpUZDRpRGsvaHJYbyt3NEtY?=
 =?utf-8?B?QmxqWnVQdUQ1eU16TzVtMVpmL2JibWNNS3FzL1dYYVhtRnZ2MFVnRFBrYjZV?=
 =?utf-8?B?MnBFVjRqSlJPZVZDRzFqRWJ0UnN1eGJ1QmM1bzFmM2N1NEJRNnBjN05DRDJ4?=
 =?utf-8?B?bTZFQ1lDeCswajZ5djExUGxYSU5WOTFJbExNekwzdTAyMk9MenlSbXNlOU1l?=
 =?utf-8?B?anhhM2JtdlhZY3NYSWNqRW5IQUZScEh0RDc4VENUcFRnc3FVMzdQM3AycjNZ?=
 =?utf-8?B?ZS9GQjdWQ2k1UHdJYXU2LzZuNjRYZVhucW5VVWlNQkt5Y21lRGpjVzVZMjVp?=
 =?utf-8?B?VkpMVTBadUd0SnhlR0l0dVh5ZmMvNUxwREZUcEgweG9jUGxldGE1aHljeVZC?=
 =?utf-8?B?RkZNMFFMejIwb0NxTXVUTmtQQ1RGbzBSNDZxYU81N3ZFN0U4QTRhY3A0bngr?=
 =?utf-8?B?b2twZTExcHFYRkZRUm16UmE3NWJ0K0tsd0RGSk9UQjRiRldYcmJ3azhEZGhn?=
 =?utf-8?B?d3cvVFgzT1N1Y1Vjb0ozaTIrbk5Eb1ZsaGpjL2hCWGwrenVaSmNNL0ZMUFdi?=
 =?utf-8?B?aFBpVm8ycm5kVi9Ga0hkMW56ak5PVkcweGZXRWFoZ01zSm1ZM2dTWDhrYjlY?=
 =?utf-8?B?NUJXVVo3VTBheXd4TzhDRkRkS3RQOWlkWFovU3dCV0RudVlRQWQyb3ZqaGo1?=
 =?utf-8?B?cmNLcC80M0hVM3hGVml6QUtScVdIU1dWTWpuUVVHMmhtRHZMMHhRZXNzTlBB?=
 =?utf-8?B?TTRzWURGRVFDMEQ3M3JCNEE3VXFCVUg2bmovZjlmdWY5NnVld0lMOURtYWZ2?=
 =?utf-8?B?bjNQd0RKRW1BS2xyYWVqTHJXRm9RcFhRTnRXN3laRFBtWmIrUkowd0JhYWR3?=
 =?utf-8?B?YjN6MncydTNhR1loY2R2RGtCaXBjYkV4NU1OMkxCbHc4U2M4MVdxbU9XOXYr?=
 =?utf-8?B?cmJIajl3cExiOXpNcDkya0NxdkEwZUVRS1dmRHdjZUgzMG81N2NzOXVEb0hC?=
 =?utf-8?B?eHlJQ0c0d29yMTUweHFXNm5HcHJTaEdEY1Q3K3lTTU5YcmpleTh6TXpGSW14?=
 =?utf-8?B?Ri9OWmxOaUgzSUZXZWNzSnpTQkxFVEFyNTBwQjdUNkhWSVBtUmZaUXhNeVBi?=
 =?utf-8?B?aFdBYTlFbTM1R3A2c1hwTkFxaW95c3FsR1ppYTRvRTNjZDU0L3l5ZVJUVHRo?=
 =?utf-8?B?UTFHVVNPTklSTmVQNmNrZUZJckZ4QzdEalZsWkQrT2g1TFB6bDJJbDJNbDFl?=
 =?utf-8?B?VGx4V2xremQ1bk9tZkZxRFV1dys1MTZRWUxGN09tcUpEWWlmbUw5ekk5RHND?=
 =?utf-8?B?Q1VVbkxSZGUzZmQxeUlOQU4vUVJGRmFkQk1JamthLzhYalFIQitETnhTNWJH?=
 =?utf-8?B?M3BDRE1jZS9kd0RTSG55eHB5a05kbXFuMlRjRXdkSXFlUDVLc3R0R2tnTUpP?=
 =?utf-8?B?ZDkzbUIyNm5laENPR1N6QzlZbXJDWnAyNGJxWWVkMUN1NG9ZYzkxNzBoUmFh?=
 =?utf-8?B?ZzF2aS9MSmw3RmxoelhqUU1Xd3BsUlNMYTQ1eDdRdm8zUENEZnRqeUpxbytF?=
 =?utf-8?B?OGhRbitXdTBoQTVhaC8zbml0WEdYalZUa1VNQ3cwbjJaU1FjZTlYMTAvVEx6?=
 =?utf-8?B?RDdsQzJLaE5KNktCTGw0aStHd0xwTXFSd3Ercm0wejV5azh5L3MwVlZLQVdQ?=
 =?utf-8?B?OFpCbXFsc2xLVHVjUzJVQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW9FNi9meWZnRUZOMkZQcFF6TjBVa2U3cGJua3JtRVNMcTRSM3VzUVFacmJW?=
 =?utf-8?B?S3dOK1FqRkNmaGVydTZtbFZUaHVWWFRab0pORHpaODdSemxhNHMwa2oyRnF2?=
 =?utf-8?B?ZUdFOXE5ZWRNMHloS0l5TWZxenNsSXNFc2ZPMlE3dDk5VUplZ2VvRHZHR3RY?=
 =?utf-8?B?YzVTMmNSSHFsUmMvWVU4YTB4eU8xQm9pd0NON05UQzJ6RUtsZEFyb1N2QVl3?=
 =?utf-8?B?NGtTWmxYTEdrT0p2bTEvSjFxVk9jMmw0a1NvNGc3b2FWRkJBT2o0dXZteG83?=
 =?utf-8?B?NXh3WHZzbyt1MUJMVzdNT3QzbUc3OCtCWFBTcHlqcEwyWVFuL0V6MFYyVUIz?=
 =?utf-8?B?RkMvSW1zSGZGR1hPMXNVZkhGMTJmQVA2clBkQ3lJYVExWnpDZFhWZTNic0lY?=
 =?utf-8?B?Q0pMVTRoV0RLQ2pqMnVnbDVMcXBSOG1ieE4xbmpXZjE2VFVqVXhvZ2hoMlJh?=
 =?utf-8?B?cFplZWdKdnpHNTVpc1JiTXMyeVJhZ1lHUXMzMXU4eUtTRkhEZDA0Vkg4UUgy?=
 =?utf-8?B?ZVEycTh4ZXRibzVJd0w4MTluSmlNdjNNRHgxQ1dpV21OUXg5M0JHUW5IYTho?=
 =?utf-8?B?RnNKdzZWZEFPalk1UDNuNkp3dmwva2grVldVc1UyN3BDS0dlNW9KQXJTaStN?=
 =?utf-8?B?SVJ0RTJFZEFIaFV4NWtvVndSL0gvL2I3eGVqbTgyTE9scnRWR2hoSTNxbExo?=
 =?utf-8?B?UEk2STJUbUsvWlpDbHVGTStMMHhHcGJxdFo5cW5qZzhZbTBub3ZPZGYrMnlR?=
 =?utf-8?B?UnROVVhoMDdjNHJQbFQ2c3hudUg3NWVUV0liQXV1WXhyOTVTdEFYOWZJQnNB?=
 =?utf-8?B?T2ludmZpUkxhSTFEa0QySjYrRkJZV0Z5dVd3K1FnNVliQzJka2M2c2oyQ3ZE?=
 =?utf-8?B?M2Zyay9jUkY0alRJNnJOSXM3U1lpUEFPcWdxTXdZWG5XSXRlU2ZidWJUWWd2?=
 =?utf-8?B?aStCT1FCYmQ3M1J4ajE5Rjg0ZFpGQW1iRENySzZYOEVpWHorV2w0RFJoR1NJ?=
 =?utf-8?B?aXArTEYzenNvQTl6eGRjTmxIVC9Xa3lkQWVaTS96S25ZR2xxMlA2bEZrelVv?=
 =?utf-8?B?ZVdBbEFYTmR3MWUvQmtCWkg0TWpnejUySDdvNGhpWWRFUW1zVGt1NnZBSGFk?=
 =?utf-8?B?cSt4Mkwrd05DSFIrcEpGU3JwNUJ5MFBEV1ZXZVJOdm9vMmE1c3NjU3h6NnM1?=
 =?utf-8?B?QXIzbnZGRTlMZDhzUzNDREpwUnZHZVN4Ukc4WWZVYW1LTnB6SlJFR2dCL0pR?=
 =?utf-8?B?ZlcrRTBGYjZDRE1jblorR1ArRFd1RWtNRFRZQk42SGRHZmdkdlI0aFE5TFpL?=
 =?utf-8?B?ako4MTVFRVVGdEl0RzJxTnY1ckc4NldtLzh3MlNZUWx3aDl1VE02emRlRVFF?=
 =?utf-8?B?cG1lWURZOUFEbVordy9NSVIrSGRpdDJXVGhibEdBV1pLbDFhb0JvTW5rM3Fx?=
 =?utf-8?B?aWRPa2hpeE5KMjM3cW9qRURlNGpwTmVvdk5TVHdCbHVkRXdpbnZhdHZpTVBa?=
 =?utf-8?B?MGg2cXN4NWpzY2F4S3BIRUkrcnZKVm1pcS9XaWhQSUlMUHJESFZ4Mnp1dk4z?=
 =?utf-8?B?NXVPYXhmSnZzQWQrNW9vNjNTRElzeVpZb2oyR3RaMjIvaXFrTS84ekpJVUFv?=
 =?utf-8?B?MjdicVdSM09rWTF1YzdRSDczTTd2YTNmUk9xTlRiK3dUY0tPM3NtWXpndFg4?=
 =?utf-8?B?RkxDMzFzMGg2U3c2NUx1SHU3b2JXUktuYjVzVzF4UjVzeG9JQXVPTkJHalRu?=
 =?utf-8?B?NUU2aFdvY3puRis4R0JaUkhFMjF6K3Q2Y21GUHhoTTdsYlRQS20wS1duR2hC?=
 =?utf-8?B?Uzl4VU5tSFgrQzZKZEFWUVpNWFpkVUg5ajdWVVAwUzJPTzQwakljU255YjFs?=
 =?utf-8?B?V1JBYThjUUZ6WmljcWJteVp0SWhzYVpNWWcvcUNhQy9ZZm5sVFo1blpYVExK?=
 =?utf-8?B?K0hsSE1Wd0pRUXJYb253RHk5YlA5a1ptRlFVVTByMjJ4ZEFkVTVRakNRZ0M4?=
 =?utf-8?B?cytOdjlnclBKMXJza1MzOEZhVXNPTHVGYytOSXdqaHVnSEY2N2o2aUZXTlZz?=
 =?utf-8?B?Mi9NMzZTUHBEN1ZDYnpsZkxMRlNtNjBmK0dENEk0bm14Wm1tS2R0QTJGemYr?=
 =?utf-8?Q?cSOG2aI600Hk5Qfxo/DYv+7eu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91368cd9-90f2-40c2-7d15-08dc63057439
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:25.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ8+cy9jgeWIRmDGiHoehuetCigEmq1n8mGC+ck7/K0ptY+WrI57DNkGIJyO7hGoDwuOVMHASErxufo875zu4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734

Add i2c0 and all devices under it for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 5c7df6171a9a5..dc1dcc5b25e80 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -95,6 +95,49 @@ &adc0 {
 	status = "okay";
 };
 
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0>;
+	status = "okay";
+
+	accelerometer@19 {
+		compatible = "st,lsm303agr-accel";
+		reg = <0x19>;
+	};
+
+	gyrometer@20 {
+		compatible = "nxp,fxas21002c";
+		reg = <0x20>;
+	};
+
+	light-sensor@44 {
+		compatible = "isil,isl29023";
+		reg = <0x44>;
+		interrupt-parent = <&lsio_gpio4>;
+		interrupts = <11 2>;
+	};
+
+	pressure-sensor@60 {
+		compatible = "fsl,mpl3115";
+		reg = <0x60>;
+	};
+
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gyrometer@69 {
+		compatible = "st,l3g4200d-gyro";
+		reg = <0x69>;
+	};
+};
+
 &i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -282,6 +325,13 @@ IMX8QM_SCU_GPIO0_03_LSIO_GPIO0_IO31			0x0600004c
 		>;
 	};
 
+	pinctrl_i2c0: i2c0grp {
+		fsl,pins = <
+			IMX8QM_HDMI_TX0_TS_SCL_DMA_I2C0_SCL			0x06000021
+			IMX8QM_HDMI_TX0_TS_SDA_DMA_I2C0_SDA			0x06000021
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			IMX8QM_GPT0_CLK_DMA_I2C1_SCL 0x0600004c

-- 
2.34.1


