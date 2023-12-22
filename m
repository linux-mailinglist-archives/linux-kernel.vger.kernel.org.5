Return-Path: <linux-kernel+bounces-9274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79081C33A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6F5B22141
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD0186E;
	Fri, 22 Dec 2023 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R+GDyjG4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0AF17D3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6da682e0a20so958170a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703213825; x=1703818625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyYQXXmJLXOsMg7EENStsDeW8R8z4sDrOY72vy4TXgg=;
        b=R+GDyjG4A7D4m6E9rhzemMY/vE4CPIWaSvReOKH4WyDnADfKaSiw/AintVr5v/ni8h
         QPdxn46q7SdZ10hKrKeBd0z1i4V1uNagk8b5IEhk6z5BaExjvrWLZNCRb7yd4VG5Kq8o
         QU+JJamB1O5LIFuZo1sLSun19/+cbwpzuB04Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703213825; x=1703818625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyYQXXmJLXOsMg7EENStsDeW8R8z4sDrOY72vy4TXgg=;
        b=KWuHEwV5c/3W4J1qrY33SmC0leFpWLSVkjHjpA/6hE+MCcn5AeM7Oblc5ZBl+L8Uga
         YMo954bvI0M9KxA1WZGINL9U1LHMdGyMXXDo8Jv7HKQGjNcBj2BYMMavrCR481+22DeK
         E/PXv1khfhPZFPUB592Z5A4/g6iBzHefvmemIiNtXd2h3dJ9H8ZO1RNYYhzOrfPYv6CE
         7OpYIzv42X0xndC2SL1u2IPt/GVFhE6CCu2Zw42de09MInr1W40YXOr7K3M6aQ27Cgj8
         9LQAipxIH3xP5Xtu9I7wuMgyVytGhHV6ShbiSUeoqDLwcJmishIwA8eY7opYlM/N01gC
         1HsQ==
X-Gm-Message-State: AOJu0YyyNleLmAaMBYiF7Yxh6+smC+FBuZzY9RYLpfQTd4wTO7/KD/om
	/RL2s8tjtzT7hKP6ctfVrI+ebuTUrdC9
X-Google-Smtp-Source: AGHT+IE5p5XNuBxOgw9WK9fWjWOb5HyvusuUTcI01VJgBQPvuvwvxH49UCZrkL85my6xe2GyA9t+iw==
X-Received: by 2002:a9d:63c2:0:b0:6d9:e9b8:75e0 with SMTP id e2-20020a9d63c2000000b006d9e9b875e0mr780059otl.38.1703213825590;
        Thu, 21 Dec 2023 18:57:05 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:1a3e:bfb4:1ddb:52df])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm2187679pgh.75.2023.12.21.18.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 18:57:05 -0800 (PST)
Date: Fri, 22 Dec 2023 11:57:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Patrick Georgi <pgeorgi@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stefan Reinauer <reinauer@google.com>
Subject: Re: [PATCH] kconfig: WERROR unmet symbol dependency
Message-ID: <20231222025701.GA3568309@google.com>
References: <20231122034753.1446513-1-senozhatsky@chromium.org>
 <20231128053443.GA6525@google.com>
 <CAK7LNAT_Z4TeNzngMskEoNdSTWUH5gGzYm5MfO6C_H8rFcF6ng@mail.gmail.com>
 <20231129041307.GB6525@google.com>
 <CAK7LNAS8q9eDerwVRbPbqd+AKjNVkEKLOW+NAKaD4duP-gViqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAS8q9eDerwVRbPbqd+AKjNVkEKLOW+NAKaD4duP-gViqw@mail.gmail.com>

On (23/12/01 00:42), Masahiro Yamada wrote:
> On Wed, Nov 29, 2023 at 1:13 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (23/11/28 23:19), Masahiro Yamada wrote:
> >
> > [..]
> >
> > > KCONFIG_WERROR is meant to turn all warnings
> > > to errors.
> > > I do not see getenv("KCONFIG_WERROR")
> > > sprinkled everywhere in Kconfig.
> > > One more thing, you cannot directly exit(1)
> > > from sym_calc_value().
> >
> > We do exit(1) for KCONFIG_WARN_UNKNOWN_SYMBOLS in conf_read().
> >
> > I can introduce two new helpers that will tell if confdata.c and symbol.c
> > triggered any warnings and if KCONFIG_WERROR is set. And then different
> > code paths can call them and handle exit gracefully, depending on the
> > context (ncurses, menu, etc.).
> >
> > Something like this
> 
> 
> I do not want to patch warnings one by one.
> 
> 
> I will take some time to think about it.

Gentle ping on this.

We are not concerned with every possible warning at the moment, however,
we do want the critical ones from CI and (semi)automated continuous uprev
PoV to be covered by WERROR. We do experience real life problems with
"missing direct dependency" not being a terminal condition under WERROR.

