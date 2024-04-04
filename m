Return-Path: <linux-kernel+bounces-132137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4E899024
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A992AB26A11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C485313C83F;
	Thu,  4 Apr 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vvT/rQWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2C13C81D;
	Thu,  4 Apr 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265808; cv=none; b=k2mh6mNGLhBCnPSQj/djQ8nYFqM7opUz7TrYZjSVDtdlE0fglwe20lNCoK+UJGRsSqHKcy1pWL+zhAnlzq/NAzOptv8zLrcFV2+d5Jjb48t9PheX68UDNBJq9MDKt9hzVXJTahBToBSOp8i9OdVg8DNCcwsccQDnKdSiBFPXrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265808; c=relaxed/simple;
	bh=mQV9wndFWdgcIzjox0OAtNgI94pyNZXkSBlBsQvwPbI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F0F3T0aSKffBN8i7GP9gDCT28/agMCFhBmNDogJ0SMoRdIpFosbMhbG0jewFRGO68odF3V4fgWQ6GqyeDQL6ZjyB4JxK3kpPxrxkuit1d82/y67BMsH1gy+wr6X0c5AnwM+2EahHGYtEI6Zeh8n2RGPlwLtlYK7P1MzcnlHEMHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vvT/rQWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51408C433C7;
	Thu,  4 Apr 2024 21:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712265807;
	bh=mQV9wndFWdgcIzjox0OAtNgI94pyNZXkSBlBsQvwPbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vvT/rQWzgJDr0V2xCe5oJnEkWOZJd3d2v4R5+z3ox1UnBdFPL8z47NK2/qafJ9FW5
	 W88A6MQWdUKe4MXiyYhJ8B/oPx/N3+C3OtecFrwPa7evbKBxKv5QIfACKONpkZS9OK
	 vNwbAw2PxEb+WZhrtb8Cx63D1g5eNLyOrfxtNH8s=
Date: Thu, 4 Apr 2024 14:23:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dax/bus.c: replace WARN_ON_ONCE() with lockdep asserts
Message-Id: <20240404142326.b3d5b0f3f7b9f25f1a16288a@linux-foundation.org>
In-Reply-To: <20240402-vv-dax_abi_fixes-v1-1-c3e0fdbafba5@intel.com>
References: <20240402-vv-dax_abi_fixes-v1-1-c3e0fdbafba5@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Apr 2024 00:24:28 -0600 Vishal Verma <vishal.l.verma@intel.com> wrote:

> In [1], Dan points out that all of the WARN_ON_ONCE() usage in the
> referenced patch should be replaced with lockdep_assert_held(_write)().
> 
> Replace those, and additionally, replace a couple of other
> WARN_ON_ONCE() introduced in the same patch for actual failure
> cases (i.e. when acquiring a semaphore fails in a remove / unregister
> path) with dev_WARN_ONCE() as is the precedent here.
> 
> Recall that previously, unregistration paths was implicitly protected by
> overloading the device lock, which the patch in [1] sought to remove.
> This meant adding a semaphore acquisition in these unregistration paths.
> Since that can fail, and it doesn't make sense to return errors from
> these paths, retain the two instances of (now) dev_WARN_ONCE().
> 
> ...
>
> @@ -471,6 +471,7 @@ static void __unregister_dev_dax(void *dev)
>  
>  	dev_dbg(dev, "%s\n", __func__);
>  
> +	lockdep_assert_held_write(&dax_region_rwsem);
>  	kill_dev_dax(dev_dax);
>  	device_del(dev);
>  	free_dev_dax_ranges(dev_dax);

This is new and unchangelogged?

I'm taking Dan's reply to your patch as Not-A-Nack ;)

