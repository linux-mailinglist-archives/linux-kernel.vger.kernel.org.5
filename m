Return-Path: <linux-kernel+bounces-122592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED588FA31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69787294ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150874597D;
	Thu, 28 Mar 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ez+anNIh"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BE381BD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615445; cv=none; b=dB0HtjldTiDfIaP8+oFp/orFHxUJwbiJcxmTC1AfkpawvBvdZWO2gryE8km6ZSEH601zw7JE+SHKMPRTnFIL+CTnT6DInsK2JMHonJN/r9DK6xSh1DMMEjcbEIJAPvFeFUhV6WbyWjgOzEOxBhrKQEdelP8FHkG6rrMKhakROwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615445; c=relaxed/simple;
	bh=0KnspxPmptjPtiiN1MB84viWFXsln01PUyXMSzLvDdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr8If0CGX7xO2R7EPw47M65y9dFFUjy9ofsnulqHYZOZ/fNUhnh9YxUfa4g0jdQr0VGU45mPKVdthYYqM6uAF77cPrkZhxvu8sWmSRuhhBUtYMiK3zdX+JCcYDKQJ3ow5F1gXn0GQaKXqlFXWfQRVSe7G2w6TsZLqSI/0MBSkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ez+anNIh; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed0710c74so609075276.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711615443; x=1712220243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KnspxPmptjPtiiN1MB84viWFXsln01PUyXMSzLvDdA=;
        b=ez+anNIhSS6evbdGqVbD1fVckKaGe6AjKPixCJnjjb2HvVV1M0d7c/1w4S7cadfk7S
         FxYuuuffqqhMkyQFohr1QFQSkog+uuuL7IEo9r6oCCJ/yiqZNgmi56qwfmklkwSEE3nz
         YF/38aiHwUAHA993DHkYgdl8yl+tDN3YENpCV/AAp1cFgtiXnYzo1t09yh+rMJ4tkUkL
         v4HwXcuVYqLR6nW8DFsNSgkzSCYvsoT2knYUtHMwfvQv9wUyR7OThjMHonyuJ1YbcF1K
         UQbtCXQxbDMmb0WAqofH871vS5sNgNugrRNaqPh4PKV5N/zmhZGg/L2G9uT1m07T/sZZ
         4rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615443; x=1712220243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KnspxPmptjPtiiN1MB84viWFXsln01PUyXMSzLvDdA=;
        b=weBoseY2igCj9CznLmT+XCWJxMb0/QPEy6mGOcTWfEmob9RckvYlRZoMZNGj8cKYkY
         6BY+emAS859AXV2o2fifqr/FKFdhGze1aXkhA4C4/NoD/RFTBPss9u32PNdclZUU6y55
         TMJHHceR48MSXHMtKpdIDQgPKwFqnMybpiHfyr0x07hO3BMXj9tnmKjpC8O7RDVPQxSj
         D3lD4oZFEbJwFS3AO00rIdapUFdFfuyZMIttuK96ssDZuar3CTYgXqmDQd2HGjc1U1k5
         LApaEuo5zWKeVbrpNBcIeEq89n8ANKE+hpy3aWLb4IUIBqhIT1ogX+zeZVOiiUIh6mDu
         CDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbOyE9drGqFfg6V15v3aVlchThx2hniQsaqS595ePMMqqBI0UQXoNF3E+uPGPqCxczMG+ABQIoKWUMCxqVbZpKRK8yWVepFQDy6Fhi
X-Gm-Message-State: AOJu0YyzAOuMSSDL+hbb3L8APEG5oGaDCsSm/b6yZqAepQs5DKos9NtI
	HLh3ghY/v8v3G3BEOc9tYC6GFroorrhQ6tZigKiTDPvnuujt6gT9RZnG1bhvFalt2f/jKk4Wgh2
	UIxoevJqdzukvG6dHVZgEOfsXMHJDd9sR4kUaBg==
X-Google-Smtp-Source: AGHT+IGb5H3R35IP1tIxYsq+Y1oXbGf8VvXryqoK/O1YCOgUhtar2l/ojXonUW+2fConiLoBCwqhN8exb2+m2cKEBjE=
X-Received: by 2002:a25:9389:0:b0:dcc:d3ab:2fc0 with SMTP id
 a9-20020a259389000000b00dccd3ab2fc0mr2146095ybm.23.1711615442841; Thu, 28 Mar
 2024 01:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311140833.1168742-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240311140833.1168742-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 09:43:51 +0100
Message-ID: <CACRpkda4y8RJdPgoZrBYYH=QGEcTWaWKRtd5i_YspRisaUgPqQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: pxa2xx: Make use of struct pinfunction
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 3:08=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since pin control provides a generic data type for the pin function,
> use it in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij

