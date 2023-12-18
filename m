Return-Path: <linux-kernel+bounces-3066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7418166DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1D6282C78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED0D26B;
	Mon, 18 Dec 2023 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KMbQgL2l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB0C8F1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12322C433C7;
	Mon, 18 Dec 2023 06:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702882396;
	bh=fVHeQ3XB4kGVbvG8trcdzhlOFXJCIm6geR4rTO2sLwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMbQgL2l2gO7u+z9sLtANaxVKrdt7WWhJzTo33ErQwZM0trRZnj8Eu8P6UkReAvUR
	 cEbMcYaBqCELd14ibErazf3lEoxHWLYOgERZMu1vWv4XbYu7VSihZBlwQwKABQiE2X
	 LFqWxeAyuZ5MO8J1Fbjn80uyVzXVs9rDEhz7kjvI=
Date: Mon, 18 Dec 2023 07:53:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Jing Xia <jing.xia@unisoc.com>,
	Jing Xia <jing.xia.mail@gmail.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] class: fix use-after-free in class_register()
Message-ID: <2023121858-slider-trustful-44a4@gregkh>
References: <20231218024403.1076134-1-chunyan.zhang@unisoc.com>
 <2023121830-proxy-washed-ae4d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121830-proxy-washed-ae4d@gregkh>

On Mon, Dec 18, 2023 at 07:52:18AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 18, 2023 at 10:44:03AM +0800, Chunyan Zhang wrote:
> > From: Jing Xia <jing.xia@unisoc.com>
> > 
> > The lock_class_key is still registered and can be found in
> > lock_keys_hash hlist after subsys_private is freed in error
> > handler path.A task who iterate over the lock_keys_hash
> > later may cause use-after-free.So fix that up and unregister
> > the lock_class_key before kfree(cp).
> 
> What task iterates over all hashes?
> 
> And can you put ' ' after your '.'?
> 
> And how was this found?

And more importantly, how was this tested?

thanks,

greg k-h

