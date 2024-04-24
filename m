Return-Path: <linux-kernel+bounces-157678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5258B1467
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBC61C21F51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D44E13D619;
	Wed, 24 Apr 2024 20:19:24 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9113C9C6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989963; cv=none; b=rJtLk6bNbAHLZ6KRTRwhEiptqfSv/NPsWsiFcqCdJaYZ6ymcDMkkYHx2xpnZWZsymWC+kpQqsryiuTnKVXMRnGESjGWA1jvAJAL5XdubGqQdBYKoLwAiWOJXsUM/vFBZh5ysJVFhf+ztjjNyBB2ucLQU0kfOMRVFusT/p89Axzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989963; c=relaxed/simple;
	bh=lM6Zi1R6SzwMyzjHnYSWzYDH7inurrGkPEDar0BeHYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC05of7l40TKO9MPvDEjh5Z/b4kVO/Jl1ONkwzpV9+b5vjH3ZwEowy9VC4B+7/9PHygKbbOgFrUC6T4vbcIXrjXtaJGuZ5yxqM49DDHDK20w6Bpr3p/QMjhzWyBumoZ5+bOmbqdIb5yGi3HsRmus4kk77pYhrx3QAH9g6yUjpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AFE140003;
	Wed, 24 Apr 2024 20:19:18 +0000 (UTC)
Message-ID: <d738dfc0-66af-4dad-bd60-a68c900bf807@ghiti.fr>
Date: Wed, 24 Apr 2024 22:19:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cache: sifive_ccache: Auxiliary device support
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org
References: <20240410232211.438277-1-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240410232211.438277-1-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 11/04/2024 01:22, Samuel Holland wrote:
> As of commit c90847bcbfb6 ("cache: sifive_ccache: Partially convert to a
> platform driver"), the cache subsystem binds a platform driver to the
> Composable Cache's DT node. This prevents the perf subsystem from doing
> the same for the new PMU driver[1]. To allow using both drivers at the
> same time without conflicts or module linkage dependencies, attach the
> PMU driver to the auxiliary device bus. While at it, prepare to use the
> auxiliary device bus for the EDAC driver as well, which significantly
> simplifies that driver. The actual EDAC driver conversion has to wait
> another development cycle to avoid dependencies between git trees.
>
> [1]: https://lore.kernel.org/linux-riscv/20240216000837.1868917-3-samuel.holland@sifive.com/
>
>
> Samuel Holland (4):
>    cache: sifive_ccache: Silence unused variable warning
>    cache: sifive_ccache: Use of_iomap() helper
>    cache: sifive_ccache: Export base address for child drivers
>    cache: sifive_ccache: Add EDAC and PMU as auxiliary devices
>
>   drivers/cache/Kconfig              |  1 +
>   drivers/cache/sifive_ccache.c      | 94 +++++++++++++++++++++---------
>   include/soc/sifive/sifive_ccache.h |  8 +++
>   3 files changed, 74 insertions(+), 29 deletions(-)
>

I took a quick look and I'm not sure if the whole patchset is a fix for 
6.9 or if only patch 1 is?

Alex


