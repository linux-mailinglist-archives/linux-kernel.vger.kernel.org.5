Return-Path: <linux-kernel+bounces-3064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451C8166D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71D41F21C52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEFC748D;
	Mon, 18 Dec 2023 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kcf71oHu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB457461
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BE5C433C8;
	Mon, 18 Dec 2023 06:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702882341;
	bh=llh1Y16tgU5GVwSkmJ1KisMeuRqZAgd9EWfxj3tYCnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kcf71oHuLCTBdRo+/clmZ8oXoWXFp5SAfo7y+b/I+f+9BE36gxpz9SlxMeq5jQyzB
	 L5RwYSj26n1ZJCyTfPm8buY844AxadGtjGVJUT5f1kfhguUFQNkQV2AqLBEr5CmnH8
	 tbt0SLWyH3zP+C30Ehy1NLlXMezCXbH0mWx0UZpI=
Date: Mon, 18 Dec 2023 07:52:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Jing Xia <jing.xia@unisoc.com>,
	Jing Xia <jing.xia.mail@gmail.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] class: fix use-after-free in class_register()
Message-ID: <2023121830-proxy-washed-ae4d@gregkh>
References: <20231218024403.1076134-1-chunyan.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218024403.1076134-1-chunyan.zhang@unisoc.com>

On Mon, Dec 18, 2023 at 10:44:03AM +0800, Chunyan Zhang wrote:
> From: Jing Xia <jing.xia@unisoc.com>
> 
> The lock_class_key is still registered and can be found in
> lock_keys_hash hlist after subsys_private is freed in error
> handler path.A task who iterate over the lock_keys_hash
> later may cause use-after-free.So fix that up and unregister
> the lock_class_key before kfree(cp).

What task iterates over all hashes?

And can you put ' ' after your '.'?

And how was this found?

> 
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

What commit id does this fix?

Also note in the changelog that this only can happen if lockdep is
enabled, which is not true for normal systems.

thanks,

greg k-h

