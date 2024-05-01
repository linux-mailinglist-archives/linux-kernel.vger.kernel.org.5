Return-Path: <linux-kernel+bounces-165358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D1C8B8BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3448C283390
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3E12EBFE;
	Wed,  1 May 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RKl9atsn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AB12DDBD;
	Wed,  1 May 2024 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572773; cv=none; b=OsKviZjqeaMNZ746rxWLewVi2Bg2CnLLTcV3zrQkKSI2tuQfK6lc+NONrrCFWswM3FizDOpDnkXr/DqNxCplO6D0HzGlK+o0UndfZu+ec24UPIILStuafltnLC3IRbclwi/hztRhxWw024rGorzECPJpUUpsPqor045/OomUZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572773; c=relaxed/simple;
	bh=fgxzKQGhIkjktiZA/KPlfV5pis6w6LQ3+OD0G47qTM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXXSAQJ9w3Kyx88+0Pr0sKcbOq5BLYmfkWPUVYy+eIT88+2t6NTbGWJdx9Gr68dsq2+cKWS3jx+AdttPQm4fjb85Ao3TxCwDezVQSWON2/4DOmV3V7XW1WTELn5GLzoDkyIqX+7NpgFenRa68zPlbNFpQIcCHoFeEIUufQXzK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RKl9atsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A70C072AA;
	Wed,  1 May 2024 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714572772;
	bh=fgxzKQGhIkjktiZA/KPlfV5pis6w6LQ3+OD0G47qTM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKl9atsnOsj/xFo+DR7RMrKYnOWbBnzRDKp6oK1U+t6NqGKRkLuug33aByA2jT4gR
	 ovHyPx0RlPkGeR3/rDqKcUCWxldy0UcgxvizOpXphb3AY+YGKF1ztUjQa7/RRlKqXV
	 iX/gvR2yPIlNov6CiBEa1ILMo1E8Np6KCJ3pdYRw=
Date: Wed, 1 May 2024 16:12:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: hverkuil-cisco@xs4all.nl, andriy.shevchenko@linux.intel.com,
	robh@kernel.org, felixkimbu1@gmail.com, dan.carpenter@linaro.org,
	krzysztof.kozlowski@linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: pi433: Use class_create instead of
 class_register.
Message-ID: <2024050109-reward-vision-58e9@gregkh>
References: <20240501055820.603272-1-ikobh7@gmail.com>
 <20240501055820.603272-2-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501055820.603272-2-ikobh7@gmail.com>

On Wed, May 01, 2024 at 08:58:19AM +0300, Shahar Avidar wrote:
> Make use of a higher level API.

What does this mean?

> Reduce global memory allocation from struct class to pointer size.

No, you increased memory allocation here, why do you think you reduced
it?

Also, this looks like a revert of commit f267da65bb6b ("staging: pi433:
make pi433_class constant"), accepted a few months ago, why not just
call it out as an explicit revert if that's what you want to do?

class_create is going away "soon", why add this back when people are
working so hard to remove its usage?  What tutorial did you read that
made you want to make this change?

thanks,

greg k-h

