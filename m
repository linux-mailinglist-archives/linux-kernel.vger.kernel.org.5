Return-Path: <linux-kernel+bounces-47043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D836B844868
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E581F2761E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078B73FB0A;
	Wed, 31 Jan 2024 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6YnjW53"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F763F8EA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731598; cv=none; b=qs2v84yh8SqB+7Ekd9FYbCMnQUXOtZuhB/nQIX6LF3n3MvEhOXwAXi5FPWVuJ+gwnxhQubRE6d4jjGKaZzks98IcxevKLJoS16C0TwFfyFF9RnfacVIRl+4wtEIMffpeLZb1K9Ehb6+xAiPd6KJbYVsVfIw0b0qwVwcG7/i+i4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731598; c=relaxed/simple;
	bh=8ItXQIkQttPChHbaKqcIBbqwcZ1KdszXLl9Uwy7Sr4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLebwsnmnYPvMNn12cJCq7HX+NGxmjnLGCuvovfLhk7Kw5J1FfGOpckMHEaH8bNcakL0VGpeqrPZLYCyhKvs8m5/ZH8kVekJjLEZMVQ4JRPpOaYbhlakjkWeLe11HGwRuk+noXv0uKZfsoJmnr8yZdY99QmWJBXiePQcBT2dTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y6YnjW53; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6040d9e52b9so1882157b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706731595; x=1707336395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ItXQIkQttPChHbaKqcIBbqwcZ1KdszXLl9Uwy7Sr4k=;
        b=y6YnjW53LxyMfQFJSdY6lwbVIPX8uJZCen3WCanqeHm9XtrlY/JHfMaSLQRyV0hmhj
         cfwtQFLakcGPcItrY/P4QdrvCy6nV+2hvZPmbW1XvMdRwvHiGpglPIf6rjqmjy0BAQNH
         YHMOSfEdxiw9uiDIumByzImNeOaYMAj81G+Z3IVXZY7uilOlQuVtHrpkzogn9Y8BnI8s
         1b6f6jcglShVfr+2jVN56SotC6iYouf8ieqIeenURnxb6U9n3cF+jTXBciqzKT7azxyF
         J2tKo5nnSFm46JRQ+47eKdXoBmHk16KGsgBJsM134WHgxZqSXAzIQk4WD9O4fbk28Q2D
         gHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731595; x=1707336395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ItXQIkQttPChHbaKqcIBbqwcZ1KdszXLl9Uwy7Sr4k=;
        b=Bq/e6xC9IJHI9J7pnxXdk8WzYhQ4A9qdOgltnRtypnwD8Gj35siOV5WReluu7KNYt5
         ptT7gj10+Iys8HhDPYmfCI4Bfs8l8fAjJbcfbVm2V7IUFu91UMr3Py7rRycYQTqCaw8j
         4bKLMV1KqcRWsSP8KtVd+1iN1IPao3Les0FDqKyxpPPbrq4nU4hEVsjGfYnm2XvZ13Zm
         H3uXlxEj+UNsnwYUhTU8yhrltJro6sSvjd5Gt3dsCwQE97JrjRlj5LTSdCNwFrZ1Z++B
         yTPcjckqErzNEIrKzbDt+WMBvFScs5sGSEAl2ZTv0IXUVFyOCvC3XLN6Imzh9YdU2cwH
         DfRQ==
X-Gm-Message-State: AOJu0YxlHFURUAB+UGhX4N6ShnJZ/dfGsQe1auwZiWFTIwlcOX1IUWpN
	IJRZE4GewcqVKq3261IYswzQYQ4Amq0i5OMcNhsi99VAnQvqHeVOFyC3js86ThhFUQLe+jJogEJ
	Az4ug8bVtcHEn8Q7qUWoR6ciThWmg469crU26MA==
X-Google-Smtp-Source: AGHT+IFOT1HXlFCXtHspX3UTVDTXTIGkWZx8hpYXw/Zb6yKcZalkw99EB7yeSJu6GX8s06md6Sc0WbZcI6LX4o5msBs=
X-Received: by 2002:a81:bb52:0:b0:5fb:c044:f087 with SMTP id
 a18-20020a81bb52000000b005fbc044f087mr2423659ywl.35.1706731595576; Wed, 31
 Jan 2024 12:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-13-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-13-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:06:24 +0100
Message-ID: <CACRpkda2dgK1hWdFRJh7N3qER1q-+Hfmng_Kiap1PNYQ-edcEA@mail.gmail.com>
Subject: Re: [PATCH 12/22] gpio: sysfs: extend the critical section for
 unregistering sysfs devices
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Checking the gdev->mockdev pointer for NULL must be part of the critical
> section.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(Unrelated: I don't quite understand why it has to be a member of the
gpio_device if mockdev/sysfs isn't enabled, something for us to fix
another day.)

Yours,
Linus Walleij

