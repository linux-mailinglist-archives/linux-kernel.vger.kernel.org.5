Return-Path: <linux-kernel+bounces-161440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78D28B4C00
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145DA1C20E20
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3D6E61D;
	Sun, 28 Apr 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfjuQ0Z5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A40F516;
	Sun, 28 Apr 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714311147; cv=none; b=cVQfT8g4yG8Fh+fBKqw63Wu31HRh32iuWJQ9PQBJKmYYXeQf8sHdGLhA9vF5JwpPFmZungKsKyNHLG5xK5bov5giGA4qyAcN+dpOnNaMyxbCCaCy0AI301vzqKYhkhVwTIpGOX72XivZKkXsRdbXMiuc5awFWulwPmuNHWC1iXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714311147; c=relaxed/simple;
	bh=DpW/WuXrLhtm2ZKRngLmSo7dhMhjdfQekX2EAKWeMXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXlrl8bLSwyT5mFHvxPbLoi6vJHY5gcUF/w1qMI8AvA3sI1nVr8Cklk3AhrQv9A5XuY8kmaQkKFjIvcrpSYq2Vs19dl+oo4R+RQ3UfTVAhZlETjhLe9aS1Ntl/fKvOP9AtB0KshCSaJ5QtpilJ+p/Sxz9PtYAnkEyRpD4jKQvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfjuQ0Z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD39C113CC;
	Sun, 28 Apr 2024 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714311147;
	bh=DpW/WuXrLhtm2ZKRngLmSo7dhMhjdfQekX2EAKWeMXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SfjuQ0Z5+q3Ohqyg/hpbGu/B5Bkmr6r99A6SRFj7OeMzzBZCezPPuhnvKvjyKw7iC
	 SZwQ/zlRKeJF6frW9kQ6sGnh9PPnL4GRMuQ88hHgRWYpdU6fi6Rd1v1FbmOoI6HYSe
	 QlVbYISjLNNHisUuLIbSc8p9XFU4x/8bLlvL5z45v1TUjFG3KrKXe4DxoIDKu53BxF
	 gyUCqvtMiQ80yDlBeaCzF+kE0VCK7Sxs6VgIhKJNTIq9+bE9D/j2ZkDbjrYGwZRMMb
	 ee6gWl5EzNH5y2CM7A6FoEptUabwnJmBBwoF7RAKhgb/c0yp6gsI8RUWPqQETSHESi
	 WXvRvPOlKaCtQ==
Date: Sun, 28 Apr 2024 14:32:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, marius.cristea@microchip.com,
 lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v1] iio: adc: PAC1934: fix accessing out of bounds array
 index
Message-ID: <20240428143215.3388426d@jic23-huawei>
In-Reply-To: <20240425-vastly-salad-e56b9225e662@spud>
References: <20240425114232.81390-1-marius.cristea@microchip.com>
	<20240425-canteen-alias-5a907b1deecc@wendy>
	<20240425-vastly-salad-e56b9225e662@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 16:36:19 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Apr 25, 2024 at 01:22:45PM +0100, Conor Dooley wrote:
> > On Thu, Apr 25, 2024 at 02:42:32PM +0300, marius.cristea@microchip.com wrote:  
> > > From: Marius Cristea <marius.cristea@microchip.com>
> > > 
> > > Fix accessing out of bounds array index for average
> > > current and voltage measurements. The device itself has
> > > only 4 channels, but in sysfs there are "fake"
> > > channels for the average voltages and currents too.
> > > 
> > > Fixes: 0fb528c8255b: "iio: adc: adding support for PAC193x"
> > > Reported-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>  
> 
> 
> Huh, this is an empty message. I intended to send some tags, but must
> not have saved the buffer.
> 
> Closes: https://lore.kernel.org/linux-iio/20240405-embellish-bonnet-ab5f10560d93@wendy/
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> 
> Cheers,
> Conor.
> 
> > > ---
> > >  drivers/iio/adc/pac1934.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> > > index f751260605e4..456f12faa348 100644
> > > --- a/drivers/iio/adc/pac1934.c
> > > +++ b/drivers/iio/adc/pac1934.c
> > > @@ -787,6 +787,15 @@ static int pac1934_read_raw(struct iio_dev *indio_dev,
> > >  	s64 curr_energy;
> > >  	int ret, channel = chan->channel - 1;
> > >  
> > > +	/*
> > > +	 * For AVG the index should be between 5 to 8.
> > > +	 * To calculate PAC1934_CH_VOLTAGE_AVERAGE,
> > > +	 * respectively PAC1934_CH_CURRENT real index, we need
> > > +	 * to remove the added offset (PAC1934_MAX_NUM_CHANNELS).
> > > +	 */
> > > +	if (channel >= PAC1934_MAX_NUM_CHANNELS)
> > > +		channel = channel - PAC1934_MAX_NUM_CHANNELS;
> > > +
> > >  	ret = pac1934_retrieve_data(info, PAC1934_MIN_UPDATE_WAIT_TIME_US);
> > >  	if (ret < 0)
> > >  		return ret;
> > > 
> > > base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
> > > -- 
> > > 2.34.1
> > >   
> 
> 


