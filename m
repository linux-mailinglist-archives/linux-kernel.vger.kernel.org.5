Return-Path: <linux-kernel+bounces-57332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5F984D715
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EF3B23310
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557BF4EE;
	Thu,  8 Feb 2024 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VKuZlJ7S"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2053.outbound.protection.outlook.com [40.92.15.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328401E496;
	Thu,  8 Feb 2024 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351692; cv=fail; b=Xcnn8vH+wO7sDVkLgmJLrJ2El4LEkf1xJGHV0VGvPmByrndSSWc5sZDFFF+BRI0dMaw0ZnoDq/VzJfVdP24mzg0hl2U/yBCidIhP8Vidmx1+6YYsUXCzW5Q61S6Cee/w5/1u0h+eS5w6Xdo4xOBQ5HFscizHK8ygqlD/vDin3UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351692; c=relaxed/simple;
	bh=x7FOsXNNfa6ZgLkKQNDoVAqKgR+K/OAPwMv9L/AcCIM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OkSY0mo7COL6wSAIcEnhVtMUiglYa1funKc3Pt+HyqrePwg2MinN0tJBg1uXUdTZLOJbf46Ho7Mf3qkmdT2qPkkD4jDdSsyvHySTqdW9Xuk3X8ptbdghJUn6RYNsOYPmSe/4ZrCdgQbaUJvJ7yVbyGo8/P8/E79pDd4x/h5vYb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VKuZlJ7S; arc=fail smtp.client-ip=40.92.15.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvJjwZzCaVhlvTzJbKq8DJOZCUQmmZbl57SHmkb29mO9KkZmOnMKbfmaj7A7IFzFCXLjGOx4FjfDVZj8qfWzN9eCX8iLJmXkYjXjftkUpCtECfcEuWM7Y7EfhgQAFqCKERpyCqHrW8cyiHdzFuPJdbRKjN87kmYN6yMVfXlG3DjkbBcMcAwfRwZWXE8k9CUhRztciHPiYGLNpaAPpLGAsLspsnKZd9bihfmqHbfzf0yf1ZHiK9OlTOMYT+XSFhPbRJ3m9mLs1xxFy8h/N/SVaprkfJFTj+YCSSpdZyiHAaGgpWx4OMFlmJV2/9/MkqbCNINFpLpFA60dREdS7YhgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGezQzUhQovpjvb7TPzDYs19/RhPOvl3Wlec5xnoyM4=;
 b=UHMMsRhrrLKtidOnbOj3EtV6tAApoNbpzYxPzAghcGVMYQ362/XH5PWyRznGiSAG/3I2PxQr4Q3a59JDHH30ZUgXjUWZuDdXCxY2UWHC16L6IiCvRXlHBs3I/jYIfBMjWCdWw6odkeN2Mg+u6C49hK8zG48ldq59w2PUcRqn5dVGhc6TK47hjr5OWDqu3bOuM9bwu9/pkZSMmLiDbuAomcDNdiH8Og3ud1iAXvq4RqMtCo59U/qdAIlSkgGnaMSdolDuxdJ0DkFdSFBTLNdrJV/Kc83GcOmCeIn+AF1L06dhbgW7OKW+r1noHp39Ex26grrLbdYoKhphpcRPz7MUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGezQzUhQovpjvb7TPzDYs19/RhPOvl3Wlec5xnoyM4=;
 b=VKuZlJ7ShvQsWA8Y1v6a4iFg5MovAPFSl45J5ub8AiigJSOHaSLOnRuqwSZyh8+J2LtCLTHLMSIg3RROwyRgEMKb6EgMH6Qr2xkdjgM6Dwtw5ExU456I4le81CvlSQlpWRjlJpDqnGky1NmKrJTN62g+wvQTNQn9azJTZGpwmutf2KBhXuQvBwuV779Vh+h+1pFq7lNpJcsWXI3rMl8d3GbMY0FaT6vqj2eAZFLIYVEmowUQvLScBlinrMASqkuGcE61EUyKt9SxtYKNvOxyPr5f9jadNjOPeeOLyZnrRioOXoYQeGgEqlN2OdgQpwXOGmAzU4hIGqX7Vyt1wJFVjA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6986.namprd20.prod.outlook.com (2603:10b6:806:3ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 00:21:28 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 00:21:28 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	Inochi Amaoto <inochiama@outlook.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] riscv: sophgo: add i2c and spi device to CV180x/SG2000x SoCs
Date: Thu,  8 Feb 2024 08:21:29 +0800
Message-ID:
 <IA1PR20MB49539A9C5F5CFF6644ED2C2ABB442@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [bJWcXTvnHmTI6UHIS+vfUDyU80EOX8KESFfzyIaYk9cTTUUUwEUf+hJmjTCUXlnL]
X-ClientProxiedBy: TYCPR01CA0189.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240208002131.162432-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c308ba-baef-431f-425d-08dc283be476
X-MS-Exchange-SLBlob-MailProps:
	Om8TgR6f4EBS2ftQVFRXvBH1S2ebRITSsr5Ej2yRezSpnOKhlTFTpDa7AkzAJNH2Wu60oFK5OWM86lEQU7+sFIOpv5HFAyPGqpQnpH5r9t0+tfVTiXYJojBvo7sIkmbDBpAcIK/Sw9HWxv+TUqSGbzUd05ynFIOOp9Un/aEI7N42ZhQHpdhuw3bh2GaZ3jBkROnfTptBcz0Q90OQ/nm4aPWQP5SxJM74wlSVzOO1zW7IFdO9MSqCtjgPMN8GK2qENkFTwoGsrOTxODpaI0VgmzR80KtoGjtr6XgL9M6bonQNjo+IksqkAjonqVY5JcDSFDlrLF+Lx63WLlZgR194IRt1SM0MHuBVH1WugIEnNwS98jrAbNAp60LpyqGcLoxgSyXfUFfzxPZGOLBB0bwW53NTyJxNAhvmqDF9zvY+JzKhl3O1fuO3YExGYNFVpgsjPi5gFSbxW16Mimwm+abfOAEH0b47Spqj5Kk9KLznmG6FRhKnn40dfDYdtZmiOG2vdEuCIoSYLgzBokmg1poyV10skJrmROPdNFf27WKLrPc8ai4oHS/PpCPn12GAHmhtt9ud+bxGZ5ZFJk6l64IWP0JgFVCMnLu0jVyQnYx4W7R7CQACWaowZu1nG8b48zDnaCQw+cKCQaxdecwaBzruOuc3CZlGQmZfqNWko+ssU3+QFs/3iBdMNtz1fk1UZpjXDkN5818noeUnjCwSWtxkYORC12iTBEjF6UcmGkbL4fIT9Nme+dghcFq6BvY+AkC7FdORbK5p+3Siv6N+jv697bVXmtvSzOGvVer5vF6PmvrrrEI0rG/oG9AtZSYDVj1Sq+5WPCtrT0XumJad/0MDSRlpISoc3MxI
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m+I/0QrCtuzxGlsotQs/ujGS3I1GSQ0nwvZ5V7/chSnhdVeEz6GwXCipZsOZTALh0QkS+ULRLWiYJ3iEwITiAJ/il2UL7KtmEa3UoQSAyPFxjai/tHiiAw9UbJRU0rsXLx0WO4uLnSjGQdGFeHGW+KRl9ZFL2grNd0mr55rdltxRraMl5qABzkBM3chu4aVWGpeuFQ8QxdDSZQVqYaI4XsbExOMcLzaU1IUtmdiOh2A158H9Nyze4nwkpzEN/MAogHJEjeeQ4AzoYzWQGGq6G5XJuilcO4QNoeZNObvre1lI12wB3dattcliMKMsqfDM+w+OE0JI+/dALoRh1DMq893Eu0/vv56yZ5XedlFcweinubfBGCCRjYlqByL408xsp9KCrnBJYFvXInKVtafnnhe/0CwY7/xNcCR/5N2VQW4yOZbggLDEZy0ltY+yfr/B+KEcMhXUKC5RcOdvzPs3U5Ei+A/eJzIL7bHnmDFMViIdErWhEl1TLsrDdtW9jca0d+DOffXQgt+Kdvi+uDQNViqNcwiwpitNLp1VmdhbwPN4y8uegDmguwZZR3ux26Yi8CvbAPy6yhEi4b2vFrl74TiSqUmaEt9JJRrd6F9jMMq3b1WA3RHmfo7ZsTBg57/k
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cBTMRBNrDkL7sNPWEI5b5puQKg71j/Qrnh91IiH7XyvuQ/Nns9tOSy2g0Mz3?=
 =?us-ascii?Q?NMXxj8CmUVj5mIU3llap6zMX+yVG9rFTRjzBHijc1hfRXua4IBQgiGKVGv5L?=
 =?us-ascii?Q?htSeaQOZUS6hGD8yQeMkjAJJRT6u7HD9mXsTJxLEXhCLSFOG27HWz/W8b5vC?=
 =?us-ascii?Q?vk3kv5937fNqgroXbu/8aRSrjadIU1abYgz30WuV6UQju24N3YDDzPmovMGF?=
 =?us-ascii?Q?RMnM4BLMf6wG/0o8ja7NzEWYZvY2V5jbtiYIGkVQpIAAS1fES1kObKb25bLe?=
 =?us-ascii?Q?VzIHTRb9pv6Z0iisK46yAEnKUhm+s08IwbFfYOgtYm1rzQEJ715IMdiisV7P?=
 =?us-ascii?Q?dXPMj4MbrxDFUcGDO7h1HMZR7iBUEWtS73jbQuahqQAmysjndgRbC3jaY5IL?=
 =?us-ascii?Q?3v7VzeNNMfhit+i6pV8BCJ71kXhed3l/KMVtfZ6BHYAz/r2F5dLYvLdxAjY8?=
 =?us-ascii?Q?t12wwPzaItuTTocWxQNywnu7XeJHlkxbKFrONztzs6JwjV45yhqZ9qWT39om?=
 =?us-ascii?Q?XydtwVefGjK6XOoZjcQSpqCWOOg3fEMId8/40kUVzRDzAQcHzS+w2TXFeDSh?=
 =?us-ascii?Q?inzYjH0W3yx6iktQzNV2dKOUiPqQqv4t0ktx3L+oxy3SKr8jlzDS2fpwO6Wj?=
 =?us-ascii?Q?5C05M0sA84PnLSF8qsYNkE0kNZOtjhCLjvBPZEpw6nzffXzB+kEXD5l8osjV?=
 =?us-ascii?Q?L/IBRSHqSxOdFiD4hIo/dKwGYM/ms1Sczbt78rm2T/rkb16xm88/wbdWJVMf?=
 =?us-ascii?Q?4O/QNc1NMYb3J1FYRm7uL3ScbZcM2CNS2gyLlPVgXS6ouEqm/tBbVzNsppfU?=
 =?us-ascii?Q?wjQaMLL60tyjKU4YXa8y7UDrxOsXeg+EgFOqV+jHwXfHjzOeDGBhKQb7t166?=
 =?us-ascii?Q?lgQWD4vkYOi8qCbCSXl6m4x7dIad9hid+HYGoqNjSQ5ILdA/uJwSYGQd/kpi?=
 =?us-ascii?Q?uiarhSfwJRMVSQAHbBNW2he4Y2B+CC4+B850yK1tv7UTaeW+66ttkdZuQSHS?=
 =?us-ascii?Q?PtwSO7VogkL2TmaLWIIBpAbBRxx7gHF9yNTqB0fYymihuSLZHZczt2/iFujr?=
 =?us-ascii?Q?g4uWQjifqEp2qEldV/RiHx3uh9kcVQp8GyqgMHfla/OMrEsHm/jDz5xYifNG?=
 =?us-ascii?Q?6Lvy47CGKrB84MKw6P1MjEqEfwXDgu+PftDlT1p9mxKc6FI1KZXw3f9kJ8/K?=
 =?us-ascii?Q?SIsonGQE2wN3nryLuVodmonNcsp/zWPHGJw9n1KgbvCv/ZGWxYt8S5tpiqrz?=
 =?us-ascii?Q?ZwN95+EqnGaj09Bt0horRVrkRpoJI+UMRPdkiKHRjg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c308ba-baef-431f-425d-08dc283be476
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:21:28.3906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6986

Add i2c and spi devices

The patch depends on the clk patch:
https://lore.kernel.org/all/IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v1:
1. adjust the order of properties in dts.

Inochi Amaoto (2):
  riscv: dts: sophgo: cv18xx: Add spi devices
  riscv: dts: sophgo: cv18xx: Add i2c devices

 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 99 ++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

--
2.43.0


