Return-Path: <linux-kernel+bounces-53756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B0B84A680
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479991F2B204
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F11A29BE;
	Mon,  5 Feb 2024 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFpjUFBG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0317B0E4;
	Mon,  5 Feb 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159856; cv=none; b=fFBZWk9CnFaGWDZfwGEVzZ0VXJDt58fI3+r74KKNfmEvrKDEgjGIOX/PHhN8r3OBFamwaISwMV5pQwB69v+6+j2BB2FZqW+5T8d1WO18ZlAgQkNo+uAZed/gY1cOPKpbdwrsEm6Qld6O1cKSdMovCZUppJGVJZ+UVdmEtMQczFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159856; c=relaxed/simple;
	bh=zl2f4VHKhS40Jsjh4iTApKIdZqzlAf4+ENj/mrFKKE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7LpRMaV/onqpjNTXTsnSOB3JyI9L+jh6rbUuC2BHici1PLJWifHsL0HtCtu96zh1X3TBI32ALCO1AP56m2+BIDf+pV0vgpSsrWCJVFxWhJ5myLXDjnrZu21h7DdABDpZqFyJmUA0LWWHtFz1eLl5vEImeMkyJXJXLnRttDjaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFpjUFBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F16C4160E;
	Mon,  5 Feb 2024 19:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159855;
	bh=zl2f4VHKhS40Jsjh4iTApKIdZqzlAf4+ENj/mrFKKE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFpjUFBGju7P8e70v+g2EkX1kTIwrYQ3WkluiqqpEMiU65AbwqMtY49N/IT6BiuJJ
	 75pxRD5LE0mhKoh1omhENU7tqobqxN6dfIY05y5proB6GvGcefZpCXQgRW5iuIc9Wl
	 ckQJ8RJq/HfnFpMA6DU/NNu/x8bvIIph3Ulm4RhA=
Date: Mon, 5 Feb 2024 04:51:40 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: dma-sysfs: make dma_subsys const
Message-ID: <2024020537-camping-unaligned-7582@gregkh>
References: <20240204-bus_cleanup-sh-v1-1-44ced951bb16@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-sh-v1-1-44ced951bb16@marliere.net>

On Sun, Feb 04, 2024 at 12:15:09PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the dma_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

