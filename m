Return-Path: <linux-kernel+bounces-163524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF98B6C89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D93B2115F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752950A79;
	Tue, 30 Apr 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZdFNT24o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480294596D;
	Tue, 30 Apr 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464793; cv=none; b=k8oj6b3391MsyjrBqivm4AeEJRI4XUN9nmIix/8p8vwAVcHtQ70v25TiUmAuHR3LjE0XKJM72BxmGo19Oe71OF7gRBxk2Fk8TFF0Yt9xoNGGH9XwVnixnHwuKIhmBnh6ptVaUsKG4tZLBI5dIwU84UGCMxaWPtbzoJL4frGHo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464793; c=relaxed/simple;
	bh=RG0T0GpJn5SyORYbgKj2g8xDw+yLsyU+TPPL+oj+/BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA958Paq6VvG65t7hQC0EvmFGInxEsjjjZT/lwesva/uaBkHVRBIy15Z1RtKbNjLGRxjSX27AIxbEFopGjjVduKxX9Q6p9bZdrPmsWgXWA8EaVLrTVRHLIIoFbsijpfjK8Bf5Iq577Ckf7HT4P13tGaqwDcnRNup9qC078If6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZdFNT24o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE05C2BBFC;
	Tue, 30 Apr 2024 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714464792;
	bh=RG0T0GpJn5SyORYbgKj2g8xDw+yLsyU+TPPL+oj+/BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdFNT24o+/buP6b6XxEHP1L/lh4DtFUpAxUlcu9mSQmMFi8Bz3koxffh2/upbLvfl
	 IvVYxA6aKUeCGLHgEPeTcX3aakMh90BIcrX48DKYWFEeT9dsJbC1Gwr7V7xpNIbGEU
	 gueAgL7+xPR0oquk4J4DifBYHF7mRkqrHf7qmjto=
Date: Tue, 30 Apr 2024 10:13:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
	Tejun Heo <tj@kernel.org>
Subject: Re: CVE-2023-52630: blk-iocost: Fix an UBSAN shift-out-of-bounds
 warning
Message-ID: <2024043053-campsite-refining-1c3c@gregkh>
References: <2024040219-CVE-2023-52630-a529@gregkh>
 <7x4ufwbvk4wmhag66rstdpbm4f2iplyc2l66cl7i2wl5nfh2tm@uxc425y2kfno>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7x4ufwbvk4wmhag66rstdpbm4f2iplyc2l66cl7i2wl5nfh2tm@uxc425y2kfno>

On Fri, Apr 26, 2024 at 07:34:45PM +0200, Michal Koutný wrote:
> On Tue, Apr 02, 2024 at 08:22:20AM +0200, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > blk-iocost: Fix an UBSAN shift-out-of-bounds warning
> > 
> > When iocg_kick_delay() is called from a CPU different than the one which set
> > the delay, @now may be in the past of @iocg->delay_at leading to the
> > following warning:
> > 
> >   UBSAN: shift-out-of-bounds in block/blk-iocost.c:1359:23
> >   shift exponent 18446744073709 is too large for 64-bit type 'u64' (aka 'unsigned long long')
> >   ...
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x79/0xc0
> >    __ubsan_handle_shift_out_of_bounds+0x2ab/0x300
> >    iocg_kick_delay+0x222/0x230
> >    ioc_rqos_merge+0x1d7/0x2c0
> >    __rq_qos_merge+0x2c/0x80
> >    bio_attempt_back_merge+0x83/0x190
> >    blk_attempt_plug_merge+0x101/0x150
> >    blk_mq_submit_bio+0x2b1/0x720
> >    submit_bio_noacct_nocheck+0x320/0x3e0
> >    __swap_writepage+0x2ab/0x9d0
> > 
> > The underflow itself doesn't really affect the behavior in any meaningful
> > way; however, the past timestamp may exaggerate the delay amount calculated
> > later in the code, which shouldn't be a material problem given the nature of
> > the delay mechanism.
> 
> The worst implication is unfair or slowed IO but that can't be
> quantified given empirical implementation of the delay mechanism.
> 
> > If @now is in the past, this CPU is racing another CPU which recently set up
> > the delay and there's nothing this CPU can contribute w.r.t. the delay.
> 
> This means the user has limited control (with noise) over such
> placements.
> 
> > Let's bail early from iocg_kick_delay() in such cases.
> > 
> > The Linux kernel CVE team has assigned CVE-2023-52630 to this issue.
> 
> Based on the above I don't think this fix deserves CVE tracking. Shall
> it be rejected?

Makes sense, thanks for looking into this, and sorry for the delay.  Now
rejected.

greg k-h

