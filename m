Return-Path: <linux-kernel+bounces-42620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3E8403E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CEAFB242C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9C95BAF0;
	Mon, 29 Jan 2024 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHP9hrLy"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90055BACE;
	Mon, 29 Jan 2024 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527978; cv=none; b=PN902v2M6BwUnPOwql4alyumCT+sskgGZfdxQjDoa2vgjU3qvrltKlyonzbSHFIEs+zKhFVlxWYlxD5GmZ60f2xbD79CzuQ6DckDF9YEjHmEKcFjdZ6vxZca4jlYJZ/JEoX22hydJn8wjeP0gz0KPiT38sGFlXil2sDKSgkUmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527978; c=relaxed/simple;
	bh=YLKY955A/JuBqyPvFG1peKrngqXsksFgeD47JoB4+D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e92z9kc083OWPoCwnsLE6WC1GAv15MJjo/blcHxIII2rBQZOo9PBeZM/TONs6tOtVDYmC+4IGscf/uw0EaDM5BlxL4mIxd94UxiI6J3iiqOAcqRls0coH0PPkGac8fksfAISjwp93SdOUp3wOTDPC0HaPP2eZX6pq1dGNQ7kpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHP9hrLy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2906855ac5fso971708a91.3;
        Mon, 29 Jan 2024 03:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706527977; x=1707132777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrTzG2cu5Mo+HGm+c3GWSYVcYaCNljzOyJtpe55pkLs=;
        b=CHP9hrLyPoFthzHrdEYcsfaeWaBTgCjY0FBWvq0A874C4YMTWo8y7uYmIEwLBLTxLu
         Ebln3sJAgKifelZt+65U9xIX7sQ2WUQer3muRKBai5fnEV42pX5xDn3IAg75DTiqcEa4
         mjNK9GlS0BqLcntnB+9wFDe+Y6UaztATuL1E0Ikpe8osoGLGJnYw+BU2XNqKoIqeWFEy
         8N7SnhZvaMHJYg9PWUS8MbPdom7LTt4QNNZpCKsYB/2quRYYDHfhe3rqH4wyZiSPA0cw
         ip/k7gfxsvChbqAiK+efr7cwuE7JeYb0mKuoEAOh40lhWRRFnUKp5x0ETCGIqWPI92EP
         yPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706527977; x=1707132777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrTzG2cu5Mo+HGm+c3GWSYVcYaCNljzOyJtpe55pkLs=;
        b=fDmrfo9ur4jE3NmAE97/zV40jh8xHPOKDXUqU4olPBk8TaV1Z7ENEARJbGFlagyy7k
         nN4TeO5CCzg0aRb2bKPu3CBXZnBMxwGhSidd1FsSCLnZuqCUs8YDwLOAEgHP8qlZNszc
         L7iA+ZFAUYrthgkwGfCk4j4R+avH1t77dbK2tv1d2/OafpiT0BGhZ/+k+TuN/6SJ6p5j
         ged48c3iKjaVwaXWGYsmwifJrJb6Bo2QqCfmo+5ITa5La8oDndFkg9ejjnJ8PQFVgbj7
         /E8OfOWE9OlrBNzqeQ5UhUUQ57i7Gk61RoOZo9F70SPP2x1spPqL6vA4U0+rI4lXJt7m
         nkOw==
X-Gm-Message-State: AOJu0Yw4aMNZlQXI7T0HvkidTWC/R2gtY76uQR7t+9ATqy+W5e/kkHWT
	aelyhh4onaKS+DFKDyYIuFIzzybOlpXLbRQbsz+JRL1YJ6eM+GAUaWwQ/0lJWf3RP6T8doX7LN5
	ANmPVt390BQhiAibH0Y/0Xc82CP4=
X-Google-Smtp-Source: AGHT+IFr2oy7BJyHbKMib1KtaErds19XGCNIqMxdLPAnCLqySfbqz2X9H9mkY0mJD32A4PYbOiyCjAC78p3+KcZWVzs=
X-Received: by 2002:a17:90b:24b:b0:290:92f5:69b8 with SMTP id
 fz11-20020a17090b024b00b0029092f569b8mr1646150pjb.10.1706527976702; Mon, 29
 Jan 2024 03:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116073421.395547-1-singh.amitesh@gmail.com> <20240125133007.GJ74950@google.com>
In-Reply-To: <20240125133007.GJ74950@google.com>
From: Amitesh Singh <singh.amitesh@gmail.com>
Date: Mon, 29 Jan 2024 17:02:18 +0530
Message-ID: <CABKcAmUOcOLq8=9Nhcf2phoDH9AU_zp+PNuUz2wJwOK2pHVtrw@mail.gmail.com>
Subject: Re: [PATCH] leds/pca963x: implement power management
To: Lee Jones <lee@kernel.org>
Cc: pavel@ucw.cz, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 7:00=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 16 Jan 2024, Amitesh Singh wrote:
>
> > This implements power management in upstream driver
> > for pca9633 which enables device sleep and resume
> > on system-wide sleep/hibernation
> >
> > Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
> > ---
> >  drivers/leds/leds-pca963x.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
>
> Same review comments as before.
>

Thanks for reviewing it. I've updated the patch and sent it with v2 in
the subject line.

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

