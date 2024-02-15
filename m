Return-Path: <linux-kernel+bounces-66943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F021856419
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E01B28B01
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0DA12F399;
	Thu, 15 Feb 2024 12:59:57 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3669130ACA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001997; cv=none; b=rn4VJ2fdY1UZSRvv1RQpwNH89CX7UBequVeQqvvtQujJ+5xLQ82rZd7LnACmvAnBvYndfmasW+svoHQ/MZQynjg6dQOCFcV3X9wB4MjWxAtoxF1mxntad4XwhW9da7IYddyi3vHMjQv2kPpxTCKeO5Ca5CilrAizAujRAreBCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001997; c=relaxed/simple;
	bh=UC17XZcFYPFqDIb9k2pMp2QXwXJqh0VGue9d5HvnQ3A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AFLjFkQlQ11iKbSpbRe62Br3rHYhyaTVA7e4diVDbUHulN3NqIfbgPps/sKvrbEaK9eMXhtNYWKMvXmca1KdxPEWTqgkcaNnbChFHAi5Lj2snxVtELxrXl5Xg2x++I14OFYAIo+aEpQ41ZNknHDguAQE3Bjp1uHvbgivz43Ss7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbFX94csjz4x0t;
	Thu, 15 Feb 2024 23:59:53 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, christophe.leroy@csgroup.eu, christophe.leroy@c-s.fr, Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, nixiaoming@huawei.com, wangbing6@huawei.com, douzhaolei@huawei.com, wangfangpeng1@huawei.com
In-Reply-To: <1705974359-43790-1-git-send-email-xiaojiangfeng@huawei.com>
References: <1705974359-43790-1-git-send-email-xiaojiangfeng@huawei.com>
Subject: Re: [PING PATCH] powerpc/kasan: Fix addr error caused by page alignment
Message-Id: <170800185784.599237.15590850355904015757.b4-ty@ellerman.id.au>
Date: Thu, 15 Feb 2024 23:57:37 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 09:45:59 +0800, Jiangfeng Xiao wrote:
> In kasan_init_region, when k_start is not page aligned,
> at the begin of for loop, k_cur = k_start & PAGE_MASK
> is less than k_start, and then va = block + k_cur - k_start
> is less than block, the addr va is invalid, because the
> memory address space from va to block is not alloced by
> memblock_alloc, which will not be reserved
> by memblock_reserve later, it will be used by other places.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/kasan: Fix addr error caused by page alignment
      https://git.kernel.org/powerpc/c/4a7aee96200ad281a5cc4cf5c7a2e2a49d2b97b0

cheers

