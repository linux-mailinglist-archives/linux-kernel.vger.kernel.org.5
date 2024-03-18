Return-Path: <linux-kernel+bounces-106453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D065587EED8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3E41C22028
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EE955E42;
	Mon, 18 Mar 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ggacv2ZP"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2042.outbound.protection.outlook.com [40.92.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E955766;
	Mon, 18 Mar 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783159; cv=fail; b=H84C4zaB9X7WyTKlgLpD/jc510LEBRoEiYhPx8m658/yVQ0LFZU6UjBXlqbC86iPI4nJ5ep9HjA5CyDDMINHgqm71tNmShf9cM/Fti+lEjTUErbun4r9VmLrcVjdBHp62ZPR2LR2RUJvYUaOONaMk9f9CNHLa1T8PSlqtZOZsoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783159; c=relaxed/simple;
	bh=gUquANMlWcYdIaPuxXUeQnYpQKPvujL2Dh+Cpieh6Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ScACV3wI7m3/FlvylDso+mjHeJ3M9ajU5h+QpMfhiG/ZnLL5isJPOmeXWhVKtbaywZraiMiLM8USJKHoF/19m1gLIBJ3i5atBmyOg3CbJf+PaaNQvWL4SugTec1ZtM3vpYoLF7INirawc2rLXRhnupIn0Tg9nMNIlR/XbqON89g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ggacv2ZP; arc=fail smtp.client-ip=40.92.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzJ9BsVVUFsZxS0un6k7tYvTxD3xZTQj6OoumJVPobvxJca0IfGakv5FCpgoEtFOfL2EKsZVcVTucFHbVcZWy8/v1mthhNEXZH0atuzScJ8YNBtKACvs7yPd79RU0NdxNsjvK4DLeNNm60M4+AQ9PZg3wbQDy8dbzYm/6ICTxY5Qr+iyA6vGCj0IB4f9fWZ3/EgkqjMlqMhW+BOc6a4S5ccZ+5SiZXNh9HKsGtV/opaEHrdJxSgjHwDHu7McAbqsQ4Ehtzf8D2R+05rrsWDPv8DKsdsDJ3wcpQmS/NGSYsBuS1d4OcmeR67YzP3MmWNI+uIdC7oO5JLuXz8wlq7xyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcf1gZIoZNtYsqOi9BO64j30c7w7uBRLlsu9fJeEv5k=;
 b=fxerKOh/3T0cEoB8JJ9jxMTCSe5bOKRnt/g903925ab5bT+nr1lH39eAj9QTS/JXdi6ROSGQsfQV0G9AhZD7TTvJgFVDFfNRc5BCOBs4scyGIEmPPSjb2vC3DwJLbtMsTm6NaGVHhTvCsK7e8BS1MVN1fWu8bl1DMjPFayLWkK7H+Nizu0q9buhlL8wIA+aHWFPrTFMudw09xgHkY9ZPsWwL5xLfue9UPRYCzia/Ys7OcP3krsBpcGFXtIGEjWHHnrnJqoQ4vqfFGd39mzt5YR446DpZFk74D2dP6d9E07PZjdUFKmMrMCAiZb2hywE1ksglwOJlx5lfX15t3M9Pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcf1gZIoZNtYsqOi9BO64j30c7w7uBRLlsu9fJeEv5k=;
 b=ggacv2ZPl8tuGBi6A9Ng+GpxEs9Bn1Cs44k7OtHcEDHoOGFEm5ohsmKAzJvDa7SLDjciP8uPzYpqlViObEY/f8SfoxaNkaFEy6pZ+LMpRVrgnotzZhoofJXnq5JIYYd/r8uHEwBipE+MmYMoSAQfs5MDg1PW9Q+OcGSx76fNBs9YVUX8mh+Q9bg9h1aKCoLExA2wpcLEpYmX+t61wxujBvt4Om12heCDvqEVjIAsvWHvIQkVSPMfi3UIpYqU4XYqkbMUGIeyPoI2Umh4Jfxi4io15tEWJbTVDKE+FGZdq6CY8eZ/1ozI6qHMcx3lHiJVrsuJJHSkudvRS9w9c9t+Lw==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by SJ0P220MB0785.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:408::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 17:32:35 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 17:32:34 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 0/5] ptp: clockmatrix: support 32-bit address space 
Date: Mon, 18 Mar 2024 13:32:08 -0400
Message-ID:
 <LV3P220MB1202C9E9B0C5CE022F78CA5DA02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [hkMi7NHQtDozWyIbY0M3RuawKp2npxuM]
X-ClientProxiedBy: YQBPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::47) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240318173213.28475-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|SJ0P220MB0785:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1418fb-b897-4f27-0212-08dc477162c9
X-MS-Exchange-SLBlob-MailProps:
	9IecXKUgicCxS1BNcGGe52rHSLVWHYUtig6yeBIHMSkEcWOHh9d0r0PHhXEKK+YVcrs7fJJNtlFbByPXnM0nYh1s0QYFyhHpkjz7ZuFO2gDU4+3rrdqdn2Q1F/Kxj5QJyih+81pd6nymXBwBEV+VK6VWhfmzxG0CtwyNoDaoipHhq1Oh0503EUVQ3SLZHx97+XQgOsAFWLAPjHSOif/W5oU4oC85yNz7oS5+7D5hPKCceEm0jwyncUDgZ0n+vznM7XmfKX8pKcc58zKWNlQWJdGy0rXrWjBcwyP+j11XZEPJzWYVSxntYC3kDDZiaSCG7H3JiwsqBb1nIdndBD2SzzQwcxE4Utf6PXBAnrR+7oJiR195gtYzIsbHngv4AIC52uRwu595euTAWHyqW0l/MPtmDCYchOn7YCYRkDrr5tufsMdowZNmJbo9fy2raLi4AmxxyKNXoWi6KZftFhVKbT1fWQjugb1/c8ZEa0FNCS/ZGNtqcnw/GZCZys3VJ1XjTzzkOa24tNl3ZklC0EkzN493suKaScWsCXegvz0g73SpvG26TEf2InG+ZAPBYnTINvjR9EMqq/4Z9wlM9fa86aQ0+/hIya5ZM6yPm+jet8qhiKDEMVHbjkw1VweDaEdP+/5Zy9LhjS2ugc/IeLZdKCC9nVyuA8tMmpZimgdgHlEZFWLJb/ziBYlnsS1SHQD4RpzxDeIKyYs4Qf1SFvJDgHaLX84nRDUWxUTqRA/LoG8B111N2ewkrg==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	53tFLW/GjHSc76IMKwHUiinypc+G7ZPq7S64WZ2VKNrqf1PYtGYVKiZwoAOOKGcwld7U9iC54rzEj8RVPw7/o7/YyKQPSXSsjmWYKsMRnZUhQrDyVplNZGhSrwB7NsXJ18v50XXHPIUZVzAiDcbcWAHrO1/Qi/Yv4XENiBZqSLRdZphZ7YcWOsRR8Z3vNFK02bYQvUl6DLvXklT65qw8hbCgpWArtpXer45+RI7nAKeCHg5wr2AnklAaj+PualJlICxEvQMsoiCxsH8F4Dj2Dqckytf339lEqRH5ZmV6P4n2s8J6OI38uCNb6y6qyNpaJy3dgrtoR5fK2bDR/f6/PjdS4g/kAMkxU0wM1zPzSaTf4AUeT/x/TzWYtJ1Jqtx041bp50DqPLjp4eKEODo7D20tUvheaLbKYCg1g2Blt6nY44wW9RHEZIpZzQNi3XeIgFkMx5fYz9iOpswPrzuB/M4XdObUtTUUm9Y8aOd8HGLFEUMLlWMHj6ANirM3R+PNCihdjJJ7xa/55g7WRDvProQSQvMn/so6puHwlY4AtxZk5ExVjrPr/ugTBRge84ji
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7b2NG/asGDmTMPgLx6XWupVETkZOqaxw4MdJujZ8w9VbYTM5N0KNfeX4mutX?=
 =?us-ascii?Q?r8i6h5HetaYoS3TuJAKVHqltE71GjpO9hjpsXHPAJ9nBlVQqHxaiOk5h+Ed+?=
 =?us-ascii?Q?gpW79CWEIqj4NNUrKeJv6iZ6LZlIVyH4eKdhfjalpk8q77IHpgAePReoqfkq?=
 =?us-ascii?Q?FL11MeBtnjoNjwN/0sgg7g5D2ucXHT9bWU1/UZWRzwXfeR1g1XHGSxxcZoZB?=
 =?us-ascii?Q?bv4JmnPaVclNx22kyqOTJYFBuKtNP+JAslktQo/r0gYoRkY09igSo70Im2J/?=
 =?us-ascii?Q?xLgURV9nPMcm4WqTMu3oO3YWzP1HSfPgcZLA49x4qgvUEPaHleSxY+yixMGV?=
 =?us-ascii?Q?UATZghm5Y5o1/GIiOc+fmy6IuFUV4kYTAX8zzTtQBBDlTS/ZR9xXVmqWe09f?=
 =?us-ascii?Q?gElDAbSTLXQ8XjwKQ08SIQaidUCBcLnolKw1Tw0E3sY7Z8CdPWBB7MRyLh6R?=
 =?us-ascii?Q?Njcgt0Z32O1CNLWJa8Lkn2nUFbfmWK6+LuyZL/8+9Z3+NNt6ox0/QnSDNP5S?=
 =?us-ascii?Q?iugJAXP7EwY8ZNpp6EgdCtZjIk+AVjPEXezCmgGMp1Lw3Vl11wvhYDilM+ck?=
 =?us-ascii?Q?bbkrqkfa6FdvdM/y327neQucWPC/D7MZhcx3Kbh+TJrLzKIQ+YpyzM13mBHC?=
 =?us-ascii?Q?tmJs4yY0i9yLUqOE8zP0u0WuZ8014Ry1BLj+b8FxATJX6yl2tL3bZ2OXjsSZ?=
 =?us-ascii?Q?x0j4URDzZDXQibMxe6FUESbvUNpV4MhMtZ1pBZcW+GJCQzGABT3ceCAbuSf+?=
 =?us-ascii?Q?0OgEyqdmxOiPWz+tNQCL5x0YMXeks0LbfERY0LKN3kTcOfllJN/VkAZJ1vQ7?=
 =?us-ascii?Q?AV3pDlUodJlUhgqQIXvK3c1pcc2jq1gwk0/0V0tVNsvACFZ1oc6HE2BBIbZK?=
 =?us-ascii?Q?4C7ZJprmkqV2NxVybiLxf13zvBecM/sIVejeVtDZcdeTYCMNyaGJY4T9fS53?=
 =?us-ascii?Q?UnClDqY/xzJvZmYaNWCxHfNSdyXw0MHPAWnGpBoDKe+526J8w2FGfFto9ibM?=
 =?us-ascii?Q?pGWGF2UsvOgIGq1jIZWnOUHLNAUUmk4ZIVyEXaOuvxxKm6KrfjgUclPeCIzc?=
 =?us-ascii?Q?6gr3alrmARfFGQnh3RORNAW0+yjtOV7PojbCcSayTEv95xvXIVzlpntyDmfv?=
 =?us-ascii?Q?6hn99RyM1E9HxFJVlDfi+v3vZt7c04EThQD6Hj7yJmzHGuzn97p5go+9lcTQ?=
 =?us-ascii?Q?ynWUv2BmjiXcbeetOrhBpI8RL05wE58ZQN9H7vxMmgqS3ymPwZ6gfX4LOOE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1418fb-b897-4f27-0212-08dc477162c9
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 17:32:34.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0P220MB0785

From: Min Li <min.li.xe@renesas.com>

The main porpose of this series is [PATCH 1/5], which is to support read/write
to the whole 32-bit address space. Other changes are increamental since
[PATCH 1/5].
 

Min Li (5):
  ptp: clockmatrix: support 32-bit address space
  ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
  ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
  ptp: clockmatrix: Fix caps.max_adj to reflect
    DPLL_MAX_FREQ_OFFSET[MAX_FFO]
  ptp: clockmatrix: move register and firmware related definition to
    idt8a340_reg.h

 drivers/ptp/ptp_clockmatrix.c    | 120 ++++--
 drivers/ptp/ptp_clockmatrix.h    |  66 +--
 include/linux/mfd/idt8a340_reg.h | 664 ++++++++++++++++++-------------
 3 files changed, 482 insertions(+), 368 deletions(-)

-- 
2.39.2


