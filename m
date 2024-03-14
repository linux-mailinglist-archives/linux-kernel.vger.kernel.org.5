Return-Path: <linux-kernel+bounces-102671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6187B5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5634B285EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDBB2581;
	Thu, 14 Mar 2024 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KDH+w9AU"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD77F;
	Thu, 14 Mar 2024 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710375941; cv=fail; b=dnDSbq8/jmG7EQnydedEBo0Q3mxeX+mtQ+f/zRgbKmZYyGtycXPfBzQZlfn8H9O5zKWfwmsHyLft1IU+DiuqCq1c2necPc1e7MBViEVJSP/XLZIDpE7/M2P5I/eX726ukMJu0vAkI8N6zj6OJy8pQlYe/oHL1+ZDWkvjnTuUaPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710375941; c=relaxed/simple;
	bh=0IKFPH/3jiM3CXeAOn5DOE6ojS5sGLEbiBqIjoKbm6s=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=gzB0janEViFfKgRlRWMARIRh17q8sNUUYSK6Rashi1VusokbnW0fD8uZe+TT1vxa62JTkMgqvF9ICi3F40wshkUZvm4fv8/ecGxaslc0IrqN5xRiAkH9dZ0F6uYphCTSR8+3RwtR0z9dXyhr11JbtZBwrR5ttvY/OA4z0nFQl0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KDH+w9AU; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqtVPzMaZH/jGSXUHTEhnFlgAif2pUDWO/m5c/rDf76QwKm3LpRLa4EQqFSQDus8rS1IWdNq/tWWsfFW2PJxcs3Xnk8uGHEP9MPoQmapugA/m5Hd8fIFoAO+inRoAPU9UJ1JR2UQrZfbFFmHFSt6J8TR+YLCkV19QfXs4/2kBn2kWCSpDm5UfPqHJQghgerMDXTl0hv2pOntFHgnyVpgBG+o4MX4NV657Z5T+H3cmRMi+fnjFkeL9NKaHmX983LfQnjrJ4JtVqxPYsU34Sy9cGpD4ffEo0ftAAA0K1FOXHZpOXQCEu5XdfDwp5pqrZMs9Q5tiPFwmGcr0WsX5cvW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCoxXYlU85HveMRw3/yOmYeexChPmA1M4HsfukFnGWs=;
 b=nvhU77+OKJxtIECc6W9HnLTufEwOFBhnOoe41PB36PBB29Rm/8jjjjrWXvnVwYsyoxn67I1vYBMdFunlypkr8BfhdconCfAW6cUzK/8l+di5FhkpBFHfpr5qSnuysAJ9uqwekl4P9fcYe+pmNMRTprNPt8qfC+VkOz8BsjQwr39pk/5qRCzub53rCkF/WJHPDrlH0zmtO96eloBoEqsaQ/y/Pdt/Ooj0Q9Xlz6zPbm/0eUgKbxtEoWxIrFq5pIJ9VxdpAMEZCAqJd5oBr4WxtB7D4GtYQfIUPnI954nPYTgtQN/qjgosiVTkxHK0k872B1R7kGuJXQnv8WIYWCxWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCoxXYlU85HveMRw3/yOmYeexChPmA1M4HsfukFnGWs=;
 b=KDH+w9AUf4sWX+m2cgdxiJJazj1LWYMOaYIXHl0vVry9n3KEhBlRmv2QtsVgjoio142PGSLS5p+HTxsBkRwdM4/L1QSORcT3Fu8NTjTbY0Ilv+ojhuL8g9HTapLgDFiTAUFJrC/Wde81xbQMXR9dW1JvnbNU2En/YMV5/VaXGh+0tNQ6apsstIWOg6PMCFB34cuEfadz7B1b+uwPdsPtaqZ8YFv6Y06CWAwiH1bsciuNwuW/qc0vTifD+U9un5Gwm08P59GhuukVZalO1SvY4kEUthinKqoXcz0flXlUQdm1dz8Hk1PqxO5lMAiuBydDFcKGzmfwAZvGXEOsQAAHNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 00:25:35 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 00:25:35 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-7-rrameshbabu@nvidia.com>
 <20240312165544.75ced7e1@kernel.org>
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
Date: Wed, 13 Mar 2024 17:22:50 -0700
In-reply-to: <20240312165544.75ced7e1@kernel.org>
Message-ID: <87plvxbqwy.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 570863be-835b-45f4-7e9b-08dc43bd4401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eniwVF1dNlafml21FzDQBhGx4NWFynI1gRGoR+8/z4wN/NsaGkBO7Z6s7OpiQaIGIhQnoNO0C+nfRf8sffWLD9AETc3qs2mLCdM2LpSqSeIWcCa5H3c8vmIxaLvcvbHZ4ZB5NDMTBg+/1G4XZuT2Kd7RyCGtBX/PQvdtSlvlvUc32jbL+GW5tG6ggqvy8MkGaDQzalvi+/eYFf4+XQJXv4mc8BC4ypx9pTi4kwxG1zSXXYayL13gqWixbdBxhU8CQqqkFi9SeFnsRPYAa5u6BtNNf5qC8Dqd99Q9bfznOj4J2/wq6CnBTwHAU38klSOstcXIxVyVqfcCcFaEZ/VE53WLZSWu9rkmNa7rhomVWhKgihvbPUmv/SlIJyV4h5cv+HG2CYZbG5QU2GTCskBAQuFDqHrEkNAx6+xp5V7DBg/Ye3hvNtQZaetd0bh2SBi/F+8b51SJEd45FIwr287da5jqvijCfUP+XC7wDMeL7AWpL/AJrnsjTidTavd9NyBe8O/WSN3oTv1kUSlIlCVuUg9nPAxu1o/+E7aIG8ssJlyiTydNgejP+9tGwqTH7KLRZTiojU342v9/WhjiuAYMejWSsOncVeZ7n5K6ErSoEdD7cJlPF4i4Ibjqa9fBnJ5S7e0LT0T604+ylts8nL5//DdC5kVnjjDA7oxtYfTW1Tc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXbHSTeCXQZtxzWgP207vNZt8obetJJdLuYBNLUW9nxYkpqV57EAzkMMreJA?=
 =?us-ascii?Q?GRQYBR6ghgWqyt2BtYhlE277onsNMT7Krv2CNRdxuXmk2PKMCKM8+y2Eti2g?=
 =?us-ascii?Q?TmDY6GPOnWqJgELHEtvBHRiwZF89gAdOHnCKiQpEjcOebX3o/D9XoTwe3bHA?=
 =?us-ascii?Q?jn7kxgxqe0xS+bxfNvut+jdasUGHGFGLWPRRa1mu1iRGTPPmPojHMQaECbq6?=
 =?us-ascii?Q?cLd3SQnuzGa0voysgC/x60TOi6dV3H1gt6LkWlTWPp7GN7IcfjBZbq6yN6j/?=
 =?us-ascii?Q?fIYYAFYumAdgLhdrTvjb7IkiwtOH6pYTjylD7ofcrr5HKdcdkm4TL7NEfoy5?=
 =?us-ascii?Q?aAoENNFrTyhJPCagUiyas6lKzZieYJ2VzNZn82yJyp4C6sAnZbMMnqnJ/NbP?=
 =?us-ascii?Q?AmmCODrwUBr6rnZAAhdaTUXh7sEqvT5I2rfpqGqly6eZj+19fdBBezVetAj/?=
 =?us-ascii?Q?lrUS6TzIhTg+meBEdTAbGhw9zhO/SrdZy5YsENkohWDH3WdTe0Wq3irTJdoG?=
 =?us-ascii?Q?wHjDT/9RHWuD4O2OYXee7B8tnhCZQx9rTil+8sbeiRIPVGnXj34zFxI6ECrf?=
 =?us-ascii?Q?FPepHzW9ocDsaRY1Ev3yD3vJ+C6CVtr6WvS4SpOFwydTyGRYcF+Tt+YqXoYK?=
 =?us-ascii?Q?O/r5PKzthpYCDjX6Q17IfggQKXrLLg9DK05wGHWoqDH7u8WNmM4hBRfPEXbT?=
 =?us-ascii?Q?WVS+aUmQjGitnkXU5BjFYI7qGy0ywjpKjYJ0U/gR0bpHLdj5z/EJF2kW2aHK?=
 =?us-ascii?Q?s5dXvBLUUVj29LVWhSTo+d60kNyHRdHUjJTj8yF0UOy3lV+Gh8aflI4JR+ZA?=
 =?us-ascii?Q?FAi9GYMuA8mehW09Ifv/q1g5vF9DP/o6j65DJ6Vdc52nIPBHYCqPqttZz/xW?=
 =?us-ascii?Q?kVvWkmHrHGGufPfrhP992VmMtVjENMC0bCXBcONI55vLMgL7LrftI/LTGclw?=
 =?us-ascii?Q?xoA4ZGoobMP4odXLWLiQVgnm0HUcQcUHEKGrYa5mxJ9MvFMHBID2IPdXPAL1?=
 =?us-ascii?Q?XUvJnsM+txp+kjUOIQ1omgfTuQRMPAmJjKTzf+gy4VYcDpC0ILbYnraNkKCG?=
 =?us-ascii?Q?7NtrrynjGfw/6Vwt6Wwwuq4TCgpbrxIPEUc77enZh9wiUvmx0rWMUj6helkC?=
 =?us-ascii?Q?BKmTTiWd7L+0hnK4g1N2GDo65vg92+1YS+dulC2XRCcQAmI2m+kOotUzDuEU?=
 =?us-ascii?Q?xZirDk9E8twniNirjSECqMcaSM4Jmg0Xmwk0PDb4MI0BSm9le3Grpd0Plh59?=
 =?us-ascii?Q?KTAhDc4urXI5U1NllU0WYfo3RXfZVB5S/lVT9AAfLxdQe92IRzlV896Bp8vz?=
 =?us-ascii?Q?Pm5FfMCqlkqiRZGJiGPuJb+WMFjmS1+q4U1x6o54q4l6loI8sc8PkYtBuk/i?=
 =?us-ascii?Q?Y6yyvR4JQ4/KuR+dKMGRqPiwBEZwpprby1tF2thZrAA7Bshcsc1A5QPifUqV?=
 =?us-ascii?Q?O+vskeBD7hRpjqPmB2wbrjSoAKFWC/3LXseuFFdnUcCJHuCiKmScFa1d3aIZ?=
 =?us-ascii?Q?i1XYwx1u39JRHn3ZPalb3Urj5fiGOaIhGUMixpi751xbttF0nNeK2DGNPC1P?=
 =?us-ascii?Q?UibQemUpyPdNWkL9h1L53HGzXYNz9oN7emuishjQkhmVzOSoIwm2xj9Zlo92?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570863be-835b-45f4-7e9b-08dc43bd4401
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 00:25:35.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vXujXcbAp00sFDax3lSbWt2zQSJULG6JHDONTMOa5UkE1zVLv94DOO+uVXKel/3px9/b6MGTTw0Zkk4mnCRWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840


On Tue, 12 Mar, 2024 16:55:44 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Sat,  9 Mar 2024 00:44:40 -0800 Rahul Rameshbabu wrote:
>> +        req = {
>> +          'header': {
>> +            'flags': 1 << 2,
>> +          },
>> +        }
>
> You should be able to use the name of the flag instead of the raw value.
> Jiri added that recently, IIRC.

I think this is for 'flag' type attributes. Not for the "header" flags
for the ethtool request, so I believe this cannot be done here, since
the header flags are a u32 type, not a flag type.

  https://lore.kernel.org/netdev/20240222134351.224704-2-jiri@resnulli.us/

  -
    name: header
    attributes:
      -
        name: dev-index
        type: u32
      -
        name: dev-name
        type: string
      -
        name: flags
        type: u32

vs

  -
    name: bitset-bit
    attributes:
      -
        name: index
        type: u32
      -
        name: name
        type: string
      -
        name: value
        type: flag

So I believe Jiri's change applies for the latter, not the former (could
be wrong here).

--
Thanks,

Rahul Rameshbabu


