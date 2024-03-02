Return-Path: <linux-kernel+bounces-89474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA55686F0D6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51911C2103E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C06618624;
	Sat,  2 Mar 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q7Fufu8d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7881802E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709392961; cv=none; b=c9I4ArYV5LumuKsKk1kA1OMPBkGop5V9IYzxNGLNU2EJIvocBynNZKjOi+OHDHUEGfMRIsW0HtfYgUcPli3HHovjtDF08dRY1qBr+0cFGGfi7XRq3XDC5FM06I6HsA/d9/dv9+J9qDlSiQHm1r6+9aO+4sPgpbZJOP5vPlHMzm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709392961; c=relaxed/simple;
	bh=XgZJnR/s4jIIVsjWgDcof7vuUf4n5SImnkYL1+d2+jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwpxQ54elhVG8iQ/wEzXfJpT3GmoOxa5hPy3GeFOegOQpUqyW91TS31NHt/8Qda7hImoamWtyyvWv6I22emE7afPdmrQT2GPGpY4t/CoYK4P5NbVRgC5GE6XJ8n767SPEfE+6ENaQFLVpb/YznKUsHDUaMQLPnZTqYoK/JN4wG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q7Fufu8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE9AC433F1;
	Sat,  2 Mar 2024 15:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709392960;
	bh=XgZJnR/s4jIIVsjWgDcof7vuUf4n5SImnkYL1+d2+jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q7Fufu8dkbuedWBWUXZQQPV91LbjQ98FCxWjz0YvP/8OJw/HBjruYo9gIShFJiiou
	 9moenPffXyDCo/Ry8QZtk3C/g+t6S8vwrr1s6B/wAVIX1aT5X0dbfJDNTV3Yzuq3ib
	 2cURGG0QPzoAo0fKmuk67c4Dczan/Db3+FyTztVo=
Date: Sat, 2 Mar 2024 16:22:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Mark Brown <broonie@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: x86 boot issues in -next
Message-ID: <2024030222-cognitive-algebra-c298@gregkh>
References: <05a45cc8-e0fc-422e-80d2-596ed63202a3@sirena.org.uk>
 <71f9b0b7-190f-453c-b55b-c842db4a825d@intel.com>
 <65e254047fbce_2bce9294cf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e254047fbce_2bce9294cf@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Mar 01, 2024 at 02:17:40PM -0800, Dan Williams wrote:
> [ add Greg ]
> 
> Dave Hansen wrote:
> > On 3/1/24 13:29, Mark Brown wrote:
> > > For the past few days -next has been failing to boot an x86_64 defconfig
> > > on the x86 machine Linaro has available in their lab.  DMI says it's a
> > > "Dell Inc. PowerEdge R200/0TY019, BIOS 1.4.3 05/15/2009" and the CPU is
> > > described as "Intel(R) Xeon(R) CPU X3220  @ 2.40GHz (family: 0x6, model:
> > > 0xf, stepping: 0xb)", it's running happily with mainline and
> > > pending-fixes.
> > 
> > This wouldn't explain the bisect results, but there's been a crash fixed
> > in here:
> > 
> > > https://lore.kernel.org/all/170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com/
> > 
> > that looks pretty similar to your signature.
> > 
> > Could you give Dan's patch a shot?
> > 
> 
> Hey Greg, this indeed looks like something that will be fixed when you
> update driver-core-next.
> 
> http://lore.kernel.org/r/2024022342-unbroken-september-e58d@gregkh

Ick, I forgot to push out my local tree, sorry about that!

Now done.

greg k-h

