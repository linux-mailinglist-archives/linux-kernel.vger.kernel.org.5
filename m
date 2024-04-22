Return-Path: <linux-kernel+bounces-153854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585D78AD433
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D7DB21C31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBD815535E;
	Mon, 22 Apr 2024 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ihqsTpDX"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739BF155334;
	Mon, 22 Apr 2024 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811529; cv=fail; b=BeeSlxiVExFuPVTJIGVBa3xGSaGSLoYo5cprQXQxcvHqBIHUPF+dvtLht7VOMRY7GpOjQJsiCaVRpw2WE/aaV82lYum69xQ6EMdiRSuEWnHibFZTm7XD/7IkM26Ui7DazfSLPBF0CNDlyZOQOOg0BxJuPSFewSf1Rrda7OAg+dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811529; c=relaxed/simple;
	bh=p8vdcvIu/jGl9YElNP5C9gcehzRlZvEtdSYDpJQ4uhw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OwbeJHavU9PQ7pM7NpvuiOORw+tpDmTn68P7SaS0ZyW3M7xtuoJiI22DxvoNjP5MDTQRHrREbe9mOvDuW+oKz807/NgrAKWTeXO2m0tiZfpBSe5xkvvQs96epozui1IKNvprOoMyHBlYXk6ln7ZJDpg4/5eGo2jSkBXgJpQ6g6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ihqsTpDX; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZBEbka0NOQHutnayo1kvqpiykiuggHNr/4oP2fxLBUTuyXzJZnHw5gW8Ekg0bvu+0vVAngUmXw7TZ+tcaV9r5Yi0rGedcsUdNLV4KfMl+HLtjGoOkS/gXTc2oBxie9Mco31MQN0F2rHtuo6bcFPRONbKyjFRWE72M2AX54AbFuRK8fQzgfObxXHOFaWcKbniRxEGR2n4euMBqPfr/A5MLp9DNWm1RltRLrtjkZ5B01JyXdI4adABPUS9n+L2mzuyUPKroJ4biZOTGBaynMqUi6DL7AE9hPuT27gEGIq7VhxTHg9hXyWedeoYX7MKayYOpw3oYhNzGDWDzVPZOEIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85hNXh4LDMGO9JJQxkOWEdPyQphnyUFJYav2LP26zIY=;
 b=YlOWXQRZKIHKNqRYNU5No7Z3URl2U6bOdeReow6bxxsb7DBOokqgzJSwCvBktiQH3wPF7v/5l0BZSdMJC0f3vl4rqObJf6BbmteCcP2gdEWXI515AmNFZ0kmdY3y9xq6Z+Jlj9j4++evCKjLkUug92/rnlOMrUFu+1JqZd8TMtGh2HsAa6+ryieqPlU/RaLP1jLPsMHZWxGPFnynSwglTMiHqNbY5Z8+WRju5GbyiM0o0zHh2O3BOZ+AUicHiBe2mIJoDOpY7QzF5nYKI2rD+oq5n5rS+AL8Lpqx9g6+jCz5ygi8adyIROH8GyyYTPKkgwVy1Xs+Xzp6akHNSyJxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85hNXh4LDMGO9JJQxkOWEdPyQphnyUFJYav2LP26zIY=;
 b=ihqsTpDXO6ILeLweU/aivCYJAkkdxVn23BPvi7W+LUWRpVJXMLeB0bN7hfVqHcS8DlSK62OtbDKwuhkRyhajxxE9fd1MuySl7KLRYOJjvv+CdhbD1Zjz8BWf18hgTWxFOociLTCe6DV3rPy0zTYyU+7dGsIopa4f2aq50Bu0Nrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:45:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 18:45:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 14:44:53 -0400
Subject: [PATCH v3 2/3] arm64: dts: imx8dxl-ss-adma: update audio node
 power domains and IRQ number
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-b4-dts_dxl_audio-v3-2-5017511f399e@nxp.com>
References: <20240422-b4-dts_dxl_audio-v3-0-5017511f399e@nxp.com>
In-Reply-To: <20240422-b4-dts_dxl_audio-v3-0-5017511f399e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713811515; l=2570;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p8vdcvIu/jGl9YElNP5C9gcehzRlZvEtdSYDpJQ4uhw=;
 b=KnLTZCHcPzTCp+SfEuzk9uFGVb3Tg8zPnczCBFefEBRXqP/emQPuBBy6VgsiT5JhK6q2V0fp7
 tw+ySoV5Y1eB+oLkBJCsNAH9lrhTfAWk1+G3FGXSZYB4zl3BoaGeZc4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 39568e14-02e3-43fa-f8b4-08dc62fc5f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE9HQmlBbDEvUmVzUTRsenBBQWk5bGZDem5BU0lFNUFDSklLdDVFZmljM1Fy?=
 =?utf-8?B?VVBnd08xOTNaLzhOUGxRaVRLK2JiNXFzVkZQT0poSVZWcGZ6a3M5K2JCNEN3?=
 =?utf-8?B?cHV5cDd5K3VldkNnSU1jeG0rQnd3YW9jNVlSajNZenVaZGs0bzFoTlRPbG9r?=
 =?utf-8?B?V2RDYzZQR05yaWNGUDJ3SDJHUk1DZjVmZjhoWEQ4WXpIZVNyN2xMQkdMb0M0?=
 =?utf-8?B?a2M4cSt1NExueWVMemJYK0NqeHJycVljSU9vMDhlMllOSE5xc0ZhY2N2bVov?=
 =?utf-8?B?RDdvbktaSE03VDZqQ3FJYU5ycVdyKzEyMnRzTXMzbzlsM0NsNkNxaXd0YXdT?=
 =?utf-8?B?Wll3RGJMRUMrZjFCaXhyTzQzWlVDYWdHMjJtYTNHRHZVSklEV28wWnZybkNJ?=
 =?utf-8?B?aEJibFR4K0JOKzVHdzk5VTZYWTMrTkdBRmlXdllaVXpzYWpMQW1sNUYrWklw?=
 =?utf-8?B?bFY1ZnlSZ012QlV5bGVBS3A5b3lEY1lsenhOd0FiZ1ppUmNjSHZ2eWV0WWM0?=
 =?utf-8?B?bUU2RFNKblNWNWRpN25UQjl6RFVtZmd2ZS9BdkxjcFd1bFZCL0JOVENwVklH?=
 =?utf-8?B?SGdJV0kvZUMwT0czd1JGRW5DZGVwY2xOdU1pM1JXNzd4eExocEY5alROcldy?=
 =?utf-8?B?dXZpeXprcnovMnp0MVdBTk4yTExXZE0xallQMzYweEo3YjlxWHkyRDJYL1Zs?=
 =?utf-8?B?WWN6ZFdZME81T1FzU0tCbWNud0JuTGJ2aVFhUEcxaXNpRkgxOE1VU0E0Z0Ey?=
 =?utf-8?B?VDU2TS9OakdZSkx2TkFXNGh1dGNjb0xDYjVHVFZJc2psWGtvaG9Jb0ZkZExo?=
 =?utf-8?B?UHpvUnpjWmR5a0R1ZzdWelJXa3V6aHFCTnNxWi94azNGYjk2VWhhM3drN25L?=
 =?utf-8?B?YVBEOUZrT0VWdk53NXFjeXBQWXpodlJhMUpJc1dCVVlnOU5PRVFHODRrVi9h?=
 =?utf-8?B?cTVYclFBWnRrSjNGODdaeUdxWTdoZS9tbGhDS1kzV2xDMHdJakhKQkwrY3R4?=
 =?utf-8?B?Z3RYR0RRdjdiNVcxbDU3VHZvTTBOelNNNVNwVU1RQUZMNTFoNVJ1eDNLNVlY?=
 =?utf-8?B?eEFJbmd3RUkwWm1qeWdxazhmOGxwRHlUYjZuSXgzblFHWnV3S3dIckxSZjdJ?=
 =?utf-8?B?YUdOOWkwREdWeldWWmU0MEtTSmJrK2VEaVpENWVNTUxBeFh4S3A4VnREejFL?=
 =?utf-8?B?ZmNoRit4V1FFTXVBb3h3Y1FkeHhMZTFNZmMwS05JRlBkUW5VZWNiNVgvOVBT?=
 =?utf-8?B?Yk1EeTNZOEV6Vm40Z0NSdUZia1JKdlBlS05FVGRIbk1NZnJwOW51MUE1RXFU?=
 =?utf-8?B?dWxNc3R4M1piSmZwdEIwTHArNzZWNURtYVRubWEvd28rY1Faa2FES2U0MW1o?=
 =?utf-8?B?YU4wTEpOU0pSQUY0ZDJmQTNkK0tRZHY3T09iN3dYODUvSEhHbHpjR1ZHZG5D?=
 =?utf-8?B?TmtmTVFTUmlUdUlCcXA5Ri9vUStHMkhyaUhIVEtqMGlFWERTaHArVEcrdUVw?=
 =?utf-8?B?SUxGd1BjZW56bGlpN0VKQU5kby9QM1o3dXNRQ2d2U2hTWngyUys0Q1NucmM0?=
 =?utf-8?B?dkRzQ3ZFNVM0VEEydkFSTnZGYmJJYndzd2M1a1B3eTZyTEJSTm51bG5ON3d4?=
 =?utf-8?B?b3hia1dpeVkwK3lvM0lQMFR6MENxR1RraGVNLy9kdDlIQmUwNDdHRXp5MThO?=
 =?utf-8?B?V2cvU0lxQThaZTVOR0NqbUx3a3Z1RDQ4RVhIZmMrMVAzQlBCTC9iRm9rVWxh?=
 =?utf-8?B?YmhLdlJGbmRqN3JCQ1JROG1JV1paTHg3T2ZhQkNWa0ZNSXVvRktOdEc3YVRi?=
 =?utf-8?B?OGR4S3NQRzNUcStVNTNIUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzVmK2RmT0tiMFBPL1Zick5yaFphTmhFRWgycG1FcTVTUlcvOFRmVk9sT0hv?=
 =?utf-8?B?STlOZUE4bDFyMkpzSmREc3hZZ2RDNXBnb2VXakZ0UnVLZjZtRUllbitjK3p3?=
 =?utf-8?B?bXpmd0Z3ajJqak1maXF3V3A0eUZuakswOHVNY1laY2RhNGVVdmFNV29NRHhM?=
 =?utf-8?B?QUZLVGJvSmxwY25SL1R4RUw2TnBRcGYvUVM2R1BWWG03VlBLYWk1NmhManJD?=
 =?utf-8?B?cUZQMi9LN0FiN2Nmb1EvVnErWDQzLzh1VTg5WE81RmFxNkUyT05FYy9UTVR6?=
 =?utf-8?B?SktlZEF0U3NaVG9sRG5KQ1VFZ1dSWWRMdk9zQjcrSFZpOFZyUUN3cDYyRExC?=
 =?utf-8?B?bUQ0S0pLdGtQYjhmYXZ5MTM4NFdQUVdaa2VLdXJCeHk4UTF1Uk5PSkZzTzBp?=
 =?utf-8?B?TzJVMWpHb1ZCVFlUN2pRYlhKOTk3ZVREODByM2dCK1RLSGFCRnMxNVpseGtL?=
 =?utf-8?B?bGRBYUpKMWhkTzhNUnIwSjcwVTNxRW1iNlJPZkg4VXpRMVFLMm90c1EvMWlP?=
 =?utf-8?B?T2laMWtwMVZRUFFtTi93MGllZ1hhSkRGRE1Bc3NnS3FHeTJFM3VOK1dYeGZD?=
 =?utf-8?B?WEdJSzZBZmI4bE52dVdDVk5FSDM4V3UrdTJQZ1hVWE5aVWMrRXdtbTN0b0FO?=
 =?utf-8?B?NEp3NjRJR25Ud3JOU1c5MDVVT2RQc3I2Nmd2MmZ1M3htZ1Y3cEk5S1o2M0Vy?=
 =?utf-8?B?eFBHRHJHVWtaSmJBYlM0M2kvNFZCcnVPcjNJMlYyVjdZT1Y5OWtaaWNpeGdl?=
 =?utf-8?B?UTVDblFiN3g4eG1VSmNvMDA3U0dPQVExNjZpcEFrNENBUWIzVDJkMnE1Qyti?=
 =?utf-8?B?bnoxY3hNR0hBRUkzNTlvb09FZndSck1iWHZhbC92N2wrNUJlZkx5YU9WTldX?=
 =?utf-8?B?RlJuQkE2Ny8vbjJ0YVZ6V3V6Vk9qOEVncWJrUmg1Nm9LMmx1NDRFMEJaK3hC?=
 =?utf-8?B?MFhOcnQ0QTFMNFQwN2h3VGcvQ1RYbEwvZDYvRmx4ZG5RanA1cXEvVFNVRXFy?=
 =?utf-8?B?RGcxcHR5NGJ4MWZNQ0VRMUQ5VVF3ZW52UHFqaEY2NVU5c0hVNHhwYnNLVHpV?=
 =?utf-8?B?V0FQSEx3NEpKYnhuWlpHV3ZlVGRvblZBV2RYdHRlUTdnb0orMFJpM2xRUkI2?=
 =?utf-8?B?WUtML0ZySG92bVFIQnp1YmVxdStVWll5WXJvM2NJdS9IWEpQZzg4NHVHV09v?=
 =?utf-8?B?WWtqanNaQkJBa1JaakJReTZtb2l5a2hyblhTUzVCOWpMNFR4dkhkV1VyY1li?=
 =?utf-8?B?OWJIZXJIQlhpWXpvaStFYWZ3dnBCZWZHbVBCOGVNVkJQWmErV0JhWGwvajhS?=
 =?utf-8?B?UlQyRWpic25ZM3NlRmhTbWVHNDZhcXl0cjYyYndhUVJhN0F3Y1U0S0Q4cURs?=
 =?utf-8?B?OTBNbVpCV2wvZ2Q1MXBmUktnMW9WK2dBRnlDSG40ZnhkaGZuYW1oVmRVL2pZ?=
 =?utf-8?B?RWlNeC92MnlHandKQTVoeGxUb0sxRXlEdFEzMkhoSDhWRHN4clc0Tk9CeGZu?=
 =?utf-8?B?TzYxTG9QT1kwU1p3V00xemZMT2JXQlczK1gzZ3JtdjZaQXRIZVk3bm1iQUVr?=
 =?utf-8?B?QXJBVWhadlVFTXo1SEFYVlREQWtLODZjeVZPWStGQ0NJSTBWZmtWYXp1VXhY?=
 =?utf-8?B?cEIvR1ZnaW05Tm9wZ3F4ZFk3YmtUQmlpWmZwSFlVMUJSOXJMcjg2TjVXdUta?=
 =?utf-8?B?VmE3WXBQdzlydXNlK2VXdjhGMjREU2xFYUpsNThHOFhJbTBrVDRGSU1ENEVh?=
 =?utf-8?B?bmlTVWRpa0E3bEJoRmpsc0RnVjZ5dEZBMGl3QmRWZUd2T3h4NmE1V1VvZnlP?=
 =?utf-8?B?SkQrbFQ0dVN4c2R3S2FDYytNcDBjK2lyMU16aGkrWElxQWgwcE5OUTlUL2lZ?=
 =?utf-8?B?VWJkc3NoMVJoR29oenFGMGVwNWphVG5iWnY3VCtDZ3Y5L0NRTVBvaW1pM2dO?=
 =?utf-8?B?QXhPcjg0TitKQm1Hck4zNWhoWnlVb2d6b3ViTlBRU0p2RHJha29MZlM0VWQw?=
 =?utf-8?B?ZDc3M21US1lKdU9JV2pLcEtYRGJ1U05laVFSUWZhcTF2VnRQcWFPby9sSHFJ?=
 =?utf-8?B?djRucERBVCtMSVVnMklIL21pVG1ya1hPWlFnNHVpQzY0Tm9ySzByeWZOLzY5?=
 =?utf-8?Q?/aDNwXh7b+aboSPmKPROfyZ3f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39568e14-02e3-43fa-f8b4-08dc62fc5f41
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 18:45:24.9885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmWxkOBk36+1Dzu3rY5d9RiBLSHht4BJHsnUVn+nYIfBS2vUdQwK+Eh2wlX68vPiJSrxyrk5t9P+YJ48At8/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

The power domains of i.MX8DXL's acm is difference i.MX8QXP. IRQ number of
sai[0..3] and spdif0 are also difference.

Update power domains information for i.MX8DXL.

Update sai[0..3] and spdif0's IRQ number for i.MX8DXL.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index f5dcdd9405928..72434529f78e6 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -17,6 +17,49 @@
 /delete-node/ &sai5;
 /delete-node/ &sai5_lpcg;
 
+&acm {
+	compatible = "fsl,imx8dxl-acm";
+	power-domains = <&pd IMX_SC_R_AUDIO_CLK_0>,
+			<&pd IMX_SC_R_AUDIO_CLK_1>,
+			<&pd IMX_SC_R_MCLK_OUT_0>,
+			<&pd IMX_SC_R_MCLK_OUT_1>,
+			<&pd IMX_SC_R_AUDIO_PLL_0>,
+			<&pd IMX_SC_R_AUDIO_PLL_1>,
+			<&pd IMX_SC_R_ASRC_0>,
+			<&pd IMX_SC_R_SAI_0>,
+			<&pd IMX_SC_R_SAI_1>,
+			<&pd IMX_SC_R_SAI_2>,
+			<&pd IMX_SC_R_SAI_3>,
+			<&pd IMX_SC_R_SPDIF_0>,
+			<&pd IMX_SC_R_MQS_0>;
+	clocks = <&aud_rec0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_rec1_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_ext_aud_mclk0>,
+		 <&clk_ext_aud_mclk1>,
+		 <&clk_spdif0_rx>,
+		 <&clk_sai0_rx_bclk>,
+		 <&clk_sai0_tx_bclk>,
+		 <&clk_sai1_rx_bclk>,
+		 <&clk_sai1_tx_bclk>,
+		 <&clk_sai2_rx_bclk>,
+		 <&clk_sai3_rx_bclk>;
+	clock-names = "aud_rec_clk0_lpcg_clk",
+		      "aud_rec_clk1_lpcg_clk",
+		      "aud_pll_div_clk0_lpcg_clk",
+		      "aud_pll_div_clk1_lpcg_clk",
+		      "ext_aud_mclk0",
+		      "ext_aud_mclk1",
+		      "spdif0_rx",
+		      "sai0_rx_bclk",
+		      "sai0_tx_bclk",
+		      "sai1_rx_bclk",
+		      "sai1_tx_bclk",
+		      "sai2_rx_bclk",
+		      "sai3_rx_bclk";
+};
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };
@@ -191,3 +234,24 @@ &lpspi2 {
 &lpspi3 {
 	interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&sai0 {
+	interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai1 {
+	interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai2 {
+	interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai3 {
+	interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&spdif0 {
+	interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+		     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+};

-- 
2.34.1


