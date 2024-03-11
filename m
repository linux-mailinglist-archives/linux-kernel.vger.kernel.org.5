Return-Path: <linux-kernel+bounces-99195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B798784B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48807B21014
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4B481C0;
	Mon, 11 Mar 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHVtjwLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145C3AC01
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173749; cv=none; b=oRSGkUW4kmTqv1UX0ED11ej26o6bw9wOrbLcn1Hg4e7l55GMiPsihmvSJPpEMU9BFgORYPhnWZTqNcOtXIyMKRaFFtru0AmMq7vzlraNKpPAXmw7uIQkHRni+uVdjTWGT1cCMCFMm5JPGit2u4VoOEhSVReDyuTbXj55V99oDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173749; c=relaxed/simple;
	bh=FiaMsB4YjZvOkuHyJ0lc36b2FtJ7u47S5pfvMXT2oBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKZqqvyrP0uSomuuVAhq8uVc4+w+pkwYK6Q91gRezN58vKTLUhsl6vK4iUgGOT54MjtHEJuEvRuXJrBZe9MkrKuyYXmvLBr5IcjbRWxuw+lKM78icE89CY7pD2EAG8oMY0DFBC+bZZIiwUrWNZW+jFgfKVbBl0aiTHcHIMA1jqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHVtjwLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F472C433C7;
	Mon, 11 Mar 2024 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710173748;
	bh=FiaMsB4YjZvOkuHyJ0lc36b2FtJ7u47S5pfvMXT2oBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHVtjwLDlqDfcNzWGphUV+T6/AF5pBJs1xaEKPRD8U05KOzll3dldIj1wim0l++qN
	 F3mk0JF+XtJtkE9LLoR8H2xpP3eWocJfctAEEg0n0t+UfIhn9PGV463CSCYE1gLaTx
	 P/jhpJ8BGhqLK0mffcHpCqkQT6wXVIrp8tUCCn84q+B2arcrjUgnehEMvE39E0GcWL
	 Aeir0l38uwkprkwQ/PuBH8vaLObXh7YIDC3R/cXQAnDrJJJa1KnmEX3M5S+owsICAj
	 Cdtvt76iy90/H2Q996bG/QQS/hE236HzRCwrljl2cqTaVNxE7xWPHdurRRcIRu0+zj
	 K3p1D5C8jgd3w==
Date: Mon, 11 Mar 2024 16:15:44 +0000
From: Lee Jones <lee@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Michal Hocko <mhocko@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: CVE-2023-52514: x86/reboot: VMCLEAR active VMCSes before
 emergency reboot
Message-ID: <20240311161544.GS86322@google.com>
References: <2024030251-CVE-2023-52514-c93d@gregkh>
 <Ze7d0YCDKdu_LJWc@tiehlicka>
 <20240311134202.GQ86322@google.com>
 <Ze8sTnE16lbYuX01@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze8sTnE16lbYuX01@google.com>

On Mon, 11 Mar 2024, Sean Christopherson wrote:

> On Mon, Mar 11, 2024, Lee Jones wrote:
> > On Mon, 11 Mar 2024, Michal Hocko wrote:
> > 
> > > On Sat 02-03-24 22:52:59, Greg KH wrote:
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > x86/reboot: VMCLEAR active VMCSes before emergency reboot
> > > > 
> > > > VMCLEAR active VMCSes before any emergency reboot, not just if the kernel
> > > > may kexec into a new kernel after a crash.  Per Intel's SDM, the VMX
> > > > architecture doesn't require the CPU to flush the VMCS cache on INIT.  If
> > > > an emergency reboot doesn't RESET CPUs, cached VMCSes could theoretically
> > > > be kept and only be written back to memory after the new kernel is booted,
> > > > i.e. could effectively corrupt memory after reboot.
> > > > 
> > > > Opportunistically remove the setting of the global pointer to NULL to make
> > > > checkpatch happy.
> > > > 
> > > > The Linux kernel CVE team has assigned CVE-2023-52514 to this issue.
> > > 
> > > I do not really see the security aspect of this fix. Guests systems
> > > shouldn't be able to trigger host reboot nor any untrusted entity should
> > > on the host either or this would be a serious security hole.
> 
> And not just any reboot either, this only comes into play with something like
> `reboot -f`.  Not to mention the impact of the bug is ridiculously theroetical
> (I didn't tag the patch for stable@ for a reason).
> 
> > > Or am I missing something?
> > 
> > Thanks for reporting.
> > 
> > If Sean and/or Paolo agree, we can revoke the CVE for you.
> 
> Please do.

No problem.  All done for you:

https://lore.kernel.org/all/20240311161318.1290374-2-lee@kernel.org/

Thanks again for the report.

-- 
Lee Jones [李琼斯]

