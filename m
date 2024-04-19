Return-Path: <linux-kernel+bounces-151472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28508AAF53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FAE1C225A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF2129A6F;
	Fri, 19 Apr 2024 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doKKNFpX"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78921272A7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533367; cv=none; b=Z8DCbXJ/+H1+Y9vxjA1tp+Z2Mk2gXMt/l24qFFAO6gXsFYpaHGctRmHhjFe0iHohHRYVPx7lRRAJs6efXltwJmjfgrLZiFz4XhIgc9MpGO3laG4EG5oG0xODCqk9WzVlSppf4HWQ89eHnqqoH16FPAPupXka5OPAsDR1r9gdYTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533367; c=relaxed/simple;
	bh=7JAiJ5Etf3MuJKuNZBjkja2+rCHW1cnBdM4LUduqTKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJLjjIzKQ71OOQ3b3Dtvoepb9o6vlZhxnRm0j5FPwpYk/3q2kiUzFuQqqygLzm0SRTqMsOcRwZPNKHo3hZs/Q+ulJCAhHdsovDt65wmCqh5F39S2TnMXJ+g70eg4F7mJHKFrWL+OspZApgWFuCJzRNxxEzStXzlvwVXIXi96y2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=doKKNFpX; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61ae4743d36so23182807b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713533365; x=1714138165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JAiJ5Etf3MuJKuNZBjkja2+rCHW1cnBdM4LUduqTKQ=;
        b=doKKNFpXWbFPX9Hk7DLkM9Zs03XuC/xLc1N2FAiVqVzFml+x+GA0Sd57E747W7pqXs
         8hg6JSR6s1ii8m5DeiT/LCpPNsZfJLHxHOB7AF8QBNhBgXlz2AxnQm1MOWpOnSFndsIj
         hB8tgllVCjXxje8dv2cBH9Qc9agmXUjz0Z/JxDmzolY+9YUhrXEwbbbtLxcDwBHiAHto
         O0ZRcbrAlifHDC9X685pTo38FLoFL7BjR92BLEZDcGTnpJzfPso7G9BKB0Blbf1zOANY
         6EankST9bH1KDEr6mO3Tb3cq8TIDpXI0oraRwCbo1yM3y4i4mTUITjqXkybYPRld/Gu0
         d9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713533365; x=1714138165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JAiJ5Etf3MuJKuNZBjkja2+rCHW1cnBdM4LUduqTKQ=;
        b=cgr9QEk/2NM62n71wD7STZNkBZrea+ISv+A0KHGzFNx/kjsJPdlgGMhlClDnoM4SaV
         xCY0tAmEiwJAVBUwGM5zpxC0UFCdRLCumZDfhF19BIvKDCAvjVFNZDuW0HrR7u6Abm7T
         MnSORDTyrTJu/JWwsr2n7cT9Hacbkjx/YUBbrpj7l7yZ+7Cgdf9qnUUCJoY+e/rZNhba
         nVBY5gMx/fRO4uIKyw8Jc2zLQuKY/Th94rza+2+TSlG1MNLFGgGXCUW4XiXv3vytZBki
         SFBGCdOi4H5l5EFnA4qMgLvYKclF9+Yg6gxE/3u+EmO7ar2qNHim/JVGOUzAgeACjNs6
         m7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUnXTjGLOB/8kJzVNcPo7cLR1CVWAcSfv8jidDkUOxY1RmAzc/OxJEVbqCI5hqKEWeOTOvcMjqL5v/g5dgB24Y8vfHcqAAYPNZ43n4x
X-Gm-Message-State: AOJu0Yzh5s1ka1f6c2Y1Ij38R0b0nA14RCGXBqaWo3S3dNAGM2sRWeON
	1u5Ir/fRS5yb4qAmkzjK6zDMNWwX396WQ6b7VRheS3zl7edKWMKHcVmG/VP7haJz8EBO0/Tt461
	6H6xjxdQ/6XZ1T+evmLTAdXs/NEMzR+7IN/SmzA==
X-Google-Smtp-Source: AGHT+IFgMs/8AHU4XdiOhdZmmG+AX6lMDzgX2zHpudUuHQbXt36lKVWz9la2Pxkh/EmTXCCM3Oc22brh0qqFa3E8lKQ=
X-Received: by 2002:a25:86c7:0:b0:de0:d45f:7c5 with SMTP id
 y7-20020a2586c7000000b00de0d45f07c5mr1937027ybm.20.1713533364785; Fri, 19 Apr
 2024 06:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
 <ZhlSaFWlbE6OS7om@smile.fi.intel.com> <CAMRc=Me489H-mTfT1hfUsY47iKwoaVsf6sgkiBwBVkxJOBo9UA@mail.gmail.com>
 <CACRpkdZRp-DFQgb3=Ut27DHd1w11_aEY0HbLjJHob=C5Ek-dyw@mail.gmail.com>
 <Zh6FkejXcwBTAqIR@smile.fi.intel.com> <CAMRc=MeXV4_MT5_DKYtHqO+324dFJnr+Y1UtR9w9mj-y2OOqAw@mail.gmail.com>
 <Zh-MMAjf6hhNOCpL@smile.fi.intel.com> <CAMRc=MfJdfwP7=a3govCcj8XHR7uPwCf2BA+BiWqif74pW5u8A@mail.gmail.com>
In-Reply-To: <CAMRc=MfJdfwP7=a3govCcj8XHR7uPwCf2BA+BiWqif74pW5u8A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Apr 2024 15:29:13 +0200
Message-ID: <CACRpkdYHuw1K1VYbTH3YzvmZevt_whNsd1ce58wCSd1+B1np5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 8:40=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> Unfortunately my TODO list runneth over. :(

When in situations like this, patch the objective into
drivers/gpio/TODO so others can pick it up, that's why
I created the file, and it has actually helped a bit!

IMO you don't even need to send edits to this file for
review, it's just a work document. Just edit and commit
it in your tree.

Yours,
Linus Walleij

