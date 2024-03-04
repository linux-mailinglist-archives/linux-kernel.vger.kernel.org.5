Return-Path: <linux-kernel+bounces-90888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEFC87066F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774A11F2797E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EF9482D0;
	Mon,  4 Mar 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rAu/YVxG"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED783B784
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568168; cv=fail; b=Oyi3SY0183w4yf41Iwdu4eQAZ6MffdOA0CS/GXj0ZSxz9iPiJ4MnwFzweYAmtXDlIgHdLC/frx+pPulmAbPenifEDczxcGhXOPaQLb0bwmHSow3A1XqzjknS+tfFM66tFME2E+Q5jV4rx9LjHmWtkJRiFzgX08h5e+bCkT1Fqbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568168; c=relaxed/simple;
	bh=TaTnDwkFxmEy/+1cjayll2UrpLY28/Lq3hLGSoEu8uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ctSas40xwV5xTpzTpQ7QuqOSA4ocb2u4KtBPdwrws24TL1HsOHP84KgLMj8kl8kMsVqn2exHxJeJ89NrjMmNt28KGYF+nl5/RuF4Kecm0wCzcfPosTvHtNcOxhSqysiynTyVruv7pPdvbu5M0OYJZ1WYa5aVbB+QTlQCJXFmtBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rAu/YVxG; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfx0Ha1oW9USpQl3yzjYmVCyIjy982sW9nOfgi7w9lLybIcbUJAoaSlcA9eobuXBZYE82rBcJh2Vi7KNSGkV5E7BqZMc0j225xFhbGAX7r7cR4r0YVZ+Y5HBeqeOI6Al9tl71bh5trwwSfHpzWfty94q6XD4/GCZYC1UHfZmia71JXvTSL+onY2NM9Rejfy/Y1VQoMiF5bWgYu0ooALQVpflB8sXbV7wbCTd0Gh6TYTBqTxpJp94fxPlDL5u9YQvLRK9Tgoi1Uk0JYoMlyLhqW/vbpSf30aexsNnL3mSNjv6wRxG/QJZS9hURdfSmA9zpGtI7aprIk25v9a071iSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWMyrUlRms78gYSenSBrsSE4uAzO9OAOyrcVervNvAk=;
 b=OAazQldwbMMAGT7JlYnT00CpsycYNHG4dbpS9VpEAFC0obmYAgXF5+2eENLZwpyk88skbAc/wAg0p9MR/t3YyYGzgcl1xxGsU14qFE2wKcU1yz1cciN01LbDrx+tvAYX3z+EUQ4JnADn1qe9EB1706r0aJd2rOQawVoAc0iXqxj1JheP47q3Cp91YQSux+i1TiWaSkYjrM0l3zO1e15mSRlrdK29cnGbeTbLMkt77kDZbCoUiWPMRGbxjZkh0t+edi2Pjuq+Exb9rCe/846fZtp61oqEhVtCIpr1wL2fLMpjkZCdYoGuvZXeg0otcqyUX5ISOCP5cb44zqUAEsVnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWMyrUlRms78gYSenSBrsSE4uAzO9OAOyrcVervNvAk=;
 b=rAu/YVxG67/Zd5JoXEuc6/nV+DofPIt21AyiG+sbtq/lSi1Q5Vf2r/H9dWNNbtaU9ZUyQtiDNczKKUcBFgZB4r4aIyAmX4iNhqgJYNDPJ6R2CW7ybQqlUUQ+xsZXcG90Yz06ecioq+UQvk8QkDYCULVkVzoH/GbLGG21OniICjGSK1++4ZxTEXim2zon6pNqVylnGIrGoWU63E7+PVUXdP6x8/sGnoPF4UGhbi3qRav4ZK9au6fFXJ/6TllHvB2PcjxYfTJMdg0FUU1M1GLKKV6uknuq1mOTAMQ2A4fMWq50AG/LQgL0Qb/B6oMr3PICD+YRImX5xzcuieFahHWLjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 16:02:39 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 16:02:39 +0000
Date: Mon, 4 Mar 2024 12:02:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240304160237.GA2909161@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214175735.GG1088888@nvidia.com>
X-ClientProxiedBy: SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::30) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf8cd9a-eda4-450a-41e0-08dc3c6483f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D+nZAO8+8nRFEgui94ryeP0fCq3w8ju+JeV1l3UaSoJ7UDoGl5WCCArd14CY8/DSYvRgW6MP4Nero2d/TvS3YiBhTs9ro7kSCdVclnmd7cZAcpjEpTz55yfLhIexb3b2XqDCQBhoOYcOupWWc4yFUWxg8kGGgS0X2O/CwT8a7nLLM5MVYzQmuCfagz3kSdK9TGyU5CE6ooKEw+4/Vd0UOHLPJT0udKyn9NnsxTpamXBRo94BaQRAhTXbQWAitomnDRF+VPAJ5XZ3A+8jo+El8RajT3+cEw5lJW0gtk3slzF9rZNqOM+B3KcaT7JbECCpxzn+Lvi2vUliNhxTisebCx5rXCdnL3PW70byebxFhZDZGjZSPANRUg6emkHn5DTG1DfGUX9iySclb4JP0wiXyPtYR9gdd/HP8P+h3XdwCtc9y5Dlg4sVZQKv03/N1paJD1cJLbAPet7p8zf2zuouBvrsQzEZUbjZrgfvJsHIu5PNVpyhLEgWtCWC+K3AE2WvpAlL/xKWHgzTOC9+iKC+sStxgHKsTj7Fo2Ezg3rhX/7ZIeZynTBNi+1kDX7qQCzz6NKmkO/Z72fnME7H+o8Mx7IFbjLe7YWYPh97xUdtevRK/9GIXkqUjPIHAF17/Dk7aNdfBBC7J+Hl2BGEEzzbRaBtqtbxoBvJLgBTmHwvIYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk1UTitZMzdRU2JIcVhWcm1pUDAwd2FQamNxeEgxRW5OYnA1Z1lKdXBQZEZy?=
 =?utf-8?B?eG8zWnQzVURleHc0Rld6OHFOM09seW9lbDNTOWVYdVUzWkUyREpNNmtyTk5H?=
 =?utf-8?B?TklMQnQ1SkpNTlpwaDh5bE1pR3BmTklBdGpMMFByYWVreW5LaEVtRGZjTi9w?=
 =?utf-8?B?alJxb1hSRlgvYWd5WUYwNlFuZ3Q1TlhjNDBhWHo2Y0p3L0pKcEFFaFBtSllo?=
 =?utf-8?B?WnowbTlzcmVKKzMyZVkwU0V6eG9xcG4wVHNhOFE2QXg1SjFPdEVTbGtHY2Rx?=
 =?utf-8?B?d2p5NHFxdlpxK2dMOEFXLzZMUmJQM0t6NHVlczZEUWR1YllhRjludkxFaHRM?=
 =?utf-8?B?SHhFNzhyTDhNaU44UnQ0U3orSnhWSk05VG1INkNCRTBjZkNjTi9WektNVWUx?=
 =?utf-8?B?RXRNY1o3YmhkcHJJL0Q4ME9oYTVZYVFYbk1rcGljTkQ4QjFiS2ljQTlhUGh0?=
 =?utf-8?B?andrSkhsTXA4WEhwenQ1UTB3b1AyL0prM0kzV3ZlSjB2Um8rK2dkbzJZMzFp?=
 =?utf-8?B?T2VWWTdXTEFiUlphNklJdTMrbTVrMkFaWE1GOTEzSmJDcUluMVBwUlMvd2U5?=
 =?utf-8?B?OGpWWG5TQXJKU1kzRXF0bmpTS1RRZ0wwampvU08rSi9pZnliL0JTampNNVY5?=
 =?utf-8?B?emUvRFBUU0ZYVmxPNkdmeVpjdGJRS01qd1MvbG1TRnBTRjZCLzlUN05ldmVD?=
 =?utf-8?B?azVBd3VRU0dpWFZtYUEvVjVyRnhRTzI2Y0xaN3dKaUp6bExKUkNvUUM4NDN4?=
 =?utf-8?B?bVlFV0ZYSllybncxSm5IU2Zsd0tCdXBFUmFMZ095NmNRejBjWUVUVHdpczJE?=
 =?utf-8?B?ZUNob0Y2U3YrNlhMVVJVeXpQbWlEck5MWnM0WGdrYVg3N09PSUxTUmhCNTZY?=
 =?utf-8?B?YlV2enZaZ1hST3JPTi9IcTNyeWlSWDdWalRWM0VzMURuUnBndXNOQTJzYWRX?=
 =?utf-8?B?OUxQdWVVTTAwRXlrNXZkYnUxQTB6cVFPbllBdlVRUWpIbERNbUFXNUlaWjlS?=
 =?utf-8?B?MWVXaDRFU1U2dnYrNjJSb1BKQ1lUbjF6S2laOHdESmNHNGE1K05PNUcwV0c3?=
 =?utf-8?B?WnJhYitYSzNabUhuVXMyaHB0NUNDNzczbCsrcm9EWEpDSkNadWI4cTEwTjda?=
 =?utf-8?B?bWlYZWVubWVSWUpYOGdrc0lUWUpzbFBISDFaTFN2U0xFSzlEM1I5TlowMFlZ?=
 =?utf-8?B?TGRJZ3J4TFkzV2xIbXlQaVlzZURZVEZ6dGE1em4wcW5SMGVYUkNwT0RPWmdL?=
 =?utf-8?B?QnhTWU9xcXplT01LdWV2Njg0c080c2tRK2IrMjlSQjh5bktxUjVFd1duVDAw?=
 =?utf-8?B?Yjg1bERDOVJKNUhFY0l4ajFCazhzdmhCbnhCNFd1N0NrQ2t1L0JkbDNRd2Ix?=
 =?utf-8?B?Z3RyTGV2U2tJczRCLzBlcklpWFgzazB1MDNOQmJXZ1FSZHJQZFBKdkwwMVM5?=
 =?utf-8?B?RVJ4TTJTN21XYTZPMGZFTmpMQ2wwQTZGVTk2UFJ6clRlYmFVM0lZeWU5M2hr?=
 =?utf-8?B?c1ArZlo5OElhVFIvc1BRellkY1BPdHpXZnFtOG9yS1dhZG9pWHo3dDBXKzV3?=
 =?utf-8?B?SlFKTzgxWTV1a2ZxdnU4YXR4REpqWWpJdDFKTlM2KzBZRWovQ1NRUjBpeC9D?=
 =?utf-8?B?Tlczd2NzWitjRDNoMTJiV2tWeFRyRUI2cUlGOUUxTy85Z0h1em14WW5Bc1ZF?=
 =?utf-8?B?ZDdVQ21EdWJWN3pnbldTUEFNeU5sSkxUK2NxMC9kWjNGeXY3cFRqcHBpbE03?=
 =?utf-8?B?TGFNcnY0RmtvN1d1RHlUaCtqYk1kVFZsN0szT2EydlJjRXN2MXpYK3RadWVw?=
 =?utf-8?B?citiTVRSQU1xNEN3R09aQjVUcUFnZGdwajJEUElWdXJHSlNoMkhMbXo4YWJG?=
 =?utf-8?B?b2x6L2VsY29tdDlUajQ3T3U0dHJjVzlFd3JXdHA0QTB1b1A2TXlGYjJKTFFr?=
 =?utf-8?B?bWhYSUppaVlYbEk0RDRRdXdnWHV2akZTN1ZkR3NXNTY5aG9DMmNGTmJBQjlu?=
 =?utf-8?B?NnJQeEtLNkJZc1FhRUtQbVdxOHI2QW9UZi9oTFpvYmxmdzg4c0pGdmtlUHor?=
 =?utf-8?B?b2dMb3QzQWY2UW85bXBwa0pUKy9aVXlUcFNWOElwbVpjc3NESW1pdkkyeFpU?=
 =?utf-8?Q?2LWE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf8cd9a-eda4-450a-41e0-08dc3c6483f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 16:02:39.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ao1asLpOoG434DH7PRGmCL27njfTfMrsEeGnuhp5pXxyE7If35LUcz0SM460j8eA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556

On Wed, Feb 14, 2024 at 01:57:35PM -0400, Jason Gunthorpe wrote:

> I also like this, I don't want the outcome of this discussion to be
> that only mlx5ctl gets merged. I want all the HW that has this problem
> to have support in the mainline kernel.

To this end here is my proposal to move forward with a new
mini-subsystem to provide rules for this common approach. Get the
existing tools out of hacky unstructured direct hardware access via
/sys/XX and into a formalized lockdown compatible system. I've talked
to enough people now to think we have a critical mass.

===============
fwctl subsystem
===============

Overview
--------

Modern devices contain extensive amounts of FW, and in many cases, are largely
software defined pieces of hardware. The evolution of this approach is largely a
reaction to Moore's Law where a chip tape out is now highly expensive, and the
chip design is extremely large. Replacing fixed HW logic with a flexible and
tightly coupled FW/HW combination is an effective risk mitigation against chip
respin. Problems in the HW design can be counteracted in device FW. This is
especially true for devices which present a stable and backwards compatible
interface to the operating system driver (such as NVMe).


The FW layer in devices has grown to incredible sizes and devices frequently
integrate clusters of fast processors to run it. For example, mlx5 devices have
over 30MB of FW code, and big configurations operate with over1GB of FW managed
runtime state.

The availability of such a flexible layer has created quite a variety in the
industry where single pieces of silicon are now configurable software defined
devices and can operate in quite different ways depending on the need. Further
we often see cases where specific sites wish to operate devices in ways that are
highly specialized and can only run an application that has been tailored to
their unique configuration.

Further, devices have become multi-functional and integrated they no longer
fit neatly into the kernel's division of subsystems. Modern multi-functional
devices have drivers, such as bnxt/ice/mlx5/pds, that span many subsystems
while sharing the underlying hardware using the auxiliary device system.

All together this creates a challenge for the operating system, where devices
have an expansive FW environment that needs robust vendor-specific debugging
support, and FW driven functionality that is not well suited to “generic”
interfaces. fwctl seeks to allow access to the full device functionality from
user space in the areas of debuggability, management, and first-boot/nth-boot
provisioning.

fwctl is aimed at the common device design pattern where the OS and FW
communicate via an RPC message layer constructed with a queue or mailbox scheme.
In this case the driver will typically have some layer to deliver RPC messages
and collect RPC responses from device FW. The in-kernel subsystem drivers that
operate the device for its primary purposes will use these RPCs to build their
drivers, but devices also usually have a set of ancillary RPCs that don't really
fit into any specific subsystem. For example, a HW RAID controller is primarily
operated by the block layer but also comes with a set of RPCs to administer the
construction of drives within the HW RAID.

In the past when devices were more single function individual subsystems would
grow different approaches to solving some of these common problems, for instance
monitoring device health, manipulating its FLASH, debugging the FW,
provisioning, all have various unique interfaces across the kernel.

fwctl's purpose is to define a common set of limited rules, described below,
that allow user space to securely construct and execute RPCs inside device FW.
The rules serve as an agreement between the operating system and FW on how to
correctly design the RPC interface. As a uAPI the subsystem provides a thin
layer of discovery and a generic uAPI to deliver the RPCs and collect the
response. It supports a system of user space libraries and tools which will
use this interface to control the device.

Scope of Action
---------------

fwctl drivers are strictly restricted to being a way to operate the device FW.
It is not an avenue to access random kernel internals, or other operating system
SW states.

fwctl instances must operate on a well-defined device function, and the device
should have a well-defined security model for what scope within the device the
function is permitted to access. For instance, the most complex PCIe device
today may broadly have several function level scopes:

 1. A privileged function with full access to the on-device global state and
    configuration

 2. Multiple hypervisor function with control over itself and child functions
    used with VMs

 3. Multiple VM function tightly scoped within the VM

The device may create a logical parent/child relationship between these scopes,
for instance a child VM's FW may be within the scope of the hypervisor FW. It is
quite common in the VFIO world that the hypervisor environment has a complex
provisioning/profiling/configuration responsibility for the function VFIO
assigns to the VM.

Further, within the function, devices often have RPC commands that fall within
some general scopes of action:

 1. Access to function & child configuration, flash, etc that becomes live at a
    function reset.

 2. Access to function & child runtime configuration that kernel drivers can
    discover at runtime.

 3. Read only access to function debug information that may report on FW objects
    in the function & child, including FW objects owned by other kernel
    subsystems.

 4. Write access to function & child debug information strictly compatible with
    the principles of kernel lockdown and kernel integrity protection. Triggers
    a kernel Taint.

 5. Full debug device access. Triggers a kernel Taint, requires CAP_SYS_RAWIO.

Limitation to the appropriate scope must be performed by the kernel.

There are many things this interface must not allow user space to do (without a
Taint or CAP), broadly derived from the principles of kernel lockdown. Some
examples:

 1. DMA to/from arbitrary memory, hang the system, run code in the device, or
    otherwise compromise device or system security and integrity.

 2. Provide an abnormal “back door” to kernel drivers. No manipulation of kernel
    objects owned by kernel drivers.

 3. Directly configure or otherwise control kernel drivers. The kernel driver
    can react to the device configuration at function reset/driver load time,
    but otherwise should not be coupled to fwctl.

 4. Operate the HW in a way that overlaps with the core purpose of another
    primary kernel subsystem, such as read/write to LBAs, send/receive of
    Network packets, or operate an accelerator's data plane.

fwctl is not a replacement for device direct access subsystems like uacce or
VFIO.

Security Response
-----------------

The kernel remains the gatekeeper for this interface. If violations of the
scopes, security or isolation principles are found, we have options to let
devices fix them with a FW update, push a kernel patch to parse and block RPC
commands or push a kernel patch to block entire firmware versions, or devices.

While the kernel can always directly parse and restrict RPCs, it is expected
that the existing kernel pattern of allowing drivers to delegate validation to
FW to be a useful design.

fwctl Driver design
-------------------

In many cases a fwctl driver is going to be part of a larger cross-subsystem
device possibly using the auxiliary_device mechanism. In that case several
subsystems are going to be sharing the same device and FW interface layer so the
device design must already provide for isolation and co-operation between kernel
subsystems. fwctl should fit into that same model.

Part of the driver should include a description of how its scope restrictions
and security model work. The driver and FW together must ensure that RPCs
provided by user space are mapped to the appropriate scope and that the user
space has rights to work on that scope. Broadly there are two approaches drivers
can take:

Have the kernel provide a scope label to the FW along with the user space RPC
and FW will parse and enforce the scope

Have the kernel parse the RPC and enforce the scope

The driver and FW must co-operate to ensure that either fwctl cannot allocate
any FW resources, or any resources it does allocate are freed on FD closure.  A
driver primarily constructed around FW RPCs may find that its core PCI function
and RPC layer belongs under fwctl with auxiliary devices connecting to other
subsystems.

User space Operation
--------------------

To be written in detail, broadly:

 - A “fwctl” class

 - Each fwctl device driver makes a fwctl instance with a struct device and
   sysfs presence in its class and a char device /dev/fwctl/XX

 - Some sysfs files per-instance describing what the device is and bootstrap
   details needed to operate and format RPCs.

 - fds opened from /dev/fwctl/XX support an IOCTL to specify the scope, execute
   an RPC and return the response.

 - A security layer ensuring that operations from user space are restricted and
   contained within the defined scopes.

User space Community
--------------------

Drawing inspiration from nvme-cli, participating in the kernel side must come
with a user space in a common TBD git tree, at a minimum to usefully operate the
kernel driver. Providing such an implementation is a pre-condition to merging a
kernel driver.

The goal is to build user space community around some of the shared problems
we all have, and ideally develop some common user space programs with some
starting themes of:

 - Device in-field debugging

 - HW provisioning

 - VFIO child device profiling before VM boot

 - Confidential Compute topics (attestation, secure provisioning)

That stretches across all subsystems in the kernel. fwupd is a great example of
how an excellent user space experience can emerge out of kernel-side diversity.

Existing Similar Examples
-------------------------

The approach described in this document is not a new idea. Direct, or near
direct device access has been offered by the kernel in different areas for
decades. With more devices wanting to follow this design pattern it is becoming
clear that it is not entirely well understood and, more importantly, the
security considerations are not well defined or agreed upon.

Some examples:

 - HW RAID controllers. This includes RPCs to do things like compose drives into
   a RAID volume, configure RAID parameters, monitor the HW and more.

 - Baseboard managers. RPCs for configuring settings in the device and more

 - NVMe vendor command capsules. nvme-cli provides access to some monitoring
   functions that vendors have defined, but more exists.

 - DRM allows user space drivers to send commands to the device via kernel
   mediation

 - RDMA allows user space drivers to directly push commands to the device
   without kernel involvement

Various “raw” APIs, raw HID (SDL2), raw USB, NVMe Generic Interface, etc

The first 3 would be examples of areas that fwctl intends to cover.

Some key lessons learned from these past efforts are the importance of having a
common user space project to use as a pre-condition for obtaining a kernel
driver. Developing good community around useful software in user space is key to
getting vendor companies to fund participation.

