Return-Path: <linux-kernel+bounces-133974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACB189ABA2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C643CB218D8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9B39FF4;
	Sat,  6 Apr 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uigZlPzx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD1383A2;
	Sat,  6 Apr 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712417428; cv=none; b=jmXMoQdrTk3zSnoWKqO6j7dNy3aW4B9dCNoL0vqf1jHKA1GO8lTS1fWxB2w1FrFrdFq6Ou35Ldx9XnqpK79wIVNfeh0A7fb5/WVpa+0iMYjSq5J/Gg5BATHZaP/llTdbhSJ6u7/qbQjVQv9DA+arYictKeQJ3D1I8vkFX5MCS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712417428; c=relaxed/simple;
	bh=CHrvBh0xlbqvJFjsw9a5/YCVy0HroQy11ohIn2uKx3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwGiNiP4Lz952j2AEgoruZKweUfEdAIDG/DSY8z+Gq+wxGRawlzwkuGQmA5z1qtAB9K1/NFqPb6O6Tq1NaMk4sPG10Kzg5PBa2QX3z0quzDUFff7kY57dlC9dv9yEMIivzewxomBo8l/kQwUkxGxjvbzkvM/V+/Uc1RVhxU7jtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uigZlPzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580A6C433C7;
	Sat,  6 Apr 2024 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712417428;
	bh=CHrvBh0xlbqvJFjsw9a5/YCVy0HroQy11ohIn2uKx3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uigZlPzxny7KqiVn4dn24kityK3XVkJiusL5plC484/Ct9WelFhh81dgXBC+NGJAA
	 Ztk3O+mTFvHO+pvCj0Lsuif6XKo0hplreukX+czwSvp7xHt6EI2vgu3qrxlWvOkAn8
	 R5e/FRg61nM9Nt9XO8R2YjzQVw9CPShcjyz6wgQ+jt0KClleNKQ+9Li0fRKC0fQ/9t
	 tNNNQEErKs2MVwcEh0hD1YQU6MDMLv5y6fhMZSLOV/aN2e5Tl5zgo3u+mdjs8dB4in
	 fc6CuRP9IQI6NJBWEz4vfyWqHfh61+oHCkasb1gFlsNkUCPuNXUhvn9q2goKYf2blJ
	 iGNki8QxlPxgg==
Date: Sat, 6 Apr 2024 16:30:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Arnd Bergmann"
 <arnd@kernel.org>, linux-kernel@vger.kernel.org, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 16/34] iio: ad5755: hook up of_device_id lookup to
 platform driver
Message-ID: <20240406163013.76e4646e@jic23-huawei>
In-Reply-To: <65788cd8-3c2d-48ca-8b58-af741884c729@app.fastmail.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
	<20240403080702.3509288-17-arnd@kernel.org>
	<e9aefdcd-5ee7-4b19-847e-5fb3d95cf46c@linaro.org>
	<65788cd8-3c2d-48ca-8b58-af741884c729@app.fastmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Apr 2024 12:01:13 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Wed, Apr 3, 2024, at 11:55, Krzysztof Kozlowski wrote:
> > On 03/04/2024 10:06, Arnd Bergmann wrote:  
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> When the driver is built-in, 'make W=1' warns about an unused
> >> ID table:
> >> 
> >> drivers/iio/dac/ad5755.c:866:34: error: 'ad5755_of_match' defined but not used [-Werror=unused-const-variable=]
> >>   866 | static const struct of_device_id ad5755_of_match[] = {
> >> 
> >> While the data is duplicated in the spi_device_id, it's common
> >> to use the actual OF compatible strings in the driver.
> >> 
> >> Since there are no in-tree users of plain platform devices, the
> >> spi_device_id table could actually be dropped entirely with this.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/iio/dac/ad5755.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> >> index 404865e35460..5c1e7f428c25 100644
> >> --- a/drivers/iio/dac/ad5755.c
> >> +++ b/drivers/iio/dac/ad5755.c
> >> @@ -876,6 +876,7 @@ MODULE_DEVICE_TABLE(of, ad5755_of_match);
> >>  static struct spi_driver ad5755_driver = {
> >>  	.driver = {
> >>  		.name = "ad5755",
> >> +		.of_match_table = ad5755_of_match,  
> >
> > I was working on this as well and have a bit bigger solution, following
> > Jonathan's preference (I think):
> >
> > https://lore.kernel.org/all/20240226192555.14aa178e@jic23-huawei/
> >
> > I need to send v3, somehow I missed his comments.  
> 
> Yes, that looks good as well, though you might need to drop
> spi_device_id table if you convert it to using pointers.

Put them in there as well (with appropriate cast). We don't want
to stop supporting probe paths that might be using that.

My preference is for both tables, same pointers in each then
the use of the relevant bus specific wrapper - here
spi_get_device_match_data() which will happily deal with matches
in either table (thus avoiding the potential mess of them getting out
of sync)

Jonathan


> 
>      Arnd


