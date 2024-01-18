Return-Path: <linux-kernel+bounces-30073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A878318D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D321C21E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36EF24214;
	Thu, 18 Jan 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD5GeeYp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00591241FB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579353; cv=none; b=DnPhJuFkSaDbDDUxWXj8rCR8GBKAuJ1Shwdc1Wk7wGB6PK4IRR7+1qaWW43WjLwkszAc+vDsGH9bLdQyaZKjTN4ppVEAezBBVKM8AGU4eiGj0f2qXV9Dzd9dC/IfWheNtTuQ6ssYdQoaT76PF33h5Jh2w6ggIimWz+ganacGX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579353; c=relaxed/simple;
	bh=Jy8yatgHc2B66rEGayMIPSlWBd8My3+CbkbzlVh3z9c=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=lUNJmYFBgL7ih0zNryRz3tpWb9eXiF1bTE1xyZXj6MJOTME1VD0QWwHc1tcO4C3pQA33bCRnKGC+oW1l1D53cJcTbLqSOOCyAn/rvV6MBeJoyo7oGYGW17/3TFW6vD4z0qdL9DxBm1UU3OY6JvV1b5u0Luh1J4kdXVAw5GIlJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD5GeeYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41059C433F1;
	Thu, 18 Jan 2024 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705579352;
	bh=Jy8yatgHc2B66rEGayMIPSlWBd8My3+CbkbzlVh3z9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BD5GeeYpeFNei71opWDxSRCJHoBQ46woj5F+iBDnl+ZPro9cQO85x8QW7vAKDtKkA
	 7ELA6dndvzvU/Ei6bHCiH8V/JVDjG1Uq/DTZYI2SDJ25E6pw4moc2b/kaxFo4vm7yD
	 Rmc5WglnHV/GLyC8hZTHz/vcfn3l0IDK1kCq3yj5IbZrO2m2HxFvojUUdtBLiEX7aq
	 3lAW8D1Sr0FJg7Qf6pfLK+lYuXcALj/Qf6iQ7jZupCOn32uf4Yx6Xc7TvESa9eZE5+
	 KAO1m/HsIhDdKYk0al9CeT0LrX2CJ77jh4VWh131EErT/8EO+ep0e7qWCFZKwarB7D
	 62hUOE5HtVauQ==
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Dave Martin <dave.martin@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Remove spurious check for SVE support
Date: Thu, 18 Jan 2024 12:02:23 +0000
Message-Id: <170557592095.3201709.4298932156768186758.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240115-arm64-sve-enabled-check-v1-1-a26360b00f6d@kernel.org>
References: <20240115-arm64-sve-enabled-check-v1-1-a26360b00f6d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 19:53:01 +0000, Mark Brown wrote:
> There is no need to check for SVE support when changing vector lengths,
> even if the system is SME only we still need SVE storage for the streaming
> SVE state.
> 
> 

Applied to arm64 (for-next/core), thanks!

[1/1] arm64/fpsimd: Remove spurious check for SVE support
      https://git.kernel.org/arm64/c/8410186ca480

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

