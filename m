Return-Path: <linux-kernel+bounces-148888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154A58A8895
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E2D286711
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ED01494A1;
	Wed, 17 Apr 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CjR2UGc2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A2148301;
	Wed, 17 Apr 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370327; cv=none; b=nDUdXtO3C85t9puc8Hk2JJlisDNejWe/MFYR5bEiCUkTHV9hAhARoNMs0rEqT9MWdWdxSPZMZavRfyrIV4ctvikA//7rvPvAAi2y359HgeG1VU5uwj0oN+bgmjiLwXEAXEVGwBeLZ3C+QQViKc1NOaYyj53VM2yeP/kdaubaRxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370327; c=relaxed/simple;
	bh=jbAl9YGRV+m0s6w3JK8bIOEhkk4DQL0onrbhGATCGow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC+IWnbTDMTd13U6tj9gUcZhF0p42dwwsB/vnooNF+Y+QpLpB/kDZOLi/oG1ZzgwTc0vlVrS2Z3OSLgiBkIiXgIRyGrVXIDly/K+96OT8zoYbfLXQz6J3Jw2tVVI+WYyoGbH99vMF+089hzLNu/Nln/h/uwlkrSG1A3KKcCMt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CjR2UGc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EBDC072AA;
	Wed, 17 Apr 2024 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713370327;
	bh=jbAl9YGRV+m0s6w3JK8bIOEhkk4DQL0onrbhGATCGow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjR2UGc2nIYu0UdSHjbiMTBGYEFbbQN8GymUL9EjMFGEmpOXXd61WD8UDm+9VuTAb
	 drfITlhpFu5PtqW3bba6lDIdrCp0G7VRL0OKUfTIw1aTeprVqsnF+Nv1s0K4VdI79c
	 3593StFBnSW1GvERzNTWmzlBeZVjRbezd6eZXaw8=
Date: Wed, 17 Apr 2024 18:12:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26774: ext4: avoid dividing by 0 in
 mb_update_avg_fragment_size() when block bitmap corrupt
Message-ID: <2024041721-reboot-squall-310e@gregkh>
References: <2024040308-CVE-2024-26774-52d9@gregkh>
 <20240417114324.c77wuw5hvjbm6ok5@quack3>
 <2024041711-chapter-uninstall-b1d3@gregkh>
 <20240417145446.uh2rqcbxlebnkbfm@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417145446.uh2rqcbxlebnkbfm@quack3>

On Wed, Apr 17, 2024 at 04:54:46PM +0200, Jan Kara wrote:
> On Wed 17-04-24 15:30:03, Greg Kroah-Hartman wrote:
> > On Wed, Apr 17, 2024 at 01:43:24PM +0200, Jan Kara wrote:
> > > Hello!
> > > 
> > > On Wed 03-04-24 19:31:41, Greg Kroah-Hartman wrote:
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
> > > > 
> > > > Determine if bb_fragments is 0 instead of determining bb_free to eliminate
> > > > the risk of dividing by zero when the block bitmap is corrupted.
> > > > 
> > > > The Linux kernel CVE team has assigned CVE-2024-26774 to this issue.
> > > 
> > > I'd like to understand what is the imagined security threat fixed by this
> > > patch (as multiple patches of similar nature got assigned a CVE). The patch
> > > fixes a bug that if a corrupted filesystem is read-write mounted, we can do
> > > division-by-zero. Now if you can make the system mount a corrupted
> > > filesystem, you can do many interesting things to the system other than
> > > create a division by zero... So what is the presumed threat model here?
> > 
> > Exactly what you said, "if you mount a corrupted file system, you will
> > get a divide by zero fault."
> > 
> > Many systems auto-mount any filesystem plugged into it.  If yours do
> > not, then yours does not need to worry about this type of CVE.
> 
> OK, understood. But let me state that with the current state of affairs in
> the filesystem land, it will not take a determined attacker long to get
> arbitrary code execution out of "maliciously corrupted fs mounted". The
> code of most filesystems has simply never been written with the assumption
> that it can be presented with malicious data and we have hundreds of
> thousands lines of code like that. We have fixed the most glaring problems
> but by far not all (partly because of performance and maintenance costs,
> partly because they are baked into on-disk formats).

I totally agree.  It's up to the distros to stop doing this if they wish
to stop this problem from happening.

thanks,

greg k-h

