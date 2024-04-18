Return-Path: <linux-kernel+bounces-150068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFC78A99F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB88B21873
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71641EA8F;
	Thu, 18 Apr 2024 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CQyTwiPo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BA3BBFE;
	Thu, 18 Apr 2024 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443701; cv=none; b=FHk75pm8LvIyFvAA9nK+zKH2ZWY+MJnQfKygmreWRVu8nuHV9BZlt6JJp32GbfkoYYkNFMBNHcpgn/TdH7APQQgVSB5d6W1t2S4mpAjvcZmvN76XvY6NpJE4AaKCRN318lXIiUNd+zp9YYPytfVaJLXSn5nN43ZJ87/VZNrSaqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443701; c=relaxed/simple;
	bh=QoJZ9cDGA2Of8vEpXDv/CLcAZv4SkKX2GQYHhqv/IbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTboaRtiKpirj8eMhvI1mMUUSbPkisKCgqrZux5MQ+LwCidrvB/p5Nn7aiGgCTqyYpFiQX/vvexRPm99nntgVuvuI7/isyeHEzTzExAv3NTNbzdz0hpgt1eILWuDJJFk69u0CWQnZHI/H7IIPvsQNPK0NAhVHmKjjh1qZ/IFaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CQyTwiPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC3CC113CC;
	Thu, 18 Apr 2024 12:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713443700;
	bh=QoJZ9cDGA2Of8vEpXDv/CLcAZv4SkKX2GQYHhqv/IbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQyTwiPoVVC0pNAFTtI1GZv01E2u9Ol/4Cjb3RJC+O0Co/QR9Cydl/HrENH+jiyF8
	 pxewW0+3oBDpvtyIBzfGPd2tHdQkLNxC28zcq5P+5JEznmItWBBjuy1eX0XkQ9QXh6
	 eKSbPs/NnSfARu3CQeMLGot5uovNpuKX8WWiBMFQ=
Date: Thu, 18 Apr 2024 14:34:57 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-cve-announce@vger.kernel.org" <linux-cve-announce@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-26920: tracing/trigger: Fix to return error if failed
 to alloc snapshot
Message-ID: <2024041805-rippling-entourage-1a72@gregkh>
References: <2024041738-CVE-2024-26920-a681@gregkh>
 <6fa1eb4368cbaa2d0b243539f1d91692da95e117.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa1eb4368cbaa2d0b243539f1d91692da95e117.camel@oracle.com>

On Thu, Apr 18, 2024 at 11:59:41AM +0000, Siddh Raman Pant wrote:
> Hi Greg,
> 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > tracing/trigger: Fix to return error if failed to alloc snapshot
> > 
> > Fix register_snapshot_trigger() to return error code if it failed to
> > allocate a snapshot instead of 0 (success). Unless that, it will register
> > snapshot trigger without an error.
> 
> This commit is problematic on 4.19.y, 5.4.y, 5.10.y, and 5.15.y,
> and should be reversed, and this CVE should be rejected for those
> versions.

Then please submit a patch for this.

But note, CVEs are not for specific versions, sorry.  We give a hint as
to what kernel versions might be affected, but we don not assign CVE to
versions.


> 
> The return value should be 0 on failure, because in the functions
> event_trigger_callback() and event_enable_trigger_func(), we have:
> 
> 	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> 	/*
> 	 * The above returns on success the # of functions enabled,
> 	 * but if it didn't find any functions it returns zero.
> 	 * Consider no functions a failure too.
> 	 */
> 	if (!ret) {
> 		ret = -ENOENT;
> 
> Thus, the commit breaks this assumption.
> 
> This commit needs b8cc44a4d3c1 ("tracing: Remove logic for registering
> multiple event triggers at a time") as a prerequisite, as it removes
> the above.

Should we just take that patch instead?

thanks,

greg k-h

