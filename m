Return-Path: <linux-kernel+bounces-161213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BDE8B4916
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5145C1F2198A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0D210F2;
	Sun, 28 Apr 2024 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KHHgok0K"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2053.outbound.protection.outlook.com [40.92.47.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA37E8;
	Sun, 28 Apr 2024 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714267750; cv=fail; b=GAxu2BOdeNqX0Ny1xaRQfrKyOf7k44wNeEoLQ7rwtW1Y1e5WK8dFU6qPzsfnOnGIo6s1c5IuvTvd6H/XNd2Oxp3bjTINr3584Hn1dphvm8GYVoMBpcx6kiGTl0W8Jw0mGaRtG9jCUvlRy89XXukTJZQuBeXMfdOifV0dPf60toQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714267750; c=relaxed/simple;
	bh=Ie6zL7gVWsSPi6xiyzZZ61swSkT/1YRgXhPScgbogXE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FvM22hvtYLtAmkcYg7PgP/NYUzmqSR/V5sSMQBYQRkRV0wjKXKnv2NREYCVN92d/o32kqW1DUkinwuWRAqxe9Is/e1fXThJ4efC1Hs7p+KeJphs4dgUaxwCSIJIULwERcP3pzWf50rTYHvE90kLkpP8ENm1OSW3Q4x3Uf9vbGrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KHHgok0K; arc=fail smtp.client-ip=40.92.47.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxPABBko7BnQec5wU/JFjkjTp0x08i2jj1lWdvZFN1z85aVJfl+v2ghft20ZeDlFx9O4gmSSWu6QzFrDo04jNUQ6VXUxl/tDrymFa2s25SQY2Bl5eeUsqUgZPh6jEgsl7PdTcU0BpwVoNwo5CdHr9OKVy5xbovl+IelfPefNeqbCT6+NukShQ0u7DASB5P4HXJeRhQQIt7UKRcXQP219DGYaTeivyeqXZzBv8xWgJMQXGvjw9Zrxiuldd0iHpJ3/pA9heWQrbULooOzxXp8uPez3Tkv8Zyejw8fIo1TvsI8QFY1iD3XrnAFaV1r2rOnaiDmA4VecwOIRb0ao4Apf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8Q3SAk42oig58O/Ycajcf3/iHN5wqQ4CweZUM1NMBc=;
 b=ZpfywTiA/Hz2kSL9B+fQYUpM6K9hf4kmAJszMAGq8n70Ulm+kc64PVCNe7HvlsYwopkBOf8552ufR8vGc4VvsHfy864OGslOhpc1ypLaiofAoR2qxsNEP66U8f8P7yUv+CrRbgGmhPuJrWJR//ZzbYuBBwWLcnNbIqWEngRtlpIin3Lqu8Ie+TTAtDcoabwl9DNeuXG+4obonExEIrDGpizneajwKdCHQz1GKs2BUxdwwek2GY4K1JAnYuiXlgX/oIC/pWMy/emedZgwk0wMwi+IKhzpKzU//ClH5v8jfOpLLo3pNBSU6aA6kANo69IGII1tuRGPhFZsbUTJD2yIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8Q3SAk42oig58O/Ycajcf3/iHN5wqQ4CweZUM1NMBc=;
 b=KHHgok0KF0DtJeg0MCQrc/z43L31IL3fCW+qF420tScKy993PQp+sEepWwVnKExs89CTuEG6H7qSfgWCoJAyTf22ZtQ7fmMqBwVuJ7iOKKk4ULgDkwTnQmtrm/OVqGNunxsuTz1ecp/UkTgGtSfg7aP4voNi7juJZps0vJnr7CRen1jcD/yAKjo6otv5NbJnlaK6lxWdOQB7AKziLHOSLBO7fuYUsjPRkd/pYlMujhdlKD4ClolOjNEON2vTWxvtQTG76zXQVyNkla9OK/PtsGvq/rNkYvbMEV82CeJtgiJwz4V26Inpc7urvhT9pmD/SStfrmVkxfom5YHKE9eW7A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CYYPR20MB6663.namprd20.prod.outlook.com (2603:10b6:930:be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 01:29:06 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.030; Sun, 28 Apr 2024
 01:29:06 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Wei Xu <xuwei5@hisilicon.com>,
	Huisong Li <lihuisong@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 0/2] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Sun, 28 Apr 2024 09:29:22 +0800
Message-ID:
 <IA1PR20MB49532A8A0C52FE5C599B6D13BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [LZXC9q2RhMWcsKvQcpB3K2GeGxWVlFmkaUZcy17Cy1A=]
X-ClientProxiedBy: TYAPR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:404:14::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240428012924.474727-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CYYPR20MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 855be870-a59f-479c-7c55-08dc67229837
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	4YRU06LkLjL0YJHv/yimWrMPvRhJ8SgER9lCqgUGXpzisomQKP8MsrNCf1wSAEY3j4+Sa8X7Kot7Ip9JWf+6+z8Eabs8Qj5SHUFxwo5J778Hzasy2BUvhdd9ghc++HH1jDBIN2Fk2otegmQKZD3AeGlEFtDieixP4bjzIwuEXD1AiSE8C+D5kXJcl3KhcnlX8KPGwsw2V23Hwkxuzv59kNfw7KyBGODAgdsgkKgzMspEfH5WrYu1txZAVOKrSjo9CJzsopzrgVo5xXdhbLvJQfTCr68NwjY020uqnmhjOtCokBW9YqAO1vVZ/E9trtJe54NjxeHs1bU/A9j+moyY/MbDubQFsJtBIDKF2braEEVJdsny9xNPvu8q5gwEa/8RuafFLbrzJ18/weZJVMuHa74V9TcR5jzMSyyGmzH+LUlvSQtOTrDXS0zICq4H1ncXkvrUhGePMl+ZU+PzgEIpk/LJOmBc+RHUdnsKmO7169qBQ7SllDnJw0g1EDGI8XI+O8LYR992m7Ke8qqC0NLsAzIsMLtmmJfCuVEIu9wDC62LjXXBBnGiuq//zu1VJh5Djks5BdzWknhtXKbL/fMN/iZDUcpaL7x62chn/5EaAQtyJOgCAG+x8LqA/+kpypB6mZ9H6IyAX6+JJuSQkZ6xu2exFoO7MyOANbplbNZ/SpVMC92FkxcO8vfwNYDXlgwJDnxOtAjGfceVaGJFyFiw3KOsAX8qqpphs1atD3toC7QAifGe7J/4ywY6lUiVl6wF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ETdOJRKiNE853pqC/h6mY1gz8fn09rsIDQxcgKmkzEk1n9WCVKGU9V/og+fn?=
 =?us-ascii?Q?mt2JUKvzlBRGphAnysBQGK0rdA82IGA+NnlcEHpDAVyCw0W3ZdDnGqw2g246?=
 =?us-ascii?Q?o5zPJMjDO2GQ8urSDpfWXuJFl/NJtqnXCZUdLG/9sLEY+VVdAfBhKe4tvfQD?=
 =?us-ascii?Q?HHByZ8LtEwYSNLNCXgxviZx8eGym7tmSa2y6VFWslCPr8IfDoLfF+PVh/Brc?=
 =?us-ascii?Q?M/jXfwdL3mCWq4jIhttKgRVXJdbAC96cCJVUt+lo2iiJbQTzYl0Ea4NizFxV?=
 =?us-ascii?Q?nd56uur+Dc4X0FjDuGW0qJsLLEB5mMTRcREzUIbmFLGEIzJGWhAHiZygAnoL?=
 =?us-ascii?Q?am8o7UyTxpHJAB8keMEqTdLsl3D0XGl25sBbBCuGrrIA4Q2VsbN8N8lRflxH?=
 =?us-ascii?Q?eEugY+ee3Zolk6lBNGkJUPN74g/5ZewrGjFyIf9JQHSVrz7QoTilFNOE4ZPx?=
 =?us-ascii?Q?0zjAUYCp2MX7WLSFtUNQOiUT6YZRr1/4feklbYW9S3oaAm5L7pWtLk5SzDi+?=
 =?us-ascii?Q?z7bs3NyI5nXLhcx3ZOYeoAjVvch4ze0rHqyzfh0Cars8pvOZZUPl8sHKzD44?=
 =?us-ascii?Q?xs2d5RUHEGoTXOLUEWFshShPr7APnfPK7rBVq6n8/Nqyo0BPNo2PpjVQWrS4?=
 =?us-ascii?Q?2FJ6aqp5Om0GFCSSCO3z1qkTtzlgIqYkf5PxkBVID5ZZJK5TfrZs19fZxSfB?=
 =?us-ascii?Q?bB10jiWvGi8v9M3b1GjRg8EkzX9TWIhNm5W3Ck9dQw63loL6uURf+KlcNAvh?=
 =?us-ascii?Q?ErQIOCJeRDZFuK/JTzDeJwtK3aGBww1FXihgWQWOIGHNJdS9YTs73EKq5w0+?=
 =?us-ascii?Q?Hg2omGg9zlxXIbz2cHNeRqxwrFULraiJDxxEtBJgMhrxe/JcHZ7YGlJrRxjg?=
 =?us-ascii?Q?J8SkFAMfL+9FAzKTdERyEyd3cPH635Ljp3cNGcmPtsP4te/zQSXeOVCulxgH?=
 =?us-ascii?Q?txVQsaUGSknlVZ6aatIzOlZO5fEc73n0ecOl/gIMVQXlq4Fs2nnSniYSAmIy?=
 =?us-ascii?Q?F3bGFjP3/oISTT5axMFhrZrXJT6feVF03+vaEejX5QHc9u4QhZ9G/da38ax0?=
 =?us-ascii?Q?Q5Hae+cCGYi6AuJHOlJfT3A9VIEZG8MaloaJO0B7HtdIZp1Z+CVCMtcd6Oqh?=
 =?us-ascii?Q?KwHkQKB0BSpxof3Aqu2I2cn6uFSqQgOCaqL9yEdRMFmfsl4nMGf9VzvBv92M?=
 =?us-ascii?Q?1p0XcExGGMuwJ9ckRUZBp8k3yNhp1p16+MJUuLmiaoDFDAT4/zq0NhLXajni?=
 =?us-ascii?Q?EkomcrxuAn/i9vldiCru?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855be870-a59f-479c-7c55-08dc67229837
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 01:29:06.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR20MB6663

Add support for the onboard hardware monitor for SG2042.

Related SBI patch:
https://lists.infradead.org/pipermail/opensbi/2024-April/006849.html

Inochi Amaoto (2):
  dt-bindings: soc: sophgo: Add SG2042 external hardware monitor support
  drivers: soc: sophgo: Add SG2042 external hardware monitor support

 .../soc/sophgo/sophgo,sg2042-hwmon-mcu.yaml   |  40 ++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/sophgo/Kconfig                    |  12 +
 drivers/soc/sophgo/Makefile                   |   5 +
 drivers/soc/sophgo/sg2042-hwmon-mcu.c         | 531 ++++++++++++++++++
 6 files changed, 590 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 drivers/soc/sophgo/Kconfig
 create mode 100644 drivers/soc/sophgo/Makefile
 create mode 100644 drivers/soc/sophgo/sg2042-hwmon-mcu.c

--
2.44.0


