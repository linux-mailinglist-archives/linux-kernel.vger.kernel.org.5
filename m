Return-Path: <linux-kernel+bounces-150436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D08A9F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3391CB2220E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE116F84E;
	Thu, 18 Apr 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KTDwVbHo"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCB2AEFA;
	Thu, 18 Apr 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455855; cv=fail; b=rfBRUMz+y13PzfJsRuI81tXm/9k2h91YrIzy0c1JD++SvpHQTIgWa/uL95rMQj9UUxJrRjM5haC5Vddt3rILic+twloygAhmfPiFQBi7dI48FhO2HO7EKsBNgoytgqlAux1ZDAxoXbvhE+1z16iT/DFGjZCCOaixQ4pRQdheoUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455855; c=relaxed/simple;
	bh=9u2MsM3vxheawLxuYJE2eAsanhUcTU4ffEkbhUwm21Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qTbwVKpiiNKyNNqut/F2DZI4GzYCiSQCnOvp2FAdphdp6BB7cyrT2NMzQ3zYC1VXefLA5D8EI2ZMRIKeSGgeEM023VM/CKjZ4cJrz80fXxI1S5xNTmgI4LsHvjpsgUCf/oqqujwwLSuukPsPcGeCUW7Xps55luCSTD5p3mL+YaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KTDwVbHo; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft8SGDChfGSkymB/GItWJaVMEXPf3qWIBxdLMGLOoo2cAXqj4lXENtOZx9IrvD59LWdztU8vkWxk5NMGqAq1jHK28z4Ozg0QmmF2XvjIffHYFvDC9cRR9c14xT1snQBUBmKbuFpflrvLh8d4IhjvuQen3BwbuNDjom7ElFYRtODtgyw7vSVr/fsf0JYM1JXBKgBXfKR+sOIGoti/PsR9ERcc4azY8byuH6LBZ9/CHXrHK8hjYmltaTL5cqSwJx2NPPArJNpAtAyXP5/xyqNG8rrqRfHMXUaaJM15ITWFDyw1RmiXkZ6X6vnqubJUHNx661DSq2gYpKvyPYjPMvHZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0D35xUBG0eykYll1WKHey6qjX3nrV2hMKsoY9r5TEc=;
 b=BipFU2fTBOD/xpCZWQAwSOssni0Qd0THjjTs7/2iP4du1dfjytQKDzx2jdIDKWc9+jCx2zu7ED8i5tEhbR9ev4MIYStizoxrTleq3rwpdpFD1trc0UTYutl3rR797czNudOcDGD8RyVvgGGkk20FvA16jaxqmxFHiXO2wv+4d2Y1jYWm1MqyZEMcge2DbFaroEvsfBJp0tLZS0PqyF62fZQEtyhPuvNFj3jrCGNRnKfCtzVT+yqD7L9XWGeE8rs+ERWL8Nq+SQOrYs3GJfNMOfXaZdailHbv4I+kL/k7wErFAFa3haORhYpR1NAJtrTXCxzguA4rT/ID/hhwalYk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0D35xUBG0eykYll1WKHey6qjX3nrV2hMKsoY9r5TEc=;
 b=KTDwVbHoOUtj3XvdYZHdpZVvHCP8f5L+LEdqU4pJKq61BW70gNngELmBe1WnDWQ2Eu9CRYVOgnIohbFKsaavRrVUInaMBIjfeaecJSb0CG6RTOBDqpLI+t7I7LhDxnKhkicuktw1/k1l/p2IjgBfb1G7rsjBd4wRLS0E6csPV1iOpvbPkRbTScGQxGmm73ken6Jvx31cZ8dN1M19+f/e4UUyZzT0xXur4W2sOiq2+YuS4ElgX29K+ch1ranM05her6NT9t/VwaKLLWCz04oZ/OetpKmJYwP/ml6nyo9h6cty7IzCeFvOR7ANhcia5DAR0GP1WSji5nY6MaRNXcu2Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 15:57:29 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 15:57:29 +0000
Date: Thu, 18 Apr 2024 12:57:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kees Cook <keescook@chromium.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Alex Elder <elder@linaro.org>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <20240418155727.GA3368771@nvidia.com>
References: <20240414170850.148122-1-elder@linaro.org>
 <ZhzgTeEHFF19N3UZ@infradead.org>
 <2024041544-fester-undead-7949@gregkh>
 <202404150919.042E6FF@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404150919.042E6FF@keescook>
X-ClientProxiedBy: DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: b5bfb448-da2c-4796-bcca-08dc5fc04002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2SF9PPteQna8vJbDz9rXzYYTbZfIjj5fOMrII8XSW5s7wjv978qIXuu0ST7z+gdcbHyhQOdqXDzk2ItfCoSA7utxtK82mkUTlx7USAwjsODrDeOUSRG4VIV4UEBw+filgjSWSaGEK8wIYYoYX+WU6OtobCANXaT73Jqdyc8OEB/gwedNzB3ou1XzuAIuq9aYFgwyPn5tVAE2lvtvg1D47oJEATJB1WG/NlsNSRU4dFM+AHakjMmynKKlRuAzOVfRh2kZ14H6/1tO+OwvDNfc0hh5k6SJobMy935jA/4eeTeXOuedaAynBRLbP2FN99v7F02SOOS4Ip4JYi0QB0LJbq0LJDtKhHgZV1fZe0CMZHBbhmeauc7tc9DPIMOpt6SByUeZyzMYdRnGp2knq8CMYo/j35yA4KrQujjDIXt+2TooCx2gIACY1Y1wNkVYngErQBUUBqeGLuxY463LN+6OKJ7Ja3tCb9Tw+XK4UMuxPgu5CLqE5JSwti8XtDrBP7EEGk/CqFpDL340Z2N2gy40xxKPG4M95F3guYXKJqyThq/pvMMPFRVY2GYDjQbohLIb+oswuK16++Apkpk4C5XJm1z/rO2QD2VtFnTzBKTOBwE3lKQ0gld09jx+CYVqKB+ypysaLY/SL75Tp37hqfFBZW6pudQ7mEtKq4VxwMVcWZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EC5mmobo9NIWIFU5K+xYVS/tTcoXNQRS6klM6TJCmcmbltbKl11vhYbNcfyG?=
 =?us-ascii?Q?vUKrvO/2+2IMRzuiM8SUi/JiwJWuTTj/Lwg12KFT91mXRIvkK+LzpZUnbAfF?=
 =?us-ascii?Q?V/94dZFLB9kUCUCv06UYGZTQ9edBogwrBLT5G/yvF+lQWmETjd8Nj0yjoXCn?=
 =?us-ascii?Q?DTuMoAcVOc9yQsi1XnfVuqAHlGrvUOs0oxfqZgMC5VMN879CLB9OnIQP3f6z?=
 =?us-ascii?Q?q0Yxwjbp8hagHBIDBC2Opu/ssgUhz1jgL2uh11N2TIzj3ShJ6QYMtSBwN2mC?=
 =?us-ascii?Q?90UMEX2Dnxi1B6T++5rGTtCSrO0sC8t/0gLsdZmtipd0jSNJoR5ABnGKKz2h?=
 =?us-ascii?Q?4PXenBWV/dzM3gBjWVf5+6yCYueqzdnV403CDaGLggpkSxqCA4N3jB3BkyGm?=
 =?us-ascii?Q?pN04e/D/X2xOMbPPl+C4MEmmQH4LUIlA2qbfibnXGpofLMPuqQsVjXw667F8?=
 =?us-ascii?Q?3b3tGS0g/rEk88Ut4cpWqtEi3Nbqbf/ofg0tZTJGqSGZ3UyC1Nq0OyuTAeDP?=
 =?us-ascii?Q?lFfucDlIvHr74a9IwMnG3x3DSwjgaRPILMh7Je/sdbwUgqaXEXK3E+DrUyID?=
 =?us-ascii?Q?Y3Dvt/OfnTVMux3VL7ps2amZ10k9mrYtv2/ydxby+6lIgN5ta92GCabmCVNe?=
 =?us-ascii?Q?SBFuYTA1JsBhlc9XvGwiYzS33tbmueIhwu8Xs3j12SWTc+z4Eqi3Mct1bs8a?=
 =?us-ascii?Q?nlwckQZyx3H8jrT3AnTUulO4dFIwjWY6tfo+EtjyJ+7EIBEXrnx14acLR7Vr?=
 =?us-ascii?Q?p2V0SCAd7dfpYYRr4Wuk+sakUIrPY5ZyXC+//4rM5IH+msKFtnIBCM2qF4Ge?=
 =?us-ascii?Q?ni+6ViNs5F8cbkpy1+n0U0M4OYIZl54xkchk7SGDq9JnGa1ZPaas0KthEVOi?=
 =?us-ascii?Q?W8iYejgJ8tnQFkAZ8hBiPosi/Nd42yKFErcWO5HGz1qwn2QUgjQ5NJgyKX7g?=
 =?us-ascii?Q?s8Pxyep6z7FFbn/KBWNQaZAy6WsQIrNYYqdMip4oy/8IueWgFSunAtHchiNi?=
 =?us-ascii?Q?Yk+gGvYsbuJ2+qGJne24dBw7rkKbh9B8WM6VaAQdbbJUvg+unK7yA6gyRoeL?=
 =?us-ascii?Q?9sQGu5eE+vwNRChEM2vgmy4JhZOp1iwUbzCodYqmoJMvn4/Ph+uO0G5Ddm+K?=
 =?us-ascii?Q?kYqywO6X/ByYMtnL4dsDD+XX/fIl7N2kaQC6Lt46+clhSihwRgisZ5hoyz3M?=
 =?us-ascii?Q?ZE0Ub8qNbXJfJOcXY7aoS7vy+DK6dQXsS1nZ8flM/7sm+3+sP8/x0in9Mzlz?=
 =?us-ascii?Q?luOZ0ELlR7Az3uzdMCDZX7/JdhRhC8HIB3XDa3Pe6dMo4gk2nDeHjZ6KuJR9?=
 =?us-ascii?Q?qmFVciEYLF9sMcE7EQcilNgsY2lX+O424BhXPTe5SEdKWyQiXTqvalNI5tYx?=
 =?us-ascii?Q?efgt7cObcZdwx9rXN2cYRkOh2tTlkctqThVtgi5wnIpDeIH1sZbLBAyz6eqp?=
 =?us-ascii?Q?+SZ1EmcnARJcTrWXnJ2AdPtNUwOU9OQaK0Krrybr73rFKl8xFTnrgSM1xjvB?=
 =?us-ascii?Q?CGwe+bcVetotuv3C9k6zSeHfOEJ5JpXXKMDaD4zCXgB8cAzGK90/IzPViUsp?=
 =?us-ascii?Q?1wXj4p7LHsEvYePWQoc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bfb448-da2c-4796-bcca-08dc5fc04002
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 15:57:29.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLT6E62fos/4vC97WzLtFZSHVr1YtWsGHr8S2FisrUCyRSYdf5YlmRk5qc+O+7yA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

On Mon, Apr 15, 2024 at 09:26:40AM -0700, Kees Cook wrote:
> On Mon, Apr 15, 2024 at 10:35:21AM +0200, Greg KH wrote:
> > On Mon, Apr 15, 2024 at 01:07:41AM -0700, Christoph Hellwig wrote:
> > > No, this advice is wronger than wrong.  If you set panic_on_warn you
> > > get to keep the pieces.  
> > > 
> > 
> > But don't add new WARN() calls please, just properly clean up and handle
> > the error.  And any WARN() that userspace can trigger ends up triggering
> > syzbot reports which also is a major pain, even if you don't have
> > panic_on_warn enabled.
> 
> Here's what was more recently written on WARN:
> 
> https://docs.kernel.org/process/deprecated.html#bug-and-bug-on
> 
> Specifically:
> 
> - never use BUG*()
> - WARN*() should only be used for "expected to be unreachable" situations
> 
> This, then, maps correctly to panic_on_warn: System owners may have set
> the panic_on_warn sysctl, to make sure their systems do not continue
> running in the face of "unreachable" conditions.
> 
> As in, userspace should _never_ be able to reach a WARN(). If it can,
> either the logic leading to it needs to be fixed, or the WARN() needs to
> be changed to a pr_warn().

Exactly! No doubt there are mistakes, but we already document this too
a few lines above where this is touching:

 Do not WARN lightly
 *******************

 WARN*() is intended for unexpected, this-should-never-happen situations.
 WARN*() macros are not to be used for anything that is expected to happen
 during normal operation. These are not pre- or post-condition asserts, for
 example. Again: WARN*() must not be used for a condition that is expected
 to trigger easily, for example, by user space actions. pr_warn_once() is a
 possible alternative, if you need to notify the user of a problem.

Usages following that advice should be left alone and more should be
added. Invariant checks that indicate the kernel is malfunctioning are
desirable things to have!

Yes, by all means tell people to follow the above rules! But that
isn't a ban on WARN and shouldn't be communicated as "don't add new
WARN() calls please".

Let's all keep in mind that fuzzing reports are incredibly valuable to
make the kernel more secure and robust. We actually want *more*
invariants that indicate bugs for the fuzzers to trip up on!

As above, a correctly used WARN, should indicate a certain bug if it
triggers.

I'd guess about 30-40% of the syzkaller found bugs I've delt with are
from a correct use of WARN_ON not oops/kasn/etc. I wonder what a
datamine on the whole syzkaller database would indicate.

pr_warn/etc don't trigger fuzzer faults, and don't give a debugging
backtrace.

I also find it strange to want panic_on_warn to exist, and people want
to use it, while also saying that the WARN() calls that actually make
it do something and be valuable are forbidden :(

Jason

