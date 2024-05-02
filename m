Return-Path: <linux-kernel+bounces-166501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E910E8B9B83
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CDA1C216B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C084A52;
	Thu,  2 May 2024 13:21:47 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2095.outbound.protection.partner.outlook.cn [139.219.146.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890AC8F3;
	Thu,  2 May 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656107; cv=fail; b=eJfJVFOx/maLWR9OfqWqj7f38ey8ddma2Nw86OCrQ9LUd3u6F57x5+UnGIy9da/GlIHuYWHwfWRsuIhBhm1WmHgbNKzl9/T/c6vbACJdJ96ZnHIzzbrIPZcbVltXYm2IvKqDkjzkSyVIfCtwqMKyqJXyWAJciU0j5zHSECFI3sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656107; c=relaxed/simple;
	bh=Sa7Mj290ohsbo1pEDefO/T0g83LDkHIYxLomRyhhjbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5LsZGTk1wHUutnk/qmdVs5ARrlbBE2gTL+mKXTZlOKyvsVP8Kfdl+h7qodDnGJgaKZubg73ZLidgaC5pdNqw9qmrNdMTG7dEWMVCuiuGx2PTr4N2oAe/PsfCd/jF6WPwULzIzAbjag45B2kFHggOtJ+wkUlqPE6kyIxwsy1Ezc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxbEIEUBkIRL4gPVKXKKoj19TK4InzbHB2Jbj/strm/rPsmkFJP5vtC8dJB0k4vaooaTKa58HBT91vncymV3NiuuHAhuELUfs7JjilzvNGUQ7/xmsnKuLW/SKB2AuNFHNEYi/rY7SRYWwyeU0VUSDWm1jocOie9eou9Vw6lAD++DpxqSnuSgBrC1+8D2dc2bk3rbJf0xNqXNWpE2gmiSpzUwaGOf2IA+qJR7puTV9FH4WYbq4BoQMcVQ75i8qqm3qOkTgDKgJe6oY7UV9yqkdafXos/5ieLMNzq0G5MIqhQ50XsxIR6t5oS/9016MMuWWjQKdJFsMX7+0xrXRvixRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nUR3fTHZD3S9JUM0dPVceXYbag/qTldA54Y0UH3SEc=;
 b=kvIKtvYl+MPpcC2OhHHIhk+J9IoLRSs6TaJVeE/p7ykD5pm41YWoHW+ZW2NYBu5oZDlDB8bAvDSfBcZYL35elQLvXrdfZyKBp9sIHR9e6pm0b1qS0ad+1hg+jP5bk+8oF4yKC5kK+9WMJjqH+5J9IKwK9ckABfcbApuwa4ljfnkZWqQwjC/9rx0AIwNjMXRrrHvD3+Z/kMVoaLczsTpc9+qBr4UaHecagXjDItq/kI/db4gy8JRQVwLJSqnoIVVq451CyYyRPWz6WY1WHwEPtvy2uDhwnoOOay6c2xFsXnMV3j+6k08KXKH6YbP34fWUfev2RU7VD6PcjKz1HcnqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1284.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 2 May
 2024 10:48:34 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Thu, 2 May 2024 10:48:34 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eng Lee Teh <englee.teh@starfivetech.com>
Subject: [PATCH v2 1/2] spi: spi-cadence: Add optional reset control support
Date: Thu,  2 May 2024 18:47:59 +0800
Message-ID: <20240502104800.3030486-2-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240502104800.3030486-1-jisheng.teoh@starfivetech.com>
References: <20240502104800.3030486-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::17) To ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1284:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ccb9fc-9e60-4e26-6b1a-08dc6a956a44
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IIm24CYcey8ZSGgxX9j0aJ4CwuQVh8rmQdA69HZNgCOJlbDobVzI8g+nPi5JzTmVM/P+Dy00tb66Z4W3KvtJUwdLm9BwjVEDFcxJZq0HVtrFRT0ZdVGLz4t19I3JnjMk2tIh/BNFgX12uss2/TUDO5nh9XuqQ1/aK2w6PBKh6rTo0FpuK0svB6MrfsiwcAblqrrhclmBCX0K39SlEA5vJqp6NpuL7v1CskH9uwqvIUfkOj4Xwha+Qg9BvzfmNVpK65ZcMUI+bKwhwgnJxF5TUNUW3gieUuz7YfHpRYhT4p8bXf+Ggx9uzZbYSeh/I0KFBKeL5faiJcA+zg4J9DIFOjFlFicGUACBNiJmTzHT37fcXSxsBcDrduAyPkAdUWJbFWn3Dxu1NGNmWYVJmMLDzh10qpr8QzANky8WPY1OoBrCgHEys3g9VvnoRxhlVYizOQvVXzljoeeHAR+dhmlDgq5VDKe5hhXev0Pxnz9nfeCEmCl1+F4v5gWbWCYeZUBaei+YMfVX6yIkaE+nb9QmoLmUTMNeMiMyEh/alsR/YXIlD59/vFISFXaImt8bSo8WDqlJViUfiBf0+xS81iWkZW+YR+RQO4gTgtcPUVEz9OCHMVDYKkHq5aMrA7hgMVNX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(41320700004)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/FUFsA/krzI7zJc90xD1SdhKtg7pbjwEYKkyTZ2ikLc56obAJUCvyKXzYqPy?=
 =?us-ascii?Q?tob7dzW8NoTfeZMwoA5UkiK9E2ujkq07yTWJZvuJ+nBWFQ+CEuaTg1YuZgC0?=
 =?us-ascii?Q?t3hKJgGe43gQX2YrLkLKB3DH4VSgRkZMqPpnudGxBbrLKAmcLMa9StPVv7Pe?=
 =?us-ascii?Q?Nyrsx8xnCHus2NlASWm617TDCWpw9HfRiyu7LhZoHXWF6/7pse6Ovgp99VhS?=
 =?us-ascii?Q?rMlpRrBnbQUert4X/mM+pG26BvLiuEnKrQbBmz7lP+yQHpqOtWfO3QWqdqHl?=
 =?us-ascii?Q?q4nQZT+SSIn68FKuqI26bIMUVzkUlYnK9xTPM5ULim9w07P1NLCSsfxsrr/G?=
 =?us-ascii?Q?Ese46+t3DdEJXlfPvQLGVa0yv2cHCZn4cCOOOm7l3wTDEKKA4Z805cDjnDmE?=
 =?us-ascii?Q?doQ6edWZEWdh0DvBv9qp6LC0tMF6UqHViO5jXiAcvMQ2DAdUURKurhi310IH?=
 =?us-ascii?Q?3WnJsdIqv7RGSdXuV362JqnAles+GnZohVSM3mGu4DZfJD/koorkjZ/Gi69k?=
 =?us-ascii?Q?5u4gdP32QUvhNSH1YlA8qbYjwLYCiczqfsuVJb51fQqpSKxD30jB03uZqpBA?=
 =?us-ascii?Q?11laGKduAghRkCIMOZdoUgDV+kQEtEDPAiRx3/saC5+JF84BqG6SBHmHkjni?=
 =?us-ascii?Q?6vbVNbpYq47t0dHk8a5W5dUinEhwWgzb5Ncy2Mbg/DI128keBTCGwsWq9A8a?=
 =?us-ascii?Q?vcQCAB/y3Xt2ChJZtwPahji9QA/ZTGRg0dA1tqGtukRptrTmoY9tXtV2h+Pj?=
 =?us-ascii?Q?gQFuzjZTPGJuc4yv9QSk26Iel4OlKHFVehClmnYbEywoEuOyFM/cm4i2eF/0?=
 =?us-ascii?Q?eHx1nmFRlYAlTygSprcLkgs5hOeJCQyNjqsMueR7IgKyuiPvfr2D4tQ5Asq2?=
 =?us-ascii?Q?x7C7fuMTZuvYjJ9XBadblOFB2rnbtV1uvsxf3MqqEkqdMhtGZWsMRf097Bpu?=
 =?us-ascii?Q?PgEjJLnNZu5sqDdTlf2bniGnegUekp78c163GfnufmUQzyKgeRaTeQwp+eHv?=
 =?us-ascii?Q?KPN3aAnFyZr5hfnxxajtZ5f7T3rYdtceq+AsUXa8my8MohzQxiBG0CK2yf3Q?=
 =?us-ascii?Q?PJ46yXz89hqNtzPJ1NACGyz9viOqZGf89mO8592G9XpMq+tYA85lzK0d6P5y?=
 =?us-ascii?Q?FVBgOtDNjAen4fIFgCeSPrL0sUVENzOn4hUqH2ZzRlxEt7xOCDKNn2dFWIdf?=
 =?us-ascii?Q?TYzc5AtvnEpQiJ5mfLZOfobO15OUAObDv0CABcT3PG0nnPHC8/ot2hk4I+EM?=
 =?us-ascii?Q?BrgHH/ZnpT4FHlefhvUaoaXrtq4lZERkB0p240fE1TOoaRcx+wdzTKhIFgkt?=
 =?us-ascii?Q?/h+5HpooJaV5Gi4dYMHQlrYvyD0IS5cbfPSgRiKadV4Waweo/4KuDxitTa1p?=
 =?us-ascii?Q?VMRg+gcnlCeMzS9yQw5IhYOyWocX/E96OpwltXv10U2MjAvJ5nYF1rOtL+fn?=
 =?us-ascii?Q?L1w2/05ccn4R0wRwOUad2EfQgIfAGRdXV7CSai0DFPDRTM7/nax/9OQOvK/Q?=
 =?us-ascii?Q?QSvZ+a44Olon4XBftDWNCd+TANS3eTRIXT6kkxZMXwe85LrxX5mpc23C1+D2?=
 =?us-ascii?Q?M60XpfClc68ZPT+0KZkd2Lr4D8IvMzpWokkyh4av5PlSbZNtiY93li05CBf+?=
 =?us-ascii?Q?HDAKpEMM2E1gBjmoIeCPd00=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ccb9fc-9e60-4e26-6b1a-08dc6a956a44
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 10:48:34.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnPnkIRSeKZfrlX413UrBnJDEcGfarp6JPDdr+1KGr6jlowlAQh32GWk4FpskLetSXB45oyfqdtjfQvAx+AM/ewLIVFqDzaG8UzQuyO48hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1284

Add optional reset control support for spi-cadence to properly bring
the SPI device into an operating condition.

Signed-off-by: Eng Lee Teh <englee.teh@starfivetech.com>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 drivers/spi/spi-cadence.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index e5140532071d..11530a531673 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/spi/spi.h>
 
 /* Name of this driver */
@@ -111,6 +112,7 @@
  * @dev_busy:		Device busy flag
  * @is_decoded_cs:	Flag for decoder property set or not
  * @tx_fifo_depth:	Depth of the TX FIFO
+ * @rstc:		Optional reset control for SPI controller
  */
 struct cdns_spi {
 	void __iomem *regs;
@@ -125,6 +127,7 @@ struct cdns_spi {
 	u8 dev_busy;
 	u32 is_decoded_cs;
 	unsigned int tx_fifo_depth;
+	struct reset_control *rstc;
 };
 
 /* Macros for the SPI controller read/write */
@@ -588,6 +591,16 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto remove_ctlr;
 	}
 
+	xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
+	if (IS_ERR(xspi->rstc)) {
+		ret = PTR_ERR(xspi->rstc);
+		dev_err(&pdev->dev, "Cannot get SPI reset.\n");
+		goto remove_ctlr;
+	}
+
+	reset_control_assert(xspi->rstc);
+	reset_control_deassert(xspi->rstc);
+
 	if (!spi_controller_is_target(ctlr)) {
 		xspi->ref_clk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
 		if (IS_ERR(xspi->ref_clk)) {
-- 
2.43.2


