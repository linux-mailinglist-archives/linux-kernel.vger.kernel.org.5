Return-Path: <linux-kernel+bounces-42266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED2083FEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EE11C2364C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281084EB4B;
	Mon, 29 Jan 2024 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="QQF2gEPW"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA54E1CF;
	Mon, 29 Jan 2024 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511311; cv=none; b=CYhXelpA502bBJrTm4Lrs/cnLQISd8kHNfkq1pp4mCwET4OnDutDKjWrTghtmMzUcpmzCH7t9MuE3BagQho9kBgE3Wo1DHUWAKZGjVZDuRWI85MWnWGUoFWyFJh73NcStooEMW7clKeMWg3K9v36VWrMriAbJNVXbvCDvXvPBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511311; c=relaxed/simple;
	bh=QxPFzwiC832gHBvsrc8uTvj7SV6ybIfVQEvlV8pe4K0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hHO/E1yCf14+o+epXfmh5/12jqe+TltuEFoDirbtsySFejSwANhz66blAd23dPzwqtFplWx8K9JFGICp4atQNALzjqenDJ7CfRk53emSQUdLhZEkbd2EfwSB8pWPfnKWzzMxcll+SQENU4jKaW0Kpda3mV9eKKnkfvkV67VaBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=QQF2gEPW; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/vK4mdK7puxw3rS5CIKuzcUkW3pOhOeAoQxmK8/bCoo=;
  b=QQF2gEPWROMVJ3W0BFwbJvQi+G8tacNtEPzvU2ZDvfyD5BCEo5deJrHE
   Rxv6Z3pwCwzwPiOAY6zNAOHHvpqwbitiWYZb/q+adZDQ4aDY+0FdFadWf
   LlsZzAgbhBU9gQbKdDz6In89cW+RXFIhQPNW+Z/SmhbxHqeaBJ+UjWoYo
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,226,1701126000"; 
   d="scan'208";a="149064864"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 07:54:58 +0100
Date: Mon, 29 Jan 2024 07:54:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: David Lechner <dlechner@baylibre.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
    Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
    linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Sumera Priyadarsini <sylphrenadin@gmail.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    =?ISO-8859-15?Q?Nuno_S=E1?= <nuno.sa@analog.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 2/5] of: Introduce for_each_child_of_node_scoped()
 to automate of_node_put() handling
In-Reply-To: <CAMknhBEL3cv4L0A-W=_1EcDmD3Cj8apheDcpnqjyJjKBZuPYew@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2401290754250.3150@hadrien>
References: <20240128160542.178315-1-jic23@kernel.org> <20240128160542.178315-3-jic23@kernel.org> <CAMknhBEL3cv4L0A-W=_1EcDmD3Cj8apheDcpnqjyJjKBZuPYew@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1061988734-1706511298=:3150"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1061988734-1706511298=:3150
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 28 Jan 2024, David Lechner wrote:

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

There are a bunch of iterators, and I guess a scoped version is needed for
each of them?

julia


>
>
> > +
> >  #define for_each_of_cpu_node(cpu) \
> >         for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
> >              cpu = of_get_next_cpu_node(cpu))
> > --
> > 2.43.0
> >
> >
>
--8323329-1061988734-1706511298=:3150--

