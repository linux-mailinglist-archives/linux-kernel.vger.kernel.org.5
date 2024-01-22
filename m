Return-Path: <linux-kernel+bounces-33317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56578836853
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD2A1F2109E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4540947F41;
	Mon, 22 Jan 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sL2CU03v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882E47F58;
	Mon, 22 Jan 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935861; cv=none; b=qV5nyI6OGiMSa30AihQmApjYI5bLZFVYRlA4mEMf2iXD6jck+toE4G6Xvh7ZEWKo9f35isMetZbpje2ot0uSIdbPeTkSBzMre6kovfFOSAf1vY1Z/tmKnd2Wn5N4JFeiwZTZlJ0xxZHG/XV8SaSA866dRg/KvkjNbCpYiLwms6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935861; c=relaxed/simple;
	bh=HJlEOLIuCq3sg9A8tPi7mwWYHioo2FNzf0m9QyRk4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKBEDLsZAeNQsrfLta1tYQvPsIo+bBtY6l8r76UWui4wry+PXWV205nSHyTf6CFVX/3Bp028NB6ExIlGIcnFAIZ6w3Mll4nPGCITHLu7Q0RGu5NSjgYbpoShY4W3fBtVUtcHC2aGk/UFygqkEgXAhR3GZiDHFdvOg8AYiUCxfcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sL2CU03v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAD6C433A6;
	Mon, 22 Jan 2024 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705935861;
	bh=HJlEOLIuCq3sg9A8tPi7mwWYHioo2FNzf0m9QyRk4JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sL2CU03vncHGeY/4nlUEjrgxefE//nw1bbgBD+5Jb24IZwrs8XhhJpbAgolZhpbUu
	 mKG1hfVhauLMDqxg7fugLXzyI0jDdWPAcUbJRIv7KMbbff0v6EZon4eqFf5WNM26lb
	 7oY1VPbv2QbRiU4nHAxlNt1NRcCvd4pDoTkzKxVA=
Date: Mon, 22 Jan 2024 07:04:20 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sherry Yang <sherryy@android.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 05/28] binder: fix unused alloc->free_async_space
Message-ID: <2024012203-expedited-job-1d79@gregkh>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-6-cmllamas@google.com>
 <Zal9HFZcC3rFjogI@google.com>
 <2024011955-quotation-zone-7f20@gregkh>
 <Zaqw9k4x7IUh6ys-@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zaqw9k4x7IUh6ys-@google.com>

On Fri, Jan 19, 2024 at 05:27:18PM +0000, Carlos Llamas wrote:
> On Fri, Jan 19, 2024 at 06:49:00AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Jan 18, 2024 at 07:33:48PM +0000, Carlos Llamas wrote:
> > > On Fri, Dec 01, 2023 at 05:21:34PM +0000, Carlos Llamas wrote:
> > > > Each transaction is associated with a 'struct binder_buffer' that stores
> > > > the metadata about its buffer area. Since commit 74310e06be4d ("android:
> > > > binder: Move buffer out of area shared with user space") this struct is
> > > > no longer embedded within the buffer itself but is instead allocated on
> > > > the heap to prevent userspace access to this driver-exclusive info.
> > > > 
> > > > Unfortunately, the space of this struct is still being accounted for in
> > > > the total buffer size calculation, specifically for async transactions.
> > > > This results in an additional 104 bytes added to every async buffer
> > > > request, and this area is never used.
> > > > 
> > > > This wasted space can be substantial. If we consider the maximum mmap
> > > > buffer space of SZ_4M, the driver will reserve half of it for async
> > > > transactions, or 0x200000. This area should, in theory, accommodate up
> > > > to 262,144 buffers of the minimum 8-byte size. However, after adding
> > > > the extra 'sizeof(struct binder_buffer)', the total number of buffers
> > > > drops to only 18,724, which is a sad 7.14% of the actual capacity.
> > > > 
> > > > This patch fixes the buffer size calculation to enable the utilization
> > > > of the entire async buffer space. This is expected to reduce the number
> > > > of -ENOSPC errors that are seen on the field.
> > > > 
> > > > Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > ---
> > > 
> > > Sorry, I forgot to Cc: stable@vger.kernel.org.
> > 
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> Oops, here is the complete info:
> 
> Commit ID: c6d05e0762ab276102246d24affd1e116a46aa0c
> Subject:   "binder: fix unused alloc->free_async_space"
> Reason:    Fixes an incorrect calculation of available space.
> Versions:  v4.19+
> 
> Note this patch will also have trivial conflicts in v4.19 and v5.4
> kernels as commit 261e7818f06e is missing there. Please let me know and
> I can send the corresponding patches separately.

It doesn't even apply to 6.7.y either, so we need backports for all
affected trees, thanks.

greg k-h

