Return-Path: <linux-kernel+bounces-123161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B520890349
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BCF1F2450A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F3912FF7F;
	Thu, 28 Mar 2024 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="i4C5/FOG"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14832C92;
	Thu, 28 Mar 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640369; cv=none; b=nUYfesDM9CKd/KQRkYqfFslwZgVwhxPBSA063LRDNQwU+bsqxDNI8IGZx+aoM9xAIHnDWrl+bi58hmaO1LvOaEuPlf9EKpLBEIPF1ktJbFH70lDJeyQWzP8kbOXXGgsmvS/wswEaAGHZqe8nRINwQ7mlm3Wr4wxaDWUni0PlNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640369; c=relaxed/simple;
	bh=pj6KY+ffCx0OGPhHnK4DS0F4tyKtiHO1xiqXRApRKLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAdKFyVg0pUa0x+Pm9kGSZG0u6s9KNXryaAga6xiuQ4Bd1vvCglfiNtm1VL/cE8yc+YeqattEofUCNtXWPDGOtFuIsrjIvgo365B5qnDqZBOZDwdFqnQwzNkzSGW76+GZ3Tsp1xD481DJw5V4YFKj2n3v/rg+wWU9qKjrb6SER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=i4C5/FOG; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SEdwM3015674;
	Thu, 28 Mar 2024 15:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=DMdY5sI6S9Ul4Hkrd4mbScpmcltFaJYK/4aNgPC2fG8=;
 b=i4C5/FOGAp5nwyfXGTYVbp+2xogJZogNkviEI7f7WFy8zCN9YzbCYwdjcwaziaONuQaR
 BUBYndeMu+wTfZ+K2gI4t+BaGxO97lHH8iYPmBknz0gLujZfrM4a5mG37EbDjtBj0MA1
 pqln6igoH4492PuXRdDKV0GaYYQzcsGDQ8x1Xn0i4NW991jjXOXfyPHW5TYX99SOrCmk
 PotXuLQeP4YNu+fHN88cdJ1KqlLB9gGcWplCrhA2+CjADMdLRaaSakrMgzpFrkyuHbSU
 QzAKNS1/aWD3p5z4QRyOGtVkXYANvouzyQDpYDHDOukGc71jmf5VUZ2MUX14eTggPC3h tA== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x555kuce8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:38:20 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 28EA813044;
	Thu, 28 Mar 2024 15:38:19 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id E6AB4803628;
	Thu, 28 Mar 2024 15:38:14 +0000 (UTC)
Date: Thu, 28 Mar 2024 10:38:12 -0500
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
Message-ID: <ZgWO5I_p8zHyp3en@swahl-home.5wahls.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <ZgABC1oQ9YJW6Bw3@gmail.com>
 <20240325020334.GA10309@hpe.com>
 <87o7b273p2.fsf@email.froward.int.ebiederm.org>
 <ZgHTXvCQr6ycbVzp@swahl-home.5wahls.com>
 <87r0fv6ddb.fsf@email.froward.int.ebiederm.org>
 <ZgQ8Ej-MLlNJR6wn@swahl-home.5wahls.com>
 <87zfuj2bgh.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfuj2bgh.fsf@email.froward.int.ebiederm.org>
X-Proofpoint-GUID: 9ndDWdYWzTvMrXD1kcDo9f8gCLUl5cus
X-Proofpoint-ORIG-GUID: 9ndDWdYWzTvMrXD1kcDo9f8gCLUl5cus
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403280108

On Thu, Mar 28, 2024 at 12:05:02AM -0500, Eric W. Biederman wrote:
> Steve Wahl <steve.wahl@hpe.com> writes:
> 
> > On Wed, Mar 27, 2024 at 07:57:52AM -0500, Eric W. Biederman wrote:
> >> Steve Wahl <steve.wahl@hpe.com> writes:
> >> 
> >> > On Mon, Mar 25, 2024 at 10:04:41AM -0500, Eric W. Biederman wrote:
> >> >> Russ Anderson <rja@hpe.com> writes:
> >> >> > Steve can certainly merge his two patches and resubmit, to replace the
> >> >> > reverted original patch.  He should be on in the morning to speak for
> >> >> > himself.
> >> >> 
> >> >> I am going to push back and suggest that this is perhaps a bug in the
> >> >> HPE UV systems firmware not setting up the cpus memory type range
> >> >> registers correctly.
> >> >> 
> >> >> Unless those systems are using new fangled cpus that don't have 16bit
> >> >> and 32bit support, and don't implement memory type range registers,
> >> >> I don't see how something that only affects HPE UV systems could be
> >> >> anything except an HPE UV specific bug.
> >> >
> >> > Eric,
> >> >
> >> > I took the time to communicate with others in the company who know
> >> > this stuff better than I do before replying on this.
> >> >
> >> > One of the problems with using the MTRRs for this is that there are
> >> > simply not enough of them.  The MTRRs size/alignment requirements mean
> >> > that more than one entry would be required per reserved region, and we
> >> > need one reserved region per socket on systems that currently can go
> >> > up to 32 sockets.  (In case you would think to ask, the reserved
> >> > regions also cannot be made contiguous.)
> >> >
> >> > So MTRRs will not work to keep speculation out of our reserved memory
> >> > regions.
> >> >
> >> > Let me know if you need more information from us on this.
> >> 
> >> Thanks for this.
> >> 
> >> Do you know if there are enough MTRRs for the first 4GB?
> >
> > I don't personally know all the details of how BIOS chooses to place
> > things, but I suspect that might be true.  The restricted spaces
> > usually end up at the end of the address range for a particular node,
> > and 4GB would be in the early part of node 0.  If the conversation
> > develops further along these lines, I can find out more definitively.
> >
> >> I am curious if kexec should even consider going into 32bit mode without
> >> page tables or even into 16bit mode on such a system.  Or if such a
> >> system will always require using page tables.
> >
> > Unless I'm mistaken, wouldn't that put a pretty heavy restriction on
> > where the kdump kernel could be located?
> 
> If you are coming from 64bit EFI it adds restrictions.

We are.  :-)

> Most of my experience involves systems using a real mode BIOS and
> folks thought I was strange for wanting to be able to load the kernel
> above 4GB.
> 
> Having that experience, I am stuck wondering how all of the weird
> backwards compatibility cases are going to work. Hmm.
> 
> There is one concrete case where it matters that I think still exists.
> 
> x86_64 processors startup in 16bit real mode, then have to transition
> through 32bit protected mode, before transitioning to 64bit protected
> mode.  Only in 64bit protected mode are page tables enabled.
> 
> All this happens during early kernel startup when the bootstrap
> processor sends STARTUP IPIs to all of the secondary processors.
> 
> The startup IPI lets you pick where in the first 1MiB the secondary
> processors will start.
> 
> Assuming there isn't a new processor startup sequence on your cpus
> speculation before the processor loads it's first page table is a
> legitimate concern.

I believe the reserved memory that is problematic is at the end of
each socket's (NUMA node's) address space.  You have to get to 64 bit
execution before you can reach addresses outside of the first 4GB of
space I think.  External hardware uses this RAM, the processors are
not to access it at all.  MTRRs don't exactly have a entry type to
match this, at least from the document skimming I've done. (I have a
limited understanding, but I think this reserved space is used by our
hardware to keep track of cache line ownership for the rest of the
ram, so letting any other entity take even a read claim on these
addresses is a problem, in a catch-22 or circular reference sort of
way.)

> > Or the target region for KASLR?
> 
> As I recall the kernel is limited to the last 2GB of the virtual
> address space, as parts of the instruction 

From what I recall, KASLR varies both the virtual an physical addresses,
and it's the physical that's of concern here.

arch/x86/boot/compressed/kaslr.c: "In theory, KASLR can put the kernel
anywhere in the range of [16M, MAXMEM) on 64-bit..."

I had to make a change in that area a few years ago for similar
reasons:

1869dbe87cb94d  x86/boot/64: Round memory hole size up to next PMD page

> >> If you don't have enough MTRRs on a big NUMA system I think it is
> >> perfectly understandable, to need to use the page tables.
> >> 
> >> Please include this the fact that splitting GBpages is necessary because
> >> of a lack of MTRRs in the change description.
> >
> > OK.
> >
> >> Given that it is the lack of MTRRs on a large NUMA system that make the
> >> change necessary.   The goes from a pure bug fix change to a change to
> >> accommodate systems without enough MTRRs.
> >> 
> >> That information makes it more understandable why older systems (at
> >> least in the case of kexec) might not be ok with the change.  As for
> >> older systems their MTRRs are sufficient and thus they can use fewer
> >> page table entries.  Allowing for use of larger TLB entries.
> >
> > That last paragraph doesn't match what I think is happening.
> >
> > At least from my point of view, that some systems aren't OK with the
> > change has nothing to do with MTRRs or TLB page size.  They simply
> > require the extra "slop" of GB pages, implicitly adding a full GB of
> > space around any smaller space requested by map_acpi_tables().
> >
> > The systems that failed with my original change also failed on earlier
> > kernels when nogbpages was added to the kernel command line.  That
> > creates the identity map using 2M pages for everything, with no GB
> > page "slop".   I'm pretty sure these systems will continue to fail with
> > "nogbpages" enabled.
> >
> > For one debug-kernel cycle on Pavin's system I added in hard-coded
> > requests to explicitly add back in the areas that not being sloppy had
> > excluded, and that brought kexec back to functioning; which further
> > proves my point.  
> >
> > I wanted to be sure you understood this in case it has any effect on
> > what you think should be done.
> 
> Sort of.
> 
> What kexec wants of an identity mapped page table really is to simulate
> disabling paging altogether.  There isn't enough memory in most systems
> to identity map the entire 48bit or 52bit physical address space so some
> compromises have to be made.  I seem to recall only mapping up to
> maxpfn, and using 1GB pages when I originally wrote the code.  It was
> later refactored to share the identity map page table building code with
> the rest of the kernel.
> 
> When you changed the page tables not to map everything, strictly
> speaking you created an ABI break of the kexec ABI.
> 
> Which is a long way of saying it isn't being sloppy it is deliberate,
> and that the problem from my perspective is that things have become too
> fine grained, too optimized.
> 
> Pavin's definitely proves the issue was not mapping enough pages, it is
> nice that we have that confirmation.
> 
> From my perspective the entire reason for wanting to be fine grained and
> precise in the kernel memory map is because the UV systems don't have
> enough MTRRs.  So you have to depend upon the cache-ability attributes
> for specific addresses of memory coming from the page tables instead of
> from the MTRRs.

It would be more accurate to say we depend upon the addresses not
being listed in the page tables at all.  We'd be OK with mapped but
not accessed, if it weren't for processor speculation.  There's no "no
access" setting within the existing MTRR definitions, though there may
be a setting that would rein in processor speculation enough to make
due.

> If you had enough MTRRs more defining the page tables to be precisely
> what is necessary would be simply an exercise in reducing kernel
> performance, because it is more efficient in both page table size, and
> in TLB usage to use 1GB pages instead of whatever smaller pages you have
> to use for oddball regions.
> 
> For systems without enough MTRRs the small performance hit in paging
> performance is the necessary trade off.
> 
> At least that is my perspective.  Does that make sense?

I think I'm begining to get your perspective.  From your point of
view, is kexec failing with "nogbpages" set a bug?  My point of view
is it likely is.  I think your view would say it isn't?

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

