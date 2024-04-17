Return-Path: <linux-kernel+bounces-148230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809A58A7F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B192A1C21295
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C412F58D;
	Wed, 17 Apr 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t4oQDr5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E0E572
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346095; cv=none; b=sT5awzpg7MEmvp16CzBuasxBGPqwWpGjw/IBYhWAle7ShtsrTf8suNa+owaIMnNUvI/w3HDHqwllr3pn4RpZ1hWTdjo5Y95jeALdy2n7I795dPpB1QeqgqfjSqWKAyVzGcog7aDFfWJcdypWYY/wyBMvsYV+hNrCuzI8o0kZa8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346095; c=relaxed/simple;
	bh=E4NxfokkS134BQqYi4l9d24KTL7bidk0mUYpB0lh7pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYXbbXYw1mnbOSttS/U4c37Hixmk3dtxOKAPtEo7+VzrjB6tMPG89iG2iPENLBOjaHQF6LHMP58aUkNkjjOX9+kOtG2wjeNTIdodRWFf3urw3NQak8TyLlXPDH4HwCmrrfDP4WtX18c5A8gP+wK0pj632yjMk93GYAk24Fbp1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t4oQDr5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A6FC072AA;
	Wed, 17 Apr 2024 09:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713346094;
	bh=E4NxfokkS134BQqYi4l9d24KTL7bidk0mUYpB0lh7pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4oQDr5h3H7bnXCR4Cr7SVoVflqDgciWtzCI+XZ1BRaSCxfdTgH/0Db67Z3HjnZGi
	 M2rQLFsltdSnsvpgsnvu5zUe2b/7uWjUEE4xAL9nwxKI2yUJkdlYAtALzvMkg+FYcm
	 ltWSGy0EFIIYcm6hQwSdQmADIwIeSTKtlluGXBm0=
Date: Wed, 17 Apr 2024 11:28:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] component: Support masters with no subcomponents
Message-ID: <2024041713-devalue-unsightly-56cb@gregkh>
References: <20240417-component-dummy-v1-1-b0854665c760@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417-component-dummy-v1-1-b0854665c760@herrie.org>

On Wed, Apr 17, 2024 at 11:12:09AM +0200, Herman van Hazendonk wrote:
> This happens in the MSM DRM driver when it is used
> without any subcomponents, which is a special corner
> case.
> 
> If the MDP4 is used with nothing but the LVDS display,
> we get this problem that no components are found since
> the LVDS is part of the MDP4 itself.
> 
> We cannot use a NULL match, so create a dummy match
> with no components for this case so the driver will
> still probe nicely without adding a secondary
> complicated probe() path to the MSM DRM driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
> This happens in the MSM DRM driver when it is used
> without any subcomponents, which is a special corner
> case.
> 
> If the MDP4 is used with nothing but the LVDS display,
> we get this problem that no components are found since
> the LVDS is part of the MDP4 itself.
> 
> We cannot use a NULL match, so create a dummy match
> with no components for this case so the driver will
> still probe nicely without adding a secondary
> complicated probe() path to the MSM DRM driver.

Why is the text duplicated here twice?

Also, why are you adding complexity to the core for something that has
not been an issue for any other device?  Shouldn't the driver need to
handle this instead if it wishes to use the component code?  Will this
change affect any other in-tree user?

thanks,

greg k-h

