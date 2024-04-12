Return-Path: <linux-kernel+bounces-142792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A658A3022
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6673C1C2359B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65F8595B;
	Fri, 12 Apr 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxEbACGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83650241;
	Fri, 12 Apr 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930721; cv=none; b=SjXraAzZQAAGAv363IjiJQfR8Y82a8x+c+lOcot5Wp4VR+YPOJZl13uCKw9GyInDXATg2JZ7PH7niNOrbLkZcuBoDf4Ux/zgY8E53rWCpYY8avl445loheJwUVMymAn8qiu5elsWn594xDz2ETY4drfM7IJ59qojbZ0CzsgYu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930721; c=relaxed/simple;
	bh=omTvxBWcSpTxGyecQAtJsPrnCfgoa+AxlGoaC88vRww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttx4ALf3lE6gBEF1E4GguQBFr0gPjRSqTtNNO0l5XpJTQtw7hj/nox0xeFGbYBihpq0bJakyW9j0V0PD1ELh+0T1hrSg/kFmeL/Eiva2bK0HfAYG5qXVQjstAElmjTaXvsp82aRqrRVkIYgirXukGE2DRnTs4RVr6e6Jw2YBTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxEbACGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7564BC113CC;
	Fri, 12 Apr 2024 14:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712930721;
	bh=omTvxBWcSpTxGyecQAtJsPrnCfgoa+AxlGoaC88vRww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxEbACGoxaVA6BbU7SH/m3SF2sTUEavGAZhWe9ZSTQHaboXVHIwKoZNwUhBYRGp4s
	 9G3gafph0mQnVTh2Z2DUp1fmaWt9ceBHzMkzoCBVvB3BykQgL4P/zY4tmNkXWw73mp
	 ufngXSW7QEUQaVY0vlpAgoC1ywpDjQ0EqGkmNPGSPUDhwAlwU0W4cNEa7R2WsKCqsO
	 qa/S03GFyo1wyHXgKq0DBHsSYLigagU/0AFIi8kJmt/ilO2/JqQDP/iIs+wajv2352
	 bkyU+eB50zksQ31vDSCapCBbmRvMGGiRT9Hyt7CzsCtK+cHGiWxf7G2SWxug4DmgcH
	 +a50UehmT2wiw==
Date: Fri, 12 Apr 2024 15:05:15 +0100
From: Will Deacon <will@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Support clean reboot after hibernate on Arm64
Message-ID: <20240412140515.GA28052@willie-the-truck>
References: <20240412073530.2222496-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412073530.2222496-1-dwmw2@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Mar 11, 2024 at 12:19:14PM +0000, David Woodhouse wrote:
> When the hardware signature in the ACPI FACS changes, the OS is supposed
> to perform a clean reboot instead of attempting to resume on a changed
> platform.
> 
> Although these patches have a functional dependency, they could be merged
> separately. The second patch just won't *see* a FACS table if the ACPICA
> fix isn't present.
> 
> v2: Now that the ACPICA patch is merged upstream, note its commit ID
> 
> David Woodhouse (2):
>       ACPICA: Detect FACS even for hardware reduced platforms
>       arm64: acpi: Honour firmware_signature field of FACS, if it exists
> 
>  arch/arm64/kernel/acpi.c      | 10 ++++++++++
>  drivers/acpi/acpica/tbfadt.c  | 30 +++++++++++++-----------------
>  drivers/acpi/acpica/tbutils.c |  7 +------

Rafael, how would you like the handle this series? The arm64 part has
been Acked-by Sudeep, so I'm happy with it.

Will

