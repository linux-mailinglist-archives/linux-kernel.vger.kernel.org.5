Return-Path: <linux-kernel+bounces-165527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4258B8DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1908B21D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1712FF6A;
	Wed,  1 May 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="n+Hv1FBw"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2071.outbound.protection.outlook.com [40.92.45.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27A12FB06;
	Wed,  1 May 2024 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579431; cv=fail; b=bSM6H75saySSI0s+qjfU3Sscjfk+7rqNwei+2TtsY+8KYttLNv1gBnEg1vtj3PrPOkVH2DTG25lTorNKb/LmejG9J5dAC6coZ/0II4+znEWkhQN1s76WQzuuPAcVJcwA44S86DWQ+hEFmTvUvMcj9tk4nL6jJi6Xsxhrx0ZLe6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579431; c=relaxed/simple;
	bh=gUquANMlWcYdIaPuxXUeQnYpQKPvujL2Dh+Cpieh6Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oLmT3R8f8UDCeiR6VuIbt0F5XmzWJExDDrbGpzAwhQ3w2ELeVhxmoYahQ0e5aQtw903pPCXnirEy8Fss1DLAjj26s5xcm8b2bpHC3jRGKxnqgj5/IH+vrw/PcZudKPcjaJzHbOGO+T1xdpzBTmedQD0LX4OoiX/4xBmK4He2GA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=n+Hv1FBw; arc=fail smtp.client-ip=40.92.45.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxSgKJryq7qpVcYC66uyEkMHLbia7HiPwHexrJ5z9zRijRjE7l0SNQv1YFG0dudyXmDekXFPzYckbTVqLHcXvtHh3uk8n5c/S6y9xGmSv7JaLcXoJ6Z1q2ei+AlkBPUcSmmz3hKZHDKcoXpHprvASSo+or9CRo6crtrvQ92dog5PKANe1eKvmtCRTqP2VY6BluGkV+UtDEewtOi6Cp6ozCe9wYxGnp1EV1xuRt3dVn+eXMeA2v07Y0Y6JEWB9WUzByvWZLu0G4QvSYm+tcBWSqIoKJPgzOvIfIFIsrEmTDMpn1gMOr4h6h3xH79MtjdnetnnqNz6MNZtlci5YW4oEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcf1gZIoZNtYsqOi9BO64j30c7w7uBRLlsu9fJeEv5k=;
 b=oQli0Dsoe5kxr6/BVGiHJ9boVRqEic9c6/5CWPzhsRRXMU8b4vyrR+b/SSv5wQPnk6NctBD5NoFitxW07yqpP+z7wYua/ctf+00KJchUyFCcb573gS/ka0Pb4V+nFWgayDanSZNWb1Ge9Djmfb83KS9qxffyT0ZIGpFi/TWha+mRufPeTw+8K6eySADsTBs3Ali6uh2swPZhp62eklv1Qmu7s8xjCbXfo2gFtKm0A8/fONgTM4Y3rQFTDwHGP7v1LjtRps1WAbAxDvlDdZlB60mLj3SNz6JZstW2w5GaM3rAMN5pVkrewx4rA4r/FeA4u7iyWiseqt/cImOrZN75hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcf1gZIoZNtYsqOi9BO64j30c7w7uBRLlsu9fJeEv5k=;
 b=n+Hv1FBwLauLnCb+9pkZdJH/w418pB96QRDpS/zsmokb/pLeApHNBqDDAxVKNkU+8rfcXYY8xCGTAZMWVrNK/Aok6ZrdzWd9c8rF9j487MOFxbelB2uyD8NJSzMzSA6AJ4Cc5ho5D913af+KKmJlGEYmevoYh33SG6GHDZcEHgJbjbFHUh6IKAGwryg/rHQpv6TTn+k2A8lgtnC98aUfa4RO4CAriinjwkB0rBnh8pauwteRmhV2IBXmvt+d6hT+XUAAqyU0R5N8bwzMrweR7/JvMisJOvmgdvtU45xsL7H6VhmnLqnZviiroaiyrkWEXPqW9eu+ljyXkshpn6L5Dg==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by EA2P220MB1331.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:257::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 16:03:43 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:03:43 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 0/5] ptp: clockmatrix: support 32-bit address space 
Date: Wed,  1 May 2024 12:03:19 -0400
Message-ID:
 <LV3P220MB12026032F3316F557415AD9FA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [U7r5c/sKRNqkJESHHUtHX7DHfYA/ZIgB]
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501160324.27514-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|EA2P220MB1331:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d775b6-0c9b-46df-ae8a-08dc69f84616
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	jYw4DALEYoON5kcJtOv3+nQaQmpyNN96VccpjWjKusgJsZJkACSCpfINbBkYTeSKSetLkf0Jylj0JdfsgEWslgVS8dwMPpLJH3krprPytNN1t/Sn1AhcariVAjnGpRPEWazowW7f8ckpnD+H4JN6Jm2+/92IaQmfNQb+yVojKzrN1wjtrJ6wBMr8GfnxgAu6yERm08jqv+xeL9ixF3xsbOCZSU07/NH1fk4sHUhu98K8AfMVXAi5SHNwz7DCRV2HpGRVBKgAGxjOU87XDQCDCMTTdxB8dSEQ8LOg7V5dvv/r3DXuSFHCfi/DSeOCp2PS+BoL68Vp28ARW0WejeoezobhC/nJgMKwZrz0qfJEO6SU2Wzb0B4TUlCFvAaygQR9cfXpy3NX6OPmFtCbC0JwCarkjsLifC0QYjm2v26/GH6cNEloDzC1MXOxYqHDi29pnwtsCPiWJJkIbNZCNy/Wgph0uDOwqRua1napOc2qs/2YTU3clRUSnAAQskkskp/7Wv3iAIdS+REOXMT967KQrIswUjrpvKpZVuP8/LFQJxjqA3JS6Flbd19sDrj+2HeA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJHYd7W0CWYJwhwKVUL/RFOce4IZvuZ3QX9pzGCtaJGJCp1JgGRIYguo+788?=
 =?us-ascii?Q?0pooMKjPwnXyDiwDXjtrqEFSraDfoTFbT2ZE9XKwC3BF8AOmPZECdlLwl0fb?=
 =?us-ascii?Q?GIz6bJIYuNCf6Z7zuYTpbnSZZ0HOkUErLYjnZGAGUz1zf4hZBmazffSAgx2J?=
 =?us-ascii?Q?FHnY6AgtrDqwDDyjBXwEuLQHR3CX+HfIyfTpxjbqbQgPv0XAZtw/Wz7WGlY5?=
 =?us-ascii?Q?fD1Zv4fMTUZmK1bNjR5KGoewePulQQZZXQhw2ad/MSzlT5Fzxh4JLrEhENiL?=
 =?us-ascii?Q?yNSI8NFtuocF3rbfcxYPVXgD22O+7mFHXYqy1iiFQQOv9y9NOw/yZJfxaaM9?=
 =?us-ascii?Q?ynyC6Nw0kaTw/bIV8/KeG2CM9PL2WzdymxT9Ufri1vzATs2CeJu6Bs1bvFWl?=
 =?us-ascii?Q?OWxbcGsygbZdj4iPohJLsFHtM0ixZ8jXv6iS7ixKB2/DY5kPFKK8zUQa2F1C?=
 =?us-ascii?Q?aCmp9SN+IpmFmSUEXWuoGY3YXWuPOisBZsZxBQv3Jygb5N74wjHLkOzgRCUK?=
 =?us-ascii?Q?8+zo6B6UkHqG/aPcpH95IkPHztecCFdjOZ41FJIeKNVm6OWexx56d/GYlxtP?=
 =?us-ascii?Q?K8vkbqLRh4+03J+QQjTwGGi/2PfJVt8fh0U3KCHiyxzVJgrVyYhxoDoXa5k/?=
 =?us-ascii?Q?PRi1KjJ//WpsVwy11lBHegX3VHiHzD/1Gtd01+Leu9cW4Dduk9h8HgtX6nX9?=
 =?us-ascii?Q?ZgWbbGWI2PYsI56l/Bh/qnVLtpDKiiLUILhetXtofsAL+pRWdoM/hqcbU4AO?=
 =?us-ascii?Q?jp0Pwn6H6suyNVtNgSTypuWO9TUWpXNnSUtcirORIcB8zxxEHQ+di1hvWb0g?=
 =?us-ascii?Q?HONIApFxEmyW/B5Mvi5edPCBn2ejHkh8DeGRQE6LCnGwartQmgbre6H7EKbh?=
 =?us-ascii?Q?jFxubnB3rd8MrYgVRd8ITvqACwb32+7bSM0hZPu1asq4uERVtQvgJ4AImUO/?=
 =?us-ascii?Q?UFLagaJJ4VWkNIao3bIsPpnRgQn9ijdZTKL60pWWOzdrdcend7jQcCKnE+6T?=
 =?us-ascii?Q?lkUHVAK1qmPl5c5wgdzEQZx8uPoXUeet3l8skqK4edhmPfOs7+Pqc1+THEQr?=
 =?us-ascii?Q?EWXXqcYB3asjOHlnWSjJMHyrhP+fVJ+Fjs9ODR5qG/YoxonhRzTJWu3u9oxY?=
 =?us-ascii?Q?2WFOh+3BSXstgpen90ni5Ue0Glep/KRN2z+46wmmqy92H0A0RxhGvQ2ygWo6?=
 =?us-ascii?Q?UdMHMuYA2Dl1NAMTt7oWyERytM8jHS1b6APrxUDig9bnRTimzWiwUV9elss?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d775b6-0c9b-46df-ae8a-08dc69f84616
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:03:43.0960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1331

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


