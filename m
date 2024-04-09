Return-Path: <linux-kernel+bounces-137346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FC389E0E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AD61F243C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6215381C;
	Tue,  9 Apr 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP3aqCHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76E131198
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681982; cv=none; b=JvtxZHpkOmvBbuvZkv3Qz2/KkY2YI6uzXHQb8Ohvq3lT4z/yWrC6mxTs4zbqplSHY4JqGtiTEzXPX3e/26WNnzTWQ13sv0pe4aLoWHZ0arD3uIAXqexEdwmzag093w1IXVHefdvpFmz9BLbX7R3LrnjTvyZOyhDQqyF3499debQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681982; c=relaxed/simple;
	bh=UsQpWYzGtSSF9+Q7lnMP/WLf9cUcLF+MjUS1PhPDDV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ha5SfoR1QX020g+Fp8dAWTM/4klFQuwhBNVCkKXpaXLCs/vNSvaUtPgyN+4Baig+qwI8/9ZiX1Js0rijj2rxqWCvE/tZYO/roh9S6tiKioQybjJtJmUzo9rvhJ4sTNFiM5GTN7zIGQHPtnBDLE/5v8AV+JiwCqv8bIgvRV47HPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP3aqCHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3DEC433C7;
	Tue,  9 Apr 2024 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712681981;
	bh=UsQpWYzGtSSF9+Q7lnMP/WLf9cUcLF+MjUS1PhPDDV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QP3aqCHb9iDV25lXTRi3qXU7pspAsEv+ee/feE2ig22A/xyRPa+3vIYJwTU+Rh3vl
	 /4IBw5Ts5aazTC3trhlFylGbOBt4L1/pIqrWAMTDt3tXQ9BRE7pmKHoaqOXakUsPYu
	 848onB4F5+XndhQnftuLJsUXb0dc9lQczASf0lJjSGOEY0HpxZ7nxaOw4Y+QCefygK
	 HAqXUYZZzQGNrd0HSwUlmuKp+trp/mfOVe/Z/6sWjBD2VMG3yBrSFBMdrIpkiz5dr5
	 RRE4bs4QtOZd2GqWWzZ1aQWdQjNQyw9ygjKAdDkmzJ2EDCQDfEB3zRQNj46z6W9+dD
	 X/L8zlkbMSYmg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/1] drivers/perf: thunderx2_pmu: Replace open coded acpi_match_acpi_device()
Date: Tue,  9 Apr 2024 17:59:32 +0100
Message-Id: <171267745568.3170287.8393944224609383968.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240404170016.2466898-1-andriy.shevchenko@linux.intel.com>
References: <20240404170016.2466898-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 04 Apr 2024 19:59:23 +0300, Andy Shevchenko wrote:
> Replace open coded acpi_match_acpi_device() in get_tx2_pmu_type().
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: thunderx2_pmu: Replace open coded acpi_match_acpi_device()
      https://git.kernel.org/will/c/105350fe0786

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

