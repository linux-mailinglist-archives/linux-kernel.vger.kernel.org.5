Return-Path: <linux-kernel+bounces-18355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF2E825BFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418451F2440F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3770224EF;
	Fri,  5 Jan 2024 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLbb29Hh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAA621A0D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30E8C433C7;
	Fri,  5 Jan 2024 20:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704488238;
	bh=gAD8bxOLE5Ams9cdsSGbh8+d7ypMq1jhYSonntHU1zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLbb29Hh0929kqeCl2us54wEX8aRCCWeYJqib0/xcASz3L+bpsRSinR8COEBw76gr
	 PC76G6WeAGQFq9piiWdgkvZTmr6p6saVUSHOoxfyNfTZW6IqN/wvf2wscJKKJwIM/F
	 BsdhUGRz0yIgEKMjEfQwJ683TZPDzGlnbRZrCYHxhQNu3gx5k1YYCPKmPiLZqaLLBC
	 MsV7LJdibxxGn1gKJQFbJNN8LXk7/Cew/qVKq0H3lyAA4ghJII+qPigKEx8BDvfSpd
	 cUKv354IHzPHkIc93FxMYMeZCW3mqYdyZZV1GaCduy1LYje7aLY5U5pMFkqT0f1rqe
	 xqxtCiMMsKNdg==
Date: Fri, 5 Jan 2024 13:57:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] nvmet: re-fix tracing strncpy() warning
Message-ID: <ZZhtK6vjk5UD7pxi@kbusch-mbp>
References: <20240103155702.4045835-1-arnd@kernel.org>
 <ZZhli2FWXwP1XSRG@kbusch-mbp>
 <20508695-b9e6-4aaa-9c78-84891c1a8f9a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20508695-b9e6-4aaa-9c78-84891c1a8f9a@app.fastmail.com>

On Fri, Jan 05, 2024 at 09:36:38PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 5, 2024, at 21:24, Keith Busch wrote:
> > On Wed, Jan 03, 2024 at 04:56:55PM +0100, Arnd Bergmann wrote:
> >> @@ -53,8 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
> >>  		return;
> >>  	}
> >>  
> >> -	strncpy(name, req->ns->device_path,
> >> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
> >> +	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
> >>  }
> >
> > I like this one, however Daniel has a different fix for this already
> > staged in nvme-6.8:
> >
> >  
> > https://git.infradead.org/nvme.git/commitdiff/8f6c0eec5fad13785fd53a5b3b5f8b97b722a2a3
> 
> +       snprintf(name,
> +                min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1),
> +                "%s", req->ns->device_path);
> 
> Don't we still need the zero-padding here to avoid leaking
> kernel data to userspace?

I'm not sure. This potentially leaves trace buffer memory uninitialized
after the string, but isn't the trace buffer user accessible when it was
initially allocated?

For correctness, though, yes, I think you're right so I may just back
out this one and replace with yours since we haven't sent a recent 6.8
pull request yet.

