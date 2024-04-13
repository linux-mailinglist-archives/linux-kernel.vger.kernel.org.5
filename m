Return-Path: <linux-kernel+bounces-143806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E38A3DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43006282234
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6154D59E;
	Sat, 13 Apr 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbSDhnlk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3F93D977;
	Sat, 13 Apr 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713025216; cv=none; b=SS8p/LOrQn0Euwn0TZbZ00t5zYzI5hUa0XvbgGvhnIynCLVDgLJCK70ZsrPGyRB1CliXBUU6S7HNnMdy3M8uPaggsgnSW1+gl2F3y5fNdbgzEka28XqoCFsWq+cL/uLXhCenYhz87eX57a4JaF9kEciRFYTmKwiuBqjZz5W/A0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713025216; c=relaxed/simple;
	bh=u1sdpsHRRMz1U80voi5/l1HBjWo/eglJy0L8udE+sXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMsEy7g1nAsCyYNQpp2VblR4d/qf7kShT587ycGfaGOZIgUPORB8EJFjwMVFCDrSWm/G2S5VCb9wR2oa4EXBpKkHZ058YwWLJVVrgKvbLVWpZvX/Q+Qo5hyC0CnG04AUCbUlcZuE2Aefk/nu6h0UFSvkcaLTY6wmAAdAdGHWJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbSDhnlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1788AC113CD;
	Sat, 13 Apr 2024 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713025215;
	bh=u1sdpsHRRMz1U80voi5/l1HBjWo/eglJy0L8udE+sXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BbSDhnlk4kaKT6z5SiGBibVAWc7CXKIyLy30sSTy63P85AOHCy7M69KedHfJZEKON
	 L/1afOfZc8oW5JO32sUF9amzSxhyoEtSV1eu0u5wLzKTItp/8i8Qj9d5CMiODRTfA0
	 cwGzJF8QNuYXtpiT4PBrbSZY4FY4UcvFWRUWIvMi25Lboms9b1FWAvpcS7aQJaiijy
	 9JujxORcsa7phI3IRMFzF1lp0sXkgNg8pa3do1QvMWHXzaM0bg1Vp0B25CiaJtiHFg
	 FP34REKX4W1G1FmF4vQ70b8ip/OVRB2LKk5lLUtylkpRno7XHkLvJ7vKO6DT4We9w3
	 /uFQHZR0vBvyQ==
Date: Sat, 13 Apr 2024 17:19:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for AD4000
Message-ID: <20240413171959.2361c80d@jic23-huawei>
In-Reply-To: <CAMknhBEMDg3YF5pvoKJ-6y0Y5OJpmBthWfogCjy90B=F84SvzA@mail.gmail.com>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
	<1d95d7d023dad69b894a2d0e7b0bad9d569ae382.1712585500.git.marcelo.schmitt@analog.com>
	<CAMknhBEMDg3YF5pvoKJ-6y0Y5OJpmBthWfogCjy90B=F84SvzA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> > +
> > +       ret = ad4000_read_sample(st, chan);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (st->cnv_gpio)
> > +               gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_LOW);
> > +
> > +       if (chan->scan_type.storagebits > 16)
> > +               sample = get_unaligned_be32(&st->scan.data);
> > +       else
> > +               sample = get_unaligned_be16(&st->scan.data);  
> 
> data is aligned, so be32/16_to_cpu() should be fine. Also, Jonathan
> will suggest to use &st->scan.data.sample_b32/16 here too. :-)

Sparse may well complain as well and no one likes build warnings ;)


