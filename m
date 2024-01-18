Return-Path: <linux-kernel+bounces-30032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAB083182B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD9B1F2159C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2B725102;
	Thu, 18 Jan 2024 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="muPu86A6"
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DFC2421B;
	Thu, 18 Jan 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576235; cv=none; b=IutRLsUSexEVkpDscJm3RS/oUIczsQ7x/FQbRdc1QMuM0He2t+CZ0BsQf4ETa7xCt2QS9dm31975GkbkBliT0sbOqhwaOi1xQEsh0EvMA6fj6yVlSH3OFvgxTbJjFbWkgxPQwYHXnCY1Ri5JZjbooA1mGZRJczV6v19vue4aBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576235; c=relaxed/simple;
	bh=GMtd0pstpQcqTleYbfyojTxp00ZU0XHSVR8HGIiOeDM=;
	h=Received:DKIM-Signature:References:User-agent:From:To:Cc:Subject:
	 Date:In-reply-to:Message-ID:MIME-Version:Content-Type; b=Ri4l8iINXU3sRVV9pf0WCf9l7APHKxRh9Kkc7Tnz+295TWJq1c4Dn3Zos5UypUAZ327djnonSvPH70IeQJDCaOuzPl87MmNezqLOMvtWDbJPpc21dpmDqkJ5q2fR9kmi/XrpcoztDEquixmDJVaZIu3wryW3V+UTTxeq7u27SEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=muPu86A6; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from localhost (unknown [10.0.8.2])
	by mail.tkos.co.il (Postfix) with ESMTP id B46D94408C7;
	Thu, 18 Jan 2024 13:10:19 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1705576219;
	bh=GMtd0pstpQcqTleYbfyojTxp00ZU0XHSVR8HGIiOeDM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=muPu86A6ftu2HlsG9jhNTjR4XMmDWwggPY7ZxAaroE5GJfLGriZw3+wA9p66vm7W+
	 b8v5Fu/BLRu59D2qzb9u7SfoGNmDj0Pdk0GjuunjUdwgywMoSRZoioVkXDxS8M64gU
	 hLP4ed3Dt6wUXVqgm/0NtCFzBKULdsnd2sxFrMtDwtB6YlDCFtoZjzPUN+ODHJ7JCI
	 fgaPMmhnZzDPlDpoKLgdjQ9xW6efT57tO4cVlgk3HrJ7FH8fSJ/IIrb7B+OqebjDNK
	 7+E1UwyottHI3VU/1jwXOq1CcaBVwAho0Hz/mJNlsxhg3VAyMn+tef/Iokd5FkBz35
	 EikZ6YBQ0ROhQ==
References: <cover.1703683642.git.baruch@tkos.co.il>
 <be71fbb0963584b8c401423d9dd2fba2511bd5b4.1703683642.git.baruch@tkos.co.il>
 <30d81f73-e27e-6cc4-5458-686e3ddd2e5c@linux.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Baruch Siach <baruch@tkos.co.il>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Petr
 =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>, Ramon Fried
 <ramon@neureality.ai>
Subject: Re: [PATCH RFC 1/4] of: get dma area lower limit
Date: Thu, 18 Jan 2024 12:59:58 +0200
In-reply-to: <30d81f73-e27e-6cc4-5458-686e3ddd2e5c@linux.com>
Message-ID: <87cytyx5gf.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Christoph

On Wed, Jan 17 2024, Christoph Lameter (Ampere) wrote:
> On Wed, 27 Dec 2023, Baruch Siach wrote:
>> of_dma_get_max_cpu_address() returns the highest CPU address that
>> devices can use for DMA. The implicit assumption is that all CPU
>> addresses below that limit are suitable for DMA. However the
>> 'dma-ranges' property this code uses also encodes a lower limit for DMA
>> that is potentially non zero.
>
> All of memory can be used for DMA by default (==ZONE_NORMAL). ZONE_DMA defines
> a special range for devices that are unable to perform DMA to all of
> memory. Usually due to the lack of address bit support.
>
> So I guess that the platform in question here has as a general limit as to
> what address spaces I/O devices can do DMA to?

DMA to/from devices in bus with 'dma-ranges' property is limited to
address space described in 'dma-ranges'. The arm64 platform currently
uses 'dma-ranges' as a hint to set ZONE_DMA limits globally. This series
is meant to make ZONE_DMA limits adjustment code work better for
platforms where the lower DMA limit is above 4GB. This commit adds the
ability to extract the lower limit from 'dma-ranges'.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

