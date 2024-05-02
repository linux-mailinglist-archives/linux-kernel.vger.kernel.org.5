Return-Path: <linux-kernel+bounces-166713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BA78B9E75
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7FCFB23AEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6184D60BB6;
	Thu,  2 May 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="amas3A2t"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2F15E20D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667045; cv=none; b=ZdOJFSGgFpgN9DqPPpm7b8quhYXvr2HfYtJkEq6iayo2LCtESDaUoeSHQL2H4ORH9utgsGWWvvO3Ub1zM7trwmdB3HS3A6z1DUtDy7WPFmd0GoWoDpYmln9pvGXikRYMCUh5yV3oXM7IeoKSQKUcmxAaT0WYfVXohpaMh876SiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667045; c=relaxed/simple;
	bh=NGVwFjaFO10XPYZmmBrdVpFxIB4XnJUxAtDA0jJnZbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+X9yE8Fn/kAKL32cg5IF1s4mHlJ4fpoQXXwR0tSVmc3nH5wYhpRFwq5OHavmymYJXa5fyVp0th3tCAmKpR3K8rvn2mI7leewIe6Phcej+2aTVsUCavFWbEfJ/+POUqe4tgGjhg/i/39TZi/0CfBvPJz0P1sBHVGt4JaTdeUNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=amas3A2t; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedor-21d0.intra.ispras.ru (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id C5A4F407850A;
	Thu,  2 May 2024 16:18:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C5A4F407850A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714666728;
	bh=DtReRsjlUyViWf7paqbZpI8KlMsBY9+Wd3lvivUXAhA=;
	h=From:To:Cc:Subject:Date:From;
	b=amas3A2tnskmQQ7zLqotmvrmOBDD3MRUJlwBBG8YFpuph8RhJxqsDwcB8JUP/n6Gq
	 JHlh8jVe7rGijb/Rhz6JgOAYoCko/ITGKQUV3VzsKkbZekqAALGD2IRWyH6GSvcfFf
	 yGRl0bQMK/ttw1GJ0NRIh3Ls4ldyzNFwovCvyXYs=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Xiang Chen <chenxiang66@hisilicon.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Barry Song <song.bao.hua@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 0/2] dma-mapping: benchmark: adjust some error handling in do_map_benchmark
Date: Thu,  2 May 2024 19:18:24 +0300
Message-ID: <20240502161827.403338-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the error paths inside do_map_benchmark() do not behave correctly.
Adjust them with the following patches.

Fedor Pchelkin (2):
  dma-mapping: benchmark: fix up kthread creation error handling
  dma-mapping: benchmark: prevent potential kthread hang

 kernel/dma/map_benchmark.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.45.0


