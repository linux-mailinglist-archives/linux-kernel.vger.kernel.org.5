Return-Path: <linux-kernel+bounces-139651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB88A05D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865C1287B91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801264CEF;
	Thu, 11 Apr 2024 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEAGRLyW"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E9633FE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802382; cv=none; b=Y+7Ps41JpaV4Y4LGVhlqWzte94hm2uw0iNMLvg66aGMy23FUDjzB/vttyp/EzYCC4Netm8R/wUlrMHpmiINk3lP2DcOA7HoZaVs+NhxC1eZ8eNj7hcmnOM01iZaZffq9v5DWPhdNv/dWrmn9SNhV230U6uAS+ydUnlnX2TVRLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802382; c=relaxed/simple;
	bh=UXJSmZxNI75aHxqgtrGql6qZ0waGZlG3tYEnH0qUS7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE57bJcRh6DAQ8Q3ajJy+XjVyF0CZmVGl8BkcusaiPICJq43BxF/9smYy7FsKITZg3HhjSXi0Zbw28qZ0VSutaMhpUyhrMRj58Tnl4nMZ/y8a4gALYBNXTw1tbGFqWXrpAptQQEPH4VMqNYG6f6gZNuoKSdSFcmSgjd4aTU2vqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEAGRLyW; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43477091797so93931cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712802380; x=1713407180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXJSmZxNI75aHxqgtrGql6qZ0waGZlG3tYEnH0qUS7Q=;
        b=OEAGRLyWraUqmw93STYIsFYWNKvqu0EqRRtw8GfQQNfllTju2Wxqpxttv9CCrJ4tS9
         KOGdbI/SuAe/W2oAv0JwOqCc7NC0EJMGsOiTYGasSodAtgfAzofDhpODKRI0SsU5kpAv
         rD1ioUalP4Sd7gJt1s/Rj774wDZyGkm8G4sjdb+XiElTGxwskGAWZj5aStWN4db26zKh
         tGlfXjuSNDZETs+Ov0onK76ibHWmIKq7wuoFHzhz+rK80QW7D6B20+ql7yHb5YQdoO6q
         MmkuepzQygnaoHGwxQbLT22ARJglurln3lUXvG3rQLoNfkouNZd5goOOK4LAmAQILkkd
         yvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712802380; x=1713407180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXJSmZxNI75aHxqgtrGql6qZ0waGZlG3tYEnH0qUS7Q=;
        b=cZXe8VTtLIoBx2bJtwk0u2IJa8eHjmqFcq0nV+DI9nwM9URIgQTftD7mAla59bRA9q
         MADPgd+JYiIm8mXBeR6lnjvfqP49A3VSyZEVX9yPtXaaQhTCeWEBxSVQf5BQhgI+tOux
         VYaZQPMi597QN9tImPoFDER9cVSiHIMUHGSDODzV/vmyDA+ON0Rc4hy3WaRG+6XZn/R/
         toHmj4y9e+znm2OM+3hMSyuSDYyx5Ar/FO1c3k0cZPSFOm8JTN1ox3BdEmF/vz3YiI4V
         eLick+YNL+EW9+DnwmiDXyqofAsHvrVH3E81evk7Ve5oVfcpw9wvHTytikKLfcnJJ8Xu
         t7yA==
X-Forwarded-Encrypted: i=1; AJvYcCVTGGh2I9+hlyM3cz0mi9TGG+eS2llH6gaEnP0FYw+N5OW4rKgzQ6wNjHlVUspNo9i23EmuG/HYhxEnP3l4wAp20D356vCaWJ9gkQnE
X-Gm-Message-State: AOJu0Yw6nnknmLi9fLrkYVcj6Z1lBDTvko7t1lQFaPcX5WcXlt1jhdYI
	XfbxUArPPcYogLg+xasoM+zryAVE30OIRxwTLenK2GoDhVfHUyNOwgyNwZZlj69UItJ2Nt+iUHy
	kfe/Ls1a4AgRYHjgJIkXqAWfz8A/FXe/7gx9J
X-Google-Smtp-Source: AGHT+IFPg5vORmoeTvYI/uTQ7j/zK/tZPyZEFI/0EvsxjhZAYdby9Des1k8yuS9qmNN9z2fJqX/gxMcyeTA58eMTClQ=
X-Received: by 2002:a05:622a:4c8d:b0:434:ec62:970c with SMTP id
 ez13-20020a05622a4c8d00b00434ec62970cmr131218qtb.12.1712802379873; Wed, 10
 Apr 2024 19:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410182618.169042-2-noah@noahloomans.com> <CABXOdTe02ALsv6sghnhWMkn7-7kidXhjvWzpDn7dGh4zKEkO8g@mail.gmail.com>
 <D0GS8UL1WKI5.1PLEUUWOD7B8@noahloomans.com> <ZhdIc3vt3DFvT066@google.com>
In-Reply-To: <ZhdIc3vt3DFvT066@google.com>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 10 Apr 2024 19:26:07 -0700
Message-ID: <CABXOdTetbKE_VWQsK4K6PB4Lm456BO7FfWyHtBBMhP77+QhzPw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_uart: properly fix race condition
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Noah Loomans <noah@noahloomans.com>, Bhanu Prakash Maiya <bhanumaiya@chromium.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Robert Zieba <robertzieba@google.com>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 7:18=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Thu, Apr 11, 2024 at 12:06:33AM +0200, Noah Loomans wrote:
> > On 2024-04-10 at 21:48 UTC+02, Guenter Roeck wrote:
> > > On Wed, Apr 10, 2024 at 11:29=E2=80=AFAM Noah Loomans <noah@noahlooma=
ns.com> wrote:
> > > > This is my first time contributing to Linux, I hope this is a good
> > > > patch. Feedback on how to improve is welcome!
> > >
> > > The commit message is a bit long, but the patch itself looks good to =
me.
> >
> > Hmm yeah it's a bit on a long side. I'm not sure what could be removed
> > though, it all seems relevant for understanding the bug and the fix.
>
> Applied with shortening the message slightly.

We might also consider applying the patch to all ChromeOS branches
directly (not waiting for upstream); we do see a number of crashes
because of it.

Guenter

