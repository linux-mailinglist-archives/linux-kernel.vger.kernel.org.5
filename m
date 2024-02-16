Return-Path: <linux-kernel+bounces-69222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265448585EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1561282115
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F0135A64;
	Fri, 16 Feb 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FnRl2O24"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14513540F;
	Fri, 16 Feb 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110273; cv=fail; b=OdCkLVNXfvO3mS1REd90WRIy2L5K7Wp0995esDYZNPf5l58nW/EGFSneBAqoR7pmO3JTwjo/ABZI6bAXtnah+7RaewhBNBZzzPrvnfmVHpyrRK7HgJUMFhUShiCf8dJqitb8mZaviZP2ASjBWRTtIvwZPSzRABfEeBhf7oKmPxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110273; c=relaxed/simple;
	bh=DofgLIhbaDW72XEZSQ1W3oJWYUcItSwRO7yzwIYE98g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=abpSLvKhu1GT8RoETMUPiLEc1FUUgwbOhmqAUyn8bi8vM4ciXC+d4Gyg/wLr38yZoOPigKR4QPcMUJxON499/AwIWo1635MoOcRavaPsBQSpdCqPZ+QBv8UbNsuRX6lfJdqDr03ClzKX6AjKRWDMN9AKEv4tYiabYPCSevP8K0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FnRl2O24; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPLl+MDDuLUWDi8Fyw/2pD3WcB4f10qOJzTiBbXNzjZKLl++oiG0GtnqJLctTewXWaTSbNcry8BsJOo3AyI8jKf7KZR3RNGg+OjdMILvektAY1TYjadNeFlZxegSoNOjqv+MbtGz/YgrkeyJiV/I1CYOnxM1qfZWf8kAfLdBQiZnD1WV9f3gl3zey32FKTtfNN7dNnUwsR2tNBV03mvhU6RxoZ9iYEc8QzgxHg6/mRy8aahW+VP5Vr2s8V5hue/cX+tTEoShCNwPSrblH9lHGbSIWiLR/MS6fMN8o55QYOrShccyjvQb5N4+V9VTpGFGPfOzTIsRXsyP/qNNJ6wKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTzvQufVrgwXjeiUsxCykAo3AjhtlDEBiHqIS8Likyk=;
 b=nFq1glu9Y2mRyeydIRygmkzfCsAreDWmIkXapvu2vLIpc009TNX18JT7PmVNS6y0hE9y31r7SMhcw0MwoCPdKwCE2MMjAUAB1DinKjgPJ9FTvw5bH267cfWgjbe/r0u4iuPC2fSxKHOyi4Jj0i6Z1Jt3fhdkgPjggRTaMj/dtkYmFIkv1KpzK/CLnAbie+4Pe2pzwE5sE6gYWQ+6fOssJvB85TfK16K7yboQmVilQ3+1lL8qsngO9LBZHm5kidsQNkrlNs4YKUhOvREd+U0lARmSwckqLYokmpEoVM3638hf+7AnkedAlZByf/Jaw8zEttmt+joDCj7u7v2jcM/wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTzvQufVrgwXjeiUsxCykAo3AjhtlDEBiHqIS8Likyk=;
 b=FnRl2O246+scVNQ2+uVZtHEc8nv7cpLcBT2TkFMjxNT66t1ptT2PA5jDy3wy0ExyUctKhHiOFuNNv5bdvU6Z/RSduCLMuTWpsYZpZ2a4nQ9nqd6SKnD3EnTNAcODghue2bOxgkJeFk0cUorGWu0zNPNx0OdR45TMo27JoRiJsq+Ali7ErbuDT6Dhs8sJh3hFwtH0Nv4cDH+pRrJH8kZglRUxWaWzF4asy0nInjEw95V540Ba7LjwdEWJeY70KjRdHSyz1kXb0t38LhkyL6bIYh6/cMQqChdBYwtO6C5jiLDYbREbYc58D11Dj2ihhZUxMRgUdXViLQ2Wbmg4Vmw/BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 19:04:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 19:04:28 +0000
Date: Fri, 16 Feb 2024 15:04:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240216190426.GG13330@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <20240214074832.713ca16a@kernel.org>
 <20240215132138.GK1088888@nvidia.com>
 <20240215171013.60566d7b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215171013.60566d7b@kernel.org>
X-ClientProxiedBy: MN2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:208:134::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 263870e2-ec90-42a3-4046-08dc2f221925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bL51VZMHeK1qGOmaXZb4C9/7AHttlbIKmVe0YD2irYugiA4CjQwwp1WxEeLaWW5euE9aNaJ9sHKyA8ANwHyL2Qd5YK8cjMlT7JqJp5gMkIhJ2nN1AaE2ynBt0/72B05fhNS2+j5itUbc20CxG3dJm8ImkLMy+5NG4WinyJ6HqI11s7F7Lt3KzQUYstJ2cgDAh2xoHppFC9FwC4RdSUvwAO04w2aaa6gn+jq2lBLkx1IJxhUAq04weeKKX13vWkD05PGUmIV2l1+JSY+5R5kEXLRbxD8OK2mk4AFh3fwTjFZByN+SHDOmAVC+4eaOHftk6Z+ECybToAXOS6gtxb4Vm75cFGzn72gtR6icgIQ2C4CkgTFjqttNB6C/XpMs0W6SavtOIk7GQRJlgxOILW2AeRs5grMJ9uDvz8VPTk1DfQfuTXPGmNknik9nbBesR8ZQzfPhvx72852zlKnUVdz95KrMu0G8V1Ec3bclXtFORvvU+HFOgC3j5oPdOMkFOyHCICietmkxTResS/2YHjmAXkXCWyvjEqTR7nWvZl00n/WzHWoLlQd/aBADyc81AOWD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(26005)(316002)(6916009)(41300700001)(4326008)(8936002)(54906003)(8676002)(66946007)(66556008)(66476007)(2616005)(1076003)(6486002)(6506007)(6512007)(478600001)(36756003)(38100700002)(33656002)(86362001)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gdjmT7mBZ9TBwW+rx0xPaRqnY+iYoAjmn63sRMQVV069No/IzzBQioLmOCSP?=
 =?us-ascii?Q?yzwDvFkkHUWeDG2jbf90YiFbUdwqy0c3PKWd/9+eKdj0EcKdTyAQdm9uLnLz?=
 =?us-ascii?Q?6pdiKUzaK9KLT2nhhF6L++08KmGHz4ED3TLGGwbSxOIy5qvPjdoMf2JBQLFX?=
 =?us-ascii?Q?m84M897xHcyhkb3GvYYKHO5SujSVjXA8uoR+/aslu3dcTU0SKND67odjAnAR?=
 =?us-ascii?Q?XWX+uY6ZLce/BfMnE8SyhWLgUaCQRiHtIqFlBNJiP3KpRVBwHYggrVBLZnlM?=
 =?us-ascii?Q?/kOuV4Yn5mWWO1F/lUWhjpHqAVoVb/jrBMtV4En7CWw96az6Shg7UYaGPFh1?=
 =?us-ascii?Q?c3svh+IpId4hNqPxoJR92GqVm9ysgWW9OC6ssz1shYSl6TOZNB4TdbqcWG9B?=
 =?us-ascii?Q?Vp13Q4GytPIUAVtpnAzP4iKb5PyXzwH2VXToXtn2T0nwcNgLQYFF9PcRGxTm?=
 =?us-ascii?Q?WQmRUH88aIVXUpjmwkirxD/YH4pHVHyMfAxlncVLhd9dAJBkDEd/E2wPQRXq?=
 =?us-ascii?Q?dQOw3/SzvHQ3lG0er3hk7aSguxCO0nEzAPNCCo48UnsqMqyoUoVgCeW5G3Bs?=
 =?us-ascii?Q?qzW6UgCxLGtFYQc/KOOBsp7Lkj9VG5iHpJqbaJfkntPQhy3MnXiZFIOncky4?=
 =?us-ascii?Q?H2I1uq93MAzRe2D7jQh3Sn9/vskgBaXLqfUYIFi3hKS784kOIl/vOcbQQw0Y?=
 =?us-ascii?Q?WtroKCSLGpEcgbk2r9QGOP17qVpYz3+gvARjI6NEHoni2i2BZG72iErsIHs3?=
 =?us-ascii?Q?y8b4wYQYAdCLJrFeTxEEtae0EHt+XNxWEBfrOb+oJ1ZvYNCYTbJt9x9WeGO7?=
 =?us-ascii?Q?bAJPcGpK1U+E3EiKiCc15gf09wqUEbiTwIhtK+fAAjsQwBDdyWoWt9Zw2o6N?=
 =?us-ascii?Q?/gEeV7u5+VSAFvAZwF3UB+hHwdrpIuT++X+Wz+zUuS5qze4AxDMNa3I/SWF5?=
 =?us-ascii?Q?PRSXhAfuzwTtt30TEeCZhsYpaRBzgWn2hYCHs7AzBLJ6iOmiYiiC828a6InF?=
 =?us-ascii?Q?ETPHzvKqvNhPv1GmwaslQv5K4LXQg77MRmEC6tvROp5vW3XbKRCd8bvXloTR?=
 =?us-ascii?Q?n0rlTEKeN7RIWVG5BNTdICaqajfq5SjTD9xIqvk0lVs1/wcKfmuK1KXH8bho?=
 =?us-ascii?Q?LooLMYKF8yfetAiK+3+6PmufAWvaLULBDCJE+1X0u+102Pvod6B/z02smalv?=
 =?us-ascii?Q?BfHXykwcp/ZaYnIF/wR8hs97/5R5ThbFELGeiOKe5awP2BcMbBof2XIbaTHX?=
 =?us-ascii?Q?sw4dXICOXWQ7wNzW1/SWDG32iUDfo3yinMLA/Tu9hD9MXW9ypTk7uhtq0n3b?=
 =?us-ascii?Q?SVY05/b4eBDBaojz2F8YBXeeiNsoTwbkQL//niFBfe6N+tLJPELTnCA+eNyg?=
 =?us-ascii?Q?KvaxummuvyAEAacv8Qfaq+BnaPcQAh/gTyIGahL+5EqUM4CyHDvOezBrYybV?=
 =?us-ascii?Q?LflxPvS0rJwmtxsrwYehZxvy77NG0MxIYzhjryeQla3rNjSbbfsfjl19c+7E?=
 =?us-ascii?Q?8D0E6jqo1uBmdL7MAe2fF7ODpnt0zBbyqe9PGXvEvEwO+be80aQQgNe7R9vd?=
 =?us-ascii?Q?/ELBDU9D+fWIsIxVDMkC7DP1766fdMkAaqBUIeEp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263870e2-ec90-42a3-4046-08dc2f221925
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 19:04:27.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMfciWipur4LS2gBd1LJK0huN4NGaqiLIb47IUerKyvFbrC/+9Czyk+4Bx7BpivS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344

On Thu, Feb 15, 2024 at 05:10:13PM -0800, Jakub Kicinski wrote:
> On Thu, 15 Feb 2024 09:21:38 -0400 Jason Gunthorpe wrote:
> > On Wed, Feb 14, 2024 at 07:48:32AM -0800, Jakub Kicinski wrote:
> > > On Wed, 14 Feb 2024 00:29:16 -0800 Christoph Hellwig wrote:  
> > > > With my busy kernel contributor head on I have to voice my
> > > > dissatisfaction with the subsystem maintainer overreach that's causing
> > > > the troubles here.   
> > > 
> > > Overreach is unfortunate, I'd love to say "please do merge it as part 
> > > of RDMA". You probably don't trust my opinion but Jason admitted himself
> > > this is primarily for RDMA.  
> > 
> > "admitted"? You make it sound like a crime. I've been very clear on
> > this need from the RDMA community since the first posting.
> 
> Sorry, unintentional :) Maybe it's a misunderstanding but my impression
> was that at least Saeed was trying hard to make this driver a common
> one, not just for RDMA.

The hardware is common, this is a driver to talk to the shared FW. I
don't know how you'd do just one when netdev is effectively an RDMA
application running in the kernel, from the perspective of the FW.

There is no real line between these things beyond the artificial one
we have created in the kernel.

> > > The problem is that some RDMA stuff is built really closely on TCP,  
> > 
> > Huh? Since when? Are you talking about soft-iwarp? That is a reasearch
> > project and Bernard is very responsive, if you have issues ask him and
> > he will help.
> > 
> > Otherwise the actual HW devices are not entangled with netdev TCP, the
> > few iWarp devices have their own TCP implementation, in accordance
> > with what the IETF standardized.
> 
> There are some things I know either from work or otherwise told me 
> in confidence which I can't share. This is very frustrating for
> me, and probably for you, sorry :(

Well, all I can say is I know of no forthcoming RDMA things with any
different relationship to TCP. I think if someone wants to more TCP
they will have a hard time, and I'm not inclined to seriously help
anyone get more TCP into RDMA. iWarp is trouble enough already.

> > I seem to recall you saying RDMA shouldn't call any netdev APIs at
> > all. We were unable to agree on where to build the fence for this
> > reason.
> 
> Last time you were calling into the IPsec stack right? It's not just 
> a basic API. IDK how to draw a line, definitely open to suggestions!

I thought the two halfs of the mlx5 driver were co-ordinating their
usage of the shared HW around the ipsec configuration pushed into the
device by netdev xfrm.

> > > Ah, and I presume they may also want it for their DOCA products. 
> > > So 80% RDMA, 15% DOCA, 5% the rest is my guess.  
> > 
> > I don't know all details about DOCA, but what I know about runs over
> > RDMA.
> 
> Well, since you're an RDMA person that's not really saying much
> about existence of other parts.

<shrug> why does DOCA matter? Should we have not done io_uring because
Oracle might use it? Besides, from what I know about DOCA it is almost
all data plane stuff and RDMA fully covers that already..

Regards,
Jason

