Return-Path: <linux-kernel+bounces-105608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D787E16C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6312814BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6073814F6C;
	Mon, 18 Mar 2024 00:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhffMgr5"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B803E57E;
	Mon, 18 Mar 2024 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710723518; cv=none; b=MN20SEb3rVQtD2PxON6LkaOJGgBNJAw0islZMlxcOLLoim5BuNSKNBlBAYKJq5O2TygrQ/pvwHxhfD2xzuxLWDU/yLpFOI1H3CmUHC/96Jt1qm8yHuvo7wT/WmbZpF7kqrrWNtt1bE2fsWLA9Kxs09B2E77rHvZqGVbmZTBhA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710723518; c=relaxed/simple;
	bh=AS1zYw8yLmefRgNdN6lw4wDAORpveFU4u27l0R2El44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZrHkP+oKIsY76E/yw1vP3YgPug+VLf/2yh20q/nIjqOy4beAL/KIn0JzyPYzuH5b9pmp1B7KOL2JP7CSeX0FVE69QHjHJIkVqYP8lWUotbiXaChS/2W7foLXO3IVGOxfHLaDSMB08k42kqDXbY9f2wQSi6elerbeL9nOy8RZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhffMgr5; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-366bc265e58so3978155ab.1;
        Sun, 17 Mar 2024 17:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710723516; x=1711328316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3gO3B8juV9rqE5CX6cYNKDzZwtkK2BD97woO9bfZ3o=;
        b=IhffMgr5Pc3Q1yawHusERlxXen1gwWQSNIz68cTnYDXizfH3sTtwwWE+87N678bQIp
         HqKnWrMKI7ChZWfkUJ0SZs9sj2N3dP7zYL4+OIxA5pdKkfZu8eifN6CgCeGtLi4gWE4r
         1FvG7CzbMyCadB5jBrhNwM6fimSlOW6CauylJBo2jjeWx8wDdszzJhXVJJUzRqApnjCz
         FY37gmrYnZY63ayPC3JzQjP5w/VF56UTnlMGLjyihjdsLa5mF4tNSWvgki4cwmxZ7bVN
         rN8HRVOZCdtIJy08cpLBpeb5KeMhrg3+nZqK5h41OgzvjiYZTXJ0wYMKBvAQutOki/2h
         jj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710723516; x=1711328316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3gO3B8juV9rqE5CX6cYNKDzZwtkK2BD97woO9bfZ3o=;
        b=C6ZTgmbNBr/zyPDt2YGdN4bWFWj78y4sgl06jm/e/FCh5ZQwJBU4I52KSVoTNIvgh6
         OlaBvzynsc2K6NQhWnf4giohqRheryhqGAtXuYjO5mr0qklaAjcjyT9htm7ZpG+PBj0t
         lxD66m/s6ItdB5R9hlEPJB8Ux6q3MfbLkfb66ZxcmIoYLJ7JirirgmSIQg/x6GM2sc1l
         UAnVGNmZje3QlsP5TTYWsPX/+CXYYGPMP65omNGvlg/OjjiLnZcJYar3psYN0vM9R6HN
         vuYHSEXge3+Eqxi8b0xR+fzRo0TmImB5YdbklYkHlXKqAUXTV4Mc/nGdZzfkQGiHr/Bp
         iHeA==
X-Forwarded-Encrypted: i=1; AJvYcCWPk/DnKjsRrLPxtUedx5Rjk2zSq3n+UArfSXuBFgrGzMNyn3IOreyyqAKWHmYy6wKBtTglDDBZZ1Ha+octnb4WFaBbLC+XekYyDSa7VacVekrUhOvZ9WyoCJfpQy1uAh19LFtbQJZBZ2eIcV2M3IQRqTMFnKeQsHwBg3AMsHI5tJNTXCY+eykgS2Z+4G0jSPqVbVcFmbtcBs7hvfujGmWl
X-Gm-Message-State: AOJu0Yxe/am9djDoRTdKGNEKQUcOtmGO8MVYQyhkd5wA8sU+N39wPoRv
	Hp8iuDb/v/Vmr2WnEUGtf864luXmVrjqPKlCInnmObCtk1m1Q5Ywp8oqP7BLWw+5252s1PQXFiE
	yImyUMKJ/UkP/p2vfkvd5+cfTCkI=
X-Google-Smtp-Source: AGHT+IEWUqkwZJEiSPp20ajC62MQHxGmIR1eTp3InTtHleO4oWkGUN0u7amI5MFyUz2LLxNgHP9dfiKArtIcMhyjwSM=
X-Received: by 2002:a05:6602:1d4b:b0:7ca:f5f5:46b8 with SMTP id
 hi11-20020a0566021d4b00b007caf5f546b8mr11953675iob.11.1710723516147; Sun, 17
 Mar 2024 17:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com> <20240227005606.1107203-2-kcfeng0@nuvoton.com>
 <9c92dac2-2cec-4f66-a8e1-4c0ccd5a3d0e@roeck-us.net>
In-Reply-To: <9c92dac2-2cec-4f66-a8e1-4c0ccd5a3d0e@roeck-us.net>
From: Ban Feng <baneric926@gmail.com>
Date: Mon, 18 Mar 2024 08:58:24 +0800
Message-ID: <CALz278YKxR4d0k7JApd-ojO-6jNoVG=B+SzBqt+ev9GLfWQPeQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org, kwliu@nuvoton.com, 
	kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

ok.

Thanks,
Ban

On Fri, Mar 8, 2024 at 2:53=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 2/26/24 16:56, baneric926@gmail.com wrote:
> > From: Naresh Solanki <naresh.solanki@9elements.com>
> >
> > Add common fan properties bindings to a schema.
> >
> > Bindings for fan controllers can reference the common schema for the
> > fan
> >
> > child nodes:
> >
> >    patternProperties:
> >      "^fan@[0-2]":
> >        type: object
> >        $ref: fan-common.yaml#
> >        unevaluatedProperties: false
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>
> This patch (through its submission with the aspeed-g6 fan driver) is now =
in hwmon-next.
>
> Please do not resend. Any updates should be submitted as follow-up patche=
s.
>
> Guenter
>

