Return-Path: <linux-kernel+bounces-143005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24AD8A331D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C67C28215B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9104D1494C7;
	Fri, 12 Apr 2024 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UozAD1Ha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C91494B7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938015; cv=none; b=HHs4eesZkBr07daWFjVWiw6qTXv2GlVylEsxyvb56xYa/AA6zjiAZPPBsbXluGm73kgKsHwvcfN/O/PnEtfVdAYbLnCyyObq+tvZzJC8su7o2Aqw01yov3Pa614FIQIMhBFchWobRdRLu8VHaCj5AiTcodUFBBR8fynXfDSB4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938015; c=relaxed/simple;
	bh=g/ypGRIKAzpOzVYJiDDtGJo0LvInSV4h5nueccUUC1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQuGnkgQU1nMp/mhjnDZZEenLZWI95nj7ZcZXYvdKumCZdA3Lm1VUFVK2mYq9arCPyTncH5tpfuVE+lFKZuOumXoBGNXDHhAQJKeAzbPTQZ5Nj9n4VMUVsyhxg/9GRokLahk2GIfL75fPq8PtPYET+sTfHKrImWGhY99H3XeoFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UozAD1Ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B682C32783;
	Fri, 12 Apr 2024 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938015;
	bh=g/ypGRIKAzpOzVYJiDDtGJo0LvInSV4h5nueccUUC1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UozAD1HamJCb6dTRkGR8DSOae+cGUG8EkVSMTQQFzl2d6h9cqFhmiNH3lDDFlqPqX
	 nFBTMTgdWGSkfrsvDvLQxBqhkE3qc0noU+gxfop1tY87nBxAqdwLbOndsDZNX0ZJW2
	 aAwc7Chu6p58efmVzToP0Dpr0pbQhBOqDQzvhEjwLHa301qNUzkcejhRyzkDbRl88E
	 epS1fbw31dWNUoPWfUTO070NgO2RDmVhXcHe+/gHt29c9fJAobFlsHzr4odGEpHwbZ
	 gtxNlyl0H0hKzVnFyxtdIlFQBDKcK8LldekfgoH5o7OrkwwZJDwyAu6ujYIZ7CqXau
	 BwcSy3PuEthnw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Speed up boot with faster linear map creation
Date: Fri, 12 Apr 2024 17:06:41 +0100
Message-Id: <171293670589.3659902.6442840474459477952.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240412131908.433043-1-ryan.roberts@arm.com>
References: <20240412131908.433043-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 14:19:05 +0100, Ryan Roberts wrote:
> It turns out that creating the linear map can take a significant proportion of
> the total boot time, especially when rodata=full. And most of the time is spent
> waiting on superfluous tlb invalidation and memory barriers. This series reworks
> the kernel pgtable generation code to significantly reduce the number of those
> TLBIs, ISBs and DSBs. See each patch for details.
> 
> The below shows the execution time of map_mem() across a couple of different
> systems with different RAM configurations. We measure after applying each patch
> and show the improvement relative to base (v6.9-rc2):
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/3] arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
      https://git.kernel.org/arm64/c/5c63db59c5f8
[2/3] arm64: mm: Batch dsb and isb when populating pgtables
      https://git.kernel.org/arm64/c/1fcb7cea8a5f
[3/3] arm64: mm: Don't remap pgtables for allocate vs populate
      https://git.kernel.org/arm64/c/0e9df1c905d8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

