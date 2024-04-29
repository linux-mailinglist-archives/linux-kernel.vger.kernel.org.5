Return-Path: <linux-kernel+bounces-162184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18BC8B5754
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4131F22FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A376537E4;
	Mon, 29 Apr 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HTh7Yj1i"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2037.outbound.protection.outlook.com [40.92.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76CF4D5A2;
	Mon, 29 Apr 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392125; cv=fail; b=ClUlz28tKFnlWgxVlmsyDI/G6u+yQBe79d90RLHhIGgc6n3k1015BVHp4ks0tj0jWQuwvc0+VIfgHRkwbFf2XdEvcjrfjYQz9HZFJHX5vGe7U6SeTxjfgtAurbBmDwPK3ExES54uvwvFp71lBVPCLmP5LGL4Gp6ufrJZGywKoz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392125; c=relaxed/simple;
	bh=YDh7WctT2SJpU9q7CEY//29XCijyuvP/EnZCQWiUdnM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dlKR95FmSPeixt8+QDe6iSUA/LiBJvoxXuT306CRcZFkcAu+e2QuaQtSTXDpRPFKyNq230JRpy5BZXw7L0FfnGsimx6SrgHkGvSB3Q2Rpc9AmFbY5NqolAL5+6e1oCggItO+mnUtGPsYQokCvwjKvfJiXVpu0e1Gq7/dTFVJMTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HTh7Yj1i; arc=fail smtp.client-ip=40.92.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2CPp2SqwJ9OP9t/WBfU+kQiSasXULimQhNV1jpUl1iMsyHRKExGN8ykfws0HkVIgssJXLXW5aEE41xlzcZRQ1ThZ48qfGwlXFgvdr5c7efmHzWzX1wy2cJ36lgVi7icmPHj9wWMLtBEZzMOE38qt9BCWVuydRwua/C1vDQLpykrGr0SaAlIX1qQ4XoTvMTBB6xNkKWTbrQFfwQasssE96KSSQyIpgDo+GVbnEEU9Li/Rwn9KpFCfHc7sBnbdiexhMjMykg4EO20bNcflzI/o5yi80sakwrA7vch9DNh/gH+HhLVO8SX8JhkMbD0LEyWzBVh/hEYPpmDAWI9FdZRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMmIiNT4JeFmaRpD+/fumuSYavXjz7QLk1/BI5/wU+c=;
 b=g5McVnUbxNA71WVpCKGckEwAeUud610IJQz4A+8gR9c8QZKdF3RGOs8IXWlw+u6amVYo4scud/cY9V0wJr37ajSyny5wsx7VAMgeL1JnaqqB4L1eeMnguuYmMBZdiGIebDd7CDoPV8HfCAo0cBb6539oEOX3aX5kqyLE/LF7H4Zj9lNPhl7GiSsm0gWlnLFehLfcLEt2L3cu3Pfq4Ncb2dGXpYmcON4whtPvuXuEEG0kSKE1u8wYtDS1v0ZuB0c16sa6OpoIVG2tzAU3rBOZgy0BBJeI7NLYHf5XYcJ4PdZvpmBjxcXymG5gpaRZQ76oeQS3zklDPtD+2pyJ8y04gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMmIiNT4JeFmaRpD+/fumuSYavXjz7QLk1/BI5/wU+c=;
 b=HTh7Yj1iX6Wy5MXNHdWgQWfNFRY2M6hLzFDB5k+ISC0gi5NFBtpvQvUcUUkmVRGDyn3GdCR/vjt4Y38cuj1UusK/tNgyMXepfuVmVt0q5PKmPKvxVxovfj3j2vL0MsqkSUdhjeEGbo1Y1nVw9gBXHmB/HRLinzW1djZ/qTFTGY9vY9c2aeY0EE24iXnJIZUVpweZJktlnHxzOwacwO71rQLMudoGdG1KzAnq2h9R8GsEdjuF43GEaHwrlNHb6p5nP5tNDbV1aEYiuB2gpqwaaWfthwd2kE8Zuz7qPrqX7nt5aC30TcCiBdfrDPl3kmqrA+aCRZgCfBR5L0FH/49WjQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB7474.namprd20.prod.outlook.com (2603:10b6:408:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:02:01 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:02:01 +0000
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
Subject: [PATCH v3 0/2] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Mon, 29 Apr 2024 20:02:27 +0800
Message-ID:
 <IA1PR20MB4953D1C509CC7F23620CCA01BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [sykP7YURQ61I+OrrzXNHKwk5htWbf/WRIfOEZniSYaE=]
X-ClientProxiedBy: TY2PR0101CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240429120229.858167-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c0590e-6692-4b16-2abc-08dc68442d5a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	zhYBmxOvTpSFrdc9s9SVMA4er3YQo0EIAWKh8B5++QjSc8us8S3e9j//szS0dDy6UHxda5SxLmRfOLl7VXGMjLYZzDtwQHRmR99SGmt4ZTwvgXXEMD1RNmz4y3bhX+wNnspSQSccXXG2lm5EKaPoO2tUwzRl1/xOEU8xo61vDrMS58uGlyzudVucjmrs4wwBKu3ptzpE7R7MzlNngaRvUXHfJlGjCOgOvnNm0+2KTdibBTiEYsrITwmGK3HnJN5x68ETOlfNGv3hggPFRvLWQAcQxKqbh4aoz/vixaSJR6M+Iq/zVjnRANi6LANoHXoOdEREocATcFWmHJFXqVHIow6MFDD1FjnYk9xbB+UoESVjIMgQ7j1v7J9fwwTyQfnjtVxDG/fORTJzM/zrUGx/S6hu8mvVgo8LslUO8aYRBsDutPIspe94STwQllWcgVeMhO7kx5wAj1CCJBl1gHfAGQj54rNM+hqDPQnk9CkBxJLxkvSLSiyNiz9KRsANDL3/RYQJne5lsHhKF7UlCV9j//priJt2FyHn04Re62CG1/jsZf46rI1I+6AT8IdYW6xJ/1GNKjPiz90IKS2FVWFy9XRckt58YRf73q8Mz6fgLitZR7wqFHJkqsTNWdm4PJxw0ntQ8ly7LFz0h/NBVvMXCZudxUy/5+zS9hT1Wb+iQdJzRe0rMYLPTHqzT6W322T7hS9dDfPtG+609F/XItMo8BLruzW8S+0HyTCHzDGRQJYB2ssaFT1ux+3M/l0QU+Uo
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHdsXmPmTKdPtupiL2/yRxwf4HuzCingOrfzAZV1RvoBlEjEUE4WBKlrT40L?=
 =?us-ascii?Q?ibxkfZ/Y57V/a4yqg7Wu+0cJyx4nuDyZ4xyN6rwWx7ZwnT4Ma0Au4ACoajdP?=
 =?us-ascii?Q?utHIizw+zfcfvWhxaC4D7AXYDUAgjy3SJK7bfJRQmS4qZTyEwGDQsonbPbd5?=
 =?us-ascii?Q?WYxbOH+2vcfzR9IK2shfCx1bo2Q45GuQqKxTbJRXWuavADhzKobF/vpjRmNq?=
 =?us-ascii?Q?cJ3z/r0gsvlcH+cFEnF77/6MU2jnBhvD87CQVsFDuCauQUm2dxU91mhfUps1?=
 =?us-ascii?Q?Jdd4CSlOuWa4WWRWZqly0kKfKM/jjOkYF8oEsHyIkd/QbFmVnJO5UQxqMC0D?=
 =?us-ascii?Q?UaeM6OmfFNymdL4tAF9WC/7sSaLuZuVTEveIrmGUowIFdhdoBrIuT7UjvUV1?=
 =?us-ascii?Q?desyNmKGDzp5URlcgTEc75Tz3E8FICsyxN20iJtCnlDCkvReuXPhiMAswMnt?=
 =?us-ascii?Q?y0PeHS9c94yIlpl5cfPe+ZwRlPhFqIHWidWvel1mh2ROywMqDP855RtVFUKO?=
 =?us-ascii?Q?2BZ1TetEHYQZQbvY9m7WmhbL86EPvK3vxjM4ct2peHvLwwqZeYa9e+YkvMIW?=
 =?us-ascii?Q?uUpl8LgpUHRGOFXQgl85L92Y/zPB9DbRrxGl1Jn7VdO72cHotml+IhPgCyfL?=
 =?us-ascii?Q?f/G9KWq4n+epO5bQdCPvsVBBbHGXl6zM5yrd8xySEtauxRjhyzDDz137I5B7?=
 =?us-ascii?Q?NMopBhyjgAJzktS2/9J4dC4WiklSJPQYTql0atC+BHumN8GEeDNgOjqANz9F?=
 =?us-ascii?Q?18FQyYcdfa6O32mgkNBMxBn+AbEMvQvF23ZJHJhD4fmqYz8o4shCRc+5FL5q?=
 =?us-ascii?Q?5s0WFgXxPsWzG4uJpC5Uml4pz/2H15LUCcLiWWKnLvfh27QlbfU4exAci5we?=
 =?us-ascii?Q?PEZ5ZDEu7rBKattOIvoZsI7IXem3uS7tVUudR7mM9YybngQSLAEL4oTPlust?=
 =?us-ascii?Q?tgzZGq8yrWClWWETmq2VuTi5O/8vOhH/yPcEj61q0kwklcxwyerLyxnEmYnF?=
 =?us-ascii?Q?96bOjZHP0wxv/ULjXWr1H5loHsKWGZYQkc+SZ5RlIGkrE9sbRoZKou622rE/?=
 =?us-ascii?Q?kAn8h8WtEQaIWeCoNzhoDJGbtDZOS2AbSQ6kvab+FxmmjKymGLafvZYlvhtE?=
 =?us-ascii?Q?5e6TlVHXA4rmS8Yz7La6GEpFoRNO1zJ4i4b3oKhdiNwzTwZLyMh2vagN1ndx?=
 =?us-ascii?Q?6FzVOUMrV9fWUytPrgn8fJxEhwkKcxMHA+byv6hiPcmnoDmY0d6AkTN/KC3H?=
 =?us-ascii?Q?3lT+MLpqcmIGtYvW0zGB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c0590e-6692-4b16-2abc-08dc68442d5a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:02:01.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7474

Add support for the onboard hardware monitor for SG2042.

Related SBI patch:
https://lists.infradead.org/pipermail/opensbi/2024-April/006849.html

Changed from v2:
1. fix bindings id path.

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


