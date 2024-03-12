Return-Path: <linux-kernel+bounces-100626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10431879AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93291B22186
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65061386D9;
	Tue, 12 Mar 2024 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HPba/kW7"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD41386C5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266652; cv=none; b=K3dOce0W0oqzS4hzT4uY4mt4otkyORKYnjMtkZjfiMlh1WPJZX6Prw3rs0vBNmXg5RaGeGDMb1IKMhwMQSmMZu5SkXSFXOF+wIPCxsU0nYaZUUBU07COGSudyViBczXSMdF77LjxAQ8c3ET26SInYY9OC6tOOahMRDMP0aPAHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266652; c=relaxed/simple;
	bh=VClP0cN2QUMlvYkmVebFXGy+sO8rF6yXMKxzDT2+OIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO0FBUBxnwaeqOizasVGisJQLbhzVkL4OddJG2YbvPMBK5dEf1nq+wl7ZPo3xbxb+aAxs5TuYkt8b6xX8VNlB3WfplnmAER/RFrPX5dDS1C791FvRt6DlDccViRRduyRJ7uNeMqODPcWSZtmJ7DikywgMTjwheDz7K5QEDSAcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HPba/kW7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l9BkDiTDTN4Ez0UwJxL2yXwhyy26CV45Z6H2eGThHSE=; b=HPba/kW79bVSH+uTlz2Jl9XCPo
	SZ/+LWoFtS7FEjXiVnUKR+APwxAio6ByPV95NmbIkVqv+YoUtB7Y6j0v/T7VwUisnszmiC3cInMxb
	n8d4yg0nFXUY8kFJylH3fD9Vrv4W/zGO8jXyMhBafy/81TRTZPW33w75trF1yFyuXcz2Cq+EZ1Rxj
	ROjZp0YMmSp1HZOom6GryIW7u+u5RGLnBhhHrGfcwxTSDkLg4Ub7d1Y6s/rmNbyeqVvY/lPy32B65
	f6v4YdieARkC3+erOlioxVVoFgSL/0LgF0U3jneyc1cJgwgqADDCnF/HnxSFaJ46n9DijN88XTR8F
	ggTAKXwQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk6Tx-00000006xrQ-1HRG;
	Tue, 12 Mar 2024 18:04:09 +0000
Date: Tue, 12 Mar 2024 11:04:09 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Lee Jones <lee@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: Michal Hocko <mhocko@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <ZfCZGevmDe149QeX@bombadil.infradead.org>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
 <Ze68r7_aTn6Vjbpj@tiehlicka>
 <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
 <20240312091730.GU86322@google.com>
 <ZfAkOFAV15BDMU7F@tiehlicka>
 <ZfBwuDyzLl5M0mhC@bombadil.infradead.org>
 <20240312154910.GC1522089@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312154910.GC1522089@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

+ Kees,

On Tue, Mar 12, 2024 at 03:49:10PM +0000, Lee Jones wrote:
> On Tue, 12 Mar 2024, Luis Chamberlain wrote:
> 
> > On Tue, Mar 12, 2024 at 10:45:28AM +0100, Michal Hocko wrote:
> > > On Tue 12-03-24 09:17:30, Lee Jones wrote:
> > > [...]
> > > > > Backporting this is fine, but wouldn't fix an issue unless an external
> > > > > module had empty sysctls. And exploiting this is not possible unless
> > > > > you purposely build an external module which could end up with empty
> > > > > sysctls.
> > > 
> > > Thanks for the clarification Luis!
> > > 
> > > > Thanks for the amazing explanation Luis.
> > > > 
> > > > If I'm reading this correctly, an issue does exist, but an attacker
> > > > would have to lay some foundations before it could be triggered.  Sounds
> > > > like loading of a malicious or naive module would be enough.
> > > 
> > > If the bar is set as high as a kernel module to create and empty sysctl
> > > directory then I think it is safe to say that the security aspect is
> > > mostly moot. There are much simpler ways to attack the system if you are
> > > able to load a kernel module.
> > 
> > Indeed, a simple BUG_ON(1) on external modules cannot possible be a
> > source of a CVE. And so this becomes BUG_ON(when_sysctl_empty()) where
> 
> Issues that are capable of crashing the kernel in any way, including
> with WARN() or BUG() are being considered weaknesses and presently get
> CVEs.

Its not possible to crash any released kernel with the out of bounds issue
today, the commit is just a fix for a future world with empty sysctls
which just don't exist today.

Yes you can crash an external module with an empty sysctl on kernels
without that commit, but an empty sysctl is not common practice for
external modules, they'd have to have custom #ifdefs embedded as noted
earlier with the example crash. So your average external module should
not be able to crash existing kernels. The scope of a crash then would
be external modules that used older kernels without the fix starting after
v6.6. Since the fix is already meged on v6.6+ the scope of possible
kernels is small, and you'd need a specially crafted sysctl empty array
to do so.

> > when_sysctl_empty() is hypotethical and I think the source of this
> > question for CVE. Today's that not at boot time or dynamically with
> > any linux kernel sources released, and so its only possible if:
> > 
> >   a) As Joel indicated if you backported an empty sysctl array (which
> >   would be unless you carried all the infrastructure to support it).
> > 
> >   b) an external module has an empty sysctl
> 
> So what we're discussing here is weather this situation is
> _possible_, however unlikely.

I tried my best to summarize that world as we see it above.

> You are the maintainer here, so the final decision is yours.  If you say
> this situation is impossible and the CVE should be revoked, I'll go
> ahead and do just that.

To the best of our ability, from our perspective, upon our review, the
only way to trigger a crash would be with sysctls on external modules
loaded on these kernels:

 * v6.6 up to v6.6.15 (v6.6.16 has the fix backported) so 16 releases
 * v6.7 up to v6.7.3  (v6.7.4 has the fix backported) so 4 releases

External modules having empty sysctls should be rare, however possible.
So these 20 release would be affected by a crash with specially crafted
external modules. I suppose one way to exploit this, might be for a
vendor providing an external safe-looking module with #ifdefs which make
a sysctl seem non-empty but in reality it would be. That issue would
exist for 20 kernel releases. Could someone craft something with the out
of bounds access given the context to do something evil? Your domain of
expertise, your call, not ours.

  Luis

