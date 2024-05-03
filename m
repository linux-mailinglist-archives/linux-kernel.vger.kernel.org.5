Return-Path: <linux-kernel+bounces-167177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A9F8BA542
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2341C21F04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371F168C7;
	Fri,  3 May 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OXJnfOCv"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2048.outbound.protection.outlook.com [40.92.40.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F517984;
	Fri,  3 May 2024 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702741; cv=fail; b=d9XLnmud8IpbGUrVGIqkANiQBhXd2KwMa+C73SkFxF7hg5esX+8aJCShTuh2QA8hemONs693RBEphQvzz0xXQb4ub70d8gKx35xo2PkcLXMlzVHzPv0YcAv6xlewOWtCQMmksklY+F/urSrff8hLZ/ssY2jWuqYM8T7k+Vhd8JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702741; c=relaxed/simple;
	bh=km3KtIM3pQOU3jzGjmpN8TTkfeZV6sMFIE9E80LQH3I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qBI/PVeDN9EqA4VA9WKgqBVLtjSzJPLDlG4UJWv6VkebvgUIYZn7ojpMe9cd6rl05jjw6B+MnRU/G6HyOqG9s9ap+OzZexFU6g+6Tj/eVLJswxMa8jEvBJxTYAQtcR2/FTBTTtME6HTfxSD0wotn7fL0FPC7peFnGGPntrd/ZB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OXJnfOCv; arc=fail smtp.client-ip=40.92.40.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTgwUyZVnMqr8DcybbRwzLyq2LYNf8WP+F5/YlUT94cgJM0obPBvAUNXrJ9KMzpBBImdJNiFPtf97i3fXkxfuPHX/3Xs+Pdki/h1o9Mg2p/7MD+ehVHm27vTx0Rq2dC09rSTjfY4F8/RdxB6wD0GhQ98H9fenIVGlQDoxa6in0P4X6kL4H5T9IvAw9ZwZ3lxIO2xQ1LfdnFzZj7bySwI6hoOJBEGxnpeWbKbZ1ch13/Ws9f7hwVZOtCWcZeAkhzrVOjmGbJTdft+d43e2BXATYWBRJ6c7m+UPdOnR9wBdehXuVQKCnWziIUse18v50dq2Q3YR6r78uM3axoUD5q3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ud2EVsxx+GO5U1A4/zRqMFMJRVM1Ju+SCGZsxk+mtc=;
 b=Hj/YOTdvIo+TC9DIRgvhsnaedVJdcTNSEXDuCn19wuZY9YquV92MAVGTYQ2628jhxAqKMXS9DFsNuxeQLaMzhlFsPrUvsKON3pbyg6ZBrq0QRmIkf/ZrQ4xF+1IeMokCWvJJLmSUVOXx4FV/vH0OhifdtokQX4GyaU37y+EzSurZ86aYddPB6MdrSayOtViQFFYZ9dAJvHkMfZmC1IvK8FHyYkXGruamAPYXu6i8pofdwpMRtOPWf4SQmomdBlc12SJQ6TcdpoP/JQ7Fimm49uUVI9T787Gvc4mUDSsV5oPypE4zzElqoRvlZJijmmwn890eB2FIp5Gt5UK3a3zdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ud2EVsxx+GO5U1A4/zRqMFMJRVM1Ju+SCGZsxk+mtc=;
 b=OXJnfOCvtPp+nLughzmaYJD0J8rsvveV6qPi9Prdali6sg8FB2A6d2SGwGw1lpZD5TuvOBvIIguSOT8AOYX0oRWU7A1kpg4fpNw2V11IHXUkB9avQsh4spg4vn1koIzZy1MTE68P/hwwqLnCGvQpm8C0d+Gjehf1FysgZUGgUfkWZe9Wsd6zlB6ErhJiLV+rogAUcgK3ukoLj3Mo9aXPNZhHTfUjsxeb5Mf90Mh2SKIQrJFlWZWqqvYNZfYZwKMW0JLqib9PGXtfmMv9ATZ8PpgI7ZJ3x+qVqtnbgrFn4+KZXkJusam0qslroh4nVtATNG8WXVy06GJsweTeU/aPVw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV3PR20MB7003.namprd20.prod.outlook.com (2603:10b6:408:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Fri, 3 May
 2024 02:18:57 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 02:18:57 +0000
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
Subject: [PATCH v4 0/2] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Fri,  3 May 2024 10:19:30 +0800
Message-ID:
 <IA1PR20MB49534B54403ECFB15D952A8BBB1F2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [W/rgHMGl8jyAQ2KJ8/ujSIdgfDX18j7NRhR0QZ9xGfU=]
X-ClientProxiedBy: TYAPR01CA0216.jpnprd01.prod.outlook.com
 (2603:1096:404:29::36) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240503021932.897404-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV3PR20MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8dccce-e96a-4550-c81e-08dc6b1762ef
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	8nTxwLRhk1iptlkIOSzO+H7AksfczkdPUEVhi9Jw/dzbm9lccGeSI1V+zTbQSaBi9hvYZePcfAk7RIhs9wSst8yquzHYPsch5eQsutWbF1QFNTRLVtpVhttJZJV/A/UQKN99e9ujGVMru79JLxX3GPzThpx+02CM6gUw58o1LlJG8zYlU18v0EFl88hXJ6LGTPgCpDAy9aYxfYYgU+GOsbIMQle5gjxN/ivIgbRZaG6DSEB0UWAJ5bFnwmcq+ugkJwhQaJ5TL42yh8kdgvq/noU9/3CY/9z9K/fWS38SxLS2xr6niggMqoQf3e9SIS6vp0Yz9dUTQShBj20QpYh6okmiAxVEj/ErQpVvFVn8TcXafIH1jprZ+c43v1DZHGx7ak4mtPgVPhYrK+JpV4gPsskxTNvvcyKOTQi1TtW/Xw6qj8pCKSF4B1EBsplXgcTEMZkLmQ+a7XGW3X1b0MbdJt1yHetU4Zo4UpYoNazcvoNddPvkJiKWQb46AIG1bjIkd+ij+mxLtB1LlKCKo1P26f7ASSfQgR51ajo2zPDEjSwa6x1xUHs5UQFRY8crM/CzYblkCpn1ndepsogkYhCZrWHpMyqB2ZRqLRZ3+bWMHPFOKrSRFQHUzlUK9YNcRjoXBCzSD/YwEoAMxfiLq+aVoGmBm2YLHv/nvdqQNnJh/oCcZp6QB4wm1Vcz2t48LGuU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/Vx+UoXM7BhPjLLjQzXaPdJ8xyjEdY/1AETeGW1naBuOEPiyvL94PSZg1Dr?=
 =?us-ascii?Q?vhAg/WQU8NhpaPvVNzyzy4wgKw2QEw6urHuRmSMYegWTEN5NLxJLycEi70ZE?=
 =?us-ascii?Q?cs0YXZPmeboVDFs5UAv3Vvxy4hPpg6sB91shh57uyjCo7cEF+WCC6nClSTNk?=
 =?us-ascii?Q?dGetarGqxwhbKkzyRpKdQj5ZiiJqjJLb6v9AGxHmOwl/DFzMucMA2+q2ZlJc?=
 =?us-ascii?Q?3vkIQYMW76YHo8Ymul5EbdaSPbRB4knjrhTlWT7oRbe1QmgnJYs/tl020UfK?=
 =?us-ascii?Q?+hiN3YIc7lyKnxbPqBlTjiQG2fXCwcsk89a7/P7KQDPH13WQ3eNLLvhNWMRz?=
 =?us-ascii?Q?JAYIp7owlNJRKMVoAgXvHCcIQ1852D/TEfp9OYE6da4T59SMov6mVCw3SORx?=
 =?us-ascii?Q?LCH4kFIbdJ8qrlpy+65xMOd2CJ7SBkOmdGE4lF3Z7vKYwskO4PvXotJ1tFzA?=
 =?us-ascii?Q?H9HinT/yIG4KSetqFm8rihojPxrOFc6LWOd6qyMK6uBAS/VWu7hE6U39fmu4?=
 =?us-ascii?Q?P0VBwHeOlfFPqTVHFMQ7BzMZZiR6ft7SbMzHnAmvcHOWWLymogXna5ffMQQN?=
 =?us-ascii?Q?jlWZXdNy3rAvNneYhf7ZdjR69h5fXVyC20FlNnEZh2c7veRASqGbDpw0c9Xr?=
 =?us-ascii?Q?nApZRdIMaN7ua3ckXmrEXmDstCswlUcF0fFMHDzDzGnGQkIoguVr6bDlwEyX?=
 =?us-ascii?Q?7hzkT7+V1uCoZ8On662Yrv4YZXmIVBmBMFakfj6wxng0eQ6ca373I6MZF4Gv?=
 =?us-ascii?Q?ihuGCycKauubAyEYQ6GZQ9AZg+skT2lxSBrnAmBDrr8MUeU05TPSKbRxslwm?=
 =?us-ascii?Q?O6tCUojyF2Lr0cDY9XC+ZATclmDM2QnYCVxlYL9iWPa68VN32nF3f2R3A3nB?=
 =?us-ascii?Q?NZxU1sX5sBm/LuwGXfv0vux0FdQwOLM899KM14rDG6pR24Bw9+kRQOuFt4xj?=
 =?us-ascii?Q?JuciAApyDGPukSQACFM1NBjc6D/OdyPJaDGSs4ELsyjbxH4wQdsLdwDoDff2?=
 =?us-ascii?Q?4MsJwlLAmqmRZHu/7l8a7ht4Y3+8qTZ/Lywj8a687I9qpUeKcLFqbJWDiOJ8?=
 =?us-ascii?Q?Pmb2SK7X4583UZ8rgOWbyYhZMvSD9S7k2SBnJqQP+cg9j6tNfZQIUtMwJ+yw?=
 =?us-ascii?Q?WAz5KX2nr57QwzjZhr5PM1K2/n5SePYG5iqmFfH2iNl7K1qkldik9vMOPJFK?=
 =?us-ascii?Q?/BZw/wlU5ka0t7HC+LSfOTnG139PcUOJAaFuCglaiWRuGthOl4Nv8Z9Lytxy?=
 =?us-ascii?Q?C6ddV/JnV0XWWs/tL3ge?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8dccce-e96a-4550-c81e-08dc6b1762ef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 02:18:57.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR20MB7003

Add support for the onboard hardware monitor for SG2042.

Related SBI patch:
https://lists.infradead.org/pipermail/opensbi/2024-April/006849.html

Changed from v3:
1. add thermal-sensor check.
2. change node type from syscon to hwmon

Changed from v2:
1. fix bindings id path.

Changed from v1:
1. Move patch from soc to hwmon.
2. Fix typo.

Inochi Amaoto (2):
  dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor
    support
  drivers: hwmon: sophgo: Add SG2042 external hardware monitor support

 .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        |  43 ++
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sg2042-hwmon-mcu.c              | 531 ++++++++++++++++++
 4 files changed, 586 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 drivers/hwmon/sg2042-hwmon-mcu.c

--
2.45.0


