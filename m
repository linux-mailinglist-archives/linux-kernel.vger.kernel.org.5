Return-Path: <linux-kernel+bounces-87633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559A86D6C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5AA1C226CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E9474C00;
	Thu, 29 Feb 2024 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qxscFPzS"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75D6D536;
	Thu, 29 Feb 2024 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245261; cv=fail; b=bu5DdkSlt85VNjLjM6mpe13VDuI6qHGZPUnpGTy5zz+MpLaAHKSTxK7uSpybL7atNNDcvLBm2sqV1ix80Rblmq3jleDoZTDJAcx9YUTByRd9Y4nSmfESo4zvJIYdjPn7kICWSEQOoghvAkpeqLGetfgLpFgDb5QF3MXZvoGmx0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245261; c=relaxed/simple;
	bh=+NMXZqCFScUiNU0DChWSBXhjFKWudht1XD6XNL4BIVc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=exexA8tDRONWV7JiawVpMyRH6JQfqJddnZL4jfXFAyILAY4WHFcbe2iloPFSp9Yjn+smcIy08u6IwiwBFJ4rJQbdrLRebUSt+azIykg6cl3hU+B3J7BVuDlX84Y1WnRYwne63iWTFpmLlGw+Uke9JDGIZt5ttZeF0PhQykCSm4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qxscFPzS; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyPgSrsNDxv4avtM38tzWLVqzT/5INldt1z/NFaVoaW8npu+3DwhDtuK5ZE9fjMCH1clFmnDUKqYtkJgwvd6J1+/mdkjK06rT1ph+2XWw3UlO6pwF3Brvhf/vRb5plBHn6vQMY80lsuM5I20jpJWGCkE0Mi4CD0rUXdQ7xwT6+LFfXZkAgj+KWYt/Fg2DPDSo2MqiNsM98SPYvVnAPIi+Awm1moiRnOWGj8O0Vgpbb3k6qZjQ4h4mCbExb/FaiiyZzSPKzV0a+Mss8d0JPXjlB2Z1zBnR7nMPhCE7IC+EEw0xKB1cfODi1sbobDhA5paPyrzw0qi6+LcVjJifGHtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL9xkSJ4A1B8q9yKV+VCVvuuPAsB9sDEDfvrd+906Ew=;
 b=Zih/8KJTFeUtP313zx9x6g5g2HgEn6Tw+Bb5q/CRaE8/3PJvPmWKO+8VUmhY63h31gC/3wSJBh67PwPxIxkofGuWjlW+ZBaoR9+qRiLcP6CKUUAT1IH9Vge/q2hB50dw6/K9sZP7ubIK/6wHoO0CnYEv9qE6E/aWtM/L9ZKLVCNikdjuCxbi+vKfcMSpDCBS06xq6C0w/VRoKT5jCcMiLV13bSDb6ocfc+HWRUUqub7c5WSLzObp3AbFM8bFQlpLM9Y3WNJB+NmZU7O0iw3k6xsDYc9M9sMpPSn3fH/IU5vIpPSvi7aWC2BTWfFcSaZUJnZN0quzTl4Db7vfOAz1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL9xkSJ4A1B8q9yKV+VCVvuuPAsB9sDEDfvrd+906Ew=;
 b=qxscFPzSv9Y6T1/ChxdxjvaQIH1PcmS6vVlHhdby/92WLOFiKWX/5TUFtUAOaperp87A9YCjHbfMpQHlDjxxbhCpkdrm5qoEv9ggvDfqj4FnTd0E7CZ0xhEMuDndNei9BSL2So6YeDPcIuz3j+SZ/ggiMRN7ew+Srn2b2x+QYMPiIS5lUQlz3S+IdKG9ovpb+vuHDvedgCMXqao+oJYPRCYEvGNm/WSSfdtOLHcHKsZIWaoCvcC13KtGtxGKHmbKc+9f8ZP3prid3KbtmoXA2Ng/rKKaPcWC3TaX77dxcbeHI7PIIfTTLzGMHR1ZkZ5/fZdEdLdUWqn4A/wWJFvkbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.41; Thu, 29 Feb 2024 22:20:51 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 22:20:51 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
 <20240228180520.5cea0f8b@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Richard Cochran <richardcochran@gmail.com>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Hangbin Liu <liuhangbin@gmail.com>, Paul
  Greenwalt <paul.greenwalt@intel.com>, Justin Stitt
 <justinstitt@google.com>, Randy Dunlap <rdunlap@infradead.org>, Maxime
  Chevallier <maxime.chevallier@bootlin.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>,
 Jacob Keller <jacob.e.keller@intel.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Dragos
  Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Date: Thu, 29 Feb 2024 14:20:12 -0800
In-reply-to: <20240228180520.5cea0f8b@kernel.org>
Message-ID: <87ttlqx67z.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::9) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 05eb0a8c-1659-448e-c475-08dc3974afcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uo0rDqXFIj1PPuwvTSr1QHGuKjzhwAg49CcVr3rVG+erddbeUHmj/81abIgsU4QPqqjo5DzmRLukEjszgZgue7aRaSr/4OMW8VdgR2UFa9Ch9IhOlvrzk8C2WVUI1hDlAlwAVI9la9ERQReir2bz6aCqq8PCMPACJEbMdv9aAkrT/OIoWM8he+M5U4jcudbNNix7MTZ3yUB8Gm6Lf/kZHTRoVadwK/RlvNCXEa0uHPAMo+nku3pE73q1ovhUD+ljtFk6Odt9E+iq/LDOmKGNdv8JUN6oAdERZgqCwzJ3FxESph4x2aJ743ZiOlXXi1kQgUR8F+x+SzhcvcS3GKWOC3ohDebHFsjXFkmnHjZzZ28S7psMx/Y5LKwA3HEEmpLOCxqMYoJJgNhyuJypI6avw2HK2E//GNaGY4w8iFO15VWlZpJk4kj9+d38jb4dFTe4CVegS8yqVo1aLZGKhVaZIndseOlXkcxp9BXzb0JTitJwFkP/AIR2ptacOHGgGU2VaC72PbPbUIYe9L1x7uDlE7xDzSuKpnpDRUs0DQdHqbsp2+gdmAalr2Z8BvNwXB0tl4XXRn7L48bHOpAa2CKpGcQoLk/jkdismMzNsJd+kALQYM/iBvf3+5HtJHVVAODu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gm+H22eaIN0oqYEg/9qa6Ia1WsHk9gGqv3kegjj2RE3DzxcmphoLQ63bJSRJ?=
 =?us-ascii?Q?RL91+jL8TlBpUTgA8wLEZwproqin633L236qN+RGPdG66xVCsTHfRWvwMjqW?=
 =?us-ascii?Q?psgXNKT4RT+0IrqR7NA9Nt77cm6Vy3CKZVXctkvMM1A19NIYQdkCFBDZNcYJ?=
 =?us-ascii?Q?IYlDKrVWPAmZWgWPAbVgR47IYsG3wkb7kYeAndDVIVg+crX4kFfaJ51cyaxQ?=
 =?us-ascii?Q?Q04XA/oHiBAHn7p8ko82JtPReIHoRm8xftKzHlfBZOIrs0+rWp2ww2nsS6+z?=
 =?us-ascii?Q?Tga316QVRgziNqHq8RCdSJKc/HsP1oCH2lEJ8vY0kfN1jnhVRuvmstQ+oHof?=
 =?us-ascii?Q?Y44DB5oih2G2scANLGYNKvxLmU34aZISgeV5e4iDGbqfiBRQPV4pd9TZeR4a?=
 =?us-ascii?Q?gqIOQ9D5L3DTYVqnaqmC/951t0VMuIjK8402+JOjGfqO35g7zoXXvHirB1iI?=
 =?us-ascii?Q?9VTWne8M5YeO4J0eeikgsHfDaUQcogSlocouKeh5PPiC56hHSIqoMncQXmLr?=
 =?us-ascii?Q?mwC023P9c8pGobDuhRZMB23Cu9D3xzRaBU889TzShKT8JgjwBUBtMm9SGl76?=
 =?us-ascii?Q?UgcMzXTbLCNYOF11MRJ/ynTNK14BcEhykZ+ZeC6QXUf1KS+M5M7PTUdEIgOt?=
 =?us-ascii?Q?FXBvUUVQBQyGded1USnJAowVBNDD1Y9XJ8SHxGg7gSbvvLoO55xlfEO0oOf7?=
 =?us-ascii?Q?NDeZH4KwYWyeRyw/ME9kk3JSmECQIPS0HXq9UPnhvAcloLCahdxVzWvS1hTS?=
 =?us-ascii?Q?rIeRypxoNbXiaJXUvtJxLxFWHDvNtpPmU207fzlofFNwjqvaZR4yzZ/xNafY?=
 =?us-ascii?Q?wgJGhLipDpOS7/JFEGkWH5iXgDbq39X/OwJWCRnGCCJpLtAwbbOESXyTG0N+?=
 =?us-ascii?Q?++KzIEbRlckm5kBYxCoEX2FAQ8X3wJ5l1AQ2utoOPXvQeOMEETD/dCI9tous?=
 =?us-ascii?Q?8p+Fu1m4tUmT7sQ1v+VvxzpeOzyilahRt3MND6Ldp4D6+Ki7MpSDmnDPWkUK?=
 =?us-ascii?Q?i5NlBHWj/pWiQe12zFWDQYajqbbwgWc97yleZS1wVVHbTH/7hTqs9qPevGdT?=
 =?us-ascii?Q?MFKFferxoQZ0XITPC8m24VAfMU5WEWQWQWdfgZG4kqwRL7lmz37df0QOxR9y?=
 =?us-ascii?Q?O+STWuas/Tfa6FMxUnC5SpZ+acVqadXF7X1cLqVgjhimUkxskbmQHrha8Nkg?=
 =?us-ascii?Q?EjRMRt3kiN6dCb01VSNqNxWo35GYnonBhGnRSWOmKhdhZ78vL4F5+CNGIXvU?=
 =?us-ascii?Q?NT/49v68pDyPRPj9vUFgVth+9Sov62d9luiIiogDMMePj2oPUf00a5JoiwQA?=
 =?us-ascii?Q?Q9ZSl8uxW8GLm4CGSsnAS2S2KcKTKGJddWafuXOZeFdh0km+nXgwgrxUjw1x?=
 =?us-ascii?Q?gkbHxZIzGoxMlEBpAU+K8U77YE16pS60dcUFSaKSUN5VidR+d50c0aS/0V75?=
 =?us-ascii?Q?2cCUbmgnmFuMSA8oED2btgeU7cC6+3xcwc34IrV4tB2Q/ioJisSFrg7XAqZ0?=
 =?us-ascii?Q?fiCavyeAVHFmELba/V6r+HJmron236qiy447ZHmKItKbzxS0obdtDBDGngjb?=
 =?us-ascii?Q?Ku6EgHXgf+1ZnbwBf5QAWoatV2yn4a3gpfgg78vPrCyz480cAEOLK1mA5vLU?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05eb0a8c-1659-448e-c475-08dc3974afcd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 22:20:50.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b26g+M2FYsNCr3rgrkTDE22oDrvRQJWgpImOxQsBPjA/YTk/R8438DDX1FjiZJRjmXKvPQKqorDbzFmgKnB9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543


On Wed, 28 Feb, 2024 18:05:20 -0800 Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 23 Feb 2024 11:24:45 -0800 Rahul Rameshbabu wrote:
>> +/**
>> + * struct ethtool_ts_stats - HW timestamping statistics
>> + * @layer: input field denoting whether stats should be queried from the DMA or
>> + *        PHY timestamping layer. Defaults to the active layer for packet
>> + *        timestamping.
>
> I think we're better off attaching this to an existing message in the
> dump (using ETHTOOL_FLAG_STATS / ethtool -I), like we do for pause, 
> fec, etc., rather than having to build a separate hierarchy and copy
> identifiers within ETHTOOL_MSG_STATS_GET.
>
> Sorry if I mis-directed you this way.

No worries. I can do that in my v2.

