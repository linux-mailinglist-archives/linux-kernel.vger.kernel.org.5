Return-Path: <linux-kernel+bounces-14776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D782220A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CD6B226A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E4215E9F;
	Tue,  2 Jan 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT3Mn7KK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF715E90;
	Tue,  2 Jan 2024 19:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4DBC433C8;
	Tue,  2 Jan 2024 19:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704223977;
	bh=uOtS3lXOus1XGG0hpqWx1TK6t9UzTRsepItDhOLvLUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HT3Mn7KKR/bkL/+mgAAFZgvvi/v1S++blYiLJHLJBxeZrSulNfCNrjVYjFcTPtFI2
	 wjn6rqeTVZXbW2HsRbK3IoTxhBdsjVhu68LodhjoUyfPAXszXvpU69opNRHvocULMo
	 CETtCS/Xhq/l8yuFnRM//J+AIHGlVoHaiLUc62Hqk+rndxhJoxiBsywNqhGhUpOW8+
	 EQXNlWqhIom8xNFUSR+pOinbZ4loaETRhNKTWX8KOkOp/ValvzT0gMtuoL/Kvqo/LJ
	 1BEiyH+xMjauUdvb4XNShfjlqaBjMdzU+6MRiBovW4JTcjBdljSWCB4V7U4V/Wt3wK
	 tkJe1DsUS86WA==
Date: Tue, 2 Jan 2024 19:32:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Christian Eggers <ceggers@arri.de>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] io: light: as73211: add support for as7331
Message-ID: <20240102193248.25a6f62d@jic23-huawei>
In-Reply-To: <03f469ca-c5f4-4255-90f4-6715a1455e0d@gmail.com>
References: <20231220-as7331-v1-0-745b73c27703@gmail.com>
	<20231220-as7331-v1-2-745b73c27703@gmail.com>
	<20231226161414.47d5171e@jic23-huawei>
	<03f469ca-c5f4-4255-90f4-6715a1455e0d@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


...

> 
> >> +static int as73211_intensity_scale(struct as73211_data *data, int chan, int *val, int *val2)
> >> +{
> >> +	unsigned int scale;
> >> +
> >> +	switch (chan) {
> >> +	case IIO_MOD_X:
> >> +		scale = AS73211_SCALE_X;
> >> +		break;
> >> +	case IIO_MOD_Y:
> >> +		scale = AS73211_SCALE_Y;
> >> +		break;
> >> +	case IIO_MOD_Z:
> >> +		scale = AS73211_SCALE_Z;
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +	scale /= as73211_gain(data);
> >> +	scale /= as73211_integration_time_1024cyc(data);
> >> +	*val = scale;
> >> +
> >> +	return IIO_VAL_INT;  
> > 
> > Obviously it's really a question about the original code but why not
> > use IIO_VAL_FRACTIONAL here as well as below? Superficially looks
> > like it should work in a similar fashion.
> > 
> > If not, perhaps a comment here somewhere?
> >   
> You are right, the use of IIO_VAL_INT comes from the original
> implementation. I did not modify that because the expected precision
> (according to the datasheet is 3 decimal places) is guaranteed with the
> use of nW/m^2 instead of nW/cm^2 (the units used in the datasheet).
> 
> I think the best approach would have been using IIO_VAL_FRACTIONAL and
> the units provided in the datasheet, but changing units now could cause
> problems to current users. We could still use IIO_VAL_FRACTIONAL unless
> that might affect current users in any way. Otherwise I will add a
> comment as suggested.

It's possible we'd get slightly better precision from IIO_VAL_FRACTIONAL
as the string formatter does 64 bit maths and will print far too many
decimal places (matters for high precision ADCs where the rounding
errors are otherwise a problem).

I'd be surprised if anyone noticed as this is read only anyway.
So as far as I'm concerned switch to IIO_VAL_FRACTIONAL but keeping
the same units for this would be a good change. Perhaps doesn't belong
in this patch however.

> 
> >> @@ -355,30 +444,12 @@ static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
> >>  			*val2 = AS73211_SCALE_TEMP_MICRO;
> >>  			return IIO_VAL_INT_PLUS_MICRO;
> >>  
> >> -		case IIO_INTENSITY: {
> >> -			unsigned int scale;
> >> -
> >> -			switch (chan->channel2) {
> >> -			case IIO_MOD_X:
> >> -				scale = AS73211_SCALE_X;
> >> -				break;
> >> -			case IIO_MOD_Y:
> >> -				scale = AS73211_SCALE_Y;
> >> -				break;
> >> -			case IIO_MOD_Z:
> >> -				scale = AS73211_SCALE_Z;
> >> -				break;
> >> -			default:
> >> -				return -EINVAL;
> >> -			}
> >> -			scale /= as73211_gain(data);
> >> -			scale /= as73211_integration_time_1024cyc(data);
> >> -			*val = scale;
> >> -			return IIO_VAL_INT;
> >> +		case IIO_INTENSITY:
> >> +			return data->spec_dev->intensity_scale(data, chan->channel2, val, val2);  
> > Where it doesn't hurt readability, I'd prefer we stayed as close to 80 chars or below
> > as reasonably possible.  So here wrap so val, val2); is on the next line.
> >   
> In order to meet the 80-char rule, three lines will be required
> (wrapping val, val2 is not enough; chan->channel2 must have its own
> line). It looks a bit weird, but I have nothing against it.
> 
> On the other hand, the original code did not always follow the 80-char
> rule (up to 99 chars per line are used), so using two lines with a first
> one of 84 chars could be an option.

Up to you. I'd be fine with 84 chars.

Jonathan



