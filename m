Return-Path: <linux-kernel+bounces-147991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B78108A7C52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EC028597C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3DF57870;
	Wed, 17 Apr 2024 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpsV1kuJ"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9056464
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335366; cv=none; b=Pgh/vmk1ScElvnPMQ6a19HuP43ddTiDibwDdEjIFU5esPSmzQujC3FzjcCKfYKjyNgIhso330pUTb2uB19ssbBinf0Y7apFa6EXOZhtjUYorAwQtvJrlERJkxak1kcv2UBO1FM4N/mkHTQOCa/qnRIuVTN9HDTfyfYk6xmiT0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335366; c=relaxed/simple;
	bh=zOuw1eJRYDZNmaVdVjGYIu581bMf2HS6hcsde8LTzaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKg+ARqyNpJva+f2Rh8hvMsDbfm+C5YllZeh0Q8DkPMZdywGZXNCLHg+hruPbaBAfWGRIDc0CEs2G6Qh+FqrBD4zV2ieBLdsEuXY5lDo4Tlw98+nXRYUm4nveRH2/AZVB4xmrkTwkComujFGcEP6TpiY1miQKS/N23YOP7Wt35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpsV1kuJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4348110e888so204481cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713335364; x=1713940164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyngQvsvNX4IVjE6EtxACZNPOHV77/T++2RB3m9+N3E=;
        b=LpsV1kuJMLYPXRTYCAnuBPVjaC74V2HYUZOxWm4EMfnHIZZdKVQpI1CYfmojmI0zsZ
         aeRI0Zia6cthod57DF6kjhhmMaqlXIP+i4Twap4YQePJV3kiY6tL1NiALOtA/ZHIxuE2
         th2ZW5QgykcXDxOfOnmHIp0cIF2u3GIieYb0Jv5Lvn7bezZi0wHt25xRVPSEBdFE2tb8
         kX1xGMq5FjQ/4cjFPRdOY4lhxn+dG/zQViTbhpnbTGEyC7lBSIiJWb/n1zHLW+mGKvmy
         DPS6MFCsrZrn4pA1YMx37z102QALxM9mYgthr2kj48Kmv7ztOAOIFM5rUyx1FJk+DzEr
         vD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335364; x=1713940164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyngQvsvNX4IVjE6EtxACZNPOHV77/T++2RB3m9+N3E=;
        b=LPES2Y1oLJ+O7lbidb+DkvgTY4kfTMx00MyA/LeTH7CiQWHb/aUxcaIXxgdQv4icF9
         CZGzgGINs/jebbESVeTz7NH34cSzsLL3PdN/8x1nl/pwcUmstH6dvSFHajLFF52zlMmD
         eeOok/PKjYbM9rwaUCUcV/7lmIO7KZepNAXOlCL+sEi7G5r1jSap8aF1Ke+vvH7H1AVQ
         cXyojLeczDEowAmYRagluLDmSdpEIvn5o4poX1sQjxJv63zob7hnJGDs0N6DnEXwx6kD
         O0sIh6gpP0WesswJq5gvTll/dpVAFNBH2pJm9O/HZuLDWwuwyv4JBrURFj1kXA0DiEhc
         3uog==
X-Forwarded-Encrypted: i=1; AJvYcCXrrB5evrltXiuyvNJ0X+5wlZYHQZSJDJ06ad6o7kCNLHu9HP9a/19W+uBv5n4wRPIMRjaKSwdJGU66CxEqGwPA/fvV13Ax+OQHD2kJ
X-Gm-Message-State: AOJu0YwkvS/H/QUehxXIylO9xFVYIlUJZI2muWRlwh9oihruPj0Au0wR
	UBOzDE1PpTsx9xqDQLeuD22tbB5xxa1tm+9tE9YUQdUH6VKdCLK0iwrRgT5jpLu6OwyoXz5Xyi/
	P36BSg6A18p5FXEoj6+HjFqeLJBBe8Z6GJKJO
X-Google-Smtp-Source: AGHT+IGHXQ5c36NdPnQ8e2OzYJ8YGPtp3VigSixmG1sd9NrQgjUSDxsXVn1v8tti2TbzQ+n3DGTVwYYT2xmvyD/Cdj8=
X-Received: by 2002:a05:622a:24f:b0:436:4015:1d82 with SMTP id
 c15-20020a05622a024f00b0043640151d82mr176693qtx.24.1713335364329; Tue, 16 Apr
 2024 23:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411235623.1260061-1-saravanak@google.com>
 <20240411235623.1260061-3-saravanak@google.com> <CAL_JsqKRVVNzgQk6PETfJ9RrDuzT1CTjHWW02Twc_T4C82t__Q@mail.gmail.com>
 <Zhx9qqiymJdXwYQs@finisterre.sirena.org.uk>
In-Reply-To: <Zhx9qqiymJdXwYQs@finisterre.sirena.org.uk>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 16 Apr 2024 23:28:48 -0700
Message-ID: <CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=iEkKPNbNOccYmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	kernel-team@android.com, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 6:06=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Apr 12, 2024 at 07:54:32AM -0500, Rob Herring wrote:
> > On Thu, Apr 11, 2024 at 6:56=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
>
> > > +#define get_dev_from_fwnode(fwnode)    get_device((fwnode)->dev)
>
> > I think it is better to not have this wrapper. We want it to be clear
> > when we're acquiring a ref. I know get_device() does that, but I have
> > to look up what get_dev_from_fwnode() does exactly.
>
> Or perhaps calling it get_device_from_fwnode() would make it more
> obvious that it is a get_device() variant?

Ack, I'll do this in my next version. Right now I'm waiting for Herve
and Geert to confirm this series fixes their issues.

-Saravana

