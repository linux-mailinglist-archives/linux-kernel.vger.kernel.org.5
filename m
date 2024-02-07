Return-Path: <linux-kernel+bounces-56687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9EC84CD9B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E25D1C25C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38DA7E784;
	Wed,  7 Feb 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdiLXX2c"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A247F492
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318246; cv=none; b=OpROi2SWcZZ/5ejHS41Jcd424Xn2pTcmM10DGvOu63C4PWeGJMQvhAZnnqI7uz4QVKAmOyl89p3YpkSVBNxOpA7kVE6QACqsT2k0LP5olfLVlnjzHbEVeqsShX6BBCggbsufHPtwK/X3FlG3e+z4zcDTk1SwMfrDE1A1im0bH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318246; c=relaxed/simple;
	bh=I87ABi+TTrDuBafniC/PL+SYU/E2xqbbxV0VxETwk3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HC1AWCJQjP/B1BZGZSptAzRIH9iXWKsFjzhkF+ktK4Zw7+AHrOr3AGPEoM/24T/mknsxes0ONdDcVZaVjkP1sPDlwEzE5GVlX+tewUnCy31rSrq4mlgYNzEbiLWzI47SiySq+GCgK2ke/WDDUrFx9/PQfIU5fRiaeUXTwzK9U4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdiLXX2c; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a293f2280c7so108093066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707318242; x=1707923042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekyRb1jmMOkOI68xzhu6ghCfzzpSW1u5Hc1zwdlq+5o=;
        b=hdiLXX2cEgIB4BsoZb5dRt58iqBF9zujnVBHIkqHNqB7MeVCmiNaRJMsPbmH6EXgzd
         VzpIUbq7HtOCgHTZEC683kqoI0eugMvm7hxWSYJ8XUuXJtjPlyJzj2EUxWiK0jFzSWKl
         27Dr29OGmITyP+KKzTquCI1TU09iXT+yl79WSClJxbycRNY/ImFlRVZQ2ZofZqrvszH2
         L6uyULdI4s/DNZIxZtJRRuBqb9zNVP04ggyXGU+mZZa2r7CIig2YNIrfgSUz/yMfsmAm
         U1es0GlPlrR3D1x5Ray+ZL6kWX3uZTB3YBJD2dW7b759iybQAq5oD9DyWna5o3x+HILx
         4QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318242; x=1707923042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekyRb1jmMOkOI68xzhu6ghCfzzpSW1u5Hc1zwdlq+5o=;
        b=ZmGvKBd9Bkqovxp7oq6CsqKKyl+8C5Rwc9y/ffRu6FNdRaedHB1De4JWmqE3JsWg2S
         TF8cgHXs/7W/MsImyuCfUOtXHugQYkPvSsFJOzCJGUdHHfykYkQWivjCuk2RTc4KKrDk
         tH5kZlHHw6hd/xh/lZyOGFRDUUmh7auwma8d3rJdZt8GioK6ujiIR31fNXuXsie11Boj
         b1KKXS+omF+WgFKmxG3BI5YZGOeSST+p5F2nIkuTTrBJ8rD1Tg3FVDtwQbrF+GGIRBIk
         oyKTcxTkkQ2sx7HWYyRL9rS5RCFUS3U2GneLr9kcz5tZAFwaoqpjAPD7jwCgn80M3Xm1
         WQeg==
X-Forwarded-Encrypted: i=1; AJvYcCW4sHNqwdGqVAHgLX9k+VHLCOb+8Iuz/HMykKdH3HnUmmL6SnL2dqZiMjLQ4J/ZO8CBfSdq+X7o/XwHvs+9zvLTPLootquTQcU6f9eG
X-Gm-Message-State: AOJu0Yx6uaT/Vwy+znEuBvhB8dNHdtr5Ik1m0NovlzSN9WCoqUjbCXaA
	B72rWriUxusOKgVmcCs30wAmEt9EQdaWqy4DbSLdsizru2h85akNLO9KmIUDJ3WDQL95RyikS2O
	KqRwuE2T8oBIXow7LUb0uuArrLdgSLNU0gASR2naa0fxhBE0SiBpV
X-Google-Smtp-Source: AGHT+IHTli2pAHUoJrCsw8RIEWALTQk+BoAv5NH4xK0yYAxfNkWEMUQAL5bQpZTsGV8s+Yd3F2Y+rtpYpl3PRIO57n4=
X-Received: by 2002:a17:906:1b4f:b0:a36:fc15:d724 with SMTP id
 p15-20020a1709061b4f00b00a36fc15d724mr5051540ejg.18.1707318242300; Wed, 07
 Feb 2024 07:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206042408.224138-1-joychakr@google.com> <2024020647-submarine-lucid-ea7b@gregkh>
 <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com>
 <2024020637-handpick-pamphlet-bacb@gregkh> <CAOSNQF2_qy51Z01DKO1MB-d+K4EaXGDkof1T4pHNO10U_Hm0WQ@mail.gmail.com>
 <2024020734-curliness-licking-44c1@gregkh>
In-Reply-To: <2024020734-curliness-licking-44c1@gregkh>
From: Joy Chakraborty <joychakr@google.com>
Date: Wed, 7 Feb 2024 20:33:49 +0530
Message-ID: <CAOSNQF2WKang6DpGoVztybkEbtL=Uhc5J-WLvyfRhT3MGWgiaA@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-kernel@vger.kernel.org, manugautam@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:04=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 06, 2024 at 05:22:15PM +0530, Joy Chakraborty wrote:
> > > > Userspace will see a false error with nvmem cell reads from
> > > > nvmem_cell_attr_read() in current code, which should be fixed on
> > > > returning 0 for success.
> > >
> > > So maybe fix this all up to allow the read to return the actual amoun=
t
> > > read?  That feels more "correct" to me.
> > >
> >
> > If I change the behavior of the nvmem_reg_read_t callback to negative
> > for error and number of bytes actually read for success then, other
> > than the core driver I would also have to change all the
> > nvmem-provider drivers.
> > Is it okay to do so ?
>
> Sure, why not?  That seems like the correct fix to me, right?

Sure, I can do that.

Is it okay to change the if checks on the return code to "if (rc < 0)"
instead of "if (rc)" as a fix for the immediate issue with how return
value from rmem is handled which can be applied to older kernels.
In a separate patch I can change the definition of nvmem_reg_read_t()
to return ssize_t instead of int and make corresponding changes to
nvmem-provider drivers.

Does that sound okay ?
>
> thanks,
>
> greg k-h

Thanks
Joy

