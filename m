Return-Path: <linux-kernel+bounces-166466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 174D98B9B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F94B20C1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4AC3E47E;
	Thu,  2 May 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hJG0B04Z"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346EC6A8AC;
	Thu,  2 May 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653932; cv=fail; b=AE7TC8aNgLI6DRBSACI+jZuZpIU54l0FTkZaAevOxP2TO+mdzBgdXjjUMhmWMDUZ+2KgQ3RvrVWzkhrTKNtIrtx7qpxqk9rmjFKNl/hRvfi+bGbbdkOWyYf30BaEFYgSRlUAMY6UmEdYFOyCITnQxX0k/Dml9H86WBw3xa7JyzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653932; c=relaxed/simple;
	bh=9/1IIKi6y4Ddgz44WuNG2s7rrvQ/zZdDVsqA+5bso7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CA9f1nL6bpPa+z346uZtiINQBrr3MEAEOf6a1T12vgKK3e6CbvXZNx4fcLb6P74tUvu3yfq3NptvA5OPOSwz1hbbzsImrdPn+zIIsyAXcy2V7NnGwa5rAmKRm47veB1NrgoIE12YtGLD2DudNxjsi7dQN6it4sdGhRj90gQq5lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hJG0B04Z; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpzLeckNkBZCeo/Le2EdRHYbkiC+R4GRhdyFcxfIaQZ4RUPXNCxJ217M4FjPZoR8hNhU0TaLQEAaDVaUYH/wFTdd75XbCqJltIZK6Ar0E2tDg3RhBLFC3rWenfNwjN9NmD4Ea/rTpBISP1Cfz3wuWSsgkP3ua5DDeJ/xZK2kRPEZ96Q2VlIP2sOPzdZDlNrSpEVB1XAw+k4jwuHgwwJ7U/RIo2fvrNe92uwuldHCGOxApjMfwBKy/kMr7WUAIVcsMXNeVVL6g4o+xN0u2qydtovenN8jleO62h1RoD9ohQCzAbF7cCCA84O0e9sFDk9kFQE0ljYuFw7CHMUrgK1iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LRms7Dv5bu7aq/ekUhkPOMTLQB10+sY5fqD9DlWdao=;
 b=RTTnidnBjc6Wr2ic2fuKgbtgZutR5/yfahk3oX83bJlGCKw0o3znou7CpsTKAhl9gH1s7CqnJB5/PiGBzxWqu7i8jGtVWtTGCECqsP9q9u8bGRhKIF0JyVpv1O1+MDF64XUCWUCRKDe4EQh15dENwjvSlOp6qfS0ktgxVzhOnMF8t+TiR1D/I/6z94760VisF7tqfm/5O0XXtNOA6sLzVAVRw6wXFAcaQPqmCkk8KYY1ybKYQ9qy3ixZtOpUIqfKTWrWVCBXgo2935p95nrh6RMnL9PVUayiAI6UBCYW3vqon9fD5QCC4Qy2958v6WNiPCEtxJaYqFCFKDt0e3HmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LRms7Dv5bu7aq/ekUhkPOMTLQB10+sY5fqD9DlWdao=;
 b=hJG0B04Z2kvIm/Ff/0l+krt4m1K0/cshCibCjw57c23QytovD66nSkERuKNnpmSzMb0+FBf8Yn2D4PrQ6ekFxIKklh3Oc2sWEFXTQm6G7rvS8KkxZVxHGb/DlawhqmlmqQZRhlmxkt3m/NqfdlZ8L1QcquXRPk0ceYYCIDI/EvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 12:45:28 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 12:45:28 +0000
Date: Thu, 2 May 2024 14:45:20 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Alison Schofield <alison.schofield@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 5/7] ACPI/NUMA: Return memblk modification state from
 numa_fill_memblks()
Message-ID: <ZjOK4Ak1p88Go1hF@rric.localdomain>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-6-rrichter@amd.com>
 <663124e36ecc5_10c21294b6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663124e36ecc5_10c21294b6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR3P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e2b133-4844-445e-04b8-08dc6aa5bec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J4LgBkCK/9zysKY0vfRaRHU3PSgthSP9NkqfKZrVD1gVNCaHqKmvLxmGQ+Oa?=
 =?us-ascii?Q?ZZQsiRCd5/bxdAOlQZ2sT39up7nRDKf9ewl6drfr0hch25HsXtTnL3CxXtzn?=
 =?us-ascii?Q?Cz7/yUzVqHbbVwhu3jrfGoL+GyGJHUn5KTmPNK8FlbI3ddJum/LTknZiYmYG?=
 =?us-ascii?Q?LkRQJMVoIsQ7Nqgys3Tn9/SDaT7p+36w5R8E0QBv2To9KV9OfH87uiB+2Nl0?=
 =?us-ascii?Q?32XW8u2zgtdPWaiIaGZM1KG82HgEE3w2ifK7y3fCMulCl61z29YDVi+UssmG?=
 =?us-ascii?Q?v7QdkgwQQb/0v23WbiSblxwfzkjQrBBq5/9Gt85oE0qNk2wJELRV3jJt9qqW?=
 =?us-ascii?Q?7Kd9fV4CeCnOzEY7/QE32VQpVTdSDE/SvYg+6JRFtLU94aRxr00aoK2fw/+Y?=
 =?us-ascii?Q?/moRoqv16MOTFH59E8RXY4bkCwkkCY+PC6n7f5i/Q1mn2ExXCPmC7/ISCw8N?=
 =?us-ascii?Q?9KGMFtxR7BFHyyGhP+xOnYJyp6BYf4Kz842OJpj5C7OUlgKvZu9CLX73K4Eo?=
 =?us-ascii?Q?+VKEkYbXokC4bRwsrNsgXKxZCNXCPsSv6s10633S+34pOyIzMBB/viNzZOZE?=
 =?us-ascii?Q?pX6NTurBWn6D+dUUMaIeFlYLQZfysnSy2m4X6GO/vuLyqYGy1S4I/w5VoA4I?=
 =?us-ascii?Q?ZjavPqAMbxyWgT/niW/EF7DqqZfb8arM/F3RRLNEa3tJMpQf+ejxpLzkjHzh?=
 =?us-ascii?Q?oEOA59IwwRqpGAo8TgIaoMPNXnFT2FHDxvG3RL4UAXdwVDOQpDc4Du5611Vp?=
 =?us-ascii?Q?eL31378X+817tP9ISzMaF0t4xUXkl82XWW4KaXv66T2t0shisshh5PA2Jcy7?=
 =?us-ascii?Q?tQHzFYL86fU1iMDc6dFjrMwMZqqYXv97gs7/hkoDf+ilwIk/IFHWQewxlqEd?=
 =?us-ascii?Q?JHNY3s6/tCxQsU6AOLJsVqucZisxzSxie75fX695VlCvZspmS26Co9XC4Zqp?=
 =?us-ascii?Q?E9AlFkk0mMUjw4ki0TLO+h9wPqJL80UcY+DxFBH8S0ViITHpy6OrHYkLLmAF?=
 =?us-ascii?Q?cVFWfrkSTDnD9BJBklLlbkGPsmapkXuDOc7hwsrytsKy8V2J9eqyMDc9C8lr?=
 =?us-ascii?Q?IrwMvIlS5O10UfMritSDklSZuZS7oWuv1ShnP60Pl1TWiN+/bxgX8BTlOnJB?=
 =?us-ascii?Q?eXjymtSqCqKIM0qMdV4OF8Dc+j7aY/i74T0Mb3uGyKMoi6FZ9Uhb7gv8VZP+?=
 =?us-ascii?Q?v4OqpfkN1v0+9v9sB6CJZZzCzf/5e1AJCvbJLdOuMCtRTz3JCdi1M90aptKj?=
 =?us-ascii?Q?kwwRk5ncqT4ygtLUh0pJvZBzL2h6jbkgYTwT+VMiiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?coN08UlEjiVlxdAfQKuy1KF7oZqKh5sBDcBW7VhJOY/7ZgRiR81KMZhogZ+G?=
 =?us-ascii?Q?YPeR4z160kJPgikMF4nDpXMf/EI/cRr2GOQUiGpRrFRrA2FIDbGi0WCXeROL?=
 =?us-ascii?Q?ehfuK0a1ttWERIhZKMy13j1vc59MWDSjGSZjJB1cbhB3USNtngM/1R9DwKUj?=
 =?us-ascii?Q?qhr5taJX23NaH7z/h4mJXs4z0GkfQ1kX5akXFI7y+B72aknPnqiIw/HbtLjt?=
 =?us-ascii?Q?RUzFKXIZu+WrB5mG7NPky7BXt+D1P1Yvv34SI/ygcvnqi1SazmjW6sPtscNM?=
 =?us-ascii?Q?Q81xBWUBSU/BYBk834TBHk2htriTS+J0kUSFj8373cnUGOd9Foh4+ZDJhqpN?=
 =?us-ascii?Q?aSkPVLdZm9dXQkin/lLHEorewS1wl7dwVRvfn6zIvO8Ks3qrRrUUCKwJP8nV?=
 =?us-ascii?Q?pT/i8jUXTRpzb+0iqfr0xxE8nNkMf8LX7PnQwCbOl4gwGWWtdw//TNuX34xH?=
 =?us-ascii?Q?8eYlIoI9kNMvP6eqJpHfJvkbvEiClN1csIRgKcI3erlQeremhKAKy/sjatFI?=
 =?us-ascii?Q?5SoHw3rWGA7Lc4WSqbRpq0iDM3f3ATtKXUOUUUknJPaGIK8RsbDavQG8KZlH?=
 =?us-ascii?Q?XBG81W6/oSXNM5o6MoDof9nJRCON78aeE7qly6Hc2Sp8JTWIYKk+0GkogfkM?=
 =?us-ascii?Q?wFjU4UkSLxZuGGODq3DhWF6hUgOkJQ2n6r3F5CRd3ZdtpL8w38/HlC67/hmx?=
 =?us-ascii?Q?V5vArD7MaSwu1vsqOMV2RRRXJnAOnHdc+4PKQOrmW/k7ByMz0XMIMz4upNAq?=
 =?us-ascii?Q?xHV+bIr+X7WJiEc4T+amFO9hJDJL8P5x4vTDByIMu8Gb2O3PoLn4j6rqw4wb?=
 =?us-ascii?Q?VaK3tiPHF9hd0EaoC2AUvf6Gse1mRm3MIVVCRKIjJkiryt+5kWnhX6/3C3F9?=
 =?us-ascii?Q?po6eA5RB5Rz6aZYwGw30PjcBRGVwTvzThDInncfBn9Lqq4jtkOLRlplJg36/?=
 =?us-ascii?Q?XAGKSa7doZRTVV7PQrnobQm/eq13stJ59ozQwpTMv1ld8leShbWV/bVZjTNQ?=
 =?us-ascii?Q?T7oB3sjRn3t3CX7skPOd5HMycy6E/UntgOhnCEozbqt8ulDP6swTod6kQZ2i?=
 =?us-ascii?Q?z4O/q3UsNQdrll/j8GnCSRQ8Z3ZAkkvhm53YysVOR7GpuIuXN5dxUdxAYjie?=
 =?us-ascii?Q?yCI19s24JfWkB3MlHAiwW8qP5PyOr0KoR1744af7vN25fMDTTcYF49JNIHRQ?=
 =?us-ascii?Q?nPuQg+fpkrWSbZDiUQpZJhmnL4ahISb6hN/rrK5gBfNXqU9lBYxVLsqITmkg?=
 =?us-ascii?Q?yy1SJdfUGG+NwTNqnQH6lr8odNVhPzIOvhZvACWTbmNG8WVCgb8+ymV8A/Lu?=
 =?us-ascii?Q?a+wtxAmjD7iqSr42BkSgK3wRAUVUONt14VDbeLu5qH9eCicTysExHUOQ5ju8?=
 =?us-ascii?Q?XTheYRpN6UT7bBhqZuEyeDgCWqwmmA/gPxEVx3JZnzlL0ffXHiqI1/yFCN/m?=
 =?us-ascii?Q?NiaZIcuZThKlMBsBS6rPHvIRKbqqc4qjYZT5s44oLcjtdndM9C+jdaHShgOt?=
 =?us-ascii?Q?KCMoq7q5MTUcWsvD8QH8SHP1NTfkj8yPfT9jXy5PZ96QKmN+E06v+V9BsRWW?=
 =?us-ascii?Q?HQxYQjfQbUQqdVjt2XfJsTWhdB7zV+cQAhUotHEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e2b133-4844-445e-04b8-08dc6aa5bec4
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:45:28.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acG0L9jcPjtJgTJhksBNMaFXqZ5tUsmifj6DIY8jkBXTyk0XCJ7P3CoaAKTbYOr7p/8rh8o4+nr28c3hwN/b2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

On 30.04.24 10:05:39, Dan Williams wrote:
> Robert Richter wrote:
> > When registering a memory range a possibly overlapping memory block
> > will be extended instead of creating a new one. If both ranges exactly
> > overlap, the blocks remain unchanged and are just reused. The
> > information if a memblock was extended is useful for diagnostics.
> 
> What diagnostic flow is this useful for?
> 
> I feel like this post-hoc debug prints for problems we never expect to
> have again, or is there an enduring need for this?

As we are already targeting -rc7, I am going to drop the printout
patches to not block the first patches in this series and will post
them again after the next merge window.

The SRAT logging is very useful to get a picture of the firmware
provided mem blocks. For NUMA debugging these are very helpful, esp.
when working with unmodified generic or distribution kernels. As CFMWS
entries add additional similar information as SRAT, that information
is no longer complete on systems with a CEDT.

The patches just enable the same level of logging for CFMWS as for
SRAT which just adds a single line (info level) per CFMWS entry (in
total just a few). The table printouts are at debug level already. Of
course, there are always other ways to get this information from, but
a grep of dmesg makes things very easy to check things.

Thanks,

-Robert

