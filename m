Return-Path: <linux-kernel+bounces-36998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0946383A9FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9321C20DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7127763A;
	Wed, 24 Jan 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2INuRfFn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA3763115;
	Wed, 24 Jan 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099975; cv=none; b=FMI8pHx3dx8/SJlcnOU6dYOPqYD+zB6TeOFP+6VYmF6daBrS8eZnQ1wil6G79d0dnguBB7IP2hOrfhSisvzsK3/khncd66wEDwC1EG4oRPGOSKuUriSJ5kL7B/Ets5MEsKwUYaSHmHDOGNQHNSRpRjSgvUyyveiH/fpvNq7nbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099975; c=relaxed/simple;
	bh=DT2dSfQM53MVse2sH7HvlYHE0fuTvdEgf9x2x1K/5zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMv9WZHsB7JfqEe7ru9YUKEuB65de60yLCqP+FdFodu/fE9PZMqU0/WC3ZI1NHnktL8hiNqlrWUSIttKuD0GztExhU44h61n0ECQJBtRuO7wYIXvkILgaoBdVq78jfvR+vlXm58jri+nxbPwzQAC0smu+hCPP5PiNZ1QVc811m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2INuRfFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5678BC433C7;
	Wed, 24 Jan 2024 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706099974;
	bh=DT2dSfQM53MVse2sH7HvlYHE0fuTvdEgf9x2x1K/5zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2INuRfFn8Qo757RMaamIOHPEYP/YWCCNxCYismqwX1q4MoZr6uLgivNS5keK1iwb8
	 t7XpkRK3+prykIGdYUumgESTTCx8ILoU0goBIC5JWDC83qQIKwC5LFJaKSvbYoU7bi
	 9bLGAR9IMN039uYj4PGozMCZB/YfUoKFS+N+sY10=
Date: Wed, 24 Jan 2024 04:39:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3-of-simple: Stop using
 of_reset_control_array_get() directly
Message-ID: <2024012400-subtitle-magnitude-45ff@gregkh>
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
> 
> Fixes: f4cc91ddd856 ("usb: dwc3: of-simple: remove Amlogic GXL and AXG compatibles")

No functional change, but a Fixes: tag?  That doesn't make sense to me,
sorry.

thanks,

greg k-h

