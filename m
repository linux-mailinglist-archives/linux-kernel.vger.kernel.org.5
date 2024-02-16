Return-Path: <linux-kernel+bounces-69324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13C858766
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC4328E541
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD214691C;
	Fri, 16 Feb 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wT4O/rqn"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F1139573
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115656; cv=none; b=F8yH86MUKnEfRgfQt+qQW3UVpXwPPucXUxZLBS9lfQd/K1UKItzi+7ovS9BuSGD4Bws8IZ5KNZPa1sHCPl2BgrKTi93g7uz7cawPgow4V1IWgSNFRFUa2rdXcCigDj9X/GNR5Cq2nEkh2VutRmyZNHBNay6ajqg0dbut5qPojd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115656; c=relaxed/simple;
	bh=pq5F3XT3b3maOzXC0OSg22Jr/nnhiqkbRrjlg8Pw5WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uX7+hjp01RcEEccFrdxJozege/qACm5TuVn18a4s+KseWjHvspg2CjG8T8rkSmkVRrn6zkjewm+xfCKFgCy0HDhO4M0djiufMfOhcdmp/ajXwtwGISc1bhhUqJxvkGiokNMvyKMUzT2GDVFNEWDOdBvSpJiJFm3HhciT2Xk1fTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wT4O/rqn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d208d0b282so29030851fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708115652; x=1708720452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq5F3XT3b3maOzXC0OSg22Jr/nnhiqkbRrjlg8Pw5WE=;
        b=wT4O/rqnQnHYkJ+OGK4uqgSCbJ75ZT/GDd2HCyCTefVXNHoj0uatbby94nU7+APg2j
         ojQU/L3tlblxeUBwyI8UTOxJLz/UXfluju5yXghvWXmLRa93IbeyD2Jnj8OpNcwZZL2R
         baIiUZmzBd21QuTercEH+stdjzfDdrtvE9D+mJ0Ak2cn+5zlnciIZhWb1D8EjT/UaPt0
         HY0g/McLnSQ1nV6i6Lh4JEr+ryvcAKe8ayNSnukVMGbI30FykULzn6EvAMpCrRDi1h1K
         8h+AR7upzu08uwI+OblGmhQNGhhtqshXNCFQuacFDD7WfuCvrRch4sMmet29mECf+YT8
         +Ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115652; x=1708720452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq5F3XT3b3maOzXC0OSg22Jr/nnhiqkbRrjlg8Pw5WE=;
        b=XfDZi2tevBDME5gFejVEjZNxqxccTnQBQUEuf6QD3wC6jAvTqSdRw3rK4C4a2OT2Eb
         GQpz61xZ8+k2fvLfPziaUztPfFJHTxwtFUi9ExzXc6O8lhWsDGPiT9+7kp91XhEOr4xF
         F2nB57wdgQOtaNNc5dS7FQc3s2sTLm29GHZUXGxeegpGX1yhbX6ZMAeKEXYuu4eHVMuJ
         qFBrXvvrp9K3lUNwFfxsgaNJPfUJkUYyiYGyWxQoC+tmna0OVoLXp4osGj5ZMXj+EBEg
         YPAWRJDVRxYfhM5KYUUL/8A68zWaCMnKfZssGteItpNe4okCrlR44vYzqHZ0aRcDqLe6
         5/8A==
X-Forwarded-Encrypted: i=1; AJvYcCW2DkxxX/g8BsO/8THg97VxWVvHdit+LmNJxpGmIzgDkYp++PP4dndL/eUO9Vrx/dGW8DwCYzYGpiepWpvsIHHyxL8nRvXV8vn91+/q
X-Gm-Message-State: AOJu0Yx3dQg+Nb36JUrla/dxBNMy5Wshcfc6YzHWAll+djgwo6qRQFKs
	4De0NK+/9Nsia3TVs4a9DvW/7+SktEJYJuoxiZb2sVReySaoXLH6UamAlGCV8JdT1o+Mc9vkLN8
	M+cLk6+hnHgFNHgmxfgmD1KOkp+A2d4SIk2I3og==
X-Google-Smtp-Source: AGHT+IHwHYpVzlRcp1qiboXEECylduunaBTGnGyNLKtqMnvOz1KUNJk4Xuwg2AY6zQSSCnxMnQ6+42b4qDDvaFHsTjQ=
X-Received: by 2002:a2e:9198:0:b0:2d0:cfe6:4364 with SMTP id
 f24-20020a2e9198000000b002d0cfe64364mr4326730ljg.36.1708115652363; Fri, 16
 Feb 2024 12:34:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com> <20240110-ad7380-mainline-v4-2-93a1d96b50fa@baylibre.com>
In-Reply-To: <20240110-ad7380-mainline-v4-2-93a1d96b50fa@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 16 Feb 2024 14:34:01 -0600
Message-ID: <CAMknhBGg0hHXrd3K92tgHHTnfbk7dLAMvtTSZff1P-C3=9nFaw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>, devicetree@vger.kernel.org, 
	Julien Stephan <jstephan@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 2:29=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> This adds a new driver for the AD7380 family ADCs.
>
> The driver currently implements basic support for the AD7380, AD7381,
> AD7383, and AD7384 2-channel differential ADCs. Support for additional
> single-ended and 4-channel chips that use the same register map as well
> as additional features of the chip will be added in future patches.
>

Hi Jonathan,

We have some additional features to add to this driver we are working
on that look like they might affect userspace. Can we hold off on
sending this one to Greg for 6.9? That way we will have more time to
sort that out without having to worry about breaking userspace.

