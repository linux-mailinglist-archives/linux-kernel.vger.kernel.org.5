Return-Path: <linux-kernel+bounces-80223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7244862C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0792281827
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F318EB3;
	Sun, 25 Feb 2024 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DpqlcBhM"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78CD18AF9
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708881257; cv=none; b=LjfezynKV522AOiBMmXwKWQmZwXatnXIFeDzDtXrRmO9zvWWKdP+0saZSab4OIKHNxGKjz5GzmcFexNa9GlF6Erdf/y7ArO6TvGMb4T1jgSu7JJCX1uqhBVRvV22/JxEga1RYmZV302GfZ1DJNvsyZvaT7qTTz7GewGhJ5kgwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708881257; c=relaxed/simple;
	bh=WWHe62jqpP7qRkfkrLQuEDOnSdiAq/+HGLtVLP+TA+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4goSVlzZ6nguYp+uwVqo/EyW6IsKpekpOaC+zqjNsPOSNH2sW71vy/juLvGG8+/sUTQJqrYnJ2pfum4eV+7rbd5peKxysazVJZVDZIQtQt9YepvpE/Jgh1FYWG7ImBDRRzSIzbeEDJd/8xV//0d5kJjeEsRXgFCTHFiCAIhE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DpqlcBhM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so334598866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708881254; x=1709486054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0eZgSeXgV3xfMa5j0GZq4dgMO8aNM+WGN0zJZjS5h1g=;
        b=DpqlcBhMhLvtUpYRG+XScFGBv00VhXEQ5QUMSjnWXs3FaOF6AyB3DWV0wfs2oQbZJ4
         9QRGb99QBH79/DE/uZ7vLv94zt0ApT5kYvA7/znY+RlgUA/GnGFC7FuxIvhHCK/tiFeT
         mymG87sOzZpru/vrlHCq5K2UXkvUqNCWLaeoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708881254; x=1709486054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eZgSeXgV3xfMa5j0GZq4dgMO8aNM+WGN0zJZjS5h1g=;
        b=GfbuJWzIR4kV3bIrfSd3UYtIb+A23oUd5KEHL1q/tWDEiaw6MjRBtGZQAAgqBz3CPq
         4KmtNiKvS3AvZ5hBVwJh9Z5e4FfTOGW0AR31Re962jLeA6xHjgVIvL1OerYAwxRda+7o
         mugxp8uEs1aa1tpKymyX038nH8st2s8vj/3xWpQ2e1hgg+0P1Vlg7PsQ1pcDpilJR87c
         RqUUTpngSj6j73dJZADuQsoPp4vpG8DAskIkD2h6I6uhk81WYpnw2cx9RDHGKUNOBcwp
         b8BcFgY90dPlG9hUM2q/MCxD8y/K/uFjnkDTulsIys5AqIwPWs5377qdCPA063wCiEfq
         SWjw==
X-Gm-Message-State: AOJu0Yy3D4O1zaoc8gzG+WeJsBSYyJkqtrfK9hXPLfGf+zoYVNVZlKnt
	962mesPxJ+Y9h4F0YBUcuYbZKufaQ+SaXfCRCpEkwKlLZtA/h0pdC1W27fJDBpvYkfrTdnT04W+
	SeMFTUQ==
X-Google-Smtp-Source: AGHT+IF4Wxq1vawBjQRDvfI8ol+WIYIOu8IswNiW4nVKXx8cVbDNmEpGPqJsUb+1bJDgw2C2QKoMng==
X-Received: by 2002:a17:906:f55:b0:a3b:eaa3:ecc4 with SMTP id h21-20020a1709060f5500b00a3beaa3ecc4mr3239790ejj.60.1708881254184;
        Sun, 25 Feb 2024 09:14:14 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b00a3f1cb81dc6sm1618674ejb.84.2024.02.25.09.14.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 09:14:13 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so2607748a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:14:13 -0800 (PST)
X-Received: by 2002:a17:906:4f01:b0:a43:1201:6287 with SMTP id
 t1-20020a1709064f0100b00a4312016287mr1617440eju.73.1708881252681; Sun, 25 Feb
 2024 09:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com> <c6924533f157497b836bff24073934a6@AcuMS.aculab.com>
In-Reply-To: <c6924533f157497b836bff24073934a6@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Feb 2024 09:13:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNh5Gw7RTuaRe7mvf3WrSGDRKzdA55KKdTzKt3xPCnLg@mail.gmail.com>
Message-ID: <CAHk-=wgNh5Gw7RTuaRe7mvf3WrSGDRKzdA55KKdTzKt3xPCnLg@mail.gmail.com>
Subject: Re: [PATCH next v2 08/11] minmax: Add min_const() and max_const()
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 08:53, David Laight <David.Laight@aculab.com> wrote:
>
> The expansions of min() and max() contain statement expressions so are
> not valid for static intialisers.
> min_const() and max_const() are expressions so can be used for static
> initialisers.

I hate the name.

Naming shouldn't be about an implementation detail, particularly not
an esoteric one like the "C constant expression" rule. That can be
useful for some internal helper functions or macros, but not for
something that random people are supposed to USE.

Telling some random developer that inside an array size declaration or
a static initializer you need to use "max_const()" because it needs to
syntactically be a constant expression, and our regular "max()"
function isn't that, is just *horrid*.

No, please just use the traditional C model of just using ALL CAPS for
macro names that don't act like a function.

Yes, yes, that may end up requiring getting rid of some current users of

  #define MIN(a,b) ((a)<(b) ? (a):(b))

but dammit, we don't actually have _that_ many of them, and why should
we have random drivers doing that anyway?

              Linus

