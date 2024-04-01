Return-Path: <linux-kernel+bounces-126788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8A893CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAC01F21578
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A119E46420;
	Mon,  1 Apr 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="GEwJij2p"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94F45974;
	Mon,  1 Apr 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984657; cv=none; b=IxuC76jOQm+kYJ/j1fQXZo0ujwz4ycE8tcXsJD+CZfytgAX+y3fIpkZBVQvqFBr4GPEZHDwD/poor6gpi1X1R62N+P/Ch6yeWmI09/M65rRgyLNuoPJceo0pCZwg9dP1tNdfSGXhfd3s7whOhLDUcduFonlThACMZS9pvAghrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984657; c=relaxed/simple;
	bh=oJmSsv5xGOhFtnk+Xic/LQeUyvu+FYl2RG6Gz/YH/qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTEhyjbq5NLQgfeS/N8zXJeDrOX5PJPie/HqWl7qI/hYXrTMVbeRVcMj7dEFJukw86uYPzWg962VcNMpKICMsAAaGe1z2hVmPJI3M6OlWCyARvQYryueNcEG/8CgXbC7CvDWFnLnzhu/Qra4HlxFcpqqK775GYfRsDbz4qKPCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=GEwJij2p; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431C2Qwp021586;
	Mon, 1 Apr 2024 15:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=BirW+UIBY1HR4YTM1gaQXYTvu6fujR94JXCjW3QUDQg=;
 b=GEwJij2p2LTOrxopReL8DU9Uy/7sy1wneW3c+CHkmpffhuqrxvIw0/uECwm9v7v14/FA
 bDcOq1fxAwFLH12Q4xpR9xznDMPXyNvSd5sZaSZuSJpRYXRvGcC6SJHDNA6AYBXDMhst
 Q0D/3o9wYgN0YWjmloPRfaSS4JHBoZAEEK0W0eolKTk2GqQmq+Jv7eTVrOsW6ImZYH26
 8s8S2q17mb/GsW3FgG4PWlm0hGTbia4mV53/2M26H1yw4ID8G7OZh7/tv+tOtbHwMG5L
 /rGKk/kBeXB008JuXMXNxL+iVo28sREMso0JBrgVex86XiCaLRbEkcHX9tKpzmrKegIF 3w== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3x7s8gauu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 15:16:26 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 63B281379E;
	Mon,  1 Apr 2024 15:16:15 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id EA89E80360A;
	Mon,  1 Apr 2024 15:15:59 +0000 (UTC)
Date: Mon, 1 Apr 2024 10:15:57 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Russ Anderson <rja@hpe.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
        Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <ZgrPrZqAXeq7e_wh@swahl-home.5wahls.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <ZgABC1oQ9YJW6Bw3@gmail.com>
 <20240325020334.GA10309@hpe.com>
 <87o7b273p2.fsf@email.froward.int.ebiederm.org>
 <ZgHTXvCQr6ycbVzp@swahl-home.5wahls.com>
 <87r0fv6ddb.fsf@email.froward.int.ebiederm.org>
 <ZgQ8Ej-MLlNJR6wn@swahl-home.5wahls.com>
 <87zfuj2bgh.fsf@email.froward.int.ebiederm.org>
 <ZgWO5I_p8zHyp3en@swahl-home.5wahls.com>
 <87msqf12sy.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msqf12sy.fsf@email.froward.int.ebiederm.org>
X-Proofpoint-ORIG-GUID: SldB7dXPKExcbOG7DIQQKbrxLxnGuLBX
X-Proofpoint-GUID: SldB7dXPKExcbOG7DIQQKbrxLxnGuLBX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010108

On Sat, Mar 30, 2024 at 10:46:21PM -0500, Eric W. Biederman wrote:
> Steve Wahl <steve.wahl@hpe.com> writes:
> 
> > On Thu, Mar 28, 2024 at 12:05:02AM -0500, Eric W. Biederman wrote:
> >> 
> >> From my perspective the entire reason for wanting to be fine grained and
> >> precise in the kernel memory map is because the UV systems don't have
> >> enough MTRRs.  So you have to depend upon the cache-ability attributes
> >> for specific addresses of memory coming from the page tables instead of
> >> from the MTRRs.
> >
> > It would be more accurate to say we depend upon the addresses not
> > being listed in the page tables at all.  We'd be OK with mapped but
> > not accessed, if it weren't for processor speculation.  There's no "no
> > access" setting within the existing MTRR definitions, though there may
> > be a setting that would rein in processor speculation enough to make
> > due.
> 
> The uncached setting and the write-combining settings that are used for
> I/O are required to disable speculation for any regions so marked.  Any
> reads or writes to a memory mapped I/O region can result in hardware
> with processing it as a command.  Which as I understand it is exactly
> the problem with UV systems.
> 
> Frankly not mapping an I/O region (in an identity mapped page table)
> instead of properly mapping it as it would need to be mapped for
> performing I/O seems like a bit of a bug.
> 
> >> If you had enough MTRRs more defining the page tables to be precisely
> >> what is necessary would be simply an exercise in reducing kernel
> >> performance, because it is more efficient in both page table size, and
> >> in TLB usage to use 1GB pages instead of whatever smaller pages you have
> >> to use for oddball regions.
> >> 
> >> For systems without enough MTRRs the small performance hit in paging
> >> performance is the necessary trade off.
> >> 
> >> At least that is my perspective.  Does that make sense?
> >
> > I think I'm begining to get your perspective.  From your point of
> > view, is kexec failing with "nogbpages" set a bug?  My point of view
> > is it likely is.  I think your view would say it isn't?
> 
> I would say it is a bug.
> 
> Part of the bug is someone yet again taking something simple that
> kexec is doing and reworking it to use generic code, then changing
> the generic code to do something different from what kexec needs
> and then being surprised that kexec stops working.
> 
> The interface kexec wants to provide to whatever is being loaded is not
> having to think about page tables until that software is up far enough
> to enable their own page tables.
> 
> People being clever and enabling just enough pages in the page  tables
> to work based upon the results of some buggy (they are always buggy some
> are just less so than others) boot up firmware is where I get concerned.
> 
> Said another way the point is to build an identity mapped page table.
> Skipping some parts of the physical<->virtual identity because we seem
> to think no one will use it is likely a bug.

Hmm.  I would think what's needed for kexec is to create, as nearly as
possible, identical conditions to what the BIOS / bootloader provides
when jumping to the kernel entry point.  Whatever agreements are set
on entry to the kernel, kexec needs to match.

And I think you want a completely identity mapped table to match those
entry point requirements, that's why on other platforms, the condition
is MMU turned off.

From that point of view, it does make sense to special case UV systems
for this.  The restricted areas we're talking about are not in the map
when the bootloader is started on the UV platform.

> I really don't see any point in putting holes in such a page table for
> any address below the highest address that is good for something.  Given
> that on some systems the MTRRs are insufficient to do there job it
> definitely makes sense to not enable caching on areas that we don't
> think are memory.

Well, on the UV platform, these addresses are *not* good for
something, at least from any processor's point of view, nor any IO
device (they are not allowed to appear in any DMA or PCI bus master
transaction, either).  A hardware ASIC is using this portion of local
RAM to hold some tables that are too large to put directly on the
ASIC.  Things turn ugly if anyone else tries to access these
addresses.

In another message, Pavin thanked you for you work on kexec.  I'd like
to express my appreciation also.  In my current job, I'm mostly
focused on its use for kdump kernels.  I've been dealing with kernel
crash dumps since running Unix on i386 machines, and always had do
deal with "OK, but what if the kernel state gets corrupt enough that
the disk driver won't work, or network if you're trying to do a remote
dump."  The use of kexec to start a fresh instance of the kernel is an
excelent way to solve that problem, in my opinion.  And a couple of
jobs ago we were able to use it to restart a SAN switch after software
upgrade, without needing to stop forwarding traffic, which wouldn't
have been possible without kexec.

Thanks,

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise

