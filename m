Return-Path: <linux-kernel+bounces-131356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F118986AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AE81F27B90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E786629;
	Thu,  4 Apr 2024 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Owq9783G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8E85934;
	Thu,  4 Apr 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232006; cv=none; b=AmCrKxk2yMprxghIt8e1xTGoXrWj2L+2sM/ZNy7IgLhCAlaa9/EEZ2WsxCPEXlU3WNp4jsTN6eK34HlOpKUYIvJw1PU36U7PwjqaiZtb/D6GjWtcbkvakkG1oVBvw/aHujN/F9h4I3WhPkWp8SUWsc8DaeuWuNEVFBJISDwQJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232006; c=relaxed/simple;
	bh=Px5gxMf6tE7367j2YyGFk4bSXXCZIlJ5JXSZauI8+Js=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XAEOg9GbWQyqAHDbinLKpiiQdFOtIj6jwO3EPkisYjIRu8M5Zx2ZRweMSU/8p5EFlLOw8r1VDxwRULNSjY2iL+YoZ7Mck+FeGrQiRfPI3746moJ9ND+geqLJ0FrgRSHCS3rUWU65rPeJNYQmpi9e1+J8bGEf2FgOXU3qEvml/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Owq9783G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B951C433C7;
	Thu,  4 Apr 2024 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712232005;
	bh=Px5gxMf6tE7367j2YyGFk4bSXXCZIlJ5JXSZauI8+Js=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Owq9783GbLDLeZP9d19ztQwHpwDD7NCh7fP637lINhBASzGKfF966xh6zQM5+l723
	 TbuddxuuXBidy+OfRIqhWNTOQH/f+jD7zvcLlro83KbfyNQAoONncguuKf/mGCLAg3
	 X2UKVhUKwhrS4z8U97khL6U7WuqfldW2mHQM6PRLlWkj16oQATi8u+qXZzQi3E1Ayn
	 vRo2hwDw9bdkRfjcu43J2gU5TVOMR4OO6YnjGp4FrNd9DacpOs+An6mPQUULa69sYw
	 IBS0yHkcAxm99xUR7FrRLzud6bDEtBAredMLIB8dkUwOD01CmZc9aH5aTgos/4nkzL
	 Sj6j2m4yqvIRw==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com,  kuba@kernel.org,  davem@davemloft.net,
  pabeni@redhat.com,  edumazet@google.com,  elder@kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  nbd@nbd.name,
  sean.wang@mediatek.com,  Mark-MC.Lee@mediatek.com,  lorenzo@kernel.org,
  taras.chornyi@plvision.eu,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  quic_jjohnson@quicinc.com,  leon@kernel.org,
  dennis.dalessandro@cornelisnetworks.com,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] allocate dummy device dynamically
References: <20240404114854.2498663-1-leitao@debian.org>
Date: Thu, 04 Apr 2024 14:59:59 +0300
In-Reply-To: <20240404114854.2498663-1-leitao@debian.org> (Breno Leitao's
	message of "Thu, 4 Apr 2024 04:48:40 -0700")
Message-ID: <87plv549ts.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> struct net_device shouldn't be embedded into any structure, instead,
> the owner should use the private space to embed their state into
> net_device.
>
> But, in some cases the net_device is embedded inside the private
> structure, which blocks the usage of zero-length arrays inside
> net_device.
>
> Create a helper to allocate a dummy device at dynamically runtime, and
> move the Ethernet devices to use it, instead of embedding the dummy
> device inside the private structure.
>
> This fixes all the network cases except for wireless drivers.
>
> PS: Due to lack of hardware, unfortunately all these patches are
> compiled tested only.

BTW if it helps, and if you have an ath10k or ath11k patch already, I
can run a quick test on real hardware.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

