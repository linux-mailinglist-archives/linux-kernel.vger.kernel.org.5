Return-Path: <linux-kernel+bounces-142178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C808A287D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A060F284912
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4E4D595;
	Fri, 12 Apr 2024 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rSmkGd7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3E4BAA6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908186; cv=none; b=pKSdd/4+IAcW1wiEH4KqYbuggbXPGFcSY2+aWBb0g5ANtOMIWckfzt50jBtYukiCkLx9ntRqJ2Y6SMob+FeTAiCnw5csqEPJoMJSaGYIyksdYNRS350nvwB/C6McQlGKjhfTRoYz1ATbjkwDXvMWeE4Bc9H8fTy80IUmGATGYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908186; c=relaxed/simple;
	bh=OTOx3DkJMNdQ0Edf3dWIV7+WlqmokDA901dvqOdLFDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOvBrMio/2JObsg789l0BrvwQIOLFR7FI9kqZYhqWLiYZ4jXJxfV1G46UcwoCTbIq37h6RGReHLjHxl9B6awPifpstlgtbwjjFxzK8FIVHwRxEg5IFvFqvWQsXhepG1tyFbyo2hup665pvsQPY65FpU0wppTgMKKIbBRTf4VLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rSmkGd7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB41C113CC;
	Fri, 12 Apr 2024 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712908185;
	bh=OTOx3DkJMNdQ0Edf3dWIV7+WlqmokDA901dvqOdLFDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSmkGd7emGIwHEEq6u6SGyABZiPL+RzY1N3KqcTM7Ff1Tm2+4CSanSTlmxinvTtiF
	 hIhrsymTiaVyqBKat8ajXHRSLDkSqi7aKbQa+RPbEQyCwMIfJgP92GbyFFOBPF8IDW
	 JdC0kPjQCNS6ghhv6RFcITLKe09GIbaIKZiqk2dc=
Date: Fri, 12 Apr 2024 09:49:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: guanghuifeng@linux.alibaba.com, cleech@redhat.com, njavali@marvell.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] uio: pdrv_gen_irq and threaded intrerrupts
Message-ID: <2024041233-aftermost-vigorous-4b68@gregkh>
References: <20240412045536.1909897-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412045536.1909897-1-chris.packham@alliedtelesis.co.nz>

On Fri, Apr 12, 2024 at 04:55:34PM +1200, Chris Packham wrote:
> I've combined these two commits submitted separatedly [1][2] into a small
> series. They can be applied separately as they are not dependent on each other.
> 
> [1] - https://lore.kernel.org/lkml/20240325015045.778718-1-chris.packham@alliedtelesis.co.nz/
> [2] - https://lore.kernel.org/lkml/20240325015045.778718-1-chris.packham@alliedtelesis.co.nz/
> 
> Chris Packham (2):
>   uio_pdrv_genirq: convert to use device_property APIs
>   uio: use threaded interrupts
> 
>  drivers/uio/uio.c             | 24 +++++++++++++++++++-----
>  drivers/uio/uio_pdrv_genirq.c | 10 +++++-----
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> -- 
> 2.43.2
> 

Can you just send a fix-up patch instead?

thanks,

greg k-h

