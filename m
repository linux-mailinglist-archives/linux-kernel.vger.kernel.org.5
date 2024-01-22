Return-Path: <linux-kernel+bounces-33334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E538368C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2DE3B2C82D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC55461699;
	Mon, 22 Jan 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XT9gcDbW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3376168B;
	Mon, 22 Jan 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935910; cv=none; b=R61hGPOk/9d3I5hYlUwCg5VBZkhFfF0RviL9cZBenn0SPfwoBCVzDOrjRevt1vfRUDHDh9A6upcQX15L/LRX1WD4/rlZdGKIdHj6xHzLS2CYxRAAcVMhPICZAVAafoag+EHj7JbYVq+9KJVm9fid6MvOZSJOVg3C6CnSjyoVOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935910; c=relaxed/simple;
	bh=B4sPbgPwhh4ajjcdmVrXlnMDl7BpbIwe14BcLn2f5UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IarkE0m0L0KyStNkdv1AMGio8yEwnweLbpPew712K6+rF6CsO9TKMcDRVCxoFrOq9xbcSbvaGdl6HEaJDmueRxA2oHzhI8WfLSDcry1e/wJkJABdgL8W9EW+S+dnG4GcCmnqt/uLSQwWu9KagafL0C0Ociqq9KOTx8vxUha3Zts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XT9gcDbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63B0C4166D;
	Mon, 22 Jan 2024 15:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705935909;
	bh=B4sPbgPwhh4ajjcdmVrXlnMDl7BpbIwe14BcLn2f5UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XT9gcDbWSQvnWqzW2XsCxrKlUDpCS26wJ/I5zCtWFk1MMfzCuRj4QP5YeN0hPrtE4
	 aaJoFeOEVI4rxcnjk/CdmmuBTChSKbqbO7UfrfMXR40WZgmnOqrscWhI8IXmdt9ZBr
	 oIvgaOA+CuUOzUGREUcQA8iAQTH8OM1ClE1CtTuM=
Date: Mon, 22 Jan 2024 07:05:09 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sherry Yang <sherryy@android.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 04/28] binder: fix async space check for 0-sized
 buffers
Message-ID: <2024012202-raking-frenzied-7da8@gregkh>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-5-cmllamas@google.com>
 <Zal8uGqP2lLZz_oz@google.com>
 <2024011948-sulfate-tartly-7f97@gregkh>
 <ZaqtPrVhmfvDYzCU@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaqtPrVhmfvDYzCU@google.com>

On Fri, Jan 19, 2024 at 05:11:26PM +0000, Carlos Llamas wrote:
> On Fri, Jan 19, 2024 at 06:48:53AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Jan 18, 2024 at 07:32:08PM +0000, Carlos Llamas wrote:
> > > On Fri, Dec 01, 2023 at 05:21:33PM +0000, Carlos Llamas wrote:
> > > > Move the padding of 0-sized buffers to an earlier stage to account for
> > > > this round up during the alloc->free_async_space check.
> > > > 
> > > > Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> > > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
> Commit ID: 3091c21d3e9322428691ce0b7a0cfa9c0b239eeb
> Subject:   "binder: fix async space check for 0-sized buffers"
> Reason:    Fixes an incorrect calculation of available space.
> Versions:  v4.19+

Now queued up, thanks.

greg k-h

