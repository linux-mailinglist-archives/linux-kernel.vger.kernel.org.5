Return-Path: <linux-kernel+bounces-135742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E4A89CAA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873162893AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE4143860;
	Mon,  8 Apr 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="d2eeQuXj"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A314143893;
	Mon,  8 Apr 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596898; cv=none; b=cqTN7ipigq2edQeAE0SdSa7Q7tP6/WR7EA/RBD9U6gn7QmyAlVuuyZLHVzFqiq+xHuAcdY/bOD4GBhcZwUKTq3hk1D0msStjJyp5uKYJFHzs7H41SZknCn3uYSsRbVz292bQk5Vdn0lN3RPExcB+dURe9DjkM5SG03rzOllLyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596898; c=relaxed/simple;
	bh=CD+KxDHqdUb5j2VIVvwfKn0QC5O9nZf/3mXOmaOeTAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCPpSKOFab6f7f3oqn2Od/eO47i0CxqbrQ40Mq0VDax/8HtgyvJ3NPHFvAqmuAuzF+78ifEbmweFFRnDgVzXgwR0IIPVWBqFAsHH1JEF3C7Yokl6VluTkycB+qUzJXN48xb/V9OfatrCUsJ2hJ5+jjAg0MglRR3ZOLI0mcCp7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=d2eeQuXj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e403dd3995so6812005ad.2;
        Mon, 08 Apr 2024 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1712596897; x=1713201697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD+KxDHqdUb5j2VIVvwfKn0QC5O9nZf/3mXOmaOeTAw=;
        b=d2eeQuXjqbnnas27VijjflZI4zO+CKojp2N84SQYWWhOaEj31IA/lDvrrqqTcGex4M
         Bc9McgPsh8h0GPW/taOkTIUitViVWZk60OA9rH7UVXWuHSXLJWJti6f3vcdYt3e6jhZS
         Z+QP2ORysebrq9v9JyV5QlQflSY21Tn3odvT2l3Tyc6qUbLzeAHDvXaqa3AwHpFJx4sS
         swU9+cH1tZ6v78UQBCvrK0/3PJdbKkuGXSbsoausQW2yGjAtaEsMU1iVfKCIfVTAKrZI
         AgswTewCp9d2tu0mvtMeZGgkAEq0otq8fakyW/tw0qCALv7bZeqMCQ4OZnPQ0SZbZmDQ
         WKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596897; x=1713201697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CD+KxDHqdUb5j2VIVvwfKn0QC5O9nZf/3mXOmaOeTAw=;
        b=uOAUEjf30kEKonguEOcaLMJfLSvRkmcKEgfrTLMdMJ4yVOzDq79dL0hku18PTXzhiP
         rNB4wDWRe0P7oZh4ARjLWlE8nIZKZ6Cbubde5sGXcXsRbYxG+7ZJuEfAZ2PEC6LraR/X
         UbfXv9kTavO7MGXGc+XtROiinYQq3WYhrhGasIJIUldyF7a6MiZHFelcb8awoJCPuKbk
         eGJ4kh/BbTxqoKsaZ0hl2d8ph2Mlm+EpgtNuwL28f5STK8t7IntyrmBVUZaPR1PmRKt6
         vCAITDaHSDeSHqE4yC+fqlsA+XYM8rAm8LQ8eFiZthTrCzpBt9vgKvnd2U5XpHWWb0R/
         UcmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaQc21Mm74sKXF2kO76uz20cWWd86qA1Sl6jqx8DDIcIjsCFO91poYwEYMYt5U62U+9HkVBph3HM2YRVtJWapKT/e4jyUqLgXwnMg05/DoV3fCCPd2W1Rn54Rm43AwuvOLiNPIqbQ4
X-Gm-Message-State: AOJu0Yz+7JIH2a/90Bckiw61wZUIZtvhQeTl+lFKPMowRQNrncAGNINH
	E4Gp8gas0CS2SNpI3IAIRbLNofURQTpKxm84rEU6Y0WS+/wXc3q/L+u4cJCofD3PnIHLXKOOetG
	HKkOx0iDFjd+W6LTN1Es71F1myMo=
X-Google-Smtp-Source: AGHT+IHKVZXmaxUYg2//3d3GkHNXzmwnMizOwlMUFZ14NDcEJmhIn3JkJUCLgsKZlmTC21ybmfXcgXIAwiaCdHNERgA=
X-Received: by 2002:a17:903:32cb:b0:1e4:fd4:48cf with SMTP id
 i11-20020a17090332cb00b001e40fd448cfmr3779134plr.41.1712596896729; Mon, 08
 Apr 2024 10:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-amlogic-v6-9-upstream-fix-clk-module-license-v1-1-366ddc0f3db9@linaro.org>
In-Reply-To: <20240408-amlogic-v6-9-upstream-fix-clk-module-license-v1-1-366ddc0f3db9@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 8 Apr 2024 19:21:24 +0200
Message-ID: <CAFBinCBQtMHeQ2drNTJhqtknR32M1pjy+V3nQD7XFRiT8u4DGg@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: fix module license to GPL only
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:18=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Fix the checkpatch warning:
> WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: C=
ure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

