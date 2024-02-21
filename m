Return-Path: <linux-kernel+bounces-75574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933085EB65
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972D21F22159
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B95127B6C;
	Wed, 21 Feb 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJC3sfne"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751E2574F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552340; cv=none; b=mU5QiqB5XDHaZtuid6GWhhJpkvDx4uFQ7c7Z8q4eRMlnsH4pKzGLRktKE3AF7n95ABvMSOG2/hxQIVHIRuf5dVKm6uQy5KMsVXt9Ec8QBhWPTfX51J4qDdSTyYw0oUMI2+H9U+VypFtv0rh1EFGNpQSU4VDD7cTPB4a/EvnaQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552340; c=relaxed/simple;
	bh=bzht/Nt79TBhvidvy4BPtQQspNOTYBbbyEtc9N8nXOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IC2YzKPD40jAdYKj48qsdfTfdnNeoCk8ra+7xp/7fb56yBVqZEV6eOkJjns7NBbkr8TSKMjS1lxOYP7BA14kaxL/QPlKaNACqsBfOwH5oPyrB9iFm+JMC9QO/Zb4UBtMjWRNCX1gPHxTHNObwqM2N0eVy4SMTUpHZG9IK9RzpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yJC3sfne; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6002317a427so60282517b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708552337; x=1709157137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzht/Nt79TBhvidvy4BPtQQspNOTYBbbyEtc9N8nXOI=;
        b=yJC3sfneDshWoiPllAc1IbgTGGy3EusgMMhNte3bjpyzna6qXPDIgv7uLIPO8DDDwm
         /AJi8Axf4vemq95Ka0z29scY/Gb26+e+6jwPYyaRt9BANLszu3PFAX3X0fezmRDZw2ag
         Q26jucFPGCrrzdQHvbyc0JwhY52nnUk4TAY+YSg3ckeJo4CM8inxAhfaycSOvl/9Y6sl
         k8zJafdZM+X0lU1nq1keo4L/MHtSVzY/bvCSHg1GGMLTWOuNZ29kZZ8345m8Qpn+vMFL
         QOXytfy9nvO694o6ox8rWM+ME8gfO4f0NaNF//XVIuvtjDMrTS3B3jf3z2m5I7wYe1jf
         jPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708552337; x=1709157137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzht/Nt79TBhvidvy4BPtQQspNOTYBbbyEtc9N8nXOI=;
        b=QNxKowB92Q6QMSN545+umA6ztyQnTj24p+grqY1Werk0qgGn0O+Acta/WJFdtSm2Ih
         NiaUlL6r0w7lne2UNP/AJZMxzt1U6Ae0nBu3J3tYHJCf3YAYn/grEXlLkj4dajFDr0dB
         2+xRW+GXikR/f8at0SZPTmnchRXCRDuldr6PA3hYJmc6rZhKXs9kAR0jzA6yXYnlMuN2
         24RQkMi50JU9CGZvby8KdaOLLMJYNdw04gSbSL6eNgLPcGTBb0dvMtP24jhEQxRWh5gB
         f5Vjr/gTrhBV1Kue/VxDNfWFkTWaJaDalk5W7+ReDXL5DeNVLIxc6pBC89Rn1XsU0bMy
         ldCw==
X-Forwarded-Encrypted: i=1; AJvYcCWICFIBSh+mLJIcofSuJS3Y+YqDh0P/v7YFj8xPcjwikB9WtLChI3w66H+hTzZKrw0P5h2tY7cEeDQNJbWaMrAGy0zDtbe0AGkeM57i
X-Gm-Message-State: AOJu0YwqrgwZcWUyMxjXP5oFXgniDrz9a138kiw2W0xfJHn5o7tvULD1
	VliDauoIAd5ekLm0E5jQ/GAfMWjJXwMvx/OMNgSjDTYpR+CBxdPfuL6ZbSirqOQ+KAwkgm4aezG
	t5KcoPTALZ5r1U+O0YXGHPnl6DDRcFQp8mVDztQ==
X-Google-Smtp-Source: AGHT+IG4RntqxvQH+No+/mHowhisXAh3Eg+k3FlTdY3OImy1ZRhqZIM2nXFg00beBZCO+ESfsnQ+95ANDllNWVf5Ers=
X-Received: by 2002:a0d:d7d0:0:b0:608:93b6:87bd with SMTP id
 z199-20020a0dd7d0000000b0060893b687bdmr1342031ywd.34.1708552337481; Wed, 21
 Feb 2024 13:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215083328.11464-1-brgl@bgdev.pl> <20240215083328.11464-2-brgl@bgdev.pl>
In-Reply-To: <20240215083328.11464-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 22:52:06 +0100
Message-ID: <CACRpkdYJcd0kLSF6+Mv6T8rSgqW+Sf3t0dZt9Pu3fGHGiY3LMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sim: use for_each_gpio()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 9:33=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Display debugfs information about all simulated GPIOs, not only the
> requested ones.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With the naming of that function fixed in 1/2:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

