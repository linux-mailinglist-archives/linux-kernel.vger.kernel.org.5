Return-Path: <linux-kernel+bounces-55028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24184B690
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877E01C24526
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E65131729;
	Tue,  6 Feb 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbN7uTfZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5473195
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226713; cv=none; b=nIE5s3Tsu733ayaECgg0QkMMbwRogFLoJh49k7JFZxQdgR8VrLoGBqftj7ilj9G0sZF9sK0xXYq4WcKClNt4G/kDYS6+8+brE6lKq1gWjIFX/07duDqyc/gcitjl2xgFHBSRy+aGeDMPLkdIlfAjW79RSe05I/55ijMqsevBAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226713; c=relaxed/simple;
	bh=Fb1RR5YKjdb++HKdFCbp1Gw0EkAjp8M6VBIziUToSwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXWAB4EEUEW3JHniTCGOhJG+Ba/IOb4YzkTAy9lNuIl2bV+U/b5vkTY8tONjvZJBCoBE7Dg8O5NkxJLI+KYSXDJz+7idE9Sd4SrxrqXJRs6et/Bqy4RfIVRXyOHMsl2gWhVHHUDP0GeTbMraAOJBhL+oqnoStHNZ1Q+psPtacHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbN7uTfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17472C433F1;
	Tue,  6 Feb 2024 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707226712;
	bh=Fb1RR5YKjdb++HKdFCbp1Gw0EkAjp8M6VBIziUToSwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbN7uTfZXwr134Sf3PejpCzdftQv7Bju4pbmqRNmVB8cm0Si1/6QSOj7OpJVPVglf
	 +TBuluksaWSHVZcwVRPJeAfgRPkxLYRma2Ds8NCDjvPOgoM0ZKm7IDwWi9lmaohYzf
	 3jKzja2+ibFv6rhPRBkriY/bRsv+diPEuOWFVZYPAt073JnKzAmvKMjuy3afg/JSrp
	 vc4mFs55R/oiGViAyPi+e2M8dU5/9KsyEHHxn7moLy9qFOhj8n+05Bzq6hXd04j4zQ
	 sQalc5QtlxCz52mgGI2DL+LhKDEm4y+zRP7gNyO3v2dLp8znwa6ObM/YElHCoB3FS5
	 m6nurpyFmEGkQ==
Date: Tue, 6 Feb 2024 14:38:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240206-beatmen-lehrling-440dc305b070@brauner>
References: <20240131132541.GA23632@redhat.com>
 <20240131132602.GA23641@redhat.com>
 <20240202-helium-eurem-f63c0f9328c0@brauner>
 <20240205152241.GB15853@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205152241.GB15853@redhat.com>

On Mon, Feb 05, 2024 at 04:22:41PM +0100, Oleg Nesterov wrote:
> On 02/02, Christian Brauner wrote:
> >
> > > @@ -2050,6 +2051,8 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
> > >
> > >  	seq_put_decimal_ll(m, "Pid:\t", nr);
> > >
> > > +	/* TODO: report PIDFD_THREAD */
> >
> > So I think we don't need to do anything here. Since PIDFD_THREAD sets
> > O_EXCL in file->f_flags and in contrast to do_dentry_open() it isn't
> > dropped. So userspace can already detect PIDFD_NONBLOCK as O_NONBLOCK
> > and PIDFD_THREAD as O_EXCL.
> 
> Ah, indeed, I didn't know that fs/proc/fd.c:seq_show() reports ->f_flags.
> Thanks.
> 
> 
> 
> OK, what about another TODO in sys_pidfd_send_signal() ?
> 
> I mean, should I send a simple patch which changes pidfd_send_signal()
> to use do_send_specific() if PIDFD_THREAD ? Or do you think this should

Yes, by default the type of pidfd should determine the scope of the
signal as discussed elsewhere.

(And later we can add flags that allow the caller to change the scope of
the signal. So that Andy's use-cases are covered as well.)

