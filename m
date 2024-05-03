Return-Path: <linux-kernel+bounces-167658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691808BACDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0E21C21A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645B8153587;
	Fri,  3 May 2024 12:55:36 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9F1514C7;
	Fri,  3 May 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740936; cv=none; b=FN5r1pSh44i2+v4mCeMDMsKaqDv0rMKyJEYNtjlKvK5RvbGlvrKMLpQ/qJA5g9eHpkdU4AJovBam7uRutL1b7TpIIL4+lYQjvY4k9rhev9FF4SOjs+CFH/b0cJ7IajU4uJTCTt6ZFoNI+njLLATs9U9adDqAOoGxfDLHxKPJQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740936; c=relaxed/simple;
	bh=vW+H45nbFCrmwhT8G7VVpJ0tOe+9QNeobrWWa8qaOf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSH1F6WiuOS28ZBsEn2iCOh0EWi7lTgOkZLirUrdvm+V+IVuU59/fBr9UCLtQa38iEjeQik2TogFpvl54fWZ/lABut8GADrxSmwm6OwtVBq6Wd7S80275Ht0awQvPmQPu2q+gW09sktn3V77K2c0jDLDIWCJdecyJ2GoePw3Jcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1s2sRd-00031A-00; Fri, 03 May 2024 14:55:21 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 7D90EC02CD; Fri,  3 May 2024 14:51:09 +0200 (CEST)
Date: Fri, 3 May 2024 14:51:09 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Siarhei Volkau <lis8215@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Take in account load hazards for HI/LO restoring
Message-ID: <ZjTdvUDL01XV39Lm@alpha.franken.de>
References: <20240430154601.1337028-1-lis8215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430154601.1337028-1-lis8215@gmail.com>

On Tue, Apr 30, 2024 at 06:45:58PM +0300, Siarhei Volkau wrote:
> MIPS CPUs usually have 1 to 4 cycles load hazards, thus doing load
> and right after move to HI/LO will usually stall the pipeline for
> significant amount of time. Let's take it into account and separate
> loads and mthi/lo in instruction sequence.
> 
> The patch uses t6 and t7 registers as temporaries in addition to t8.
> 
> The patch tries to deal with SmartMIPS, but I know little about and
> haven't tested it.
> 
> Changes in v2:
> - clear separation of actions for SmartMIPS and pre-MIPSR6.
> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  arch/mips/include/asm/stackframe.h | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

