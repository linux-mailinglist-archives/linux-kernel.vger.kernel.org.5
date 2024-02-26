Return-Path: <linux-kernel+bounces-80579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27138669E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B351F22292
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6D1BC31;
	Mon, 26 Feb 2024 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="knBtwZzL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2A1A5AC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927636; cv=none; b=TEAcG4T+qRYkD5GEztUGReks/wU5WdUmuMPbFgiQaL0eU90YjSVpZN3yfiJaazow37I5Ans3G4vO8gXy9MDL/5UEA8C526XVxxh5XqmlwsfciiT467ql0b50fBn8pb3DrfbXCk+x8NvvVara6my9Bzt1CymvGBFsDnsc8+tAdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927636; c=relaxed/simple;
	bh=36QxVjV3+eH09ZejI6sP5vFGHyzzkinONV48q0+cQq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrziAxos0/tkk/78I6VT1+/s8aRM/kx2kNfRK0WuOPTAjA8KrDg1GKuprcln2UhfNSLUh3ehRHYBmMNMQSMZskMxMi0kjplVNLT7ZxBL1g5lzEnzxTiJaG9xDFGDTUsXcwuwOWD63aaYzgBDdGPc5+a7SVvQ7WaS/FajrzQmA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=knBtwZzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707ABC433F1;
	Mon, 26 Feb 2024 06:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708927635;
	bh=36QxVjV3+eH09ZejI6sP5vFGHyzzkinONV48q0+cQq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knBtwZzLMycCV9Gzfh1Be/CHmlfLd6ZhCfcaFlW9p5NSsfdviQwKEj7eeCU9IKv/v
	 F+pTyGpY0thJJBV93kh+7HTWU3+p0ZF7bmC+CeDJ6/mrTaC4xkYv/iZAaMqsmTxeQl
	 r8uzPQXElhxf2fNCkU+mA1kFoWL89ypQgXG0f6qE=
Date: Mon, 26 Feb 2024 07:07:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-26602: sched/membarrier: reduce the ability to hammer
 on sys_membarrier
Message-ID: <2024022614-unhappily-python-2cd0@gregkh>
References: <2024022414-CVE-2024-26602-5e76@gregkh>
 <22f42e54-d791-42aa-88f3-172f616b8316@leemhuis.info>
 <2024022510-goofy-entering-12e3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022510-goofy-entering-12e3@gregkh>

On Sun, Feb 25, 2024 at 10:47:28AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Feb 25, 2024 at 10:31:19AM +0100, Thorsten Leemhuis wrote:
> > On 24.02.24 15:57, Greg Kroah-Hartman wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > sched/membarrier: reduce the ability to hammer on sys_membarrier
> > > 
> > > On some systems, sys_membarrier can be very expensive, causing overall
> > > slowdowns for everything.  So put a lock on the path in order to
> > > serialize the accesses to prevent the ability for this to be called at
> > > too high of a frequency and saturate the machine.
> > > 
> > > The Linux kernel CVE team has assigned CVE-2024-26602 to this issue.
> > > 
> > > 
> > > Affected and fixed versions
> > > ===========================
> > > 
> > > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 4.19.307 with commit 3cd139875e9a
> > > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 5.4.269 with commit 2441a64070b8
> > > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 5.10.210 with commit db896bbe4a9c
> > > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 5.15.149 with commit 50fb4e17df31
> > > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 6.1.79 with commit 24ec7504a08a
> > > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 6.6.18 with commit b6a2a9cbb675
> > > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 6.7.6 with commit c5b2063c65d0
> > >
> > > Please see [...]
> > Greg, JFYI, I noticed that this announcement did not refer to the fix in
> > mainline (944d5fe50f3f03 ("sched/membarrier: reduce the ability to
> > hammer on sys_membarrier")) while most of the others do that. I don't
> > care at all, just noticed this by chance and wanted to let you know in
> > case it's due to a bug in a script or something. I hope there is not a
> > good reason for that difference I just failed to spot... (if that's the
> > case: apologies in advance for the noise!).
> 
> The json entry will be updated when the commit shows up in a tagged
> release (i.e. the next -rc release), and then when the real release
> happens from Linus (i.e. 6.8), it will be updated then as well.

It is now updated on the cve.org website at:
	https://www.cve.org/CVERecord/?id=CVE-2024-26602
and in the cve git repo record as well:
	https://git.kernel.org/pub/scm/linux/security/vulns.git/diff/cve/published/2024/CVE-2024-26602.mbox

thanks,

greg k-h

