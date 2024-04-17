Return-Path: <linux-kernel+bounces-148068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF898A7D43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C048A1C20C61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A06D1BD;
	Wed, 17 Apr 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="cQ17gMKG"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2031.outbound.protection.outlook.com [40.92.107.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0040850;
	Wed, 17 Apr 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339714; cv=fail; b=NI6uH+shLAMSSWBWaosokp8k3m4iyiJ4UJ6zdTVrdtKz19Y0TxKSI3sjQEt1aginkihYhInenZeY9FrWMISnf10FadplK1wCeUkFIaUVe9yGSCUcK1ZLTFwYflRF5ga0MgG4zFOu0cPu/PlqnyYKjGktILAYtr03Cxj8dEbLwzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339714; c=relaxed/simple;
	bh=B1A94KCr13rjsMwKhSgPtfzKd+sWXoK4PvoG2yclImA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=utaRpeDddLHJcMA8XEp9LTbn16bclCt4IVRC5jn2tk/9usN3Cv5XBEHAwrB/VsKJU4tp71/lSQCpVd9tKxpcBDkHIt4j2g6DrjQqP0/lgHr+3VmmMDWfueNcI6fvrY0AS9LsD9vJHGNTiKP1OUGb5NF+Dqq0awoK7zyjco+NURg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=cQ17gMKG; arc=fail smtp.client-ip=40.92.107.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6u8s4iLUkFuCX7LHCi8axz2Xun2DpTUTyrkQehDLLn+K5leHapmxkmi24sxANHxBTiZ6OCy8s+P19SZcvZAgPa1XOgJLKcOQXU88/a0g/zsxBXcyhHimaik3friBfYRSoZw0iaBzvmx/BAldLZVB6pIWkuNHQFW0Xh0VUKREJCTXnTLKwGbK+vecexfmgeZ5a7ajFOOj4bDy6sDCpqVq67FIqvu2fT9vqiVK0SfoT8ceeKqcm4uEvgaXzxcwpsw0J6WVL6YKx8J3LruQXQsosoV8O5s5Bn6ljzrwiVi/TlIdfaLP670OG1GUUtAcg97gbFmRhjMZhnB1rmMUhpBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oa3u4Os+yrLu7G4Ykf9zRNpFydcAdbwoVT/0Wu6ciY=;
 b=CpW1Rt42NmBqbKzEwku11S3mPy5sJZ+xeVMQAFs2ubnVhs7RE28VWLvTFJwNzjOhUbIjCOXrYYeh1iqInrOLP0ElF2FSQe+70iGaqAQXOsf5tl6zamiuZRwupAxt/RJcJJaJGSPOc3NHr7yDUQgGG3GenLBwf5Fa8aFFZiIfOSnimo6zIWFq6xFiUfvgt7jeHdRKq6uSo3wDcdfcGEXEa4HIZYGcFyNoC1fCE9Nn4AGaiT+sDtvkJFI3sGUP5DzZLKAxRjXeM35m/h8vghge1eF0pJNruoJOLeNCul2wG0DyKOWbI/5Pc/G0hEoEjPvqPiybPc05NHVSPeMe9L47ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oa3u4Os+yrLu7G4Ykf9zRNpFydcAdbwoVT/0Wu6ciY=;
 b=cQ17gMKGFPceHdP/y9bf9GAevjIFWCgdfLprnu6dE5oIsBELOarsPvjSX6NcewfydgnIWpFy/NlK+rtLG2t7sqogOicsxQAwSmahFlEe92mmH9E6iSubW85lvaDK7T4Z63uPMcXqGLJuMItIPkhvZ4jE8ESQpH2+pqmofv23HAoL2xHelQtYse1UqPPUR6C4gLQpiSNLBT9YAYb5rAt+jLWL1RByTIFhQOZ6GAXS8A8wddnz+6qp6IaJqk+/FoCavqW7M6QgSBAj5b0d40bQVwdYnmjDjKArrnGjJ0ikv7fK1cvN+bypDURweWn54jrKdhq/BbyYa+2CV7KFSeGwKw==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by SEZPR06MB7228.apcprd06.prod.outlook.com (2603:1096:101:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 17 Apr
 2024 07:41:48 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 07:41:48 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v4 0/4] HID: Add support for Himax HX83102j touchscreen
Date: Wed, 17 Apr 2024 15:41:11 +0800
Message-ID:
 <TY0PR06MB56110754EB9D827BE3304A259E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [sf2nz5GcrYS3ORIYuty0zqB/LdXS9KU3]
X-ClientProxiedBy: PU1PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::28) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240417074115.1137885-1-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|SEZPR06MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b6f6c4-5cdf-4f0e-34b8-08dc5eb1d68f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QqEDcdAwSUE6krWOiBZ1R7t84Z/taH/OAXVHyUB1/4Pqglhdx+nIA/Ck1l9AkAmjHcWNJHy8KQVvE4OcUVz8MiQ426Nl85FIltFuBvVrbe99jZanTqRRAHSKo7aA1VO67ju1BaGTCWLncs7YfC3ILca5K7iyRQxhQ0zDvDxXN+6DKwQz2y/Q51HJ2Y+wyOT4P6NUgI22OoPv8algU+2BSzwGgbJLesex8s1KGdO7vS6gMSuD9aT3VsUECGt4eDSTUqasZYoPwHaM+5MXpDfR0DYDWw+PoRVXhiHSDnmO6jejsO1gKbCHdo7Bcbv5RGg7Maoa3u361KxWagqz+ZJ665B07kqS5ILodemIaWsrjvmMfHlpkF+GklWKR2+OBAhuu+8KRsIybuhbUL2oJra9hjZasdM2ZmHPW2tow4pqCJRDISMJnH4AGO3F/w+5ReBAtPRFMB8SXlepMEq16o17NStUWE33Z6BAbML+F6HpzilicFGLjP1fV1qrJRzfBFNB7eccZL6xBUwDh1aIia8ABU6yIV26QTQ1TM7CYb6RvNIki+Lc/84Nb7LzaxFbV7qjv9z6MR8FMLVSVR1uNdjp/1YucpEX9DT6PhJ35QAgseRTYGKBZR/SW3MdrBWTYC8z
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HmjjInY7TvM442sdzhGty/rmeBvmu80+AUh5+XJ8MdFIh4IahubJBMnjBZ54?=
 =?us-ascii?Q?gzS/C68OPPqIokRxf9GWYQGr4a2tdS34N0sk31qwW7kn4NSCEtSiuPC3/Nna?=
 =?us-ascii?Q?GtJp3KOjDc91pbYnwbtyARf2b9EuHuThUp2KX0Wy3gnncq8m7xh1FD7MC+Aa?=
 =?us-ascii?Q?FkCLcXZNscVvqIlY1fa6tG54Z/I+K781xgoxj1fEi/1BsG55VuKtWkVjonDb?=
 =?us-ascii?Q?CUZwPjmy6Fz7LZ0eOjYQsdMPe3u10RtoJlflJnosZmA+qnFKK0PdFYrZ2YtT?=
 =?us-ascii?Q?Ks6N4Dc6DO4e7GOtGen3RGqKg0ndsWpUitV4J5/C2aZqjninTeEVidiils9I?=
 =?us-ascii?Q?s4wwZ4fhQ2sFxinY38wvZMXQ0PzUBhjarPHGi7ahyrMDhC42Y0AM1fFebM26?=
 =?us-ascii?Q?UdYLkFJ0GE8IPpmI8C6onb3eZyCOJrNT7TAeOLhOrtJ79WA9aIFnJCLU37XP?=
 =?us-ascii?Q?5vHMx+lHh2V4Akem4GaxMHuoAu1FOIPoA1qNzrINVY8lYL1sDSNgZ1pRtwMT?=
 =?us-ascii?Q?j/QDwZznwISMFlwG/NFgu448mUTVm5GkRnsRm626iOcJZ3KEKlmMYSKZuK2j?=
 =?us-ascii?Q?mYtTHgNkwo200zmWMaYJ9EBHlLqwDyupP2dNXcS4rfGEI/zUylCzkeqJcSMD?=
 =?us-ascii?Q?xeYFJeFFWVDVvLH+fHJzeoYIdSUABuR+y0iQmE0VRfIrumWpA9SGP4iR2rYy?=
 =?us-ascii?Q?LfBFoAZt90D0i4RxGDbcOsxtjT+bv8cW91NKDPxnN5o7OzpWA4a3HaNL7KtL?=
 =?us-ascii?Q?gIfGxnxc5Q3tTzfAM/F8IpEdmzgnl7xogp5Jmh6tMtMXgZ074vghJbfEEG0I?=
 =?us-ascii?Q?CcyKd2DOOaj47JSMciklUGSYBUTbD49Lc6dUGntyRuqrPtOYxd3abWfJBARE?=
 =?us-ascii?Q?wZ6amb2fblWFdNE3w+L85OulgfBT1lkhndd64L9rAf9nPhrx2acMnRKppjLG?=
 =?us-ascii?Q?mSDXF5+vmkuwCEG56vQZ4/5RMOuxzhY6UiQbBPS/qZbs9wWeR3a3ntn6Gmxv?=
 =?us-ascii?Q?VehZJ7rW/LMmWkGiEgEz+kSB8oV0H3hUHhrF/cOQQzURLTgS3BVjeD+Zpr9i?=
 =?us-ascii?Q?jc/mNJvNL3bNfbc7lEsx8QLsxs/OqhUywN9naQReaiz6K5rxYg83q5HnTO6m?=
 =?us-ascii?Q?jNk2Q4k1jYSfD4CUB8nFqKd9ChPzkIzRb6uYYHD55ISTu0ckcWsonUxqNhSm?=
 =?us-ascii?Q?zju32cDZy/r/4CWNikQ55/6Vp/wMfmbhyz86Zj1jIv2yDLI7oPs5DbgVCXY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b6f6c4-5cdf-4f0e-34b8-08dc5eb1d68f
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:41:48.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7228

Hi,
This driver implements for Himax HID touchscreen HX83102j.

Using SPI interface to receive/send HID packets.

Changes in v2 :
-Added power description in YAML document. 
-Added ddreset-gpios property in YAML document.
-Added firmware-name property in YAML document.
-Modified the description of pid.
-Modified the example.


Changes in v3:
-Fix "regulator" spelling in YAML file.
-Change himax,firmware-name to firmware-name in YAML file.
-Remove himax,pid in YAML file.
-Change driver name from hid-himax-83102j to hid-himax.

Changes in v4:
-Fix "no new line character at the end of file" error in YAML file.

Allen_Lin (4):
  dt-bindings: input: Add Himax HX83102J touchscreen
  HID: Add Himax HX83102J touchscreen driver
  HID: Add DRM panel follower function
  HID: Load firmware directly from file to IC

 .../input/touchscreen/himax,hx83102j.yaml     |   93 +
 MAINTAINERS                                   |    7 +
 drivers/hid/Kconfig                           |    7 +
 drivers/hid/Makefile                          |    2 +
 drivers/hid/hid-himax.c                       | 3133 +++++++++++++++++
 drivers/hid/hid-himax.h                       |  460 +++
 6 files changed, 3702 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
 create mode 100644 drivers/hid/hid-himax.c
 create mode 100644 drivers/hid/hid-himax.h

-- 
2.34.1


