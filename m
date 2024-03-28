Return-Path: <linux-kernel+bounces-123064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41F08901A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013461C2BDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70F01272C7;
	Thu, 28 Mar 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW+heum+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BF81AB1;
	Thu, 28 Mar 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635736; cv=none; b=UmDS0d6syVOWfqTsI3Hg7XMynDA4sg2Etk4DrNOfXMnWENTScAK+Z5xuObjmXH2Gos47NWgiVmNuTd2CJfcVmQ1zBAipTvl4wDg1urgKEDQOky0ulwNgZm5IZRYOEbMXOq6xnF0fI+1BBqqUCHOWe+LOt3Lxuqj6JKWATcPXVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635736; c=relaxed/simple;
	bh=P56jOi+vB8F/gMU79xMGuZt5R/KzQ/6nNhG9zp3Tbzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pG+NC5wDUEg//PvFDfmP6DrCwQVmsPdCjskMv4RLCHI5CVKHnnLMXnIyu2KyymCkq/eqSTIkjP+c4XlAfPx+pKt3aNwzWM0TjkTF9n46cjkXziyQeTEGTppHZbflroTC/BGBQMCEpQzVHPg8Tb0J9iBVX4utiRbSIpagdlbhKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW+heum+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B217DC433C7;
	Thu, 28 Mar 2024 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711635735;
	bh=P56jOi+vB8F/gMU79xMGuZt5R/KzQ/6nNhG9zp3Tbzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qW+heum+mVGRg4Y8WD/6/b5KDOfVXXCaezVOK5N5kNlmQKXB+4xgq886lcXn+VCHZ
	 nvtP+Jpzo3FgDgMkphAbyJNVdL2Btul4fMPChIBvEfxGkghWBpkyEFw0FwDa6Ls5ET
	 OYJk/wXBKRia4xnvbG8q7ixE2E8WZO6/s0NvDBLS6Q9zfdslkT1SVYhNg/n/ACD3g5
	 iXw9neckqjuysP8U2VI8A/pZaiGzGFNZ7f6bFJuNzlxGoLTETp3JHR/dGXj0s5tRVh
	 KULLcNWOKbBgyQCVa6rX7+MtEN0PdIGx1uFp8AN+j2HQXH4R8UAzk98CECzVVI6si0
	 jn5mqWWWk3nXw==
Date: Thu, 28 Mar 2024 14:21:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, Support Opensource
 <support.opensource@diasemi.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 7/7] Input: mpr121: Use
 devm_regulator_get_enable_get_voltage()
Message-ID: <20240328142157.2165dc5d@jic23-huawei>
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-7-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
	<20240327-regulator-get-enable-get-votlage-v1-7-5f4517faa059@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 18:18:56 -0500
David Lechner <dlechner@baylibre.com> wrote:

> We can reduce boilerplate code by using
> devm_regulator_get_enable_get_voltage().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
LGTM though you may want to bring an error message back if you drop the
prints from the regulator functions.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


