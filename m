Return-Path: <linux-kernel+bounces-49863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C588470A4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C699A1C2328C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C494402;
	Fri,  2 Feb 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6YrLgtZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4820F4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878230; cv=none; b=irYlrnefIOT+/anRr6sKEwttTU07EgyA+dbzZTKRReA+ifQmXaUaYORpdpdjyYfqoX3/f9YNqsQk2l/+67+/pHgyXh2+HNzbdMH3dfc0TdK+wsmEcMTOwvECHc/nW9cuoPemoYTmkdS0AfH8YNCupIdMmh8zy1GTVswTL+YbNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878230; c=relaxed/simple;
	bh=yRAUEQ2OEGC0kPXDh7EskUX+yLmin6erghB34U7SLtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdljZgCGH0bLKEwlowGivdfuy6RIoZEdYv2sUWPXGGOLz81C8rcm90dB+0LxLyljk/pVf3htdgw3XuASnQKAwL+4T3us0HDTLp8zzXq6o87a+x0oUPXXJH1LXCf4stabnnL7VxigdK9wOpahEdFy39i/AA+fCd8BWzXnIq3Ic3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6YrLgtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB65C43394;
	Fri,  2 Feb 2024 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706878229;
	bh=yRAUEQ2OEGC0kPXDh7EskUX+yLmin6erghB34U7SLtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6YrLgtZ2nEoN8GmGauznZJtU48bqI8OG8j3u/nkMArMjHjvX/cXr9P4gUOos2yWQ
	 xXOIl2Nf48tE8mKSbolZtKMEUtbx0RRCGWICEycYR7k2YdmpNuVG3SrMDtRzy25WWa
	 X+jd224A9FRtV8f8gwcd+kjGZbhgWoqzuYnQgUTaaTsyO7am6B52zhoKaVA5gt/X2C
	 PspXI9JNNiR2lvN9ORQrYINWL/Ldmh3WZM5QSSzakNQ3IKmXbwMUoWNyDTm/tYfAaV
	 +gQAE20OxpJFbfdtvSkS2zpgeUZBuYv5rvGWhhXjSqOYWZNIH9njI8Z6UemKiaDty6
	 RVew9JLvhiv7w==
Date: Fri, 2 Feb 2024 13:50:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240202-helium-eurem-f63c0f9328c0@brauner>
References: <20240131132541.GA23632@redhat.com>
 <20240131132602.GA23641@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131132602.GA23641@redhat.com>

> @@ -2050,6 +2051,8 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  
>  	seq_put_decimal_ll(m, "Pid:\t", nr);
>  
> +	/* TODO: report PIDFD_THREAD */

So I think we don't need to do anything here. Since PIDFD_THREAD sets
O_EXCL in file->f_flags and in contrast to do_dentry_open() it isn't
dropped. So userspace can already detect PIDFD_NONBLOCK as O_NONBLOCK
and PIDFD_THREAD as O_EXCL.

