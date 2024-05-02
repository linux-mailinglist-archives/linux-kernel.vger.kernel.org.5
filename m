Return-Path: <linux-kernel+bounces-166616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791648B9D15
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83C1B23953
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D315AACA;
	Thu,  2 May 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h2Eqjfjz"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140215686F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662635; cv=none; b=Je7hOf5MHZzL136uha0fFgMLgBsihputW2Ux5y26RNYVbhFiXt7xQDBZcBA0nO2JhG9KwG8tOT1QpEYlHQPA7GZvfeC/DlxPAEmuqOFJDlEtDb5o7qT0ZFAooDfqtVaSEAL6PUYDcsq1PoDTuIyYUSPDYO2P2snQ9+WPU3s4rsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662635; c=relaxed/simple;
	bh=Syf2VkK9OhG0FGm9QolyXfqpQVipkFzlmRdO+Bf9ENk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kea0a3YBspJaYYpNf3TYpfNaR8oGfb5J0rAGuUzbn0turJRuhBYGK6JQeJv0et6Jrwr/K8mfAacWv18v1ishN4YI4CSD9ArNTvjpQEhl3BL79CFgqeoT8avhUdZpE0tKaC3QKMsHmeu0vtWFn2dbKXdoonu9VChLwnzX3no1v80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h2Eqjfjz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4472561f1so182688b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714662633; x=1715267433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xXVdsaSQZG3q3BjeEnlUXi15uZTx4OzcFDhBo6L16Js=;
        b=h2EqjfjzYM3XOGhILe6haVIG3Yi6d6XW1bPfW9ScggCVjhapfmiIYyQmgB3c82WuHT
         Clsa8rm5TZ7A94hMlTBzdXIT/nrV4ehH9omp7EAvXBlNgNIr/71Rm9DZDK90DtH/fFji
         w2ExWKQW4tTfC83C/XBY0DVR5p24sWm4TsiOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714662633; x=1715267433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXVdsaSQZG3q3BjeEnlUXi15uZTx4OzcFDhBo6L16Js=;
        b=od5tGy+xkQyRFtDFe5BD38scvG2M5f+Oc1tJh4wCmT31ZxZhF9aB3N+UEae8FarZgV
         ejuJwkpVzqmUtGUiVOlUfDkDfXlroj7dVb2FgTJ7bj7xkTH1Y1shr/TdTVomuSSFljRV
         cQ9bHBxZ0fKBl6CqvLbfON7Nj4SciZC2Bi+zyulLTi80BREUdM/Gfm0hDTv3U+aaUXVw
         LcHGOUDWlZQ9dCS9ux5CZ6n+VOl6Jw2g2PYE6P+7V51wZHXAuhqVSJjJ/TJ5sPjWYE82
         6cj5pYq4l2U3svkqBYXfAPoRrN2ASnJPqHYu2Pb7YgGaPv1Jv0GqLyOfq0WA2eW89y76
         hlhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmlIoSr6cYFMCMHV2HvfS0rIXB363oinscPpQ7ZYpGZzUfWuSYsOYhUr/UXKfCAJycgsqIwAoLtXrR/fIPQRRxaI2Dzn3czKaiemGW
X-Gm-Message-State: AOJu0Yz1aSW31jC3Z6SQNa6ogMyXJdCWwpNBpImODH4v+D7CrqmJbhjr
	X9NVprX1TaGuXPQpCd+kXl6cGkXZHzpnNIiLAUb5SKfzaz5uhLg6YDvu2bCIiw==
X-Google-Smtp-Source: AGHT+IEDevyNghnvP0FJS9e6/4jOvzu/SE7p8PlLOxCCPwL7t0qLUaejFyjl7i0fpqziyW0FaHiZcA==
X-Received: by 2002:a05:6a00:4646:b0:6e7:29dd:84db with SMTP id kp6-20020a056a00464600b006e729dd84dbmr3422934pfb.31.1714662633150;
        Thu, 02 May 2024 08:10:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y63-20020a633242000000b005f806498270sm1340442pgy.9.2024.05.02.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:10:32 -0700 (PDT)
Date: Thu, 2 May 2024 08:10:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Hsin-Yu.Chen" <harry021633@gmail.com>, andy@kernel.org,
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] string: improve strlen performance
Message-ID: <202405020809.C8973634BF@keescook>
References: <20240502141359.89567-1-harry021633@gmail.com>
 <CAHp75Vd9PibrQA=tgZLHuv-kDXana9rGcu5s_aPqyxW6tDBYGw@mail.gmail.com>
 <CAHp75Ve4BV7+C+XsNmmjCSupcL6PXe_9ZNMGAQXg9nqdMBFrqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve4BV7+C+XsNmmjCSupcL6PXe_9ZNMGAQXg9nqdMBFrqg@mail.gmail.com>

On Thu, May 02, 2024 at 06:03:04PM +0300, Andy Shevchenko wrote:
> On Thu, May 2, 2024 at 5:59 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, May 2, 2024 at 5:14 PM Hsin-Yu.Chen <harry021633@gmail.com> wrote:
> 
> And on top of that, check what this code will do on the architectures
> that do not support unaligned access. If everything is fine, mention
> this in the commit message. Btw, your commit message needs
> elaboration, e.g., pointing to the test case (which is absent in this
> patch, I assume it's already in the kernel?) and step-by-step
> instructions on how you got the mentioned results with details of the
> hardware you used for that.

I might be worth looking at the implementation of strscpy(), which is
doing similar multi-byte steps and handles unaligned access.

-- 
Kees Cook

