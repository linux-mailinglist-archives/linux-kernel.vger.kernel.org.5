Return-Path: <linux-kernel+bounces-32325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3F8835A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D741C21A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9DB4C90;
	Mon, 22 Jan 2024 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TLkXbU6N"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D24A33
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705899458; cv=none; b=HajlEdoXFoxmt9XBM+mO7DoyCg7ga0XPFo7EB+bkQwByBeGS4MnEruDBrQhFMtDNZCDqayeWVvdbEqZ2evfJ87vtcG11W28mXZ/fQQUCxWgXgJ3WL/oj1KUMZyH6ZyZJtRjo2tI5TGZt2aHxkcj3fUpoGF4YeW1vstk+WaSrJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705899458; c=relaxed/simple;
	bh=5YeLdYqk8xDHGUclfUDC+uN84dr7BzMUwPtW37X3OG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZJ/yXg0smcdsWipdNKxStzKoyojPYhITjIsZeSWZFoa7/suzxBFlkYZa1889Y763NGdF3aIh2963xtTnrw/tulysMxNxKDjJxbIPNaDMDIySUNY+UkH9UJUr9WH8x53tx23cAAOteVi/vHAhW1G/jGia/RjQ67UCVv2yWjd6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TLkXbU6N; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50ec948ad31so2832466e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705899454; x=1706504254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YeLdYqk8xDHGUclfUDC+uN84dr7BzMUwPtW37X3OG0=;
        b=TLkXbU6N4pDEu/c6OhurPJqcOd4Rc1ZaMimFP9b+AnzM3F0ma/xpztYhj0/cWfmQj8
         0ppQHVTiT2B6PXdrFHvbY9bPjnUQm6lC+DwVxxd5VMQhweRs7eAhhWfpJSOvIg821wLj
         fuGOMJj6mNKU+5AFOnUEMnivBAmqWqHlxXCq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705899454; x=1706504254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YeLdYqk8xDHGUclfUDC+uN84dr7BzMUwPtW37X3OG0=;
        b=u3BmRNRZJtZvJ1AGjJY3pMlrF5TmNlT9nCju5HhunKtVMJnBjNmaIxOJqm52PkFqUB
         MvchpZH0xuKM67TAvirXFyy3YX5rUyGgpMa27jR+LP3uNgAE+m9HEeI2E2OXRzcsvkkO
         52xwxF7Ba17M1fHAOK48gbkf9xWtiF4IfY+4buA+NTRLrKG11HS+cqbJxNCIHe5104p4
         a6N60+mwufv//v5gXZEr8CvJdkLIbxMaXeHZf8K0NcvCsXa+CwwLV4171B/VEr7iJ6+5
         /YfXyzBenMqSbD3GVezQKRZtC2tJ4wzTeIET9WyWCrJykSkbeRPzIuFt+Rv5xnBX7b5U
         9OaA==
X-Gm-Message-State: AOJu0YwuRDsC+TH+ACJhyScqvZdNMTxiiAJxR2kQ9AAx/Nz0nNB4VoOX
	3EcfXb7S9eBfStKGDMulo47Xrdy2ZgUPL9fY+9S0X5XmU9hGb8KRetbgpEJR3XS5tCCj+8BihRU
	LNA==
X-Google-Smtp-Source: AGHT+IGT7tYymkieZT//YNpHRfyiDsgnXYIfmIHCJO9ttm8OvNM1rXt+LluXn8ODEPEk9PaC6Vj08A==
X-Received: by 2002:a05:6512:39d6:b0:50e:596f:6853 with SMTP id k22-20020a05651239d600b0050e596f6853mr1611728lfu.22.1705899454136;
        Sun, 21 Jan 2024 20:57:34 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906399900b00a29db9e8c84sm12983106eje.220.2024.01.21.20.57.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 20:57:32 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-337cf4eabc9so2216147f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:57:32 -0800 (PST)
X-Received: by 2002:adf:b343:0:b0:337:ca7a:313d with SMTP id
 k3-20020adfb343000000b00337ca7a313dmr2180046wrd.10.1705899452326; Sun, 21 Jan
 2024 20:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com> <6c7d9c92-7616-4fad-806e-44302c33b63c@linaro.org>
In-Reply-To: <6c7d9c92-7616-4fad-806e-44302c33b63c@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 22 Jan 2024 13:57:15 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AN-1FTHZcE1Eja0Jd4iqpDocZSz19F44RxqtvKs6ikeQ@mail.gmail.com>
Message-ID: <CAAFQd5AN-1FTHZcE1Eja0Jd4iqpDocZSz19F44RxqtvKs6ikeQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] HID: touchscreen: add himax hid-over-spi driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tylor Yang <tylor_yang@himax.corp-partner.google.com>, 
	Doug Anderson <dianders@chromium.org>, jingyliang@chromium.org, 
	poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org, 
	jikos@kernel.org, wuxy23@lenovo.com, conor+dt@kernel.org, luolm1@lenovo.com, 
	robh+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, poyu_hung@himax.corp-partner.google.com, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Wed, Oct 18, 2023 at 2:08=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/10/2023 11:18, Tylor Yang wrote:
> > Hello,
> >
> > This patch series adds the driver for Himax HID-over-SPI touchscreen IC=
s.
> > This driver takes a position in [1], it intends to take advantage of SP=
I
> > transfer speed and HID interface.
> >
>
> Dear Google/Chromium folks,
>
> As a multi-billion company I am sure you can spare some small amount of
> time/effort/money for internal review before using community for this
> purpose. I mean reviewing trivial issues, like coding style, or just
> running checkpatch. You know, the obvious things.
>
> There is no need to use expensive time of community reviewers to review
> very simple mistakes, the ones which we fixed in Linux kernel years ago
> (also with automated tools). You can and you should do it, before
> submitting drivers for community review.
>
> Thanks in advance.

First of all, I can understand your sentiment towards some of the
patches being in a very rough shape. As a community we have large
volumes of patches to review and it would be really helpful if new
contributors followed some basic simple steps, as described in our
"Submitting patches" page...

That said, it's not a fair assumption that there are no steps taken to
offload the upstream reviewers community by the corporate
contributors. We usually do have basic internal pre-reviews for
patches coming from partners and even a pre-review bot (CoP) that can
automate some of the checks such as checkpatch or bisectability. But
as others said in this thread, we don't control our partners and they
are free to send the patches just directly to the mailing lists if
they want to do so. In a similar way, not everyone in ChromeOS is
super experienced with upstream submissions, so sometimes they may not
be aware of the best practices, etc.

I haven't seen the patch in question, but I'd assume it's more like an
exception rather than a usual pattern, so I'd appreciate it if we
could avoid aggressive responses like that and try to solve the
problems in a more productive way. Just a simple response with a link
to https://www.kernel.org/doc/html/latest/process/submitting-patches.html
wouldn't really cost you much, or actually even less than the entire
litany in this email.

Let's be nice to each other. Thanks.

Best regards,
Tomasz

