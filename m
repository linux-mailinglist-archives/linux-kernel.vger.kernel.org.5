Return-Path: <linux-kernel+bounces-19935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119F3827706
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC001C21729
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F269B55E62;
	Mon,  8 Jan 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3uVa8IM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EC56B7E;
	Mon,  8 Jan 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d88fff7faso22778155e9.3;
        Mon, 08 Jan 2024 10:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704737005; x=1705341805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rohZ4h41q1Lpjm2ASdq6poviREEB3sYbV11ylcmnrRo=;
        b=N3uVa8IMyLgXdkEmHblcT69e+gKttFNHMx1RHzpIdkG9w1vk6KxnAwArBqVu8DSn4v
         U/Gw2gagh5tBfjmBTgHCuX9yn/7MfrVrZFzE49LHIIZrM8db5ZWtoBAqJV/oQajIjpMi
         ncMQOXD71MnM3geAxCKrTUqNy8hBZC25QS7+kMAZScfnSBjzwAaPZSe6bo1vc2qO8meC
         Yf1OAW+JgrvUpbA4KaY4RT1YGh52B9g1c6zLarXkunA7Fn85IVRonomKa/JQ0CRc4Qpr
         Imz5B1FsVXO7SJurBiKLiTZ+8bM5dTb9xsUO8emmpzWnK4GTW27jLtVNAPirpJJM/PFy
         M/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737005; x=1705341805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rohZ4h41q1Lpjm2ASdq6poviREEB3sYbV11ylcmnrRo=;
        b=P46s8gYzNlahMqdI5IQLh1v63htk56lCdywAajV+FDTtxHcdd0sv9hfRsWc1xMJNd6
         tMCaa5oVHhE4QGNPvsY6xwp8+E0dhZF0rLuZd7PtFzEWlF6JCnptpdSbXZB5cPWxH71z
         jJzBVe2utG5MXWOwdJH1gutxTuwFdOLP21dn6iBpvhsKqP/Eb4mto4dFQJhqXBgmBgke
         BQBHTKAWXxfem5RnoorZIl2jkYPO2kSHSe7V6+suSIZE0YtKv82GAthKc7gUYbwLDQlD
         Ir6/CXwVmjO6DYhgdm1Wbi5xwOB45SPf6B16tsLmQS74tz/jltmZsD1BA38Rb1BGm9qv
         SToQ==
X-Gm-Message-State: AOJu0Yw4Jws4w+DBvsX0D1ysXgMQeMeIOAbTfhPSfFpw7f4boEmPinFb
	RPzkUu6IcHIWt7HYYH9B/pU=
X-Google-Smtp-Source: AGHT+IGL9HaOHI1pA66TfIvcnThcrsucMoJsUN9XCN/3vveKsO6ydakuBqm/MjZ2YbGaQxNUJ599Jg==
X-Received: by 2002:a05:600c:1c9f:b0:40d:70c0:b50d with SMTP id k31-20020a05600c1c9f00b0040d70c0b50dmr1171249wms.8.1704737004722;
        Mon, 08 Jan 2024 10:03:24 -0800 (PST)
Received: from cjw-notebook (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id ay26-20020a05600c1e1a00b0040e4a8c2d47sm1726250wmb.43.2024.01.08.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:03:24 -0800 (PST)
Date: Mon, 8 Jan 2024 19:03:21 +0100
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 3/3] w1: add UART w1 bus driver
Message-ID: <ZZw46ZQ5JoxlWflG@cjw-notebook>
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
 <20240106-w1-uart-v4-3-7fe1378a8b3e@gmail.com>
 <5ff1d706-9f06-4eb6-bc86-75f933e54118@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ff1d706-9f06-4eb6-bc86-75f933e54118@kernel.org>

On Mon, Jan 08, 2024 at 07:18:31AM +0100, Jiri Slaby wrote:
> On 06. 01. 24, 17:02, Christoph Winklhofer via B4 Relay wrote:
> > From: Christoph Winklhofer <cj.winklhofer@gmail.com>
> > 
> > Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
> > the Serial Device Bus to create the 1-Wire timing patterns. The driver
> > was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
> > DART-6UL" with a DS18S20 temperature sensor.
> > 
> > The 1-Wire timing pattern and the corresponding UART baud-rate with the
> > interpretation of the transferred bytes are described in the document:
> > 
> > Link: https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html
> > 
> > In short, the UART peripheral must support full-duplex and operate in
> > open-drain mode. The timing patterns are generated by a specific
> > combination of baud-rate and transmitted byte, which corresponds to a
> > 1-Wire read bit, write bit or reset.
> ...
> > --- /dev/null
> > +++ b/drivers/w1/masters/w1-uart.c
> > @@ -0,0 +1,398 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * w1-uart - UART 1-Wire bus driver
> > + *
> > + * Uses the UART interface (via Serial Device Bus) to create the 1-Wire
> > + * timing patterns. Implements the following 1-Wire master interface:
> > + *
> > + * - reset_bus: requests baud-rate 9600
> > + *
> > + * - touch_bit: requests baud-rate 115200
> > + *
> > + * Author: Christoph Winklhofer <cj.winklhofer@gmail.com>
> > + */
> > +
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/serdev.h>
> > +#include <linux/w1.h>
> > +
> > +#define W1_UART_TIMEOUT msecs_to_jiffies(500)
> > +
> > +/*
> > + * struct w1_uart_config - configuration for 1-Wire operation
> > + *
> > + * @baudrate: baud-rate returned from serdev
> > + * @delay_us: delay to complete a 1-Wire cycle (in us)
> > + * @tx_byte: byte to generate 1-Wire timing pattern
> > + */
> > +struct w1_uart_config {
> > +	unsigned int baudrate;
> > +	unsigned int delay_us;
> > +	unsigned char tx_byte;
> 
> If it is a "byte", it should be u8.
> 
will change this and all others to u8.

...
> > +
> > +static inline unsigned int baud_to_bit_ns(unsigned int baud)
> > +{
> > +	return 1000000000 / baud;
> 
> NSEC_PER_SEC
> 
> > +}
> > +
> > +static inline unsigned int to_ns(unsigned int us)
> > +{
> > +	return us * 1000;
> 
> NSEC_PER_USEC
> 
and use the correct constants.

...
> > +}
> > +
> > +/*
> > + * Set baud-rate, delay and tx-byte to create a 1-Wire pulse and adapt
> > + * the tx-byte according to the actual baud-rate.
> > + *
> > + * Reject when:
> > + * - time for a bit outside min/max range
> > + * - a 1-Wire response is not detectable for sent byte
> > + */
> > +static int w1_uart_set_config(struct serdev_device *serdev,
> > +			      const struct w1_uart_limits *limits,
> > +			      struct w1_uart_config *w1cfg)
> > +{
...
> > +	/* 1-Wire response detectable for sent byte */
> > +	if (limits->sample_us > 0 &&
> > +	    bit_ns * 8 < low_ns + to_ns(limits->sample_us))
> 
> BITS_PER_BYTE
> 
ok, change it (it is the time for the UART data-frame).
> > +		return -EINVAL;
> > +
> > +	/* delay to complete 1-Wire cycle, include start and stop-bit */
> > +	w1cfg->delay_us = 0;
> > +	if (bit_ns * 10 < to_ns(limits->cycle_us))
> 
> What is this 10? Dub it.
> 
> > +		w1cfg->delay_us =
> > +			(to_ns(limits->cycle_us) - bit_ns * 10) / 1000;
> 
> And this 10?
> 
> The end: / NSEC_PER_USEC
> 
will be more explicit (it is the time for the UART packet:
BITS_PER_BYTE + 2 (start and stop-bit).

...
> > +static int w1_uart_serdev_receive_buf(struct serdev_device *serdev,
> > +				      const unsigned char *buf, size_t count)
> 
> serdev already uses u8 * here. You are basing on the top of some old tree.
Yes, this patch is based on the w1-next branch of
  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git
was not sure from where to start. I guess that this change is probably in
the w1-tree after the next stable release.
> 
> regards,
> -- 
> js
> suse labs
> 
Thanks Jiri for the review!

Kind regards,
Christoph

