Return-Path: <linux-kernel+bounces-166101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6FD8B9633
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072B2B22B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADADA2D7A8;
	Thu,  2 May 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPCHjVV6"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD728DC9
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637545; cv=none; b=qZlRS4AUXCji/VXEqVPKBa3LMPLg6x0bPB7O9lZfkD80HoJfl6/OQ93BscRGsagWwtZFPlpjDtwrA95O+U1BOKcWrgSsDOYexmLmC36oXloAjcoYtVXSl++wUxrXzychZzL9RrR2v40CMYAQB8HKldLFsuIgTBni+Y5dB4iAn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637545; c=relaxed/simple;
	bh=wb3LX5vahpx/rd816iu/ui5vqsK5KsZzBjV0cje8jHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oP2xXXdv4fO0+J/tRMZm0922TSZNzlhiiO2ZFKD4GOJFDCR9rCW6St3Sx39Usc4yooTtLXHUgeLj0FOxUbfHYDzP7+TyLl/PGeEQBDA4nIJ56CGINlSJRzLNtGWuQc+EZaq15UmRlYKc0U/WWFGzOJHkYobZTYCZnkrT06PBzAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oPCHjVV6; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de60380c04aso4463196276.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637542; x=1715242342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb3LX5vahpx/rd816iu/ui5vqsK5KsZzBjV0cje8jHg=;
        b=oPCHjVV6xufvCmOrjd8XH25kzdv2cUfoWJv6QG1k0EKQ0FQZQluIEUwRow9p/u/pa3
         k9yoNEgf8D2kUtXL6y05tLsteICbRx0DbggyEbByKMPM2oCwCRxJGn07J2A2P5ejKG/e
         90l3lBSA9qTI04lXSms574toBSgzqkR76588Gtu7eGIh0Rd9c7G0YdYBcygc3JURsQ9y
         ffQ6jDdUwOuGmqYW/XOBaeWL2cnQpTYQ8XpumXfFPw2rIspOY2OjdIT2Ho4ME87aZv3B
         +pKPHngNq+oMCvxFAHpT2UWPGWwFj1wKBt6nmBEbLRk9ZDzzEiwdr2UqOnzYOS65VFUY
         cVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637542; x=1715242342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wb3LX5vahpx/rd816iu/ui5vqsK5KsZzBjV0cje8jHg=;
        b=ovtbi99sTRZO8Ep3c2KEt6ffX69vEyvWD7YqqS9NWvFPTIux/8jRWRF0kAe8Hy0piv
         rIohhW+qby9xgjeQKJxFt/HtlYl9ebXAezMAERwK3BsSCAcJmXeL8tHnwQ9qj5WFVIPM
         KrkECPQ+t4G2P+YL6CYWPv+lnvjaLAHLztaiHddKL4r/wuvWNQ+4DXSWTZOz/BWOSEjZ
         62mnF9o24Udu+vaJfn+TmBYFS6QihF8oFs0Ak17slSdOpN6Q0FFX4QeY2zcGyaxXc2aj
         96D0QMDbHS+OezERr35J+kd6O8Db7yDKPCMOo6Juoy8UwCx19+dUqH9MkGKCdTQCeVoa
         kG5g==
X-Forwarded-Encrypted: i=1; AJvYcCUlzWT4CM+xzQ8hoEpQNlg+xSZo00zSQX8ejrRzoQqWgIRa41ZNhndaSAIf8f65ZYHhdaSl2Qp+S7iECWf5ENyd4V4s194X8gVZMyuK
X-Gm-Message-State: AOJu0Ywvz8ZdDN2DguzpFOACqZ0DyZQQtbLoES25VDfbr9G3V+CKTLyl
	haOUWQkmNb++cp+pUjPl/M0IO8QU3Ubekm5k8XWO8gd3I9pETy89c+MGiV3motFOLeE8Fn0pzMU
	DO1jgYqukJhv6e0WyyQcRttAYMFbQ7h/D8hhgTQ==
X-Google-Smtp-Source: AGHT+IGLKzyB+YZkE9uQws1DXu7KI6tBzhmXigQBA2PcTyA8yFz1MOY/h5s8kLI1LQHzH2r62g7N6C3hpZhGXaNnsIw=
X-Received: by 2002:a25:6b01:0:b0:de6:dcd:20ae with SMTP id
 g1-20020a256b01000000b00de60dcd20aemr5048683ybc.27.1714637542546; Thu, 02 May
 2024 01:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-10-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-10-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:12:11 +0200
Message-ID: <CACRpkdaPnO=Xcj-aYwBA3MfdmCk2EEfbvHyy4UJsjxsZbWmWfg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] spi: pxa2xx: Don't provide struct chip_data for others
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Now the struct chip_data is local to spi-pxa2xx.c, move
> its definition to the C file. This will slightly speed up
> a build and also hide badly named data type (too generic).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

