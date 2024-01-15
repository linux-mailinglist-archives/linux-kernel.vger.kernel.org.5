Return-Path: <linux-kernel+bounces-25582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A6882D2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C097A1C20A80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349D28F6;
	Mon, 15 Jan 2024 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV7CMGsR"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFC2566;
	Mon, 15 Jan 2024 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6daf9d5f111so6658048b3a.0;
        Sun, 14 Jan 2024 17:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705282256; x=1705887056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1SMr9r1P9ntLQdKlqfO558DPhNCAuaDs7tWm9gTvsU4=;
        b=nV7CMGsRHiLsiRasqE5EcNC64Jmv1LjGXyrAuIezN+CWh3YJI9dYW+oHvgw/FFcG63
         OVgcf5xyY97EQwegiyQiG4+qgnIUaoS6aSTI4gLwdtT9dTxws99JbPakItlD1OCTaOqT
         VuEzx6BxUwTLHxQ2MDCsFTA6j9V46UA3XK0vTK6s0XggD28ntDem7hyknhhFsFYwYbLg
         FQVMZgJMXfAlbF1JhR/5qSSIaieXrb1W7/qWJAMvXYiC63uXkrv7s378Sre7tBC0VvBb
         GfjrRukKObFD7vIgy8KVqiiwtyor3jQ8dz+MdqNDHbVQtzNNqRrmgldPB5Hwnxg8BB/+
         SUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705282256; x=1705887056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SMr9r1P9ntLQdKlqfO558DPhNCAuaDs7tWm9gTvsU4=;
        b=f/aT19EwaUUnta292h7foqsedqe9vYob5Yk7F62EH/RwVdgQKVZV0eK+o7MlfBzjqt
         0H5NfWCgamw35bJy6cI6WH9Zyp4iqHGpDcy6slHRZRSvFCNf2LmhVpnuMartTRaQFxwl
         qZJ3ZkDfCTn3vQEIcDaEfIvI5ao//pUpeqbKin449Io8ldDf6bkomE14T1gv2cMOShFk
         aJr0GIsE4gKeLuVruzpEg8d3NZQLAzyVnMOuPzktt8PPBxxGMAlZ9+iEXZDpoPI+sk9T
         Sy0e05bKz4EkqVfTHoyDo4QLNyu2c0uk7/e6m2BXo3/tCBjEyiiHvx+8s5NtvKlruJP8
         o5JA==
X-Gm-Message-State: AOJu0YzoShXgPl1p9UIixOb0ftX5TocUZb92uMrMcXEYSGdQGwUW/4Ml
	QsaXexf3eIuKY7r2fNiA1XM=
X-Google-Smtp-Source: AGHT+IEUrsl4+PPW7stJomKebbDxC5gxCyEQseFCOWI63q2e9W2MLh69fxNp5sQtjdaY02sFQZ5rJA==
X-Received: by 2002:a62:ce8d:0:b0:6da:e557:8132 with SMTP id y135-20020a62ce8d000000b006dae5578132mr4842403pfg.14.1705282256606;
        Sun, 14 Jan 2024 17:30:56 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id k30-20020a63ba1e000000b005ac384b71cbsm6122379pgf.60.2024.01.14.17.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 17:30:56 -0800 (PST)
Date: Mon, 15 Jan 2024 09:30:51 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
	andy@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v2 1/9] Documentation: gpio: add chardev userspace API
 documentation
Message-ID: <20240115013051.GA27189@rigel>
References: <20240115004847.22369-1-warthog618@gmail.com>
 <20240115004847.22369-2-warthog618@gmail.com>
 <CAHp75Vc=oZK=VR6vZ+kTapq5WpySgKVjAfuO6mxcPqPfQe6VRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc=oZK=VR6vZ+kTapq5WpySgKVjAfuO6mxcPqPfQe6VRg@mail.gmail.com>

On Mon, Jan 15, 2024 at 03:11:07AM +0200, Andy Shevchenko wrote:
> On Mon, Jan 15, 2024 at 2:49 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > Add documentation for the GPIO character device userspace API.
> >
> > Added to the userspace-api book, but also provide a link from the
> > admin-guide book, as historically the GPIO documentation has been
> > there.
>
> ...
>
> > +.. note::
> > +   Do NOT abuse userspace APIs to control hardware that has proper kernel
> > +   drivers. There may already be a driver for your use case, and an existing
> > +   kernel driver is sure to provide a superior solution to bitbashing
> > +   from userspace.
> > +
> > +   Read Documentation/driver-api/gpio/drivers-on-gpio.rst to avoid reinventing
> > +   kernel wheels in userspace.
> > +
> > +   Similarly, for multi-function lines there may be other subsystems, such as
> > +   Documentation/spi/index.rst, Documentation/i2c/index.rst,
> > +   Documentation/driver-api/pwm.rst, Documentation/w1/index.rst etc, that
> > +   provide suitable drivers and APIs for your hardware.
>
> Very good note and would be nice to convince users to follow it:
> https://stackoverflow.com/q/77683532/2511795
> (OOH you might be proud it's Rust, OTOH as described above)
>

Not familiar with that sensor.  And wasn't sure what they were up to or
why, so didn't comment.  You do a good job reminding people in the
forums, though, as above, not sure how many listen.

I'm language agnostic, so choose the language that suits your use case.
You can still do stupid things in any language, though the language may
constrain the set of stupid things you have to play with, or throw in
some bonus ones you didn't realise you were getting (I'm looking at you
C++).

Cheers,
Kent.

