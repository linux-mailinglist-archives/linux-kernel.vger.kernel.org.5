Return-Path: <linux-kernel+bounces-142124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778CE8A27D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4313B21210
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005694AEEA;
	Fri, 12 Apr 2024 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GMLC/12q"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2103.outbound.protection.outlook.com [40.92.41.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742447A5D;
	Fri, 12 Apr 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906473; cv=fail; b=Mo01G1y6ZXb7ztf8CKOGgs9/Y+lJDBvUJrkf3p6vIF/JGXji49+udiy59WMg+8qK5t67AvJsNIXQDRO5q9QwP4ds6p1x7D95WieMjJHGXANMmYv5GCkkCTa02H3M9FLFYMLgjYswbPGwkRpXbalCkdcvJbKEDQr6RhIPk/ybIAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906473; c=relaxed/simple;
	bh=trpLCH4LdNUuGQyJE38R3pzK1Nb2skmEFx6ewo398qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LzyH130ZZ5Z89LOR6ZoHu9CQm/xWqGzXcpGXCtYrPZ7n2U6E8BGTghidT/+GONFypgr6oo9z1WbJgv13g8gMhw1az6B3nJbrcP1UkpqaHeODzTOhjDTEg+sWW94AXtztGBtw9TTDgDMx6rD4N5i5899WaAsHkcsKAhMtraOC5Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GMLC/12q; arc=fail smtp.client-ip=40.92.41.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDgVP5pmoT8NQtYe2FF3IgdLZRN1GcaVFNy8+f+S8io4eOK9CszjZ7hxemGcc7Y08p6ukJec1ZT1jprCLb5lQnhv5kQ8pB5QzSyTn6C1PP45QhPg01Jrf6Vg1vrAyyOQNRWbOgwqMFYVK8FVidCiz5ZqubChp8jTg4LZh2VRMPFcmMS6Ya5VBgLUNmXl/dKz7/F5bXRUYW5e25Inuvw45nxsAuDuof+QHRG7B+bEOCAQH3fn+6p0sfvv7Fu+hdSNNK+dQy6xbkW8gfe8XvaJyIZMSLQpyvWPV4FEBeBmlUfN4tAqWe2IzTl7bfaDTtV0s7pBspLX2seXLE07mxZ+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7l7S2uIF1msaoJPPub2FPKn5wjRERU0aIBU5VNadYU=;
 b=fAQwUpDtMaWLQKHcGDXZNh6h1vQUmSwf/NSLWRVNU98DCje2SZibjqpGv1OOPUUggkVvwUhN+UWJITtkb0BHznLC/a5T2BKvg82EfjOHPbHV9AGmy8bdPRy/VwRgcNAgR8CkGPokh1dJu659JTQFb/7RrsI71n1Dg/QtJ/sxs/F6Kd/kx02aR7Vz2Emiv7Lj0XRsl44mT7/ZvKXzA47rWxcsfW8Wx374ctHjuBKYISpFmfBkTwz1RZiwwewryByc1KcVIWfPcRcYr27eCD2oMaws5B7yeEBpwJ54+iuSHFvT1YcZC0vO8SqrpQU3iDwP4YGVryKUaWC/QOcig35eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7l7S2uIF1msaoJPPub2FPKn5wjRERU0aIBU5VNadYU=;
 b=GMLC/12qCBOA/zkBJYmkEe7DlN7O5BnkgFKxjKJiwnZWgZpJdV0TFWb3GgQZiYy7yD8JDNj5n+CnjhbLB+Qj3i3cTUr1mL/YOnaRO1AZyCtfZPS9f6U1muzru2IwteacFiddEB7A25g9gDmOvOenPh3PPRfCoh3rmwXx7R9bWsE85amveYhEQ5XeVzMqBwmkr5BpSf38GnnZYygJcuSYp7Hoba29IDnCx4ESe3JN64i3B9FQS9A5iJ7+CrLfzrUVQIz10bKZl6+PyvtM6cqPi5K7TkFeCLv+5DPCQfChm2KvKfa1R6C1xIg0n69V8ApElJsTlGZouxtPAnmGmfcKxg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7544.namprd20.prod.outlook.com (2603:10b6:610:1e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 07:21:09 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 07:21:09 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] riscv: sophgo: add USB phy support for CV18XX series
Date: Fri, 12 Apr 2024 15:21:26 +0800
Message-ID:
 <IA1PR20MB4953780F4617823F7173B6D6BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [jsWy6NaxOh5rWtr9I8+p+hcws0m+1Kh8gY2ReTSyOVY=]
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240412072128.119095-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c225d3-db10-48cd-a947-08dc5ac12041
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3iy6B2zcPcTG6CIJGEFnGZSRu7xgLPUh0eq1nw12S/aC2KlZe+8TrrfjCGuATLEP3P76JdcPwH+qcaB7nCTN1o0l+IggEV/6K440JuNhluUgP9/mW02YojSaTgV/Ytd/MvLRvhOuYZulLvP9HCuW6MS1s0eIncRR7U1TxYcNR3FcMSlYtG44FXqULY7gjPlKYaeoBT1YCQezkI5kg9NOyobzpISqvAF/WUCyPIPPQsW5Kz9zB6qh3EAC1NUmwjwrRcVZQZ7eaEh/SpY53xn1YQAqSRGrmJqle5sWekHMGpBA+AQKDQKgkP7sh8BqTiiCiPmd8Zkk969QZKSsbWpRXy2yI0jMkjOKqOcTFjWRtPqUxf3mYHGylw/U0z+zIKt/1ZDOZbJY5sr/CGE4+hFIJskxh1eaNUx7ejPdPAbKDiECrhLeQSyutdgucNdT9gemZ3qbd7qvMgEYKOS9rklixqt4zdIACvX4eCWXFu244rueJLp/kL+/roVwuTeL6ZjLALsz4WHTscwiIJvcRJ6/+Q6cXng15vAw2gKuChqm3mfUGjmfRi9ncNLuI/sxjk+L9L7xfeOp9I1PH5GX0GX05tqFeVchX12BhxNkGiIUYcExfy8Qi1NKzuVRAyUeFw16lQVbPuOejH6mFvj3zT7aqaYJbP0RA2DI5sMM4FbYzpkz3q9WlTTvDsyWODkHUGD1u/80itkZSIKNtpYQdKEhVyxPRsZf/SMPQu6f5ZWEa1RND2x5KEuZ6NyOR26OOx7t6VzaZKMquJ1l5A8hAEF/TLQ4nZiH57W6NE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fjn0X94+NyRq+HuMqBngOZBF6HtfXuBbrIzEiFHdEUg5aWC2WGyha2HqSk9JfpLjhsO3G6cfh9h5vvIOwjfAJHi1gXJ12WTLPOyBIJH7455TBAvKKoDLeK/Jw1/IIcYupd6A6+8bIjqcsENUAC3BNcOOl+0uBTDCwKf7WGYIj+amJODbUvB3ZqCoQNXzxCjWLn/M4HEYATvaaZdLHI/9hz1PtCX7D6Vr+DqZYobsd2YZci4TdaVULRvteYizsbQjKFMedbkKxOyvDV6CU68fT8ZoRAlgbSRMuenVtB7NUdzXvM0HNEvp+iktzA2KLXSpUa69KaYxo6Qw/Fe8Q+7Ml3an/XbcnOYII9Z71d8ExYJXbud51nzy8GDp+4PXJRzjoTrw/drfeQdJkQ13T6HC8n8AJ4eVEEHcuPu89d6wZ26yzAwSr3W1qYGIWfpHjUw4qKwQwCZv28RGrJTK4WFZ8qCP0rFdIR1F0cLW0cgBXf+b4K4TXMERx09r62L610f6+lBDZlfIqUzePEmPqvQLMJOBDr3i4Uggti/Uspt7D+9ICQyBj25C49U81Hp/eKCMiqVW/V9fyUdaqqYDObEYvJJ5ppoo72XjVN1+WszBKnjAOSthCUiJ78DuihQldMy0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fc7TEiUzUGzma5kvwQsSC26piePaxcos11z/1teEePIuJXsGfBI+mnVFoAeL?=
 =?us-ascii?Q?Tg+h2hcOnz2iZPcAmw4MOSLHhPAKwERgYr2rPm6GyS/pjtKmO6+Irv+KOlrt?=
 =?us-ascii?Q?FJGk1d/w8fNoGSXXtyHIXxzG5mHorvnSp2kwswMPIl+00FofcTXf3n0v/TVC?=
 =?us-ascii?Q?oVTTe3eD7D1tk/ki6GWkRi/UGnbRSNq+eLgjRE5QQaUz9ZoOvmXXieEl+gTq?=
 =?us-ascii?Q?beo9cUD4kVsQ1OLHvY+/BiGcIrKyYvAPnfySB/shOgy+mbhxpWQH9Ii7lGtu?=
 =?us-ascii?Q?0RsNB87otcepZsV7sAXvSLh+SwcZjSq+TgNd3w6vPEXNneRjEeiGMnagBvq/?=
 =?us-ascii?Q?MC9MtRPNPZxqudIIdQff4LaeUwONjZRdTsQ9EwbP/ZMwI52wwZMJtyMu1COY?=
 =?us-ascii?Q?y3KeDpGqCv8H3IQP2qPFoO4uHnqod+E/ORx9fn9aXnyQW+ppJDJ2BmrLqlEY?=
 =?us-ascii?Q?zWeO1ONegxsqvT9p5tiuTRf1huBEH/TGQP2xLu+oJJtIVtaVIN3Gw05Hrvjj?=
 =?us-ascii?Q?DNgPXUnMnuKW/z3nRUub5PSnqUMcUsXACmRaYu4EvudrfUoup8dTPARCLaZd?=
 =?us-ascii?Q?p3R0eofjpymIzuihvVl0XzGMM0u+TgV6CJbrGr/Iw1HkA8B4tNv74opReYxQ?=
 =?us-ascii?Q?asC46yeYyYlhn4MCITG4lrLAwepdUt44BYbB03oN513PLOxEtoADvY1ddwWB?=
 =?us-ascii?Q?2lma1DgUe5jFEl/Vgw4I4xXSxBbD5ASrkZS1/j6k1lhuiPxRip1Cwqr5zaom?=
 =?us-ascii?Q?Sr20pYwCLf42CLtOUyDZy77W3LS4sww37tx2AHmVUQQTviyfC5kaJwnsvawy?=
 =?us-ascii?Q?CnGApTFeIG7KuxJpkhDLzhUwUfROt+MpwiU1SH1R8qaBALUCb17HQvM+5QQP?=
 =?us-ascii?Q?NJhrPJAS2vO9Ni+C+grqgI4aA7Qm+dBlrlboP/j9Rev3XSVXlQMa6G07B3Qb?=
 =?us-ascii?Q?ZNF+/fuL3HyTx3FZXL+lTYbYRtnCfD0Klc8j22CG5ySuujRQgwB9ONeBq5xm?=
 =?us-ascii?Q?A9VWeY4T4Ji8JDIlkFOtZBeuIgYiSSaukg4hUaBHWHs/uUTjdeXlD7XTKsrF?=
 =?us-ascii?Q?a2avWxxP2k5G/jX82+BAnEoLuIY6R1JcApNzKiTDFAljerZwZxOvCAbTtHwt?=
 =?us-ascii?Q?bPi616ZCirL9p/zoapxCPz7urhDipOchaXur+Q005N6JbBOegBACzknZ+CTV?=
 =?us-ascii?Q?PeY6CsES2IiwpOjOJWIVDD5OPS2RaM4A794AQzUnY8YREeBWltwa0meFE4fS?=
 =?us-ascii?Q?8zFwH+N5oW4riGpCb0/b?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c225d3-db10-48cd-a947-08dc5ac12041
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 07:21:09.7549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7544

Add USB PHY support for CV18XX/SG200X series

Inochi Amaoto (2):
  dt-bindings: phy: Add Sophgo CV1800 USB phy
  phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X

 .../bindings/phy/sophgo,cv1800-usb-phy.yaml   |  90 +++++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/sophgo/Kconfig                    |  19 +
 drivers/phy/sophgo/Makefile                   |   2 +
 drivers/phy/sophgo/phy-cv1800-usb.c           | 381 ++++++++++++++++++
 6 files changed, 494 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
 create mode 100644 drivers/phy/sophgo/Kconfig
 create mode 100644 drivers/phy/sophgo/Makefile
 create mode 100644 drivers/phy/sophgo/phy-cv1800-usb.c

--
2.44.0


