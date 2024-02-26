Return-Path: <linux-kernel+bounces-81873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59882867B43
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5E12892E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1312C553;
	Mon, 26 Feb 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xdo2Rm4v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CFD12BF1C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963942; cv=none; b=II+k8b2r58G34MIvvEmFENI8DhHzh+OlplqVVTfncmKlfZc1QSkvXS8b94QUqeBntquOPbMAeFfifkJDMyDtclnm7nqp8OlHi1aGqPEMVggNOul0l/vWQRLKVI6/qEtDWSkmEel0GrQuKfakQjAJccEv/7LjHdqft6/GLlcB8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963942; c=relaxed/simple;
	bh=ExcOlxxD1FEHgyOdbKFwYGAt8XNYsDupzatENSCfXDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN1bM8LReQEJLq9czSRClUA53dWCBNQcITnz8V1NeVTzQGd1YSocK91Kt5jQPrtmi6cQC4eprciihxkUqn0FOelubgjWYC+G23bvz6thhGYaypRuErBh3V2eVZz6O7buX+nI/i29ceZDotl3pvljfta/5ml03ocxqXp7VRhsaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xdo2Rm4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CE4C433C7;
	Mon, 26 Feb 2024 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708963941;
	bh=ExcOlxxD1FEHgyOdbKFwYGAt8XNYsDupzatENSCfXDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xdo2Rm4vy7+7SO1RGtVXcdCqXwgxhB7ciDLQzf0r5LgRZO1AKHam7h3ibl37tb6VF
	 kRSNpVXDI5WxW7aFHRmQ0AH0zPrO1j/0LUnBB5bh8nNROdYklr2FxDuGcSosSQwSBV
	 sys57+H/6XzsoDHt+W7u/hROM/+pdhOg7vuieu2I=
Date: Mon, 26 Feb 2024 17:12:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <2024022652-defective-fretful-3d13@gregkh>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdytVTOgfvKBBvtn@tiehlicka>

On Mon, Feb 26, 2024 at 04:25:09PM +0100, Michal Hocko wrote:
> On Mon 26-02-24 16:06:51, Greg KH wrote:
> > On Mon, Feb 26, 2024 at 03:52:11PM +0100, Michal Hocko wrote:
> > > On Thu 22-02-24 17:21:58, Greg KH wrote:
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > powerpc/pseries/memhp: Fix access beyond end of drmem array
> > > > 
> > > > dlpar_memory_remove_by_index() may access beyond the bounds of the
> > > > drmem lmb array when the LMB lookup fails to match an entry with the
> > > > given DRC index. When the search fails, the cursor is left pointing to
> > > > &drmem_info->lmbs[drmem_info->n_lmbs], which is one element past the
> > > > last valid entry in the array. The debug message at the end of the
> > > > function then dereferences this pointer:
> > > > 
> > > >         pr_debug("Failed to hot-remove memory at %llx\n",
> > > >                  lmb->base_addr);
> > > 
> > > While this is a reasonable fix and the stable material it is really
> > > unclear to me why it has gained a CVE. Memory hotplug is a privileged
> > > operation. Could you clarify please?
> > 
> > As you know, history has shown us that accessing out of your allocated
> > memory can cause problems, and we can not assume use-cases, as we don't
> > know how everyone uses our codebase, so marking places where we fix
> > out-of-bound memory accesses is resolving a weakness in the codebase,
> > hence a CVE assignment.
> 
> Does that mean that any potentially incorrect input provided by an admin is
> considered CVE now? I guess we would need to ban interfaces like
> /dev/mem and many others.

If you have your system set up to prevent admins from accessing /dev/mem
(isn't there a config option for that), and you can access it, then yes,
that would be a CVE-worthy issue.

But if you configure your system to allow an admin access to /dev/mem
then you wanted that :)

> > If your systems are not vulnerable to this specific issue, wonderful, no
> > need to take it, but why wouldn't you want to take a fix that resolves a
> > known weakness?
> 
> I have explicitly said, the fix is reasonable. I just do not see a point
> to mark it as CVE. I fail to see any thread model where this would
> matter as it would require untrusted privileged actor to trigger it
> AFAICS. I am happy to be proven wrong here.

We can not determine threat models when filing CVEs as we do not know
what your threat model is.  All we can do is determine if this resolves
a weakness in the system.  A use-after-free is a weakness and this
resolves that issue.

It is up to others to "grade" the CVEs if they want to.  There are loads
of other orginizations that do that type of thing, taking into
consideration specific threat models by which they wish to enforce.  If
your orginization thinks this is not relevent to your threat model at
all, wonderful, you can ignore it :)

thanks,

greg k-h

