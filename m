Return-Path: <linux-kernel+bounces-140206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00768A0CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671CC1F21CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BD7145B10;
	Thu, 11 Apr 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E15cJJmQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6AC13DDDD;
	Thu, 11 Apr 2024 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829165; cv=none; b=rUQ0kqJaYkH5vJqHreVw6ty4PXGnlXCnuCYo9mbbusSOUb0b+4RK11pImmHEVr8f1Xj/luA49fUzXoEWlPE1AJeZ7oRdUSwePwVswWZx7+Prow0YEHAfOnwIQnEuePywByjS1+JNpKncEMKmOVx2X3CyWz1jyxbgYIbm12TVzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829165; c=relaxed/simple;
	bh=6LPoBgM4dGej3G/EWTMFuCJO16wnG8LmgDKZpio/Qhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncPUzk4TXiNpglkYSWaCHgXND1hw5rBUwCk84fncucsXsEOw+eaTkmOrukXb/VOpCwrBJ2BJvJe3OHcpP8gB/dIYuX9WFVPXXQnR626ZJsGrS0iJPGTKPPWG+K8/pbAcRgu3nWmylP4YMtnjDpqa49EDNi9LfOtVmxDRk0QeJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E15cJJmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9730FC433C7;
	Thu, 11 Apr 2024 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712829165;
	bh=6LPoBgM4dGej3G/EWTMFuCJO16wnG8LmgDKZpio/Qhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E15cJJmQXcTEWhPntWZaEqhzjfV6BmzTLhrLy5VszuykEJiRpYvX63Gw8sx+KCiFF
	 0dcPdr8um1FyZ4lFMRUsmBHeDQG2mH1RtxIYU0Ubg1uoKbQ3qeLYS5KfqxwvWBC8d7
	 9CfWanz66AH9E38nL2POUCwZEQ8YVmKKqb+HIqmM=
Date: Thu, 11 Apr 2024 11:52:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: stable@vger.kernel.org, mpatocka@redhat.com,
	torvalds@linux-foundation.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, nhuck@google.com,
	peterz@infradead.org, mingo@elte.hu, yukuai3@huawei.com,
	yangerkun@huawei.com, yi.zhang@huawei.com,
	lilingfeng@huaweicloud.com
Subject: Re: [PATCH 6.6] Revert "dm-crypt, dm-verity: disable tasklets"
Message-ID: <2024041103-reputable-bobsled-585f@gregkh>
References: <20240411091539.361470-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411091539.361470-1-lilingfeng3@huawei.com>

On Thu, Apr 11, 2024 at 05:15:39PM +0800, Li Lingfeng wrote:
> This reverts commit 5735a2671ffb70ea29ca83969fe01316ee2ed6fc which is
> commit 0a9bab391e336489169b95cb0d4553d921302189 upstream.
> 
> Tasklet is thought to cause memory corruption [1], so it was disabled in
> dm-crypt and dm-verity. However, memory corruption may not happen since
> cc->io_queue is created without WQ_UNBOUND [2].
> Revert commit 5735a2671ffb ("dm-crypt, dm-verity: disable tasklets") to
> bring tasklet back.
> 
> [1] https://lore.kernel.org/all/d390d7ee-f142-44d3-822a-87949e14608b@suse.de/T/
> [2] https://lore.kernel.org/all/4d331659-badd-749d-fba1-271543631a8a@huawei.com/
> 
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>  drivers/md/dm-crypt.c         | 38 +++++++++++++++++++++++++++++++++--
>  drivers/md/dm-verity-target.c | 26 ++++++++++++++++++++++--
>  drivers/md/dm-verity.h        |  1 +
>  3 files changed, 61 insertions(+), 4 deletions(-)

What is the commit id of this in Linus's tree?  And why only 6.6.y?

thanks,

greg k-h

