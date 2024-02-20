Return-Path: <linux-kernel+bounces-73100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C7D85BD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794A91C22D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07947318D;
	Tue, 20 Feb 2024 13:48:55 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912C569DFF;
	Tue, 20 Feb 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436934; cv=none; b=d9mD8hBPtQagykPxKbJnl48t9HvOzL8fcNy5x+KCQzjynYwrjMmmHWIrUDRGhd8KJ5cxC75hq4kJD2xIKKaNRza49CyNPQP6DAqsKEg0M0kzZ1cuGBcw+g7AT3dgvMBh4TfPmRqderxXqr1TAdRZxAC2BksbhukZidVt6RzGboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436934; c=relaxed/simple;
	bh=FXC6OCaMo6PBra09rv0mQ7fmtDHn40tyIY5riwAomwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrujmuqsVy2d3VSWVnaKDHC+6/Z1QpTfMQpo/eq67d2a2/riCvtYD7XhqB9Wb+/CRunukMLljWUXA9eev+jEIYMf372prRGGDoOMe7SA6mTu3FD5mceAvGma/ucX0xrybsLzbvwuap8yuukiTgWKzxfQt2FrikJjbBHwrfLW9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rcQUF-0007OQ-00; Tue, 20 Feb 2024 14:48:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 99382C0694; Tue, 20 Feb 2024 14:38:24 +0100 (CET)
Date: Tue, 20 Feb 2024 14:38:24 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MIPS: move unselectable entries out of the "CPU
 type" choice
Message-ID: <ZdSrUKlV+Q37S3B7@alpha.franken.de>
References: <20240127162309.1026549-1-masahiroy@kernel.org>
 <20240127162309.1026549-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127162309.1026549-2-masahiroy@kernel.org>

On Sun, Jan 28, 2024 at 01:23:09AM +0900, Masahiro Yamada wrote:
> Move the following entries out of the "CPU type" choice:
> 
>  - LOONGSON3_ENHANCEMENT
>  - CPU_LOONGSON3_WORKAROUNDS
>  - CPU_LOONGSON3_CPUCFG_EMULATION
> 
> These entries cannot be selected from the choice because they depend on
> CPU_LOONGSON64, which is also located in the same choice.
> 
> In fact, Kconfig does not consider them as choice values because they
> become children of CPU_LOOONGSON64 due to the automatic submenu creation
> in menu_finalize().
> 
> However, it is hard to understand this behavior unless you are familiar
> with the Kconfig internals.
> 
> "choice" should contain only selectable entries.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/mips/Kconfig | 76 +++++++++++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 38 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

