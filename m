Return-Path: <linux-kernel+bounces-41987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C05F83FA5A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC7C1F21C08
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2784438C;
	Sun, 28 Jan 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GmUzxYOA"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536222E413
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481141; cv=none; b=Cs/9r/HUdnv6YGgneFx51+QCrg4pfXclel0YAFIGaBrKNdkK30z2peON2kaTI1Jm5YM8NL+EDN3XWMtU5hTuciCqj7ol8l/BNVpxGY+xROaXQKoVWAuPk3fYDLoRMJmZEx8IeedYmGGsoDM5UbKu54r0+cat/Kbhn8ZvUnaU6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481141; c=relaxed/simple;
	bh=AEYZz0WbEa5P8+CB+O4anP0MQfywFaLOnhWBqol5b2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiHuMesOVN100vVGzMmujirZ70iO7SLYUvzW3Oy6qsrohybmxiku0dZqi4PkJmrePY2sJqdDCBe1PxQt2TrYrB5IhFasvyoBTL6A4MG4sw+VM1JxRynqXcIErx/VuWCcZyzDX7T1HKGg51EkwYTbNzx6pSx0pD2OOiB439aSK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GmUzxYOA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a349ed467d9so211207366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706481137; x=1707085937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bqwd7hhPAgPM5QIH38rfOxpWBqWFIbyQQhTZxa5cgpo=;
        b=GmUzxYOA42m7h/7H4YNdv34VRamsWfZHNZ0+fFrZ+hcwnOSugC+FDjr97BOejvA/B0
         15aSABLiDKGWI+Ddja2wklAoPCVjLPunUNcDlKBoPIj7ovhktc5CpY6AhqBsts39Uo9v
         PoBAqImOt3ALpkfnJXJlAe0T8391j42pTmHrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481137; x=1707085937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqwd7hhPAgPM5QIH38rfOxpWBqWFIbyQQhTZxa5cgpo=;
        b=tqxeG3nModEVnrsWxA1wVzcyX3SIf8+LK3zNExxa0K1us7ztwqXG+/MFajGt9b5pyt
         OaZNlCynOQSVINCBUd5eW7NgnYzSuI3brnpZPh7dI47Pnn0yWbuQje+/ILy49lO22gvk
         3iajHjp62v0/R2R3bbTN1gN4uOnTLse9E3qqKKvw5hKSYt2pAERnY5CjuIqX9JlWRcv2
         fMQx81I/gTZaSSm9N8GUcl+hYxcnW00vf7CDv5VSkzBAqKbwp0VAapuP1AVbZztK7CLS
         LGtuehLCazo0kjTAYwGGd7cOJpnmERRKLgBZZN2joc4B63zJwIjw0NoHRWyFg6c3yoGO
         vaGw==
X-Gm-Message-State: AOJu0YwiNM4rTylLN0ldgVPkkrR/cbWW5SgsoUybrD0seREkh3Jo/NWr
	pkIuwP5CMsOCthj2E06rlf4VO493/TwptsNc4J/7zYRgoE3lRnYpO0FgyACb8iKd0oJgJe4s1h+
	sivC62Q==
X-Google-Smtp-Source: AGHT+IEiO3guxIDg3SU/aSm8MKWrHXgiIWKXaUsEhhZ/xcspsGTOzgFKAEzVJG8AcjV3cKRnhsGTsA==
X-Received: by 2002:a17:906:fa95:b0:a35:9da8:5cd3 with SMTP id lt21-20020a170906fa9500b00a359da85cd3mr1179569ejb.57.1706481137261;
        Sun, 28 Jan 2024 14:32:17 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id gu24-20020a170906f29800b00a35b99df4a6sm378363ejb.38.2024.01.28.14.32.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 14:32:16 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55eece07a75so601731a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:32:16 -0800 (PST)
X-Received: by 2002:a05:6402:3509:b0:55e:c6e3:5e24 with SMTP id
 b9-20020a056402350900b0055ec6e35e24mr2150353edd.36.1706481136452; Sun, 28 Jan
 2024 14:32:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
 <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com> <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
 <a756a7712dfe4d03a142520d4c46e7a3@AcuMS.aculab.com>
In-Reply-To: <a756a7712dfe4d03a142520d4c46e7a3@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 14:32:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiacNkOUvT_ib9t4HXX9DSsUCFOCAvbPi+WBkdX3KCq2A@mail.gmail.com>
Message-ID: <CAHk-=wiacNkOUvT_ib9t4HXX9DSsUCFOCAvbPi+WBkdX3KCq2A@mail.gmail.com>
Subject: Re: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, "David S . Miller" <davem@davemloft.net>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 14:22, David Laight <David.Laight@aculab.com> wrote:
>
> Hmmmm blame gcc :-)

I do agree that the gcc warning quoting is unnecessarily ugly (even
just visually), but..

> The error message displays as '0' but is e2:80:98 30 e2:80:99
> I HATE UTF-8, it wouldn't be as bad if it were a bijection.

No, that's not the problem. The UTF-8 that gcc emits is fine.

And your email was also UTF-8:

    Content-Type: text/plain; charset=UTF-8

The problem is that you clearly then used some other tool in between
that took the UTF-8 byte stream, and used it as (presumably) Latin1,
which is bogus.

If you just make everything use and stay as UTF-8, it all works out
beautifully. But I suspect you have an editor or a MUA that is fixed
in some 1980s mindset, and when you cut-and-pasted the UTF-8, it
treated it as Latin1.

Just make all your environment be utf-8, like it should be. It's not
the 80s any more. We don't do mullets, and we don't do Latin1, ok?

            Linus

