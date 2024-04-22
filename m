Return-Path: <linux-kernel+bounces-153222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CDA8ACB0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0F11C20C06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3A145B20;
	Mon, 22 Apr 2024 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="akLMyIq0"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E671465B5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782367; cv=none; b=Wlvk94wOVX0n81ql/VA/sOnq+u3slBSJohoJFliJlETB080r1moYpK1lt+Wsqg4iUX3jGVJZUlQ200qDV48i5L6MGA5Ix6X9Iige3saa2THwSCAcYlFpmI5bVk9LPmWCiugSysfN+WlSy/OJWmLCvHgcqtA/eP3E3x6YizPoAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782367; c=relaxed/simple;
	bh=tw/ruLJw2IldqcRfR0Fp7vfH4KWxGbJZHGJPXcevGa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbUHaATjMD7sSwgYlkXhzlrojGjzYqB6/ygY2qLiaBLsWUyf6z2fZMzLPJJJhsQLggXde3Bz1rF/MmcvUr3BKFpAFfG2qHMVMXEaGtnsYTjdyRdaBRpAJMyZ2uiKXgXAJgeQJr2SesbGSf5VaJBwMGHGqzDAaBIRQqXJEnrC6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=akLMyIq0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a58209b159so2647986a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1713782365; x=1714387165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tw/ruLJw2IldqcRfR0Fp7vfH4KWxGbJZHGJPXcevGa8=;
        b=akLMyIq0VrmEX1uWnZRFeRCkeK6CxK4TRVjz7Od1V/J+5R/A+t/skq82/ftTR8wZvJ
         3zN70hoZS4wehVpcCYc0HMG5e3aM8qzsIi8SW8MgmpJTB9jDBqwk0DgcyKCu8ccbiUw/
         Povf/u3YFUQ9qsQLU3+F5unFahS3i1DjCuudQTYcmYgVJrwCkkiwr0gAh583OnfYT/rC
         /1SXO91pbY2K1uRdXtyWMGru2PPc+bYY8bANYm2RO8vfvLb2Wk024raVKVKuBWJYg1Q6
         Y/oLLlyM8i/tdXEFDQmJyabeFWZHagYuK7sTiVs0egOzY3iDvCA5rKi1rOTtN+o2f6mE
         27IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782365; x=1714387165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tw/ruLJw2IldqcRfR0Fp7vfH4KWxGbJZHGJPXcevGa8=;
        b=BAtPDX7zII8cU996jDsl6rq9YxWnokt3D9T1jRh+dogAiVkP5L4TgEaGrfW2SSV+C/
         qUHT9Tc1jDMjPjWNFDHkx9U2QuzUve5/3OLDd0S7qxuqeo4Dj5bU8iWyto1wF+CSxHIA
         Suv2HFtWCdtMvsRzNZiCkJMKCdFhBThb/Ye2XgA1HVMeRpwJ78inwejymKeKXvR9jhkg
         mO+9E4CPZuosWx1Nz6F04swO6TF57GwTqfC/Q1E8BD3kk5nXRBZFpaL8LToZk1qxIRTx
         D8AWXhAGG2z+J2Fn0Khc4c+iMGWpfBpIRJvIwwoVgrueiU/g9HkucJg2eDOh2NhB7PSa
         2DAg==
X-Forwarded-Encrypted: i=1; AJvYcCUv6Q5ZRj7rt5370l9bh75ypMXFM3gBrrqyWsR4BEz786gNoDusqB89SGuA94ZrPqE7ws/A786GyFgRONl7bJdOmqVxuYibHAJf5uIz
X-Gm-Message-State: AOJu0Yzp/9fngoDH5v5A9VDQMxCRAj6LZq7b5mCWdvQX5L9GQqiuWQ5M
	N7XvbioPv3e8HworXpz37204jlGhon4nHbgnBcmIXKsQkOAGVpkcsv1q+w71QWrFO6KDa0AGQ4j
	F1C3ZsEUuMFJN9o5ZjcgyOtFVeIixHs68IrfRFA==
X-Google-Smtp-Source: AGHT+IEY8we/dWrYRB/yxAUGuYNMNlMwrdJ2+M3MXEXX0Tp8j2MD0fZjxDax1iTRPLWYc2bGHOUcREPQl1a/jn+isOA=
X-Received: by 2002:a17:90a:4294:b0:2a0:3dc3:8a8b with SMTP id
 p20-20020a17090a429400b002a03dc38a8bmr6662584pjg.47.1713782365451; Mon, 22
 Apr 2024 03:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <20240416171720.2875916-2-naresh.solanki@9elements.com> <ecddd7f3-fc25-4021-9758-b00893ac9622@roeck-us.net>
In-Reply-To: <ecddd7f3-fc25-4021-9758-b00893ac9622@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Mon, 22 Apr 2024 16:09:14 +0530
Message-ID: <CABqG17hebvkpvxwGVfp0nT_YMrvgdkEqU2_XjijCpdtgU6C+1A@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: (max6639) : Utilise pwm subsystem
To: Guenter Roeck <linux@roeck-us.net>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de, 
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Wed, 17 Apr 2024 at 02:52, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Apr 16, 2024 at 10:47:15PM +0530, Naresh Solanki wrote:
> > Utilise pwm subsystem for fan pwm handling
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>
> That adds a lot of complexity to the driver. I am missing the benefits.
> You are supposed to explain why you are making changes, not just that
> you are making them.
>
> Why are you making those changes ?
Sure.
This is to align with fan-common.yml wherein chip pwm is exposed.
I'll update commit message

Regards,
Naresh
>
> Guenter

