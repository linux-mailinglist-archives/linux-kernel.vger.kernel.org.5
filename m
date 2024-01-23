Return-Path: <linux-kernel+bounces-34569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2584783812B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563A5B2B431
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4D13F008;
	Tue, 23 Jan 2024 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cnyg90WM"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168213EFFE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972017; cv=none; b=eHlpm2z1aHzWoL98BqO7t1gk4k3iVheEU6rjA2VtahWATh+hFhkBheaKepBSG8Zwqx5FeBz4X0tqslYuo3h+y/z2OEkB7YZ7pGHRiruxqQD4clPFPAZNl5vFx2sxX4fCRay6SD2fZE+6yrSOK2VsFuCxCoiKM1HvTjWCXCQTEvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972017; c=relaxed/simple;
	bh=ywRV5J5Nzq5u9UseuF5RgaNdI1b+Me/W43zM3dVnPQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsoGasLNjRFlQITYqbMOL9Hq77sFFpD/+d8ekiXQq9YWOpI5eHDUUGKbxeqlfY7Z8XulM1PHOpcY1+e4LAsANUxk5Zyg36oYx+BVB0Oh7WwT3esiAO1tufNQM5N2rYnHFhiC295310G99+pGLnGuPUU3S1ZOMXb3s/P1TDczznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cnyg90WM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e43e55b87so15565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705972013; x=1706576813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZk5WhKB+5XNkDgpDR6qQPJ9RduGx9EVoLu/fbH5djM=;
        b=Cnyg90WM31YH+N6SZ8qJHSS6wW3eYOXvSdaLeXy+KHpqPiPm76Ldn5ZRoFv5wOATDU
         ii28U3wVDlLAqPOtZJoxOXq9pcCIondZGS1rpDaBivSTvDTzIox1USIlBtL+M2lcfspM
         Yp3frwHmUlDakSZbhmS7oH4Y892W72le+2DwkS3nNig3C6quCSNkC+/0nATawK2RkilK
         M5bRUBdER/2q8q/dLjULrd0X0hngWccbPNWY0L/doyTUixdzrFxT6yCXbNFj1dn33RNM
         YnVJ9q5bDIN/7d4Os8lyZh/7gPASDwU9jqRMOwVjd2Eike5fTDkMZOVDa8ST9qqZY+1M
         JBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705972013; x=1706576813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZk5WhKB+5XNkDgpDR6qQPJ9RduGx9EVoLu/fbH5djM=;
        b=lhhp6EuR5hewRQLjqfOb8GRn95iyR2O37pmpAti0U0FQbXSumAAJsiJzlQu0AV+NGs
         ERBGmhPxTk7nLznbxmh2m5VXEMFNRRDGb0hF8XgUcF8SkFm1KQvJZ2MbndgyMjTrwAFh
         O6+2N6ct1zR41BU9zm0H/9BmRvMbZGMr4KAR5Cl+QDmDxrmwOf2L8x7HIFGJkWhY1PT+
         DhXvnmqxCJXEXlSVeoTRskMMED/aW1PO6gvn0RZ6gNZGgY1o4X9tMZyY2f32ke5dntLt
         Tpc2j3URcKgkhdr7kfjY1Yp78zIF789pC/WzwceJQcYNwouYtWl0qdCX/jFPO3KJFZGl
         MOZw==
X-Gm-Message-State: AOJu0YxZ9/rYUdUXUj2MUwN6i53eDSo/EB/Q8EL7+RdLeBLvjMQdHu9H
	ORHpVruYtC7QAxwXaGYY3pQR/IXeZI5FPImXPjIuXoc5KZReqR9CvIylg20Endi1nX0NbA3iQWg
	393Rs9E+u6x4/Wcaxx96PQ+g1klfn8JFO+6M=
X-Google-Smtp-Source: AGHT+IElL0l7ZlzCyVu6sV4TowvH4h8r0O04eb+NvMNmeHH+7QDZkuVEAlW8EbrBMPiwzqOcOoBeUWgdFl3Fn/WB43A=
X-Received: by 2002:a05:600c:4f4b:b0:40d:839b:7844 with SMTP id
 m11-20020a05600c4f4b00b0040d839b7844mr92588wmq.6.1705972013523; Mon, 22 Jan
 2024 17:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-75-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-75-keescook@chromium.org>
From: John Stultz <jstultz@google.com>
Date: Mon, 22 Jan 2024 17:06:41 -0800
Message-ID: <CANDhNCos=XQoHS1YHxpaw-cawJUiZyw-Z=6qZ1iZw3RFUxNN3w@mail.gmail.com>
Subject: Re: [PATCH 75/82] timekeeping: Refactor intentional wrap-around test
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 4:36=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
>         VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow()=
.
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f185365=
94 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/time/timekeeping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 266d02809dbb..2fc7cf16584c 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1984,7 +1984,7 @@ static __always_inline void timekeeping_apply_adjus=
tment(struct timekeeper *tk,
>          * Which simplifies to:
>          *      xtime_nsec -=3D offset
>          */
> -       if ((mult_adj > 0) && (tk->tkr_mono.mult + mult_adj < mult_adj)) =
{
> +       if ((mult_adj > 0) && (add_would_overflow(mult_adj, tk->tkr_mono.=
mult))) {
>                 /* NTP adjustment caused clocksource mult overflow */
>                 WARN_ON_ONCE(1);
>                 return;

Acked-by: John Stultz <jstultz@google.com>

