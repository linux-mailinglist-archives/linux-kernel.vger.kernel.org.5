Return-Path: <linux-kernel+bounces-71025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C54859FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C55285FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BD723757;
	Mon, 19 Feb 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVMFI7/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6E23749;
	Mon, 19 Feb 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334684; cv=none; b=sotTw1N8K9UY4lPLDFVhgZOQH92/IHr/bfLaRKtvNTJ8Q3MymYPxgjW415lbpen8sLHXFmurnKwlbmG6XgxazOi84GwaQqOL51Yvm9sRhuNLXcXT+Mx+LrwstlCHuf9BG9rLM1ML84wwuVNaWERZ1CLChLexY/eG8fuyt61csp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334684; c=relaxed/simple;
	bh=cHV74QhceqZ2+XbCvJJj3Cf7xONLS1W+pjFWm1YMEvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANWzkWz9aQ56C6Emtjd/PGrmyxllMX3/rQIrBJpEr49hTcAkydLacQtVQQlGVR7ocy0mSRgEEVzaFB4diciQiPf4MHt7bxpaEOdxM0fu4kS9RdxA2e191jGfuGdZarZjju4zmf7a0eXFhP5qVYLT/4Xwe5AWDlX0rsbtXKOa6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVMFI7/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6340DC433C7;
	Mon, 19 Feb 2024 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334684;
	bh=cHV74QhceqZ2+XbCvJJj3Cf7xONLS1W+pjFWm1YMEvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVMFI7/r5bqKUYpio0866Qs0B9QoX/6XMIm68I8w0UzwXl3a/lxe9PAxq1eZToYPj
	 69F3XJuzbGXvFrcTdcMGoGV9bkVXsvH9T93+9hr1nuUmv5jrjtSf7ruCp4fj9i3Cig
	 liXrHNa/T+3EXOHlXWS4We5DXihfDWl6BfFd0Y5X4quNwWu7YyIT2WnDHv7svxAIqS
	 Ewl7VXNyzk/09jPz3KlacNnBhqNEbVSzWxpuHdDBJHGuKuJYajP+UuT9Ay3a9+iwHb
	 c3YTtJdwuGQdk9ebqphhZA2Z+gJuI+rGO4GKIPWs04wAbvEcdOuZRoksXY57b8yKE1
	 Vd7aJXtLYMCPA==
Date: Mon, 19 Feb 2024 09:24:39 +0000
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v3 0/3] Fix double allocation in swiotlb_alloc()
Message-ID: <20240219092438.GB4105@willie-the-truck>
References: <20240205190127.20685-1-will@kernel.org>
 <20240219063527.GA4580@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219063527.GA4580@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hey Christoph,

On Mon, Feb 19, 2024 at 07:35:27AM +0100, Christoph Hellwig wrote:
> Robin and Petr, does this looks good to you now?

FWIW, I'm likely to send a v4 addressing another issue reported by
Nicolin with NVME and 64k pages [1], so you may as well wait for that.

Cheers,

Will

[1] https://lkml.kernel.org/r/cover.1707851466.git.nicolinc@nvidia.com

