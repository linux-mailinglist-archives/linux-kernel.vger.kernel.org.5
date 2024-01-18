Return-Path: <linux-kernel+bounces-30075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E4A8318D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB2C1F231B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C51F250E3;
	Thu, 18 Jan 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUEnWzIa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7165D24B4F;
	Thu, 18 Jan 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579357; cv=none; b=rwGZWgR/9zYb7fBptjaElpPDGvVKMx7e8zSaidTYKzCEcUapRwo03mOxy5AJagb+Nc2PtScrMEKynbErIaEuNVqejD67nOr0obIbGun1pmzexqvJLWo75Cnxtj8CLRm8mO4tmCPaWAGaivDoDmBkjqFFULdQYa3976hKmErrvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579357; c=relaxed/simple;
	bh=4JjInX8GTRaVqwI9r9CiIei88hE6LnBe4PZYIuppOAg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=ODUJYgfy30cJzuWy7J9DO56l9+tpaFgWhyA/MJKFRV4f4vOcLdaNAxR7GK7ORctcug7NeAJYRRLm8734y3HWc4ligsAHDYwyMPtFgWypq2WZJjkCld3nUuOmFZ+C0uxtFvnkTd888ZA0Iu7A0hDVk9Uk1R/b0J1u9cawlqqtuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUEnWzIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57540C43390;
	Thu, 18 Jan 2024 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705579357;
	bh=4JjInX8GTRaVqwI9r9CiIei88hE6LnBe4PZYIuppOAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUEnWzIaeit0wB9zixIV3kKPPCENsvoitIKnlvEGyqyNAm5qXRvPAY0eN74IeMzOj
	 crRrZV4r8Eh9CfMDWOfFI2aydM9ZLo9F52Kv3xCzD9gTsoI3tIRMdr6VIISXkQkMtc
	 6nZVNANGrRndi5zTwbPywguISBqwk83iyGk4dMp7MrSXRilgS4tQDn0NZ78NnhOcj0
	 zf0XC+Aw5dFiWPTtrTsh+MrMgNA7uY4O/PH97jateHtmEdtwgZcdv97sUuAwlu1k1X
	 K3bbCmcXVa5RVo8/LL2y4GFKLdSWtPUmvL80p4J4lNdtiS0khAISQcZEpepHpeZKnB
	 YjpvcnEGgPX2A==
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Dave Martin <dave.martin@arm.com>
Subject: Re: [PATCH] arm64/sme: Always exit sme_alloc() early with existing storage
Date: Thu, 18 Jan 2024 12:02:25 +0000
Message-Id: <170557595437.3201963.17750438476514444044.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240115-arm64-sme-flush-v1-1-7472bd3459b7@kernel.org>
References: <20240115-arm64-sme-flush-v1-1-7472bd3459b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 20:15:46 +0000, Mark Brown wrote:
> When sme_alloc() is called with existing storage and we are not flushing we
> will always allocate new storage, both leaking the existing storage and
> corrupting the state. Fix this by separating the checks for flushing and
> for existing storage as we do for SVE.
> 
> Callers that reallocate (eg, due to changing the vector length) should
> call sme_free() themselves.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64/sme: Always exit sme_alloc() early with existing storage
      https://git.kernel.org/arm64/c/dc7eb8755797

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

