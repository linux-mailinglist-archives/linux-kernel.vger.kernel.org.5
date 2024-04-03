Return-Path: <linux-kernel+bounces-129199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01858966D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E361F245DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3425CDD3;
	Wed,  3 Apr 2024 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BnyJR+AU"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2012.outbound.protection.outlook.com [40.92.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE944EB2E;
	Wed,  3 Apr 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130106; cv=fail; b=D4y45ULUPT3gSTYUYwbALnptMlSJWKKWYaWk92t/C8l3tCpJ/vTRtcMSRZ2+Xz+WmjP/7rSZ3sUQNyusPcndIm4mmkFUZkWP5yUcdCToAQw1+ai6CF8IP9qy8gjXDYKBCfVU/mh4ACDUAcSwenqyaxsELP8dLkhg6TbCQ6morec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130106; c=relaxed/simple;
	bh=XEbPO2jF/jt3BT4YdYHk3UIhCO2+CJxodcZi2Sxa7uU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PUhMEMCWWWmL13d/HrEo+qx7HrArvUzo7xubd2d28ZaaL3Iie8cnNhoWkkUHDOwSUpRdRSQSH3qx48iovlXSFUN01KXHM2hrH6ADvzV7iz5HrNBQtV+EMiOOn4RepLc+3heJtBCpDFxCnj0LDLDfho5Zc2xk8YdRTVmBdLa6POI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BnyJR+AU; arc=fail smtp.client-ip=40.92.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2lPbJPKULKslb5Y1m1DNqKAYWVxlqCGuN4o+pDWxS2E1JZxTYbs14sBVUwPTE+JiP/FxeEu1aI5ucwp8lrrOrCn7KKHim2ahT9m4l4hEOlwztObnvZY3FlPBRM8OcBrXg+AAGTsAfRDeIcKc30owthi09fLmpc5REguHG3pmXfk9sU1wjMIcSEsTrJsoV/fnUsE4uqPipk+uhE3zm6fhN7DI5Jw7TVbOnWQwlva1/yZhAZjFV+U26xGb9/nsmg3ltWsqATD3oN3xlR14omAeh+9VyexwwXavETna7Qc/zsIkDeVN2l1eFPLwqfNx7HjYVkpGUqV3Dykw5bU6OaCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBh2Mo42HQOCROtJW97N/C+xLV2w7oHLJGQAtmMf4g4=;
 b=C1qsteGf2QsTWs9NABNQU2BuA5q1wBXHvE7u6xR3zzYPp22cFiX8o/AQ8mtlK5IqBi79jhwDT1KJadaKGElhkgfNBOV/IQtS0wW9szx/Z9Cky4p+WiGwdZV0JEPNltQfsY0+bM9jIXmqv9LJzoUusALqj2tUts+8cgV7OMqlN2WvVSqh13UcATIB5awzCuOJ/I52G31LwnbOaRZeMar6FHIQc4dvYODTlIWLCKsfPgsocU/zYEgshIw3yIkYNB09ni2rxRnqm0f1DYX7XMn0Jdjjqd6CiLWT1L6imtnSkXd0DPPtebpmvvjsp9QPnGuWe5H+qCv1OdsSNgQiY1Y1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBh2Mo42HQOCROtJW97N/C+xLV2w7oHLJGQAtmMf4g4=;
 b=BnyJR+AUrPGX5anbeVeuCCetI57U/o9kPs5tQGa8qcL3jegerDvAi7evuOgh2ngxoLTOswSz+DmUXQYEfuKUGebh5kkA28/LhtKVbNCJhldfVrOBbVUOeBqB4ejKmhrh/gLJUNTV/r5C3mTf/Z1bnk885LqOBHtdWbGzjwC+E/ICjY11asF/wyHTXF9t5Z83Xz0YxTObI/MFqN2te/TyzICkH2d9Kite8IPNzTYwCXVe9oJ65VOe68ep2JLInxO6f5jEOmaRP8+AFGAXay5B2Oc87zGHL6nCb0m+IrpySnV1rOlJRAIM4Vn9ZRApXT5zWCDsC0LLXcvDNFG7l4UpPA==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by TYZPR06MB7169.apcprd06.prod.outlook.com (2603:1096:405:b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Wed, 3 Apr
 2024 07:41:40 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 07:41:40 +0000
From: Guanbing Huang <albanhuang@outlook.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v4 0/3] serial: 8250_pnp: Support configurable reg shift property
Date: Wed,  3 Apr 2024 15:41:27 +0800
Message-ID:
 <PSAPR06MB49524F135EBF81C4F2D181BCC93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [KOut+fD3pxOctsiPMJgwofpbhdruQFIO]
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To PSAPR06MB4952.apcprd06.prod.outlook.com
 (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID:
 <20240403074130.93811-1-albanhuang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|TYZPR06MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 80144fb7-8466-4424-e4dc-08dc53b17fbf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NujF5vtNh+EdKgamEP+gNmgd/rViO/vDFUQW3hbzrPUy6H3Cr1r9FYLtKRuSg6l4GuzgwtyUdmB9DZc9A0NtSnvALUDYCNgnfuXnIMtM4kPVfgNF6xaAUJcWNKNmtOjXBCwXaBgEqnnz3Q18IC/0B9hf29IE6x8rfHILoCl+M93En4ZkqW16tuhTzkJLjvD/zCTO0JteEtlKky0TB9d4lYnryRWLH9yohYMCxaT+VMmjz23Stz89IgYR/ZaOx/60D+KEGe+BomuV5HsrzwkrzvDW5+RpJPifEl8FVXNPmuvZUxX/9qDc+yXahJtJ+6nuupojDLVAgiGbELDxvVZKLw8llo4s3BmI1t0tQmG4XRAOH2esDK8pXs/KTrL5idXXYUQQX56Q2LkG1f24qb+N/oZn1RBKFu7keZVAA/0+E2MjNp6DTxNOIAuR9Il8kzhmtsrrpGs0+SvzyOsr4QPXqOEaU1wtvuMw2rDHIHl2/RBNbXk+N3aglwYV4SDruN1VlAQDpxHuGRgktGjmUdrhB/s3ZwVupbZVJ3bQOl27g0EOFt0x3pvixxXa4ca1/kvv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JfCJDLFKJxNRiyHpLnq7bH3Slaq/EbtvWvC1Ne+E1ar6GoneqOacLPwQjR6y?=
 =?us-ascii?Q?3F/n4GAwS2xtE3IHBolMLLPHrgRDy2gBWiU0vHdufIB0fGMEhmBR0Wgb5XNh?=
 =?us-ascii?Q?et3gIUKFujC+LnRozPYQGCQT8ym48UKYlWM+bJImWgEuIzT87NTJAtyysYdM?=
 =?us-ascii?Q?yuWc5rCSINQJzNpHz9GehNR4hexGFRfZJpFTbgYhF7aays66lC09l5YTFPV6?=
 =?us-ascii?Q?Bj2wXa/i8rzqfv+VB+urkaLDtjQclasqBCGpnAFI5Cj5jEnGzSjeH1J87tBZ?=
 =?us-ascii?Q?QE47+lvMEMHjS8ALs5lxRA/PQx7WMulPUC8v/OnsuB1MCeRQ7EuYzxvYcl89?=
 =?us-ascii?Q?kGi6oSAns2QZJOURO2AY4uNSC48cfmcuB0pdGnEELSbTtGHdO6fRXWPOsleZ?=
 =?us-ascii?Q?7IxzGDIRFvfSqkrRnisDolclRJ60nDQzekp9GfxJ2730ePNx+aYkxRg39xS8?=
 =?us-ascii?Q?vZo/iE5z1ZJzZYxZuBbU5xn7oNzE6Ue6wXOfmNG4BeaQ5w4stEIhvs0JLhYM?=
 =?us-ascii?Q?xawqB2O3EHq67AJi3f9AROqef1FzC/03B1ok+ITv5WSXV2Z76XOnyOWlYiEM?=
 =?us-ascii?Q?c2N+JWtL/jMGtFL3L5VnytzLOKBCMgU2DyfM7I3H+PNxwOpUlEODNJvSIg7b?=
 =?us-ascii?Q?mqzTEuL3ZM+hDO9L2LGUYl8PpVDS1Ht44OMZ7E2tketgZn/bazgmDVeaMxcZ?=
 =?us-ascii?Q?OFO++Zg4umhYi0s4HhBzJZ+Kf8+dA3y4A/gg16U8c1p5gyQ1t+qoEXaJSCop?=
 =?us-ascii?Q?yzjGF/sgv9E76nR0H9GTV/yCTRcDM3yMtBS3dDV64Rx9wchKAfHwlVsdxyFR?=
 =?us-ascii?Q?T/TawtENOILlD5dzQSVc8cS6eYetJAogMNoy5+t6N4QJSpypQYDCYPSmK8ZE?=
 =?us-ascii?Q?s5RXPsY6qadSVn1F6hM58z4wJIjWBrQ0gxchG6RYHsZ/lBlQiuREbypfab/r?=
 =?us-ascii?Q?ZrqNXqPU034bgQWDU8Yi0qtxYc9Epp5dNUjm40oFMsezcVdEU77gQ6O707Rt?=
 =?us-ascii?Q?hlarej8qjODXRtbE/a47T/iik91/T5hiyyEaCd0SOlfEQ6UafQqN3vOMl9wv?=
 =?us-ascii?Q?i83CSDw+AtfRZhIO36TxXAsLX1r4s5aSf21bjl35WmznYiGWQ6Mwq4y7kp9h?=
 =?us-ascii?Q?Yl+Q1/Mcs8QW8UuDBKp8OXQz7H2fptxte4BryDXuEGAMd0M52+AYj319sTlr?=
 =?us-ascii?Q?7seR3GHI6JL50DydvwdfwYdZPiajwmvMPKfw0RaM0FXMbpgn8x49TdXkr10?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80144fb7-8466-4424-e4dc-08dc53b17fbf
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 07:41:39.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7169

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

To address the issue of configuring the reg-shift property, the 
__uart_read_properties() universal interface is called to implement it.
Adaptation of pnp devices is done in the __uart_read_properties() function.

Guanbing Huang (3):
  pnp: Add dev_is_pnp() macro
  serial: 8250_port: Add support of pnp irq to __uart_read_properties()
  serial: 8250_pnp: Support configurable reg shift property

 drivers/tty/serial/8250/8250_pnp.c | 36 ++++++++++++++++++++----------
 drivers/tty/serial/serial_port.c   |  7 +++++-
 include/linux/pnp.h                |  2 ++
 3 files changed, 32 insertions(+), 13 deletions(-)

-- 
2.17.1


