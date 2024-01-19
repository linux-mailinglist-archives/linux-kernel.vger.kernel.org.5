Return-Path: <linux-kernel+bounces-30787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D54883245C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E701F23900
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC35381;
	Fri, 19 Jan 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0GccOKXT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF46D29E;
	Fri, 19 Jan 2024 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643343; cv=none; b=ovuwlWHk8+yMney6DGo6+nIHMJVXVFxnnoQLgwHv7bpYuik+W+7ZHX25FdXJ4e2RsqfIF8wHzOuFiFaoJhBbqjk1R425L+R622SQcfF3GmezLWhyQSPbxVy/izmSzXlaf1s5f41sIgj8wS3jfHbLuN+bLtuEQssN8WdAf6ergRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643343; c=relaxed/simple;
	bh=givEckCEBG994/AoJcSh11hoPD5I6LKxZjQVj1cedyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6hMnrHN4fVTMj1oDxoytmc+DMPGpxQyuNj0QmroBDfbAE3lJTRjU/iCn9fljBULeUxo9dq/JBt9GfKWBYb+GtOpwnVBo5Rp1PngV5ASOk0HOHuo0mLUnoNLemS8pkILphZi6o7mQa82nSyrwwBF17yfiq3BVaMv82x31SPJuYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0GccOKXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC55C433C7;
	Fri, 19 Jan 2024 05:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705643343;
	bh=givEckCEBG994/AoJcSh11hoPD5I6LKxZjQVj1cedyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0GccOKXTJNo5k3sUULxAkCSnqL7koN8n4sFY26qMlD22SfTELKp8Sr03ZVUASTn8c
	 VpmF2JBLcdY6ZfP1wcHsBkzkxz2Q5LKxzl9rN7H7I1Wjt76RKZlj+WF0bcr7NMUuFg
	 L6HQDgSOMMbRXGftgGMHGmHi5n2kUEm1i+4NqIv8=
Date: Fri, 19 Jan 2024 06:49:00 +0100
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
Message-ID: <2024011955-quotation-zone-7f20@gregkh>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-6-cmllamas@google.com>
 <Zal9HFZcC3rFjogI@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zal9HFZcC3rFjogI@google.com>

On Thu, Jan 18, 2024 at 07:33:48PM +0000, Carlos Llamas wrote:
> On Fri, Dec 01, 2023 at 05:21:34PM +0000, Carlos Llamas wrote:
> > Each transaction is associated with a 'struct binder_buffer' that stores
> > the metadata about its buffer area. Since commit 74310e06be4d ("android:
> > binder: Move buffer out of area shared with user space") this struct is
> > no longer embedded within the buffer itself but is instead allocated on
> > the heap to prevent userspace access to this driver-exclusive info.
> > 
> > Unfortunately, the space of this struct is still being accounted for in
> > the total buffer size calculation, specifically for async transactions.
> > This results in an additional 104 bytes added to every async buffer
> > request, and this area is never used.
> > 
> > This wasted space can be substantial. If we consider the maximum mmap
> > buffer space of SZ_4M, the driver will reserve half of it for async
> > transactions, or 0x200000. This area should, in theory, accommodate up
> > to 262,144 buffers of the minimum 8-byte size. However, after adding
> > the extra 'sizeof(struct binder_buffer)', the total number of buffers
> > drops to only 18,724, which is a sad 7.14% of the actual capacity.
> > 
> > This patch fixes the buffer size calculation to enable the utilization
> > of the entire async buffer space. This is expected to reduce the number
> > of -ENOSPC errors that are seen on the field.
> > 
> > Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> 
> Sorry, I forgot to Cc: stable@vger.kernel.org.


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

