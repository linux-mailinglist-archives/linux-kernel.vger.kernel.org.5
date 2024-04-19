Return-Path: <linux-kernel+bounces-151393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD28AAE09
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD731F21981
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF06784A3F;
	Fri, 19 Apr 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UlyzfiaU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5CF83A14
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528334; cv=none; b=TvhW8fprvMJoCxTS/mV0AOeRlK7F+NIvvF4vAVrkmwokGvTyfR/vtjLHAXfMn+dVatXfuqqeX5etdd/4TWOg9L+AgsKJzok3QQJfhOdxltl2L+mXnIOa155n9cyLrIsK1Bd2gQa4mRi94hZPx6emWzFOtk56BhxJOY/7ZTvcyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528334; c=relaxed/simple;
	bh=ZU1UTErqJhURgPa83kN0OX69TojMNxE5N8eAscWh5OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPMmfMUgfJcPbEaVIhwr17GRqeHoE8MMsjzqcNlxhx9QK2v5H+IQcpuf9n1G2TQ6tGGobDjEmUroa6wp9IyYqH+L3ofIImnK3FlzfbK5NcWFisF7vXIhKJ3J84ggzZBD9pUh5Eu29Aox00oHrDu5B5BtrF/rmlx/BkU+otOp4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=UlyzfiaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F06DC2BD10;
	Fri, 19 Apr 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UlyzfiaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713528329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sgvA+pX3m076VODfdVT5T36t6N6KpW3H7jte1/zPwIo=;
	b=UlyzfiaUf6CZ0D9OZ0DeUkyUqT80dx11ttf/Yb8RUie94AXuNtvwKEe6G2hGrh+8QT79dG
	QjiYRvF/B0sBcrvPUmofvfHKeKZFnnMSUhMYwxJHhuhRl4NFIi3PQWK7iAMTn5v3aWGOVv
	NQ+8z0gBddlE3ed43SExJbVJGnasKKM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0db50ce3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 12:05:29 +0000 (UTC)
Date: Fri, 19 Apr 2024 14:05:28 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Guoyong Wang <guoyong.wang@mediatek.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v2] random: Fix the issue of '_might_sleep' function
 running in an atomic contex
Message-ID: <ZiJeCPkcnEEmYqc-@zx2c4.com>
References: <20240419105453.5440-1-guoyong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240419105453.5440-1-guoyong.wang@mediatek.com>

On Fri, Apr 19, 2024 at 06:54:53PM +0800, Guoyong Wang wrote:
> In the case that a delay is acceptable for 'crng_set_ready', it can be
> deferred to a workqueue in order to accommodate different contexts.
> 
> Signed-off-by: Guoyong Wang <guoyong.wang@mediatek.com>
> ---
> v2: Compared to version 1, version 2 has removed the definition of
> 'execute_in_non_atomic_context' and always uses a workqueue to execute 
> 'crng_set_ready'.
> 
>   Send out the patch again for further discussion.
> 
> [1]: https://patchwork.kernel.org/patch/13595066

Sorry, but this doesn't make sense in terms of how kernel development is
typically done:

1) Before you sent this, I told you there was no need for a v2.
2) The removal snippet at the bottom applies to your previous v1, not to
   upstream code.
3) The other snippet is taken verbatim from a patch that I posted.
4) That snippet is already upstream:
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e871abcda3b67d0820b4182ebe93435624e9c6a4

There is no further work to do on this. Thank you for reporting the bug
- very appreciated - and for discussing the fix. But now we have a fix.
So everything is all set and there's nothing else to do and everyone can
be happy.

Jason

