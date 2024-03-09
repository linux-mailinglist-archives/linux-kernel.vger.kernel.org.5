Return-Path: <linux-kernel+bounces-97768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9541876F2A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F77E281EE0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D41E864;
	Sat,  9 Mar 2024 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OUKjhYfo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383016FF33;
	Sat,  9 Mar 2024 04:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709959003; cv=none; b=JMNSgODyxKkToCbigOo7tuFiLkGN2XSrOYliCCsImQUrBUHMOO1JzMMI0K1k+3MnrXCOMd2AZUZdQQ9MEXgWNwcA3ZVsGk/godIJyoVjgfXJZnp/wn96+TeoYDICyC2ZQwcxzZfXmAailWta3ecyjXko1brlTaWZn3HIW4io2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709959003; c=relaxed/simple;
	bh=i0OAAR81212W4woDBe/PQ8uKcxC/93Z5iRmjo8Evf0s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ftgtuDLPapD3TJik2p8sX/k128GHWwuPYl2JCZz9W3ym76C0cEzz/emlM5n6d10X36EElOs3GCvCxlxE86wcy1hEPZCwWhseWaiI0Zo8DYahWDFr8ceb8OL+p7H1SEZ0JkIumuN4lsPykkge1i2PgUkTnH4SeJPDspqWNFY9s10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OUKjhYfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3EEC433F1;
	Sat,  9 Mar 2024 04:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709959002;
	bh=i0OAAR81212W4woDBe/PQ8uKcxC/93Z5iRmjo8Evf0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OUKjhYfoqkhazCLlSOcQ5sAPFfiGlfOEe/6b6hODcZr1w8kJH60KN+GpUlwsrUCuP
	 toG0QwbzNc0R/HA/CbygibGknOWjLzMa44zmSHf7m0gkupcFCDrA/UmXXI0YL++00o
	 XPdtjYna8bJJp8KYNZD0IJT7H8xZ8N1JLHuPeikU=
Date: Fri, 8 Mar 2024 20:36:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: herbert@gondor.apana.org.au, chriscli@google.com, chrisl@kernel.org,
 ddstreet@ieee.org, linux-kernel@vger.kernel.org, sjenning@redhat.com,
 vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>,
 davem@davemloft.net, hannes@cmpxchg.org, linux-crypto@vger.kernel.org,
 linux-mm@kvack.org, zhouchengming@bytedance.com, nphamcs@gmail.com,
 yosryahmed@google.com
Subject: Re: [PATCH v6 0/2] zswap: remove the memcpy if acomp is not
 sleepable
Message-Id: <20240308203641.7fbe7e939b3483bd83b9769d@linux-foundation.org>
In-Reply-To: <CAGsJ_4xSwNZmHN5GvipS-1kELX2NBwHxoGE=aG4sekm1LcYVPw@mail.gmail.com>
References: <20240222081135.173040-1-21cnbao@gmail.com>
	<CAGsJ_4wMGNDcgc3pqSUicYoH7Z_miczkT=uwZU+yhDF0fd57Rg@mail.gmail.com>
	<20240308192334.845b27504a663ec8af4f2aad@linux-foundation.org>
	<CAGsJ_4xSwNZmHN5GvipS-1kELX2NBwHxoGE=aG4sekm1LcYVPw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Mar 2024 11:58:39 +0800 Barry Song <21cnbao@gmail.com> wrote:

> > >
> > > So it should be quite safe to pull this series into mm-tree now.
> >
> > But this zswap chage requires the presence of the other patches, yes?
> 
> As far as I understand, we rely on two driver fixes because those drivers didn't
> set the correct cra_flags needed by our patch1. Without those fixes implemented,
> two platforms might encounter issues: Intel with IAA (Intel Analytics
> Accelerator)
> and Hisilicon with ZIP. Other platforms should be unaffected.
> 
> The two driver fixes have been merged into the crypto tree.
> 
> >
> > So the mm.git tree alone will be buggy?  And if mm.git merges ahead of
> > the other trees, there will be a window where mainline will be buggy?
> 
> Before 6.9-rc1, there might be issues if mm enters Linus' tree before Herbert's
> crypto tree. However, by 6.9-rc1, everything should be fine.
> 
> >
> > If so, I think it wuold be better to merge the zswap patch in the next
> > merge window.
> >
> 
> Okay, I understand. Since this patch improves zswap's performance, I wanted
> it to be integrated sooner to contribute. However, I'm perfectly willing to
> respect your concerns and adhere to the community's best practices.
> 

OK.  I very much doubt if anyone is running those drivers on mm.git, so
adding it now isn't likely to hurt.

So I'll merge it now and shall aim to get it upstream very late in the
next merge window.

