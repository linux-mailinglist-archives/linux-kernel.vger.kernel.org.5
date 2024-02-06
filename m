Return-Path: <linux-kernel+bounces-54724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6784B2E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932631C212A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568512EBEE;
	Tue,  6 Feb 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vXym/VY/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0E127B7B;
	Tue,  6 Feb 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217021; cv=none; b=ifkWQrwL+VXzQXn9WuouPgoFJnHtpNtgSHfPw8Lg14Lw5xdK/ZCdx1AyL4VZEAv8O49Gzo8/EUsRNbWwOYCRmGLiO7IWIMfLjXKlDbANrJCNsmvdNokCbCHPTz13jU6X4T2OazfcyXlH/in75aCvfaVqeU+Tki4H8uLHUK90b4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217021; c=relaxed/simple;
	bh=3Lhq9mSmpgCBq52pk4XzYDiys11ugzbO0gtwPHiuULc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0GtDiyHawgZcunJJGgGjwQhuWsNiPbeXiwlqwXVjrJiOnGwn1nxnhFr8cu4eoFUUov2D2ELAKtKkxbqJhNnQlZS/9IYCMt1lP+rah1+1NWOJyBuekc5llc6/d5VXmNOiVLj6lPgCgJqLIUvRNi74e91M1uRPVdAWvFKib3HNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vXym/VY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF61C433C7;
	Tue,  6 Feb 2024 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707217020;
	bh=3Lhq9mSmpgCBq52pk4XzYDiys11ugzbO0gtwPHiuULc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vXym/VY/EBHnj6gxYyEiMG/bZ4fM9VgXCQgX++/KO/wikCDxJOL3IWreWxMcR0ove
	 AUDpMH4z5cK6FLXQY7tt/kEWlmbHbPWan21E2eUyrWIKG3eMj1EeU7Qijk0dMFOGRb
	 0QS7aLaAnaE3RCY+KydKS/ZJ3Z1oGbZaxSVyR9tU=
Date: Tue, 6 Feb 2024 10:56:58 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	linux-kernel@vger.kernel.org, manugautam@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
Message-ID: <2024020637-handpick-pamphlet-bacb@gregkh>
References: <20240206042408.224138-1-joychakr@google.com>
 <2024020647-submarine-lucid-ea7b@gregkh>
 <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com>

On Tue, Feb 06, 2024 at 04:01:02PM +0530, Joy Chakraborty wrote:
> On Tue, Feb 6, 2024 at 3:00 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 06, 2024 at 04:24:08AM +0000, Joy Chakraborty wrote:
> > > reg_read() callback registered with nvmem core expects an integer error
> > > as a return value but rmem_read() returns the number of bytes read, as a
> > > result error checks in nvmem core fail even when they shouldn't.
> > >
> > > Return 0 on success where number of bytes read match the number of bytes
> > > requested and a negative error -EINVAL on all other cases.
> > >
> > > Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > > ---
> > >  drivers/nvmem/rmem.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> > > index 752d0bf4445e..a74dfa279ff4 100644
> > > --- a/drivers/nvmem/rmem.c
> > > +++ b/drivers/nvmem/rmem.c
> > > @@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int offset,
> > >
> > >       memunmap(addr);
> > >
> > > -     return count;
> > > +     if (count != bytes) {
> > > +             dev_err(priv->dev, "Failed read memory (%d)\n", count);
> > > +             return -EINVAL;
> >
> > Why is a "short read" somehow illegal here?  What internal changes need
> > to be made now that this has changed?
> 
> In my opinion "short read" should be illegal for cases where if the
> nvmem core is unable to read the required size of data to fill up a
> nvmem cell then data returned might have truncated value.

But that's kind of against what a read() call normally expects.

> No internal changes should be made since the registered reg_read() is
> called from  __nvmem_reg_read() which eventually passes on the error
> code to nvmem_reg_read() whose return code is already checked and
> passed to nvmem consumers.
> Currently rmem driver is incorrectly passing a positive value for success.

So this is an internal api issue and not a general issue?  Unwinding the
read callbacks here is hard.

Also, in looking at the code, how can this ever be a short read?  You
are using memory_read_from_buffer() which unless the values passed into
it are incorrect, will always return the expected read amount.

> > And what will userspace do with this error message in the kernel log?
> 
> User space currently is not seeing this error for nvmem device/eeprom
> reads due to the following code at nvmem/core.c in
> bin_attr_nvmem_read():
> "
>     rc = nvmem_reg_read(nvmem, pos, buf, count);
> 
>     if (rc)
>         return rc;
> 
>     return count;
> "
> since it expects to return the number of bytes.
> 
> Userspace will see a false error with nvmem cell reads from
> nvmem_cell_attr_read() in current code, which should be fixed on
> returning 0 for success.

So maybe fix this all up to allow the read to return the actual amount
read?  That feels more "correct" to me.

thanks,

greg k-h

