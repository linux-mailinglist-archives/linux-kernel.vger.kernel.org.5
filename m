Return-Path: <linux-kernel+bounces-151464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E628AAF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311AC1C22216
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90E127B56;
	Fri, 19 Apr 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aa5bLbHd"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08241C66
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533105; cv=none; b=N1F0Z0iGLdP7Oo3f97DmFhu26VSsLmnOHI2oBimCE/+GtrMWcJ4rP1hkYxQ5NbKZr0eUKO3lT8z6jkBJVKOkMPVAa806Ijr6B0YSNYW+aLRI7RjkH1Hq4gapKfgAb7Ib46Hi6w4tA5cuTYic56M2BNL5FjrEuKIb4Ka7+WaUbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533105; c=relaxed/simple;
	bh=UWXTaQ82HyFtQb3TRUV4cf5MB8r08tl9SIn+hgm0d+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hs5Uc6KA7HAb0tdf/5ZJ/gCc4s9M1V4PdqT4nsnrTwd1Ux/5D+2QKxI6z+C82E8yjnUyCwyNE9M/Xz9AvxxiqM9JOxkklxpdGtO44FWorGgEdKhqpE6El5El6D+qfnV89JNEPwllRpw7QGDtWEFUOQsXDx/rvrDG4ET3NYgNHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aa5bLbHd; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de45e5c3c68so2301021276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713533103; x=1714137903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkrOJ4wKG+fycpys61fJmDawiloLrXFnzq3mdhSsqRc=;
        b=aa5bLbHdbG/MRkL+K3v6q4HnJIyKyjT0PNGYQzu3xcKehSZhCBZo0Oa2STrIIHGxmI
         NYTDDIHZoVKFVSiamSwyZc86AOfpOIsn9UzsEhWUDoei/N+k2CeqKrZONtwqmJYwFtjn
         wGfloUa4qUl6S+LdV8pTsGWWZrfUk29P50IoEp4t9KHOcVz35KI3CWO3IqcCz7Z0kE1N
         Oucg0qfX3gDjuPo3fPNcf+8M7igM1XtK8XVeaOy+i+rCTjKt+e9Uy9X9LMwoFFo9WSOS
         hkT64eWbFcnhvV5hl2FFgt/1S9LdhwHvAHps+QECurjuNctvfCVrK7H5h77RkdcohOHI
         MroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713533103; x=1714137903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkrOJ4wKG+fycpys61fJmDawiloLrXFnzq3mdhSsqRc=;
        b=FHNtupgACpEeRVJ6xEuFbhr5VzoLyHv97+mFyNM3fmUjVTOAO+9gK8+7pB/zJTBdDQ
         APvid9dmh6+mxXXs1v1fJDm7fhVqeoJ7zJ68vvkwt4/q3v/Ss/rWKxOb3pGfnaW28hUI
         6M4t/Rt7h9C4zVtAKVyiQKUDXQnqb96aWrml4v3Q1oZAJALiTC3btsBQqL3NSdYWpzWs
         pK+EfNpCLQT1/2+ZJBIIhMW+UFsdAsv3VG089gfqLEvDXmK5pSOUadGLUjgCmxd/AFef
         xAe7zWrs9EeyFBSsoGYFDF/uT+4fMPCzO+XjT56XPz9L6CjrSdPI/FxyxSggGNVD+mwj
         KVkA==
X-Forwarded-Encrypted: i=1; AJvYcCU0JMqqMD9bs+O6gf3tDrGS4ZC42fpHDtYDprw65wryOJjwSJhAJfTZZmzuh7r26KM8FQvr16iHc4qH4uy1ioynaFLjv61NK2kf7sGW
X-Gm-Message-State: AOJu0YzSEuEDy3YfihdIE2C+8xpjUbxUWs/dI35anIPGmFIHCLNrblQs
	enREl+ub+Sl7VojpngaZwwz/4n5gPLENcK43MwLR0MmHB/6QNpIDODBnO60UIN5SHlrP8YHScL8
	AD1009G8k+zNhwbp1EMzxqSanFTT/F79HBaAO8w==
X-Google-Smtp-Source: AGHT+IEyyp8kZfsahZ+i2TdwPhFvo3EiP8GYbc2UBm1PxE1KueAyxKWGN/Vu8bv/kI+9tRapKwazomvLnYLu8G9C8dY=
X-Received: by 2002:a25:55:0:b0:dcc:f0a:e495 with SMTP id 82-20020a250055000000b00dcc0f0ae495mr1727089yba.3.1713533102898;
 Fri, 19 Apr 2024 06:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415105328.3651441-1-zengheng4@huawei.com>
 <Zh_rM04PspfXxlv_@smile.fi.intel.com> <d80e09d8-5f35-4865-9fe8-195b86527972@moroto.mountain>
 <ZiAC9zzSWume8063@smile.fi.intel.com> <fe83e07f-ca28-4c00-9b1b-7d16c63bad62@moroto.mountain>
In-Reply-To: <fe83e07f-ca28-4c00-9b1b-7d16c63bad62@moroto.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Apr 2024 15:24:52 +0200
Message-ID: <CACRpkdb2YCrG_wJtdSNhqUJt5x-fPSb4A9uaU6DmAOm3roFN0Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Zeng Heng <zengheng4@huawei.com>, 
	linux-kernel@vger.kernel.org, xiexiuqi@huawei.com, linux-gpio@vger.kernel.org, 
	weiyongjun1@huawei.com, liwei391@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 7:49=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
org> wrote:

> Probably we should add a comment to say:
>
>         /* Return -ENODEV if the property 'pinctrl-0' is not present. */

Would you mind sending a oneliner on top to fix this?

Yours,
Linus Walleij

