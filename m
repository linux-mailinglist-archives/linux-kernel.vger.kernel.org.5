Return-Path: <linux-kernel+bounces-149503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377E8A921C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E890282B10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB32D4EB50;
	Thu, 18 Apr 2024 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJqHREHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA837162;
	Thu, 18 Apr 2024 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713415258; cv=none; b=YKqQ4AmVdjrkZqAzm/o3I1DtTS/IiTqjb1DI9ycB9uTFNWKWANxPkxfcBvlMyF2zxe1tOgL0Wng3O+J3fZdPjsegGzKUD/TsVP6BwPuKV6FeZNjanmGaSC5EmoADOvkTfiNfdE2LOaZPAnMz+f3LT3siExmLV/Q64dQpPBp99V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713415258; c=relaxed/simple;
	bh=VQ+erC02S8QBEDvlvhPlfOxKd9HwPHoMlyukhevwlIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuJDVP5+IyDaoVI1H6Tl2qbHC9JRHacZd3Yg1GKKKlQ0GxdMpSX1gB7cnbvlUMPZ0gZRlsxFROGjOva1/qokpjTjVGmPWwTFTg1Mx+mFDO3LifAizOnpK1hcIhaPV8rJaHO3FAAsGMDXxdjHxo47I8D3+0Lzc4rTFJZHfg1SSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJqHREHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210FCC113CC;
	Thu, 18 Apr 2024 04:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713415257;
	bh=VQ+erC02S8QBEDvlvhPlfOxKd9HwPHoMlyukhevwlIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJqHREHbYjz/JTe12+U0xtkbyjeOrhG+U7wI2vaISWNhthmu6JzBwTJzx0T6OUqkA
	 hcLnVClJH3E1joYatGWn/i5ijuRyr3mCYwgaMhcXwqev0eX31VRfabVAiiyHakgmsg
	 aglJgsJMS+Xf3aALsPR8EDgcn3EDDOaGfhF1dwmA=
Date: Thu, 18 Apr 2024 06:40:52 +0200
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
Message-ID: <2024041858-unwoven-craziness-13a6@gregkh>
References: <20240417191418.1341988-1-cmllamas@google.com>
 <20240417191418.1341988-5-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417191418.1341988-5-cmllamas@google.com>

On Wed, Apr 17, 2024 at 07:13:44PM +0000, Carlos Llamas wrote:
> The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
> size_t to __u32 in order to avoid incompatibility issues between 32 and
> 64-bit kernels. However, the internal types used to copy from user and
> store the value were never updated. Use u32 to fix the inconsistency.
> 
> Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS declaration")
> Reported-by: Arve Hjønnevåg <arve@android.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c          | 2 +-
>  drivers/android/binder_internal.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Why does only patch 4/4 need to go into the tree now, and as a stable
backport, but the first 3 do not?  Shouldn't this be two different
series of patches, one 3 long, and one 1 long, to go to the different
branches (next and linus)?

thanks,

greg k-h

