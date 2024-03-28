Return-Path: <linux-kernel+bounces-122995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C37C8900D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3C6B22CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45C823C8;
	Thu, 28 Mar 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ7l3BC4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EEF1DFF2;
	Thu, 28 Mar 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633919; cv=none; b=roBjaAxp2ZiJ6XxxXm7OqnwA7l4LlSewfpT3eAVb2MSgxbUdaBW7OqwnFSFmsQdzcQ38qTZFQzuVdK96hqTxeAZkV7UfahB/4ndjVEouANuZfCbetLz67of9rvqh2xQLZSnwB1uR/M0HQVmXD5seCI/+44pyAfA2qI//Oaj3zpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633919; c=relaxed/simple;
	bh=26u9hTutRX6gyzhSopBxvNqZnd9SNWQgRgZYdO/+yxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUiiKJa7Zv35vxZa/FVhUU3mf3+TcA6AQe+THtoOzyXK1nZQ1TXJPmMZdpoTuuTLlSv/tmNJG3zP463QnzkKfjCpYG0Djqm9BPUmSCHBiN5TeFr90FIIemgIAUZ0+GBDT592ByRlif3L6h3gEzboIfNB0uZfKjA+KrQbPN8u2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ7l3BC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5365CC433F1;
	Thu, 28 Mar 2024 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711633919;
	bh=26u9hTutRX6gyzhSopBxvNqZnd9SNWQgRgZYdO/+yxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZ7l3BC4RFLFjfD958z/Um8CFZJv87cNlRlI2Q68ynNI5q3ZWgso7zPVIi8TTsRbt
	 x6ltTKqlH2ezgVxYqJdyHkgsf3MxwjsbzY8Ttwd7n232+ILqpSgEwThJ0XU3CVwOFb
	 mG7lC9MPSEO74lcIJYE2eCCZkUP0h1DYU0Bl/rqN4RSdxlIO+JzDoCLfuC+MbsO0tr
	 ERVYr0LkSOIGAwM+idaDlpuCOpkMbbaGnYUXbgoi9Q1jsn+Rvs2UVOGVfszjPb+9Ge
	 4KXetUBFBwBr4n8KynzSYgedrrPXwmCfKyXZzl5hrWyQpIePoh9+k4zzeySti9Pe8R
	 I2knuWsLWI3bg==
Date: Thu, 28 Mar 2024 13:51:40 +0000
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
Subject: Re: [PATCH RFC 5/7] iio: frequency: admv1013: Use
 devm_regulator_get_enable_get_voltage()
Message-ID: <20240328135140.7cb91163@jic23-huawei>
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-5-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
	<20240327-regulator-get-enable-get-votlage-v1-5-5f4517faa059@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 18:18:54 -0500
David Lechner <dlechner@baylibre.com> wrote:

> We can reduce boilerplate code by using
> devm_regulator_get_enable_get_voltage().
> 
> The common mode voltage is now passed as a parameter in the init
> functions so we can avoid adding a state member that is only used
> during init.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
LGTM - on basis this might not go through my tree

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

