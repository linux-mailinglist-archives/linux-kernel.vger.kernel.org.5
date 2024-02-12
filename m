Return-Path: <linux-kernel+bounces-61262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDC1851012
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C263B20E58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8143417C6B;
	Mon, 12 Feb 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdQmsBfh"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B117C60;
	Mon, 12 Feb 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731670; cv=none; b=lssWrdddfk77LSMZR9ETtpkMCncn/n292+y5S24UypnKcL/CHuyKR6KlbW2o7veMFRE1u2GFs6fN57Bzv1ZWzvWtrPHaYJj+YoYx/GytHFoVZw6bWFcmU3A2JQ5MLkOPp2F+BXzcPISAB97e2Wj82n7p9zGRWz8VPYYmMmcZn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731670; c=relaxed/simple;
	bh=TMIQDKpWunM+UrneNS0NgY3ocyzjZza2ecHhJJ88y1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPNnlY9wynWnct8iTObIyjmCe5VwytOrnBGXAj0uzVOuBkuVM3ei2EEIwzR3qLqY0k+HKqqwQkCzqNMmGopVSeYU18Sx0YdCK7wZWe+SyZNKZoIKa9rpzltJ9IQyLEyn0Nfi7attU9i5oSRuEuQZISE3piXdTK3DLnj6Gy3bIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdQmsBfh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3850ce741bso284249066b.3;
        Mon, 12 Feb 2024 01:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707731667; x=1708336467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMIQDKpWunM+UrneNS0NgY3ocyzjZza2ecHhJJ88y1k=;
        b=MdQmsBfhgbYHH6hymmhEszVWOymUHbrr0TrZag+RqIp7O+VFHusX7oOYBr8a9zKDaS
         mPwbm4vc0wuQaLtp+8cpXffwtoFuropO3IWF6515r+14pszXkBcVVMvuxP3r52dmdhAF
         z8bwWSxVVrdtvcpjncQPiATiOw4p62SHPnQev/5/71yHIcfD1g7CGlwBXuBu31oz2g9M
         VhPsK9XqHJUfPh2cetwNml4ncwbV7DuKJ6qI0Me5472OjcutXmeGcbNYVi2+5NCME7It
         6PJGhnYDjZKtxbd8Wrna0qWpMlMck3zu4Vy7oeJUMGavhNVboWO8lype0mAuzT2R3xbg
         Qj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731667; x=1708336467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMIQDKpWunM+UrneNS0NgY3ocyzjZza2ecHhJJ88y1k=;
        b=HpeplDEFUHpUxFrnkrcaRUa4ZF7pUZ3jluQ26jFPmTpTfoE74bEX4bCIJvsLPncbtD
         bzVCyqBCJw4x0EDElBnMhUDlaQwwkGkL3M+K/n7AmdOBYQiQNhyJbNgzZGT0QNDdeOm+
         yjUUEYU8Eng0H3Vmyk0U/Bz/YYp1TApVxeTRJFDYQkgPsNB5LDBDby/bI1M4yNaNtSuP
         ngFRhCJ/p+aFcTcCHB4uCQBGnyJofgB7tD5qVrTV/+SO7mydhWZCrvKmgAASLB+wFmai
         bCNITbU/5JmRV8UTmN4PB3vxqUZT0koIna99NqTUCyBwcVQYoOO69DME9Dy+FDflABTt
         ScEg==
X-Gm-Message-State: AOJu0Yyf0YQtkcm0tsSQaYrjwB3qr8WchtPn96Pm/lGAILOJs3t+eOH7
	lcJ5Go/xYfjm2MSq8mpsPGgkdNZevbgmmXdsu2grEUHG7tCxXPKCnPJ2lV6gJwSjwLuwKscCs4T
	CAgVktueaodVz1IWsTiIJCfKnbc4=
X-Google-Smtp-Source: AGHT+IG/MlHO4rtA/ydi+JG0ItW1+P0Kw4weOn/uJNJktOE3eTDa25UDCp+VSUuqwmxkMzquRjo17adF55sUnhaFaMo=
X-Received: by 2002:a17:906:4c57:b0:a3c:8a77:e67d with SMTP id
 d23-20020a1709064c5700b00a3c8a77e67dmr1916452ejw.59.1707731666830; Mon, 12
 Feb 2024 01:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
 <20231221151111.GJ10102@google.com> <ZcZcpUHygltD2ETa@smile.fi.intel.com> <d844862e-1d1c-4c9a-b7fe-e0ac44f4126e@salutedevices.com>
In-Reply-To: <d844862e-1d1c-4c9a-b7fe-e0ac44f4126e@salutedevices.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Feb 2024 11:53:49 +0200
Message-ID: <CAHp75VfQd9e4fLAYkYrMajnJfPQqno6s_aiTarErPiqP-Z6ydg@mail.gmail.com>
Subject: Re: [DMARC error][SPF error] Re: [PATCH v4 00/10] devm_led_classdev_register()
 usage problem
To: George Stark <gnstark@salutedevices.com>
Cc: pavel@ucw.cz, vadimp@nvidia.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, hdegoede@redhat.com, mazziesaccount@gmail.com, 
	peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, 
	boqun.feng@gmail.com, nikitos.tr@gmail.com, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Lee Jones <lee@kernel.org>, kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 1:52=E2=80=AFAM George Stark <gnstark@salutedevices=
com> wrote:
> I haven't lose hope for the devm_mutex thing and keep pinging those guys
> from time to time.

I don't understand. According to v4 thread Christophe proposed on how
the patch should look like. What you need is to incorporate an updated
version into your series. Am I wrong?

> Sure I can single out the fix-only patch I'll do it tomorrow.

I believe it can be handled without issuing it separately. `b4` tool
is capable of selective choices. It was rather Q to Lee if he can/want
to apply it right away.

> On 2/9/24 20:11, Andy Shevchenko wrote:
> > On Thu, Dec 21, 2023 at 03:11:11PM +0000, Lee Jones wrote:
> >> On Thu, 14 Dec 2023, George Stark wrote:
> >>
> >>> This patch series fixes the problem of devm_led_classdev_register mis=
using.
> >>>
> >>> The basic problem is described in [1]. Shortly when devm_led_classdev=
_register()
> >>> is used then led_classdev_unregister() called after driver's remove()=
 callback.
> >>> led_classdev_unregister() calls driver's brightness_set callback and =
that callback
> >>> may use resources which were destroyed already in driver's remove().
> >>>
> >>> After discussion with maintainers [2] [3] we decided:
> >>> 1) don't touch led subsytem core code and don't remove led_set_bright=
ness() from it
> >>> but fix drivers
> >>> 2) don't use devm_led_classdev_unregister
> >>>
> >>> So the solution is to use devm wrappers for all resources
> >>> driver's brightness_set() depends on. And introduce dedicated devm wr=
apper
> >>> for mutex as it's often used resource.
> >>>
> >>> [1] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b=
@salutedevices.com/T/
> >>> [2] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b=
@salutedevices.com/T/#mc132b9b350fa51931b4fcfe14705d9f06e91421f
> >>> [3] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b=
@salutedevices.com/T/#mdbf572a85c33f869a553caf986b6228bb65c8383
> >
> > ...
> >
> >> FYI: I'll conduct my review once the locking side is settled.
> >
> > To reduce burden can you apply the first one? It's a fix.

--=20
With Best Regards,
Andy Shevchenko

