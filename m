Return-Path: <linux-kernel+bounces-162833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0148B612E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79A3283AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF54F12A157;
	Mon, 29 Apr 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UGY80Z13"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06312A14C;
	Mon, 29 Apr 2024 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415691; cv=fail; b=YgFZimrYQln5LrOzNCGOzJOJZmnU8nf7AkVZor1JDXOJLvvPDp1Z7cs8dMxq32TKYnSfooZ3KqwMcRGJn+zrprxNA5jk8nji7V1+XlDAKKtXFcGGM08xGTDi70vXB7e4Wvh8JjWk1bV6zwm5jpXMZBlEpoCo57yXAv252r0dkxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415691; c=relaxed/simple;
	bh=iTZs0AKYV9BYtW1Bt+IWXOyLwtmI89EZwYEDZUBsqA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BFAQchbprguP0MxcNd6E8EXzkKle2OWWodcLKe22G9VWd4sePOLCfYaWj3KlkLPszhKi0/gymgW7mxyYWiplK5Q5TKBJk/fAq2psV2D9WeymQjSNUy9nVa9P76UVEoj5Ox1bW9D5fdqAw7DL4+ArkY1iKmOUWfsCBhFqBLhHLK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UGY80Z13; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgJdNcBmCNOd9EsDuu59XopUKKDREum7rBimv4Nzj+Kf0jy6BLML6xvrtilvHWJT4Y5juJ5C8dYOvy+Qe5M0Uayv3wjJ90ol+ghZEQlnTtmJ4mVgWBGKTsW/EF++znASmtdvq0SlxnUx6e285CjO0+1PHyfnI4nQfFe16j0o0Mjdh9Vq8wCDZ0AmnWpVufIo/MA2tCeZ+b+HWUKm3aSe5A3oiXNTQ/UPcEDMjXgcd0ZId4jjgvZoVaZINv8jSLSEIwUIG9+LSHAJ/hYnJWa4chh6qVoqch0/1RzA4PfzNRc1479Gq3Y3Z0jBaGX1dSJplMdIQk+mAyzbttBgOC88kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbqDHemOhhI9gLu4HgQ/TmUUTYsB7ap0TZ2cvLFCMdU=;
 b=XLXnZMIweKzcAvsrLZGAgDRJUP47sqaqRxQmHfLLhiz20U8LulIXpGdZz2I6TPKRbQhw9VnfSwNQKYMxKdTYkOk4KTBv+ZNB0oWeuDWlAVtRwcHAEWsVhZ0x5wensDetv9G5takMHzyptD20rl++4DZh4p5wyEJhONyZvQF3pECL/aKnBj2dZFzj//KnyKJzNuTZOBUmkeikyvt6bfvMF9IAEHzGe0ApylFTcnE0+KBnybGRXM3C6YbmcCZmROoblA5fZjnt+5RYg4gTY9NN+LisLLrhzIgb0PNXf+T9edqizHQOL6n7eJn7iea8ZHGkFT/7EdOU2LNY2dbOgSl8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbqDHemOhhI9gLu4HgQ/TmUUTYsB7ap0TZ2cvLFCMdU=;
 b=UGY80Z13Wm8dkJx51LjODPzC8Y+u8iazqghu/PXKfg0pvnWOCph2lMjZkISYRQEjrq6mtA7E3hD8raNwdYlMsVYwTjtaFf4lPBXWVQsg7TquCTOpuEyfMsayCQg2BgBl6sK9rD94tUGsw9PzQWt+JQrrCZRur0aHSbvLrQxbab8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 18:34:43 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 18:34:43 +0000
Date: Mon, 29 Apr 2024 20:34:37 +0200
From: Robert Richter <rrichter@amd.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Message-ID: <Zi_oPUzvCDhRVSk4@rric.localdomain>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
 <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d705d9-67cd-44a2-305b-08dc687b0985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9cvEFkJ0Qz5wa4ugnHLZxDmzdiXslSzL22E1ttqPqlMVxE89uHTOpBvJBeht?=
 =?us-ascii?Q?LrRqY68UaKt0SsYcuSBOMHwb7rrm4wAkKcoKdlFEIxRC6JDarKUUthSGTGyd?=
 =?us-ascii?Q?Ez09y3aznAyIxooJdBw74diAemRBpJ/Nw/WvpeAKdLPEkl5AT9p74tD4LWfi?=
 =?us-ascii?Q?RqP8Q7WBI1AljcXs6oBosK2Eykc28EUeAGOhKBthn8M9kQhX4aJo/Ds4rmio?=
 =?us-ascii?Q?MkyuUcMp9eiwZQeb4hHcLcu44kk2GvAEh6GjnsZZyaeZwQ4p+xu8ziocPSKZ?=
 =?us-ascii?Q?gObGgU4AFkQlADbunIYWiTfVFcS5eBK7x4/vDz9QiiqI/5gsciQp84Y7c5JI?=
 =?us-ascii?Q?hobNuhr6cIKbt3bD8EiE0/tQHDm/bPtMcgV6AANEkMi+i5rZNOF7g10c37/2?=
 =?us-ascii?Q?Fw2CYgrlL/9i3BY7lBEGJn4newfApTJFdh0aZAvptXep33atMY2eaZwBZtQu?=
 =?us-ascii?Q?tjA69jhs+cYY/6TghLlRw/nwVbecm4zHRyuKI3bvpI7ZJNIFNKH+DKxBt4TR?=
 =?us-ascii?Q?WVNTUlA2vljDaHuc4Z1+M+iATax2Oi9aHQLFJYs3hlUpZOvHClaTA2n7xkg+?=
 =?us-ascii?Q?lOLgZbL9YPa9qpX4vLf1gRSLkkJjRY6M10XHxhPE6NMFn16h2v5iMLn9JM3T?=
 =?us-ascii?Q?2FyKXME3lMQ42xmgwqHzS6pT15kHl021v6TEU32x9L0sFUEkHSNmZig5JH9I?=
 =?us-ascii?Q?hXCtEzZow+zH2GgwBk+/p/0l9WEYY852gtRg3T3zRln/3y9xw9y8SwRa68zs?=
 =?us-ascii?Q?2aRwiT6ls59aK6Oxc5zlnHuXGR4w6/IxQ6iH5gGl5s42qxC4iXChOhEpf5w1?=
 =?us-ascii?Q?wWJm2v86RavfmQBzHvMkyEWMCHkYN6YbP621x6i6OjzQzGuapbUDwLFelOjl?=
 =?us-ascii?Q?IcSIOlhthldnG7eV8C8dbtiEl/saa5ecxdLB1jF+CG+TwLHucxDOwi4dftAS?=
 =?us-ascii?Q?QzhZEDm6exQO1XNFO7Xgfwi0P/mAKDy6bOXAoeHUgDVyMhstDdRuQxsusuZ0?=
 =?us-ascii?Q?7pSK7CA68qpMkiMH71qUjVQ+3Soym/pWonDuPybxlZanEDL/jU8Kv3wLltHA?=
 =?us-ascii?Q?K5Bz74UJ16Z9nTWxlZ50+M83fV5JlfTLlaMGgS3KSeIza9tQQiuJRiPTV3LZ?=
 =?us-ascii?Q?SwzB3520jA6kwrPkX9s7LdocDx6DeTWZfbVH1qPBc3TWLliXWpNCJNA5gFe2?=
 =?us-ascii?Q?s3tfodL6txXDPxZ/dbvwCnMRfHPZhA8hCLmLE0ZFl2CQGUiUg022xVZXqxOt?=
 =?us-ascii?Q?69HeLw+sjb9w5BuPCOvb92lq7Oo2ZjJFBtdalaJyaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V1Kp142F8DxHZfwrtrZuRHiN0vRX542+Ohe6Rra5U8Tec8/Lx3nSvUhs1CgN?=
 =?us-ascii?Q?QbRn9XdCXn6tZHKt0tsuxigAchIKcclbMjQ8/+NP4ML2yBQcYzEYodwL+kj0?=
 =?us-ascii?Q?saORfQNEx8GerRLnUo0IUPrWcCFwT4WSUp9t+TIc/wR7rHdru2ZTaYZXxo/K?=
 =?us-ascii?Q?hV9IPmJfqt6fpozsNnO+pExZ9dD5cHpkYeDBlJQAoCD5ro8B2bP2NwKHBwRR?=
 =?us-ascii?Q?hbUKDUj58l9WUZKTYD78tzhkwc7RLq1C4ZyRlJoBT+DnGFSpgITidEuCnJrU?=
 =?us-ascii?Q?PPdjVLRRAX1e4XxKZ5qKAYmHxNbMHdTDUZsGlh/qiOnYeXCZ95O064Ug4bpa?=
 =?us-ascii?Q?6hWQlPytIhIyk/eQCD/d8jtMILXmRg3bi6R2FL8y6tZzDP7vOD+51/VPRtkZ?=
 =?us-ascii?Q?BxfQs0602jCDdN0ytrW0EjVZayH8XOdtSvEQ409hgDSA7zl6o0FNnP4Be6kC?=
 =?us-ascii?Q?FdRVKLAn/6MYAV4VdeLe1X8GgufyANWqmZgiro2lPrw0cB7C6iZadsMkB8Vj?=
 =?us-ascii?Q?7pyAhS5+kTit4q+8xS00rirKbRLkF9p4/tBV1ABgbVtbMfF7ecB4nN0yaRZX?=
 =?us-ascii?Q?HZXKEnGx9qeGzjOWp/cq5iz93vcwKkHVEZlbUvMAiVZw3XoegFryUD3+93Ha?=
 =?us-ascii?Q?fsPeqAaGANJdmy+h19gDHVZdlJC5Dk8jLQkHvfV7CdsM7SSaGuCYjvR70W15?=
 =?us-ascii?Q?IpL71tV//VJfRkQaMaQhYY5IlRp4ExTdYYYoG8ny2lCwES31nLvULvJPAkqm?=
 =?us-ascii?Q?0xyqGsZxmGjayotZfONlX72pSlbMRksAiSxTNpC16uVe5NtTEBy6QQK+tw3R?=
 =?us-ascii?Q?c9K07x/XG4dHQim8q0oDWlo653MXkG/I0ta1QrpLVmRSqFrNMRTNCMBqf4FG?=
 =?us-ascii?Q?bajMypR5q7/vnItTYxxHQvHczflpQFl9b8xglLP3GK28XBVuSZ3nyOYmt22y?=
 =?us-ascii?Q?yUraRbkKxFNZ88wjdBuaZMjVA2WXM3/rgGCui3YiCC0zOV2AkRlFmJZGlLoa?=
 =?us-ascii?Q?kwyBIVQne7F/vXg7YFsGGf/YP0QsTkZDADR2AyvfENwc7jrhhpi6fnk8j4M1?=
 =?us-ascii?Q?lv2s5JF8mwXyrteTCszBmYFXtF/DBvx2gcUDg+dj9LRC0Yvk7wOwPgfp4XlC?=
 =?us-ascii?Q?CMU+m3FkSlkhC0bYoAgoes+j165HFZa0bwjlHflbyT8huotRh3xFhuaUs+Hu?=
 =?us-ascii?Q?d359KpemNYVkFpbdUJ/pSCrE9zbx1f+S0kUnr6k2BU4PeHW/J/uFE7AJvvKu?=
 =?us-ascii?Q?Q6wlSwpiYXui6XXO3OxYBJJBITJikb9foieDtn3D96yY0jz9DbdU6rlB3CjG?=
 =?us-ascii?Q?Qxj4QJukrkHGxCY/996lsG3pbWX2jF4wxeiLZygyOb7aecfen2hgyBTh50rp?=
 =?us-ascii?Q?IEYA3ELEYD3pDd4d3yH6EZnP77WmDbY7xY4ioeejxmQ1yj72MTIQes6vzZ1N?=
 =?us-ascii?Q?jBDbfH711HmN2+Tj9J62HhbY+0mq3LJ/zO7jaZCETjJoq2d3OxrBITMkb+f9?=
 =?us-ascii?Q?lC4i66dfsDFnK/81Drg9KQLncr5+10pMqkyhwKfktj9ki8aktMdUZejrj2QF?=
 =?us-ascii?Q?Ex7ZcSOS5MjPkOLB4IA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d705d9-67cd-44a2-305b-08dc687b0985
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 18:34:43.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcrG7+byuk2Ui84vHv7f2PL6cLph0wKsWc529QRStTa+ffMTU8NuLf3xDJMA9orh5eUwgyH136HpofmaVpCL/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504

On 25.04.24 10:12:44, Yazen Ghannam wrote:
> On 4/24/2024 3:06 PM, Borislav Petkov wrote:
> > On Thu, Apr 04, 2024 at 10:13:50AM -0500, Yazen Ghannam wrote:
> >> AMD systems with the SUCCOR feature can send an APIC LVT interrupt for
> >> deferred errors. The LVT offset is 0x2 by convention, i.e. this is the
> >> default as listed in hardware documentation.
> >>
> >> However, the MCA registers may list a different LVT offset for this
> >> interrupt. The kernel should honor the value from the hardware.
> > 
> > There's this "may" thing again.
> > 
> 
> Right, I should say "the microarchitecture allows it". :)
> 
> > Is this enablement for some future hw too or do you really trust the
> > value in MSR_CU_DEF_ERR is programmed correctly in all cases?
> > 
> 
> I trust the value from hardware.
> 
> The intention here is to simplify the code for general maintenance and to make
> later patches easier.
> 
> >> Simplify the enable flow by using the hardware-provided value. Any
> >> conflicts will be caught by setup_APIC_eilvt(). Conflicts on production
> >> systems can be handled as quirks, if needed.
> > 
> > Well, which systems support succor?
> > 
> > I'd like to test this on them before we face all the quirkery. :)
> > 
> 
> All Zen/SMCA systems. I don't recall any issues in this area.
> 
> Some later Family 15h systems (Carrizo?) had it. But I don't know if it was
> used in production. It was slightly before my time.
> 
> > That area has been plagued by hw snafus if you look at
> > setup_APIC_eilvt() and talk to uncle Robert. :-P
> >
> 
> Right, I found this:
> 27afdf2008da ("apic, x86: Use BIOS settings for IBS and MCE threshold
> interrupt LVT offsets")
> 
> Which is basically the same idea: use what is in the register.
> 
> But it looks there was an issue with IBS on Family 10h.

After looking a while into it I think the issue was the following:

IBS offset was not enabled by firmware, but MCE already was (due to
earlier setup). And mce was (maybe) not on all cpus and only one cpu
per socket enabled. The IBS vector should be enabled on all cpus. Now
firmware allocated offset 1 for mce (instead of offset 0 as for
k8). This caused the hardcoded value (offset 1 for IBS) to be already
taken. Also, hardcoded values couldn't be used at all as this would
have not been worked on k8 (for mce). Another issue was to find the
next free offset as you couldn't examine just the current cpu. So even
if the offset on the current was available, another cpu might have
that offset already in use. Yet another problem was that programmed
offsets for mce and ibs overlapped each other and the kernel had to
reassign them (the ibs offset).

I hope a remember correctly here with all details.

Thanks,

-Robert

