Return-Path: <linux-kernel+bounces-103755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D2987C406
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516AD1F22F55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E527762C6;
	Thu, 14 Mar 2024 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nHiMmBt2"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299574E31;
	Thu, 14 Mar 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446777; cv=fail; b=UPWY/lHyNpJhfyLg5pg/IPu8OAInnbnQvJEv7BS3kge0+sFLVnB9WKqsu4aEGtBtDW18wdsXEvQwuOIxdPBOkv/6PunvJ5NXxxzg07hThSGX1oeme6NoCxmYhBm8O9jYSKI/0hTVWcNkJY3R7PVj4V+D5x83E8BqBGfd4I9EfPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446777; c=relaxed/simple;
	bh=WthYkSqqRI1XlcktK7lICT7QYH7vKwbWB+8t5Xn+s3s=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=sdS4iyWKhpDHhdHXB7CqdfTLUfWZj139xiHJ+KLe5d1MZ+J8Qdb4Zcmy5WIoaWTQ6+2Q2Cniviitq7DklQevtzXLI+1hewF7m9vr3Sd8dnalN3hB9tkV7SMIZomCptJsP4YFCD6q9SSf9gHqU/auhiZmhWquOF6M9pd+ZjLd8lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nHiMmBt2; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8L0+zM1jbUTVJXFXe7h2o0TyipnUULq75agrDtS5jEn0BhEb/1br9vdSuXjVubT/gRLgOP+cjRyMceYabTH6BxR+1z6COHjgmruafy7hzxjjB6NRwhJbPtgQVr3U4XszJRANadCCMqYXgk1RWwz+RFFoO4r7dyTo/jSmEqu+uH70LlM7xK6EYYthFtGPGPGMI++2ECaomlzODOa6WWDy8nheg7NK7NkO+Kkog+DpsHKy7nd2ep4R/UdA3boUaK04kDaZgsK2jXtiZGIwN1BfOI2O+7WctFfxehDN2aKO9xSCOOooU7gvWs57aYH2Er/dKaTaK9da8pvBMY5XeUijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/SYwC8pJAoZD361Xmx35ejErKFFxxrdG3yPRvmok2k=;
 b=oKmwQzms9rcFrk1sJTqoxhz6pOqB/7I5BjL8ul2Q78zUQhAPSOGH8gvvDwkdIfQkEOMCjOglCGFK79uhvFdmUoqVGtE9ye28D4Uz5tqp7TapruMHiaKmiX4r8p/i2V6T+Nkv4GWVyxTzJx+P9HtMUW1V5+/7iIQLBQ0pTxNYd9i124xplIsBE/bNTP76x9mT+jfudS7PH4bJGKtgvxDuRsLngE21gpjVWSIr9Z3dkN2HCMT5i8g5NxdJTvDSiWnagFLi/ZErjVqmn1uV5XFt35CiFIletOLnXXDKFRx26V2tmMH24XfblPcHScSY3cWJAApPkEpjOVJLQdKqp62F3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/SYwC8pJAoZD361Xmx35ejErKFFxxrdG3yPRvmok2k=;
 b=nHiMmBt2ilvY/cr8ipzqK6ETUbPdRYZoRHfJLFOOTaMRxNTgRztEdOtnQh68fR1l3ffgCrSu7UZeyGM9eln6vxdz9boFykAEgJjFnAoJm7WQvhOP0CpbSyCwyC6/8Lg77OHMWzs7CeQGQGjSchwYvSyQP4a2j4axU8N9td+NL9Cl69O/Cw70hA58hCbX40USvjp8+nOgxF8G5gm39ppKBBkr/96gs5YvjYia9zcJzYEA1Gf2F9+nSJMV5CTlaBnv4OlbclUwKR8rtGvthVz23kq0/VT5q7H71JZxVpKY4Ya/f0RFJh/x3lmmxkA31+CTDG2Qz8q7vc0EZbyjxK0KaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 14 Mar
 2024 20:06:11 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 20:06:11 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-7-rrameshbabu@nvidia.com>
 <20240312165544.75ced7e1@kernel.org> <87plvxbqwy.fsf@nvidia.com>
 <20240313174707.38a71c84@kernel.org> <20240314130436.1052c739@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 6/6] tools: ynl: ethtool.py: Output timestamping
 statistics from tsinfo-get operation
Date: Thu, 14 Mar 2024 13:05:40 -0700
In-reply-to: <20240314130436.1052c739@kernel.org>
Message-ID: <87bk7gvary.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0142.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::27) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e136dc-b603-4576-0a4f-08dc44623193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dsruFFaBUShDxgc27y2YSztsjunVBkkoTPB4tJsqqMFOw6d7WOjJkdHNSvEK/mry0Cq9TBqskFDGIAh4Ecf5gWNEYihhW6d0YG+h3NpodVk1uKkB+gRloGfRhkRrv6NKBeb9/F9h2AUqkwWHodI4j0zcx1HukNkkH5odEUIWZlhO0cActb3wJzR3N99ml70u0Pzgzuf6x4re3YVwHHnyFTqPB/tV1vl+LJ8+cLIZTckvVQ/N/b26txUDimZQ0/wiiVaFoJMP8tcebdJr3qOQ66ybjULw4iAntEgIuFl/J//5x+iY5SK8z5jSIs0MB0UQiJ9Qa2ijyJ5hTQmRhvXjz6vPDO/huZNbfi1rXzHDhijnKOzpqAXloiPzOBlOYzlDpJhB3fWdRso+u9A/PyeI2NftVxDx5k0Fjp50tYqk3Wt4A0MU/Sv6t/mzz+2n1D8kHIHcWI6sbB0WN1jdrz+2YB3vSJx+PptBnQeS1y2rf4iPDLyJC/y6WdIyF2upU6QpdDEfoq2yxaJUCJAnlbNhg8QrXx4giOXZgiEtAIA4SRD0kDrWmW26890u4LH6L6VULJDojEZ+1bxORx2/mJ9P2uNR5QEeVlveIMxDqysZFpE4suiOywOAhnb67vj6f90tmp4rUClbSdeg3xj9VDA5YMFhjc1Wto3QtjThJkwNuNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ldnOkzgqJt/zkNgrJS/N8ITAZn7m4FOTZUJJ7FKGEENR9fyeqUUtx7KPISO?=
 =?us-ascii?Q?AawI5T5XyxqURVuaCroKFlNSn4SNbqLcxnlWtSFjWANiIWqh6MCbQpdCXudm?=
 =?us-ascii?Q?Txa9xwKsDYN81qdZuQYizdmPCEghss3TN8tBKIXTA/w1U2uFe4FWaRLkun88?=
 =?us-ascii?Q?cT/moNFcymLLTAI+7ptEMaBs1viGFa1hZRYZPvVpaPl4pDgI3dx8blwbNCPT?=
 =?us-ascii?Q?15eLf7OP83wSsrONDhK3dW3bbHvdw6bAqPwCn5Cx4hahrVp3GlBztMVBjV4d?=
 =?us-ascii?Q?gZ1zpsh4am3tqd7v+53nhq5jwNBwEqJWqzpmryM1bf7UzxkPahL2Oyn+T+GV?=
 =?us-ascii?Q?u2poOoARNRWS8WHAJw8oLj9bU4zfAiS0T9HUut6l9wNSkd3rd82ZkcoEH+e3?=
 =?us-ascii?Q?mxWo3Hht/8AzxMafRhlVEFVEkzeqxoUGTuxTRcn8zgVz1D/Io4yQy7U75dHe?=
 =?us-ascii?Q?bRtFEFDfHnhD6TZU1mkXy4Y05r50GBoGMUtmpbqcw5+Qd69QP1bFAgx/Niwp?=
 =?us-ascii?Q?uEYTl3wCpX8vLGwn+LUEctBAoeLYk0vYwJBcoTtI+YG6SbE/fGjnMvAWfd0B?=
 =?us-ascii?Q?lIe5weX2d0nWvUA7FDnWcvomJ0d51ArnzeBZrTwSs1Gqd9QORcLzxr5ADbF1?=
 =?us-ascii?Q?TNDf/WMX/Tsw/h7hOqJLGbV29a7Jw4KaZwKumV+aySC4VAujnfNjtHGkp/qC?=
 =?us-ascii?Q?FTKxdif57upPZVXiplPW7lfIRPXTJnCtb0d6SvAML1U+lROOMQCPAMQboszx?=
 =?us-ascii?Q?fjtpdxlmLRLtTHfc2uQtA/vDVWJgRX98/DpVp8n8rem/Ctb/iAXL2U7I5Ptw?=
 =?us-ascii?Q?ZGa+FPoHbwWuTlAzEhK82G24OEffaPp17mSVaBtFFb2+bpXFVK/E0n9S4b2o?=
 =?us-ascii?Q?LnKez5sz0WM+HraEeXNEH+BKN6RhoEicziUlf8wEGYjfBHZ8gsh54H0xxPf8?=
 =?us-ascii?Q?MkCE0O7Rs6WK1Z0+KEYjXNOPaiWFrsekp6cQq3ZITmIB6VYILjm2Qct7LD4+?=
 =?us-ascii?Q?tb71l9pk6ex2t4cJL9RY8B/Uh2RN4XQPYHjRpEsTSTOK+43WpVfu4AYfcsPa?=
 =?us-ascii?Q?FB2oGcwJlEvmyPP8R5OLCA/bBO2VzBRPxRVT7WOA7aImV2iVtgfKl1Hi9aOE?=
 =?us-ascii?Q?b7teDL705o3UHQ0UMCg9NCx6HHWEMf5ieR2QiSthBeQOYhHvHv15QuBS7TFR?=
 =?us-ascii?Q?ikmfxF1A4LGVl8fKqffWGe0Ose1Qj6449avURTvMDx+L22NLYeZIdV63SKkB?=
 =?us-ascii?Q?aIqC2QWWR6d6BD/mC+xIl+pfceeaT5/db4xkUGcFUJwCaEfwOyGD7IBNKf+J?=
 =?us-ascii?Q?/24sriYXOewdlWP8KbI2poQ/Dqa95VNytoJ7/wKkGnwzoj6+mqIAZmx5HSzw?=
 =?us-ascii?Q?g6drexEDkKvvBh+RpGCrjt/qqR4yX98Pi7UhmDWWuF0NJ/dikQfZGBOt4QUo?=
 =?us-ascii?Q?Boa3EFqdd46s+Fi/LHGrz2PbNrPZ5Ams466T1/wAm8qgIVZB2aIf5eZ8J+l8?=
 =?us-ascii?Q?CmacHQ9Q1D5BoNIKLWyd1dZJks5Ud4vZZWw1Mctgs2xD6UW3IVqv7vXPlDZT?=
 =?us-ascii?Q?qzEP/jY3So6ptPfi+gYWWIzmSpUbVMPadknuVd5qkENPO4PTHH9fSSndgRKz?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e136dc-b603-4576-0a4f-08dc44623193
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 20:06:11.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dGsAJG1z9ui2dTm3fN0je9V5hqUH1PnzZw4nnTYe2u8B9O6rujcQIAPje3eBKh3aCtmkE3w7ZfqNB9Two7sqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810


On Thu, 14 Mar, 2024 13:04:36 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 13 Mar 2024 17:47:07 -0700 Jakub Kicinski wrote:
>> +  -
>> +    name: header-flags
>> +    type: flags
>> +    entries: [ compact-bitset, omit-reply, stats ]
>
> Ah. Throw in an empty:
>
> 	enum-name:
>
> into this, or change the uAPI so that an enum called
> ethtool_header_flags actually exists :)
>
> Otherwise make -C tools/net/ynl will break

Already handled this in my patches by making the enum for
ethtool_header_flags. Thanks for double checking though.

--
Rahul Rameshbabu

