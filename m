Return-Path: <linux-kernel+bounces-82716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F370786888A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83EC4B23349
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5152F7C;
	Tue, 27 Feb 2024 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v5RPXDlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999D0524BB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010888; cv=none; b=hGXGuCjnTuJNjpkweilw5DA9Wu69tt4ND6j0uNcFiwvSYkg/VwuYqzeQhaSceKu+MMaRKvBCSS7OmfIhI24l7Db6EzSEOinuBgAsM1dmsvNVSR1tuo2nRDCKj6S2KdtIGAhU+NUEQPgLVnhDhFUoontUhO4f/gHY5DJW4VfHf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010888; c=relaxed/simple;
	bh=9ug22FuSGdCqHLfKK1jLGa5UY1EagxrgLC31lpxI5NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmXrA79guj7XpN/XTGyueNBiXOWJ0N8p+u/90LE/F1SlIiIvZ+SSNttEC/Eo9TRUdKVQHqNlFVdMYF07pPqGa1yIJU5Emg2TMKo4yfY0p6q3DigA+Q6uyd6keO+/WNNnlUtK1+lTv1kdZxra5gNsvBMk80anWk+gkBeRZ94i9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v5RPXDlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACBAC433F1;
	Tue, 27 Feb 2024 05:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709010888;
	bh=9ug22FuSGdCqHLfKK1jLGa5UY1EagxrgLC31lpxI5NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v5RPXDlA3GFP4rtthRPk4+rLOyzBtsjWMB2wPps8K0Q8tqv3lGT1dQJFus5qfaskX
	 jT6Z0PmcDiVG1phTZs+bAR2pKITf5ZiY5FB8KfUosglsH7sth8djTs5K4IZc5p3f2p
	 il2INF3XKh0pGC5LMRHdGnKz9tfS8UaxKnTNbydQ=
Date: Tue, 27 Feb 2024 06:14:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <2024022750-treble-wish-b009@gregkh>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <2024022652-defective-fretful-3d13@gregkh>
 <Zdy-KbmSt0egNV3c@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdy-KbmSt0egNV3c@tiehlicka>

On Mon, Feb 26, 2024 at 05:36:57PM +0100, Michal Hocko wrote:
> On Mon 26-02-24 17:12:19, Greg KH wrote:
> > On Mon, Feb 26, 2024 at 04:25:09PM +0100, Michal Hocko wrote:
> > > On Mon 26-02-24 16:06:51, Greg KH wrote:
> > > > On Mon, Feb 26, 2024 at 03:52:11PM +0100, Michal Hocko wrote:
> > > > > On Thu 22-02-24 17:21:58, Greg KH wrote:
> > > > > > Description
> > > > > > ===========
> > > > > > 
> > > > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > > > 
> > > > > > powerpc/pseries/memhp: Fix access beyond end of drmem array
> > > > > > 
> > > > > > dlpar_memory_remove_by_index() may access beyond the bounds of the
> > > > > > drmem lmb array when the LMB lookup fails to match an entry with the
> > > > > > given DRC index. When the search fails, the cursor is left pointing to
> > > > > > &drmem_info->lmbs[drmem_info->n_lmbs], which is one element past the
> > > > > > last valid entry in the array. The debug message at the end of the
> > > > > > function then dereferences this pointer:
> > > > > > 
> > > > > >         pr_debug("Failed to hot-remove memory at %llx\n",
> > > > > >                  lmb->base_addr);
> > > > > 
> > > > > While this is a reasonable fix and the stable material it is really
> > > > > unclear to me why it has gained a CVE. Memory hotplug is a privileged
> > > > > operation. Could you clarify please?
> > > > 
> > > > As you know, history has shown us that accessing out of your allocated
> > > > memory can cause problems, and we can not assume use-cases, as we don't
> > > > know how everyone uses our codebase, so marking places where we fix
> > > > out-of-bound memory accesses is resolving a weakness in the codebase,
> > > > hence a CVE assignment.
> > > 
> > > Does that mean that any potentially incorrect input provided by an admin is
> > > considered CVE now? I guess we would need to ban interfaces like
> > > /dev/mem and many others.
> > 
> > If you have your system set up to prevent admins from accessing /dev/mem
> > (isn't there a config option for that), and you can access it, then yes,
> > that would be a CVE-worthy issue.
> > 
> > But if you configure your system to allow an admin access to /dev/mem
> > then you wanted that :)
> 
> OK, I thought we are having a serious discussion here. Now I am not
> really sure about that.

I am serious, sorry if that came across as not.

> > > > If your systems are not vulnerable to this specific issue, wonderful, no
> > > > need to take it, but why wouldn't you want to take a fix that resolves a
> > > > known weakness?
> > > 
> > > I have explicitly said, the fix is reasonable. I just do not see a point
> > > to mark it as CVE. I fail to see any thread model where this would
> > > matter as it would require untrusted privileged actor to trigger it
> > > AFAICS. I am happy to be proven wrong here.
> > 
> > We can not determine threat models when filing CVEs as we do not know
> > what your threat model is.  All we can do is determine if this resolves
> > a weakness in the system.  A use-after-free is a weakness and this
> > resolves that issue.
> 
> Sure, you cannot make any assumptions and nobody questions that. We do
> have a certain common sense though. And if somebody comes up with a
> usecase that we haven't anticipated then we can surely assign a CVE.
> I though that level of control is exactly the reason to own the process
> by the community.
> 
> All that being said I dispute the issue fixed here has any more security
> relevance than allowing untrusted user to control memory hotplug which
> could easily result in DoS of the system.

Ok, I traced this call back, and here is the callpath, starting with a
write to the the 'dlpar' sysfs file (conviently NOT documented in
Documentation/ABI, and it looks like it violates the "one value per
file" rule...)
	dlpar_store()
	handle_dlpar_errorlog()
	dlpar_memory()
	dlpar_memory_remove_by_index()

Yes, the kernel by default sets 'dlpar' to 0644, BUT that means that
root in a container can cause this use-after-free to happen, or if the
permissions are changed by userspace, or if you are in "lockdown mode",
or if you want to attempt the crazy "confidential computing" model, or
if you have a system which root is possible for some things by normal
users (there are lots of different security models out there...)

Yes, I will argue that making the sysfs file writable by userspace is
out of our control, but what is in our control is the fact that there is
a out-of-bounds write that is fixed here, and we don't want those to be
able to be triggered by anyone as that is a weakness in our codebase.
That is what has caused the CVE to be created here, not the fact that
root can remove memory as that's the normal expected operation to have
happen here.

However if the maintainer of the code here disputes this, we are more
than willing to mark this invalid and reject the CVE.

thanks,

greg k-h

