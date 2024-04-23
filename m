Return-Path: <linux-kernel+bounces-155611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04DD8AF4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07891C21D21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAED13D52C;
	Tue, 23 Apr 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2EjxUol1"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533C13D88A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891667; cv=none; b=hf2RqfYevfRZ1N+pro13SM5q2G8xN9vGJWquPYdgh3L8DYM1jsyQIqKiWTOCzL3X8pkGVw//RIFNmsOSr6t+9zjR5/TjUg560jbWgLejcjWTppfaZBMb/4ZrEliPrzvgkYDNl/hQfxDPbzKH5m64F0g8WndXG84oqM58PpMlXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891667; c=relaxed/simple;
	bh=aswP9hdxKwb+09GNXGRaPB0IEecRqGKQdL5a6+WxhGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo3TTGWpKLmExlgyPuA+kaGZHlvgtZ0udIlv5CZE9itzFPXkHrlwN8QZdKoyOkdjsdZnSAKJGA7+yHqCLBbGWZPbydTXjkDwSKLbwPqjP1mlmlppZlMlUfENYDma1B7ufXFkBR1hep8zPoy0p5BtQOsvunPihQBzTzkLJJe+Hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2EjxUol1; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7da939572b5so139750839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713891664; x=1714496464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLMRks9PdH+g104L81D287ju8A0NrozcbxbmvZl/Zoo=;
        b=2EjxUol1sf/a+UBLSAipJ30Dd/j+tsWIwtoBEMBjsNjmKVCCpZ/V59XqTWUOF1l2iF
         JcNE8xxtY46hamhC06kO168CU5bkn2RfehiPVmStYpAs1+mtWgFIXjtted0vcl3SHyo1
         /JxgdyVikMPwAnuBFqB8zFzM9yit0VnfSD4y8Vkyd3YAaZqsj26H4Y6cxAdAEkg/kYDP
         OdsqQP2dpeoegaOfs9hTWZ6BPXtSsfc/H689masPI3IuYufjp/3wvMyTXXat18cYkBe5
         xJ+74HmMMHXmmHYN/tnaSO+yIvw6CLmz82BWgkVtflJXg9Eo6Ca4BiiXkKgAA2P3nLm3
         n9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891664; x=1714496464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLMRks9PdH+g104L81D287ju8A0NrozcbxbmvZl/Zoo=;
        b=VOn06pQFh/loYvA7pitUDRjmEtI1tscCdIRMDoiVoei4K/zGntL0Nxr+ZcKwNtZvPE
         6cEtivvouDz5+Yuo+KUY4sZ2sk016Z+C+h/CKxs/BM7ciw1SJGTK2xzGjuspm3P66V1m
         XLrATLupTfW9cB+oD+0e12NE98tMsg5J+Zh8qATvMvwqSM0pK0EBsTbuUqRR/E9pUYa5
         lOd3D7TFY2vWqJzXftL7oVtc2ikKPR8TvA2fKCrrMjhXY9LknSc9sYEPOSq+tXXo5BYa
         uwU1qQXDM+u6lzCmnC1Lt8ElJXJ3nysg8i+EyW+4j4nrIdXXAAmEiaV+dyAYrvlPcBub
         xkJA==
X-Forwarded-Encrypted: i=1; AJvYcCWixHq37EkIIPUGzSSo3T7vGnGROg3Uy1bpxnvp9mthUmg9Vj1QeTjJKrMrB3MD0AQZdv2l4kiuiEOLVYZGcpn7ZyY8VzRYuEo9/TY7
X-Gm-Message-State: AOJu0YyzyNNccubg8ttVUP1ggITgxYDGRk3y+r5aOkWFhvvthC6lwC4K
	xkRSJucXSN4X1UliudkfF+8oylVawIjydDyAjf/zKbL4GVT7eiF/pzt9ZBBHxkWqFWjwl7K1FIv
	j3c1+YnkBc4RpevorYdJQxfSJY4mFlMQdrJdC
X-Google-Smtp-Source: AGHT+IGcw1mE7GQw0RFfG3rYNhp3N2M96TVgZiM44ui1PYuC2rOp0yhfUgHlgGhehZWYsoHgBqII2uXkVaAYJ4TGtYU=
X-Received: by 2002:a05:6602:6b12:b0:7d5:de78:1d8 with SMTP id
 ih18-20020a0566026b1200b007d5de7801d8mr21123669iob.18.1713891664253; Tue, 23
 Apr 2024 10:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221160215.484151-1-panikiel@google.com> <20240221160215.484151-8-panikiel@google.com>
 <09579b62-77fe-4ba4-b3a1-e3b17dff0188@linaro.org>
In-Reply-To: <09579b62-77fe-4ba4-b3a1-e3b17dff0188@linaro.org>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Tue, 23 Apr 2024 19:00:53 +0200
Message-ID: <CAM5zL5q7LJC8AmrtM7fH03zyvQug8k4WN4t2=Q-6jQBZAtYYEg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] media: dt-bindings: Add Chameleon v3 framebuffer
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, chromeos-krk-upstreaming@google.com, 
	ribalda@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, sorry for the long delay

On Mon, Feb 26, 2024 at 10:10=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/02/2024 17:02, Pawe=C5=82 Anikiel wrote:
> > The Chameleon v3 uses the framebuffer IP core to take the video signal
> > from different sources and directly write frames into memory.
> >
> > Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
>
> ...
>
> > +
> > +  reg:
> > +    items:
> > +      - description: core registers
> > +      - description: irq registers
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  google,legacy-format:
> > +    type: boolean
> > +    description: The incoming video stream is in 32-bit padded mode.
>
> Why is this a property of board DTS? Can't the input streams change
> depending on the usage? Who defines the incoming stream format?

The input streams are defined by this hardware module - there are
specific input lines for red, green, blue channels, h/v sync, etc.
However, there are two variants of this module which behave
differently - one has 60 input lines and outputs BGRX32, and the other
one has 192 input lines and outputs RGB24.

The "incoming 32-bit padded mode" referred to an internal bus inside
of the module, which I realize isn't very meaningful. Instead, I think
it would be better to have two compatibles, one for each variant of
the module.

