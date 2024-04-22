Return-Path: <linux-kernel+bounces-153950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D488AD540
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD5F1F2128D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E3156F50;
	Mon, 22 Apr 2024 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GlsBwxLj"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209AD156C7A;
	Mon, 22 Apr 2024 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815441; cv=fail; b=INrOWhbM/RWhVgcPU1GggbsIqfq3IhvH7xqcT9yDexYyErw18raBjaplJ3RrSdZ59lhn8d916P69NV7wGievGpzX7bNyE/UvNWK/l1xiai/NHQUSPxOrK12Hic/JUFpjxXUl11nUYyZBEWuAJW2LKQoAFbSsoIErFmzdaDVlA7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815441; c=relaxed/simple;
	bh=+GjOktyLcbbX0qP+iET5cgY5uIbUxbO1kaAEeh2kMpY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CTc9K2KEB+nzdyko/j7rm8v7mrLeKkjjkHf092OISpv2Hu1OdasOOH5cqhml1m808NcyzzyhRj6yheNB4v0gYYOmjoV8Rv9BQ4ZGrOYiNvHOG4/F2IYQJeh6+YQnQDDvTkpubm6r7c+Zvu0GaK4ZYLUXcjhLYrwg9diUtXG1gmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GlsBwxLj; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a29z+hhSJccKFqK2iVE6jw6BtNtD654Z+k3qFufce2Zn7kHUkEs8kUstTbhvvzAUx3IATwoXVb71xsgJgLOoz+vTiqSGK2ZGovURRXqhi9W0Q2UtP1/JuACpG7Eea1WGye0J8ZwxsGToaxVBhT4f9pyKovndK38qQ+No57K6psp9oGwiyndCeegB/ZZleM3SFSeJgDNtoTb51JmcM9uflTFXqP3IEsuNrBhx8O0GwZzrwNCPotbM4IghOqH8wG9d9ktgmg+82G1Mjc6NUCVaT2DYO82jiOeBpOzy8BMR/9dCHVFsVXWm/9bFqzF0zV/mbGhjoTGCrGHz0k161s7hHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoU5jT+j0uWs/giLsnT2xrtux41+0eK9wLGxMre+i8w=;
 b=ekmB2vzDtQojOJo5YQ9Dw/KNMrdLP8fGkcDVFKjuazIoqsDbr1OoNKIl9jMjwUfjvSZVyqGIsvVf+n4zMuOorFZFv+DaxT0o6dg/GpYc426fXg/USqx9dO++NqSRdWV8A1jbcK//g0adhnZpd6IGi5uloEmETOnXcRZQliLlPGwOa5WtMJXkqxhte7tHbVVoIqG9q/qzmfLohpPW9MQY3R72o0RHzLZJVK0PRMqrza+nOwjvKd6BC9YlfrExdJz+D1GMWjyP0l8BjMHIU8ne9K5l9tCTbcf7lPMrY9Sl7ri0gv/cZJwCZz2gvjTcxmhIaOSd6MGl5E3Up0/YKYugBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoU5jT+j0uWs/giLsnT2xrtux41+0eK9wLGxMre+i8w=;
 b=GlsBwxLjeNxVtLrXilG8D7UyAd719HxKC7vQ32zWa0l+SF+iuuY+UjvR0so9jtwGUYPzWHNdaZQAI8HMtzFf7rvTVKqjGG+He/wU5Gc8nQnZZEM0VZB45n4EWgK6jx8m6aTWIgde/ys75/vyvnHbkiY3QxrIjh+FI7qx7zbYLbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9734.eurprd04.prod.outlook.com (2603:10a6:150:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:50:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:50:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 15:50:10 -0400
Subject: [PATCH v3 08/10] arm64: dts: imx8qm-mek: add lsio mu5 and mu6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-dts_8qm_audio-v3-8-680cee731ced@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=641;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+GjOktyLcbbX0qP+iET5cgY5uIbUxbO1kaAEeh2kMpY=;
 b=i51NosOF1/o0kSb00tmQCGAT+KxtsGSUzJw+dDpRD+gzldW0zUD+QRsveio+UXb0XtQ/viQMl
 AXML8q14kc4CEARXnMm91cJrYud8zpf1zUeT30RV585VM/5RE04T2E7
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
X-MS-Office365-Filtering-Correlation-Id: 950ee7f1-fecc-42d6-f432-08dc630577d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm1TU21QZVlCcnpjbG9wdVJwb3JITE1GdVVHb2hWVDdEYWZuNU50V1pPaklJ?=
 =?utf-8?B?bG9rOTBGUTMvVGFTQXhreHA0WXNqNXBUT3BwSllnaEdmNVJPdnYyMHdFWHJH?=
 =?utf-8?B?Q09weTVoRWNrYVlDN0RFeHZiWUtBKzY1VnI4MU1TbVF3VWNxbllQOUxYRytV?=
 =?utf-8?B?ZmRFY0dCY3E3Wm9HdnAwdWJnWTBFRDd0V2htcTAwZURsc2JDNmxOaUYyUEtX?=
 =?utf-8?B?aDVJcjlxTkZkYUdYeWxISUUzLzlpdTZ4Znp0MWFIdmE1OXNiZU9Ca0NJYm9G?=
 =?utf-8?B?VXpXaUwrSVRFMEJDdDFvcEk0bURUM1BPOXBvMHUrNWxKaWhwMDUzOVVwMUlQ?=
 =?utf-8?B?SGdqRE5EVit4WjVudFU2M28wam5EdG1kSnozdnRsR2ltWGh3elppWk0rTXNC?=
 =?utf-8?B?cFY0b2dWOGRTTEVUcXVwQjBRV3Q1OGh2SnN6UjdadXdJUzY3YXJrY0psNHYy?=
 =?utf-8?B?bjV2cWUzQUpSakU1RVNpaStQMisyN0dvSVBsb1k0QUgxUTNNZFNrWjVZZFRU?=
 =?utf-8?B?b1NwNFVaeFI4cWRJVGtMc05ITEFwbCt6SUwrTjl3SkJqaTBhS0dSVkQyR3NV?=
 =?utf-8?B?U1RGd2VwaGkwcDIvY1QzVlBIREFCditQdFBjTnVXbm5zS2ZwWFNrL1U5Ri9D?=
 =?utf-8?B?M1N6ZTZpWG1xci91d2ZBREhEYUN4NzFJaEduc2RNWHNJbFRERHltWjlpa1JT?=
 =?utf-8?B?RDJCSUVZTEUzL2YzSzRGMGNMZFJPMGNmenUvUjRQOTF1U1E0aW5Dcm1TWEFj?=
 =?utf-8?B?NDlGN2ZLV2JzbnpYYlloWXBjeTE5ZmdVQkF3VURnK3pFNlA5aEZ2bkZ0SDdM?=
 =?utf-8?B?c2xGelc2bUpUUGMwaGdaZGR6OTNXd2RCd0tVQ1ZBYnFobE1TSk9EVEo4cW44?=
 =?utf-8?B?ZStpOVg0WkljS1VqQW15ek9VSHFtUnBVUDRuYlR4b2JlZlA1c2s3ZThxak1j?=
 =?utf-8?B?dWNpcEpTOGJRQ21sZnZGaWY3OWtiYkQxSlcwWTZUWVh6MmpZeDh3MGFGVjlW?=
 =?utf-8?B?bEdRR2tLTTFvUUxXazAzOFNNZ3g5a1NIMzdNZGVyN2loaElPZTdWa05TdXNC?=
 =?utf-8?B?b3VNbjJTNFZRSFhFWXJNcHBuVGx2U204YnYrdHB2TUcxRHBwNEhaOGZ3bmpi?=
 =?utf-8?B?MnRtb1ZmQXRaYnN2c1RHSysxVXNKWXltWWwyZVdHWEdhZE5zMWs4RTFtMHdi?=
 =?utf-8?B?TU9BVWVMb056bDJPRDN1b2NiUDJQOTJOTkY2LzF5RkFNeTllQk1NU2R6TWlP?=
 =?utf-8?B?OGpLOWtBSGZqWEpvckV6M1lTaXJtVVpveVZkbXJhQ1d4b0dwSkU3V0ppeXM5?=
 =?utf-8?B?aFpzNktnc2RwU2JOME5MTExJTnIxNTJrUHlHL014Tm5oTjIxZ1RUMmp0SmEy?=
 =?utf-8?B?ZVZ6S2FBNmdnekhYRWhjd3l0OENVZThESm9CdXk5SVIwd1duVEpQNlFkZ25L?=
 =?utf-8?B?NUkvd0xRQ0wvbHMwYnh3anMrbjBCNFlaVG1DdkdzOU9iOHVocEVnRzM1U0Vk?=
 =?utf-8?B?MXo2UWdiemlxbHFLWEcvN2VBQUVocGhWTXBEL2xyQzZ0TDBjUnJKblFxLzY1?=
 =?utf-8?B?Ri9QSzBNVjc4YUJMSy9kUjdNaWJiV09KZHRtSGJsQmpFMEJ6L2NWMTlLSk82?=
 =?utf-8?B?TGtjdmljcW1aZG5pWDY2N3ZvOGlRMGk1RElQd2pRRWhwVjNEcC9UaWZHQVVR?=
 =?utf-8?B?b1pJRXdpbU93TnJHK0tOaERIc1RxV083YzREcHhXbjZMRURTNTNYMlJXZmpD?=
 =?utf-8?B?UkxkR3Zyd1llVXpPNUhHc0ZzMENWSnUrUkNpdjFuSkdTUXpmbmNWUEo1Y0h5?=
 =?utf-8?B?eGRTQjRqMkFpc1dVVEdUQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU5ON2JBWWd4ZytlbUZBeEZzd1RrOGFENWgvZldFR0dpd1NRbUR5eHJwdEN4?=
 =?utf-8?B?Zm1WdHVveU5la21QMUZ5eTUrWngvaWVZSnRid043U21nanBYQW1qTUhqWkUv?=
 =?utf-8?B?T1ZkMHRXUU9zRVBReGpzRU15aTkwcWtCODZsTHcxcm4zb2lmQkduUGJVS0cw?=
 =?utf-8?B?SGE3UWZqeWpaZklVRHhvZ2xXSW8yZlZYQzhBeGhvUVpDTXRsZTAvS3U5UGdL?=
 =?utf-8?B?amMzQTV0SkkxWFFZQkJ3eFh5UXBDRlpPMEp2UzRTSnBvbkFwVi9pUzlrQWpL?=
 =?utf-8?B?SmJ6M0Z2NTkxcm5xUmhjU2hkaDAwWjF1Q2VLNnJEZU5OaHBxQzllTkRpUnh3?=
 =?utf-8?B?MVYwVkFObVNrNjlTTnRyVDltdVE1QS9xVXhoekFGc0RoVHcrankwYVljU2E0?=
 =?utf-8?B?N0h1NHFrVG15eDNJUXhnOUtZMEdjUWUzYjdoM1Npak1jV2RmdGVSdUdEYk1u?=
 =?utf-8?B?RmNuNlVISkZjelM4YmwzZmhUNXovNzVDNEx5dVJYUzlxZEpId1F2V0RXMkwz?=
 =?utf-8?B?bHZkOXVrV2Y1MmgzWi9MY3EyZzBFSVNqV2xKZGxKRUJrUEl4WkVoNEE5Vldm?=
 =?utf-8?B?dThJSzdOb2hpRDlNbzFhSlRhNExpVDVLallzbzlkRXplbGR2RmExemVTMllL?=
 =?utf-8?B?aTRXQWcrcE9wYXhrZWhlSFlUZ3QySXR3emJLYjlCZGxGYklsY2FHS2txcWd4?=
 =?utf-8?B?Qm41bmQ2T29acDFGeWxybmQ0QS9aZEdSb0g1MFZFVmRKMlNhekRTa1NmS3dp?=
 =?utf-8?B?aStDUWl4TUpXY3g1K3puRzlsOHBBalk5WmNQcmRab3hoK0o4alpHb3lnenVP?=
 =?utf-8?B?UXFqanJZZ2VFS0JyRWkrZE1LT3JOTENzcm50S3ZUY0FWbUIzMW9EaEpwNnJP?=
 =?utf-8?B?SGIrb0d5d2x3TG1tSjZpMitseG1SWTVJMWFwblgybk5Pb2hkVjVwZ29KeGpH?=
 =?utf-8?B?N2VoV1ltaGpicVlxcnlHNmJ1MEZuR0d2SmNwbys4VTcrckdCOUZ3WHdGODA0?=
 =?utf-8?B?c2ZmWHRrK3VtblpWNmVXNzNRamtEdWZsVFZlaDNDUzJNSUhLWDk3NkFhMWhr?=
 =?utf-8?B?WFlTUmN5QjFldUl2VTk2NXBjN1pXZDhjbC9vc3Rwb0d2T3k4Y0tLMTQwQ0FG?=
 =?utf-8?B?aUZHMWZXRnAxSUtEUTJ3bG5NNzhkUHp2dkZ0NlBqdnBqU1NDcTNaOWFCYjB4?=
 =?utf-8?B?b1R2K2ZJVE9oMVJsQ0NEaE51NVpSWDcxRVpLbk9zQ0NFQ0FQck1SYnhQRnp2?=
 =?utf-8?B?REVFMTFSU1VsbE1MejU4cENVcHdGSW9wdFhPNldPelBvTGd6cWlQa0JNVVlK?=
 =?utf-8?B?ZUNsN2xvNktnTTBNSHA4QnZuRkdFaFNqNC9GcGt2MnF1RWFOYXdDUTkvUU1u?=
 =?utf-8?B?cksvZDgwUEVJTG9sMkRuTVROWE1TK0NTMkNmM2daMmJrTDNvMjVwcC91U2JO?=
 =?utf-8?B?RnFKWHpBRG5kVUhjZk5rcGJ6QXVTZzM5MTRpVjBmTTlFcVdienpJTUVwUlR1?=
 =?utf-8?B?aCtxUUdWY3BOOWh0bW9YNmJGRTRPQkx2Z0R1RXdid1p2aGZ5Nmg5azZSUWtr?=
 =?utf-8?B?N0psLzh2Q0F5UU1hVnFLNm4wVWtrblRqK1hROVhFV053ODRkL2tCSGllb0du?=
 =?utf-8?B?WGpFK1hGbGxON3NJeTV6ZFU2MGN1T3hka0tPTE9iZDcyalIybTF4SVZVR3VL?=
 =?utf-8?B?VGprcEN2SmpPejAvdjRKSm1ZbzhHWXBNajM4YUJYclR1VkFYQ2ZlaXg0eHhU?=
 =?utf-8?B?Ymc2Z3FPMDVHQXVsMmVxTTlhNzlpc05tUmY5eGJUTWZiTWJSZGgrc2ZiTFhE?=
 =?utf-8?B?MFNOMDNxbmNLSUpVeXNDNGl1dTFHN3lZMldBYjFyaVA1aU9LWUtMa3hCRUNw?=
 =?utf-8?B?ckpmOXBQTTBJeVRSWjR6bzY5SjE3MkVlQ2NmZGZtT3dyZFFLZXFuTXUzVWdB?=
 =?utf-8?B?czFxMXFuRXpoaG96VlpZandPTFpWS3FRcTM3dlFTcExnaHZ0eVhueklDbmUw?=
 =?utf-8?B?Z1lOOHVXNzhHUnY2Q1kyMXFSVjhiWTQ3S3hvT2xQcExnUGw2T3NkUnUyajB4?=
 =?utf-8?B?blFRc2oremQ4KythblF0OWdPSHFnTnlDUkhZS1J6aHVuNUJCN3pCc3JIYzIw?=
 =?utf-8?Q?vbXxV33KM64700+7Wbn/SevIS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950ee7f1-fecc-42d6-f432-08dc630577d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:31.7520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xg5ElLuYt1TDRImhJFalt1Gt81v7MbCst3jY5IVpM/QErhLBad39v+Zq1hPhuBZBfZAO6NJl11xjsy4WQOVDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734

Add lsio mu5 and mu6.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 62ea3efd1ee2c..cef395e919395 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -259,6 +259,14 @@ &sai7 {
 	status = "okay";
 };
 
+&lsio_mu5 {
+	status = "okay";
+};
+
+&lsio_mu6 {
+	status = "okay";
+};
+
 &cm41_i2c {
 	#address-cells = <1>;
 	#size-cells = <0>;

-- 
2.34.1


