Return-Path: <linux-kernel+bounces-90011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B790886F8E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C23B281429
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1F04696;
	Mon,  4 Mar 2024 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbuelRFg"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8858211C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709522912; cv=none; b=Fri2SZvB4rqV9jY1TRObNL8kN7tRIIfkIYqxg9KUYAdP+ZY3xTRKtvANhOco/vddiz3+vI6JyHjZUj0knY7hIDTXRXHQFatyeYbqmzMTMNJQz8iPfDcIS0HHBOBhuN7z240Z9KqpvNSR0GQ21bylakFEhfs3HWPg/8dUOecl4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709522912; c=relaxed/simple;
	bh=zaCqbDv2/XlXGPllAK525n20UKA8SvXsWmlKlBE+yKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAZuXnI1Z1a/IW4wt9LxJk2Tc725jl/BxGXffocYPWuAm+7s9rMGzCjbUVmbcdhX3jmulBSsDCJRzmwW05BeiTeK5uT2FDU/8ClGZmrc6kcwR0iDLEI0pzK9XwodGt5AT3bgRFyJwusy1qOCdtxO2C5QFzLdgPYsoCL6cXbd8Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hbuelRFg; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso46955881fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 19:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709522909; x=1710127709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaCqbDv2/XlXGPllAK525n20UKA8SvXsWmlKlBE+yKo=;
        b=hbuelRFgOZHnVHd7ezvCqL5nmlDLAbP2+aRSYeEGPIIdIWg20iN1XchCOLNAvROCkn
         0VEkmgLACDfNPoPtmLDLoeSBMEhEKxbP43GrKzhGJCjZmIFNYX9dPLQEodX3Rm6tZ59T
         F1HQCbH5RIJTFwhn8wisfhjp7Rf3PtauKCymI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709522909; x=1710127709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaCqbDv2/XlXGPllAK525n20UKA8SvXsWmlKlBE+yKo=;
        b=K2x6F1d79sdEp83yNKuTBICFP9yc3U8JceaVOVFieiaWmGCxPPjE4oip3JWPjcehsh
         0fs7ceXA0kld8dYLPfc90Ane+Jwljd2RCYLZ2h+7DNJaD/h9gZ2gx9NLUxwqH7p23DuJ
         X+hSkENtBUE+6solWeL0EGkXeJQjMp0MzpiE0Gz4QPJMUMislwHXig814ue35oi3AClg
         jJWSM0xBxsuOKMA7D5sfoHqtCzt9PMUPnrlzYCPADpaGeauitShmQMKLYB20E1pLdnKJ
         h0jmdMpP+Va5tyFd95AXEzIQEwGBZ0taW4rLWUTY98YKIhZ6H8AJMh4F2vBCSFOzGBKC
         ryvw==
X-Forwarded-Encrypted: i=1; AJvYcCU+K4rd/rr66WZr77OXkOhuvgJ4FEAF3aJY96sP6aNZxi2eQvPSL2M8VNkN8QCGZ8PoFOoxjzPVTFjhGXMD/0HAQpR68eL28Zzw6FiH
X-Gm-Message-State: AOJu0YyJZz3vaaMDVe19raxI4k7imJqivwoDsHY4du6fgMsCO2hez6mG
	ZTjUhDL/DT95Wh5PVsvjMXXbEBBUd/crli8sbvgvUtMghDKK6318zLoFMys3RIIPNrpnYRlNrdj
	orwkfGw3DLmHIBNA2XQW315SGQEZjLYYBTj6b
X-Google-Smtp-Source: AGHT+IEX83GLBNJB+QNwcFIXMoTZkODExcCHERXmVIl8aUNac2twIKfR5WnaqYIhJt/pNZJVY/YxZji44acT0blrZBU=
X-Received: by 2002:a2e:81c6:0:b0:2d2:3fac:5fc7 with SMTP id
 s6-20020a2e81c6000000b002d23fac5fc7mr5106312ljg.45.1709522909066; Sun, 03 Mar
 2024 19:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303121410.240761-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240303121410.240761-1-andy.shevchenko@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 4 Mar 2024 11:28:17 +0800
Message-ID: <CAGXv+5HvpUpkXSZ1W+-sCiYaz6dv1d66q-j44hU0VMMwLFnF9A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] clk: fractional-divider: Move mask calculations
 out of lock
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 8:14=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> There is no need to calculate masks under the lock taken.
> Move them out of it.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

