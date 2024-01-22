Return-Path: <linux-kernel+bounces-33340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C6683688A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C911C2354B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E0B482F4;
	Mon, 22 Jan 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sRmiSZjQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EDB63107;
	Mon, 22 Jan 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935930; cv=none; b=aystO0rLxC6Dj77FJkEx85bM5xRehThCDMXHnYsYL1LqveqvlWD4GpBA1Hh45lQJBTbIc/0NNV4DYehzXdc6XkJ7OxsmfQ0DH/3Tm+KDzqh3SX90+19gyWhFr/dTjcO3Q0f3ER8fninIPgeUBhjM5tuKjd8WDAMbkqiuYovadnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935930; c=relaxed/simple;
	bh=F68i9hM8sovM7L3HP/urMxCAyGFLBSAzNVces5MUfjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drUR0jymZfwv6ypjMsGCQOK6DjvUHG69/M1RKR+rpRfgArXO+fUk8y24DXmfZs2OOrUZ76T0vb8peGMeiMetftjhUnu2o6g3PcFfyFruSjgbY2VExuSrBWivFZ/acAnAzIo8qqB4BfaFAuer0+1mqR4aN2vt+qPyixMRTeMtw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sRmiSZjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9ACC43399;
	Mon, 22 Jan 2024 15:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705935930;
	bh=F68i9hM8sovM7L3HP/urMxCAyGFLBSAzNVces5MUfjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRmiSZjQU/5ajgL+XobTaF6guD5KVFVFiRyahpHp1sxqe6jEavU4Dsx38RUhG/Mek
	 uFa/gpf4NbLutvtobDxiEjPsSaATb6Zk4KCPJX4hhSJvBVObuo/AtNs1M80aJ+TJJ7
	 W2WhTEMBBAyzL/6fSccXN6n24NX513TUqE4YDwPo=
Date: Mon, 22 Jan 2024 07:05:29 -0800
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
Message-ID: <2024012214-ideology-curvature-febb@gregkh>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-6-cmllamas@google.com>
 <Zal9HFZcC3rFjogI@google.com>
 <2024011955-quotation-zone-7f20@gregkh>
 <Zaqw9k4x7IUh6ys-@google.com>
 <2024012203-expedited-job-1d79@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012203-expedited-job-1d79@gregkh>

On Mon, Jan 22, 2024 at 07:04:20AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Jan 19, 2024 at 05:27:18PM +0000, Carlos Llamas wrote:
> > On Fri, Jan 19, 2024 at 06:49:00AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Jan 18, 2024 at 07:33:48PM +0000, Carlos Llamas wrote:
> > > > On Fri, Dec 01, 2023 at 05:21:34PM +0000, Carlos Llamas wrote:
> > > > > Each transaction is associated with a 'struct binder_buffer' that stores
> > > > > the metadata about its buffer area. Since commit 74310e06be4d ("android:
> > > > > binder: Move buffer out of area shared with user space") this struct is
> > > > > no longer embedded within the buffer itself but is instead allocated on
> > > > > the heap to prevent userspace access to this driver-exclusive info.
> > > > > 
> > > > > Unfortunately, the space of this struct is still being accounted for in
> > > > > the total buffer size calculation, specifically for async transactions.
> > > > > This results in an additional 104 bytes added to every async buffer
> > > > > request, and this area is never used.
> > > > > 
> > > > > This wasted space can be substantial. If we consider the maximum mmap
> > > > > buffer space of SZ_4M, the driver will reserve half of it for async
> > > > > transactions, or 0x200000. This area should, in theory, accommodate up
> > > > > to 262,144 buffers of the minimum 8-byte size. However, after adding
> > > > > the extra 'sizeof(struct binder_buffer)', the total number of buffers
> > > > > drops to only 18,724, which is a sad 7.14% of the actual capacity.
> > > > > 
> > > > > This patch fixes the buffer size calculation to enable the utilization
> > > > > of the entire async buffer space. This is expected to reduce the number
> > > > > of -ENOSPC errors that are seen on the field.
> > > > > 
> > > > > Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> > > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > > ---
> > > > 
> > > > Sorry, I forgot to Cc: stable@vger.kernel.org.
> > > 
> > > 
> > > <formletter>
> > > 
> > > This is not the correct way to submit patches for inclusion in the
> > > stable kernel tree.  Please read:
> > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > for how to do this properly.
> > > 
> > > </formletter>
> > 
> > Oops, here is the complete info:
> > 
> > Commit ID: c6d05e0762ab276102246d24affd1e116a46aa0c
> > Subject:   "binder: fix unused alloc->free_async_space"
> > Reason:    Fixes an incorrect calculation of available space.
> > Versions:  v4.19+
> > 
> > Note this patch will also have trivial conflicts in v4.19 and v5.4
> > kernels as commit 261e7818f06e is missing there. Please let me know and
> > I can send the corresponding patches separately.
> 
> It doesn't even apply to 6.7.y either, so we need backports for all
> affected trees, thanks.

Now I got it to apply, but we need backports for 5.4.y and 4.19.y,
thanks.

greg k-h

