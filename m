Return-Path: <linux-kernel+bounces-130603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA57897A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A05C1F2239A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9800915665C;
	Wed,  3 Apr 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uiDq8OBm"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2116.outbound.protection.outlook.com [40.107.94.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAD815099C;
	Wed,  3 Apr 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178298; cv=fail; b=t1GUQFOhooKDRavbtt8CDGLt+xOXyDiMAOKxXLK6gZwwckAmoA0+ABiCmhV5j6fweAucMETAloevLHY3ZOAUeIQI0Te8mmlj8idiBixSS8gDNSGeNeV/cw0YbPM9t9CMxHa1rTGPpv72imHE/VIecfyZpYu2Zye66TwMuLSd+sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178298; c=relaxed/simple;
	bh=Y4sL9h9LymON8SBqSdfKRyl16sGjSJb5LIoA7nfSl0o=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=ZeXSjpFIePTWgOI8rylocvsEMcG6Qpm1C3x3QevZKNC8MdCrS2Y6ngXJRKYOAPRl4GNnkRC7wKhJzk68ah0ZFNahWJTRIQdAnQfjFs2gYvj+tzh3TT1f1M3c7BwBhByeSk5q/XwRmtcFvimeC8j9H6xyjst+4sCKpgzauksERKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uiDq8OBm; arc=fail smtp.client-ip=40.107.94.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGbNSl/pU9T+q/7R8VgalWjHEufgMe/Qdo+uanQ0LTkOuBR+k+UltwqwHdVOnuEdMw+BFbGD11GuGJH37MB6PLRvMRl7ZVI6XtGG3UWTj7/HrMJDgP5m5Eup/LXab0POQgJO6PbEcFHmFs0+ZNB1DH7rCYbNGK3qid5cxCxuBLr/N3xkRmaRP9pMVaD3s1k1uRt6VW22+gXhHTVi0Pz85aAPdF/Isu9aMaA663OXR8jVLhJx2iDswIHrpWEJ2zPJGNwiMzxZHNtlJ0vR8ZFeFxIndTFFQIgVwauOED060seafcVPJgpZ1M5B9+8aj3TNHPGO0S4BlkDqATorHlC3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CudaZo4l5JUsaw7gELqGC/gQC8YejOWVN5V0Q94ebF4=;
 b=m/JEdvaS1A2aH6j3BhNqgfPWxuPu+kkaG4J4Fup+zeD/Dz14AoTVrLDAPOFTkeJ7uoVKI+CK2gALBJ3a5gkM85jeqptrn0z78H/ovU8/XdmQF/8ZB9ZfeNAQSm9oSsOXz//tsT966v60kGvod4EdteGyU0x3TZqx+DCb72UactNvGdCtU2LXx4ED6wr8s9astUHackqwp0EiptsJV82KyyxlEMtgkppV3k6vRZsuUyYcxXhWAuKTd1L+NcMiZAHdfa/1N73WSJMwECXnKq7teRdt4As4wK5VHywAMW0oCk5tq/LKiHYuFROxI85dKhMT+v5VEdJBMI6Ine+WVBHxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CudaZo4l5JUsaw7gELqGC/gQC8YejOWVN5V0Q94ebF4=;
 b=uiDq8OBmL1VgedFMLaJTghoJrB50DCAQpp3KkqF9t+NCYQ3S+XyJ31+Pt9vrodLB9ub+WqDddDy9iwyFJQmflxvn3pSl6vP8QoQ3a32a8ncz+SjnceyavgUX1fNKvqNCGBGf+7lYa+3/bJWj1mZP+jpgHN5v2ZLipScAVSzUvQhxJsnHYC1nW3GsG3lHzEduAF4HaCzoDodNMetViytHV+FFgyopHCKoBkry6AYqNN/iCmcaI5rtQyO37x2MUeVZYLqMect97WYNXlJztIhOaCQSsnXfPQaW8i5dAlQJn/Yac8us7zMEs2ibEyPAzTT6f3EWHvqTekImJIcL/CIBtQ==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:04:53 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:04:53 +0000
References: <20240402205223.137565-1-rrameshbabu@nvidia.com>
 <20240402205223.137565-2-rrameshbabu@nvidia.com>
 <20240402191842.66decfd3@kernel.org> <87r0fn2e2b.fsf@nvidia.com>
 <CO1PR11MB508917567D84B711C2BD5821D63D2@CO1PR11MB5089.namprd11.prod.outlook.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "Zaki, Ahmed" <ahmed.zaki@intel.com>,
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
 "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "cjubran@nvidia.com"
 <cjubran@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "davem@davemloft.net" <davem@davemloft.net>, "dtatulea@nvidia.com"
 <dtatulea@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
 "gal@nvidia.com" <gal@nvidia.com>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "joabreu@synopsys.com" <joabreu@synopsys.com>, "justinstitt@google.com"
 <justinstitt@google.com>, "kory.maincent@bootlin.com"
 <kory.maincent@bootlin.com>, "leon@kernel.org" <leon@kernel.org>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "Greenwalt, Paul"
 <paul.greenwalt@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "rdunlap@infradead.org"
 <rdunlap@infradead.org>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "saeed@kernel.org" <saeed@kernel.org>,
 "tariqt@nvidia.com" <tariqt@nvidia.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "vladimir.oltean@nxp.com"
 <vladimir.oltean@nxp.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Date: Wed, 03 Apr 2024 13:56:06 -0700
In-reply-to: <CO1PR11MB508917567D84B711C2BD5821D63D2@CO1PR11MB5089.namprd11.prod.outlook.com>
Message-ID: <87wmpeyx70.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::34) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA3PR12MB7922:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u1j1tCdmC4YrJ6mQetsHBpiFt/EHOD86Lhz3G7Pub0E7veeLS5vAPn33MgwvV6klUEylbVwqH9Sye/6+JvpwxLmbhRatMcIPRFziwoiDX1eb42X85gLm9W2RfDawhszzbCN/q1sTCHVZauPOpty+WC1PRJirBAxrw8YHEU9rjlND6ldjrdHIF2TR5FQa4uf6l68PzJ9bjRdePFj1v4wkyfxnf7hpaR9D31WVhIdvIUStLpu6tw+BonKvPE9Jm12IK+O/uEEXUk8I/us6FbfYrLiSkiPe158l50zMcv9Nof4rIcvazZVk4fjCMRNdcDHF70YlI/8tOz5Xa5XUf5rywDVwNF4FIiJSHc5TWuGLqAAEWw4zgl7jBZD4wPII/9CsTZuM1ZLSTyKLI2zpThsg6kdB5Osdz1YzI4sJCCICzEVcuGI6tjTHws1N3OYWb3KsLHYGiZJ3my/G9hnyObBn3nLfMzU0b4WIa1oLksHn2bMrI0N1E57sRaF4lGFzuxJchFndgJUA/50zPXhVo+MfHYfjpzcqqjXxWKSuiKUx9NJi0nc5/EFEg2WjHFJtE7PhU8t+U9xcJtb8PHSpkm7ZtTDMWVjiBLX1T1cCu6KHJ1BK3u/lQoLuFkDJ98AC7/qDeOrgdNgOd+9ZNX6zbhdbzirTyuIT3iSgcn3OILwlczg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z7OTiZw5SLenPKvSfKlaG8xIGAx63kMAGSfDQ6OeO0uQxisRv8zzWyi43LJj?=
 =?us-ascii?Q?RCHyr9/kSBOuU9S+/1zOScJTL9+eefs4l95EhiZukabmhm1oQpE87yBkFdlc?=
 =?us-ascii?Q?lVchSha/uz0KR0BE33h1EitTh6zIFO6Q8AcAWH7RcFN+ZGrYqL2GzoJ55mRC?=
 =?us-ascii?Q?fShEX3hal3ujOXS40mucG3IpfFFwZhptAbUBpFdzkqHiTR6OTiz5+p6fdcu0?=
 =?us-ascii?Q?HuBEW3rifnbT/JQdkCZy1p1s3LV8Pqoy2Fqv8hQPUs8fv0CvdHcP/UGcnd09?=
 =?us-ascii?Q?mWlSJeKVEjZC0afgzkocifHZrHkGH0Dk3kPmZhq0OMiJtOK7gyMOsGNWiIXl?=
 =?us-ascii?Q?hhs5RR1k4H3W1XYH+U4mJEEaTCMqb7/wTlDSCczYjYT3tQylT+z9l1FeSRJ0?=
 =?us-ascii?Q?zOfW25d39W4JpdUuMW9GwZtqteokhdbUDr4MM738oHQy8VKcAoUJFfo+4jR1?=
 =?us-ascii?Q?LMZeBdVj31bQzemwUiiyeMhSwGVevTly/Y4yw6oecNyiEauBZMBsm1CfX0IH?=
 =?us-ascii?Q?H8sfRNJAY1W2+PXNsKt0IqhpeTjFJcYdYo9wfO//96hjbhLVLpJSo4zctAtO?=
 =?us-ascii?Q?8nmqPdwaHLwWnrlPw0s73rpahPD+yGd2HCZlTyJAh9iok1jDQHZVl3eOTywh?=
 =?us-ascii?Q?KlbuFvFhYtqbmWMxaUqo4TY9bJSV9ptma3asO4gVTrtg3joU5QCd2bw2KUe2?=
 =?us-ascii?Q?pjaPLPvQImMsWfENStdJpGqnlPYCEBE1BjPjf64IWKIUpbyqReTdmGMH77vt?=
 =?us-ascii?Q?wIhUlHh79a+bjd0/HJVNR95rj6FaGHXIUvN0+r0CtfM22m4Xop7kQaHdxreR?=
 =?us-ascii?Q?Zpz7em9c86TCsXG/uP3YDSW7jlHBYgenYKWO8d+93NDiU8QVs9WIYgcikdHl?=
 =?us-ascii?Q?Zj4brmgxiH3stS8dbiOpT7BEbS7Yy4/eGCZ3Okf2/KdfiCuhLkAJmUL9Li/k?=
 =?us-ascii?Q?OK+dvy7n2dpEw5mWTw23wHRXSbKg88pCaHqzTEXdRLDqys94rqdguZWztLxD?=
 =?us-ascii?Q?+76ljiz4ZfI182S4xkdj8Feinry5oxHrgLLF+01bGrt7PHGNy6Up5ozNDWMP?=
 =?us-ascii?Q?cmBZpAnM7M1dh/yylzmPXU32eb3DxhAtO02H6UB5tSaliH4+xrxgG04c+U6n?=
 =?us-ascii?Q?9fYVzCScfkHky+sHTIi4T1j4bMiVQoZvXX7w5SLVGkjOIE6m/Gpmrn1TSOi7?=
 =?us-ascii?Q?ZdwzWfdDmc2KAPYY8W8jFtPpu/608s52n/bR8FF9HkF0LAlf7A2VbxwOvYw/?=
 =?us-ascii?Q?djhrQvgBP1I4LTfpMzJYv0hUpW1IemPxejR523cgKFjX+1xdYy0l27D4A46e?=
 =?us-ascii?Q?xGBYrWIhnZw4j300crL7nZm3E7Ih/hWA13bOe1aUrd/hQ1ET1q7Lr3ZwZh1+?=
 =?us-ascii?Q?VA4eeJOnc8DSolWZ+rNqwqiX8U1063uWTnuLbM8RLIZy19qg2a1YmYfMZziL?=
 =?us-ascii?Q?bJQpBOx5FXgxEWQWaEEKNuXUJzh/yzkjIimjQQSOP3rzjEDHfk5ReQt5LOCS?=
 =?us-ascii?Q?2laTvAtf+lcUVl9/4RUV5xCEdcajE+qPughQqYtitarzg1CKJ2RrMdXvMpw5?=
 =?us-ascii?Q?S1KF6kDagMOSMBDAJTydYAeAJM6FhbufbzYITr15MV2JvBS8zEiKKN1cuBS9?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fb27c9-0aa8-4c3f-5d2c-08dc5421b53c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:04:53.2893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1udrScBQIquOrsjz5xGdLesRHB9GCXjvPxiKjCoQIJFLVUpQAsd0YsIVoSzr6sTSy++JHWt83kGsdSKdZPoLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922

On Wed, 03 Apr, 2024 18:44:52 +0000 "Keller, Jacob E" <jacob.e.keller@intel.com> wrote:
>> On Tue, 02 Apr, 2024 19:18:42 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
>> > On Tue,  2 Apr 2024 13:52:01 -0700 Rahul Rameshbabu wrote:
>> >> +/**
>> >> + * struct ethtool_ts_stats - HW timestamping statistics
>> >> + * @tx_stats: struct group for TX HW timestamping
>> >> + *	@pkts: Number of packets successfully timestamped by the hardware.
>> >> + *	@lost: Number of hardware timestamping requests where the
>> timestamping
>> >> + *		information from the hardware never arrived for submission with
>> >> + *		the skb.
>> >> + *	@err: Number of arbitrary timestamp generation error events that the
>> >> + *		hardware encountered, exclusive of @lost statistics. Cases such
>> >> + *		as resource exhaustion, unavailability, firmware errors, and
>> >> + *		detected illogical timestamp values not submitted with the skb
>> >> + *		are inclusive to this counter.
>> >> + */
>> >> +struct ethtool_ts_stats {
>> >> +	struct_group(tx_stats,
>> >
>> > Doesn't seem like the group should be documented:
>> >
>> > include/linux/ethtool.h:503: warning: Excess struct member 'tx_stats'
>> description in 'ethtool_ts_stats'
>> 
>> Was looking into why our internal verification did not catch this. We
>> run W=1 with clang, but looks like the warning does not get triggered
>> unless explicitly run with scripts/kernel-doc.
>> 
>>   https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to-
>> format-kernel-doc-comments
>> 
>> I have debugged using strace that the way the kernel doc checking works
>> when W=1 is set is that the matching source file that is being compiled
>> is passed to scripts/kernel-doc, so include files are missed from the
>> doc check. I think this is worth adding to the kernel documentation.
>> 
>
> It would be great if the W=1 setup could figure out the include files and send
> those to kernel-doc too, but I'm not sure if this is possible and if so how
> difficult it would be to implement it. A lot of headers produce warnings because
> a lot fewer people manually run kernel-doc on the entire source.
>

I took a look into this, and the one naive solution I had in mind was a
checkdocs target for the kernel where you use gcc -MM to deduce all the
includes, create a unique list, and then run scripts/kernel-doc against
the list of include files. That said, I do think this is excessive
compared to having a checkpatch logic that runs scripts/kernel-doc on
the parts that change in your commit before and after the patch is
applied.

Kudos to the netdev CI for having this.

  https://github.com/linux-netdev/nipa/blob/main/tests/patch/kdoc/kdoc.sh

