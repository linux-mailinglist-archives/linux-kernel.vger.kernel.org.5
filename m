Return-Path: <linux-kernel+bounces-30785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F6A832458
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D741C22F03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869974A3C;
	Fri, 19 Jan 2024 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="De1RDYW1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC13C37;
	Fri, 19 Jan 2024 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643326; cv=none; b=k9x7mleYz4F8hywKrJOGVgHM0u3uTZkNpHRLjUOMTGctpypdEJSb0N8vOAgieG+RiWL6yngCt0XkKTiqab1gesYhUqw0psM+ek6F1jusUEtiTlW3xkV+MYgpr5QngVCWDnkBqF78lK505P6eAZ6oq52zqx8FxubuQC0RLGvNIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643326; c=relaxed/simple;
	bh=gkPF4VV6kDIgpkL8E52m/jsG+aV/R8c0E5+3UEWMyvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPe86wVev6QJUov7f3PApgm+PfNRA0xgL2YoPPLsAwtcIM/xK8tUZWzhySWgNebWjSm4HwiYmY6POvZeOfTtC6ltTqLGWkgah5nlCbLy9RlcTox/QfOejWScbYySuXGWQQFpR8Fkm8JOkonx8iOpeSAE93v8RrWMm/sy1pAecl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=De1RDYW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F10AC433C7;
	Fri, 19 Jan 2024 05:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705643326;
	bh=gkPF4VV6kDIgpkL8E52m/jsG+aV/R8c0E5+3UEWMyvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=De1RDYW1sHKyudNYEL/xPak+b/SmeOjoNWdHIZb4qZZyTc3R1hB2585ek+nJRvtjY
	 c5JIoc2+JnIL2oqF8pBvnjMfnzPWYjcO5uoGb2ADLtM7uYo4AhQaZSRKVOBDdkHniv
	 uNStmfA0flLRbLdM2X1Cbziwxss4puK17GxhevD8=
Date: Fri, 19 Jan 2024 06:48:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 03/28] binder: fix race between mmput() and do_exit()
Message-ID: <2024011935-placidly-justifier-4338@gregkh>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-4-cmllamas@google.com>
 <Zal8A95q3jVl4nu5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zal8A95q3jVl4nu5@google.com>

On Thu, Jan 18, 2024 at 07:29:07PM +0000, Carlos Llamas wrote:
> On Fri, Dec 01, 2023 at 05:21:32PM +0000, Carlos Llamas wrote:
> > Task A calls binder_update_page_range() to allocate and insert pages on
> > a remote address space from Task B. For this, Task A pins the remote mm
> > via mmget_not_zero() first. This can race with Task B do_exit() and the
> > final mmput() refcount decrement will come from Task A.
> > 
> >   Task A            | Task B
> >   ------------------+------------------
> >   mmget_not_zero()  |
> >                     |  do_exit()
> >                     |    exit_mm()
> >                     |      mmput()
> >   mmput()           |
> >     exit_mmap()     |
> >       remove_vma()  |
> >         fput()      |
> > 
> > In this case, the work of ____fput() from Task B is queued up in Task A
> > as TWA_RESUME. So in theory, Task A returns to userspace and the cleanup
> > work gets executed. However, Task A instead sleep, waiting for a reply
> > from Task B that never comes (it's dead).
> > 
> > This means the binder_deferred_release() is blocked until an unrelated
> > binder event forces Task A to go back to userspace. All the associated
> > death notifications will also be delayed until then.
> > 
> > In order to fix this use mmput_async() that will schedule the work in
> > the corresponding mm->async_put_work WQ instead of Task A.
> > 
> > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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

