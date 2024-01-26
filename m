Return-Path: <linux-kernel+bounces-39539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FF83D285
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21081C248A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7238C17;
	Fri, 26 Jan 2024 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N29fNl8B"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC888831
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235869; cv=none; b=AlZD7CtAyq7dSJ1nh9im2dXWWAWhHqSLLzCylbpeMJJC8Ryv1GoMkrWcuu/OzyIbUQ65QZVL5+qTuwELgpf0jy+M5KKMbv5rVXcuWvjeJXGd5Wqzg/fwpTe1frqJNkn31yWoRL5YO9LrMA6l2Go4HkhG5yQjyzLDWyuWVpOKVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235869; c=relaxed/simple;
	bh=U+sljIPjwTGEa/e8pcd5Zj0VJm9xVGm61FMKNNTG6JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbjcA/lbbwjkQVYtXs1vEZsUqD7AjhQdqRvVKFS2drKCzTzewirfEvoZWMgMjNyQJC1WUCFFlRCF6gI7OfvzsgJPpsYA+cwq4Eu36ihQ2wy8Z9rW4RY3Xs27X85mj7IXzXX/nEOWyASv9qgLVRgoGs2/hmhVQ7KA8EvjTo9iuhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N29fNl8B; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a7765511bso58731cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706235866; x=1706840666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcanplUuigeG7+SyQESZ+PLtXFKVvk0gBTooHhSHHRc=;
        b=N29fNl8BZqCUddj3zBlELxpAoJFEg03dbCfE3dvDVtnH6uA8f+/u+rqcFG9GUorT4k
         DgE+2m3+NlK2dspPX/nKvtxMxi/JEbOLnL+J1RYMHdBZppoyRes3Y3OD05lin9+IQQhZ
         KWTaclHrIUEjDYCqC8CbTwZWhmUyPSTTTD3xJxxeBPTgmDIRtdFEpbxeq1kDLi6GtPYi
         OT9W4HugRWExZipyz+JE5Qfy5JjgPXCgZgWjjpaA6gRa4+su02Aph9zDP5QzEW/m8Ulv
         hvvGKRV71aAqECSBU6n0UEMl/HMXxjoQmrGXrJfMlUV70utelXZnJGjZRIu+rIkjatTX
         ZZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706235866; x=1706840666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcanplUuigeG7+SyQESZ+PLtXFKVvk0gBTooHhSHHRc=;
        b=DfnHlPZl5OzeYU7fCgfZtbIjCh7ynADslBEOl3/HKsR5s8P8MAyVqcmix8yb0altQa
         g/uxAL4kx9eLy1tq7VjNn+hlI2yewoqICsUWgvmmTnnn9aiM5EKbBIqcuomFte8XBTyc
         /tL498w3iBHnMqBDxd+cDrRA8eURcYPHxbVkzZu6hqSvOFMHnYsc5BV0iNJb25p2L+Cz
         Tvff6P26I33A4SPM1cR5YKGvPyx1iuUMYtd8UbiIDWs4NHC+VO3/W8iWY6V0ysHv+9db
         wrFIHxIbfGECymzKqgHr7QYOgV+4dBCi6hVyBSp9wq3A4C47ew6kqP2uaCEb0Ap33maV
         Fcpw==
X-Gm-Message-State: AOJu0YzbX7m8sqnp5KFOHpPKYOgSjnWCbj6XW0dbf61qVPznme9kwk1M
	SG3lWmbBsKpqGI4K1JAXAHXEN94CQls0wa+GAPZJOtk92Kmkgkh+asKSia/KLHeamMMsSHyxo1D
	r535IVz8tYCGMMXjfUYooqef9dinxF1h+/sR3
X-Google-Smtp-Source: AGHT+IF/ZjCQprLAq5jGDSptgQBwNVbqFRuAhJO2rELD+78XU9TW9TFfow5bmp/ztezQ0ineqG3PU4a9MUvsr92ka1g=
X-Received: by 2002:a05:622a:1c0d:b0:42a:1b6f:ec97 with SMTP id
 bq13-20020a05622a1c0d00b0042a1b6fec97mr128440qtb.26.1706235866248; Thu, 25
 Jan 2024 18:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-4-peter.griffin@linaro.org> <da30a68a-e29f-45c8-aa73-02955255a457@linaro.org>
 <CADrjBPor5tMY4r0jOy7GH36auCU7dWn6Qn4ct89bsSMW4vAQOA@mail.gmail.com>
 <6c72a521-1048-42eb-ac74-d8f718a90723@linaro.org> <CAGETcx-CCpaV7R0O0HpDpoX6KxQBuJiMmKdWA8nDE-5Qj2Sa7g@mail.gmail.com>
 <f4d3aa5a-e01d-4ef3-8004-b6eac4461184@linaro.org> <CAGETcx_HGcuGQTO11tzX0EvnuLEaKYc4vBse1CRP0JwPqMJdQQ@mail.gmail.com>
 <04411aaf-6f2c-4f43-83b4-aa0741ccd25f@linaro.org> <20240125114606.GA1327902@google.com>
In-Reply-To: <20240125114606.GA1327902@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 25 Jan 2024 18:23:47 -0800
Message-ID: <CAGETcx8r_+_B0S3VJ6_66+dgAOusN_pt_=pmgoa-r8TUY7quPA@mail.gmail.com>
Subject: Re: [PATCH 3/9] watchdog: s3c2410_wdt: update to use new
 exynos_pmu_*() apis
To: Lee Jones <lee@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net, wim@linux-watchdog.org, 
	conor+dt@kernel.org, alim.akhtar@samsung.com, jaewon02.kim@samsung.com, 
	chanho61.park@samsung.com, semen.protsenko@linaro.org, 
	kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	willmcvicker@google.com, linux-fsd@tesla.com, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:46=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 25 Jan 2024, Krzysztof Kozlowski wrote:
>
> > On 24/01/2024 22:27, Saravana Kannan wrote:
> > > On Tue, Jan 23, 2024 at 10:27=E2=80=AFPM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 24/01/2024 04:37, Saravana Kannan wrote:
> > >>> On Tue, Jan 23, 2024 at 10:12=E2=80=AFAM Krzysztof Kozlowski
> > >>> <krzysztof.kozlowski@linaro.org> wrote:
> > >>>>
> > >>>> On 23/01/2024 18:30, Peter Griffin wrote:
> > >>>>>>>               dev_warn(wdt->dev, "Couldn't get RST_STAT registe=
r\n");
> > >>>>>>>       else if (rst_stat & BIT(wdt->drv_data->rst_stat_bit))
> > >>>>>>> @@ -698,14 +699,6 @@ static int s3c2410wdt_probe(struct platfor=
m_device *pdev)
> > >>>>>>>       if (ret)
> > >>>>>>>               return ret;
> > >>>>>>>
> > >>>>>>> -     if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> > >>>>>>> -             wdt->pmureg =3D syscon_regmap_lookup_by_phandle(d=
ev->of_node,
> > >>>>>>> -                                             "samsung,syscon-p=
handle");
> > >>>>>>> -             if (IS_ERR(wdt->pmureg))
> > >>>>>>> -                     return dev_err_probe(dev, PTR_ERR(wdt->pm=
ureg),
> > >>>>>>> -                                          "syscon regmap looku=
p failed.\n");
> > >>>>>>
> > >>>>>>
> > >>>>>> Continuing topic from the binding: I don't see how you handle pr=
obe
> > >>>>>> deferral, suspend ordering.
> > >>>>>
> > >>>>> The current implementation is simply relying on exynos-pmu being
> > >>>>> postcore_initcall level.
> > >>>>>
> > >>>>> I was just looking around for any existing Linux APIs that could =
be a
> > >>>>> more robust solution. It looks like
> > >>>>>
> > >>>>> of_parse_phandle()
> > >>>>> and
> > >>>>> of_find_device_by_node();
> > >>>>>
> > >>>>> Are often used to solve this type of probe deferral issue between
> > >>>>> devices. Is that what you would recommend using? Or is there some=
thing
> > >>>>> even better?
> > >>>>
> > >>>> I think you should keep the phandle and then set device link based=
 on
> > >>>> of_find_device_by_node(). This would actually improve the code, be=
cause
> > >>>> syscon_regmap_lookup_by_phandle() does not create device links.
> > >>>
> > >>> I kinda agree with this. Just because we no longer use a syscon API=
 to
> > >>> find the PMU register address doesn't mean the WDT doesn't depend o=
n
> > >>> the PMU.
> > >>>
> > >>> However, I think we should move to a generic "syscon" property. The=
n I
> > >>> can add support for "syscon" property to fw_devlink and then things
> > >>> will just work in terms of probe ordering, suspend/resume and also
> > >>> showing the dependency in DT even if you don't use the syscon APIs.
> > >>>
> > >>> Side note 1:
> > >>>
> > >>> I think we really should officially document a generic syscon DT
> > >>> property similar to how we have a generic "clocks" or "dmas" proper=
ty.
> > >>> Then we can have a syscon_get_regmap() that's like so:
> > >>>
> > >>> struct regmap *syscon_get_regmap(struct device *dev)
> > >>> {
> > >>>         return syscon_regmap_lookup_by_phandle(dev->of_node, "sysco=
n");
> > >>> }
> > >>>
> > >>> Instead of every device defining its own bespoke DT property to do =
the
> > >>> exact same thing. I did a quick "back of the envelope" grep on this
> > >>> and I get about 143 unique properties just to get the syscon regmap=
.
> > >>> $ git grep -A1 syscon_regmap_lookup_by_phandle | grep '"' | sed -e
> > >>> 's/^[^"]*//' -e 's/"[^"]*$/"/' | sort | uniq | wc -l
> > >>> 143
> > >>
> > >> Sorry, generic "syscon" property won't fly with DT maintainers, beca=
use
> > >> there is no such thing as syscon in any of hardware.
> > >
> > > Then why do we allow a "syscon" compatible string and nodes? If the
> >
> > To bind Linux drivers.
> >
> > > "syscon" property isn't clear enough, we can make it something like
> > > gpios and have it be <whatever>-syscon or have syscon-names property
> > > if you want to give it a name.
> >
> > This could work.
>
> I'm not opposed to this idea.  The issue you'll have is keeping the
> kernel backwards compatible with older DTBs, thus this solution may only
> be possible for newly created bindings.  More than happy to be proven
> wrong here though.

You are right about backwards compatibility. Technically, we might be
able to fix up the DT at runtime (by keeping a list of those 143
property names) to maintain backward compatibility, but I'm not
suggesting that.

We can leave the existing ones as is, but we can at least use the new
property going forward to make dependencies easier to track and handle

-Saravana

>
> > >>> How are we making sure that it's the exynos-pmu driver that ends up
> > >>> probing the PMU and not the generic syscon driver? Both of these ar=
e
> > >>> platform drivers. And the exynos PMU device lists both the exynos
> > >>> compatible string and the syscon property. Is it purely a link orde=
r
> > >>> coincidence?
> > >>
> > >> initcall ordering
> > >
> > > Both these drivers usr postcore_initcall(). So it's purely because
> > > soc/ is listed earlier in drivers/Makefile than mfd/. And as soon as
> >
> > Oh... great :/.
>
> Agree.
>
> Even using initcalls for ordering is fragile.  Relying on the
> lexicographical order of a directory / filename structure is akin to
> rolling a dice.  It would be far nicer if you are able to find a more
> robust method of ensuring load order e.g. dynamically poking at
> hardware and / or utilising -EPROBE_DEFER.

Let me dig in to see if all the existing examples of listing syscon in
compatible AND have a different driver that needs to probe it always
list syscon as a secondary compatible string. In that case, we might
be able to make the syscon driver only match with the device it it's
the first entry in the compatible string.

-Saravana

