Return-Path: <linux-kernel+bounces-40462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49283E0DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158F61F22E14
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E021DFD2;
	Fri, 26 Jan 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GTL+ze/c"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC1200D8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291262; cv=none; b=mGMws7QXN41p3RmOCWpXvDrenlt2L1iXvSh8AdREo813jHm2V9O/CaSJfNLOynI4c83yr7BjW7InFf1w1I0DP8JVJbMLGWhErAqmk/WQjuAMA9CmBr3vErB5AWfg60TMio3HHyB++y44SEi08eIhEPvedZGIdbaRTj7je04bdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291262; c=relaxed/simple;
	bh=mo0Zb5IxAaVSxuH7aZv0jdRMwxfn5IPdm6aKawjw1MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fL/TTiJ4PVEiBkD7OobGLnojbNYSKEnXUfCmGj05EzCJfP+kzeR3tHyP1P8X33r0zmTl7FwSfReH0irMUdqfw3osiuqSW09h8hh0svJTQq8ORO43UHaEQlmYvSkh52SF6PLSOnLdvlwT1kmo/B2XHbfBKJzG8PEPWIFNw0Dfp+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GTL+ze/c; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a30359b97a8so78853366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706291258; x=1706896058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HynQcdHHZlfZlhzBvDS92YNUyRkwcuZt7YudJij5RKQ=;
        b=GTL+ze/cV6CjcTPrY7mXuSajFn1JI27sxp/ZfHmW9cABhTLFo3fW2yTo5XsgMoX8oe
         EltO3malrblZwVFnYsRvrAH8VIp0m3r4dnVt//k7sHWr0RhvY8b+SmejxyU589CDQPRm
         hmT36mfpMPI9KAfiyBReaBTvxV9ZOC1O+lwPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706291258; x=1706896058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HynQcdHHZlfZlhzBvDS92YNUyRkwcuZt7YudJij5RKQ=;
        b=T3K8X3bFMrzK7nLhXUqLHZvky1vedFvgGp5oj7nRRn7X6/2fbfrZXpWLHRr4KafGS2
         aEe7e270STb0/tXmKrihwuZkkTbrNS54sdnmmJzcojeoBqqOSPMK1beRp7GrTOrtCcA9
         72JQlPFkIfh9Om7H0O8n2hfbZiTp5e7n8BXUK3WWRSluMd9s0Z7HFT0waqE3WaTpodLb
         lM/ozT9JoGGOqhTzZr7MPDvBFop72+BzRsAUs+haZES58Yk0ySa0cEU3Xxd7NrZPpR7A
         XS7s+xI55suKFfZiioQ504LSS4ZA0xBhsUWplqh2MIuZ0gvVICqRdCp5KXD3F/FHljdV
         qS0g==
X-Gm-Message-State: AOJu0Yyw8noLUavOK+X6cZguNME6BlQZ41QYE2jCn/LPMC49Em82g5Gs
	UQmT81nG3x25JXEfnTfar6s3uYl1EKkHt82SMvxYfqBK0LdBb6RmcSrT+X5U8wj7mjNHIEtD4Vv
	0RbTp
X-Google-Smtp-Source: AGHT+IG6CL+uVIEh0o2/107eULQjVEmnWdsCE7Yk8LtQ7Vgqw9L1SJrUWq6i7yvKlsC3lB1IanfYUg==
X-Received: by 2002:a17:906:140a:b0:a30:474a:916e with SMTP id p10-20020a170906140a00b00a30474a916emr5503ejc.7.1706291258480;
        Fri, 26 Jan 2024 09:47:38 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id se27-20020a170906ce5b00b00a349318ea10sm854288ejb.199.2024.01.26.09.47.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 09:47:37 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e43e55b87so1025e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:47:37 -0800 (PST)
X-Received: by 2002:a05:600c:510f:b0:40d:87df:92ca with SMTP id
 o15-20020a05600c510f00b0040d87df92camr164431wms.3.1706291257547; Fri, 26 Jan
 2024 09:47:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126170901.893-1-johan+linaro@kernel.org>
In-Reply-To: <20240126170901.893-1-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Jan 2024 09:47:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UzGcneoL1d-DDXVugAeq2+YLCKrq8-5B7TfVAAKgF=SQ@mail.gmail.com>
Message-ID: <CAD=FV=UzGcneoL1d-DDXVugAeq2+YLCKrq8-5B7TfVAAKgF=SQ@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid-of: fix NULL-deref on failed power up
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 26, 2024 at 9:10=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> A while back the I2C HID implementation was split in an ACPI and OF
> part, but the new OF driver never initialises the client pointer which
> is dereferenced on power-up failures.
>
> Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separat=
e modules")
> Cc: stable@vger.kernel.org      # 5.12
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-h=
id-of.c
> index c4e1fa0273c8..8be4d576da77 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of.c
> @@ -87,6 +87,7 @@ static int i2c_hid_of_probe(struct i2c_client *client)
>         if (!ihid_of)
>                 return -ENOMEM;
>
> +       ihid_of->client =3D client;

Good catch and thanks for the fix. FWIW, I'd be OK w/

Reviewed-by: Douglas Anderson <dianders@chromium.org>

That being said, I'd be even happier if you simply removed the
"client" from the structure and removed the error printout.
regulator_bulk_enable() already prints error messages when a failure
happens and thus the error printout is redundant and wastes space.

-Doug

