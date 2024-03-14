Return-Path: <linux-kernel+bounces-103691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BECF87C309
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C512820AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0D75819;
	Thu, 14 Mar 2024 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C8m7Wpmu"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C57350B;
	Thu, 14 Mar 2024 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442189; cv=fail; b=FMK7fYmoAVq2LbgMczP0m1yjdRZ6C/zPSLPZ5dIxFX9JidhCaX+pcqxZwZWlVpCk+qJ7+88lvXnOfDxEZBHdi9y39SV4p2SlbR2ccjNeYy4ReEEolDKT2sFU9bdNQHNzswM+S4RKslgqoT/hbfCTdfCI1BDleolr0odi3Uyg9Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442189; c=relaxed/simple;
	bh=hqXMc5/rYTL2eqfE0TQeOc6tZb8AXNtuuUMEwUiqxQ8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=maWebSeGuWZ3Vjq466U0L+ot3qlLDtRxCDyo3qSfSENzMgpp/rxG/Gtyo0t9fj/Be6nJbAbyMtL9pjT1sBxiDiYNE09P0iNxsI+gl0vmFxhs9PpvkpMecy9fAT5e9RsXznGV7Q/1gmOAe4r+dDCN1ix/hj0euX82jsspu/HPwjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C8m7Wpmu; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXC8TWwpz7QkqSrqwBUsWeI22t9hhKgxuw6tZ4FO0I7GS+Ba7yE0tStUQj3kPi9xzIb05izxTJ7/6A7KqNIHQZSdklm14gJDUepZTICVZCqvmoTlexHUzAOIyO7uE3DUMAwsBeziJllSi4eixWam6CEjCQjMu3Yzx21Rwla9TrdYRc5F8dUnwSknGASUu/LJ+NXWXbCr9GUxIvY2VcU5rnai2H87XcK7hyiLaY0VBnBcFIDKZrteI1vldb7hee0MgudJfkg1xY35tqtTCMLevA46BvxoE0F1P7R5/xC0pId43nq2aerIRlY3Uq9Hkq242Uyq5AcFPlLU8jJcEglzEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viBNZkyZDo1uG/RK9QS5BDLQf9dvAXMiMQRlrohAN2Q=;
 b=g+Cnxy4e+c8huiiJAj0vo2kx5ylRT9Qhnhsy2sXaLm01HjNdp7dXG5fH8mq42Nr7un002IbR6vZ0DyFnaAZezQaNyxCl88P2rBfN9CuFh8BHU4ZogaOpiNBd2t8riyS35c+NTW7cj/tP383pfUYFXD6IPmkEiZj71HyO+3zY0VnC0SHz8P+NLczBFWmolPiRG2DlRP5o4SZCrg/TC+BCRhWdMSlTDrVIK6z6IDvLaVVlYYk4gc2AkyO28IA/kzJ7W5F66iJZjEL90l1mylgzPfFW0cgop1QjVsK9h9PvxlnuPwlbKdH00WsoWVmAwP/2Vcr2ooxb5WG5NK/S/742qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viBNZkyZDo1uG/RK9QS5BDLQf9dvAXMiMQRlrohAN2Q=;
 b=C8m7WpmudXjjCauSwI67S/VzIGgJi9KOhhVjjQJC13mQQuNCqbimdmOWTtQxOQs9DvuXCJmovAz61opjernzlXt0r3jpCPfAuoxByeK7HOlBi+mF+QtsH8hYbkxR9CpurOSAulL+QsCM9iYXoxfcsmC729pLynfdUz/xXX0pGmJCJu+8wzLmdWb9iMf5EXLHyVpjmv9q7gSref8eJz3Pk0R8i1bE1VZXbLiLs5sOw8v0I7LEWcMu2UTKAlTkPqc/HBeeGtvbjiDQuafIaGZgwDurYD0TAedn3H/MiJVVhGE+B/JbXYLSKfxv7w+gq2ff2TPWuI6k+hr/3h2ztO7TXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 18:49:39 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 18:49:39 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-2-rrameshbabu@nvidia.com>
 <20240312165346.14ec1941@kernel.org> <87le6lbqsa.fsf@nvidia.com>
 <20240313174107.68ca4ff1@kernel.org> <87h6h9bpm1.fsf@nvidia.com>
 <20240313184017.794a2044@kernel.org>
 <CO1PR11MB50896031737DD807D071C34BD6292@CO1PR11MB5089.namprd11.prod.outlook.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "Zaki, Ahmed" <ahmed.zaki@intel.com>,
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
 "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "corbet@lwn.net" <corbet@lwn.net>,
 "davem@davemloft.net" <davem@davemloft.net>, "dtatulea@nvidia.com"
 <dtatulea@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
 "gal@nvidia.com" <gal@nvidia.com>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "joabreu@synopsys.com" <joabreu@synopsys.com>, "justinstitt@google.com"
 <justinstitt@google.com>, "kory.maincent@bootlin.com"
 <kory.maincent@bootlin.com>, "leon@kernel.org" <leon@kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "Greenwalt, Paul" <paul.greenwalt@intel.com>,
 "Kitszel,  Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>, "saeed@kernel.org"
 <saeed@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, "Drewek, Wojciech"
 <wojciech.drewek@intel.com>
Subject: Re: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
 timestamping statistics
Date: Thu, 14 Mar 2024 11:48:11 -0700
In-reply-to: <CO1PR11MB50896031737DD807D071C34BD6292@CO1PR11MB5089.namprd11.prod.outlook.com>
Message-ID: <87frwsvebh.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::40) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: e764c267-8302-4b99-f181-08dc445780a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lh+uNONe/MTcpidrVuhJvGQQKxI3pmEKOVafKobfuoregxtjwxXWYRzGmSjgArNsUJECSLcq61HF8odBXSsqihg14+U9vBE1hSbtYVKA/frJC8buibLRmuNhW9PbFoZ8IgdXzb5a14r4LAw3EhadMgJ/ip8jcQzN8sRkzjTbhKRZbvAnq1vgvOMGgGTEtQ8dHVQ3jcQwULQQsbvgAGz8SVOIbIGK3uoOCsHM1rBEy6HNz49SqG85oBKfOXOzbey2c2a2urFHMjdzGUB5+91ZaVLZDbr+bBjpB+Y47fZNNqribahVKB4DwOq6pNK8eAz7kGtQ52UfFq3FPVUK3u81Q0qI0m+ZLScxjqi0NIbFkfcN0cBg9+jGpB/WGInf+h3FeLOnVcsmkj4szXlKLfF2EQ4HEODJ2j3KIm8ZsrdG/H3bWde+mGRMaRJOiOm1zQ0NLxsDlVNNaGsXVlqV8eojOqaqB/wkvAi8GPR7BjfqO0+8UycW3nXWO1ES7nLGZFTZWw0jdBcpG1jHJwxtXekmDGYBW7cP0eSmglBGlA2nfvKyBXklOy2Uj7SGPvBB7fWOa9jB+Q14RYGIAYKLeU+o+f8XPkZeC1pw9TEQBb5xQ+ABFDIrC0kOv45gUdk8reo/Pb9DPxuFtmI3hNIxzE3WbyDPtd+Al+obFiLg2xmSN9U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQPKSulr7/gE7o1tbtcNnbLU4QDOIunlytGDy427U2S33OVYkTjyxU7GMy18?=
 =?us-ascii?Q?GpqxuZX9V7yGS0ftagdQB6/k1B3TP/ExHVKJ3AJfzMNSAsHa1AVm/VuNC2cz?=
 =?us-ascii?Q?PZFbpHf1OSkENUPmPCAbI3Pibs1C5ZALCqY18gpaQzoagCh+7VC6mXY8db9j?=
 =?us-ascii?Q?VpbC6rn+xE00WhTs75vdntlGs13csk6qMfz86tdRQ0LyZ1SOiJLc3N52P88Q?=
 =?us-ascii?Q?QJ4ruSWc4Pfgk20fT2PW38wiQvmeqqpJq05bjtAcTf0hxJv6h0+05mO6B7Hz?=
 =?us-ascii?Q?qg+4GI6lgXWn5k9aYORrelnmFCUmhyeVMsO791OYpOPhZOpevJa6ka/lFuXz?=
 =?us-ascii?Q?faWVYiQ6JRk9dMh8ZyFKoeFJbbR+qkRnKDaG9aHBFOxfgW5vtHGWoDfh4kDZ?=
 =?us-ascii?Q?V+KB8E0vR/47MhJ1/e1I4miNSJhBGRaPmZDpAlxZnV7pCSFTVPd2bLdZeNYE?=
 =?us-ascii?Q?PjK31m8Lyo7zqd1CMrrqL1GmsH52RhN7VamhPjPkvNvbu4thStk9dpGkjqO1?=
 =?us-ascii?Q?yxpmQ+VfFd+Bt87DZZOYgfHpisFbKH8qiplRKBee8geQk537ZNZAuNnXIAED?=
 =?us-ascii?Q?ATaGsMyyu3BmXBFnWKPo9G5QMMWkytuXELBsDa+VFc3PgZN1+5H6LhBD6//Q?=
 =?us-ascii?Q?dlPkCBO1xhBZER+UXApcN7meZ6HkvIMquq0+UKiWi98VoMugo8oa9HIBNC3A?=
 =?us-ascii?Q?iTkLQGHS1jWapgzNF0AIOYhCbwxtRkMc/YczqeZkqLRMxRxx3b06mJXdafZX?=
 =?us-ascii?Q?9rrHGgZVXhjAKOWwGl4IXMLjg20HPrNpLweGz1iltixfE7sijakl8KQu1/eV?=
 =?us-ascii?Q?v5uwk4/fEZSD0jkJ0srqvqE0E4KMPgfFm2HjbFJeWA2hibA4PWbylL2g9NCx?=
 =?us-ascii?Q?Po56H+JmkXtxzpgb5Ms12RA6gJdvbQ53dywJL03WK5qRY5TJqu4eeXmYWXig?=
 =?us-ascii?Q?Qu8bUhYua6VaApuEhp0zMjeUF/Ud4h6Sxbb0I/9ywin3O1l0v9ZAX3xoQCL9?=
 =?us-ascii?Q?StQbPWfhoUekWkNOdvmgWKQLcX87FMIKU2WtwyUjyXYYmAigV3TM1IMJDtho?=
 =?us-ascii?Q?cp1pf7AKxTJCUwk1Gk9EwtkuRmS7ITLlyCgDlJYnUpeWgssYFSUMIpA/ZtaL?=
 =?us-ascii?Q?VATE9/LDcvTV5ZZQ2CEQQxxPOTInkKzuW+q09oBuSg0I8PBw2d67/lpHB2ds?=
 =?us-ascii?Q?AhuGwBo1LVV5hRMH+qDdigHfdr5Mtjhs50giMmE8TfChst+W39N+1DEs43qH?=
 =?us-ascii?Q?zpstX5PyZuhwQTytvREuYH7E+sTyl8LYCyYRHnKapH7z4NJiRRT9mvnnvmd0?=
 =?us-ascii?Q?TvgIuhoL42UmDqwRXTJSnqCzNwsNT9MNOdBKb1EUWlimB1y/skemWSKC0eZW?=
 =?us-ascii?Q?1OTkytUP7I7x/PUFiYGaZioaLWS5hnQLwot8rLW4vqAmqB/IH5k/2WG8QrIz?=
 =?us-ascii?Q?8VIf+DFljcfHoS86Ig40m5NB/WaERydoxLFmt9GrL0QTa8oUqCl9NKTxWcRc?=
 =?us-ascii?Q?i15+C9j/Ra2lMMMFRat0fzTjNgFw1GEqUg9Xiid3omtqOJ/SAMq41U0cP1Sz?=
 =?us-ascii?Q?O/UrSwrhshytmFjsTGeWZ+CwT2ayDvkz8kDXqZbEJHCLmAURQ3En2j1cyUy9?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e764c267-8302-4b99-f181-08dc445780a0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 18:49:39.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85SJz1tnKsToJflV099rUxrXA3vbS7OfKKvq5XcnqNOm+0QT0irPjcKaSa752JURqBN5+F4i9aArlm8k0mkFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510


On Thu, 14 Mar, 2024 17:50:10 +0000 "Keller, Jacob E" <jacob.e.keller@intel.com> wrote:
>> -----Original Message-----
>> From: Jakub Kicinski <kuba@kernel.org>
>> Sent: Wednesday, March 13, 2024 6:40 PM
>> To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> Cc: Zaki, Ahmed <ahmed.zaki@intel.com>; Lobakin, Aleksander
>> <aleksander.lobakin@intel.com>; alexandre.torgue@foss.st.com;
>> andrew@lunn.ch; corbet@lwn.net; davem@davemloft.net; dtatulea@nvidia.com;
>> edumazet@google.com; gal@nvidia.com; hkallweit1@gmail.com; Keller, Jacob E
>> <jacob.e.keller@intel.com>; jiri@resnulli.us; joabreu@synopsys.com;
>> justinstitt@google.com; kory.maincent@bootlin.com; leon@kernel.org; linux-
>> doc@vger.kernel.org; linux-kernel@vger.kernel.org; liuhangbin@gmail.com;
>> maxime.chevallier@bootlin.com; netdev@vger.kernel.org; pabeni@redhat.com;
>> Greenwalt, Paul <paul.greenwalt@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; rdunlap@infradead.org;
>> richardcochran@gmail.com; saeed@kernel.org; tariqt@nvidia.com;
>> vadim.fedorenko@linux.dev; vladimir.oltean@nxp.com; Drewek, Wojciech
>> <wojciech.drewek@intel.com>
>> Subject: Re: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
>> timestamping statistics
>> 
>> On Wed, 13 Mar 2024 17:50:39 -0700 Rahul Rameshbabu wrote:
>> > > Should we give some guidance to drivers which "ignore" time stamping
>> > > requests if they used up all the "slots"? Even if just temporary until
>> > > they are fixed? Maybe we can add after all the fields something like:
>> > >
>> > >   For drivers which ignore further timestamping requests when there are
>> > >   too many in flight, the ignored requests are currently not counted by
>> > >   any of the statistics.
>> >
>> > I was actually thinking it would be better to merge them into the error
>> > counter temporarily. Reason being is that in the case Intel notices that
>> > their slots are full, they just drop traffic from my understanding
>> > today. If the error counters increment in that situation, it helps with
>> > the debug to a degree. EBUSY is an error in general.
>> 
>> That works, too, let's recommend it (FWIW no preference whether
>> in the entry for @err or somewhere separately in the kdoc).
>
> We don't drop traffic, we send the packets just fine.. We just never report a
> timestamp for them, since we don't program the hardware to capture that
> timestamp.

My actual kdoc comments are better now, but I should have been better
with the language I used here in the email. In my head, I was thinking
more about the case of not submitting HW timestamp information when
sending out the packet rather than dropping the packet entirely (I would
say that is still a timestamping error case).

--
Thanks,

Rahul Rameshbabu

