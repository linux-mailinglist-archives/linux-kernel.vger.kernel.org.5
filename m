Return-Path: <linux-kernel+bounces-82738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2258688DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0CDDB218D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C49553373;
	Tue, 27 Feb 2024 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="eDKdOxs1"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2127.outbound.protection.outlook.com [40.107.244.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA54F4EB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709014325; cv=fail; b=SRn3SIPUBjO4ru9SIEnMw625vIa/Q5vFQV188HXe1WcLpbCaEhf4oYXE8bCRAkHm44Yoh3c2GQfflB2LGNHZaO2nbVfw+CR/ZmjFbC9d6gysJOJf4xxpkFouw3er0mW4/Ll3Svua5uRJRM4OMXFoM+DOt4tP+exOlvXdkjKSCAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709014325; c=relaxed/simple;
	bh=XVLW9J0YVa2yp6Myjk5wvPf23Mm6WOUQ1T0VNi6aqlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GArD9HqRcUTWdPE/HSCVe753f6T/Z53hzJI0HQeT2+nC6Flx3TPA6Svrn3byKX9afE2zLMCMQlh0qA8enowk5CelE8hIzzl/pvKSBVJRusVD6FeMty+fG/ATowsRptq5J2uiMLdDyNE7afcbjSGF14LTlUmZkoaFQXDug7OD4oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=eDKdOxs1; arc=fail smtp.client-ip=40.107.244.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+z96wdQlGYUx2IIx+CokJytUls0s5FP48mi8mCYWeHbNt069ANDoKlQdWHvxcRM8J0kclE67v9RWnr0Qk5im1aCjetbv2sKP+1eZQ+Xa6XoVDdeITS0hfB7k03/StZakdeEEmoEPdcRo3g6v8GL3FAgovtKPcIxCf1f4kLtU4l48gQecTkLhDvbuzCFierjcL63tO11ccDirAdyz/28Ea/kV7+/LFBbFr8PakmU251tlD9yWCFusF7ipPxk750MrzbnW48wS6MMR7KjM5VFOFUPJ2qEkHNFM77IA/lsTokAKWo9o99WPLEqXLKjBqtzkyThNB76owPx9Zwd43G+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pi6sygn0RqryY8ZMO1MtMPqq/5xqrSIIfFT6smWrcQo=;
 b=IXpdBr0yTdy9uAH3RvrvfxyoTMETMwyehKkwxfVdpgNZjfR/EnoQyROfRtQrjDVDYr7tDeoGwRpGpYebD2Xt1td1XLyDv5psZFuQS+mmkLLU62iW0r6JdMfEE0FlrdqbvNekBr1gnFQTY979r+4QOgK1WFowddMbZ3RqCri1d1PEB7T0zEyMMLCeIxN5EScaRRcQe5wboS2lHIfVI3APJkSJtQ2EnQ8ZMivxksnTNvt94p0ZcUOBzF4tTEzZGNtcCi8kUYx7ByKfzySLyB8n/8V0Lrtq3sdkgBtIOc4VZRKliQLKQ5+KDz7KpErP/8ipFOpD3IWZqUioaUzye3sCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi6sygn0RqryY8ZMO1MtMPqq/5xqrSIIfFT6smWrcQo=;
 b=eDKdOxs1p/55agm0qOsrM7uSHK8ZVQeAIoRQQwIeQC2xNMs2pTMbM6jld97LrPT/8f2fjnn6fv/L0B6lbhWmmZUQU0fpgf3KZe0q7Qj2rd9PK3OqPwtMo36aUxLOPmB66kKdArikvSKGYdPT+m+gNGjeBFyykVK+WWr5G/ihAFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM4PR17MB6246.namprd17.prod.outlook.com (2603:10b6:8:111::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 06:12:00 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6903:7860:581e:4468]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6903:7860:581e:4468%6]) with mapi id 15.20.7316.023; Tue, 27 Feb 2024
 06:12:00 +0000
Date: Tue, 27 Feb 2024 01:11:50 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, dave.jiang@intel.com
Subject: Re: [RFC 1/1] mm/mempolicy: introduce system default interleave
 weights
Message-ID: <Zd19JvKrhMho20Fg@memverge.com>
References: <20240220202529.2365-1-gregory.price@memverge.com>
 <20240220202529.2365-2-gregory.price@memverge.com>
 <87wmqxht4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZdgxaLSBznupVmJK@memverge.com>
 <87sf1jh7es.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZdygZ8ZidfaORg8F@memverge.com>
 <87edcyeo78.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zd10+G4XIrPoojJE@memverge.com>
 <87a5nme9c1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5nme9c1.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::35) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM4PR17MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: e7508887-b014-4ee6-ad7c-08dc375b028f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gf85sEdXwa9s9EoaVyv0NWrffH9WHn2pnDIcQlZp+49JJvLf8QzwIY0kMUTDFzFJxrG19zpYZCzk0fG8laNW8RJHI9qKF1k9QsZnecNPjhSv63a6QWD+3j0vSzFMIhwdGLK3ZRK1RUdBuprzH7Mb5EDa/cjuqCDc90yz6mNlUVsogKaYxDbaaPo7sb+TRSiviyN0fDDhDPXnuWCG+vmylNLVxMoGvJdiNZqIIOO63AZUna2whjqYSIw0g8s7+jGGsMvhSfQQw+4lRVxb7+SxfOPOfGgcBDx8Lj8mOA8TPKhKOOZpPKWJRyjelbr4hP4AgjVm68DwHS5IG3C4dG4BYsWAab//kio2qryNTBPoSm2xKIlSO6irTRpTnwGNT+r8TGxhzY4fp2YIHp6lix7zupVSjyDlnQvOPr0OXcGU1Cg1pS+tbVxt8KmJTKu23NzuV5di5njmPzqx/CTb+m401g7OeXL7IBRvAy9ojxzgDmlxlAUb7vchF4aL1NTGSv8FbfjI69Aiw1x82H6lMoAm11zrDsKQM0NjsWwLzyvoHpc09y7Crbn2gT8HKWC19bcL18v9Un6siU8KCxw0BwBOqJHiMSZ3LAP3Nz1sJTPUNef1AqHwjGjRxcCiDYog3Z/QJ8nTX4X624nzCq4RYm7Bpw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kfmvDleHfAyT6XDjnPM6YJupn/3AoCxfPbTqdbDJM1DvpKRfuGsP4elrp4RZ?=
 =?us-ascii?Q?iZ3VqGF0MW9wqZvcWY71kSGnJ5Ysp9Hk2jA+slvDklwf9Z7NDHH5PG5VZWWU?=
 =?us-ascii?Q?qxeGYrURbAV/cNUJQhxNN1NKOrzIcEgNZ4/cDW/c1EnwnxOnJqBn16hRD36R?=
 =?us-ascii?Q?W5JZb5ZallItNiPtjwXRhPt+a9Ahl47iGZNhcKpPS+4VYjIaKyqBdr0baQRI?=
 =?us-ascii?Q?02qmcesca1y+RqI67JdrTyWpTfFntBmaO6My0hEyFw1V5GrtFu7cTkHOAsrX?=
 =?us-ascii?Q?XZ1qmfhGVB8kk7yHeZbmdXY2oVJTiE0LNH492uQ4JRRy6CSqsjW85SRH+YnE?=
 =?us-ascii?Q?krxBAqzoUKI2lTqEK6xDGa/9BqeBocnPem2PUdHuunHvbDq/gUxePnCf/Dc1?=
 =?us-ascii?Q?nmmIvjX8g7+Zf7JoWshio8N0lFn3KAU8RME1jdvJfPMoj+AjF2b6yVDoqox3?=
 =?us-ascii?Q?DLKiqWajMOqh49nSc1M5t9xsyLYJGxOqrYDWrbpcxe1kdeMuTEvdKzxZ9ism?=
 =?us-ascii?Q?GRnWoNauDuAbyCy8ys/rkSw3h6V9z7J4XfU8yUY/LA/XYQzqX2WvGztfXGLk?=
 =?us-ascii?Q?Gz6eqC/uLMLWnqlx4Iu8Sr3t6S1Ebyj0Bl4+Pr78LO6NZtIXkUfSTgtGM0u7?=
 =?us-ascii?Q?xT3DaKNpotfYZCiUITJLRrnTZ4QQBoFzjHsBZNEc/PEQ+tqRy21KiPzeW2nQ?=
 =?us-ascii?Q?q3uPtJb2zlzHz1Hxk2PdJm9aENBFPgwDITp3Ykhjb/rMwRlJXuzjfpI1kbC9?=
 =?us-ascii?Q?rf1fw+OQMg52/QUHCBBalA/jrnTtuIJf8HOR7ldNu5Lu12NnhP8weYxj7Owd?=
 =?us-ascii?Q?NaBq6jwi1NwSkKMzFnbDHeZh2D1cZHse7S/mWa1z/FpadhTGqpPNE6Bbw4J7?=
 =?us-ascii?Q?0hccRCuVdbrs0zPHGLX3N+EHz4dldJEP+u87yRpCl8lRPtnH9H659M002SWd?=
 =?us-ascii?Q?yKKpd9ESxCGUJF/vzgVolQOmlFEgPSikFCIam3kq78s5YGKE67uBQnoePO/U?=
 =?us-ascii?Q?UiwrItn5DGaan1yI3XRhUf+k5BS/OErsOsPSqLYd3lnLD2lED5FCrwcilk63?=
 =?us-ascii?Q?L68AeLW7E3sFo6s6KQe7I+l+0tdH5chWMj7LyhXC9N2/bx2N9Qj6AE/7NANb?=
 =?us-ascii?Q?D8MzwpIrfqSvqa31ZhWi5bnQb5OkNmoNZmBr0w2GC6bCKk+3ZyUXLnCZO6Bu?=
 =?us-ascii?Q?VBZn0egLvZNLNaJwasjLb5ktc/ACgt4/h173M4/JcsJo69qPXyUu2ijNI4tV?=
 =?us-ascii?Q?wFaKdsTvXLwdSgBYAQJgfFAxqtllZDkJlOxowMSmsQM+4/l9G1VmOYhD7WHE?=
 =?us-ascii?Q?uGtxbpXMqD2cW35a9YpDOi6PLf5t58T6Ujj0Rk7+CVfTGtHyCJXP4LvFcN4B?=
 =?us-ascii?Q?NYVY3zg2RQicuBYSOuxN0aU2eg4f8DsLi4J6natAATBanAnjCZQ0+rR7KzQy?=
 =?us-ascii?Q?O+5HvXQLe7TvYgOTJUKayopKhm8ggfC8OUsqOUy0v//uJPwnRMNbAxIEGG6+?=
 =?us-ascii?Q?DsAKR6srEHBtM+l7AO9fEjxagocWUXoQQUiJjwHyMeWH0P/DSJGwXTq6RyVa?=
 =?us-ascii?Q?3tH14o0h1qv2uuB6GX6tss1llyRFPLe1Ark60RoPLOEIasBL3ERbtXgmB5se?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7508887-b014-4ee6-ad7c-08dc375b028f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 06:12:00.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7tNIbTDpHXxDfo/kqy+JG45OCzaLJ2hFw7RWbVFnvqcA2V6ochz9IQzqi9ET6lW1KrJx7WgxJqBbq5f6Dn8ib6suS8DfBng/x8cZHNB0jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6246

On Tue, Feb 27, 2024 at 01:59:26PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > I have to press this issue: Is this an actual, practical, concern?
> 
> I don't know who have large machine like that.  But I guess that it's
> possible in the long run.
>

Certainly possible, although that seems like a hyper-specialized case of
a supercomputer.  I suppose still worth considering for a bit.

> > I suppose another strategy is to calculate the interleave weights
> > un-bounded from the raw bandwidth - but continuously force reductions
> > (through some yet-undefined algorithm) until at least one node reaches a
> > weight of `1`.  This suffers from the opposite problem: what if the top
> > node has a value greater than 255? Do we just cap it at 255? That seems
> > the opposite form of problematic.
> >
> > (Large numbers are quite pointless, as it is essentially the antithesis
> > of interleave)
> 
> Yes.  So I suggest to use a relative small number as the default weight
> to start with for normal DRAM.  We will have to floor/ceiling the weight
> value.

Yeah more concretely, I was thinking something like

unsigned int *temp_weights; /* sizeof nr_node_ids */

memcpy(temp_weights, node_bandwidth);
while min(temp_weights) > 1:
    - attempt GCD reduction
    - if failed (GCD=1), adjust all odd numbers to be even (+1), try again

for weight in temp_weights:
    iw_table[N] = (weight > 255) ? 255 : (unsigned char)weight;

Something like this.  Of course this breaks if you have two nodes with a
massively different bandwidth ratio (> 255:1), but that seems
unrealistic given the intent of the devices.

~Gregory

