Return-Path: <linux-kernel+bounces-63040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8B8529A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CB11F2109D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06D917999;
	Tue, 13 Feb 2024 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ve01hH6N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18E1774C;
	Tue, 13 Feb 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808882; cv=none; b=XCiu1GrQTNRioHXCQPJUOux3LGuB8F4rNQMB/9UEHUXZPMOSBfuANOdI0jDT0KJv1hjcE+0pj7cRHTZgDn12zhngWJ21uRushXCyHrHGwHuF/PTaIPxsmfyGMqfpv9hTi7Y47O3yhdXzX0EoxVqi/UbR6sZMkHy9D2UoWOmUvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808882; c=relaxed/simple;
	bh=7aj2dsWrq6HhDMS2141xPNojK2aQpCE6F46PWy5w7tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVSGpEOMIMxM9qNlR2NUvP7pytZII8QUwuZ92ZLs1iyhAB0eGL4PyXMaHlcTKVhMa4vZhXZCHGdrTFolFHzDy9ZD8AOZiIE16No68du0mUWZCPv7+t+xD4klTxIy6abXaqZvOErn1ufTOR8UzL9oeA5l9Er4M6evi1ivnveqL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ve01hH6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E29C433F1;
	Tue, 13 Feb 2024 07:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707808881;
	bh=7aj2dsWrq6HhDMS2141xPNojK2aQpCE6F46PWy5w7tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ve01hH6N7tUS/qsm+x4boxAhqJXMc0x5hoSXAt8fx1DzHRNrHxA5xHyKU6UmEf1QP
	 V0pAZXkoojtLitvxMQ2AIkO8J64dHXxp/gi5UUK/9qFydDtBCPSwZGzi9XZ1wtMCyW
	 lgjLz8r8RNRx5ALO5FH9ScuvrEWN9jN5B4c0udVg=
Date: Tue, 13 Feb 2024 08:21:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, rafael@kernel.org,
	syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH riscv64] kobject: fix WARNING in input_register_device
Message-ID: <2024021356-unveiling-falcon-54db@gregkh>
References: <2024020821-quintet-survival-54f4@gregkh>
 <tencent_9D9878866FF42C756D2C94DCEA36EC26CE0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9D9878866FF42C756D2C94DCEA36EC26CE0A@qq.com>

On Tue, Feb 13, 2024 at 08:50:01AM +0800, Edward Adam Davis wrote:
> On Thu, 8 Feb 2024 12:25:35 +0000, Greg KH wrote:
> > On Thu, Feb 08, 2024 at 07:37:56PM +0800, Edward Adam Davis wrote:
> > > On Thu, 8 Feb 2024 10:56:00, Greg KH wrote:
> > > > > The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
> > > > > of data to env, which will result in insufficient memory allocated to the buf
> > > > > members of env.
> > > >
> > > > What is "env"?  And can you wrap your lines at 72 columns please?
> > > env is an instance of struct kobj_uevent_env.
> > 
> > Also, why is "risc64" in the subject line?
> Because when syzbot reported this issue, it wrote "userspace arch: riscv64".
> However, I actually tested it on the master branch of upstream.

Then of course, this was not correct in the subject line.

thanks,

greg k-h

