Return-Path: <linux-kernel+bounces-158905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20558B2684
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EA9284D93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E062149E12;
	Thu, 25 Apr 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQLC7G6Y"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25543AA8;
	Thu, 25 Apr 2024 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062649; cv=none; b=safE84RucIt82NCr4qUPUQ27r6xc7QWHx7lCNaCowEnb2w7phRGeza1iyCPp8Lx9Fl3P1WFyf5k4d/SinMFZfypZBOHv0DFYQfKG9UMwU9qxJTDMArWTYhOre97iqZ0LDteVNfUyRaan1hc5N+nI/8eY/lEVsDVMqB2vgzCi+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062649; c=relaxed/simple;
	bh=DKGLfC/7PKhg5OTJlNJxSCiY4zEAe3yMefBF6ZZFWqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+nU/+gG88CLuPZ3L/sUZ+EsWweARNWFmYkJJrX0cRyJNAo3FbXww4hCbp3/PUgsPYj3OKqQ4dYs15drPLpPpBGHksCRZMfZU0icNTho6464N8v+CyanEek+k0AXcIJQJlzImi740Uutnwc2SKc//+WPBaKkV/ssY91/+6QjQsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQLC7G6Y; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6181d032bf9so11654947b3.3;
        Thu, 25 Apr 2024 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714062647; x=1714667447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+m8AgMN5pHo9IgY4LAWVapky7s6aKz0htkJdTk1MDQ=;
        b=EQLC7G6YtAkJ1KuzR+jCtNVnYwFlT2BefM1WaN9z1IziJV5UGSKapinDNNAxcM/R8n
         g4soueMWk1plh5Pwko4NWNINcWxawztVB8LZwR6d4Jsu0tLWeD4lgqmHKsOXVfjsUGxv
         JNDaqEJJ+srxMrt3jh4H/k+2c9dKwux6pB3zpMIdalLXc76jpwSVGvWYc/EEpDKRF2jt
         TZGVfC4w7moTAz2RMmuRQMVHADZ+5n+fQcU211sOEGYnPiC6wdizdRBqfohvt2QINgXL
         l3PMl4SDZKyyqNw/UMdXjo7nGWm3bGlJbdaQFfwfoPMNDv2cOarnsA5Pzx7znpNe6qIV
         s55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062647; x=1714667447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+m8AgMN5pHo9IgY4LAWVapky7s6aKz0htkJdTk1MDQ=;
        b=SdZeqZBnvMq1+plToh+IeYYNVHPBK2hiQ3sEtTnpRh4/vpiM+7HjWtg6p/38NTKqJ9
         CVB/Ej4nrwNnGsOjHzecTjFcjaepFKUfQ5U4qelTdt/F9StWwuqz55duNBQ2BO3KT/cX
         k+xklwIK4J8cfhXY3l6TGyXbhPiUDwQh+9wZMBm/Aavr8R069EfC7e1PzkJDzN/DUt4C
         1EkRf8fBDcKz38XJHBGlQ0QYinYrZuhnCPa+o7NF8d8v8QyvrxivEKO5KPhbRWchplkh
         aITh8uLTUpm/Sxgjt09qYnxapwVZvgtxbtQt3GlfKmwlClayWVeWxk12fBrtIpTcd4/e
         t4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy5GT0ZXeJxRgH2Gy5hFnjHA2nClJ77XQy1DhkPY4faIvJcfxpa5zYRwJ/ZlxTo8DGFB0KbSmumjJNaNqqDcd7n7WijUnt3eQ2sh71VTFgTI7lu1u6f61SxzqWtTL2zUFJmGQ3I8nAAQ==
X-Gm-Message-State: AOJu0Ywpbw08f1nvkfPfL6eCLGuicuCgUKoOS6mM7LYWmrhXnsfNOzun
	uv2D8tUM7Dqn2k3uX0zeVO+pvuX9kP9DpSqTdGEXDAqskUjLIgU6TgChGhDpCC63eYeTuI+N6/B
	pv20nDK2fv7L4j/qCa5mDyN4bqcGBm33S
X-Google-Smtp-Source: AGHT+IHZnPPBZAczUy6Xgh4mycbDLzssxxJSCyYbyPgwtlSwrRzUTGcN9pIZNf7yBuUZ9/5GlBbTrQGYvB2baVhmIlM=
X-Received: by 2002:a05:690c:7086:b0:61b:1718:7302 with SMTP id
 jg6-20020a05690c708600b0061b17187302mr6546946ywb.31.1714062647409; Thu, 25
 Apr 2024 09:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425162829.2370614-1-robertcnelson@gmail.com>
In-Reply-To: <20240425162829.2370614-1-robertcnelson@gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Thu, 25 Apr 2024 11:30:20 -0500
Message-ID: <CAOCHtYj5sJGzzZdXHsH2gmQ_VgMS8JfTBLjg0aE9vRrVujgS6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: ti: Add BeagleY-AI
To: "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	linux kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
Cc: Rob Herring <robh@kernel.org>, Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, 
	Jared McArthur <j-mcarthur@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
	Deepak Khatri <lorforlinux@beagleboard.org>, Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 11:28=E2=80=AFAM Robert Nelson <robertcnelson@gmail=
com> wrote:
>
> This board is based on ti,j722s family using the am67a variation.
>
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
>
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Andrew Davis <afd@ti.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Jared McArthur <j-mcarthur@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>
> ---
> Changes since v1:
>  - switched to the TI model am67a over the family name j722s
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documenta=
tion/devicetree/bindings/arm/ti/k3.yaml
> index 52b51fd7044e..201378cdbd93 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -134,6 +134,7 @@ properties:
>        - description: K3 J722S SoC and Boards
>          items:
>            - enum:
> +              - beagle,am67a-beagley-ai
>                - ti,j722s-evm
>            - const: ti,j722s
>
> --
> 2.39.2
>

Rob, after discussions with TI, we changed the name of this board from
beagle,j722s-beagley-ai to beagle,am67a-beagley-ai so i didn't apply
your original ack from v1...

Regards

--=20
Robert Nelson
https://rcn-ee.com/

