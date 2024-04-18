Return-Path: <linux-kernel+bounces-149569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0003F8A92F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B014628162E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A446A8AD;
	Thu, 18 Apr 2024 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SN4LUAdx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27515B208;
	Thu, 18 Apr 2024 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421139; cv=none; b=fUUeM2D3P18QXyW794p71lhxDRObCVORk/zgUqIITiHhBTQqSdYIDVUCweHZJ5Ia6E3H048I8KPXD28W1StHKge+kTj1u/wMB/Dq9TQwotbIE93TnRicXYE9M9KyTZiqJjzMVR0XCFB4FWMNaokGxrp20GLtf2qExVVxjkwKyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421139; c=relaxed/simple;
	bh=qiaaLrLHMNrrVXyQh8MxZ8QW64mjDaaC3fGdkvGQAhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXjwlwyqzhIn/kwQdTtI8K/svNUo3D0el03TQzCenYT7C05NaXJ2E/xpYarBT5QBLAH4U2WSwaUopOHov1EWROOfEYHZ0sctBUJi1iEYZBN4C2hH7xTaOLRuQyPla9m0YdIqIbTcGH1Qe1s9jC2GtxfH0nA8ruUihj8+0/YE9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SN4LUAdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C0DC32781;
	Thu, 18 Apr 2024 06:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713421139;
	bh=qiaaLrLHMNrrVXyQh8MxZ8QW64mjDaaC3fGdkvGQAhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SN4LUAdxKbE+sMItOKd3sTfrXvOIoXQaNkKvdaGvTRqLYuSVU+DARW06ukSfdDRbX
	 1DvjXkJ8j7eLi0aw4xk727QFohmuWyNOVYheRoNqneUVB53+S5uLEc/DsujQSJ5PMD
	 o3OXT8Nqr43rxPJUExl5JCwEubkbvK/AvV3Wdvuw=
Date: Thu, 18 Apr 2024 08:18:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev, linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 1/3] VT: Use macros to define ioctls
Message-ID: <2024041836-most-ablaze-f417@gregkh>
References: <cover.1712080158.git.legion@kernel.org>
 <cover.1713375378.git.legion@kernel.org>
 <e4229fe2933a003341e338b558ab1ea8b63a51f6.1713375378.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4229fe2933a003341e338b558ab1ea8b63a51f6.1713375378.git.legion@kernel.org>

On Wed, Apr 17, 2024 at 07:37:35PM +0200, Alexey Gladkov wrote:
> All other headers use _IOC() macros to describe ioctls for a long time
> now. This header is stuck in the last century.
> 
> Simply use the _IO() macro. No other changes.
> 
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  include/uapi/linux/kd.h | 96 +++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 47 deletions(-)

This is a nice cleanup, thanks for doing it, I'll just take this one
change now if you don't object.

thanks,

greg k-h

