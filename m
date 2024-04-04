Return-Path: <linux-kernel+bounces-131914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAA6898D86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88E22815D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBABE12F37C;
	Thu,  4 Apr 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="fy0U7NXh"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2114.outbound.protection.outlook.com [40.107.20.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570012E4D;
	Thu,  4 Apr 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253173; cv=fail; b=o8YkXHhG3A6WQZiBMGxeIy7MUyCHnT/8BPQAwrLrLmcRSlXWUf1zxlTJT4+9vGjXsAg0OSSI18jj5wo3OHRZ71rjrPfjG/kpjsLkPJzQOSnrPkZUH+WnT3b9ZMBwBgiB4fNMBfVgsPx8//wHRxxsBTUq6IRmN1cuwPejDo/vKgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253173; c=relaxed/simple;
	bh=EZRytNjn7PfbCOUVKkks+WTif2utk3C6jyslB/FdvU8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lVGR2NF4mfi2hVY47NJi1p+cM5aH22+2fO/RG3MQAXlbAc4+s43oe82OLK+e4bnbD2XM8uI1J9+nQqvsLst6W/nwAT3na1PSpLrUsE2TRG4Gufyhp4hrINB+jyBmkJGNbaS2VrIz4ZWqIGH57R7DSlhLjBPYhT4dCdxWAlUf204=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=pass smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=fy0U7NXh; arc=fail smtp.client-ip=40.107.20.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2Dh/KaigmJI/Pa+o+N0M+rkPTgFqPIPT/wBAxo6kSXHDxuhxY1npTegeuhzDF/p3p1ULzKVz4ViTZCDph4UWHedumYh73EL+ASa44f/kzw/azQ3T4qjICy+J4DCU23TR/e3/+XxTyjYm4DoS4mFdmikxo2nJa7ik6c7HTqCcdPJbYr2KggzyO6+3L7jnlTFWiYsocNN4/rmeKJjQQp54ykFX0kDbxuYiPQ4qJXZmJ9MvLs2j53HVyurTnDW+zNckeT2NbkPzzLhz94I0KIiRESBwqj2MN5G0Aa9I5V4KNtm8ATmweAfuY4j/xJxQdzONfU6SorIJ98oXX0yWPPsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRVzY8EgHsg0XmmkJ+UKXyTJa3wD15teSMAC5TFmXy8=;
 b=PxwkQKunU9VhzUrYNUlzl+lX47xq85TuCEHjUNB9S97m2Ms2dEVWD6ptXxKeLV6akque+tKg5mq7K9ukDK6KCvIrrxEXGg3x//ewjY5QQXJ9klL2FFb2zYARQO620B9EW3Y0o+BbWJuyvCfItw7OVEcq/zkjfoOIlG9TYjT54Vd3D3azCBf5izd7oBjyVIdpKt3ZSZPwPmVtvSLuJHF0ENWrOlyR0AvI2yvFafdrn8aIKfUhOVM2UsoTE/CoYjBkbUyfL5IG3Ot1GuHg+Biir6CloJmV1t3m+YViV2FyJT22WQlWoy6flZ8+021fLpJZE4vHO2T3lKM0Ll1+1u2OOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRVzY8EgHsg0XmmkJ+UKXyTJa3wD15teSMAC5TFmXy8=;
 b=fy0U7NXhVbdrCqwPng3OGZn3Uk0b2XDXiZmsAlLev0c1+e44iDszszoDegj4PxdfFNHIIxPkjBsV86JTP8/AF+UcfQa2OyRBu7ulabpaANvTRx+JSHT/Avn5vPX9+hDuJIF7JlnoDtGeDjq7fgVzYg+3xsvSqTz3scrpewgT4bx/IUcLALSb62o2ie0nm1oIqcHR51BJgkem4dP/5N1V6HBhue/zuFpLCjsUCED+KmEDPgpc466hgix3K/SXu6XKVfd5kslzX+bR9yMU3iHnQjcrib4TalE9fXyC2HjcAIWSNjLm3jQCPlxe/7B+gRc/P5pOsCPcTVYXnARIn9hNdw==
Received: from DB9PR03MB7513.eurprd03.prod.outlook.com (2603:10a6:10:224::17)
 by AS4PR03MB8339.eurprd03.prod.outlook.com (2603:10a6:20b:507::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 4 Apr
 2024 17:52:47 +0000
Received: from DB9PR03MB7513.eurprd03.prod.outlook.com
 ([fe80::99b5:2449:1fc2:b78e]) by DB9PR03MB7513.eurprd03.prod.outlook.com
 ([fe80::99b5:2449:1fc2:b78e%6]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 17:52:47 +0000
From: Markus Burri <markus.burri@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Markus Burri <markus.burri@mt.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v1] iio: adc: ad_sigma_delta: Clear pending interrupts before enable
Date: Thu,  4 Apr 2024 19:51:26 +0200
Message-Id: <20240404175126.110208-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To DB9PR03MB7513.eurprd03.prod.outlook.com
 (2603:10a6:10:224::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7513:EE_|AS4PR03MB8339:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ffJwxQGlgDMlEDJImeWnCBIxR42gf+Vrx1NDuKcNIn5VVz87YrluJU5643zaHxlJIH8bPo2xsDvRPfZcUaRWBzDdrh1vASGcZDM4ntKo6qtZaOHpsSkMBNF+994QwwfenBvhkSqbHKjOpe5b+nWjMFHwr0j/wwzlOwcLBErTa3+KmTLtBJNNpu4VUlIL3elS/bPUUskBLSKJtla2+0RMhjngTBj5alkIjIOatdYb7u3147XDy0v5fYd1yRdVdKzAcmXqxiN9dqrHWZKu4VHn3k2D4EPZ0NPqX56bsRX+tpz1ThfW/iEsDXl4KHOq/5PpakJZjBxBysuqgVv5SxhuZjpdhi9jlVFiH+a9U7nh78nRSm5geLpk6+YZ0pubmsC2Mx4J9uTkC30sAJ7ER89xPjE9KWEWx+2XRGDvHOuhFrlmBlvJNAq5U3R2mVfk53TbYwZ+aFvpAR4GwlZ9wrJuRvzIgM/ymqUTDVVo64hdb/rUa+McOLEBIRYUewegPI1XtfETX9OnPMpkNLhJvMoERTv/ugRJF8bvmyiHV1vIC3kUkqyBF1yzM9ZTXkmFsFOEru7Djguj6uJg/TlkQ/szEuskUWyVV4ubUTGZLDhipAE/ebMyw7jJibEzmYeUgdh5tGab6obltyEDxKUVzNDNaxwI4oMRNHeDKYc7L+vTXcfT6EfUdgcMX/3wTog+5yKQjoGhohzgBKkNHq0A+rzSG433Djeoma0h7FQSPbuodxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7513.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ul2duN86phhMzdxoM63VRaFR+bEU2eYEEYy1fTYpynZa4VyTUAUXaUkKSgWS?=
 =?us-ascii?Q?84KKLTSApNofiN7COhx/A1cZ5UbcE/owSQXbJYJ7UWlfWyIe4FFKluhqsqx9?=
 =?us-ascii?Q?12TQ249A8DDtiRd6gG8vtmr0uiL/9qEj+SC6Wb5P2VAgADYdZ6XP6SfKUXpU?=
 =?us-ascii?Q?CrrmvMb6I9KPxnp2XTMIoYL29t3tCVC+BW8kPiFsyaUqYDJpmI2IRJMnSqD1?=
 =?us-ascii?Q?HesMr8q2wTdzK53sqCc/87BWD6guq9G6WNUnJBbd9g+fWmDgLUe+Pd4R6/CK?=
 =?us-ascii?Q?QA6dqYoV0lNORjlofwfTXzOs5pQgmXMw6WsYAMLt8wHIOR9hvkOWAvdVYxcd?=
 =?us-ascii?Q?EdqJpZPIis93838JjC54kS8E2ZBVnPXUXFWXuTdljya/1sZwaayMsW2htbuT?=
 =?us-ascii?Q?NjOhkAq38uWEdtV7eHutp8dh9jfIt5SxZjLPE7GipjXzzoqudAHXxZdOCiT/?=
 =?us-ascii?Q?eZ+/yAAeIOvUgAOcuScXWpXLf3zkucVm3Nduw6I4Ayp6DbkXItRv4gFxTV1e?=
 =?us-ascii?Q?VCRjjvJDyTxt7GTeLprWCKTDPKXa973yaCxRyU+QLWcQtGdbJqB0NA6hsE0a?=
 =?us-ascii?Q?Y+7yAYMi+6oxHhFdPx044qMUOt+YdmuUyxxrCeEqShp4UITi7/C4Rc8OJpIt?=
 =?us-ascii?Q?qHU6lqUyvKhSYMSraYPDu7AwXnb2cEE4PB4V0br+Csi+xGP9f+jegdfkuxQr?=
 =?us-ascii?Q?FUFJ9bKp4dbGU39sL4X4jiJnfUFIAD0QpRarbdSly6WHtTaY7eu8irLKuYTK?=
 =?us-ascii?Q?R+XPL5AJEOKo78Hlw4akT4zsAjVkmwNlvn5a8WW6SbKYUvSd2NliwqEEDsAG?=
 =?us-ascii?Q?ZLKu36xrS4IJXwJ30Nrt5+CT+VRf7mcha9VCmjEqiyaAC/XmjhzZGUdkKIVN?=
 =?us-ascii?Q?55RzqM+o2chQ5xRO0ceSZuGNmtUv4n12j+XeRLF7Z/nLJnSgU7W5xSL22MmG?=
 =?us-ascii?Q?AzYTw0m1oY86r3AdNnb5+cXnplA7sggc8hcur5T7OrbhmdCviQcnv+Kxl5AQ?=
 =?us-ascii?Q?811swNmgR5FCR6BDCMvwpx8fVgApZUyZLh17L9bGseuoMCxm5MvOm8ipYXBL?=
 =?us-ascii?Q?6qtGlTEPYVaubm29Ysp0MyZqIDymhHjtHRY6xL0UswqnEllYCpkYm4mU5cL+?=
 =?us-ascii?Q?v0aB1YYbq9g/UPmm2wVRl2+H0vCXzaacL0ouuMJE7HRzhpM5fiNOtYY7HhAk?=
 =?us-ascii?Q?caak2F1C7qgWHC1nPEuH8NIojRSEgsOIwhAIKd5BLWeTmxfXowHhiUZW+S6y?=
 =?us-ascii?Q?BsxRIyz6ZrupbVD0SkXFrjerbQXH2CDP9Sg19VWJwoiaQutKb3lhEess2SJ/?=
 =?us-ascii?Q?72bOaHWOPfGFKJcX0A4f3IwcUrGYAB/cFIdpG5DKFcDL13vxY8TzgKMuDnUw?=
 =?us-ascii?Q?6LKoXFbr4BAfxZ2oFz4+4BitQ1FwOMvf8EFF7kvzSH2pVTvlL5tlZXbviUF5?=
 =?us-ascii?Q?HfXLQm2T/Hr+8SUhQhLbl/Rui3qlooMFgCi9LBpAqdeY7JJNcP5cSigBurJv?=
 =?us-ascii?Q?Hr1MwrbYmMKAJExnYGGswugUaT+oWy044i7obqEIQ2LT+4AJ5V4Foc8I5k+y?=
 =?us-ascii?Q?y4KV9ibMCLPlssd4LSVKT9++9WRUHVDD3nuMp4hX?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c161d3e0-b2ac-4554-2a14-08dc54d009f9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7513.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 17:52:47.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unnyy/YZxH9fQlZnt3fLW5pkXYoZWH4BQFQfSz6R4ijM9/8RJt8SMIxA8JZnw/hS1FQoj3IQ4wemqYcLt97WUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8339

For device will enable and disable irq contiously like AD7195,
it use DOUT/RDY pin for both SPI transfer and data ready.
It will disable irq during SPI transfer, and re-eanble irq after SPI transfer.
That may cause irq status bit set to 1 during spi transfer.

When the active condition has been detected, the corresponding bit
remains set until cleared by software. Status flags are cleared
by writing a 1 to the corresponding bit position.

Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a602429cdde4..59544c39642a 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -515,6 +515,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 
 irq_handled:
 	iio_trigger_notify_done(indio_dev->trig);
+	/*
+	 * ACK pending interrupts from spi transfer.
+	 */
+	irq_gc_ack_set_bit(irq_get_irq_data(sigma_delta->spi->irq));
 	sigma_delta->irq_dis = false;
 	enable_irq(sigma_delta->spi->irq);
 
-- 
2.39.2


