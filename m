Return-Path: <linux-kernel+bounces-164931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7808B851C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD0C1F22D47
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BBF3F8D1;
	Wed,  1 May 2024 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mNa1Bdr5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC53BBCC;
	Wed,  1 May 2024 04:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714539096; cv=none; b=Ua/rO9ynBTXJWM6n4Xj+03LT9/PpQx4K2bbXnTVlLQPHv7B3woRzvuMyJYxvxAttpbb8uvDYR4qpo64zOGS2rMMzFKevs5lfB12EQC5R/bsxtzls/UGtLO4G5DaGoUDubeVG9L+B9dIVPLl00Zje65cI4nLnTlBvqyY2bn5zU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714539096; c=relaxed/simple;
	bh=YGgTKxXyqaAAF0ywpX/ecqJzXT56HBCZAyegb7doVOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHpqrCFnOFYQYdm2y9tFYbdqZSVsROdCdoe2vK0vlxkCMzDV6rvzEJzPcI8TYrlKy+dmbRiRgjwoh8gbJoYkbgZZ3fBE84m3UfCUzZFScw8lnas311BCWZZDbC8otEks8FXhzwK9pzXbXMEHVqN8okwH+TwvmieKeawoEFpeh4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mNa1Bdr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49AFC113CC;
	Wed,  1 May 2024 04:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714539095;
	bh=YGgTKxXyqaAAF0ywpX/ecqJzXT56HBCZAyegb7doVOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNa1Bdr5TFjWcP9iAAg5BlZTLsOnqct+9qUlRPMOUwU1G3s/rQiwdQof55dY1bM3S
	 BvEwg8Pfg992May+XXuicxUC8MWxy2v1TH23T+6sBDyYSF9sjHJKMaLg4OzhzfE0se
	 J1j+SjQcbRH2LCL/Xa2IEOxzu9GXI4YPtu6wdwxc=
Date: Wed, 1 May 2024 06:51:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: davem@davemloft.net, jirislaby@kernel.org, linux-serial@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Shuah Khan <skhan@linuxfoundation.org>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tty: sunsu: Simplify device_node cleanup by using
 __free
Message-ID: <2024050119-pediatric-prankish-64b9@gregkh>
References: <CAE8VWi+UwYWw+RBMPi5ozg+sQHKtyxp2i2K3u9e3b42Gt8D+qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8VWi+UwYWw+RBMPi5ozg+sQHKtyxp2i2K3u9e3b42Gt8D+qw@mail.gmail.com>

On Wed, May 01, 2024 at 10:01:00AM +0530, Shresth Prasad wrote:
> Hi,
> 
> Could I please get some feedback for this patch?

I don't see anything here, sorry.

Also, how was this tested?

