Return-Path: <linux-kernel+bounces-165582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 914B58B8E39
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9011BB22597
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6018ADDC3;
	Wed,  1 May 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="fpN2hknC"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2082.outbound.protection.outlook.com [40.92.18.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B8CA40
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581191; cv=fail; b=DPhGOe7EhCSilsclu7//qo3DXiXv34yzPQuJFZUT5USASy1yEKbvW1Vs2oevY+xe5Ltt/Wk6PVwhJCO44V94/eSVZWRFCgHOSubnn0CflmwNxtUe97TJ0H+KzQSYX+2ncOikj4xY2pMm7sp5lpdamquLsRD+smVwS2TECSSEyBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581191; c=relaxed/simple;
	bh=HFPFQ0FrUpRVvXKIT0qRcAyOiflRdiSJr8+MNxS3f9o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Wiv+eZ7UgE6KdwN+Jr9bOk63htj8Ujvy24Xzo8x9XJfBvYPhgkz2Wwo374R45CLTmHm/KIThWLg381RKGXQxIPoXmoPeMY04OG/lZE6gVCdtS/3zy5LcVqQlLXRW7SDUdN1+3XyMZQYw1wj4bbIxnYHkWauqNpq7FLykwsWtWF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=fpN2hknC; arc=fail smtp.client-ip=40.92.18.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWn56RtFdkd9hbCbd6JxPklhGgYUY8RvhGBpQgf2gRV+bEsrkqcqRVZetSUvtc/UwwbLiCDBqnYLu681sH+cBITWaa86v/+T/hp9u0/MOVnY4YpYNabdBOQGIYlKp+XfZjKSgv56uFK9bGYSLl9DOBc6Bf3d8IIe7nanbUpOnLZ34JhNbts/rEI8NgWEciutrLZwApxwVlUnT5JeAyZHAKIZf7V5SyoDqNUTY40+0f5r5pcwTgu7xo5n+Rh4SXs3M7ECkujisH7FTUMMJSJowxsjOwpBf9UZehtRIBwsMy34p16QnnCI+/JfWWd6Uz4Wal3mgRZhHbQ+ITWO9hF0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzddQsspqt6Wr3amBJ3j57nNlL4Hl8DkhQLJ+7uZkck=;
 b=mtAxi5g7bnyVYudljQtb9HMk/H7YaKL0uzrNiq5gxYeFE3x8Y1yFZdTaptVerK+98pdpMI3pJkt33fbU/lTAsVP8xonMWUB+xtzX7oosHpwbvTk+/WHY6Yk5nAvRes6snUyBGschzysCd2XlAasXK075o2sJEEr0p4XgdI/r72ObdXc4zr5vSW0yWydBKWwOpIU+prT5Xj7bI9GTBo5lF73HP27bbx8mJrPz8cEca3BNwCM4XjUqRhduiV8eUm6Xkpv4+saow5gdFgt5dk1NNYn1gUWHmCS4eWUasz+OCjNJUkRWlZf+fh3IOuk2t7cHb1NdNWrTl68rXidoLc8MiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzddQsspqt6Wr3amBJ3j57nNlL4Hl8DkhQLJ+7uZkck=;
 b=fpN2hknCF4M/irdc7EDDoeAXxW/ovWGz0hw55ymAu2GQiw2S6PX4THVAhGXbNpGe+mGLYuEbE6juApGkyyojMITvQuV8GPs/Mnnp3PrfwItwZTqb71s6cXMx2RoynRvKW72p7kWAYqcfGW09bvaqwZxflPQD0iDFi3OV1Bg1aWHYoVlEpQ8vjDem53xeh9MZq4ae+/laydapMlYeAYMtvsOa/2EPbObyPf4SKb9Z0G49+IO+4x1wleW5KtbNsSf5X1G3e9ckzqWRZu0/abDtExWwQelFKHI5vNiL/V6Ixr7wjZa2c2gFH5+BbTUtIb2nDyj8V5EevVY3HE8Osh4D/w==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by SJ2P220MB1335.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:595::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 16:33:08 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:33:07 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v2 0/2] mfd: rsmu: support I2C SMBus and FemtoClock3
Date: Wed,  1 May 2024 12:32:54 -0400
Message-ID:
 <LV3P220MB12027E97C73F84A01548D3F0A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [CX82MjTxx/4r9BZcN9835g88ycKWQpwC]
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501163256.28463-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|SJ2P220MB1335:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e4d10e-94ca-4b05-5a57-08dc69fc61da
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	bJzKwGC8ksduWtJP9h2pEcJk5B62Ypf5DA7d2eTuBnPnwl8wGKkZLQNDiqhiFzy2mW73h+c8sdSb/sLvPqMbAwTa2nvQkYN7PK92h6yph4WR2BPzzEc+M99Jzbu3fkzd25GDB/dCKPiIa3jS7ZHiMCrXEZE9ZA8Fa0EQYNnyCOMY92yiZuxNZ6fCcj+gG6vIL+psvTZKMn5IZi8RJLaH/g/MhefsSU9AMZAu5XJr+rFDS+yZoR6IzhemRuMX15ozWG+S2KaibKxqBidqpefnr2FK4a6ACMbwMiHrOZ5oQfWQ/rN8i/t3oqdeaJ86/lkoiQV/BrEde1Ad8t+UZxPva8z7n2/Ym/8JPGAvu2fHqQY0F337uTy8534UEN0cRIB7oekdCK/zsOb/Atvq3RB3U95hxV06kD0GqJbNvaPY3EUqfi5QIosIWfzCcIkWUjrl6sWw/Sl2u2VDIAtt7bxeJFMj1IZocBNPoG2VtyjAvlPrQn6V/f87EOAIdHNL7EIoHu2apLIn3sXywS+lVr++gY1Ep4sKWmabQkGKzWM5EdIAjN7dV3NPZwbaMyQ27ASK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vn9RVuijvF3dFan90FCMOnOyRqPHHCMLlYMb1KLsga3mCLKxJQ49DKdp0Yg1?=
 =?us-ascii?Q?iaIOW7cHPZRImCBk6Ta7d8Q5I6p71ckVlSYa25Z78G/oLx1RfoizKTWjmRGM?=
 =?us-ascii?Q?q7pU82FZVmWNJd1x/c9eqZ7CvdJolDMMgmMpTgCEu/r3tEe3yWXGGCr53Pi4?=
 =?us-ascii?Q?J0rRY83KatS0mI0q0j6V9cNAA37Z7Hx9eVgT6l3QnDlI0ABO43Tba+EAvGYn?=
 =?us-ascii?Q?MAMQXcU3H+eb9qhV9TzRiTqCcFXmDOoR+EVA/VC6dAkCXWCpFDKxQmC+x51Q?=
 =?us-ascii?Q?OhgufoUMSUN9rXcOt48fRf85KOdneEzA7PdnQKyHBBAMJa7X8AKptSmqf+jx?=
 =?us-ascii?Q?qo2GrybdKd/vsiYiF5qtGUCHLiDJM2YdUgTuEtL/o7/AaosTePXY/+RMOIOT?=
 =?us-ascii?Q?fPGuUkJMeoN2RqDHdGDrpuQncklrU6QvUmwYoIwgwSI9PhBCp15YUTsp6dl5?=
 =?us-ascii?Q?MR+7joMH/7Trgyv2NbNf6ZsjWRXSd/g24cByksreUIvafBUZ0HGroRTUUICF?=
 =?us-ascii?Q?QEIcDaz0GdBitkuPFcZKD8cl/Z6JQ1ssd1Re1WNa9naWFe/cvVTDj1qOG7Oj?=
 =?us-ascii?Q?NrAzuk35HuaibVhhznk/zYwT58calmyDaZD4fh1TPedTmu6xYPTyGcVj/Ayg?=
 =?us-ascii?Q?UNbgczwK45Uih3fLsNnX7RyEpCw2Z38OJb8anXKmwMpkZuerKY+smfn1NyMX?=
 =?us-ascii?Q?nfaLZIaEP2L3ahwDV7b6y9WCOcac2unmF6wa3WSMhHoyOVbOSMJiLLZB4g5T?=
 =?us-ascii?Q?vfSfAEQ0qe4L0lcECamJiOFU+/9AyeJEt8yUiA5XmcmHW9WnrBTGlIjq5vBh?=
 =?us-ascii?Q?cgnakuVJ4SO/niGJYbvrLMxklWHqztTEgvhVv2JweE9H14MUU/WoA1Ga3NI/?=
 =?us-ascii?Q?UpWS8lv3sBvRfEND5MegyPKTujmp0pIM1nFBPjhYhYAqw6JPSm3yv/cefgMM?=
 =?us-ascii?Q?+aJRUisqEJQPyVtFe0oMDC18pnB/m5tnaGeNzzjNsyCUVeaH3iN9H/DUTce2?=
 =?us-ascii?Q?0e/qRzFGS7g25cWBEFVyr8tzoKIofFPHtC/GjxFj8jlhf+OmtbQY7UoBwdCl?=
 =?us-ascii?Q?/I0cPeDd/meQEBB/jMbOtfbx54eXyGmr3Cpw6QSZMS5nW16CGQJqKrz2ip6+?=
 =?us-ascii?Q?avYTo4qf1W9Wsgl5U0Hm3bwcEtgvrrD6oSXYZB6bGd7z2UztbSPbKS/f6zI8?=
 =?us-ascii?Q?JMpg0NE2WyPdALOD/1pWnmpOezljHB6PLpbW7jIVC1k5E0RP8st/JBJv8Y0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e4d10e-94ca-4b05-5a57-08dc69fc61da
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:33:07.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P220MB1335

From: Min Li <min.li.xe@renesas.com>

support I2C SMBus access for Clockmatrix devices
support new FemtoClock3 devices

Min Li (2):
  mfd: rsmu: support I2C SMBus access
  mfd: rsmu: add FemtoClock3 support

 drivers/mfd/rsmu_core.c  |  10 ++--
 drivers/mfd/rsmu_i2c.c   | 123 ++++++++++++++++++++++++++++++++-------
 drivers/mfd/rsmu_spi.c   |   8 +--
 include/linux/mfd/rsmu.h |   4 +-
 4 files changed, 112 insertions(+), 33 deletions(-)

-- 
2.39.2


