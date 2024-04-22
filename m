Return-Path: <linux-kernel+bounces-153127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7D08AC9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D934D1C213B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5513CF9A;
	Mon, 22 Apr 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LgZMHU1q"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632EF52F96
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779575; cv=none; b=VpyDCEUZb5V8+U7wkYKpV4OA1Pbgfdr+oNWttZvB4CVncix68n4hG4AB0s7RajZfmAA0Jb0S0XsIu0Sdgw+33B0IVVBn+dciZ/AMZ2+FcguZX06r1L66l5GXOPM0VdrPHft7SLuraN8zZClUOK+Z7W1iTfoc/e/HZgcO2phPerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779575; c=relaxed/simple;
	bh=V3oVGMNS8ISkwJivNvBbRJ47+PG7EGkNa1AOXFoJqY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nolah0M4fJp6AWsb8Ddqw6nEbOBQdo1HFKMzACL07bUD67Ug0l1S775v8Wk+cjXgYyDIatRS0WfiMwFZbiiuqO2YK9RLWUEfDJazyQL2B8j3qOwz0llQl473SnYMXomNLGOPwv+8yItpamggjyU5qWVjFIA4rTnrT96gA87+cLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LgZMHU1q; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78f02c96c52so301413285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713779573; x=1714384373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0DMas0mHpFh9kwXmaE0q1HSRk3O9Zpoon9fcRvKmbZg=;
        b=LgZMHU1qKt4CFlTBwIGmlrC5bLhh/iXkNzM4dc62z1CNiSK2ZzCetre+/ZYsfYyEe/
         DdQABy2mzIwvssWL3yukE3d1qZPlcKkKIFDXtcXt6aehVEGQ0Qmm4eSf1ckz9m1Av+Si
         dlwFMSuu9ElSbFijcmG6jiRTEiyivakYoO0cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713779573; x=1714384373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DMas0mHpFh9kwXmaE0q1HSRk3O9Zpoon9fcRvKmbZg=;
        b=YhH0gevo6t78rM0HqfzX/WiP+Shsn0dAasIi1aabp+x9Y1X/lEUCuU2LcBWoqoMC27
         N73xXVzU3Oy+Qeobs9lvfjF6PVo2/7OQ5QjRGndEAHdwM31uOHrGzxHHFtSz+ByLwGEL
         bkaKXfEpauUWEdh7fdZPVdQsYfwHr7hi09++VBdglASScUglCLkCBALkAVU47+YGCBrb
         k5r55woCXW7C9adgdxQr5bDkXDC710N39tnOahB8vYFhb/0/GxYrWN53delayOc6Y/Zu
         lpOi9ZcqagCYMYz1l8U9+0074cD5+HoFKMH8hnTYQkaNl/XAI34gBYYGE9GSNoXi/B82
         5xvw==
X-Forwarded-Encrypted: i=1; AJvYcCUhrJupXgJeHoe0Ai31QFm21DfuXBuvwsfC673XuqRTi/eAhguFNR8rtYbK0GfV1HSyIQNU3hLsEt4MfTDXep+C26pFxHDdr2vpLjSO
X-Gm-Message-State: AOJu0Yz1ZrGbfxzi7C3fGkvDpzHxECCmYYwtqe6A9R+RdMVBI2ckbsAl
	7rCoauuZvmTvG38eTiRqahBEssO4UIXGVMW2AiRzk0ta9bAymVy8IH098zVFI0rXQ0zDWBruGRl
	Ryw==
X-Google-Smtp-Source: AGHT+IGPusKqJJxcztwQN9UtsnTCEb7TaeD+IZty+CxNpZ8gLHbXu5etX8BeH8s7LQ4wVxeMIcwWkA==
X-Received: by 2002:a05:620a:470e:b0:790:7355:78e7 with SMTP id bs14-20020a05620a470e00b00790735578e7mr3231582qkb.50.1713779572807;
        Mon, 22 Apr 2024 02:52:52 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a20d200b0078eaf335331sm4130462qka.77.2024.04.22.02.52.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:52:52 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78f031a4442so312397385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:52:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXPJAwY0zqpcDfsb4y1D8dHra768ildGqA79Hc/XJyBzGYf2jW+aoB5Jmg3VKS3O1AcGzSs6RPweqc0I2s/vcBwuCWp8GfmF7NdiFv
X-Received: by 2002:ad4:4388:0:b0:6a0:7a81:4b97 with SMTP id
 s8-20020ad44388000000b006a07a814b97mr4195625qvr.16.1713779571701; Mon, 22 Apr
 2024 02:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e43980df-1ca5-459d-b037-788dd7d9085d@moroto.mountain>
In-Reply-To: <e43980df-1ca5-459d-b037-788dd7d9085d@moroto.mountain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 22 Apr 2024 17:52:36 +0800
X-Gmail-Original-Message-ID: <CANiDSCtjEPqEstuo92QeVK_rWkW9icsjKWakPyN19ETM+MJuuQ@mail.gmail.com>
Message-ID: <CANiDSCtjEPqEstuo92QeVK_rWkW9icsjKWakPyN19ETM+MJuuQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: stk1160: fix bounds checking in stk1160_copy_video()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <elezegarcia@gmail.com>, 
	Ghanshyam Agrawal <ghanshyam1898@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan

On Mon, 22 Apr 2024 at 17:32, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The subtract in this condition is reversed.  The ->length is the length
> of the buffer.  The ->bytesused is how many bytes we have copied thus
> far.  When the condition is reversed that means the result of the
> subtraction is always negative but since it's unsigned then the result
> is a very high positive value.  That means the overflow check is never
> true.
>
> Additionally, the ->bytesused doesn't actually work for this purpose
> because we're not writing to "buf->mem + buf->bytesused".  Instead, the
> math to calculate the destination where we are writing is a bit
> involved.  You calculate the number of full lines already written,
> multiply by two, skip a line if necessary so that we start on an odd
> numbered line, and add the offset into the line.
>
> To fix this buffer overflow, just take the actual destination where we
> are writing, if the offset is already out of bounds print an error and
> return.  Otherwise, write up to buf->length bytes.
>
> Fixes: 9cb2173e6ea8 ("[media] media: Add stk1160 new driver (easycap replacement)")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: My first patch just reversed the if statement but that wasn't the
> correct fix.
>
> Ghanshyam Agrawal sent a patch last year to ratelimit the output from
> this function because it was spamming dmesg.  This patch should
> hopefully fix the issue.  Let me know if there are still problems.
>
>  drivers/media/usb/stk1160/stk1160-video.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
> index 366f0e4a5dc0..e79c45db60ab 100644
> --- a/drivers/media/usb/stk1160/stk1160-video.c
> +++ b/drivers/media/usb/stk1160/stk1160-video.c
> @@ -99,7 +99,7 @@ void stk1160_buffer_done(struct stk1160 *dev)
>  static inline
>  void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
>  {
> -       int linesdone, lineoff, lencopy;
> +       int linesdone, lineoff, lencopy, offset;
>         int bytesperline = dev->width * 2;
>         struct stk1160_buffer *buf = dev->isoc_ctl.buf;
>         u8 *dst = buf->mem;
> @@ -139,8 +139,13 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
>          * Check if we have enough space left in the buffer.
>          * In that case, we force loop exit after copy.
>          */
> -       if (lencopy > buf->bytesused - buf->length) {
> -               lencopy = buf->bytesused - buf->length;
> +       offset = dst - (u8 *)buf->mem;
> +       if (offset > buf->length) {
Maybe you want offset >= buf->length.

And remember to add at the beginning of the function

if (!len)
 return 0;

And I would have done:
len -= 4;
src += 4;

In the caller function


> +               dev_warn_ratelimited(dev->dev, "out of bounds offset\n");
> +               return;
> +       }
> +       if (lencopy > buf->length - offset) {
> +               lencopy = buf->length - offset;
>                 remain = lencopy;
>         }
>
> @@ -182,8 +187,13 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
>                  * Check if we have enough space left in the buffer.
>                  * In that case, we force loop exit after copy.
>                  */
> -               if (lencopy > buf->bytesused - buf->length) {
> -                       lencopy = buf->bytesused - buf->length;
> +               offset = dst - (u8 *)buf->mem;
> +               if (offset > buf->length) {
ditto >=
> +                       dev_warn_ratelimited(dev->dev, "offset out of bounds\n");
> +                       return;
> +               }
> +               if (lencopy > buf->length - offset) {
> +                       lencopy = buf->length - offset;
>                         remain = lencopy;
>                 }
>
> --
> 2.43.0


Thanks!
-- 
Ricardo Ribalda

