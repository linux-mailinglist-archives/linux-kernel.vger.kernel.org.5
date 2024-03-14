Return-Path: <linux-kernel+bounces-103761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CEA87C41D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C881F22592
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B0976053;
	Thu, 14 Mar 2024 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QhrfEAfg"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3576049;
	Thu, 14 Mar 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447454; cv=fail; b=aRb0fJxZb35ocKqy9QcYoU7CSIFMn+9DUWwVTY8H/TltlAhZoWTSGvLY/XZ+NLdjPd+UGqD1/yBQzlWS/8xZTLbDubjgrbVT6OwdI1t/QxfjxRlSmCNzyBDjogIXlJ+tj8I2QwnVDsmn0n8czlwW8p3lklomjDDOOx8MNchkIfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447454; c=relaxed/simple;
	bh=TDmqtiHnulGSuvzSj66/9EXajL8lP4NM7FQW8GXYcX4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=u5Rsm+TI1G4CdQzp8KIikzohMAXYoVGN/8NMwRHhATubxwnZGRkA1iJUtG1ur52c79D/Luc7XM3ratLQQmPnFvIDWXYZXzXdszGYrz8MJpFVsn8iOSOPa0O9qGzTLIrpknvD26PPKbtCa2J8KGrHIId9YfYqn0RjB2FDkkvYTN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QhrfEAfg; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd+I0A2G2w5qduG8xSYU8KeME37qE6lHI7J05NqCOPUgqW0QqHYeF3Uwf9UPTraoxoC7uslYryqcFMALE0rT7m+p69t1dX9vPe9E8AjfQbGid4K50QUUt2InY3deSxzCwdUS1oGErP7FPixkF8yU7Wo8iQEv8571fj/YlIr+ZiCSErRJ+/G7rVJ5KDlCeZw+9IiFQPh+V6B9AoQ+1E2S1SNdoqb/x0WHLJM+7hSefpZPUP37aaVO5ZDUPy3KIePvvJIPM8o/VXg6NXM+8Bo97jZQOxwGyRJpEm0umH4+8DOfrRgj59Z2Yvaqo7RDr9VOWEfYsL4pnMhAG3cCIDM2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5ryQkP+i8+9AXuobEiyUgAUU0gjatbAX1T4QCeUpaA=;
 b=VO7Hd7FFJhNIlEibS6QwssXVtunbDrO8GY0WBl72WeGF+2OGgJG4p7F5v+iwpWDFaoNkEC2MpCZ2FkCElS1rkH8vD1dHjsAlwVAIAxHFB5t5ETRFZaxcGU3eHTKbZzDAGKGQM+XvVLys2CETuUHmFh8R9qPR8wBoxzTbKu/F0av4v1NsDcsdbDjS+g3tGNoutx++7pOlaxv/5e34TvnFJXcd6E3hopQsuX8UMcslkkNz1CLdmeZwIVlUtFyJ79o+huw7sB7yYlvllCkRjoJDA7ylV9K+gaGYRVXQO28hMl0Vo5ykOOF3AO84bqsJoq73Clz6KaTdzfQNaHyL+97udA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5ryQkP+i8+9AXuobEiyUgAUU0gjatbAX1T4QCeUpaA=;
 b=QhrfEAfg/VNkVv6dBxzxYQzDzpEg0AfzNq61JrUm0KvorY8RGZ1QHG1KVuzY+H1ZEbMm8oXBnN+LHGswFMBhb/ktUUx5SWbQNfKaLxCpsqUkWWgP2rwgd74FIvybfUZFmttReAVW/EU3kyeQk+/wvWzK3cHCg1OA1RmiFkhVq8aO4nD2XnRa39KBeSWEgJ0oX4L4p5YxkRwFI5U0iSKv7fQG7Yzb/Q0PmXfedTy/fOt9od1UcomD62UHtWgwOBoUKfAfwixE4uDfK4ykY2ycQ6wj5/ZH5DAQO+M4xaCtFSqo0blclUomCaeqoZbaSBQWnucesPtsHLumM/y2fgPxRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 20:17:24 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 20:17:23 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-2-rrameshbabu@nvidia.com>
 <20240312165346.14ec1941@kernel.org> <87v85ovj4d.fsf@nvidia.com>
 <20240314105943.7bc6f2ef@kernel.org> <87jzm4vejp.fsf@nvidia.com>
 <20240314120647.58a07d94@kernel.org>
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
Subject: Re: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
 timestamping statistics
Date: Thu, 14 Mar 2024 13:16:42 -0700
In-reply-to: <20240314120647.58a07d94@kernel.org>
Message-ID: <877ci4va99.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:a03:60::22) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: eb782a34-fb98-40a2-39ab-08dc4463c2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FXno3a/7kDhTju7MjK/eZsorWK4g4HLZ0olg2xOZe8KMrcnnY8mPA3yTBGGn8sdqT0rhGWHHBjRut3fZlJbxH5blzdhe1wbY/bSMc4SjenBcFM7c/kZYLa2r1nEXxvOpp6C5GXZvJrxBkpYj1R+0KSv2RZerEdg4576RbV9MKFrFo27z6/j4fUDcvsltSEd6/wpc+K6/Kgi3UBRiTuH0Y34trZztC3hpdktjdqiB9xYZxPjgRnaT6Bi3BBa5plW5OJdqFrB8EQNCf0VEWjeyVG/ssjNTZzrVr9TYqrC5eRhPM/bYF7oyTOh9NI6fqvHRLJEdBg0zuUtAYyBMnrzpK8fcR5kjHAqcSLFidPJZm7H7JW17RVui/7jd4X/6jn1piGxbkZ2o04MHLgWIDYwXPQgthhft168sgcK9f2smRa6I7dBBmNACC0TSKMrKpYR1kD2OtfHah49v2jcR10DVDLzdYjd8mARR6SBk2QiJbc0cqRcgNJOSDtTekmFj8gToBHhRwfsOFBFGLPxVz5tiOoxRPT66vZG1ePhQasjRXnHztF9meIxVy+bQzS2ggKokpE/wZncdY99O3fasi4q7/K5mPVZELKLs+7Vrn4ggu3ji6eEaXBamIo1OHG+6TO17E972zEvBZ0mBgh7r4X5lBMn2rSTyoZx0T3vXj+5w4rw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4kQIOyf9U6EeqwfJK6bm6j7M3jTlON6RZErPKp68Av/cM9B8bPrhRGiKmpBl?=
 =?us-ascii?Q?AFKOWO8ug66GlZWTyCKf4taxJkZPQWthRkUBmxwHx//Y7rYuXxp1riu8e93n?=
 =?us-ascii?Q?DWr/ztU+Boa1H0KBsEovG8tRjpz0oD6DVDD51iB7x0XbOmmoIJxo5Xdp8XSa?=
 =?us-ascii?Q?nj04rbZVNP0L4STiBlaZLUkmrwjb8/hY1GznvF50akDePFUHaUaceH64kXLS?=
 =?us-ascii?Q?EWL1PBHbJQhsSZLKCnMOdQlZCZ/E2tAAULa9KkithOnGoebBU3NTuW0XGNMk?=
 =?us-ascii?Q?HcT41BwOlnq+4IoUtxouDvB8Cq4ans0IV2pFsdy2QMIaMWB+/f9A4BzGo2PP?=
 =?us-ascii?Q?hyp6tYEnKtpneRYH/wzlJArKLQxpaTIXYegVB9M4OIjY/fhaU0CZX5GVxK6c?=
 =?us-ascii?Q?LQ/RBDKQNOjEYwt73ABH5d/GkBZUCLe2/Jh4Nl+rfH9G3L1ouzOqP1thG713?=
 =?us-ascii?Q?G28Ge/Ol7MaUG76xKGIqVqr34yYTH2lbrGD/xts785ATIbI/AL1GJtCx48Kh?=
 =?us-ascii?Q?jGRXaPg3vDpRI3I7mC7XP3Kmktt+8HXqv2oNmB3rBSKk7JA17KQxcmYO+lra?=
 =?us-ascii?Q?WbcvbSNnDKSY+OarSnGSr6lLFPAuAsW1lr78ac92erqp+JRjP5SH9vffDSKE?=
 =?us-ascii?Q?QRi3X0RFU2pSk3ujY85kLV7RmWhf3cAfDGRX1aRuuYg/KYK9PvVvF70PQMJz?=
 =?us-ascii?Q?fUYsuProY1tOsjvPvDAgZSJ4cBGZGajue0iSue4Tb8Srnj6WayOkA6zOTLC9?=
 =?us-ascii?Q?2nkFXfje5nCXD0nujs643xJbf+onx1Lx9ZT+O5kpfoZ0KnnjkkhwVjtlSXOC?=
 =?us-ascii?Q?DFs4Fzf2PLW+q5caVcFIIoY1bFi/1pRciUKg1dOW0dOjwq5Hi6zXAWAji5ax?=
 =?us-ascii?Q?0mMl8BGaTEA9oDTn815A4KDbCn/HadXiFtmKPjiz1ssrs1BuckILjMSvMveC?=
 =?us-ascii?Q?60xdCJrcuUEVq77NRdIQ1vaEKE/6+46pzR7NUa30Oj4cK32ynTXXrudgCGOt?=
 =?us-ascii?Q?CPZu9q75KggT1Ikwvro3TDa+Yw4C3fyGbe5W78j2ndpV+fuIVU2Nmfi4fIGT?=
 =?us-ascii?Q?0TkM24YU5ZiHcNXiVvMDaxAZAeegKtPkgAjpDHnEhgSdJW8sqtyH/DPv1unU?=
 =?us-ascii?Q?M/qyAILFeF1/1tXEWeWNkHvrxrOeSI5aZ2PTYpJOyhhYYNzdg2MRGWUNEczX?=
 =?us-ascii?Q?0BPIHtQ7JHecf6weLxeZW5u6OlKL4GE8vkSLozPMeNaUWuQ5LnefuVdBaMuu?=
 =?us-ascii?Q?iLoo6VdVUKR+0XXyrsh1X9R8uwHmB//qTZ9mGFKhZS+2JZZDpWiWv1uu8551?=
 =?us-ascii?Q?XtRBL4clP8B0lz4NO6ZOms6zv+cuWSZesaL3KRDAMCbG2TThC0nRDX2zJxEd?=
 =?us-ascii?Q?sl3in5zwk/Ys3YisAimpYJzdnb+cSkH2Q5VRL4568LFFpSt92IiWGsIRjK4H?=
 =?us-ascii?Q?61Si4YK67pwqkCWlbSMcjWw/Px9t+AmtdeV46lyZS5tqhHuibHXC4S+bgiNb?=
 =?us-ascii?Q?irhMeEzISweJfuhJtq21bLSltQ1+W0QBTksFcd0CE/yoDPHMRAb8krb/GIXt?=
 =?us-ascii?Q?6w7aYXslzd1D0RzsfgFJJnpJjpz51dWyfS4Oj6b0y4+TvREAVyKD4fSoPhhb?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb782a34-fb98-40a2-39ab-08dc4463c2a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 20:17:23.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rE+ZHF4ZzdyvAlxx5u/pQASZ6ibFAxMRZ4oPDqC+eQTWyw4VBS35BONHaYdJn8SBYjcbRwZ95Wbc5VWspwrrZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833


On Thu, 14 Mar, 2024 12:06:47 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 14 Mar 2024 11:43:07 -0700 Rahul Rameshbabu wrote:
>> > I don't understand.
>> > Are you sure you changef the kernel to use uint, rebuilt and
>> > there is no ETHTOOL_A_TS_STAT_PAD anywhere, anymore?  
>> 
>> Sorry, I was not as clear as I could have been with my last reply. I did
>> leave ETHTOOL_A_TS_STAT_PAD in when I tested (intentionally). I was
>> trying to mimic other ethtool stats implementations, but you are saying
>> that in general there is no need for this padding (which I agree with)
>> and I can remove that unnecessary offset. It'll be different from the
>> existing stats, but I am ok with that.
>
> Yes, the small divergence is fine - uint is pretty recent addition.

Yes, the uint suggestion is great since we no longer need to depend on
the padding. Thanks for the feedback. Accounted for in my patches.

--
Thanks,

Rahul Rameshbabu

