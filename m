Return-Path: <linux-kernel+bounces-160005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D257D8B3791
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1138E1C22521
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3A146A9E;
	Fri, 26 Apr 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="VIrp8gQ3"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7E13E88A;
	Fri, 26 Apr 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136214; cv=none; b=QNYWqRM6UazvD/l3k/koT9KZGPcS2iJ9I0nPJoK17hDmlwIW2298qB5gEZreE3oP5auLpVVdIOSWgKSbFVSpjNVjEUHRt4Ntr34nr9qQXmCTiBPYVVYTOL++tMmsAj6UrNBbqfsj3Wh/UVDXJh+nq+2kmTDqZVcBxdUv8rjoa/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136214; c=relaxed/simple;
	bh=Vm1MqXYIrKm3uWWE9OUrBXSWg2xXPd6nhFg9uS9/cpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aMLQr+cJeanIjXAhUzwBlookTXr0zJePH9xDtYd5RPvf3uWNm5mzWVcX0L2G4m6vt0e1hebQBs6ncSr6sIJ5e7Lm2fvzUEiuxbdkCiNURg31p6FMra9zugCdIohnMlDsomL/PXhFz+HhEGKi6oyRcMJNuhYI3/LhzmbJFBQqahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=VIrp8gQ3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 014E647C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714136206; bh=O0KvzxSAUIcHusHXbcj1H/WOMoqxs1lLJ3AgneKmmhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VIrp8gQ3zGKC3bogJXtlDT872C3ZWn5cBQvFDniF7CzaqGGCPVqRaj9fFiUpdB98O
	 ntJfWrbAEHZ9ifvMr6x2IVVCJi9UA+ykHIan7cY5Sagsnkqg1IjalPZB01z6NJJ016
	 ob4y8BxSpozTC0Hv7xR9Oh5Kph1nLIppJxmm8AQN75KmBTkn8KRAs90dqeRYZeqc0z
	 vvMF/jklNQgDYofkb4nr6CoErvlGEGqJs+oH0F/l30FK4mdMa3hcigQ0VSR5vLsOgU
	 QKpj68OJ9/xx3gtnbt1/Z+X36oynzU7Ai5/DK2pCDG3eyoKma7pQfg8IO6v/vrchbj
	 8E3S7f9QGfYaQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 014E647C39;
	Fri, 26 Apr 2024 12:56:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Christoph Hellwig <hch@lst.de>, mhklinux@outlook.com
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, petr@tesarici.cz,
 roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v2 1/1] Documentation/core-api: Add swiotlb documentation
In-Reply-To: <20240426061852.GA5645@lst.de>
References: <20240424150253.560999-1-mhklinux@outlook.com>
 <20240426061852.GA5645@lst.de>
Date: Fri, 26 Apr 2024 06:56:45 -0600
Message-ID: <874jbop9iq.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christoph Hellwig <hch@lst.de> writes:

> On Wed, Apr 24, 2024 at 08:02:53AM -0700, mhkelley58@gmail.com wrote:
>> From: Michael Kelley <mhklinux@outlook.com>
>> 
>> There's currently no documentation for the swiotlb. Add documentation
>
> s/the // ?  (note that this is used in quite a few places)
>
> Can you use up the full 80 characters for your text?  As-is it reads a
> little odd due to the very short lines.
>
> The other thing that strikes me as odd is the placement in the core-api
> directory together with other drivers-facing documentation.  Swiotlb
> is internal to the dma-mapping subsystem and not really what is a core
> API.  I don't really know where else it should be placed, though - nor
> do I really understand the "modern" hierarchy in Documentation, but maybe
> Jon has a good idea?

I hadn't thought about it, but it seems that putting it with the rest of
the DMA-API documentation would make sense.  That's core-api, at the
moment at least...

Thanks,

jon

