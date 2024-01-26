Return-Path: <linux-kernel+bounces-40051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E3983D966
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8671F237AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF6B1429B;
	Fri, 26 Jan 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZFovAG6d"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D214280
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268779; cv=fail; b=CeLWYuydiKUPFTrFI2j/wJZKVaCmzZOtGEnZivaQ36/qZdOKiMQEQ0+xJKDo/i0uUq6i8NonFtaGBVTBsPQpAZrew8Bnz1+efKr62UKDLJvYyxHM9w4LIahvNanIUCA9Rk86Mr4cYq2LZ0QRuF4GvtPfBglm8QwZWTGvnPenCtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268779; c=relaxed/simple;
	bh=/yQsYmhpzglEGrVtdzUlw98YZZrGRlEaZctJbbtSmmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+9UilswslVOZ1E03Yau4e9/ybHKEDx7rJskYY+1IwXL2R3IXU60j7mazklp8E/PKc7eTP6UI4xawRrhHxa3L5Dmnm7C7q3Xyj9OOGreHUiLIk8YOxRm07EzwiZicOf4qUkfs9rozXVJzmGNFMI1xYFPftwCe36fh27gRo81o1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZFovAG6d; arc=fail smtp.client-ip=40.92.20.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF4uggHvSVuwTlDMgoNT9gMnMkjOzMgaZnD8xh0oL/ZS5ynFqFHHZw1Efs7l+Bct8yxzSigfjrl8rTy7tLh6BAEkkKX2dmfQZdCTwoklNLsJeSeDT/FJuiU1msLiSpXi7hUS8IXEguvd0uf6CxiSca31HcIthyPlS89sH2DO0m+rCzDTobR/iRQwEiBQ4ITFqHdFpzb5741/sacCKBid0+wMbq8mg4x6HDAwsPz8ggPNeOHKZaU3siMg3hJ/hFmpBxH3RxOhvzuFNSEBOc6Ulv5Lru0u+B8EbhwBz1H8TXv0ETDU7RspxzipDv+Jbs2eC2rgySFf8sTJAgMPVZaaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRPCH1TxfsnOzhetMeOTcGu/rbVLdrtb3UU3sZY4aIE=;
 b=YUOUHq2AZQWmatAsKH6exKvlbzZSM9NCUfy2BDgwFlzFFthCyDthCPOWzoriY2SjCa/Gfxjf/jmIY/S+PMhpl1sT6EpjifqGpxUtaNMXTRWEEt8uN4TYCax/9i+AOhRVmn2BsFZ+9uW92R8orCkchYon9aWk2vAH+gFBObkrFN0hzGAgebdCSaZwsaSkb2LF637r7O4gcSVoIiMLU1O8Buei65Ed/I/xeLne9c8isT3Sisw8eUpDHwbD4tIrls2N9Kg0f9gmQiV/TJP6ly2dc1EkmMlWgoe8a1rVopTt2rPkSPDx9qFqOZZ9TIcrCzOJdJCBmkvDQa/GuHOWmH+YaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRPCH1TxfsnOzhetMeOTcGu/rbVLdrtb3UU3sZY4aIE=;
 b=ZFovAG6dlcMdM9OO19ZGUPk5msFSCuz4EodPkJZBF1vexLYMHz5j8VtA244zWC4LtCdsjXfEFCOGqZvmfeKa0y1jaZwlb1QZCMQx5rHNB791+GZsCz9NfSzmOIyOWKp+uYzzi31oLGud+GZx/HYYw1KwTNIoe0zDcp2VVhL61S9ypU/WGaNwBMxSa1jXVroRBDK7Sxa1OY7++uwhejWYpGLHuAGtL69tMHImLmYQ83jxhFcDUGrNh94IRMPIUy/hnM7IUQ+g8sxlQ0RmxDUduqEUxHwF2z8IZnOH81rTfNnspmfTfkoyTOx0N1b/fuBpiy+DbUCCca59eooiCrUHoQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5120.namprd20.prod.outlook.com (2603:10b6:510:1b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 11:32:54 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 11:32:54 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Setup proper info for SOPHGO vendor support
Date: Fri, 26 Jan 2024 19:32:40 +0800
Message-ID:
 <IA1PR20MB4953B353554E71776D4E89DDBB792@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126-squabble-vitally-7dea14d09e18@wendy>
References: <20240126-squabble-vitally-7dea14d09e18@wendy>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [LmgO9Vr2/YESrHs8W2YTKyxUvD4xCpkA3C+371ybbdop2NQC04TPW5zP7TuLY7Sk]
X-ClientProxiedBy: TYBP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240126113241.924381-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c130155-1e86-43db-bb5d-08dc1e628988
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NuBg7WabM65vMibBGTyKHOnUjCEvthxI0uCYxpQ7VLxVuEKJqOqbfq1iTpa6ypTWt6UbXGSLdZRRr4TaeMSY79RiKZKaNONR7KP6PMjdEMFbpKsXwUTklP/je+KRogumR+fuH8WKeGRyi/i4oZ83JzMGtqqrBvQJ0U9YWdH/TteJWkZ2QzjLgEzWWUs/Z1Bv5eyO1kn2XJZjDq8dJICrBL8PpG5y0pxNKBgi/BA/wfaEg/u/42GkFbr+JajJ2Ssdu7vbbzqsXsukV8uQJ0UE+Smkyc5o3WCDMPr80xXmusiAM0DVC2OsVGhHJDVmmiRjW3PHWgjGyuTxI7MszKAtbypCXZryvI7vwluzEADA70PKyIp28otss4kwPVkUwh1/LdTF59D/6ciPVz3CgW0ivpl9zWT4oea04eyjtDOMRr8hgpGnJy+g8Gc8Cpzk2Q4f0CUHJkcKNqpbj3ROTquYqCS6oSN73aIcrUOKopKIO9aiM2S7VBKonn6yMd7hKilHUtxJphJHJFqG1ztNLtixeRxcGWLPjDCQwN4a14pJXYr+Hhr/kh4YVz9NgVYo+tqrtkzS92Ytpehigl4qVjXZ2FVsvAyZcgJ2wARatZEbCeQ1eKeHCrQY+tFHOQ3kz/u+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLBp6Pq+i1LYEPxNK36nZz6byddIOv3zC0Bdy0LjItHj1VdZCmn2WrnJ+H0n?=
 =?us-ascii?Q?h/1rqUPZcGzkoCfrz62mSThIeCxoQa4+bPHrozBZpYEC/pqaS5J6lNvN0Tt2?=
 =?us-ascii?Q?WQkpEEfERWWAGuvHZejdfggWTlMaY24jy2aTTnQXNRl/htUFJbDRI9fxDuzP?=
 =?us-ascii?Q?dVBQUzYe46geYWmhM5Wi1CkD+qcpLpNhcPbAY4JToKkSPoPsMWpemq7Iokzf?=
 =?us-ascii?Q?99lUCjnnqbUKmxjdo8a38lOccS4Pe2hH1ZbLy1ANQug2oGLhFhJhwYpWwbUP?=
 =?us-ascii?Q?FRmft15ORt2o5fkRHG70Tbc2gQ7WFDQZHdK1zAX3olwgmIPgbx7gl1k5EZ+u?=
 =?us-ascii?Q?wtLWZA/cgwhNeMhwGLSosg1I1qiRwnwqgIqdUn+31nXS1DSyIU/8pY4b4hBI?=
 =?us-ascii?Q?RfgNtc/A4rwTn0ovIdSq7T2/H+c6zF7Gjt831ql0AZWUROwMYIzzP85yD1PJ?=
 =?us-ascii?Q?hhSExN4aZ3U8RaUgC0kcWPITi+Aq2F8b7F48//p/QQHF8p24Is1gXQqmi/a7?=
 =?us-ascii?Q?lPEgPwwUZy4nskW8Hy/p6Wd29UnFeteRuRYEoUAMurvJHYYrly90lSedcYpB?=
 =?us-ascii?Q?3V44Y342V6aT3y7E2pl63jpaKI+A7iKUDv0t2pJGvQWSskeXlpX9dVFYwute?=
 =?us-ascii?Q?WWjK9FtLR9Ax9vdgjHOyHHMFjswQ20Nv6RCtxt9XmtHaM0UKRcbSYJogN094?=
 =?us-ascii?Q?cCAwhF1OlCeD/cPcslUrxqB2HmaPOOOwC50PYecojFhbkWFOMZQeVLgLiZzC?=
 =?us-ascii?Q?vh4CADrc9dMhAIQo6T319QdVRLhZOjCeexR2KtQYQTdh9pwUOKUG3nZ2gQKw?=
 =?us-ascii?Q?Y0KGjllRGvfaZGE7zVkspxGzW5I+VUmhtUv9BlaPCfpyt0TP8tcYNsajqUdT?=
 =?us-ascii?Q?baSma8cxGC0OLAPuApnsscpiQaV9Bkd47eOTVCHKr/G+JwZIdrR324BIohJ4?=
 =?us-ascii?Q?gDXLFQDSuOAYmVjVr4tvoeZs1iEfcgGIGnPzYKtYArR5ngIBvRwfEhWP4+aD?=
 =?us-ascii?Q?MqTzBlEs9QVPwG8j/PmSSgGBL9Bl6Y0tieqwrWOBOmtnEPZL81bxD84+9jpA?=
 =?us-ascii?Q?Aqet9bSfNUHwUw790XZMNjbV3pQxHTRpH86Ugzm0PwxV9Q4mkmwEyEsgL0Ds?=
 =?us-ascii?Q?ZLBHhTkxO2yAgvIca3duZeTPtwF+emyhWe4cdedpod5lVyhi8IKbaGJwLKmx?=
 =?us-ascii?Q?6ofSuuV8WV/dRBAVcY6UoZVNh0BK8ctdTaK5n6U3s5o5/22Rl9UOIkcvv4e1?=
 =?us-ascii?Q?FQsDS7CuSl5ynJNEQ9kPJZvz6e0wXbs0cBttTUwJiw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c130155-1e86-43db-bb5d-08dc1e628988
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 11:32:54.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5120

From: Conor Dooley <conor.dooley@microchip.com>

>On Fri, Jan 26, 2024 at 02:04:50PM +0800, Inochi Amaoto wrote:
>> Add git tree that maintaines sophgo vendor code.
>> Also replace Chao Wei with myself, since he does not have enough time.
>
>Ideally Chao Wei can spare some time to ack the patch though?
>

I have asked them about acking. But sadly, he seems to have no time.
And he agreed to remove himself from the maintainer file.

>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> ---
>>  MAINTAINERS | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 39219b144c23..0dbf2882afbf 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20446,12 +20446,13 @@ F:	drivers/char/sonypi.c
>>  F:	drivers/platform/x86/sony-laptop.c
>>  F:	include/linux/sony-laptop.h
>>
>> -SOPHGO DEVICETREES
>> -M:	Chao Wei <chao.wei@sophgo.com>
>> +SOPHGO DEVICETREES and DRIVERS
>>  M:	Chen Wang <unicorn_wang@outlook.com>
>> +M:	Inochi Amaoto <inochiama@outlook.com>
>> +T:	git https://github.com/sophgo/linux.git
>>  S:	Maintained
>> -F:	arch/riscv/boot/dts/sophgo/
>> -F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
>> +N:	sophgo
>> +K:	[^@]sophgo
>
>There's a single instance of this "[^@] business in the whole file,
>is it really needed?
>
>Also, you can fold in
>

It looks like I have made a mistake. "[^@]" is not necessary. I will
remove this.

>diff --git a/MAINTAINERS b/MAINTAINERS
>index bf107c5343d3..cc8e240ba3e2 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -18859,6 +18859,7 @@ F:	Documentation/devicetree/bindings/riscv/
> F:	arch/riscv/boot/dts/
> X:	arch/riscv/boot/dts/allwinner/
> X:	arch/riscv/boot/dts/renesas/
>+X:	arch/riscv/boot/dts/sophgo/
>
> RISC-V PMU DRIVERS
> M:	Atish Patra <atishp@atishpatra.org>
>
>
>if you want. I get CC'ed on everything under the sun anyway from the DT
>MAINTAINERS entry, so this at least might reduce some confusion about
>who is applying what.
>
>Cheers,
>Conor.
>
>

Thanks for reminder, it is better to reduce confusion.
I will take care of this.

Regards,
Inochi.

