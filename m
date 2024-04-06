Return-Path: <linux-kernel+bounces-134057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1FF89ACA1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AD01F21D76
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C07A481D8;
	Sat,  6 Apr 2024 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwwkuCxw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BF1E86E;
	Sat,  6 Apr 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712428515; cv=none; b=pCkkMSmEXWtJh5Xrk2ZQBI/4ALTGFBL97/BQJxCBTOQvof19Bi6XQV2vt436FMwB2MHEqaFAq368K7Ty3c0EcAvECt7wZvlWBc+vlDrAvscgWQJruKZSq+yUy3sYuYC56iXTh3nHtSw9MusD3SsGngCrpNuqPrxz17y1ZdAQ9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712428515; c=relaxed/simple;
	bh=JJadtLGGQU8Da7vaVgG5DqXtyVsPFDQjEHLVDvlD7dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu6PIVTEa/iZ5YaEWDTbBsFWfItJn4oAzVVYFSIZwa6nXn73aX0HXd6RdY1aD74cBAp040RY+ekt1RDxttwOyUZKIi+Zk2f6I2SZWBJWdTp8N2u6ihp6nHf6YUtX4XHIalC2VFEzepI8kWQyCeo5O1zOUz6DhI9+/Fw7Ntya+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwwkuCxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EE9C433C7;
	Sat,  6 Apr 2024 18:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712428514;
	bh=JJadtLGGQU8Da7vaVgG5DqXtyVsPFDQjEHLVDvlD7dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwwkuCxw0LPpMhXloIykbX0iRg9kDG2/A+sszXhH/h/arXdpLmXgM5lzqhWBb1FEi
	 wRnXxP+Ic1pGkQtK3KwMjEURdpMN8q8gGmDo5UjpTmeYWKDGERg/1NusTO7GaoJjiW
	 +IY2ROGO3v8hK+w8vrVVURIo+WEyzBYKXJRRIHJL2ixxEd7yRGiuWRmWuxVgXI5PS8
	 ZPT9DjnbCD4uFuHe2WWgDc5sMqOIHDPMI+zWcoATln5hdDHtAjw/E9yjJqOrUHdC4W
	 3iJlF/YbZ1/jH+nR6Dyl/1732DqpnGN9Ao/AjpZQsww8PIxQld1KAT47ZarOZT9VS0
	 x/K/8NzKuEFZQ==
Date: Sat, 6 Apr 2024 20:35:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Jyoti Bhayana <jbhayana@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] dev_printk: add new dev_errp_probe() helper
Message-ID: <42sw4ugekugyqzjylsci6tvw5zfxlwz6ypnetnau6dyqnrqfiq@5jde2w4etpfh>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
 <20240404-dev-add_dev_errp_probe-v1-1-d18e3eb7ec3f@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-dev-add_dev_errp_probe-v1-1-d18e3eb7ec3f@analog.com>

Hi Nuno,

..

> +/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
> +#define dev_errp_probe(dev, ___err, fmt, ...)	({		\
> +	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__));	\
> +})

I have a whole series adding a set of error oriente printk's. But
for the time being this looks OK.

I just don't like the name, the 'p' is an important detail, but
a bit hidden... how about dev_err_ptr_probe(...)?

Andi

