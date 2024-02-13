Return-Path: <linux-kernel+bounces-63783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3B2853458
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C3BB21FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0283F5EE62;
	Tue, 13 Feb 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O82mdty/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EDD55780;
	Tue, 13 Feb 2024 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836982; cv=none; b=XW5/LH6luJsrs56Cj4yUFa1njktTAKXJoC3lnMK9RjfOoFD3vbxfCq+d7Z/ifAGyjwxKbMuG7+xnZZSDMXI/gOsswQMI5h7vAZpkGAwGEBwod/hCRdfq9RwkjK1D5K431qKc1YDhIyEheY6aKl4MFGLeDwP6gM80rx9wONieads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836982; c=relaxed/simple;
	bh=d/SbQewKw97qHMcT4YLu0I9/NAOZ0hdPBAZpUB60RQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFAmkPLlMI/qHkF9K4OjJop0hTU/Y5xZRuWLB+d3gW4ocxE0YsGIYZ5Sug55Z0HD+lXPlUbH7dwSqKdVnBRyrgUv28hb+Sun43un/u8soF4oAycvcFaJsprTH9f+vSG29aIPNDHKxu8R4xlIFAAEckJmjVYntWOsvdxTRDQPlwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O82mdty/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF90C433C7;
	Tue, 13 Feb 2024 15:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707836982;
	bh=d/SbQewKw97qHMcT4YLu0I9/NAOZ0hdPBAZpUB60RQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O82mdty/hIg37bZ628amycXSBelVC+v3pWEIaN4x4Aibw2Eo4LNZndhemHyVrEBCY
	 PJzD93+3rSjq3Po+k9RZLruxyiu6qvpwX9iHBbhM0caNj7akpWNiJ6MJ9X2lhPmkmh
	 zRGuXo1fIkHOifOJbS/fP3RntrJ30Qb3MMvdqxYc=
Date: Tue, 13 Feb 2024 16:09:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, David Laight <David.Laight@aculab.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] linux-6.6.y, minmax: virtual memory exhausted in
 i586 chroot during kernel compilation
Message-ID: <2024021327-granular-boogieman-de5e@gregkh>
References: <f9f89284-0f48-4971-ad8d-86938a82fafc@leemhuis.info>
 <2024021318-shifty-daybed-fca8@gregkh>
 <699726f6-8f5d-4482-8c27-8ea47a483f8a@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699726f6-8f5d-4482-8c27-8ea47a483f8a@leemhuis.info>

On Tue, Feb 13, 2024 at 04:01:23PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 13.02.24 15:50, Greg KH wrote:
> > On Mon, Feb 12, 2024 at 05:16:58PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>
> >> I noticed a regression report in bugzilla.kernel.org that seems to be
> >> specific to the linux-6.6.y series:
> >>
> >> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218484 :
> >>
> >>> After upgrading to version 6.6.16, the kernel compilation on a i586
> >>> arch (on a 32bit chroot in a 64bit host) fails with a message:
> >>>
> >>> virtual memory exhausted: Cannot allocate memory
> >>>
> >>> this happens even lowering the number of parallel compilation
> >>> threads. On a x86_64 arch the same problem doesn't occur. It's not
> >>> clear whether some weird recursion is triggered that exhausts the
> >>> memory, but it seems that the problem is caused by the patchset
> >>> 'minmax' added to the 6.6.16 version, in particular it seems caused
> >>> by these patches:
> >>>
> >>> - minmax-allow-min-max-clamp-if-the-arguments-have-the-same-signedness.patch
> >>> - minmax-fix-indentation-of-__cmp_once-and-__clamp_once.patch
> >>> - minmax-allow-comparisons-of-int-against-unsigned-char-short.patch
> >>> - minmax-relax-check-to-allow-comparison-between-unsigned-arguments-and-signed-constants.patch
> >>>
> >>> Reverting those patches fixes the memory exhaustion problem during compilation.
> >>
> >> The reporter later added:
> >>
> >>> From a quick test the same problem doesn't occur in 6.8-rc4.
> >> See the ticket for more details.
> >
> > I think this was already fixed in 6.7 or Linus's tree, but I can't seem
> > to find the commit at the moment.
> 
> I thought so as well, but was in the same situation. But your comment
> made me look again and now I found it: that was 31e97d7c9ae3de ("media:
> solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)"), which indeed is
> not yet in 6.6.y.

Yes, that's the one, thanks!

I've queued it up now.

greg k-h

