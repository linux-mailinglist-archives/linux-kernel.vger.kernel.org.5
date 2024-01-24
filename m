Return-Path: <linux-kernel+bounces-36999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0783AA01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED832896CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2D97763E;
	Wed, 24 Jan 2024 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X161Be2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65C76918;
	Wed, 24 Jan 2024 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099999; cv=none; b=s1SsuAeUn3gnv29pjZZe5rOoqvhJyJ6D9aLxTjXqN0pnyLQRcEr4tVfy5Iu3hFu65JoNa6AjNkHmxPKFBi5YW41ZXhPOFAvnUVc/zARuJQ0rWmTbjq+ZDvDd01dym9Z4xbaUHnCRigm8ykcyZMOzsX874KMRKxVmPEjn1+ERAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099999; c=relaxed/simple;
	bh=dK6lm4L/4++nH/EwK9llPnRTDeubl0qwy4zZz3EHVNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgDJHN/UUWW6DdyHgSzSfnHsb/sfK4y/UobEJ5kFNPCVPdWfKwn19fb5boQ5kHZkeS/RcVcYVXC4F8SEVHHRsJ9cyqX7WeEflhzP4k6F3d9NPU2dm2UMr//ByS4435tcQ/BUGGwN/Y3VXuUx4aZ1age9gg8PaMZCoAnUSHLwYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X161Be2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D183C433F1;
	Wed, 24 Jan 2024 12:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706099999;
	bh=dK6lm4L/4++nH/EwK9llPnRTDeubl0qwy4zZz3EHVNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X161Be2LtBjg71xtIVV/ThsJWfShJM/GRbnuPOjx//Imhdv7+FkdwW18zRFlF4C2J
	 lcq6JgBQWV7Ln0oKpHdoUeVwDHz0HasHi7D9dinZRcpNLG2U9+IdcFwWqAeFbJAwOI
	 FdJgaA2toOG3qda1nZTrVF270l/+oy6lqDNx3gFs=
Date: Wed, 24 Jan 2024 04:39:58 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3-of-simple: Stop using
 of_reset_control_array_get() directly
Message-ID: <2024012441-gender-crock-016c@gregkh>
References: <20240124-dwc3-of-simple-reset-control-array-fix-v1-1-808182cc3f0e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-dwc3-of-simple-reset-control-array-fix-v1-1-808182cc3f0e@pengutronix.de>

On Wed, Jan 24, 2024 at 12:26:20PM +0100, Philipp Zabel wrote:
> Use of_reset_control_array_get_optional_exclusive() instead, it is
> implemented as:
> 
>   static inline struct reset_control *
>   of_reset_control_array_get_optional_exclusive(struct device_node *node)
>   {
>           return of_reset_control_array_get(node, false, true, true);
>   }
> 
> This makes the code easier to understand and removes the last remaining
> direct use of of_reset_control_array_get(). No functional changes.

Does this mean the function should be removed or made static now?

thanks,

greg k-h

