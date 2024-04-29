Return-Path: <linux-kernel+bounces-161655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA828B4F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5EE2822C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01857EB;
	Mon, 29 Apr 2024 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="auohEPKZ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2078.outbound.protection.outlook.com [40.92.18.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75E7F;
	Mon, 29 Apr 2024 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714352120; cv=fail; b=NF6BkMol+JCJX/GEpJ8DCaB5INBzpA8/U1zUshBUZep+2R9ADyr6v55irj5K47woUK2y5kXDOtRoEmGMbmLo8bytb+4BQW//KJagksfy0xGONv0DwM/GsxQWD/mavyH1hLYTc6EdE12vfvp8OlciEWjjOFYDZ96EHOHBR4M1hT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714352120; c=relaxed/simple;
	bh=2vYNUPDUxYPRqRRqjpnP1EKu/ATps5SeCCStcxHXWv8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NgJnooEi2AznOnipF6qZI38FNLXQwUZEx9pmSEo323yBMfV6Is49MBqac/fedh3QYmdCt/vXUj+HQrxDHlyj21D3KF2TsLFBt9Z+4B/DgFSK1pYxDbOQQB8bPQq+kuN11GCWnAgCxsyf9NGL06XBuElbiJtA90cHQi49y+RsEmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=auohEPKZ; arc=fail smtp.client-ip=40.92.18.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYp65Qk37lax8GY5MAMBh3v3/H4KE02QGC54pKvt865xDWzIi+LvTysM0zmYRdTnOctG7r6rXJ5K+Zeetj3fWw1AnHtUzGfGsSJBYW4SIIjsLV4EKgU1Hfd+WqJEh/oQ017GSIHC73KDREp0FGwCslELJ1UV1qpmeEsh1jAHYdumfRcCudN6p/hJLba2295o/mLbElmEjmTVZ3iD5EMJ/5IqXsNq3dbPQGba6Yi62KsylDJMBuNLabyenSmIiWZCFvvA6yPT6byxisAmet3i9pjYppcM6VlTDX1ANXclFlrvg7pqWhUt2YHEdHby4/Q+1PvhZG9WvFKUcwlLKFs+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1SsTUZwZ4D0mElLxTiEo/rdB5EcIIjO60HPxzhDcJE=;
 b=IR2w9mAIi62CO9KbEflJ3BRVZVb2umTzTsxLTJwbXXITu577aNuDJooaNE+IJbdRcPIKegTuWazL7YW8RVp+gr+MQK7Mz0CL9tYIXgnXMZZclwX3fvByLwr/DsOCakLngkF6YdRF9plgh/c3wuSDrBHbzcocGPIuxV1ZDRJ3W3rDdfOv0ALM0LwoYTJP9EELicJHrNE8xq2PrxQsIaFp5h3wUBTQHL/FW0/Qz5J9TFlKopwb9temGaSJ3d2KzUa5apx/6Qd64uq1XvElKuT0Av0FBauhMiUfIPB5CZ8U123flp8T5FbwxH37KHSmOvHqS1aLL+nMxU3BDuEqwS4ybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1SsTUZwZ4D0mElLxTiEo/rdB5EcIIjO60HPxzhDcJE=;
 b=auohEPKZJNcIKsATSj7TZXI4N/pdjdRIGn/BV5NrKs8F6xhlUxG7yiTO76Lvzzbpq919YiXlellAAtrqsDnQ/G+3hIP0jTBgWMc5SycRJm6K+aaWkAwvIO0vmk45o/3YCsm0wENlzdFqy7CdF6AFtWnS51hZN78usk30uUqVYw6M0sXxKxKiiaIWDPZrkMmq0maAn0z2WXZJJUcqoJaK1evM0EWLDXgC/1d6XxPt5jCDaHIQW7G/YnIyrRzytSuHw/+ieKcnyU9FJ/bLl93SoYiQI748BoS4KHObWUmsh6DA5Ve4dTsvZnM6TZQ2oyERNYvkcUH4Px7ObGYg79hxYA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB4345.namprd20.prod.outlook.com (2603:10b6:806:228::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 00:55:16 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 00:55:16 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/2] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Mon, 29 Apr 2024 08:55:35 +0800
Message-ID:
 <IA1PR20MB49533CA5A5D0036F373308DBBB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/BdcicbmmktWIx/EPQrrkeP9fAdqwMJghSz1A0GZZQY=]
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240429005536.160392-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: c743869b-87bd-4bbd-a341-08dc67e70909
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	LdKcHEY2N6gmkKyfWS4JKDRGKPndgvUFfI8AEgwqNEqSU+emKZuVOx7PDr1scJGZ/0GI87VUnVV9c31jMPIH5IwNEyZt1tAcAiawsxsmkwhP4sATBLYS20/KGQZH5lCQ3MtFKFTllp/bWGeSopjA3yDEC1P0OMbwjYRVLnpUlAcBiEn0wLrbtErPIODll293PTb4meT3u2RFIVcQtvRtjICi3Ggg+MR8uDJUggBkGUCPMtJDaaoan2KDUxqc76bzAITZaAyu7jw6Lt6kHVThi5MZISusD+MXx13hOakM5gBqSGLDTSv5Lpik8vn0RZS3LtdifOQ/J2gLbodirnveODkGyoB+rz+UvH+3DFXWq0sY5KNZw5exp32gKEcqdIYA+nfQthPiPbwsZ3N+wjFoWTJ0slUh/RPEYalOK9hwTfsD9GdmoFpHL9+g0N0Wrhs5s1FtY5sl3++rrHHP6bChb30x+r8ZG+zHKWcaIfG22K0DBqf8Z788tPHSdrhC6nJ1csvhuKqfSIPRDFrpDyqVte9G+ISFy1oPrEAsbYfKmSYW2rD75Vxl10pLpXOYiSsdr42rsEFJUhbQljsJUmSAtFtfHM1bb8SPY4riWAq3RYJn/ttEn0ybSXbHrhDpVaZPjF6hV3B9EVxQVIaXNA1zGwG5ABtBPO1hfUK1RgzYYVSu90hTuf5SJHIY2h5ivQhNy7bGNdoDnh8PGi/zWWHkHEjsy4NH4nfbplc5iJlZjoUEHTxsO22qFkPRk9pRte9R
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vvyGsfqt3K41JSZOZPgrgn6qlWJnUPfZSaWJL5PrZYBTugovJaao5S3JZtVs?=
 =?us-ascii?Q?YYSHTwwOZoRL6OWB1J2fLYaoH2VxfDlr99EJzPymtof2mHYqsFFH9CFcAb1Q?=
 =?us-ascii?Q?uCaE6jvthpsQAW0fAMEVa2Z6UONKLX3lZAuvRkVTfDyXwm9E7MQoCt1oWUDF?=
 =?us-ascii?Q?Li5jTzbte2LPz4IKEFjT4Vt2zFRWApANm5kChEe0lf2VcwF4PiVLoO6TaDrS?=
 =?us-ascii?Q?ZEcs9hq6bMqYL6ilADGiptrBr5zHMzyNmGqLG6AURSvHxbXMfP76WQASWJKv?=
 =?us-ascii?Q?CD7gl7uiB/aTRGbpljFLp71NSb5IllOCZ8Ml2EmUuBOY8sAJ48D5g5ITOml0?=
 =?us-ascii?Q?rnsdLt7jqy8Qe5Zz+VDJvRrvNiClFP6cG6pQxp2OA4e+MaoYFGqp8QWPHU9T?=
 =?us-ascii?Q?AWaU5/a6ErVU6eQl0ZWGqIIsiK5kuDVTJcaje/hIN5W/wk4wsjc1hmOzBOLQ?=
 =?us-ascii?Q?nTB0mW6lr6F/mX4jDG+sz3Bd9AtDmiFqBo9cjC/J3khO/lVjpt1olIZwcmrj?=
 =?us-ascii?Q?RfkANEVHqXu1a+gRW7/dJgjwlqxOFgzhNoQkdRzqhNalMhEUnkWp0mPPlV27?=
 =?us-ascii?Q?lQURGKx2q581tOyipYYGvnesoJK7W/ZPpzwGlTTAWtEpCVNVGeOCB1ThlyYX?=
 =?us-ascii?Q?cMT8pjMU8kE2ME5NlY5ElYMTQWRrSoXzmBwNNJ+YjZhJEMN0drOQjYH8Ah17?=
 =?us-ascii?Q?Ny8MPUaBYyjv5xsHWhxc17vInXvAWP7LjfLd9XrzmWgC6P/XA8q3FknwOLY8?=
 =?us-ascii?Q?lIFiqVyD0vAKMiW2oLpPULYaGJilVLs0RS8xYMRac2WaTUvSsyajQkp/kJMF?=
 =?us-ascii?Q?nlyDrbFchcCBwDvX2ug0AfDXXrSPK06Hh9FuoGaHtps+GwDYFkjWIC/BnCjT?=
 =?us-ascii?Q?ZXRas1yttwhfSnxwQoZQxHfv28E0Qck9llzI3CQtpnB+4Wh0M6zVoULqkn+X?=
 =?us-ascii?Q?fC8lzOA9WtXtE5BpWhp/mz7CQW86JzFiZwzbhdK9ZgC28tVIan3OuFj3L0qT?=
 =?us-ascii?Q?1Ir1CAtJg3KQY7P5MlTFtomQ+7VNHb44y0MGNGVV5ogWu+nDtfglt0yi6ma+?=
 =?us-ascii?Q?AofO5xOwl1G2KamQzsK9Q/8a96ZHzqOEIBDkv7ohWOC1YHeAw/VotdOr9OdV?=
 =?us-ascii?Q?lYrqPSAAj/wa8WzNp04rIyxyLoYg2I6bKPk43owTaxwmVAHk/aVFRd8qj8pM?=
 =?us-ascii?Q?Ws8o7J06BPwSlW9QwtN/miO3CLZrinnh3KXzz3JG+1NcWK02GrW689qTAext?=
 =?us-ascii?Q?aeKoB4ziPzGgEF34DyRG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c743869b-87bd-4bbd-a341-08dc67e70909
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 00:55:16.8672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4345

Add support for the onboard hardware monitor for SG2042.

Related SBI patch:
https://lists.infradead.org/pipermail/opensbi/2024-April/006849.html

Changed from v1:
1. Move patch from soc to hwmon.
2. Fix typo.

Inochi Amaoto (2):
  dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor
    support
  drivers: hwmon: sophgo: Add SG2042 external hardware monitor support

 .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        |  40 ++
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sg2042-hwmon-mcu.c              | 531 ++++++++++++++++++
 4 files changed, 583 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 drivers/hwmon/sg2042-hwmon-mcu.c

--
2.44.0


