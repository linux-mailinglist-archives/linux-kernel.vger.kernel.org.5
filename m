Return-Path: <linux-kernel+bounces-47077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CFF8448D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A3DB23D81
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440C63FE24;
	Wed, 31 Jan 2024 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSb/6rbQ"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A913E22E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732657; cv=none; b=HFQQpS/FeccoFetbbsFICgAeSjRor38pydtYNeIZ/PN6lUaZxrasGJX9GbItt6sb47pOndrJOomPVEye+aPUX2rHdmBHXr47mMn9m4tztbz4mrSI806zA6EIhdnJlLHACLkUKKgh8/o6xN6TNhOjTE77UGTzWnI4dLie/9Mco+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732657; c=relaxed/simple;
	bh=64KMf/+FyjVtpRUZmQKXmip+XQCMRyyekmcIwCIvfR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzFbgeDocbfw4kfFV+pqZzp+nHOihP0v7+MRyd6s7n7FRiUicz8YjFhhNsmmmSPpiZjaFmoRFl11PcDOq5xK7SHugNUuR2Cue934IvcNZ8QeekiFHcy7gx4OrIUeeBluyadFMUCZmSayibkItSQfte+YuX7PF4R9FO3mi0qdHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cSb/6rbQ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-604059403e9so1766357b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706732655; x=1707337455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64KMf/+FyjVtpRUZmQKXmip+XQCMRyyekmcIwCIvfR0=;
        b=cSb/6rbQ0yNBl6lfzR1AN2pOZbUm/8OFo6BkvatnzdMhVIQqGBHobob5lzPVhbgHqO
         GQzHprgxVI1xz8i4wOU5OCwYtYbJu/ANVm6a4WrylgeiR5KoX1F2RwedWkK3KvB84lc9
         LC3nbcdwqSVwiD6EalSx1AhX7Kl1FXXZa+T8/p51Nph7ryrVtfw3uvxo8ncOzK8fcYJy
         ZHnDbqckPmAMFyw7owDg5rCGtE7a5nKsiTrDaOPTx6NPqRvSnDs9wlDb3u00Yhp6qQLG
         7aFzv70gJYpQ0bvD2pPAtjYdGbSk5seqDNBgPRzgUPD6Q/mnPnbo6GMAvZR2o5JW0Z+P
         6J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706732655; x=1707337455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64KMf/+FyjVtpRUZmQKXmip+XQCMRyyekmcIwCIvfR0=;
        b=dQ9utrXg0QPG/oXiW0OENPRtBxAV/rnT2tWo8xXqeDGvHX8iRPJkdC1L9tpuVsH4nD
         ndKjYpQc3tK/EOpmqT2EJxXhnvybVssBW4OMXsHH9/XMgBVIxUwHJNcvqEKLp2JSk5L1
         mD2OScYLE5N9od7JPTxnkgbGLvreL26ebvi0mVxyA4kV1gnIkth5j5LEbmMzl+KEP5Bh
         QuaT0546Zk9gV5lN4cnFv+OODVEWxh9azPUkFLX+NBXoJwFuOLQZQySENTv5/wzBZVzM
         0pV52KkQtmm/YxNDxi8J4WqOZifhxeFqJwYCh0KuCUpI03hXVClMQ3zdO36pUkcwOYXx
         NsLQ==
X-Gm-Message-State: AOJu0Yy2nrqeZ0XqTbbyARzpQEwxUR+yMkRfTuqcnga6lb5mzn59d7mO
	TtTBDRTwotbW6pbbP/efnujxyFu+NrupxW61/2hJz1nHzGnn6V8BsJ7t1tiKqriIPtUjzrj8ozt
	fQMvPa2ghsIVp3xqPfmSRJPhOlVeCMYLa4i+PGQ==
X-Google-Smtp-Source: AGHT+IF1QF/qVP8hWirLpqPTh4WqY/koXmDouYX7xW9tJ0uXH/T8LEu41dns0v8qPg9Pknhpq6nH2WDb4tKsn16RMsU=
X-Received: by 2002:a81:9a09:0:b0:604:18dd:881c with SMTP id
 r9-20020a819a09000000b0060418dd881cmr159836ywg.49.1706732655001; Wed, 31 Jan
 2024 12:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-22-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-22-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:24:04 +0100
Message-ID: <CACRpkdZfKRCNO2nVXzBGEuY2-sV=D1utfOaPD_OsjfnUhDSqnw@mail.gmail.com>
Subject: Re: [PATCH 21/22] gpio: remove the RW semaphore from the GPIO device
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
> With all accesses to gdev->chip being protected with SRCU, we can now
> remove the RW-semaphore specific to the character device which
> fullfilled the same role up to this point.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

