Return-Path: <linux-kernel+bounces-157135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6EA8B0D45
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6691C252CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886615F413;
	Wed, 24 Apr 2024 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCASQPkm"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26834161B43
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970361; cv=none; b=MA3wu+KEW+w/3wU5ZMuWjx/jLBxWU3+NG8E/7i8QoApMOJ32AXJbW14VGyCAcMNqQynkmVRqWKVXlqi+fbv6OFvE9/R1o+PiwB3TuqT+rovyUf0piYop+BUHv18NZ3AgZK+wDs0SM7ukiboRcjZN1HfQmgL0y5EI4oV5uqQ2xZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970361; c=relaxed/simple;
	bh=wk6urfGs/M3O3sb5eJszZmntrwsXFmVqzMNu2d4frow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/09lGJKiQskIKdqlLTGWlgAIZu1IKsPFjjcyfh4DXvMmHiOQJz6KP6Xww7OjZ8BPBKgjJjUNqrPtbELRpdtvMIi7l/DsK96p6tfv1TRrtRInhnBeZBg7ZMtBoL3ktDYEz+PRvlW020dS3BwVQG9JgNC0YDvZHMm/9G4kMLi3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCASQPkm; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de54c2a4145so2399954276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713970359; x=1714575159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLcB2GhY/+cPlasvhbE7nJ47bQSzEHeObUtBifAPvFU=;
        b=pCASQPkm1bBYKvdWkYGwGZ9ti6KMfSZsLE0eNsON6NsrdMYXBF4Gdu/IrP+3FFfwOV
         U6f6sT56bVig5Kyaa/COCsDX0xgBEKl3nK1yxI3yAgMMf8t1OM/y7lkx/o6PeYjRYbR+
         OJmn9iyFNBEfeLfeFACiO9gORGvgCa1K2zjDnegT60kgQBSTsBZc58So4hrjttRoggz9
         AO6YuI4sRXVem/0bAfapjjOsMfUI4BViZV2miRiapNLj6+LhwRGC/Jc9gejQphSy0f02
         gIVwBowf8W8xRJMraBpRiPsumJ6o/oF17W8aMY/gPjAGy7ZO3vI+UDSZW2lDvXwpExwE
         4gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970359; x=1714575159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLcB2GhY/+cPlasvhbE7nJ47bQSzEHeObUtBifAPvFU=;
        b=E3ZjPwoTv5qTN66A14jGr4ENvMIruMZkc5QljMxr4SNiA2xvaihNnvC39bYjdoxjUb
         y8k6XE0FFw7yMsPjPF4sv8hA9IANlfD8c86slXjwjVhUNHw3ym074YIRFXUetm9/7w/B
         ovk5E5FAX38Bhea2yRRQTwFcKwnqvLj7E2Fov+m0IcVC+X7Z2a+LLI3zrtrfvylbStSg
         qKfBl8pT8fkgPNfMpHq+9XyADVqG4tAKcZEtMLbK5c9PiuKURN8xE/dvbqKSE/53j7w5
         /Z0qjVV/gy660u9XYXIoKX6AWN5RTYwwWKjrVOo5wS3zeB3kZDKt9vFWy6Yxs2lM7SNa
         FQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlktjuv+2hkcfxfKkYKvpe2g0aOi4zxfVi6O0akaTy6a3XkoWG5bnrmqNpkr4023rF5uQATS/yAP3TNJXgYT6qsVM75YHfACLczXRh
X-Gm-Message-State: AOJu0Yxw4AXHMmdBSz4jBoWlWplcbyswR5YLSqdmnlwqJdF0vEP/iT7K
	CwG0RR3LhJ78+C3MMSljzKHu02SPhoEWvTb/vzzFIha7HMwzT5aFEze9EJ0q9AWIDTIYill7v5m
	ufmQSH6d1sxv3jOJ64rDqpjmitXMs1aw3NRxICw==
X-Google-Smtp-Source: AGHT+IH54wRIUrZM6RC8JRJT0ltlwP+DKNmbmB5RqBiF5ARNVrbx7ouSNK2r3YIofnkI0L1dAtgGzNJSIgy36VVWSF4=
X-Received: by 2002:a25:adc6:0:b0:de4:7831:919 with SMTP id
 d6-20020a25adc6000000b00de478310919mr2699369ybe.38.1713970359182; Wed, 24 Apr
 2024 07:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
In-Reply-To: <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 16:52:28 +0200
Message-ID: <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wren Turkal <wt@penguintechs.org>, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 16:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/04/2024 14:29, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
>
> >               qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
> >               if (IS_ERR(qcadev->susclk)) {
> > @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> >               qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
> >                                              GPIOD_OUT_LOW);
> >               if (IS_ERR(qcadev->bt_en)) {
> > -                     dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
> > -                     power_ctrl_enabled = false;
> > +                     dev_err(&serdev->dev, "failed to acquire enable gpio\n");
> > +                     return PTR_ERR(qcadev->bt_en);
> >               }
> >
> > +             if (!qcadev->bt_en)
> > +                     power_ctrl_enabled = false;
>
> This looks duplicated - you already have such check earlier.
>

It's under a different switch case!

Bartosz

