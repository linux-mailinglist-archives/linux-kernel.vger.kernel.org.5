Return-Path: <linux-kernel+bounces-74675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5396985D78E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C1C283E02
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379544CB5B;
	Wed, 21 Feb 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Hq+f8uFn"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B224D59B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516906; cv=fail; b=rMVXiEfliG42XYhQ9d+QlK1DrED5UFXEUBAjHXdCUM8RFCwAQzwRpAGJmD/lNBxmFvZ7KYzFzeCiHlE05sQ7Y6vPBS/x5i0mRyB21GzYRHddiKNqWjGKR/g2T3TCHy2a/lC8q5gSjknV9WS85hewQnwE1slKGbATgzUojBe7bts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516906; c=relaxed/simple;
	bh=BDcLnbXl771Mgu0RA9ajqiJgXlhIwJbSR0zN3t7/Qcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MylL7964OafKbldyZKblpTUcE+mP/YAj9a9VPOyMrW6d/oG4lSmz/VdVEDW4RE2Gd22GOl92OReCfBpxu6mKII5D/yzhRTVtjgrgPxbbAw4TZwN0JdAH+5apqfT8IOzsgvts+7+Naq7MmuwAKV51qW5yq2lmCBr/A7z+/lJQNt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Hq+f8uFn; arc=fail smtp.client-ip=40.107.14.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv0lTP5yVg27Z+tyKJfIVs9pyXB30ERrUPIofm5I5oh4EOtigFIszOgxQxsrliJiHdV5LDQokObld7vDBsLnLC84VRTQPWsNzqbcB/gH5fNkg2LqX2wveY/x3lV4g4CFEzZLxAiJMt3Qa6V5Q0XJXT+BgCeRm3WOfe4S4IoLfa1yhHiZ2DLTJ6QiGHrbpXQ5gU9vz4aqE7DyFAn72HJsIj9zK9ACjbH7MtTf16xVeRXlbdrUSPUtzdxJJgHiKahCREUrOYp/y/Zc/sgnJGXBroCyhEwfe/4tb/J+9bzYRm0gSGezggSZJ+gumQZN2aofVgrmkAi/ZH83SYlkhc5Ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsTnaL+X8KjbDnEq+nkalPi/K2lNUmqUqge4nToCYBc=;
 b=CI6WZOa7nFDmWlzslWyeLCLCBy8pbH+JLEA2q+yS9+Zf+beJ1/l2fprQgXwtHQrKZmZqKiUxayisco6Xo0X2Sf3eewkdSj4ph07b6COred32AzieTf4aEVC39Hc1jrq9/xlw85Q7iN7wdDWW/nnlbccYkV3+7zIfJJHewgeTsqBPzT5jF83i7pN1YDR/5mARFyuq/Zo4WjOnpBe28G1ATGQhgt5DYXOsMUyjfCjka8oitq0KxnTPueWibst9mZJgNkqvoHBPmLhU5fGeW0hIdAIUD4AU4myXxX4pUilpXF5Ev7Z9lBL/yG7ZhHCHhf+FKU7HtPzqtwEQVMcQaNIrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsTnaL+X8KjbDnEq+nkalPi/K2lNUmqUqge4nToCYBc=;
 b=Hq+f8uFnfaPRhXEYIbCv9vmmizHcQW0/8tWmGn9GbQJfVy0S5NxGvB+Lb7ZKqwNslX0kIxcUwYGlyXeUrBhpafp2onSanNSUiBAP+7TE5O3E4cntViRicDb3vYFLtwcIrH+GkFYZQitLoTWytH2Tf2XS/N5iStSPA3v0fmsBuiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DB9PR04MB8395.eurprd04.prod.outlook.com (2603:10a6:10:247::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 12:01:39 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 12:01:39 +0000
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Chester Lin <chester62515@gmail.com>,
	krzysztof.kozlowski+dt@linaro.org,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	soc@kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Subject: [PATCH 1/1] MAINTAINERS: Add maintainer for NXP S32G boards
Date: Wed, 21 Feb 2024 14:01:22 +0200
Message-ID: <20240221120123.1118552-2-ghennadi.procopciuc@oss.nxp.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221120123.1118552-1-ghennadi.procopciuc@oss.nxp.com>
References: <20240221120123.1118552-1-ghennadi.procopciuc@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0016.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::28) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DB9PR04MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c8660e-204e-4210-297c-08dc32d4dc32
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UJx6tF4pNqOx75ddW0mbcEYLkuP5rDxUf/VQcXfJUtBkOKuS+gCJywgp0K3wurCuefvAGtnMiKlSOrWkLRJatLW3lLsPDrsW9+JtJS8dDZC5kvL1apDp5C9OACH09ec49a15tNunB55hQaFec6PZa1bXIf0/msF6CAqr9wOoMsk8XhhcaF4wMDSxw3cuBaR2kbK5cWuR0jM2wTUpZk75lLLC5XkWSCCN5o1e0di2+1MbXx1D4FTaG2wLiFoDwxlS4y8vTiscTN2KKDj8Hox/ThtoplnYFmVwodSrSW4rDxd1urWTbRip+c5SgibzonQueq/nEdfPRu/xjZFzEU8XP5u0HaLUZZMAZHsm29oxqE9f6b8b2gSM2F57SWG2ZlkTpLeL0Z2n3sGE6T+oQ83BUwx63zyGcYvfPNpi/Vm26QDcgew94xKM8XZSKfnoDxvmqsx8RypID15Zwui1rs6pbnI4H61UcIV/y567v1fDbqPuDaVwrL/kQPN4HtZ0njsAcPwDX/juOUEGLmqAe/0DNb/Ec6qBe8+4ehros5dMj1PFsj6Ckl903e0vbH2tTgUJ8p0KQKeIyyIkz/1rFXfmDSnUtimA3Bu1l8o8PNA0RXRmW9b2eAEMTfYrvc4DQz3a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ENElS1L3LZCfzgt4sMoRM/pbA7sjC5Xp+aoqDvRtAODZr+/tY6GvrOOAphhS?=
 =?us-ascii?Q?yz/DVe1QFDApMVtScdfKEqGHcm+W2bG0ZU1AyxvMp4D0X2/0A5IsZasVOWr8?=
 =?us-ascii?Q?l+zgkgfyIoZrxxk2zValkhgw7/K7YX7J2QMhg1QKmIp6mjL1X5yrG1cE4Np8?=
 =?us-ascii?Q?SkHA2NBZlsif8rog+MjWxh4QYxBSCQdw4Kt2SYVjCjZw7dZRavFHVFEqRJyd?=
 =?us-ascii?Q?1Rj5BPUdez2k9QyVTmopVzLBQ0UR6SAKoExS2CdjB7hNIwaJYY6j4hni1kZ+?=
 =?us-ascii?Q?ocWzy5pccaVncYgjLgMQR+JjvQtAhidxZ//NKyGVeS32ObK4k1V/WdMVKuAP?=
 =?us-ascii?Q?boEPoSyFhrIEiKRLoYnm4xTo/ozzcsDUOz7rvrHIwjJAScDG5axehKKaU1zX?=
 =?us-ascii?Q?/jc5FY3IW1woIFBIc6ol6GIu5mAOw2kFa5WzLwo60HO+slwIXYFQCE/7pCFS?=
 =?us-ascii?Q?ennuApmUmIpAj8Ck5bguXWAmRIXf4ZmFIs4EA6cR9mODqA0T4Gi+2APqP2y9?=
 =?us-ascii?Q?OkPsqFWnNfe0Smb/cIS2aa5GXmGlBpP/MvshAwUu+mVLvNm9ANJPqMGLPWJX?=
 =?us-ascii?Q?HbOUdEDP16Z2Fm7KKu0pBzKZ9WDc6UASIdCyvueOTVueqI6TwaKbyAP7E8fI?=
 =?us-ascii?Q?uBaGdIj8tQmG99LOKyv6TPW9IxUAEfJ2e9QD2/jxnSU99kp/ToupLNAHujgB?=
 =?us-ascii?Q?g75VB5riE1f5oDBT3x+qp0yIDoK9RsWK8E56b/U0zqzXh0iLZfFqDdzDUhil?=
 =?us-ascii?Q?sgc2zXz0ZqRMC6n8/zRO0Lk3sFxVsKnMWWxrkKbsGXZ7x2/Iwx2VdjkpPh3y?=
 =?us-ascii?Q?ag8vlt1YTa7eSSY3UNV3ns7JKLPUs+m/cmUfiklPVgD8KA0hsD9E6xKuSj/x?=
 =?us-ascii?Q?qFN3qb8r20awhWDuMsQbvzJTuy7GN5FJCrOulng7uob/Cbj8WxtOr+XXP38j?=
 =?us-ascii?Q?n+VBZX1QpbVQxO/y/WiKn9RsbLTG9C2BZiWsKeorQchGpiTSIn2jHeibDuSA?=
 =?us-ascii?Q?JODBnJdV3a9bcWUWIXA9BBAcT7WAOsqLZulmd3N1TtM4GKZ0e+VECqSmY9sh?=
 =?us-ascii?Q?NOsiA5nkd3YymHUjbl4+H1kYspudFwmg+nqTZuKnNHoCf4GbSFmaaaoCVDLi?=
 =?us-ascii?Q?AoHLYzIdA6rgr/8cnNkIN0S3r/mw+hzQ78IcVoKx1ibyREQvMJphM169aIoL?=
 =?us-ascii?Q?gfrDfz/38ZJbYJn6bu/RfdfOpZf2IkKstF3QYJ4D0m0LKOiZXXjwTOSnB9yc?=
 =?us-ascii?Q?XdgHG8AJM6FUeiiK/GllsK+XSXUe+MZsFecGmHrhPNbnURZWefSjaXJK2bia?=
 =?us-ascii?Q?d/guIXkB49CKOsV5WiW6o/Z80+A7bbmNhpFUkodOYrW48cSuIzNtTvSL5lAR?=
 =?us-ascii?Q?9/51/EIWsFJSXkn7FNsp+UFiF0x5cpe0C8QlYJqVcT8CMrTzBNYlT4E3XQZ2?=
 =?us-ascii?Q?tLixO9Np7mkp2AamV838nDDH4m4VzwOGpMsCtpl/g2yDi6uvSOIqNHSzg2xK?=
 =?us-ascii?Q?aTimEYO9csrApxxMF10KPKd/zstGSwqdXDucGp+zdZRkr2fCPYblLKst4o8+?=
 =?us-ascii?Q?O3ORdFSeBWQOaTNxpurlJmOlKOLngO/nw5mQxphI6zZx/ck3b90tNJndxInX?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c8660e-204e-4210-297c-08dc32d4dc32
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 12:01:39.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuC54qs3IOhWybv0nVunUdOD0NjHyb+X/0la/708v8jXIO8oV76UwYSU84Xf//hbe6p01huOmy7cLMQlMh4yqxxgit/T9/wgz6jFeCMikcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8395

From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>

Add myself as a maintainer of the NXP S32G DT files.

Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..09d7a0489952 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2543,6 +2543,7 @@ F:	drivers/*/*wpcm*
 
 ARM/NXP S32G ARCHITECTURE
 M:	Chester Lin <chester62515@gmail.com>
+M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
 R:	Andreas F??rber <afaerber@suse.de>
 R:	Matthias Brugger <mbrugger@suse.com>
 R:	NXP S32 Linux Team <s32@nxp.com>
-- 
2.43.2


