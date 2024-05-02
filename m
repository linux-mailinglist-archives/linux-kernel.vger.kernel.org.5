Return-Path: <linux-kernel+bounces-166096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622468B9629
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A4C1F22E96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3F82D047;
	Thu,  2 May 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJLOaKWQ"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C996B225AF
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637440; cv=none; b=eMfr6k39ETz32PbEuNR/mXyvTJrmis62zJid8CU1C/1Xf2W67i4cWWet00W09Bp6NiJBq/9ySzLgjTPWBBwc+6Xo6mSG+igZlgkzzqJyC8YMOELxxwol5nBW3pAgsWWNGBxq3NoyT+6BT5OmQCNLX2h1XR2JWEkVC7WhD8dPdrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637440; c=relaxed/simple;
	bh=RAwNolerGirdCR1O3ec7omBj85ZhFthPcHqaPU5XEeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvlfJTD3BWgTkWO9Wc3JnqLX68rpQe2DYAHC5YK0hIDwtFQnX/9O99cM5I3hhcHnkI0tETwtM1mLwl21syD2TOWaa253XAJcBqBpivh4N2WgavSp0fF1wT0ZYiopEOrzGRfrttcgPyIZQ8sWT/elFT61q9rJGHCt1/nw6rikv94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gJLOaKWQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61500da846fso55042357b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637438; x=1715242238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAwNolerGirdCR1O3ec7omBj85ZhFthPcHqaPU5XEeo=;
        b=gJLOaKWQAWJ/36u/h3lhrbG5SWpixSQZuJu/Od0hXFcdO8RDoPZO/6M4pY0w+1rRxT
         whA0lY1UHiCInibw7taGY2AiS3G2yrbdiKEnTPZy4r9BBMX/k+qTIxvWgPJG7eRRg+ah
         eZL73H7SbjxpkKR1KwEYupFX+ycA3NbLtR2hrxkrACdq+jpEKk4bC8xrtKjZpImAH1gQ
         1Ax73lfJGxxk8KoisZ0FE3TCfqLpUGezeJdt+KnSEkVe2eDh1BXLQOmVJn0GA8jYHD3S
         mxHlbIEPAx6A8b/6cuI2lo7OomupID5L2D7DxBKMJ3aFrph5W4FRVovrhzBr+z4JBz+o
         5sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637438; x=1715242238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAwNolerGirdCR1O3ec7omBj85ZhFthPcHqaPU5XEeo=;
        b=ZeMN926hf5p9n0YhPd7x7WA5xkOha07eL+tXiiX7wA9o8KtCVjBlYGQ1kUFn6rCmiI
         uASHkgoholLMtlW7+SqwSMhfm/t4ek/2teqBp/bX/fGkvwWeaE2Eof4+1er8hdv385Cm
         AT8zD9QY6+N2JJPFE4g4ZNu1+iVLqatIjCHDZ4qw3w2g9bhY6sqNXzmLvXXryYplsoRO
         UNkN14/NGUhYftouKcWZ05FM8d3RJn9u9SCr/KCSDZ68VQJ7BXNoH5H3fC6w6VM5zsUB
         CRkGl5DKDQYQOufjHGYh7gY5mgOqVvG+1r9WNbM5U837jEQA91c7U0aZokdfltsvCNaM
         928g==
X-Forwarded-Encrypted: i=1; AJvYcCXhU8/ixsSfs6UKNg7tXkT8L6/F52tD+j57TnK61KCenRpSEH47bnlWlUYbqKyIFBdRR3WzpC6jzJSWDeKnmK9UcAsQj3D3hCq5ROa/
X-Gm-Message-State: AOJu0YxTvTYCm9l/V0KDJjMQfOQadQQqZ/HHWldHQ4pv3MCKof4aQYif
	toKetp/Jf1fH3/VjhjWBUKtRQXZcMim67IALlmHqeQdZ4SsdV0blHSZOWnhtTknLY16JMrpbzmo
	EvT1pHtEFvjsljNFzJE3oqR1ybIGrpzZxwQppyQ==
X-Google-Smtp-Source: AGHT+IFW5rtqDg07w/xR35suGneJPXY4vzLGzaxkYgyhDIm1iKnkcxkh1FzOlJx/Rdd8m8d3MmLRxKntnFEh60J9qQg=
X-Received: by 2002:a05:690c:6309:b0:615:a86:f77b with SMTP id
 ho9-20020a05690c630900b006150a86f77bmr1472850ywb.26.1714637437876; Thu, 02
 May 2024 01:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-6-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:10:27 +0200
Message-ID: <CACRpkdZ3K=_Vj9SXqHjBPfw0PFLVOyUCvuT-O4qw5T=TZedVsw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] spi: pxa2xx: Don't use "proxy" headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Update header inclusions to follow IWYU (Include What You Use)
> principle.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Didn't scrutinize, but I trust you more than myself on this one.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

