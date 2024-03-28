Return-Path: <linux-kernel+bounces-122920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1045788FF70
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F06EB2288B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F77F481;
	Thu, 28 Mar 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ivTCTV7A"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8218F72;
	Thu, 28 Mar 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629972; cv=none; b=DneqABk29v6p+P4pX09QjmS2LCM1HWv3SwiHurA/DA1zcpo9eBWlgSxAJKZnfKQbdQwzdlu27/HEYFaHW9PtGMHyoPwC7QhphiKTxv9KOeAzGxi+feEBoWmKIjbFoyjPj9DaKKacJUxGLpOEoCwaKpFd1l//kSPdMVQQKgNgn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629972; c=relaxed/simple;
	bh=TtrpAhm4EK3hOjyDiXwFao0QdbP4kQ+GxV+DiirB8oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjCVsfarjAXootVRN/pLu/qOdSEgFBx3RGCuU0r8Lg1OMLLXI6/vWZ6iJulpv336bdSrane7ZZ1WmqL05n6ZpSkeNvghso18EjWjKuk71xqrufW9FzbN21nlUyHro1NI6qFI7+Rv21w93Sc1rfW4lUOfbaP+GPi1DgR0IBKCKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ivTCTV7A; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e220e40998so2417075ad.1;
        Thu, 28 Mar 2024 05:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629970; x=1712234770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LTDetgMoFDMdYo+/f65ROtS8ZVAqCz6mWkWnRKEGLi8=;
        b=aMxb5OzLeIPch0h3pkF6MxEbvoiIuTn8v3ddVcTynK8Qrlq7hvMrNJ3Lwixx9FRb19
         aVj3qgd923le+rsJXC0SZ/BHggbGshsx6/APLFvJoHaOT0jDFlGMcoRrUejAZ4Ezx8iO
         o3OKO76vrWVElHjSM4g8Sw/zkTkHxGAELsmHVanwm9060kI5LKVXFxDSsAAnN72VBuP8
         rEJke+qWy7e/Y+mZz26JA5TAgjs9561Zneb5QtnpLF//J+06Ehuwt01PN6r9V0jaosi+
         Vdqw5PTgpjC7hNflL/4JC3NkbwVOhGaqwo9lEE1rL5spU9k+NnRaPou3F61+9VNqhCsO
         +AWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTghmf+eZzzx3RuTSwYw/2TeVKQYCGu8rNsH0S3kvxIMs238f+l7HXOJa/qdb3kdm4xTY1KPSP9PIAtA6Vz6TeVFlRfe7sJpLvdRkflPe5Gk5jdvIvZRjQtDf4f3IQqMZfKNWnSVWyrGk=
X-Gm-Message-State: AOJu0YzD5Pb3X5QSJBgL80ukgoc0rTqs8oXvNz3q01IA9VSzEBybQ22w
	SLkSembeVL+6u3gziC6k/GLkpH8DjwSH0ptdZoCMsQoO8rBnBP0e
X-Google-Smtp-Source: AGHT+IEEhmPxP0HLaBLqoNVpjIItHLRwRW0RnaGcx72NO0s4/vfI8hmTcXHS732a2Z5eZabhK81l6A==
X-Received: by 2002:a17:902:f54e:b0:1e0:cdcc:340b with SMTP id h14-20020a170902f54e00b001e0cdcc340bmr3110653plf.19.1711629969598;
        Thu, 28 Mar 2024 05:46:09 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kh6-20020a170903064600b001e0e89f9bfesm1464997plb.264.2024.03.28.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:46:09 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:46:01 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1711629967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTDetgMoFDMdYo+/f65ROtS8ZVAqCz6mWkWnRKEGLi8=;
	b=ivTCTV7AqA7bEn0lb8P7YlmNMXNPblFn4MUZXCiCZDjUqRXJEU/AKXUMyR4ebB/c7otVus
	m0OhwAu4jIn+nEJRiOv7OgPvLlekcxDN08Fpc1BB2yzz986HdenVZRGp23ZWWrJwTDBDvm
	obEYB0bi1nE2b76rMlnpm7hpgDAQodmA4RAOAmllFemgoI7RWlEVB9TN1rIK7HmU+Q3pH/
	5u29veDfxRN4lvgtmK+4t/FUf296VhcF+udQ7CpD5w19Zcj8wwesHBH1LMyk4rmezetEro
	s8Qq7/PCmt9j/Tmbi2YlB0SComl15y1qFCubJa5fytPEbnvBQBanvuYovsNZXQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] video: backlight: constify struct class usage
Message-ID: <anuaxqt2zlravjpepkuhqmii3adjdeh3lzal3wwb7rg7krv6uu@7sbwczq3flot>
References: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
 <20240328114131.GB13211@google.com>
 <2024032816-tightrope-lushness-00f1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032816-tightrope-lushness-00f1@gregkh>

On 28 Mar 13:01, Greg Kroah-Hartman wrote:
> On Thu, Mar 28, 2024 at 11:41:31AM +0000, Lee Jones wrote:
> > On Tue, 05 Mar 2024, Ricardo B. Marliere wrote:
> > 
> > > This is a simple and straight forward cleanup series that aims to make the
> > > class structures in backlight constant. This has been possible since 2023
> > > [1].
> > > 
> > > [1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/
> > > 
> > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > > ---
> > > Ricardo B. Marliere (2):
> > >       video: backlight: make backlight_class constant
> > >       video: backlight: lcd: make lcd_class constant
> > > 
> > >  drivers/video/backlight/backlight.c | 29 ++++++++++++++++-------------
> > >  drivers/video/backlight/lcd.c       | 23 +++++++++++++----------
> > >  2 files changed, 29 insertions(+), 23 deletions(-)
> > 
> > No longer apply.
> > 
> > Please rebase on top of v6.9-rc1 or for-backlight-next.
> 
> As I already had this in my local tree, I've sent out a v2 at:
> 	https://lore.kernel.org/lkml/2024032805-putdown-mushy-a0f9@gregkh/

Thank you Greg. I will see what is left to be made const for -next.

> 
> thanks,
> 
> greg k-h

