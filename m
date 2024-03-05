Return-Path: <linux-kernel+bounces-92835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F28C8726A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6A228104A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51519BA3;
	Tue,  5 Mar 2024 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpB3hvRy"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE331426F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663828; cv=none; b=lL7Ogq/M8V7UjiQ/rjkswoY7nSHuUdgPDZBvVGdawOGVN8hxNV1h7pB93jVApTk06bST1CgWf5BZtdnCrNmNOG3au16xOx1Mna2Y7frjpmfTcJjMfSXngW4SNy7dGDEFzk8W6/+lWEyyHqMZjoS8IGY9v02g9Wda8DQ2Bohkxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663828; c=relaxed/simple;
	bh=kcInFMDuwGJ0Axr0QM+HodbDvTjHxk7/GQsBaDqghoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBWXEC/aXGXS0NwI6iQFxMGl/3fpQbqWU8XNHgltCCdvTLqBbZleWKPoB7pJrFohYcc7+3uy3VGRzlkyDYsSpm1QWOzD2YcSf+3rU5TwHe0TiGKmbobQnkNGtQyZNO5rjW/EO+HuQDCrP16EDlLwVGqqJywftdWeDsO9l+m8pWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpB3hvRy; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so63509276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 10:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709663826; x=1710268626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoNrumIdDmxRFKTd8oqeNhVL7nHIUTBgQcYMEPSY5hU=;
        b=vpB3hvRyUyca9vy0xhEGaSET96qY0lWucndTm8Ry+UwlMqvJDBp6MEZ2wrH0Ti0EQC
         7mgLOe9f81pWuWByvLQrB6GE2s8CKvjvLFc/EwTVSrspe43jnmlsOT/5reg7pGNlxqWN
         pKdMmbdMZDOXW+aSfgznkhwz1+Fbb6/PYu6xH90mMgXa4/5mGpvMQGuQZcLP///fuSrR
         x7cR26/M04D60DiaGkBc7nt3kZduUn1YJTH+UEccsf+cs0dm2mNvUCBkPC5fmADJuGaF
         XZJwbpGs+KhbqXRTswwXDl8jsgQEX6f4Nl7HtdhtjngtIvZU4FmWbZrNMzfH1GGui1ax
         BACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663826; x=1710268626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoNrumIdDmxRFKTd8oqeNhVL7nHIUTBgQcYMEPSY5hU=;
        b=E10TaTisF1QKs9bNqqnBqLX86+7wNUviCTaqa/XjLmP8DVH+vP9+Ek8fAKBYfynBSR
         xCfQGF7GC5Qwir5DiVtaH6V3U5TvCUtyz7hF7Sfnc6AuthBy3dlyXN+hF/gtH+f7umUd
         /RV8DYxUiSvPKbWMvyhBVuvldE8NqtDskdyeW7Qt7hIsu24Wm4IwpOrVJr0sfsKbtgeH
         8Prx0tY9GV3+E76equ7M8x91++s2s7w5nXXuspU6Ng7IOjkKBw5LqmuCmoExhmRHwPut
         vqbuJiVha9HfrGMgXL5SaMBEWbmPgKfxR5pGH+vzvZqrRMDg3MK9jhcJufL+O6EuiXtb
         63Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWEKeqWlNC1IUmLBAZ6skbSQOJkr6jFPgG+Y+MdLelgsGJKFVldQ4mTPVWYkU5V1j3kTkYZ/asOc0sRW+JDpXEAiP3rEuf8G9Wokrht
X-Gm-Message-State: AOJu0YyGjoGK1edg9PeeHIBUfY8uY5ro+VARCIez7WFQ/XlKe+v4PfX1
	oU3WIZv4ZImNZ4G2lEWF/D1jtOFPlElZ1YCE7uphze8UXL/nm2odmzFXKttUJ66ki55ABAnQS9j
	f4GPdrfeGvM7Ot6Pv8hDAtC0t7pgOF0ynUAbl
X-Google-Smtp-Source: AGHT+IEoZFcKgWl/szXzeyOtASBiJA8GR+9pZvgd3lMN7BXMAj+p5AQ3HQCYYWPBUm119ytYheFglLY62BfeRkzUV08=
X-Received: by 2002:a25:870f:0:b0:dcf:9aeb:73af with SMTP id
 a15-20020a25870f000000b00dcf9aeb73afmr2705895ybl.2.1709663826235; Tue, 05 Mar
 2024 10:37:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305-class_cleanup-drm-v1-0-94f82740525a@marliere.net>
 <20240305-class_cleanup-drm-v1-4-94f82740525a@marliere.net>
 <CABdmKX0VGyBdTo8gzEocyz2HFcqEtu_31PYVjWzioBdCbnXW6w@mail.gmail.com> <gdkioaqffaoiocsybn22qwfpkgz6cujy5oklrdicgdcbatlsan@v7qjtak5jacn>
In-Reply-To: <gdkioaqffaoiocsybn22qwfpkgz6cujy5oklrdicgdcbatlsan@v7qjtak5jacn>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 5 Mar 2024 10:36:54 -0800
Message-ID: <CABdmKX0PKer3PF49ypH-8XBMT8rsm3xi3ia1iJB7DVHfFS5fxQ@mail.gmail.com>
Subject: Re: [PATCH RESEND drm-misc 4/4] dma-buf: heaps: make dma_heap_class constant
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:02=E2=80=AFAM Ricardo B. Marliere
<ricardo@marliere.net> wrote:
>
> On  5 Mar 09:07, T.J. Mercier wrote:
> >
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> >
> > Is this really a resend? I don't see anything on lore and I can't
> > recall seeing this patch in my inbox before.
>
> Hi T.J. thanks for reviewing!
>
> I'm sorry about that, I sent the series only to Greg before but I
> thought it had Cc'ed the lists as well. Then I realized it was sent
> publicly only once. Double mistake :(
>
> Best regards,
> -       Ricardo.

Cheers, glad I don't have to try to rework my email filters. :)

