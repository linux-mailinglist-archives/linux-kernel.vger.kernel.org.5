Return-Path: <linux-kernel+bounces-90009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5E86F8DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E77B20CB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A384688;
	Mon,  4 Mar 2024 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KhB8Z4At"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1FE4409
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709522690; cv=none; b=WHbEkjv3KJMPkVAg+C3fsxKRnI/TyMNiSRHcR0QjgjS0XsQKYFhxDC/r12w83haiNCHRS+aINqGoxnXhNvo01eBMwLDaMTKox6D+UyHPYtwTmy/KzJnvYNCxvdUJi8GWBpvDzjVvQjDTR5NWiV2PVwJkaPxCXlSMqb17/pTnIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709522690; c=relaxed/simple;
	bh=BzTSepAuqFk2iwTMwG1megTwsCGBNZgyhxfUaw1EYww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBMzynMfujVgkRGWzdkyuTrLpwl8qPWTf7me/ucwnWPBDzAte5xK4VLlgkH8SGUrtR0qZC0fnWngIel+lfdJfXbQxVhShKhrhfH0QjYtlwtjFNEd6c6alvfGy2q1TW2eUFiner6IzTbKotwF2NSGNjAAnxCLzU2opaLgDudTh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KhB8Z4At; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso6237681fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 19:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709522687; x=1710127487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzTSepAuqFk2iwTMwG1megTwsCGBNZgyhxfUaw1EYww=;
        b=KhB8Z4AthnVazVBZVAEjV1VhR6ABdg/FOZhEbUSSUCto9mw3eNQwZHBiJGRv+JnpiA
         g8LCBQrPhmsMkO9oqSLJrnMzf0kF9Hx8aUwW4PiNGYrVYA3CMPQrQzcsRepHvkUNNZmK
         OwiQigh+IphXWBA6AgCvD1SXR7wVUTh7M/nOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709522687; x=1710127487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzTSepAuqFk2iwTMwG1megTwsCGBNZgyhxfUaw1EYww=;
        b=cyrxJHK/5Y3GJ6xRhRUSR01aHEpBd64MCdF+eFbHhwkXf9zqgPWuh//YcgK0ZfSXR5
         JK90CjWYl4A4IjfJONnXUD80wD/m1JM9vQyVlfz1isQdOBBWe2M6r0M+4SvHjH1n1Oqs
         KzGlMp3PslyHe/R1/s+unXjXX8aEwNkh+eNYXCzDe+O7JmFP2tDBdsL6MUsG5SoSCW8f
         r8v1vwANWKkvzlE+ju52aJT12ynh9ACQ+QjhBpRJ8Ejn2R38rahW0Yoij6OfTDCCknKN
         k5dquyOYZnKIMNzldJKCo85cqRiUI2dUgoBbRK0MSaFW+2yf08FgcAFFR7fWVtDPdGeX
         OP2w==
X-Forwarded-Encrypted: i=1; AJvYcCVtOhZmXT+ezf3FaBhxQGvA2BHrYWVl2jvDxlHO8hDDU2jkGabPOQPOZhE3INlky1athWCk3NhPQJSIL4cG/Koj20BO+Cvetpzd+f6I
X-Gm-Message-State: AOJu0YyebY4VyVbu9R4Ysx8rdA8rB7j9i24zH1Tl59vzZ9j+9Xcvz+hr
	HEWd+b3rLN2fk9PFl0AAW52H7w7Hs5t+rxpTpkbTxOFxQX8e1JhzyjV2Ea629WvMuQHZYL5AB1K
	gP5aF/NhOH3Cv1DPI61QwZhhPoay3zK3BzWKF
X-Google-Smtp-Source: AGHT+IEaehJcwv8Ql2bnEZCwMAwZ5eA5JpRBQx0Zydi4rfkUwXK43iue/SyplevfR5G+84KJ52NkA76SuR5iNQSwni0=
X-Received: by 2002:a2e:720c:0:b0:2d2:f429:3a93 with SMTP id
 n12-20020a2e720c000000b002d2f4293a93mr5725775ljc.42.1709522686619; Sun, 03
 Mar 2024 19:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303120732.240355-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240303120732.240355-1-andy.shevchenko@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 4 Mar 2024 11:24:35 +0800
Message-ID: <CAGXv+5H-xLEO8A2=BbYEOzZyX9x+-0tnkV-s60x6iYTjntGw_g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] clk: fractional-divider: Use bit operations consistently
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 8:07=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Use BIT() where makes sense. This alings usage of bit operations
> in the same pieces of code. Moreover, strictly speaking by the
> letter of the C standard, left shift of 1 by 31 bits is UB (undefined
> behaviour), switching to BIT() addresses that as well.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

