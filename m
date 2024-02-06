Return-Path: <linux-kernel+bounces-54235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229ED84ACA2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4322D1C22B28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FDA73196;
	Tue,  6 Feb 2024 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxZh61Sj"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D2745C9;
	Tue,  6 Feb 2024 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188729; cv=none; b=f+9TBGmJJGcX3avHOIaRjmZlq0lqGvLntTNCPNRCSIEI1z8rUCPu+5eY7KBHuC2wiVqr7P6f9pvbjsTBBG842t9YfefieCVRc8XfFOVYfDVg+CXPqMlqBn30rwSnsdqyz9uQ9Ip4OVLHeI1HDB5mYj/XPOzOKSbu4mWxTsnyv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188729; c=relaxed/simple;
	bh=McwGGPgRVkavoNQoMXPL2VXwhEZL1rZM8bw+shBA+Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSvPvutmjuFrrxl8XbtryII9oW3nvPqkqD2gI9MAjTVitg0ydbcciKQCSs3tP19d13TecIYz/YhtXe3UqWlLjWfRpi8woitJbLJI0sSCSgYp6RkHixprUEHvDk6+eYTRqRip77IYna7Tx4Th7ROK97MQ1aRTCIRLJh+E/fSdBN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxZh61Sj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3796032418so189019666b.3;
        Mon, 05 Feb 2024 19:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707188726; x=1707793526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ku75UCViTWac7boa5tWLVJAO47alPJRNpLs6NkWusg=;
        b=VxZh61SjW20wYxVweRwHmc60M+9EUl2QiSm5azciVqG+qk62FoZE2Jc7x5eYAZCPuP
         jhf9HvQ3xwOFs4KiQfroNgphQyo6v7OtCG0Emfv9/M79aV1dcxbZW7EV3PJpcViti/3Y
         jFJ5aIpd6u2z/J1IXqnBs4qVfsgnz/gbMRPn41j1yCEV6wJ1+ooCnizredNnilUbc7IW
         xsdcZ5yO5sdYlbyyAmZMUFB/LOaXT24TZZs6lDJQ8Lkq9nVCk7e/uwSsMU3EOG3i9ZbK
         9Voq/RPlpaZnQfJS/hgO+cMHXmj2dc/qQYbqrbnoQB5wTRuKS5d0udJ6BURVzEf0jJU8
         XiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707188726; x=1707793526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ku75UCViTWac7boa5tWLVJAO47alPJRNpLs6NkWusg=;
        b=MzYTWrIiDTM45oIMJ+cxWi703iHONDEs8W44h7PT8buiL4j/6Q3Fhy73MFlvHj9UYs
         W3SUqTNTHzbShA9vFqoBZ0pBjmmcDGNswXkTLqop7PerL75xmJoXighNO+YGxOaYqLxH
         t7AQP0GLE7Uddp89vNkUjAI7/VNEO0DU5i50PUN7Rixus1z2533mFZx5vxle26fIU/PN
         p2WmjDHfbfkLc1KTcR2W6HuIGkLJzFkcqsuAT4sbz97aa6VPGkgsvvgeeU8tPf4jAwEl
         R4oVOyaBOy2I/PGx5Ct6E4wWeJZvya/pDSO+Prl/iaPbVO93emGOpLPX1HC2lES1J8Q+
         02iA==
X-Gm-Message-State: AOJu0YwkZEh8BgKT2ucbTcTTUfRCDeMajk/7qPsa2l6U26G9ji/dVxJG
	1ijmnrPrgyHsksdiAX7WKRb/gIaI/3VAvMgIP9prGc5ERQEQ8pje35uOOG3lPOPoB3kBCP8nYfz
	VvLchAP4yXoFM6hbs0x6LKe5cVOkY0HExnv0=
X-Google-Smtp-Source: AGHT+IFFtkSco0Nn4trbVLlcxRdt06Mavs1dxjdC8tfMdK4uxDm7E2j/S1fPE2WZ+9OvvL+APbgi2zuPGcLjt73Lrzc=
X-Received: by 2002:a17:906:e091:b0:a37:9793:60fe with SMTP id
 gh17-20020a170906e09100b00a37979360femr820985ejb.54.1707188726369; Mon, 05
 Feb 2024 19:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205152013.3833940-1-chou.cosmo@gmail.com>
 <20240205152013.3833940-2-chou.cosmo@gmail.com> <4a504043-e24d-4119-8c5d-107f0d371110@roeck-us.net>
In-Reply-To: <4a504043-e24d-4119-8c5d-107f0d371110@roeck-us.net>
From: Cosmo Chou <chou.cosmo@gmail.com>
Date: Tue, 6 Feb 2024 11:05:14 +0800
Message-ID: <CAOeEDysSZEeKt==zyexLE1GhE5ZpeDHS7sDLRfcC=4JgiogLKQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
To: Guenter Roeck <linux@roeck-us.net>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jdelvare@suse.com, corbet@lwn.net, broonie@kernel.org, 
	naresh.solanki@9elements.com, vincent@vtremblay.dev, 
	patrick.rudolph@9elements.com, luca.ceresoli@bootlin.com, bhelgaas@google.com, 
	festevam@denx.de, alexander.stein@ew.tq-group.com, heiko@sntech.de, 
	jernej.skrabec@gmail.com, macromorgan@hotmail.com, forbidden405@foxmail.com, 
	sre@kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 06, 2024 at 3:43 AM +0800, Guenter Roeck wrote:
>
> On Mon, Feb 05, 2024 at 11:20:13PM +0800, Cosmo Chou wrote:
> > This driver implements support for temperature monitoring of Astera Labs
> > PT5161L series PCIe retimer chips.
> >
> > This driver implementation originates from the CSDK available at
> > Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> > The communication protocol utilized is based on the I2C/SMBus standard.
> >
> > Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> > ---
> [ ... ]
>
> > +static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __user *buf,
> > +                                        size_t count, loff_t *ppos)
> > +{
> > +     struct pt5161l_data *data = file->private_data;
> > +     int ret;
> > +     char ver[32];
> > +
> > +     mutex_lock(&data->lock);
> > +     ret = pt5161l_fwsts_check(data);
> > +     mutex_unlock(&data->lock);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.major,
> > +                    data->fw_ver.minor, data->fw_ver.build);
> > +     if (ret < 0)
> > +             return ret;
> > +
>
> You almost got me here ;-). snprintf() never returns a negative error code,
> so checking for it is not necessary.
>
Oh! You're right.

> > +     return simple_read_from_buffer(buf, count, ppos, ver, ret + 1);
>
> Number of bytes written plus 1 ? Why ?
It's just to include the string terminator '\0'.

>
> Thanks,
> Guenter

