Return-Path: <linux-kernel+bounces-16965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9950F824694
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD811C23F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B457225568;
	Thu,  4 Jan 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmUFVV+7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2B2555C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1113CC433C7;
	Thu,  4 Jan 2024 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704386859;
	bh=gUL3ydGH9gI1f05tOKDtRIs4ksaWn/LR5N9XebQaO1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmUFVV+7jEZvhSjq03hi0FLNJ85H8T6nqcxIvwlhNEJls+vxHNPopDZalFbP6Uo81
	 qPR6VobMUiIbrOgEkd27J59G2rbFxza+r0VWkux2Z7yB4YLeaEUvVXgraY4wvILYcf
	 zpjVhyVt0L8x3rq44R4OW/VNZq0iaR668hl2VMbm8vXPM9aUTylTNEy5r9aKgVxWOq
	 WQhkOngqIIeDJh+k2aryhU28WPQWfhhDseHzll2NRbm7zdmBjt1i3QXBpuH37iUHog
	 w8+KjRy3K67WgWcVtLr5iGaqLNJEgb9mdxfH4aI/y4fGKxuemOdHHqKCImDzE/A+n7
	 5EWpxHeVv9sFQ==
Date: Thu, 4 Jan 2024 09:47:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
Message-ID: <ZZbhKM0L8pFYX_zd@kbusch-mbp>
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104163826.10561-1-stuart.w.hayes@gmail.com>

On Thu, Jan 04, 2024 at 10:38:26AM -0600, Stuart Hayes wrote:
> Currently NVME namespaces are scanned serially, so it can take a long time
> for all of a controller's namespaces to become available, especially with a
> slower (fabrics) interface with large number (~1000) of namespaces.
> 
> Use async function calls to make namespace scanning happen in parallel,
> and add a (boolean) module parameter "async_ns_scan" to enable this.

Hm, we're not doing a whole lot of blocking IO to bring up a namespace,
so I'm a little surprised it makes a noticable difference. How much time
improvement are you observing by parallelizing the scan? Is there a
tipping point in Number of Namespaces where inline scanning is better
than asynchronous? And if it is a meaningful gain, let's not introduce
another module parameter to disable it.

