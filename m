Return-Path: <linux-kernel+bounces-131511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2B58988E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF531C221E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AD2128361;
	Thu,  4 Apr 2024 13:37:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CF85644;
	Thu,  4 Apr 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237822; cv=none; b=UTL7r9OcC71tAli/290MISMZ3vrsSBeIKnXuPh9vey34CEJAbSGau6ZAEsTAIWK0o7WUYIAo0bzhVJUQZvf564sG1o9TWOsJysmDSNPUFs/Vmti19F6+DZf2++c7AXPAMrwgbpijRPNORvLh3xVq6JAkhXyGvsPd8BPs4QQT7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237822; c=relaxed/simple;
	bh=CJkCDyzJweGksUwYeTjtpL2ZrmVMW55AScBhGmCoOMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FfSx+fEP4oNjFx81OjEMWfRO5o7V6lFcnKcE9TEkA5272KVKkKkn2Q21jrwHCJX+/p6EuHsAHNsENZ4cbHV/TcpiEVc+vZP/uMiV6HUIoNy7qLDo5c2NmfRfrt7EujMrWy+R9wV7rtuRGa8pWp92iYrQ58Q8aIRlNVSa1uKb2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6476FC433F1;
	Thu,  4 Apr 2024 13:36:59 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-mm@kvack.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 0/3] Make {virt, phys, page, pfn} translation work with KFENCE for LoongArch
Date: Thu,  4 Apr 2024 21:36:33 +0800
Message-ID: <20240404133642.971583-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On LoongArch kmalloc() range is DMW-mapped rather than TLB-mapped, so
KFENCE remap __kfence_pool to the TLB-mappd range.

To make all drivers work, {virt, phys, page, pfn} translation functions
are overriden (part of them already done, others done in this series):
1, virt_to_pfn()/pfn_to_virt();
2, virt_to_page()/page_to_virt();
3, virt_to_phys()/phys_to_virt().
 
Since LoongArch overrides page_to_virt() which use page_address() in the
KFENCE case (by defining WANT_PAGE_VIRTUAL/HASHED_PAGE_VIRTUAL). So move
lowmem_page_address() a little later to avoid such build errors:

error: implicit declaration of function ‘page_address’.

Huacai Chen(3):
 mm: Move lowmem_page_address() a little later.
 LoongArch: Make {virt, phys, page, pfn} translation work with KFENCE
 LoongArch: Make virt_addr_valid()/__virt_addr_valid() work with KFENCE

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
2.27.0


