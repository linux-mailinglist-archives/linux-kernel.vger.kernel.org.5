Return-Path: <linux-kernel+bounces-122451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD388F7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73971F26DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDD14CB30;
	Thu, 28 Mar 2024 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qjH7Sl8T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB523FBA7;
	Thu, 28 Mar 2024 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711606088; cv=none; b=kKyzS9G/GK2fyncaL1XeKtcYeShiPaJBUHet9stZENksVoPbwuT21WC5o4lpxdYxEgK5uL4PVdb4e2GVAxuqtXQZvj72MUHDCcleBwz7R8EOlIsAcYBynMRL9WUGDNrW1gFT9K95SMyo0qV5dgCRpbvp+DRoSbEEDmDZBFNkY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711606088; c=relaxed/simple;
	bh=nnA0rFWt7SnSLovWF/sQubwVjNxtvJ50X2vkuAyeF2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFEAB+gcMf49hGrtOXAvBQ+Khqqv5kRU9/oE940Baw69Ja/QpQPFG+Az5jx4uMnQRXRPMElU7rhSVSiEslxmHcr06yNpYM945vLbRKI9jcFqId5MucfKXMiP4XhE1SpgfvqaixxRtKmMpYjbL5lTCGOR5D6+zrQU8gtM0/vXdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qjH7Sl8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7DDC433F1;
	Thu, 28 Mar 2024 06:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711606088;
	bh=nnA0rFWt7SnSLovWF/sQubwVjNxtvJ50X2vkuAyeF2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjH7Sl8Ttnt/cWpeDgGWRdBc/J960MVlSsb7g/jmVNwg2cnO+SMVwNQbttnJMprMx
	 XCB9gYBkFSSHWroTyjRL8qyV5dFOfMpMo6kdPYqOYVVJkAYdXaPfA6/dX0BsmqdTit
	 6M6z+G25cAqF0DWZrPwZhrK3uEkl3faEExvXv6uM=
Date: Thu, 28 Mar 2024 07:08:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: alison.schofield@intel.com, paul@paul-moore.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LANDLOCK: use kmem_cache for landlock_object
Message-ID: <2024032836-grief-parish-88e7@gregkh>
References: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Thu, Mar 28, 2024 at 04:55:57AM +0530, Ayush Tiwari wrote:
> Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> struct landlock_object and update the related dependencies.

This says what you do, but not why you want to do any of this.  Why is
this change needed?  What benifit does it bring?

And why did you cc: the staging mailing list?

thanks,

greg k-h

