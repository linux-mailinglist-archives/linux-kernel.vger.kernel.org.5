Return-Path: <linux-kernel+bounces-51458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC52D848B7E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB821C21734
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D717460;
	Sun,  4 Feb 2024 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GsuHNmSP"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF08BF3
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707028068; cv=none; b=K15g8NmM7eRxjO1MLVdjhpW7h1eFdq5BQUsMSAAk9/uGaIFkjqJ0YpwP3rKpIw+BpjkQB9D6UpZ6isA0za9L0XzowAQ2h8boPMV/de3pld4DEIpM/aHyNF5XmvZXOHyjnpLKpCnAZ45x9r3xRu19VwHQ7lYzSZS+VlFeq9YvnMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707028068; c=relaxed/simple;
	bh=5bxZ/rq8CMxzomMWyzPoqrgoI4wlBnejXrS2wHBkLlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rM1K5MaPcqehmODnRKI8Tg9GbALdS7QMxuTi07huSDHFqHFJ540tYBlNWbs1GiqeeKeSIPPOYsMSkVwJbX1k/JQuoYxvhn0pxPrvboPv0mkCGViZ0Q7hmnoyumhEYLPC0IBvbnBBiK8A5deUtGlsQJw3B/jsrzKEqHAtjTOiaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GsuHNmSP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so4356369a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 22:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707028064; x=1707632864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VnGKPEZoM3Z6DTfYOVg2LOet7iC0N95dYbHHaYKz37Y=;
        b=GsuHNmSPUwAWQdnZy9Rf1gn/UMzioLqvzV0p7L/6ChamDQ602kA8QQ7H+LN30H12HQ
         MTAztwIXeKdsJZHjS5mzM3rdnVsIXVFdHhnNzFksk6kpG+qu/Nw4d0J6SVjxVhXQcGBU
         5cPuJ9x5ck/vgMKSdgvd8iVlx/r1pi8jHkUEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707028064; x=1707632864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnGKPEZoM3Z6DTfYOVg2LOet7iC0N95dYbHHaYKz37Y=;
        b=XUcoRjiKGuY6wlvyXlO0LpD56IFc+aMJkNP/QZ+dINIqWpWTaegntHrVf0pFVqqauS
         RTbHZ5nUUDFegHIUNCcnLCdo2YZxUX1lo+uT7/cWzbsMEJty3F1CLXq4ytMTZmGgXmzB
         pzBjlYm/so9NMf9UtmnwFV9ciX8iXg5bxB+7svqf8c54c9nCPdRmjeOyiGnbFUwXHV7V
         ndsYx3VjpteuEJGyn4ur/laQrPhxYWU9HeP6GcYd2JXgjHQxsIRpYFDpHzblbY6R/0x/
         e8UhnF3GD2Mt5vWz12rmLMl0iQYWYxCaWGEnbBuTwoznvnT/b4FFm5BvSu/og7bFp26B
         kCVw==
X-Gm-Message-State: AOJu0YwUDj3eBl2g2AIzu157i3C1jZQp+YKFxYd8lTePszJlWUlCAGcJ
	8SPW0Np4mUYiyOpxFU1aiSiDf/4zb58PPrR/+cgk7n+rDNiMRkpbYcXmanrYukAbP3118whZL+H
	i1cE=
X-Google-Smtp-Source: AGHT+IFekoMxihFf5aoVuGHZMtctrlm/WJshD0PCujm2SIZPpgGq3eZO2rLY2CaDq8u3Tm7sspBqeA==
X-Received: by 2002:a17:906:28c9:b0:a2e:3a1a:e436 with SMTP id p9-20020a17090628c900b00a2e3a1ae436mr4220807ejd.64.1707028064485;
        Sat, 03 Feb 2024 22:27:44 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id pw8-20020a17090720a800b00a349d05c837sm2766051ejb.154.2024.02.03.22.27.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 22:27:43 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55fc8f91b79so3371871a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 22:27:43 -0800 (PST)
X-Received: by 2002:a05:6402:30b7:b0:560:5ace:2476 with SMTP id
 df23-20020a05640230b700b005605ace2476mr32827edb.35.1707028062869; Sat, 03 Feb
 2024 22:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
 <CAHk-=whJKZNZWsa-VNDKafS_VfY4a5dAjG-r8BZgWk_a-xSepw@mail.gmail.com>
 <CAK7LNARzZ07TX2obHSpCgsC=FPTbLx5J+kPBFUECT+N7V42i5g@mail.gmail.com>
 <CAHk-=wg+3J8L4C7dcsZZNPEr3CJ49wKtJC0taVDBwGo9ZGot+Q@mail.gmail.com>
 <CAK7LNAQwcm9XfYAgcxOmGp9tvzj8kNbq8VUX09ZKscG1KEgE0g@mail.gmail.com> <CAK7LNAQTbNv1C6sU2Z-gAofKZS=vPiGdV=V3Kd0iYFpR2qF4QA@mail.gmail.com>
In-Reply-To: <CAK7LNAQTbNv1C6sU2Z-gAofKZS=vPiGdV=V3Kd0iYFpR2qF4QA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2024 06:27:26 +0000
X-Gmail-Original-Message-ID: <CAHk-=whDYCFbd23C6KssR=OJnaaGJDs-aXCQEiNGwgWHqdzYhA@mail.gmail.com>
Message-ID: <CAHk-=whDYCFbd23C6KssR=OJnaaGJDs-aXCQEiNGwgWHqdzYhA@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild fixes for v6.8-rc3
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 00:00, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Is the second patch fine with you?

Yes.

> If so, will you pick it up, or do you want me
> to include it in the next pull request?

This is not critical enough to bypass the regular pull chain, so just
put it in your queue, and I'll get it with the next pull.

             Linus

