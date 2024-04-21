Return-Path: <linux-kernel+bounces-152454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5338ABEB1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 08:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876532810F1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 06:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BF6D2FE;
	Sun, 21 Apr 2024 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PKuCF6AT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F6205E2C;
	Sun, 21 Apr 2024 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713681567; cv=none; b=d4MpIa3R2ytwtKOVfb3mva8RUR/eAmGDdrRzty3bs317t5/LZC3vUgswwR/9nm63/+4XPif0ye2uY7hj/GzaE0chMOsOr2WwCeobVaJWB3bV9pDl+byV8/EKxp7Uv8wXMu+prAVXE0PZM94bMixYJRtofZof+/vwOH9pemN/8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713681567; c=relaxed/simple;
	bh=LiRB9rjFKxbX5IKYehMMYf2woCtRaCUAx0H9EFjhyJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/yyYRxMpn3CurtqUPcaKBqYdNi8Bc7dbfuut/6dTiirdI+b4Aic5/tFt1QvqkqIu1nzseCfoFzEYarewz+DrPpdeS9FzNQKNIrOhcVoRd5ABWq8XUKdrekjnaIzBXlcibQiq18EvwZHkNN+ASAJO4FSGl4ja6gGn1bAHLuiQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PKuCF6AT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A7C113CE;
	Sun, 21 Apr 2024 06:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713681566;
	bh=LiRB9rjFKxbX5IKYehMMYf2woCtRaCUAx0H9EFjhyJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKuCF6ATamV7RPkPHWQnV/DYYpHVEonNUu1jA8+AbrwodQI+y73xqt8SEeYRPx8jw
	 +VRPflWsy/YTSP6STp+izb0ZJVwpOGthseuF3Bzz68S3N5rKFOSF/SKuijjdfwnwuC
	 pHVLyfDacrxG8nXoXxmndUuX7SgNnv74kgD0gZKI=
Date: Sun, 21 Apr 2024 08:39:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Serban Constantinescu <serban.constantinescu@arm.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] binder: fix max_thread type inconsistency
Message-ID: <2024042112-landscape-gains-1bb0@gregkh>
References: <20240417191418.1341988-1-cmllamas@google.com>
 <20240417191418.1341988-5-cmllamas@google.com>
 <2024041858-unwoven-craziness-13a6@gregkh>
 <ZiRXHs9_Uszd7xzS@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiRXHs9_Uszd7xzS@google.com>

On Sun, Apr 21, 2024 at 12:00:30AM +0000, Carlos Llamas wrote:
> On Thu, Apr 18, 2024 at 06:40:52AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 17, 2024 at 07:13:44PM +0000, Carlos Llamas wrote:
> > > The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
> > > size_t to __u32 in order to avoid incompatibility issues between 32 and
> > > 64-bit kernels. However, the internal types used to copy from user and
> > > store the value were never updated. Use u32 to fix the inconsistency.
> > > 
> > > Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS declaration")
> > > Reported-by: Arve Hjønnevåg <arve@android.com>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > >  drivers/android/binder.c          | 2 +-
> > >  drivers/android/binder_internal.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > Why does only patch 4/4 need to go into the tree now, and as a stable
> > backport, but the first 3 do not?  Shouldn't this be two different
> > series of patches, one 3 long, and one 1 long, to go to the different
> > branches (next and linus)?
> 
> Yes, that is correct. Only patch 4/4 would need to be picked for linus
> now and for stable. The others would go to next. Sorry, I was not aware
> that sending them separately would be preferred.
> 
> I'll drop 4/4 patch from the series in v2. Let me know if you still need
> me to send it again separately.

Please do, thanks!

greg k-h

