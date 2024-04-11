Return-Path: <linux-kernel+bounces-140406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D8F8A13FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91546282B21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2501414AD3D;
	Thu, 11 Apr 2024 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePtHMzYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D5145FEE;
	Thu, 11 Apr 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837213; cv=none; b=odGk6cbMtmD01+05F8W52wb/jr+ntfJ5FAQPZH3LJ+aQQsV9rVOcMyhpNztExLWo+w89bqk0BCM8wwyM3gDVyTGriUFMoBmCAQImjxRNd8pGTkGWQcoVJPy9iH/dVh+CRuvFaNhK1K0yaBZSmXe5r4wW2YXLV5yU0vUdN9BsBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837213; c=relaxed/simple;
	bh=jFxW61R4XvNpf6y0HK808cnVABYyTYDvgVwNDWHbSes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T58E/fnbeSNJwwV/8pFfNN+noCxvP7JSd84aXQZ0xLnunof+WrM4fh7ogMKcF57q1KZmvD1PQICjdzRWjMoQ8npBfiI6KH2mRG0EjTyenSxBhnx5L9W4YFcQzI9vv9QD2ahHe1M3HpONdZeONrwWBJxZvtlCOExTI2caywYQS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ePtHMzYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B66C433F1;
	Thu, 11 Apr 2024 12:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712837212;
	bh=jFxW61R4XvNpf6y0HK808cnVABYyTYDvgVwNDWHbSes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePtHMzYfrvBhjxvYsuscTYaPtgAjEVuz2SwBegGLm75FJFOmRvQdd7gne8yFXzmRN
	 ql68WT5o937J2cMlVxV7kmJQA42Gx9zZ2Da4egqAzuaO6rSnrvhko5IbT6wZez5/++
	 SS7tVSigdOYeQew6JyRxf5rEvrohzMuhwcEGyzR8=
Date: Thu, 11 Apr 2024 14:06:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Sergey Organov <sorganov@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: imx: Introduce timeout when waiting on
 transmitter empty
Message-ID: <2024041122-transfer-diffuser-781a@gregkh>
References: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
 <cf197182beab7acf6ea7ead54fb4324e97e18cbc.1712733269.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf197182beab7acf6ea7ead54fb4324e97e18cbc.1712733269.git.esben@geanix.com>

On Wed, Apr 10, 2024 at 09:18:32AM +0200, Esben Haabendal wrote:
> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potential
> deadlock.
> 
> In case of the timeout, there is not much we can do, so we simply ignore
> the transmitter state and optimistically try to continue.
> 
> v2:
> - Fixed commit message typo
> - Remove reference to patch series it originated from. This is a
>   stand-alone patch

The "v2:" stuff needs to go below the --- line, so it doesn't show up in
the kernel changelog.  The kernel documentation should describe this,
right?

Please fix up and send a v3.

thanks,

greg k-h

