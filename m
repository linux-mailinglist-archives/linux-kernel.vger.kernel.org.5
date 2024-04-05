Return-Path: <linux-kernel+bounces-133052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CE7899E18
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3A7B22093
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1CC16D31D;
	Fri,  5 Apr 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx+q/GGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AB6FE09;
	Fri,  5 Apr 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322787; cv=none; b=b40jsazFjO2kLk7ovLrLNI49TF9lWlmIeeIUML1kxPV72KF2j3nMJtgNHnGS1vr7ghFln8+rzqvyvsSw6Y5jkzIOtyESX1V4ANwfmifHZYafo58W6H8xJ49uBmkClSYEto4HgVYLK3cA4JxDJoRu/f4elZ+mM8PrkaV7BvG+4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322787; c=relaxed/simple;
	bh=VEyed/ecHyBqgaA8v+Xe6IFTwm1TtgE9SEoK//nPgEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aRKSNkfwECRcwwn19gJ3QSDPsgSoIQQiGO3IBCZzaQn/lujhtHsU9bC42jqZ5vytiKfYILu/tF3WBg0XGcuOTk1JdRw8coerGQqOVWEnYCRM7An9r4/FAIUywr4NJ1tdGBk25cGUtHJd4GcS6iWfTV2UlKeoftr3Fz0f6z07vHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tx+q/GGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925C9C433F1;
	Fri,  5 Apr 2024 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322786;
	bh=VEyed/ecHyBqgaA8v+Xe6IFTwm1TtgE9SEoK//nPgEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tx+q/GGZxrVngkwOS8gFgGmvPhKZBJty9/r0v9W6KxDR4q7LW2DKE/90/6iTg5Lpp
	 khAQFoyq/950o5C66xexkrWnwTvP9ODsID+Ue1i2Kg+Mv1j9EcEGzJ0NUdcMlCC0h8
	 o0QgSPnKlDtSyjET8kvChwpZfv+mgx7u5mwgGpTq5YV7IWNGuxzVR8RZhrM4WLEYNn
	 48DvvijRxSE+RtmHTq4kDEZGuUhBuKTYG3ORkecEMwB9cUoVgjRDTMewTF6kagtQWR
	 n2QLnkWlXXRJlMrflacttX1VbthH0jqld+PFv69b2R3OznwDng65dX6XH6yNARcGo7
	 MfNIIZDZbJHzg==
From: Maxime Ripard <mripard@kernel.org>
To: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Cc: 1054514@bugs.debian.org, airlied@redhat.com, carnil@debian.org, 
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org, kraxel@redhat.com, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 regressions@lists.linux.dev, spice-devel@lists.freedesktop.org, 
 timo.lindfors@iki.fi, tzimmermann@suse.de, 
 virtualization@lists.linux-foundation.org
In-Reply-To: <20240404181448.1643-2-dreaming.about.electric.sheep@gmail.com>
References: <20240327-cuddly-smooth-trogon-59c02d@houat>
 <20240404181448.1643-1-dreaming.about.electric.sheep@gmail.com>
 <20240404181448.1643-2-dreaming.about.electric.sheep@gmail.com>
Subject: Re: (subset) [PATCH v2 1/1] Revert "drm/qxl: simplify
 qxl_fence_wait"
Message-Id: <171232278434.15085.12649965715947984950.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 15:13:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 04 Apr 2024 19:14:48 +0100, Alex Constantino wrote:
> This reverts commit 5a838e5d5825c85556011478abde708251cc0776.
> 
> Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") would
> result in a '[TTM] Buffer eviction failed' exception whenever it reached a
> timeout.
> Due to a dependency to DMA_FENCE_WARN this also restores some code deleted
> by commit d72277b6c37d ("dma-buf: nuke DMA_FENCE_TRACE macros v2").
> 
> [...]

Applied to misc/kernel.git (drm-misc-fixes).

Thanks!
Maxime


