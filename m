Return-Path: <linux-kernel+bounces-103545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B99F87C0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B86C1C20F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02AF7350F;
	Thu, 14 Mar 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YRZ3ERwh"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6273196
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432352; cv=none; b=ti2/98uI4LwE6Xx8xsSrEtm759ZgzxCQoSJ1+uyaX6sXjVN92B8DRtfNUiHzL6ybNhQebB7q8MRP1Ic8GzU5//OePJP+JQs7J3fbxCIWjmGYFkMojNIA5nUGVKkm/G6kEveCH23VCv/wQga1DvwYJsKg4h3eELyHbTrKduTZnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432352; c=relaxed/simple;
	bh=ffDXoKBWQURZ1YqNHkbBDZZhwob9lLULOqQyYM8v64k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqfdRmMc2NvjySTn545OAlFPMruT4EHlc3PqYJ9pk4tXsodAi1XRcfe57LdA1T7jYU2Y9L0vTtG08nCBW18eE4Q6T7eTTIwwF/yIqV3Gt9hwcCw1cuAQZnwiX9sIJC8AsZxkFr4y7ARrqMFqwcd6yIWSA9Z25YR2k4T55Reip4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YRZ3ERwh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4832d7f44so2935121fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710432348; x=1711037148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffDXoKBWQURZ1YqNHkbBDZZhwob9lLULOqQyYM8v64k=;
        b=YRZ3ERwhBZzZY50paHZIJSPlOw30kTWZrLCLDDWO3ZCig7FoG3aLJPkR0s4abflecE
         R0OBR39tK5VvoEzg6JyOIGa3VdFfIYAZspq7pR3HsEuAvZ7xTIIjkJkBjzyfeJWysPh2
         Y46bnvJ4BqCVy8Rk1qVRapMbdQ0fPXV0DdOxP6GUKOyYfNaG1ZYIauTSAkdKHgnDg2MJ
         ghGDyFMxEamhRpUi7y1eoGfawi5FgucA6v4c1vaNxa7Y7C5F8njaDUx/IRH68/39ivUC
         TMLGgHvXBTbeZA5wA5GJTbZ9xt0Qlw4FJSbODCsR2Ww2yaGEEQg7/TCcV6y6XWVGTjJj
         Umrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432348; x=1711037148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffDXoKBWQURZ1YqNHkbBDZZhwob9lLULOqQyYM8v64k=;
        b=gpbDJFvPNVSE5JWFT6jBOeOS/O+6+foikxZRP9ovdeYWy2WA1WworCzDbJ0Il2TZ/F
         UEX8Qa0zeu39p7rTRYV0ItFnNbPP6K0U6C2Qps2AAnZeozWRXcSV5g78zfYbTF/NBd8j
         ThndyZCzBkMnB/R4nyu+CVB5Vtgpe3YBwYFVXkPRAxugIXDuTbZIvRKXvp0LJa/1cnBd
         zrSTVIk3pitfxpSlyeupbNd2pkfUnfvPNJp29oi0s7OCN8pYSntleviyBk20w4vVc6Pz
         yMVapt779Mhl32AWd/B3H9AU0j7ilfexmRYzyg71NVDMBfYaYJ+b1h9b/YqdtZidQ9Ij
         /bNw==
X-Forwarded-Encrypted: i=1; AJvYcCWxj6GpwtLYTIPKwvI1wfG84tID1uMK0o48vzTMeOgrvONS4kRTohmgNenPFZNHMwXgcGq8MwmfEp2IFCg14P8Rc/mu523c994NTUba
X-Gm-Message-State: AOJu0YyhH7M5E0PCU5zlxAvAZ0Nb2ACvS7KcgHesqF9TB05ckpgNciKB
	ozVi8IHi7eT716bLBXAPCS35c0uyVq6NxgTe7MICXMKaIaqv5c3j+e2T4ZXwO+AYEbeof6ZB/B7
	DSXa9tTlqMne04d026ioGSwkgWfg0RDzTivWBbw==
X-Google-Smtp-Source: AGHT+IEI+R9IwFNzp7XCIfN3Lxbmgb+bzqnuZPvIxGrbMiXAxsfqZXMDZP6WdFW+89spArIFyY6oxXuKf+JhVk8h9Xc=
X-Received: by 2002:a2e:b8d2:0:b0:2d4:375e:9e43 with SMTP id
 s18-20020a2eb8d2000000b002d4375e9e43mr1783013ljp.27.1710432348394; Thu, 14
 Mar 2024 09:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com>
 <20240313-mainline-ad7944-doc-v1-2-7860416726e4@baylibre.com>
 <20240314153049.5895703d@jic23-huawei> <CAMknhBFtN7haURhV-TN13kxtMm1otpAz8UMX7VT1xmxz70nPYg@mail.gmail.com>
 <20240314160143.2ee0cb02@jic23-huawei>
In-Reply-To: <20240314160143.2ee0cb02@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 14 Mar 2024 11:05:36 -0500
Message-ID: <CAMknhBGLk7z1OzXOMrj051BYtXyiOai_T5LB=cxCACH2k29aJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: iio: new docs for ad7944 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bah, I missed the reply-all on this one to, so for the record...

On Thu, Mar 14, 2024 at 11:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 14 Mar 2024 10:47:43 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On Thu, Mar 14, 2024 at 10:31=E2=80=AFAM Jonathan Cameron <jic23@kernel=
org> wrote:
> > >
> > > On Wed, 13 Mar 2024 15:21:52 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >
> > > > This adds a new page to document how to use the ad7944 ADC driver.
> > > >
> > > > Credit: the basic structure and some of the text is copied from the
> > > > adis16475 docs.
> > > >
> > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > >
> > > In many cases I don't think it's useful to have a per driver doc, but
> >
> > Having upstream docs for each driver is something that Analog Devices
> > has requested. So unless you object, we will be submitting more like
> > this, at least for new drivers.
>
> Keep them focused on the unique aspects and I'm fine with more docs.
> What I don't want to see is too much boilerplate that might rot.
>
> If a whole bunch look very similar see if the docs can be fused even if
> the drivers aren't due to different register interfaces etc (same
> as we do with DT bindings).
>
> >
> > > for this particular part the asci art diagrams make it useful - so th=
anks
> > > for putting this together.
> > >
> > > LGTM, but I'll let it sit on the list for others to take a look.
> > > Poke me if it looks like I've forgotten it (which I used to manage
> > > a lot, but patchwork keeps me organized better these days!)
> > >
> > > Jonathan
> > >
> > >
>

