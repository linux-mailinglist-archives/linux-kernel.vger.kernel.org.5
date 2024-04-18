Return-Path: <linux-kernel+bounces-150094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC48A9A54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CA9B20B96
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3193A161308;
	Thu, 18 Apr 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBqQ3YaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6753B15E7E7;
	Thu, 18 Apr 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444421; cv=none; b=kdAdIx/MwcZPv86ek8rSwJ+BN7AOxZN2IiT01hLrxKC9lYCnI4RwrxzIhInmLKDNHEY8YwiGcAYqYIn4yvN0+x3ua4PHsPL3xlzlOzGK5AzGV6AVREB3Jf2kJbVJwn9AAcouoQonU6RnhDNu9IEGxjfOSdiY/95dY2Pmg4CPhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444421; c=relaxed/simple;
	bh=A6gHdTX14hzxoADRPGN9sifbwuNE31ws3WFjmms2JaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEBTOzZhyGbrUWj0Sk1X/qZj92S9fCh1KMBdJ8GyEyIM9QfwKpl8iBRolUI3bPc1TzgG6KS7RdMeOxVbfZRbtrbQgtVU8AzpLaK/klva+5uHghzbfZARHAGwPljFCiOjfqatNSsCLJjrxsyQDIIJ174waCI/vQ2kj/HDkKKjcNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBqQ3YaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89221C113CC;
	Thu, 18 Apr 2024 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713444420;
	bh=A6gHdTX14hzxoADRPGN9sifbwuNE31ws3WFjmms2JaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBqQ3YaWfdR4I/5K6W+ZmHFXCV92UX3hfcA/Mp0l0lz9wEdvHWlXQKRHkyebh2pEj
	 Pr/CvZr651wNVWxIScQj1N/zd+Q+3ZFkEjOP7ULrUBhvdwqsUozQ8PV52fXXVq/76Y
	 ieIry8zunRoeXrULaj8E7BgUl4yhoEL2kJNxL3VE=
Date: Thu, 18 Apr 2024 14:46:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "vmgenid: emit uevent when VMGENID updates"
Message-ID: <2024041829-gander-uninjured-5b2f@gregkh>
References: <20240418114814.24601-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418114814.24601-1-Jason@zx2c4.com>

On Thu, Apr 18, 2024 at 01:48:08PM +0200, Jason A. Donenfeld wrote:
> This reverts commit ad6bcdad2b6724e113f191a12f859a9e8456b26d. I had
> nak'd it, and Greg said on the thread that it links that he wasn't going
> to take it either, especially since it's not his code or his tree, but
> then, seemingly accidentally, it got pushed up some months later, in
> what looks like a mistake, with no further discussion in the linked
> thread. So revert it, since it's clearly not intended.
> 
> Fixes: ad6bcdad2b67 ("vmgenid: emit uevent when VMGENID updates")
> Cc: stable@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lore.kernel.org/r/20230531095119.11202-2-bchalios@amazon.es
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/virt/vmgenid.c | 2 --
>  1 file changed, 2 deletions(-)

Sorry about that, I picked it up thinking I had missed it previously:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


