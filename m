Return-Path: <linux-kernel+bounces-165359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350F8B8BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B436F1C20DA8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A62F12F363;
	Wed,  1 May 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TSUOSfvb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA412E1E0;
	Wed,  1 May 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572844; cv=none; b=tkJLwsrFK8g0fKtwM+0gZie/pqUQ94ghuBzPmjlaL93BAXojhBU5V1xEHy9lqAXAipj9PSDcXRuT2YxuP1XQXYkQRiyxvk7muouVpZJkkaFRO/BeNQ3jIkiorZQpCyFAYVkMnWkC0yE0WqsHn1h89QLwJTv6ObjFL3Q8wv/BgLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572844; c=relaxed/simple;
	bh=6OXPCkzN/zHDiCjzDlCgu+l7lTQF3AP9altTiQ3IE9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLiPh+YvQcuK8Uonp/AfmApI2RGVCNWlrXQ4puWZbNr2uTLgzsxcU7pg7Z+euIAZSWwM/Nypp8U/A4IA/RKoffB78zZukPt+L0e3bVsLoJkNbuXRBUWxhYFx3XFcZfcMrtXIg+TkAE6OTAF2hnW52AHe15N2lUVjJXlrm6I8V90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TSUOSfvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4DFC072AA;
	Wed,  1 May 2024 14:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714572844;
	bh=6OXPCkzN/zHDiCjzDlCgu+l7lTQF3AP9altTiQ3IE9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSUOSfvbMvt/DMmrDdhA5xPkX+OTAJnABIBIOiVM6d0kBCVGb50NMRiqGYqT7phuM
	 3vfGEYZ0XmLlgMWw/k5d7z8UuB0IShuOSmwojgJ5Zbj5XVKn9jcQyi8yTQeAHBG/e4
	 o8q9nZy6fIqORMHOKfE0i60tuVbAjXCx0eDu6rCA=
Date: Wed, 1 May 2024 16:14:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shahar Avidar <ikobh7@gmail.com>, hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com, robh@kernel.org,
	felixkimbu1@gmail.com, krzysztof.kozlowski@linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: pi433: Use class_create instead of
 class_register.
Message-ID: <2024050158-mutilated-zero-13b0@gregkh>
References: <20240501055820.603272-1-ikobh7@gmail.com>
 <20240501055820.603272-2-ikobh7@gmail.com>
 <cc00ea68-0ec9-40af-a147-e8f67f7f29d0@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc00ea68-0ec9-40af-a147-e8f67f7f29d0@moroto.mountain>

On Wed, May 01, 2024 at 05:00:44PM +0300, Dan Carpenter wrote:
> On Wed, May 01, 2024 at 08:58:19AM +0300, Shahar Avidar wrote:
> > Make use of a higher level API.
> > Reduce global memory allocation from struct class to pointer size.
> 
> Doesn't this move the memory in the opposite direction from what we
> want?  Originally, it's static const.  Isn't that the simplest best
> kind of memory?

Our reviews just crossed...  This is just a revert (in 2 steps oddly),
of a previous commit that changed this api call, and for that reason
alone we can't take it :)

thanks,

greg k-h

