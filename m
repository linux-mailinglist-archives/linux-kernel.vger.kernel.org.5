Return-Path: <linux-kernel+bounces-63077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33224852A93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EBB1F229C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19630179AE;
	Tue, 13 Feb 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4jFAK8l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81A134CD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811855; cv=none; b=pO1Y16vR0A98YepEP4kUmtWwrZpyT7TOYfRh24jLZmXtY3+prLiikgoxN+By4Likdl01NGmDB0yBx4LXL/LLdGAj0BKi1cK7z35LdVj4tA+TsThqZZteacPORFDcjebCxw93q8xbNTk96XXb+mr54Ieurtnr4JXRt6TNE66pifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811855; c=relaxed/simple;
	bh=5U247CdSLwfn8h6iw5PSRxaDI5O8KRpil4aQpkGAu3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t+O3UFVh5DI+7YwpM3pM4z3MoKXzbSIytDvHcJcT5meNOsT5zy40acMl6Zfgo6Widl/+KKC6SSt+l9rfJ+H3R1VXNetsFzqQlMAJTHJhcUvjhrD1d7WTV/5yX8OoWfo/mARwzo1pHSwohMST1mpRZYh4qTWZjpgmsVBFHgGIX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4jFAK8l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707811852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SPesKyrldOWhdNiuSwsZ76DEnwm8BRWGN2yy5GtATUo=;
	b=b4jFAK8lWKNs9yD6Op4n0//OFkQUtBx+gVWgwoLAnEtVyOnTiXq6x2guhkxVzL9rdwUtWG
	dFZbKuPVQdslkhuYvDJ1U6gI3unRf5iJ6r6mR9Zld7HLFZZilBRiOooRKB1aHEikeTwAlv
	3tYbLfcN8zN9Qf+oERIjh7vYxNTn2gc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-Pz7GkEwNMJGIr3feCi8myQ-1; Tue, 13 Feb 2024 03:10:50 -0500
X-MC-Unique: Pz7GkEwNMJGIr3feCi8myQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4102b934ba0so23669595e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707811849; x=1708416649;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPesKyrldOWhdNiuSwsZ76DEnwm8BRWGN2yy5GtATUo=;
        b=XdGjLHA+9oYITF7NVcZ8vO/N+DfvlAQsfNYj7B8oRaS/2bHRu/0ZqDTFT+B7KwFABw
         74i/07oVdq9VhVdYSvN8eto0Q0+awiuoB/h1Du+DafEwHEnpx0xZYsdFrXj266ODrZDc
         ZQXIOlCktvI4UNm1s5gRjtqhvGRXSZENbBCadqOWyVwA5fhICkG9PfVvvIXUgj1Cpg/P
         Hc0Jrepd1sxO+nvyD8dJJKNJ6z8IS8dTjN2kfZB2aTFYE8aaWUllA3jHISkCIOORpi5E
         ecLuqrwMk5YGFWaGZQIma6CET4QegoTW8EBaxsQhG9eZtAP2KLIPQCmRK4Ll9I5OMV3I
         F2cA==
X-Gm-Message-State: AOJu0YzV8KZV/sKsBBx0Y7Vz28cmu7V7ptIUZEaySvS/esE4vcTd/Xg0
	1Q4QpVJ6rTOUSSQGs893BpoPRKnUPwnU/LKP+mwiDsNC3WY1pI5IHyvT9V2nVIgyZhaWOPbRqGG
	nA84X7AHc0dzJZ8oNNuGHSs++VTLTVwD6I/4zAV7R+G7wgVooHqkVpdTAUiySKO3N/cIN6g==
X-Received: by 2002:a05:600c:468e:b0:40f:dd18:a152 with SMTP id p14-20020a05600c468e00b0040fdd18a152mr7475251wmo.41.1707811849446;
        Tue, 13 Feb 2024 00:10:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV96DWjMl95of2ukgvtYKhM0qDXhLwfUn88ToEVnVDvTKPLeE/Nxs+RUsjRJu78/3AcewyCw==
X-Received: by 2002:a05:600c:468e:b0:40f:dd18:a152 with SMTP id p14-20020a05600c468e00b0040fdd18a152mr7475231wmo.41.1707811849088;
        Tue, 13 Feb 2024 00:10:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4S+D3spM1KQRgaOa+mJylI16P/gbD5RTAmSjKSqfW0H4+pjVO08RUufyIg799WffCScXZdNSlId2CeYTkvNrZ6umzwYIssrh+ZLpoz3BZz3Mr0V0I09tn9g981dL5aIlBPkTiot7ghdNSDw==
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b004107219c664sm11010168wmq.32.2024.02.13.00.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:10:48 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
In-Reply-To: <ZcpKwz8J8OoODMYl@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
 <9c7df0e5-31a9-4c86-b996-4cba82c4ea2f@suse.de>
 <ZcpKh_EgNM5IaV-P@smile.fi.intel.com>
 <ZcpKwz8J8OoODMYl@smile.fi.intel.com>
Date: Tue, 13 Feb 2024 09:10:48 +0100
Message-ID: <87sf1wkcmv.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

Hello Andy,

> On Mon, Feb 12, 2024 at 06:42:48PM +0200, Andy Shevchenko wrote:
>> On Mon, Feb 12, 2024 at 05:33:39PM +0100, Thomas Zimmermann wrote:
>> > Am 12.02.24 um 14:23 schrieb Andy Shevchenko:
>> > > I have no time for this, but since it looks like I'm the main
>> > > contributor for the last few years to the subsystem, I'll take
>> > > it for now. Geert agreed to help me with as a designated reviwer.
>> > > Let's see how it will go...

AFAICT Miguel Ojeda is quite responsive and is still doing reviews/acks
for auxdisplay patches. Can you elaborate why the maintainership change
has to be made?

You can still be listed as co-maintainer of course, and maybe Miguel is
on board to drop this but then I think that should be mentioned in your
commit message (and have an ack from him).

>> > 
>> > A few days ago, I talked to Javier about how auxdisplay is a hotchpodge of
>> > various drivers that seem to belong into other subsystems. Could we attempt
>> > to move all drivers into other places and then remove the auxdisplay
>> > subsystem?
>> 
>> Can you be more precise on how it can be done? We have at least two clusters of
>> the displays: line-display and HD44780-based ones. Moreover, the latter might
>> use the former in the future (in some cases).
>

For line-display and 7-segment display I'm less sure, and it may be that
we do need a specific subsystem for those. But then maybe it has to be
renamed to text-based or character based displays instead ?

I wonder though if these can be modeled as an output only tty instead.

There are though more than these two types of display, for example the
cfag12864bfb driver is a FB_VISUAL_MONO10 fbdev driver:

https://elixir.bootlin.com/linux/latest/source/drivers/auxdisplay/cfag12864bfb.c

Now that we have better support in DRM/KMS for monochrome displays, it
seems to me that could be even ported and be a modesetting driver. I've
mentioned this to a colleague who wants to get start with Linux graphics
as a good learning exercise.

I believe the problem is that auxdisplay is too vague of a term, so anything
could be an "auxdisplay". Even tiny I2C/SPI panels could be defined as that.

> Btw, I have no time for major things here, if you wish, please take over,
> I will be happy to get rid of this.
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


