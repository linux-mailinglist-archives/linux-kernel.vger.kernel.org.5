Return-Path: <linux-kernel+bounces-154210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF30F8AD956
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E162879C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ABD46435;
	Mon, 22 Apr 2024 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VeZc0T32"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109144597A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829930; cv=none; b=tHnHRKSQdrvSncg8recuxY0f3JBO41UF8v0X/2YHha64ndBuQv9cq3PY1BxKg4txvsnqJ1LniIcNarKF14cQPiHIePFU6PuFkTeQLd4CKLY2smr20/gYnXdpjXPIV/HR0CGoNf573IcCRJqglK6yvQVlzUoWYiOdDwUnAG7RBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829930; c=relaxed/simple;
	bh=4r98zwDgiy1YfXNKtIkT0ExLUuEswdA2nBvFO8XbVmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMsm6aIvpksg6Gwi/Xz/vnU82vem+2+BOuy1dWNzwM1YFES/EeFpgZ+IwS1wEKRerPaW4MLHRqPUb+4dY0zbAwh/eXf1Xn609vxB50EOJaKtCSJoiDhZBxm7SkXpx+SGL48C5lg+Glw/9cXCLkBrPZhQmtMsJcOGxmq5aR5tzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VeZc0T32; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78f05afc8d6so347497485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829926; x=1714434726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFMZDFCKqtRsg+Es89BVufKPl3Pj2valoSZO9ZIhMr8=;
        b=VeZc0T32WzEUv4/+biDjr0w/2Cbn0OdVnZo3bZVW9GoJDPfIUJgI2cMogIQZdmIIip
         ZOFTPdMhPLLvN+vYVcUB3FtNba/KZI6ulVTcJQVH+mECP7PVx5kH00blshuymQbA+8SJ
         uN9cn6wA1GZxP2s9sgwUKATDkMNOSsYTkoEug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829926; x=1714434726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFMZDFCKqtRsg+Es89BVufKPl3Pj2valoSZO9ZIhMr8=;
        b=ABbdIvjloC8Mli4olXwyX8R0wU0x5zl9stCwnQuFyosQOs+VQ9nPiaiCicu/BJFlOx
         t5nCi8eJBNjJebRcoqO0bxdWCcBHb6zrHtHmMOjPuXD7HQIlQ/CZYJPhKZfhLvaDVrg/
         +f1Hgsy+qft4NrdtTx0/wSl1RtbyPceab5eadXC5zIYDElAIeMSHJj4eQEe40weYBk4D
         ILEdyov8yKhsThLUnjvatieryKG80y1Ts7bN3cuHNB2QY5nssuHgz+oprnb1rRBuMN/S
         cymd2TPHuyzVIN+5BJRrHwziYxXrN8jxnAJI+uGqxdVtka1hC2hOyeXcHj+crovojqJS
         5hxg==
X-Forwarded-Encrypted: i=1; AJvYcCU4kGtL4J8iHSz8ADP5iHnjRSAnHd54A+1aIjIeRZf7jY70xuOXvF7LCYLAOn8QU9J147nlFBI+jGlZ1Eq0zjMa/W1BIo9s35wVQyJ6
X-Gm-Message-State: AOJu0Yy+sweFTVZ8sBez6ucb5u+XK/T1rFVHuq1gcdJE6ubI6RiSLWJ2
	YhBKjE7gqrfs35tn3INhbVpOpHVi01Z6kvAq569Yl8+bTOIrCbmrc8snGoxfBPZWXOhJw6dqoqg
	2ZGCv
X-Google-Smtp-Source: AGHT+IGgRySu8OAdpsI+BH1RFH+SrXh73PLdHFwlhfwm1UOrX09Y/KLMO+7qNnVORIIQZ8X+Vlglhg==
X-Received: by 2002:a05:620a:166f:b0:78f:1583:fde8 with SMTP id d15-20020a05620a166f00b0078f1583fde8mr11333630qko.62.1713829925949;
        Mon, 22 Apr 2024 16:52:05 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id s28-20020a05620a031c00b0078d61d4c810sm4767478qkm.0.2024.04.22.16.52.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:05 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-434ffc2b520so79101cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6xqWWPIwD+AWoDQAF2KQxLpXiX5fMqVPqRKRsz9co/lKCsDOXRxVaMwHAzrqc7JiT5nroAU5IFJxA/Kj9ECZsssVdZENSp155DCT+
X-Received: by 2002:a05:622a:50a7:b0:439:a613:c4fa with SMTP id
 fp39-20020a05622a50a700b00439a613c4famr129884qtb.18.1713829924524; Mon, 22
 Apr 2024 16:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-1-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-1-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:51:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VrOSN8VFaRwH-k4wCLm6Xb=zJyozJac+ijzhDvH8BYxA@mail.gmail.com>
Message-ID: <CAD=FV=VrOSN8VFaRwH-k4wCLm6Xb=zJyozJac+ijzhDvH8BYxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] kdb: Fix buffer overflow during tab-complete
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:37=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently, when the user attempts symbol completion with the Tab key, kdb
> will use strncpy() to insert the completed symbol into the command buffer=
.
> Unfortunately it passes the size of the source buffer rather than the
> destination to strncpy() with predictably horrible results. Most obviousl=
y
> if the command buffer is already full but cp, the cursor position, is in
> the middle of the buffer, then we will write past the end of the supplied
> buffer.
>
> Fix this by replacing the dubious strncpy() calls with memmove()/memcpy()
> calls plus explicit boundary checks to make sure we have enough space
> before we start moving characters around.
>
> Reported-by: Justin Stitt <justinstitt@google.com>
> Closes: https://lore.kernel.org/all/CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+Lqv=
C8deA8GziUJLpw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Boy, this function (and especially the tab handling) is hard to read.
I spent a bit of time trying to grok it and, as far as I can tell,
your patch makes things better and I don't see any bugs.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

