Return-Path: <linux-kernel+bounces-18324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8820C825B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D78928172F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C70F36099;
	Fri,  5 Jan 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUV3A2sx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ED63608A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7112CC433C8;
	Fri,  5 Jan 2024 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704486315;
	bh=bAZttlTQMZlhQC6CNZBZC3zQ6+w00XhSfvWG1FFDVUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUV3A2sx8AH0megKnsNxucQs1h21xGk3A/pWRHNqKOhLfNWoSIL/yUIqaMY01VE2p
	 vvv5DSmr64xBG+1mvJFzxMBCPMNMmEABKKeCpD5IBykBYa9hvo6s+08dvPJQZp1u4h
	 gI+wqSrdug2BY75/P3vkQKM29PLAX4ElpZup9+3hUk88/hjtfr2rwHqSil7LmVXSBe
	 TiM1E6xf7ebVNZKumSOF/WJYvXbjijsASAlBt8amZpIvW20qj/Epu+XPh7XhTq7Wod
	 iejiRK7EqwaR9aD+CLJZqm1trUGc+pM/GZv+R04cPx0aIggY1wlAp1UCR3eGIPKkFj
	 G6iFNZhJNBX1w==
Date: Fri, 5 Jan 2024 13:25:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: trace: avoid memcpy overflow warning
Message-ID: <ZZhlqHLfB3o1Pzuc@kbusch-mbp>
References: <20240103155702.4045835-1-arnd@kernel.org>
 <20240103155702.4045835-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103155702.4045835-2-arnd@kernel.org>

On Wed, Jan 03, 2024 at 04:56:56PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A previous patch introduced a struct_group() in nvme_common_command to help
> stringop fortification figure out the length of the fields, but one function
> is not currently using them:
> 
> In file included from drivers/nvme/target/core.c:7:
> In file included from include/linux/string.h:254:
> include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                         __read_overflow2_field(q_size_field, size);
>                         ^
> 
> Change this one to use the correct field name to avoid the warning.
> 
> Fixes: 5c629dc9609dc ("nvme: use struct group for generic command dwords")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied to nvme-6.8 with Christoph's line-wrap suggestion.

