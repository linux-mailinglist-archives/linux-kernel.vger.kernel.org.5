Return-Path: <linux-kernel+bounces-47394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59F844D5F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821C41F242E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE7A3A8F6;
	Wed, 31 Jan 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq9J7l2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925603A8C6;
	Wed, 31 Jan 2024 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745110; cv=none; b=kwiVYVhF2AqxUEnM8Ccyt4UglsYAmHm03/qpRs5TpeYG86FMA3pT7VI6JE/5SJFs+UyjJ/rEZqnGTFoKRFx+4rlwIb4m5uHMJnEFhgHkKSJMAXwG5+RVWUPZKSPX7RSylTkiPBiwaRR5WEHWs7oE0rrqVE6Bw5fSipfIScZR++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745110; c=relaxed/simple;
	bh=bEXE9iCcPsAyP4fz4RssHiTnyheZ4ZI2rqh4iftmVgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovAWbCuueG8aAuR61x9ugybxoA27x+Fw2ykkMKGJJbG2hudnRKGuYH6ur77lpKgNS5JyOqf2rHVijseJDZ6jXlcusJbnFZ1ZzNNlFWz/2lceYa3lF2VeEuUG8uv4x6UAkD+x3L3ofXPVNVcQ075c7EUJFjZKk5FJTnL0MgPAbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq9J7l2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2106EC433F1;
	Wed, 31 Jan 2024 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706745110;
	bh=bEXE9iCcPsAyP4fz4RssHiTnyheZ4ZI2rqh4iftmVgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pq9J7l2Ra6F4wkK6mHCN6mfAMSgCZKw1SvtPrQcPGZ7SY/FSOB/hGJwO2nlrlYJUI
	 zLZwlTLPSpxXPIOa+IBhSgxW+W1pTISGjrlRZLxqTUsO+6+C7zLLtbY90mMJisimS3
	 kWckl4YNWUBlbLqOCrWRSg+7/8R6+lefyXNREAdEubVoFsDR1OYgAvnOcAJLio3d8D
	 2wpPwC4CevJnMJVYwlTBahP9AN0TLV4ood4N6XgdrulDEBooz1uTBNivsWoKhNC1/h
	 fBZlkoT5NkvQyvvrxx6ZnJ35rtdMXxpfdS3KUyVQ2CljN1JlkKuXdEiFAXCi8jYm2B
	 CgK5OiSe0kzBw==
Date: Wed, 31 Jan 2024 17:51:48 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 2/5] of: Introduce for_each_child_of_node_scoped() to
 automate of_node_put() handling
Message-ID: <20240131235148.GA2743404-robh@kernel.org>
References: <20240128160542.178315-1-jic23@kernel.org>
 <20240128160542.178315-3-jic23@kernel.org>
 <CAMknhBEL3cv4L0A-W=_1EcDmD3Cj8apheDcpnqjyJjKBZuPYew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBEL3cv4L0A-W=_1EcDmD3Cj8apheDcpnqjyJjKBZuPYew@mail.gmail.com>

On Sun, Jan 28, 2024 at 03:11:01PM -0600, David Lechner wrote:
> On Sun, Jan 28, 2024 at 10:06 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > To avoid issues with out of order cleanup, or ambiguity about when the
> > auto freed data is first instantiated, do it within the for loop definition.
> >
> > The disadvantage is that the struct device_node *child variable creation
> > is not immediately obvious where this is used.
> > However, in many cases, if there is another definition of
> > struct device_node *child; the compiler / static analysers will notify us
> > that it is unused, or uninitialized.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/linux/of.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 50e882ee91da..f822226eac6d 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -1434,6 +1434,12 @@ static inline int of_property_read_s32(const struct device_node *np,
> >         for (child = of_get_next_available_child(parent, NULL); child != NULL; \
> >              child = of_get_next_available_child(parent, child))
> >
> > +#define for_each_child_of_node_scoped(parent, child) \
> > +       for (struct device_node *child __free(device_node) =            \
> > +            of_get_next_child(parent, NULL);                           \
> > +            child != NULL;                                             \
> > +            child = of_get_next_available_child(parent, child))
> 
> Doesn't this need to match the initializer (of_get_next_child)?
> Otherwise it seems like the first node could be a disabled node but no
> other disabled nodes would be included in the iteration.
> 
> It seems like we would want two macros, one for each variation,
> analogous to for_each_child_of_node() and
> for_each_available_child_of_node().

Yes, but really I'd like these the other way around. 'available' should 
be the default as disabled should really be the same as a node not 
present except for a few cases where it is not.

I bring it up only because if we're changing things then it is a 
convenient time to change this. That's really a side issue to sorting 
out how this new way should work.

Rob

