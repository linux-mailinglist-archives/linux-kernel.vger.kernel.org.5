Return-Path: <linux-kernel+bounces-133977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6764A89ABA7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B771C20BF0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56DC3A1B9;
	Sat,  6 Apr 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="manFzp8B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C439FC6;
	Sat,  6 Apr 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712417529; cv=none; b=SF5/AwHTqV/tRL5DCKpNjMC3Ser9A8u7COhejudmLDDKOINaALajuxOyps8xudbB573FUsbhybZTnVXVu3rkvgkfMqv93r6kVgs334ud3rgcwxqU1O+ynEL1653BYooW8W0i/fhpMMmAMX3DSeahYHICJRwLhco0MuELEO6SxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712417529; c=relaxed/simple;
	bh=ZiWKqTlVngAKanx11YFdGqJCzaJQdlTtuRJlfIa+Y4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aq8lesH9la0J8xiCrJ7sflRT6HLu5d4mBDfgEV3ciXNuYLVNo8bYBu2Dd79AcXYy4TlTtacLdYJ99vOSVkmZPUJyJ2/aboxViI9KUEy3Jif5lJCPT8tdIS4vpjFAxOW7vikb3jDabLnJJhEfLaaWgRCNN2wG2ixc17wwGf4FXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=manFzp8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637D8C433C7;
	Sat,  6 Apr 2024 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712417528;
	bh=ZiWKqTlVngAKanx11YFdGqJCzaJQdlTtuRJlfIa+Y4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=manFzp8Bt1uRVZSBAFwz+W3JmzpoCbxt4xV7y0m0DvY87KAiIWeP8NmDtOS50hiKf
	 m/ylKXgqT1dCHTc7gTc3NZvJ+bDtBaiSOxvZIIY+FYEg7AK4pPso39ww2rJIT+INF1
	 R9ng10FjwAmnfWlpv0nQA8WwmnIB6WZr3gRjgD8cX+bRV0zVy7lP/Nn3k/6XK3gZAi
	 +lMQ0GKPrrg+OqcbXQ7bPj0F12FGLAPzKvNBL6qtJ5lE6WwdMnjJYsbHTP245CEP8q
	 XJicP59jtQML+768OsVk0CpRDaxNpl0CSgUmU3cFOk3omCggANazBudCH2FLOQKJMZ
	 X6n8n48P3Tvlg==
Date: Sat, 6 Apr 2024 16:31:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 16/34] iio: ad5755: hook up of_device_id lookup to
 platform driver
Message-ID: <20240406163155.799f515a@jic23-huawei>
In-Reply-To: <e9aefdcd-5ee7-4b19-847e-5fb3d95cf46c@linaro.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
	<20240403080702.3509288-17-arnd@kernel.org>
	<e9aefdcd-5ee7-4b19-847e-5fb3d95cf46c@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 11:55:06 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 03/04/2024 10:06, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When the driver is built-in, 'make W=1' warns about an unused
> > ID table:
> > 
> > drivers/iio/dac/ad5755.c:866:34: error: 'ad5755_of_match' defined but not used [-Werror=unused-const-variable=]
> >   866 | static const struct of_device_id ad5755_of_match[] = {
> > 
> > While the data is duplicated in the spi_device_id, it's common
> > to use the actual OF compatible strings in the driver.
> > 
> > Since there are no in-tree users of plain platform devices, the
> > spi_device_id table could actually be dropped entirely with this.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/iio/dac/ad5755.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> > index 404865e35460..5c1e7f428c25 100644
> > --- a/drivers/iio/dac/ad5755.c
> > +++ b/drivers/iio/dac/ad5755.c
> > @@ -876,6 +876,7 @@ MODULE_DEVICE_TABLE(of, ad5755_of_match);
> >  static struct spi_driver ad5755_driver = {
> >  	.driver = {
> >  		.name = "ad5755",
> > +		.of_match_table = ad5755_of_match,  
> 
> I was working on this as well and have a bit bigger solution, following
> Jonathan's preference (I think):
> 
> https://lore.kernel.org/all/20240226192555.14aa178e@jic23-huawei/
> 
> I need to send v3, somehow I missed his comments.
> 
> Jonathan,
> Do you want me to still work on this according to your comments (which I
> missed, I am sorry).

No problem on missing the reply! (I'd forgotten all about this!)
I would prefer that solution to this one that relies on the two
tables having equivalent entries.  So I'll not pick up this patch.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 


