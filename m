Return-Path: <linux-kernel+bounces-143003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087AA8A331B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396761C21FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE6414882A;
	Fri, 12 Apr 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEK16wTB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C913BC34
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938011; cv=none; b=hd+nITyW8nmtGsB/cpLw8ItD7ZZTWwNpoCQUGicUXWaUaNmQxFtpEZl8nVLAvQnRW47y+KGCifnBEBAjA5/EC/UPxAQga1HN5J/RVQvP6+7gxzN4gP3HwP3D0eu0shtKLSN1W8vaUqc/Qj08D3fvuZchsN3PCDwcDHyE3WYZTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938011; c=relaxed/simple;
	bh=5pH4s1XLerrXy9k1AYpN+fU13VFXyhA3Dz0ugkHOoSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dr+K1ZPjixJgnr7l8pwWCkhuUubTFboDsMgps5pQXiSV81rZYWK8Xez7uhFmT49HPtZ7NFjeyaK8yPitbCtOp2Ma2U4hXdtzXEw8QkkJZR2ZrxcNCNB7HdJIVTXiYfdH8p0s3TkrOAyVlWisJRFRTs/pr3oXHkz0H6ELGGL9uLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEK16wTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52559C113CC;
	Fri, 12 Apr 2024 16:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938010;
	bh=5pH4s1XLerrXy9k1AYpN+fU13VFXyhA3Dz0ugkHOoSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEK16wTBCbtYNSl3+h8NXgXombKOUy9miD1/ty7ekxeuox4GuJ983Dg/xs5tCY7IA
	 FCzKDa84C5nCPzPC3OL8YWRJr2s3O/lvW8DSVoR989+FZGCtfyEhwHYb5i/EOGTgxY
	 /SUuXqfYTobRiw6roYvhnXctDKqEI0rFhG7Ygm9OBHcnbJtRRTq+XfuZCl81Lkk5FX
	 CoWVi7eC0XBdGtsmHTmr1jeCq9f/ckYMO2XoW9w4UC6bA37bS/JZLBhJ7sgO85VooM
	 yF0oQ1hX4QgqiZn9yhHAtWMtPwJjhCfFznBrw7uaCasHZlqYOW787/uRT8lnYHopnX
	 Gp0ryNIbLCA4w==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gavin Shan <gshan@redhat.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	akpm@linux-foundation.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	ryan.roberts@arm.com,
	apopple@nvidia.com,
	rananta@google.com,
	mark.rutland@arm.com,
	v-songbaohua@oppo.com,
	yangyicong@hisilicon.com,
	shahuang@redhat.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH v3 0/3] arm64: tlb: Fix TLBI RANGE operand
Date: Fri, 12 Apr 2024 17:06:39 +0100
Message-Id: <171283217883.1337455.2882364241442501889.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240405035852.1532010-1-gshan@redhat.com>
References: <20240405035852.1532010-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 05 Apr 2024 13:58:49 +1000, Gavin Shan wrote:
> A kernel crash on the destination VM after the live migration was
> reported by Yihuang Yu. The issue is only reproducible on NVidia's
> grace-hopper where TLBI RANGE feature is available. The kernel crash
> is caused by incomplete TLB flush and missed dirty page. For the
> root cause and analysis, please refer to PATCH[v3 1/3]'s commit log.
> 
> Thanks to Marc Zyngier who proposed all the code changes.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/3] arm64: tlb: Fix TLBI RANGE operand
      (no commit info)
[2/3] arm64: tlb: Improve __TLBI_VADDR_RANGE()
      https://git.kernel.org/arm64/c/e07255d69702
[3/3] arm64: tlb: Allow range operation for MAX_TLBI_RANGE_PAGES
      https://git.kernel.org/arm64/c/73301e464a72

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

