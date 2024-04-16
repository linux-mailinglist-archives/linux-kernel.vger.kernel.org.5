Return-Path: <linux-kernel+bounces-147077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA608A6F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513A61C21FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA90012FF7C;
	Tue, 16 Apr 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="T0ey2bKo"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2083.outbound.protection.outlook.com [40.92.23.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490C12F5B7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279637; cv=fail; b=e8znFzQLgtM6zqE5ZY564C19/JbTc0pCGpKZNU51upi5af3BpK5mCvxWy55/EfIIj8kh57/2y8sBv/JaDeYJ3uvC0WRopjfFsQdNe2F3qnNK3/ocrf7WnmxyAuN8f+zzXgrNf/kOKhKrGKYdmh3sukpXi3/16mQVN7YbgegyVnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279637; c=relaxed/simple;
	bh=POf6O9lhlbf7EFAREFLGpZzgKKGKEjZLPM0ZyEQKrV0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MsIllkq0ZI5hqrzuOfdgZl1DGUaWGHFj8sBJ5cCWSo0MDgiAg/cvoVOg7lQ5ExQBo01zEgPqE6HV3HmxFdiIbrn8OqVpbtnwNfQpKTT7IMdEqls8oxTc+tXmtFCX9Yev9UcJibAn65CFZlIXfZPpqGnY7SyiNcBS4pXFHfvaqw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=T0ey2bKo; arc=fail smtp.client-ip=40.92.23.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlggBdbnpmlkragfOu+G13if9WjBVyxEmLgRphcipw5DR9dcWQMm5OUtmKFL9E+d4K/OykTODM8sFDV5HGOQTTlc+mfyiINdIP1qwZDDqOg/ksuxwzJiv3EhIIiXqDh+fpuczgmGrXCP4+mNTXCoqvzh5yBKodjRBE1bEH2hGw0SvSTYwtwJjwBiN3QC5P9MIuIFnzMmkxnQeWSPozMNiX6ZHXIDCd4hOb9eyE3qZbiHsUMCTn6hLGVHil6cuCeWJMVM/4iEKN2TxpNWIloPtVPAifkbFcqrldnAVy8b3TAbUrdgdOTEG6b0q4Li9bXdteWubDUSi8296HJzFWZdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgxfsMGQG2FnTziuTl9Uy0JDar47L9rSnEk49NhvlbY=;
 b=bRrpm7AwEVqwlSOYGBnSZvlTOFotNWLhUZ3kqzeWS5AvjTFaNkgOiqvnUxGieKV7TykKdithX+bthKEt1zFLRYFDtsWrlI+Pbvde6ztD25xzl89Ny62LD75MR2y9YziTH4kta8AaOqRVf++Zt0wuVlzNJwVWL1FvVTPYyvaTSscuyip9Oj4f5yJ978gOkAseSDljYOlcNTMYuQoFz0cIdQK+qgwx1MxezdQHPO0pZln+dMsA96kKSdmrVq9eKZbJPM0SZHFid/pQ5ia4ZDPcKrnG8FUzqR/Tu+Ku+pmv2ArvRFzMZh+ft0tmbWk0cshIdwMgHSIwe7gCp/7MsIR37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgxfsMGQG2FnTziuTl9Uy0JDar47L9rSnEk49NhvlbY=;
 b=T0ey2bKo/nCTf6JzXhwXkEWn1YPTUUkR61SG7gIjjx76hI5EymXQJtZrPMc5W2oZktnhAsBJ5R8d3vY4Q2/Kbnva/mbwnO19vPAs12XacclWgwGdDj2qIVD1BzXaPIZRAElkh2Rofr4WcTheKDGWutNRQ7jMx7L3iGb8N0lqUhT3IWPd86DH91ZFPetYLq4nT1ytJYpzPpWyHLFjJbCkIzDZX20jUlggfppto9QFyA8t3RS7ysnn4E19FbSGOuCc5U0Tde/vd4k6yE8NANabgSzqJMkoKuSNJHCGVQBjE8n6QRfmUL7pC4qW48WuZa0EkMOPgDjAia67uxpyiBnPQQ==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by LV3P220MB1504.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 16 Apr
 2024 15:00:33 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:00:33 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <lnimi@hotmail.com>
Subject: [PATCH mfd v1 0/2] mfd: rsmu: support SMBus and FemtoClock3
Date: Tue, 16 Apr 2024 11:00:18 -0400
Message-ID:
 <LV3P220MB12022135E4B59EAB3316B1DDA0082@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QErdGE8sv2h2NoEhhPwJ//+526wJBEjQ]
X-ClientProxiedBy: QB1P288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::40) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240416150020.9898-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|LV3P220MB1504:EE_
X-MS-Office365-Filtering-Correlation-Id: 08dcd3d9-f06c-4178-b847-08dc5e25f728
X-MS-Exchange-SLBlob-MailProps:
	quCBMN2EvO+qv+S/AfCUL6HWhxncUpMX9ClOk+nnxyBQPbr5DDYiaHagkhwAxu3G+uR966AxfshepK/0BDlwzRfuxy640XrPMnicZ7w0POZ5t6KOwAsr3LiGEp4FjKOpthPcs7fRVg1rfQj2qPKJlEEGsTP3kfsVeR19yRw+b4lw/WFETXjD77Mm5CGS8yUlJBS/ACMLqd/RuERsCLA17VnTqVlINEN9UfLvTuGGaMLkXyEnOH06X47F3+7UHUjI4XpPib4QHWUE8OBV0Y0C+KKMG0iVGWA9bk/qq2prD+1EE7G11UmoRrAo15Yp/baH92Oj9g0dHFkkgvvgzVVMTTZdjfADOhyAtKTnN+7/MGFi/B9cuxtMkRxC5B2asuSTa4Kfbjj32mWvyL0F/uvpZaO+QIWdaF469pSuarPEw6FvFaONBe58Abd/kQopjJAP7YnAutuhWDyQddTLCkkVxtMMELGt0S27TRQtNaLiQOXL9Hr1fzNRnNII+wUIvUB7oEHzzAR06IH3IqVU1e5VMAVkJ13qhOERXt3c0vKPvfR+KGmti48e762zM6alHNLs7cg//px/TcwF25iTgB25RbaJGeVkGLg8KI/tdi1S3Oepa+DlrJc2S6Ciy82LE4FQYfelVeywSe3wMjgYRCm15HcHXK3hcWAZmeIGuB7mThKDFcQRPyQ90yQWRM+e3xq8vQe4SBgbAMBFrF6Am9LZGQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MZ6QnwWtwzC9Bpc3QpXCFnIQ1sGdip2I3W9UcdGSdBTk7q3TEvE24QO2wfUA6m/GNplQVZWElYNmb3Q2LVK9ST1O7E8d6bA7mrjOt6x+4AcZynfJcSzs/qXm8ulikBH64OINXmbo6SfETVfv05pKJ+jwdTN2Q9p4ns/C/5YtjIHfFyvuYgqxUKNEiKppMVz9/5CHwqQLRFoPERMfW7gEsmbhoD2jOjtftKbdDlfbDWAFHDynGAN744GQEIL9w/Cr5NuE042B+81KmIH2T9XdsGWNEun9xELAf/ct+EZgUWV9vMNXyZztNZEAe9OH4MD/LvbpKxPTBluR8SjVOvmpKU7FVUv8KDQbZ2GDv4YI/vPbuxApRG+k+jtkMJk+Hj8fs0jCM9cmhHZavMlhqBUo8XsvJEwcbnPmMgVWk03nfmmPfBJDnYTI2Z94Y83rTXVMTs8K2I/AdEDf1x9fNdKP4Hs6Ye6k3LLmUOwuOKP72qmmkaxCnxHWhY3+Gt8V1ORGZjEqvOYt0msu36yzVcfIkpxekX7JYC5J2jboLsxMOpRTDGX+oKwplLBZi5OfcxJfAUESZOYcm0rHI1hs/6jV2MPjXg5gq6NKmLj3CnXU40w=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6arAQmbXBvZKR5NQWS0kglyHgspJgjuZwjt9lz6EOF4gGczrhiVMvHV30gUL?=
 =?us-ascii?Q?tCi6AoCo3LfYpyNeRDuxXRZvZvnHRlZxKM3Pjc268Ir2vIds5xkOW44Xv7Tp?=
 =?us-ascii?Q?efv3tin3oCa34zDdV7SNFvTSVi1ezAF2iHv18RZKE+soDIOlSrdMCocSjLMf?=
 =?us-ascii?Q?tHIU3i6BmzamW9dPcwPZb08rZj1cVsFy7sZtCkQmfxIGGzkliRmL5G7tm9A2?=
 =?us-ascii?Q?nRz5YKGu1MAc7Lvn1cBdWYUwN9UAoOPYKpB1kpLyh/0N4xMfTbq47Up99ez3?=
 =?us-ascii?Q?6TWJxwgGnG4xJgPjVO3GKlvOSyVY2A82EzoEi7xCb6eBXfznTHlhwEd9hB3H?=
 =?us-ascii?Q?YoUG9CyBnQXZ4rlOgLOkHvNBt82UugPCZccOLbf6l3RSzKOew8B1f3Hp6ZFr?=
 =?us-ascii?Q?RQ8gS46HX/7nv6KnqVVtkN2349/VT/wHh3PpHf3B6Qm/pbh1BP/TIXEuH07s?=
 =?us-ascii?Q?TB5DKlfSRmZaINM7oRy/KqMSM9Qo/F6osfGy97F0UmcBURiQzGXe7aVRz8MD?=
 =?us-ascii?Q?sZ/NccCdyl/NIt/X8QVyT6bRWBbLoSjy36jle4iP7ARGEc499KmhcA/ZLRZJ?=
 =?us-ascii?Q?C79YHrGhc9xNYlzCtTK/lXDZaE/ZQMm7eR+X0fnuLEd+PSATipZ8TD9wrkDh?=
 =?us-ascii?Q?CZsbaEJpuamgVAEqhTNCt+CvO7ZHqalrsDN5M9ryQkY9RVK2dZQVCq+570Al?=
 =?us-ascii?Q?YWvlq/oYwyXixlOE8aa3kv2K7R/9DOuDpTSGwvJG5ToltvGvdJ1hIc1xxmuB?=
 =?us-ascii?Q?apwIA1+8teEHOv3AyCiSF8rirVmCZ4q7M0kLPSh4+9MdroUDcpZyOFywUjWR?=
 =?us-ascii?Q?KOybHPdp6gjbIeMvWT6ESbIY0hvXA+q5aZA3UvGiIi7q3zD4mB5f4sWmnosX?=
 =?us-ascii?Q?Piylu3n/z34iPk0lMhtphUbD6s04ixAi+y3CIdHAGRlFMa1DZO6anlPnBkhF?=
 =?us-ascii?Q?zKml9zKaN2HFfyPIm7SGrltUy1yo6DFWG65tUiEWUIz8+frFSb+PziKFC/zJ?=
 =?us-ascii?Q?DNoJSJKMcN0D7nrItbEO7WQaMcRoL8Dew7AhPcfw0usEaeb4/8Z994FCbVjG?=
 =?us-ascii?Q?8eFdDtHqArfFtukw1k+5tIl90rQRJrCfwVUwgXE77r6JaA/Wgl3MDWTDrI8W?=
 =?us-ascii?Q?IlS6J7MXlQpUi5OojHSvfKMIlJDq8k5KJEGTBPeZ9ACDvD2lq+CGLoZEzIDw?=
 =?us-ascii?Q?H5hrVj1Ma7VQLbmXYZ/fDm1Sx5thqM2sb8xM5vZqqWRSUyhn00p1LEKrS9Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dcd3d9-f06c-4178-b847-08dc5e25f728
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:00:33.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P220MB1504

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


