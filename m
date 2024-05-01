Return-Path: <linux-kernel+bounces-164934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B258B8530
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2FD28463F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C073FB09;
	Wed,  1 May 2024 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwtBneT/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D911CB8;
	Wed,  1 May 2024 05:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714539806; cv=none; b=cNd+k0rTkTk+m38h2a4vDaKqaXe0YO8l9YtwVBSqk1II2s6ncwUJWwo7MU6PCjgXDrdqxi3n9vC3NUiMbpd+PdWElX6uuNhdQcfawiq0p0rzoxBf8Bi7hTV6ijRioKqLgGIGRbNao8pkre4DZ28gnpGJYfhNBfogx+G/y+9uoa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714539806; c=relaxed/simple;
	bh=6CTLEQa1Z7qc3o6aubQDW1BWUYOYvkB+w0sj7I9NFXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf6ITNNAd9MmNRrNLLipo68XQeg6McuM2gE0H5vhaFynhX9TGMR4a+ngBVOVkTshQgHBv45UiGALk027wQ2EFZMb6M/ElMjIKf2RzAEERfD51AUVz43ZkMI3CQzv3T8dgSoRdy5uIXURnsbXgqWwlMIuAZwC2Fzfwt6VGJTCPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rwtBneT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EA1C113CC;
	Wed,  1 May 2024 05:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714539805;
	bh=6CTLEQa1Z7qc3o6aubQDW1BWUYOYvkB+w0sj7I9NFXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwtBneT/BbgErfXhF/ZRUP0Q9FCjEV4zPFV/AzuUV3RBVUb24amOVC1qPmdArQQgL
	 aK+GP8CE4QqNZ+gKb/XD/nAP/4osZPTOqglu3h8wtNdLUywyKPQZahsogYAwZfe9qR
	 0YLka69u7ox+NfLqTtgIkHBE6BdjMB89T4qaE2nc=
Date: Wed, 1 May 2024 07:03:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: davem@davemloft.net, jirislaby@kernel.org, linux-serial@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Shuah Khan <skhan@linuxfoundation.org>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tty: sunsu: Simplify device_node cleanup by using
 __free
Message-ID: <2024050149-blob-afoot-af04@gregkh>
References: <CAE8VWi+UwYWw+RBMPi5ozg+sQHKtyxp2i2K3u9e3b42Gt8D+qw@mail.gmail.com>
 <2024050119-pediatric-prankish-64b9@gregkh>
 <CAE8VWiKqrPge_OaeCXXAER6ofFLULLPrPK8StCMV9DPM+WHuHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8VWiKqrPge_OaeCXXAER6ofFLULLPrPK8StCMV9DPM+WHuHw@mail.gmail.com>

On Wed, May 01, 2024 at 10:28:35AM +0530, Shresth Prasad wrote:
> > I don't see anything here, sorry.
> I'm sorry but is this patch not visible?
> https://lore.kernel.org/all/20240425060303.8045-2-shresthprasad7@gmail.com/

Yes, but you did not include it in your response at all, so how were we
to see it?

> > Also, how was this tested?
> I tested it using a qemu x86_64 virtual machine

Great, please say so in your changelog text.

thanks,

greg k-h

